Return-Path: <linux-pci+bounces-33034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF49B13C18
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5670F189FBA4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA026E142;
	Mon, 28 Jul 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4nbgzXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409B265CDD;
	Mon, 28 Jul 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710770; cv=none; b=OVImODeWRvwvcx16oWzVRKXJVKz6jnRg1f+gtjQX6sUmu3/dtXWRLHH88MdA3UbgWuUs5ZfhtSBOU5RPBe7jt01oJU8l4LvUWf/sXuhQWxoQ9eZ3ocq3ktWRcyPxL8SLSN3KdC+1ttRCfZR+cZ3WPSxZ/70h6d6/LUR/tDdBukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710770; c=relaxed/simple;
	bh=GcvXXx1lH7e5vihnT4eJBpV8ZfmSctEe/4HiQvmUR7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqU6xM9DQ12EqrdtUno/kdG+MLd0obadn8bkaid7a3r0CsJHaklMe6S+DXLTYJPDdxxCJVaNYxFlNMvyEFr+ud0L2qnCVBcZQwbZnXdK8mjTChqzoeKYrnnvXIYjIGoWJLwbEmVIqQW19SMWd+ap93Xy+WpjJLRNO04MIHRcRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4nbgzXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE4C4CEE7;
	Mon, 28 Jul 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710769;
	bh=GcvXXx1lH7e5vihnT4eJBpV8ZfmSctEe/4HiQvmUR7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4nbgzXGytKie8QjM2gZk0snFtn4Qd7ijbdfmS12NoKBMtFxsZljNEy/StsgiSFsC
	 T83aEkES7dg6x4hTeWXhSwgPbIVMLY6wEZfTi0o/okeCOqVOu/YRm0JnEfuq8q/DA9
	 W+ZwNq07I5YRzou+aYWBcSYqcN+QDmd7c1Rwc1JG0tWNrPVvdmQ79nuZvMBcJfd2S4
	 3vKjjC6BbYQjapBd7CDM7eua8lqd96KibfD2iJcko99598DJ9TAYyrmzqzeXTlSoyy
	 OWCljYzbhYF3XNqga9E39lbXZVOTwGLNcT6go9th6R0YPYgbo06OHemunEQKXJwBCS
	 jGTfReMlqZoiA==
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
Subject: [RFC PATCH v1 02/38] tsm: Move tsm core outside the host directory
Date: Mon, 28 Jul 2025 19:21:39 +0530
Message-ID: <20250728135216.48084-3-aneesh.kumar@kernel.org>
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

A later patch will add guest changes that will also use the same
infrastructure.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/Kconfig               | 3 ++-
 drivers/virt/coco/Makefile              | 6 ++++--
 drivers/virt/coco/host/Kconfig          | 6 ------
 drivers/virt/coco/host/Makefile         | 6 ------
 drivers/virt/coco/{host => }/tsm-core.c | 0
 5 files changed, 6 insertions(+), 15 deletions(-)
 delete mode 100644 drivers/virt/coco/host/Kconfig
 delete mode 100644 drivers/virt/coco/host/Makefile
 rename drivers/virt/coco/{host => }/tsm-core.c (100%)

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 14e7cf145d85..57248b088545 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -15,4 +15,5 @@ source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
 
-source "drivers/virt/coco/host/Kconfig"
+config TSM
+	tristate
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 73f1b7bc5b11..04e124b2d7cf 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,10 +2,12 @@
 #
 # Confidential computing related collateral
 #
+
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
-obj-$(CONFIG_TSM_REPORTS)	+= guest/
-obj-y				+= host/
+
+obj-$(CONFIG_TSM) 		+= tsm-core.o
+obj-y				+= guest/
diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
deleted file mode 100644
index 4fbc6ef34f12..000000000000
--- a/drivers/virt/coco/host/Kconfig
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# TSM (TEE Security Manager) Common infrastructure and host drivers
-#
-config TSM
-	tristate
diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
deleted file mode 100644
index be0aba6007cd..000000000000
--- a/drivers/virt/coco/host/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# TSM (TEE Security Manager) Common infrastructure and host drivers
-
-obj-$(CONFIG_TSM) += tsm.o
-tsm-y := tsm-core.o
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/tsm-core.c
similarity index 100%
rename from drivers/virt/coco/host/tsm-core.c
rename to drivers/virt/coco/tsm-core.c
-- 
2.43.0


