Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA25C82662
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfHEUwd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 16:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbfHEUwc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 16:52:32 -0400
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8779216B7;
        Mon,  5 Aug 2019 20:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565038352;
        bh=IOBQeBrjuJWC+xvDlUUCjyNQJ22b8xmF5sL15aFS4Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiHVRhFYnLOi2Bk2+3BKrMmmToRYVL6mc9VkXKFU7+DA8ZZ+o2GEuNoGUO+tK7dG9
         NUnkGH14ev6E2SzPDu/cEZmpLoDBiDyfGMVSkT8eoRpDoYiLHrGG75vp5qUYjsG8nV
         6+zSbxGYDMGhsprHTGCLXk1zq1FU4nihhIho42XQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/5] PCI / PM: Return error when changing power state from D3cold
Date:   Mon,  5 Aug 2019 15:52:11 -0500
Message-Id: <20190805205214.194981-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805205214.194981-1-helgaas@kernel.org>
References: <20190805205214.194981-1-helgaas@kernel.org>
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
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfc739dc6ada..984171d40858 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -851,6 +851,11 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
+		pci_err(dev, "device not responding; can't change to power state D%d\n",
+			state);
+		return -EIO;
+	}
 
 	/*
 	 * If we're (effectively) in D3, force entire word to 0.
-- 
2.22.0.770.g0f2c4a37fd-goog

