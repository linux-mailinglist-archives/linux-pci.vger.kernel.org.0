Return-Path: <linux-pci+bounces-22427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0EFA45EB8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F63B67CA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69627218AB7;
	Wed, 26 Feb 2025 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw9CPk3c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BC218AB4;
	Wed, 26 Feb 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572033; cv=none; b=qs3b9BPVme39pCg3Is2BE/hEjJ6ZYstO3m3YfaYF+0Ouu6GeyWTtD7LLCJLVmVC1RzodFJzFZ4ueatLyVGzylwFxECqwqLwC7Cg+Yacq8rSO5uziBXfUIFH7D76QmJVmlUe+QLqHwK95PoBx7QSh0Dc6QBLIDXGJmFlDRoWhMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572033; c=relaxed/simple;
	bh=GcvXXx1lH7e5vihnT4eJBpV8ZfmSctEe/4HiQvmUR7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGkMKNsdRQrVWHUDaXW99UwU5EonQZGTxBK40tbO5HhRCxJjCtyOhbjiEkiJjlkjQCZrYDz+gevaGxYmCIVylS3AiLPI7mcItLrwMdo3D2XzS0Vu9v9kIgn+b5/MEQs/a4Nn8T7YpXtg50M7/OdmtdxrpGbyjV0LY0Y9yMghBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw9CPk3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3292C4CED6;
	Wed, 26 Feb 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572032;
	bh=GcvXXx1lH7e5vihnT4eJBpV8ZfmSctEe/4HiQvmUR7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw9CPk3cyvIcAmj/SI0HoWoP5+17glL9ksAeiPmcWvgfUtS/CoSj7pFyfUif+ujdR
	 3/ZvG9hzJS2VSpY8Y+670LYRbxnSneA+neAy2iE34VOkkJnRUmZXfdUdS7nXfEG1zC
	 kQ5xtT5j1QWh0w7CeievEJ72mAKO7oKGLpkaFxUgth2R53pD8ohAIir4Xo4kMrSTZs
	 r9LHzwasBuTV2/wkfkLDX3JIBMBQMfN0+s7jZjEfpn/EC+AbKzW1D3m9prtZUER3yk
	 JmyRawfnB9Aju2/Klgk75q5n6viw7lXBwvt1XIf9FtODQ9ktwSsM73xJr7i1QBFENp
	 +nLI0VyCUb1pA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	gregkh@linuxfoundation.org,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 2/7] tsm: Move tsm core outside the host directory
Date: Wed, 26 Feb 2025 17:43:18 +0530
Message-ID: <20250226121323.577328-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226121323.577328-1-aneesh.kumar@kernel.org>
References: <yq5a4j0gc3fp.fsf@kernel.org>
 <20250226121323.577328-1-aneesh.kumar@kernel.org>
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


