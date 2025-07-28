Return-Path: <linux-pci+bounces-33055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A440AB13C5B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15B64E158F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07326E6E5;
	Mon, 28 Jul 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnK64EkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22831FBE9B;
	Mon, 28 Jul 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710894; cv=none; b=oEp8JN6pTpdf38PgBSrWxLpAv+l8ZpQqbo7+uv4yy4rjcgrgGUcCJ8/t2K0gYSFE47vGfeyJMEGIqNWoB7x2IZkd7BepbsuNHjoEn0avnepwr0jbMMOFL1mpbMtKvF7QfxuGgsKKYGbpivyefbUJ0IMPG7Nd63CKnFydO86yGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710894; c=relaxed/simple;
	bh=0uRSZsgUrPsLQX8cHcPVQBzeHfezwcb/o6314ZYbxOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/J0ga4NRPSFhWuyux9RaaDg/3iNbU3Frx1gj/eCFfMr1RLop8bsU0BNBAJlsqkbSLbkrh+bIZ6XkuuyH3nwx0QVBQRScKdN9lGUqDDzC6XLD7wRF5HJk1taI+x/Bc6oWBJj0WcXpCajJL8mRTgOqi/gsEveyKtPddO9w5B3qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnK64EkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DA1C4CEF9;
	Mon, 28 Jul 2025 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710894;
	bh=0uRSZsgUrPsLQX8cHcPVQBzeHfezwcb/o6314ZYbxOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnK64EkIp5HEQKmIWV9qJmAGXYHcebJHzjGu0iFRo0N97Z+fGupGK3Zo7CL99fAtX
	 K9wxKq7eyx8yVHbUhRY6Hmm+nCHBJdvPCVuFRxnmz2sfOfPyclifYvjPkLioZRR9kL
	 qev8O6n35NF00gBistj0oe9Tg6DfbEAPVlY6+GhGC59V3sdRIERRB/TiX4VS4aLpLX
	 wYpEEMo0OcVEOFTvFdBC3AOMA06oBksisNVYMHJJ75wbNDB3neUJ5/tynpd4pCKOoI
	 AsCD52h5hbtXGcbky8tWgTec/EBBjA2txODWOWWoJptxzUl/JwT+V+saMSgWL3NgxJ
	 uIB5YrdEHClZg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 23/38] coco: guest: arm64: Update arm CCA guest driver
Date: Mon, 28 Jul 2025 19:22:00 +0530
Message-ID: <20250728135216.48084-24-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch includes renaming changes to simplify the registration of a
TSM backend in the next patch. There are no functional changes in this
update.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi.h                  |  2 +-
 arch/arm64/kernel/rsi.c                       |  2 +-
 drivers/virt/coco/arm-cca-guest/Makefile      |  3 ++
 .../{arm-cca-guest.c => arm-cca.c}            | 52 +++++++++----------
 4 files changed, 29 insertions(+), 30 deletions(-)
 rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (86%)

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index b42aeac05340..26ef6143562b 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -10,7 +10,7 @@
 #include <linux/jump_label.h>
 #include <asm/rsi_cmds.h>
 
-#define RSI_PDEV_NAME "arm-cca-dev"
+#define RSI_DEV_NAME "arm-rsi-dev"
 
 DECLARE_STATIC_KEY_FALSE(rsi_present);
 
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index ce4778141ec7..bf9ea99e2aa1 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -142,7 +142,7 @@ void __init arm64_rsi_init(void)
 }
 
 static struct platform_device rsi_dev = {
-	.name = RSI_PDEV_NAME,
+	.name = RSI_DEV_NAME,
 	.id = PLATFORM_DEVID_NONE
 };
 
diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index 69eeba08e98a..609462ea9438 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
+
+arm-cca-guest-$(CONFIG_TSM) +=  arm-cca.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
similarity index 86%
rename from drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
rename to drivers/virt/coco/arm-cca-guest/arm-cca.c
index 0c9ea24a200c..547fc2c79f7d 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/tsm.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
 
 #include <asm/rsi.h>
 
@@ -181,52 +182,47 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
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
+static int cca_guest_probe(struct platform_device *pdev)
 {
 	int ret;
 
 	if (!is_realm_world())
 		return -ENODEV;
 
-	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
+	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
 	if (ret < 0)
 		pr_err("Error %d registering with TSM\n", ret);
 
-	return ret;
-}
-module_init(arm_cca_guest_init);
+	ret = devm_add_action_or_reset(&pdev->dev, unregister_cca_tsm_report, NULL);
 
-/**
- * arm_cca_guest_exit - unregister with the Trusted Security Module (TSM)
- * interface.
- */
-static void __exit arm_cca_guest_exit(void)
-{
-	tsm_report_unregister(&arm_cca_tsm_ops);
+	return ret;
 }
-module_exit(arm_cca_guest_exit);
 
 /* modalias, so userspace can autoload this module when RSI is available */
-static const struct platform_device_id arm_cca_match[] __maybe_unused = {
-	{ RSI_PDEV_NAME, 0},
+static const struct platform_device_id arm_cca_guest_id_table[] = {
+	{ RSI_DEV_NAME, 0},
 	{ }
 };
-
-MODULE_DEVICE_TABLE(platform, arm_cca_match);
+MODULE_DEVICE_TABLE(platform, arm_cca_guest_id_table);
+
+static struct platform_driver cca_guest_platform_driver = {
+	.probe = cca_guest_probe,
+	.id_table = arm_cca_guest_id_table,
+	.driver = {
+		.name = "arm-cca-guest",
+	},
+};
+module_platform_driver(cca_guest_platform_driver);
 MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
-MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
+MODULE_DESCRIPTION("Arm CCA Guest TSM driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0


