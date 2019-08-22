Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F89A0C5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392692AbfHVUGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 16:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391403AbfHVUGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 16:06:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6755923400;
        Thu, 22 Aug 2019 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566504364;
        bh=J14VXb0caWumpGuohanF1qPvm/fay5bHrIMzl2VCG38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkApFLZi4o5SbU/V+XIDUy7PRsQ9xRoRsBEfiUBcE96ORHqJIS0uYJGG7kmUyP6zX
         Co+2lOs8XAiRRtxXHEFyVvnJR6jJeftDaS9ZiZAQsMBZNA9Cq/AoheqDSAlTnpEqPy
         PK72LI3TvCzn6LP4FasMZckmnnGveGQZGolZXN/E=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI / PM: Return error when changing power state from D3cold
Date:   Thu, 22 Aug 2019 15:05:51 -0500
Message-Id: <20190822200551.129039-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190822200551.129039-1-helgaas@kernel.org>
References: <20190822200551.129039-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_raw_set_power_state() uses the Power Management capability to change a
device's power state.  The capability is in config space, which is
accessible in D0, D1, D2, and D3hot, but not in D3cold.

If we call pci_raw_set_power_state() on a device that's in D3cold, config
reads fail and return ~0 data, which we erroneously interpreted as "the
device is in D3hot", leading to messages like this:

  pcieport 0000:03:00.0: Refused to change power state, currently in D3

The PCI_PM_CTRL has several RsvdP fields, so ~0 is never a valid register
value.  Notice if we get that data, print a more informative message, and
return an error.

Changing the power state of a device from D3cold must be done by a platform
power management method or some other non-config space mechanism.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5f0a3145c3f2..41112af189a8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -853,6 +853,12 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
+		pci_err(dev, "can't access config space to change power state from %s to %s\n",
+			pci_power_name(dev->current_state),
+			pci_power_name(state));
+		return -EIO;
+	}
 
 	/*
 	 * If we're (effectively) in D3, force entire word to 0.
@@ -893,8 +899,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	if (dev->current_state != state && printk_ratelimit())
-		pci_info(dev, "refused to change power state (currently %s)\n",
-			 pci_power_name(dev->current_state));
+		pci_info(dev, "refused to change power state from %s to %s\n",
+			 pci_power_name(dev->current_state),
+			 pci_power_name(state));
 
 	/*
 	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-- 
2.23.0.187.g17f5b7556c-goog

