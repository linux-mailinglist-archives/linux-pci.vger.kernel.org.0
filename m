Return-Path: <linux-pci+bounces-3946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF1861E4B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B2CB2192D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5A14939A;
	Fri, 23 Feb 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJDP2nx7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8023149397;
	Fri, 23 Feb 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721939; cv=none; b=CIquBULENHipGU+g7Ap15ycufAriKg1y58Q04Qn0sBy8ZhcRYBKzG8Qx+G82ZjG9t37TxWtDuVfyC7ygxT+3MNfAW9irG60g6hfpxVgNxF1FXWYTGpx8Y3gKNv6cCUjKEI7Y1q20TwbzYJ+QkDWJ3SZ2Pv4qvDvMx2TCeQwuHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721939; c=relaxed/simple;
	bh=x65rMjAkCbuMIIOI1rAb9CSZyHu2Knp8Gr3cSU2oInE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcymUZM2vH5eX22LlcpVymG2t4Qwd2B6eDn3sezNUnznICEGODCpv1WCwOwM0aKBUttnkEmWHocviTflx115vitL9KQsxREmTsIZYjBGaXBnHyBg9zGg+dQlZpwuJ/r2UyfH+F3Qq1dBJry9hQDBVvtSnldryYsUHjNGWnLqX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJDP2nx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E6EC43390;
	Fri, 23 Feb 2024 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721938;
	bh=x65rMjAkCbuMIIOI1rAb9CSZyHu2Knp8Gr3cSU2oInE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJDP2nx70+e8AzyQeZipolaoUklfvNpG55x5LxdePBmRDfB60VHt0l1Q7tj82p2vT
	 aa9gXGE7m11cd7Y22Xwe4u/i6kSG4qRI6obFvMJ7lb8teTVubeWRximRxoOurNqMRw
	 D8IfqM2BRrPBp5PgL/Qy8Jr7vW0K25H47oDSt1HD0zIx405bj0q0AZC2x8bPX7JTCZ
	 K8EVXO+E+KXbCSnalTa/K3yle4RkfUgFAjQEdamNW/lxJz5yBBBp6odAyEN5xpTNUN
	 3PBwim9CtmIgHCSZMM9tJuG5JegzeHxGtLzSLTkKVh8d/JmE614eIPHo6WH3o55/Pa
	 HBJIbKZffYZzQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 2/5] PCI/ASPM: Always build aspm.c
Date: Fri, 23 Feb 2024 14:58:48 -0600
Message-Id: <20240223205851.114931-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223205851.114931-1-helgaas@kernel.org>
References: <20240223205851.114931-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

Some ASPM-related tasks, such as save and restore of LTR and L1SS
capabilities, still need to be performed when CONFIG_PCIEASPM is not
enabled. To prepare for these changes, wrap the current code in aspm.c
with an #ifdef and always build the file.

Link: https://lore.kernel.org/r/20240128233212.1139663-2-david.e.box@linux.intel.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
[bhelgaas: split build change from function moves]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Makefile | 2 +-
 drivers/pci/pcie/aspm.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..6461aa93fe76 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,7 +6,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
-obj-$(CONFIG_PCIEASPM)		+= aspm.o
+obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d1538f73f2f9..d50c0f83430f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,6 +24,8 @@
 
 #include "../pci.h"
 
+#ifdef CONFIG_PCIEASPM
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -1517,3 +1519,5 @@ bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
 }
+
+#endif /* CONFIG_PCIEASPM */
-- 
2.34.1


