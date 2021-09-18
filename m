Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB054106D3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhIRNcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:32:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57564 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbhIRNcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:32:09 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5c65a5afa5370310; Sat, 18 Sep 2021 15:30:44 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3847F66A51F;
        Sat, 18 Sep 2021 15:30:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
Date:   Sat, 18 Sep 2021 15:21:10 +0200
Message-ID: <1798761.CQOukoFCf9@kreacher>
In-Reply-To: <8003272.NyiUUSuA9g@kreacher>
References: <8003272.NyiUUSuA9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucfuphgrmhfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
 ohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlvghnrdgsrhhofihnsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=32 Fuz1=32 Fuz2=32
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Support for Intel MID platforms has mostly gone away with the SFI
support removal in commit 4590d98f5a4f ("sfi: Remove framework for
deprecated firmware"), but there are some pieces of it still in the
tree.  One of them is the MID PCI PM support code which gets in the
way of subsequent PCI PM simplifications and trying to update it is
rather pointless, so get rid of it completely along with the arch
code pieces that are only used by it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I am going to post patches removing the rest of MID support from arch/x86/
and elsewhere, but that is still quite a bit of stuff and I don't want this
simple PCI PM series to depend on that work.

---
 arch/x86/include/asm/intel-mid.h  |    3 
 arch/x86/platform/intel-mid/pwr.c |  150 --------------------------------------
 drivers/pci/Makefile              |    1 
 drivers/pci/pci-mid.c             |   77 -------------------
 4 files changed, 231 deletions(-)

Index: linux-pm/drivers/pci/Makefile
===================================================================
--- linux-pm.orig/drivers/pci/Makefile
+++ linux-pm/drivers/pci/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
-obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
 obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
 obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
 obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
Index: linux-pm/drivers/pci/pci-mid.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-mid.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel MID platform PM support
- *
- * Copyright (C) 2016, Intel Corporation
- *
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-#include <asm/intel-mid.h>
-
-#include "pci.h"
-
-static bool mid_pci_power_manageable(struct pci_dev *dev)
-{
-	return true;
-}
-
-static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
-{
-	return intel_mid_pci_set_power_state(pdev, state);
-}
-
-static pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
-{
-	return intel_mid_pci_get_power_state(pdev);
-}
-
-static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
-{
-	return PCI_D3hot;
-}
-
-static int mid_pci_wakeup(struct pci_dev *dev, bool enable)
-{
-	return 0;
-}
-
-static bool mid_pci_need_resume(struct pci_dev *dev)
-{
-	return false;
-}
-
-static const struct pci_platform_pm_ops mid_pci_platform_pm = {
-	.is_manageable	= mid_pci_power_manageable,
-	.set_state	= mid_pci_set_power_state,
-	.get_state	= mid_pci_get_power_state,
-	.choose_state	= mid_pci_choose_state,
-	.set_wakeup	= mid_pci_wakeup,
-	.need_resume	= mid_pci_need_resume,
-};
-
-/*
- * This table should be in sync with the one in
- * arch/x86/platform/intel-mid/pwr.c.
- */
-static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
-	{}
-};
-
-static int __init mid_pci_init(void)
-{
-	const struct x86_cpu_id *id;
-
-	id = x86_match_cpu(lpss_cpu_ids);
-	if (id)
-		pci_set_platform_pm(&mid_pci_platform_pm);
-	return 0;
-}
-arch_initcall(mid_pci_init);
Index: linux-pm/arch/x86/platform/intel-mid/pwr.c
===================================================================
--- linux-pm.orig/arch/x86/platform/intel-mid/pwr.c
+++ linux-pm/arch/x86/platform/intel-mid/pwr.c
@@ -5,13 +5,6 @@
  * Copyright (C) 2016, Intel Corporation
  *
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- *
- * Intel MID Power Management Unit device driver handles the South Complex PCI
- * devices such as GPDMA, SPI, I2C, PWM, and so on. By default PCI core
- * modifies bits in PMCSR register in the PCI configuration space. This is not
- * enough on some SoCs like Intel Tangier. In such case PCI core sets a new
- * power state of the device in question through a PM hook registered in struct
- * pci_platform_pm_ops (see drivers/pci/pci-mid.c).
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -103,11 +96,6 @@ struct mid_pwr {
 
 static struct mid_pwr *midpwr;
 
-static u32 mid_pwr_get_state(struct mid_pwr *pwr, int reg)
-{
-	return readl(pwr->regs + PM_SSS(reg));
-}
-
 static void mid_pwr_set_state(struct mid_pwr *pwr, int reg, u32 value)
 {
 	writel(value, pwr->regs + PM_SSC(reg));
@@ -150,143 +138,6 @@ static int mid_pwr_wait_for_cmd(struct m
 	return mid_pwr_wait(pwr);
 }
 
-static int __update_power_state(struct mid_pwr *pwr, int reg, int bit, int new)
-{
-	int curstate;
-	u32 power;
-	int ret;
-
-	/* Check if the device is already in desired state */
-	power = mid_pwr_get_state(pwr, reg);
-	curstate = (power >> bit) & 3;
-	if (curstate == new)
-		return 0;
-
-	/* Update the power state */
-	mid_pwr_set_state(pwr, reg, (power & ~(3 << bit)) | (new << bit));
-
-	/* Send command to SCU */
-	ret = mid_pwr_wait_for_cmd(pwr, CMD_SET_CFG);
-	if (ret)
-		return ret;
-
-	/* Check if the device is already in desired state */
-	power = mid_pwr_get_state(pwr, reg);
-	curstate = (power >> bit) & 3;
-	if (curstate != new)
-		return -EAGAIN;
-
-	return 0;
-}
-
-static pci_power_t __find_weakest_power_state(struct mid_pwr_dev *lss,
-					      struct pci_dev *pdev,
-					      pci_power_t state)
-{
-	pci_power_t weakest = PCI_D3hot;
-	unsigned int j;
-
-	/* Find device in cache or first free cell */
-	for (j = 0; j < LSS_MAX_SHARED_DEVS; j++) {
-		if (lss[j].pdev == pdev || !lss[j].pdev)
-			break;
-	}
-
-	/* Store the desired state in cache */
-	if (j < LSS_MAX_SHARED_DEVS) {
-		lss[j].pdev = pdev;
-		lss[j].state = state;
-	} else {
-		dev_WARN(&pdev->dev, "No room for device in PWRMU LSS cache\n");
-		weakest = state;
-	}
-
-	/* Find the power state we may use */
-	for (j = 0; j < LSS_MAX_SHARED_DEVS; j++) {
-		if (lss[j].state < weakest)
-			weakest = lss[j].state;
-	}
-
-	return weakest;
-}
-
-static int __set_power_state(struct mid_pwr *pwr, struct pci_dev *pdev,
-			     pci_power_t state, int id, int reg, int bit)
-{
-	const char *name;
-	int ret;
-
-	state = __find_weakest_power_state(pwr->lss[id], pdev, state);
-	name = pci_power_name(state);
-
-	ret = __update_power_state(pwr, reg, bit, (__force int)state);
-	if (ret) {
-		dev_warn(&pdev->dev, "Can't set power state %s: %d\n", name, ret);
-		return ret;
-	}
-
-	dev_vdbg(&pdev->dev, "Set power state %s\n", name);
-	return 0;
-}
-
-static int mid_pwr_set_power_state(struct mid_pwr *pwr, struct pci_dev *pdev,
-				   pci_power_t state)
-{
-	int id, reg, bit;
-	int ret;
-
-	id = intel_mid_pwr_get_lss_id(pdev);
-	if (id < 0)
-		return id;
-
-	reg = (id * LSS_PWS_BITS) / 32;
-	bit = (id * LSS_PWS_BITS) % 32;
-
-	/* We support states between PCI_D0 and PCI_D3hot */
-	if (state < PCI_D0)
-		state = PCI_D0;
-	if (state > PCI_D3hot)
-		state = PCI_D3hot;
-
-	mutex_lock(&pwr->lock);
-	ret = __set_power_state(pwr, pdev, state, id, reg, bit);
-	mutex_unlock(&pwr->lock);
-	return ret;
-}
-
-int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
-{
-	struct mid_pwr *pwr = midpwr;
-	int ret = 0;
-
-	might_sleep();
-
-	if (pwr && pwr->available)
-		ret = mid_pwr_set_power_state(pwr, pdev, state);
-	dev_vdbg(&pdev->dev, "set_power_state() returns %d\n", ret);
-
-	return 0;
-}
-
-pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
-{
-	struct mid_pwr *pwr = midpwr;
-	int id, reg, bit;
-	u32 power;
-
-	if (!pwr || !pwr->available)
-		return PCI_UNKNOWN;
-
-	id = intel_mid_pwr_get_lss_id(pdev);
-	if (id < 0)
-		return PCI_UNKNOWN;
-
-	reg = (id * LSS_PWS_BITS) / 32;
-	bit = (id * LSS_PWS_BITS) % 32;
-	power = mid_pwr_get_state(pwr, reg);
-	return (__force pci_power_t)((power >> bit) & 3);
-}
-
 void intel_mid_pwr_power_off(void)
 {
 	struct mid_pwr *pwr = midpwr;
@@ -469,7 +320,6 @@ static const struct mid_pwr_device_info
 	.set_initial_state = tng_set_initial_state,
 };
 
-/* This table should be in sync with the one in drivers/pci/pci-mid.c */
 static const struct pci_device_id mid_pwr_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PENWELL), (kernel_ulong_t)&pnw_info },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), (kernel_ulong_t)&tng_info },
Index: linux-pm/arch/x86/include/asm/intel-mid.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/intel-mid.h
+++ linux-pm/arch/x86/include/asm/intel-mid.h
@@ -10,9 +10,6 @@
 #include <linux/pci.h>
 
 extern int intel_mid_pci_init(void);
-extern int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
-extern pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev);
-
 extern void intel_mid_pwr_power_off(void);
 
 #define INTEL_MID_PWR_LSS_OFFSET	4



