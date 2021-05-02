Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA7370C64
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 16:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhEBOGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 10:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233002AbhEBOFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 10:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D4D61446;
        Sun,  2 May 2021 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619964292;
        bh=YDlg5KDB7MXGQvMnQvkD4Vzdj4c2+NFSVw41cvKCM0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+RjDp9zJ2wRysGNA0t1uJlwD5jZBk47/cx3c5nf7paNH/tpmWpJnNQW1XXYWYO28
         zE3d8Bh49569nAc+dmRcM0zuGWIZi+7V+TcC7ZUPopKaCzjWwRSERN8qEmiRw/7aUK
         /gn8balCU1pXOOBHDOV8T8Q8aqX8SFg2B7ZFfnueHDMwJ+BgmANTckhgRwcyKyLKNs
         EkyzHFHyWu8kUm8/sxrH9qZprDslPqlu83SbPym4Rtvx+hwBfUyjCbQlZNGNO3fC70
         ePQ2U0pPaO7CtBqqyousJgVjP4GO/uJv+RmM43nVsTrakgS1IC2ANm7HTeVSIXiMy2
         ntuEm8l7ocA1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/34] PCI: PM: Do not read power state in pci_enable_device_flags()
Date:   Sun,  2 May 2021 10:04:14 -0400
Message-Id: <20210502140434.2719553-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210502140434.2719553-1-sashal@kernel.org>
References: <20210502140434.2719553-1-sashal@kernel.org>
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
index 3c3bc9f58498..34a06e89e176 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1666,20 +1666,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
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

