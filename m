Return-Path: <linux-pci+bounces-39385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D075C0CC6F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B9719A20B9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB72F5A39;
	Mon, 27 Oct 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsCjugqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D552F4A14;
	Mon, 27 Oct 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558687; cv=none; b=lBHjxPy3OdWr+Kjlt4Y5tD5T+45AjSD4Uz/dvdH4wNYsLhjRrHeLf5KAa5aNfGvSTVXpBw3SzyQulsQOvThKOD5HJnOPWAx2gqZzKE+BeP1K8TbDcL2zIXvEl8eEXl+panu5JSbcYYKRYHZqwSKAQEAmtZ2JWMqtF7YoM8QEOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558687; c=relaxed/simple;
	bh=xgScCgzz6ncBbywMhZj1X+FhxpDg3LK2VwTvSsathms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7gI/EORJ4bl4je6cXnBaoX+9JBjqKQCN7JJNYVh861lcZ4EEkgs8lQlFNAmHQY2BebOBAruawN8cKOX2jwUtFXb1OloBy7n06Y5zJTFS8RR5fJKawBfaPgLROBRH5+Cb5CBKWG/z/Cx29jN1EAbHGLkoNzzSqB/eJUojjPHcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsCjugqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79E8C4CEF1;
	Mon, 27 Oct 2025 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558687;
	bh=xgScCgzz6ncBbywMhZj1X+FhxpDg3LK2VwTvSsathms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsCjugqezuKjuNHz8X/d87fVfj7hVPvwOmwjLQDyWNlXK6Au43Odd1grlrPbcx91X
	 PHvy8SlX9OZFqsOp3DVouDhzg/tSdbzredT8s2A+kO91jWbArkupkalhsGk6eeT0KA
	 ATyVhP9N+tIMk+jbxwhZTC4JgG6Kz6flbW4euKgWilUzDASU3cbzIhh7IGgi/kjVmP
	 OB8bmbpsqHqY2KKv+B7Xh36Ksz7QjeAcERVtWbCUfun2oMovwCzNv/sHgHxeSquHtE
	 fIi2JoHUAZMrZH6tmLMeLvM/FNuDjvQsFHpbW0hD+/H2uoZPnARcDD3/+t7TlGZb0D
	 o6po6+JPsJb2w==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 02/12] firmware: smccc: coco: Manage arm-smccc platform device and CCA auxiliary drivers
Date: Mon, 27 Oct 2025 15:19:06 +0530
Message-ID: <20251027094916.1153143-15-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the SMCCC driver responsible for registering the arm-smccc platform
device and after confirming the relevant SMCCC function IDs, create
the arm_cca_guest auxiliary device.

Also update the arm-cca-guest driver to use the auxiliary device
interface instead of the platform device (arm-cca-dev). The removal of
the platform device registration will follow in a subsequent patch,
allowing this change to be applied without immediately breaking existing
userspace dependencies [1].

[1] https://lore.kernel.org/all/4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi.h                  |  2 +-
 arch/arm64/kernel/rsi.c                       |  2 +-
 drivers/firmware/smccc/Kconfig                |  1 +
 drivers/firmware/smccc/smccc.c                | 37 ++++++++++++
 drivers/virt/coco/arm-cca-guest/Kconfig       |  1 +
 drivers/virt/coco/arm-cca-guest/Makefile      |  2 +
 .../{arm-cca-guest.c => arm-cca.c}            | 57 +++++++++----------
 7 files changed, 71 insertions(+), 31 deletions(-)
 rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (85%)

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index 88b50d660e85..2d2d363aaaee 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -10,7 +10,7 @@
 #include <linux/jump_label.h>
 #include <asm/rsi_cmds.h>
 
-#define RSI_PDEV_NAME "arm-cca-dev"
+#define RSI_DEV_NAME "arm-rsi-dev"
 
 DECLARE_STATIC_KEY_FALSE(rsi_present);
 
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index c64a06f58c0b..5d711942e543 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -160,7 +160,7 @@ void __init arm64_rsi_init(void)
 }
 
 static struct platform_device rsi_dev = {
-	.name = RSI_PDEV_NAME,
+	.name = "arm-cca-dev",
 	.id = PLATFORM_DEVID_NONE
 };
 
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
index 15e7466179a6..2b6984757241 100644
--- a/drivers/firmware/smccc/Kconfig
+++ b/drivers/firmware/smccc/Kconfig
@@ -8,6 +8,7 @@ config HAVE_ARM_SMCCC
 config HAVE_ARM_SMCCC_DISCOVERY
 	bool
 	depends on ARM_PSCI_FW
+	select AUXILIARY_BUS
 	default y
 	help
 	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index bdee057db2fd..3dbf0d067cc5 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -10,7 +10,12 @@
 #include <linux/arm-smccc.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/auxiliary_bus.h>
