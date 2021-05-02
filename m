Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BF370CAE
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhEBOHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 10:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233126AbhEBOG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 10:06:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2CF261408;
        Sun,  2 May 2021 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619964328;
        bh=X+U3jmsc3JchLrx7Po9Va7Mgwqc+hK41B8X1jL8ccyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJEouYy3/fv90DohFxi8e5YBW0O8i9UoabYmtsMabxppPw2dJ8ISc8/yD+H4kDqC1
         JKyj1ag+imkU0mzHi2R9QDFcldAaykRdTIROHL8jbhOzIY1UG8XFe19vHxDtXH57Fn
         0fnC1/j1N5BDxLCWd5gHJziR5HzpH3Sg8IWard+4mYST2Vmx9z5T1pfmJKwMSlQb+f
         UGZxZR1BvWJtEgpj8eDvpRMg54uXWvI6r1c18CMAo4gr8sTtbk9BCN7ZxcAU+nonhN
         br7MyUKyHsPWd2/rrawgIt7rOG3k7KDplnvH6nJFrPTHhdZnk1NI9VYc1bA4EVJj0x
         yzKAwnpgTKVRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/21] PCI: PM: Do not read power state in pci_enable_device_flags()
Date:   Sun,  2 May 2021 10:05:04 -0400
Message-Id: <20210502140517.2719912-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210502140517.2719912-1-sashal@kernel.org>
References: <20210502140517.2719912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 4514d991d99211f225d83b7e640285f29f0755d0 ]

It should not be necessary to update the current_state field of
struct pci_dev in pci_enable_device_flags() before calling
do_pci_enable_device() for the device, because none of the
code between that point and the pci_set_power_state() call in
do_pci_enable_device() invoked later depends on it.

Moreover, doing that is actively harmful in some cases.  For example,
if the given PCI device depends on an ACPI power resource whose _STA
method initially returns 0 ("off"), but the config space of the PCI
device is accessible and the power state retrieved from the
PCI_PM_CTRL register is D0, the current_state field in the struct
pci_dev representing that device will get out of sync with the
power.state of its ACPI companion object and that will lead to
power management issues going forward.

To avoid such issues it is better to leave the current_state value
as is until it is changed to PCI_D0 by do_pci_enable_device() as
appropriate.  However, the power state of the device is not changed
to PCI_D0 if it is already enabled when pci_enable_device_flags()
gets called for it, so update its current_state in that case, but
use pci_update_current_state() covering platform PM too for that.

Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ebf32de8575..3d59bbe4a5d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1585,20 +1585,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	int err;
 	int i, bars = 0;
 
-	/*
-	 * Power state could be unknown at this point, either due to a fresh
-	 * boot or a device removal call.  So get the current power state
-	 * so that things like MSI message writing will behave as expected
-	 * (e.g. if the device really is in D0 at enable time).
-	 */
-	if (dev->pm_cap) {
-		u16 pmcsr;
-		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
-	}
-
-	if (atomic_inc_return(&dev->enable_cnt) > 1)
+	if (atomic_inc_return(&dev->enable_cnt) > 1) {
+		pci_update_current_state(dev, dev->current_state);
 		return 0;		/* already enabled */
+	}
 
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
-- 
2.30.2

