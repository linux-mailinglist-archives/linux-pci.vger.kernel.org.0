Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4C9A0BF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392630AbfHVUGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 16:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbfHVUGE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 16:06:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE06923402;
        Thu, 22 Aug 2019 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566504363;
        bh=wnzWCTX3n1Kd3FzpTcGUaCEZFXaVUTDLNV9GdS+XwYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+H0HWdglpI3rlytE8qsK5lNIN6PHf7qEkYXLl/bQGlqtXVXHUdZAnJQKf3BSlZRB
         8MK/zEh7+z0vK06sH5sc99Oj4NSwtB0KsTbX7ci2E2FC/8CaEazgQE8uWEr/aMiMKY
         HrG+H2oa6x1YY21eNHBcM22BY/e7aCvtgT0WBMjw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/3] PCI / PM: Decode D3cold power state correctly
Date:   Thu, 22 Aug 2019 15:05:50 -0500
Message-Id: <20190822200551.129039-3-helgaas@kernel.org>
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

Use pci_power_name() to print pci_power_t correctly.  This changes:

  "state 0" or "D0"   to   "D0"
  "state 1" or "D1"   to   "D1"
  "state 2" or "D2"   to   "D2"
  "state 3" or "D3"   to   "D3hot"
  "state 4" or "D4"   to   "D3cold"

Changes dmesg logging only, no other functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfc739dc6ada..5f0a3145c3f2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -834,14 +834,16 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EINVAL;
 
 	/*
-	 * Validate current state:
-	 * Can enter D0 from any state, but if we can only go deeper
-	 * to sleep if we're already in a low power state
+	 * Validate transition: We can enter D0 from any state, but if
+	 * we're already in a low-power state, we can only go deeper.  E.g.,
+	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
+	 * we'd have to go from D3 to D0, then to D1.
 	 */
 	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
 	    && dev->current_state > state) {
-		pci_err(dev, "invalid power transition (from state %d to %d)\n",
-			dev->current_state, state);
+		pci_err(dev, "invalid power transition (from %s to %s)\n",
+			pci_power_name(dev->current_state),
+			pci_power_name(state));
 		return -EINVAL;
 	}
 
@@ -891,8 +893,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	if (dev->current_state != state && printk_ratelimit())
-		pci_info(dev, "Refused to change power state, currently in D%d\n",
-			 dev->current_state);
+		pci_info(dev, "refused to change power state (currently %s)\n",
+			 pci_power_name(dev->current_state));
 
 	/*
 	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-- 
2.23.0.187.g17f5b7556c-goog