+
 #include <asm/archrandom.h>
+#ifdef CONFIG_ARM64
+#include <asm/rsi_cmds.h>
+#endif
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
@@ -81,10 +86,42 @@ bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_hypervisor_has_uuid);
 
+#ifdef CONFIG_ARM64
+static void __init register_rsi_device(struct platform_device *pdev)
+{
+	unsigned long ver_lower, ver_higher;
+	unsigned long ret = rsi_request_version(RSI_ABI_VERSION,
+						&ver_lower,
+						&ver_higher);
+
+	if (ret == RSI_SUCCESS)
+		__devm_auxiliary_device_create(&pdev->dev,
+					"arm_cca_guest", RSI_DEV_NAME, NULL, 0);
+
+}
+#else
+static void __init register_rsi_device(struct platform_device *pdev)
+{
+
+}
+#endif
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
 
+	pdev = platform_device_register_simple("arm-smccc",
+					PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("arm-smccc: could not register device: %ld\n", PTR_ERR(pdev));
+	} else {
+		/*
+		 * Register the RMI and RSI devices only when firmware exposes
+		 * the required SMCCC function IDs at a supported revision.
+		 */
+		register_rsi_device(pdev);
+	}
+
 	if (smccc_trng_available) {
 		pdev = platform_device_register_simple("smccc_trng", -1,
 						       NULL, 0);
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index 3f0f013f03f1..a42359a90558 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -2,6 +2,7 @@ config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
 	depends on ARM64
 	select TSM_REPORTS
+	select AUXILIARY_BUS
 	help
 	  The driver provides userspace interface to request and
 	  attestation report from the Realm Management Monitor(RMM).
diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index 69eeba08e98a..75a120e24fda 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
+
+arm-cca-guest-y +=  arm-cca.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
similarity index 85%
rename from drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
rename to drivers/virt/coco/arm-cca-guest/arm-cca.c
index 0c9ea24a200c..dc96171791db 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/arm-smccc.h>
 #include <linux/cc_platform.h>
 #include <linux/kernel.h>
@@ -181,52 +182,50 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
 	return ret;
 }
 
-static const struct tsm_report_ops arm_cca_tsm_ops = {
+static const struct tsm_report_ops arm_cca_tsm_report_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = arm_cca_report_new,
 };
 
-/**
- * arm_cca_guest_init - Register with the Trusted Security Module (TSM)
- * interface.
- *
- * Return:
- * * %0        - Registered successfully with the TSM interface.
- * * %-ENODEV  - The execution context is not an Arm Realm.
- * * %-EBUSY   - Already registered.
- */
-static int __init arm_cca_guest_init(void)
+static void unregister_cca_tsm_report(void *data)
+{
+	tsm_report_unregister(&arm_cca_tsm_report_ops);
+}
+
+static int cca_devsec_tsm_probe(struct auxiliary_device *adev,
+				const struct auxiliary_device_id *id)
 {
 	int ret;
 
 	if (!is_realm_world())
 		return -ENODEV;
 
-	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
-	if (ret < 0)
+	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
+	if (ret < 0) {
 		pr_err("Error %d registering with TSM\n", ret);
+		return ret;
+	}
 
-	return ret;
-}
-module_init(arm_cca_guest_init);
+	ret = devm_add_action_or_reset(&adev->dev, unregister_cca_tsm_report, NULL);
+	if (ret < 0) {
+		pr_err("Error %d registering devm action\n", ret);
+		return ret;
+	}
 
-/**
- * arm_cca_guest_exit - unregister with the Trusted Security Module (TSM)
- * interface.
- */
-static void __exit arm_cca_guest_exit(void)
-{
-	tsm_report_unregister(&arm_cca_tsm_ops);
+	return 0;
 }
-module_exit(arm_cca_guest_exit);
 
-/* modalias, so userspace can autoload this module when RSI is available */
-static const struct platform_device_id arm_cca_match[] __maybe_unused = {
-	{ RSI_PDEV_NAME, 0},
-	{ }
+static const struct auxiliary_device_id cca_devsec_tsm_id_table[] = {
+	{ .name =  KBUILD_MODNAME "." RSI_DEV_NAME },
+	{}
 };
+MODULE_DEVICE_TABLE(auxiliary, cca_devsec_tsm_id_table);
 
-MODULE_DEVICE_TABLE(platform, arm_cca_match);
+static struct auxiliary_driver cca_devsec_tsm_driver = {
+	.probe = cca_devsec_tsm_probe,
+	.id_table = cca_devsec_tsm_id_table,
+};
+module_auxiliary_driver(cca_devsec_tsm_driver);
 MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
 MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0


