Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFE536D76
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiE1POg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiE1POf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 11:14:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE0E2EE23;
        Sat, 28 May 2022 08:14:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5609D1063;
        Sat, 28 May 2022 08:14:33 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.7.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FB73F73D;
        Sat, 28 May 2022 08:14:31 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update my email address to @kernel.org
Date:   Sat, 28 May 2022 16:14:11 +0100
Message-Id: <20220528151411.29810-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I will soon lose my @arm.com email address, so to prevent any possible
issue let's update all kernel references (inclusive of .mailmap) to my
@kernel.org alias ahead of time.

My @arm.com address is still working and will likely resume to work at
some point in the future; nonetheless, it is safer to switch to the
@kernel.org alias from now onwards so that continuity is guaranteed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 .mailmap    |  1 +
 MAINTAINERS | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6d484937f901..9ba38a82aba4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -236,6 +236,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 <linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 392467e9ab73..4fa6a8da4b83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -382,7 +382,7 @@ F:	include/acpi/
 F:	tools/power/acpi/
 
 ACPI FOR ARM64 (ACPI/arm64)
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
@@ -2946,7 +2946,7 @@ N:	uniphier
 ARM/VERSATILE EXPRESS PLATFORM
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	*/*/*/vexpress*
@@ -5162,7 +5162,7 @@ F:	arch/x86/kernel/cpuid.c
 F:	arch/x86/kernel/msr.c
 
 CPUIDLE DRIVER - ARM BIG LITTLE
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -5182,7 +5182,7 @@ F:	drivers/cpuidle/cpuidle-exynos.c
 F:	include/linux/platform_data/cpuidle-exynos.h
 
 CPUIDLE DRIVER - ARM PSCI
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -15289,7 +15289,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
 
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
@@ -15352,7 +15352,7 @@ F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 R:	Rob Herring <robh@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
@@ -15905,7 +15905,7 @@ F:	include/linux/dtpm.h
 
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/psci/
@@ -18277,7 +18277,7 @@ F:	drivers/net/ethernet/smsc/smc91x.*
 
 SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
 M:	Mark Rutland <mark.rutland@arm.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.31.0

