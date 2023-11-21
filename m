Return-Path: <linux-pci+bounces-62-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B17F361E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F038F1C20DAA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5C5101D;
	Tue, 21 Nov 2023 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYxBaRDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5F6FDA
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8D0C433C9;
	Tue, 21 Nov 2023 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591827;
	bh=C6m0QxEEEagkK0ogkwO9p1q1S1UTNszLjTNwB5ZbW2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYxBaRDnE5422oa0tSYk6ckiko3rH9YAi6UgUhSK63hSS79pUTTmAbz3duI5LgPXL
	 xUmWNDGVqEUZirq7hvviy1DhoHjE9wyGi6o+V4djOx9guALh5RmKqI/Pyogzd7A4WL
	 xJ8Vi/+n1jLv3C0HQ2y4tOBuffpM6onr7Mwg//wmIiYMwb7UDuR9IC2/wbe5UmOfc5
	 sFk5ZS9+omU7vx0BT4N00pPVFEimorsZQNEZcDddZsIpcG4e51iHO+B6HEwdQ1zqEz
	 WpCVQIho4E3i+mUgNCxea9M7C5INUvUmTsjLroxI6WMtdwwR7QgkEMBOt1NUWyDiQD
	 fpO85TRmUbsJg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 9/9] x86/pci: Reorder pci_mmcfg_arch_map() definition before calls
Date: Tue, 21 Nov 2023 12:36:43 -0600
Message-Id: <20231121183643.249006-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The typical style is to define functions before calling them.  Move
pci_mmcfg_arch_map() and pci_mmcfg_arch_unmap() earlier so they're defined
before they're called.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig_64.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index dfdeac0a7571..cb5aa79a759e 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -111,6 +111,25 @@ static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
 	return addr;
 }
 
+int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+{
+	cfg->virt = mcfg_ioremap(cfg);
+	if (!cfg->virt) {
+		pr_err("can't map ECAM at %pR\n", &cfg->res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	if (cfg && cfg->virt) {
+		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		cfg->virt = NULL;
+	}
+}
+
 int __init pci_mmcfg_arch_init(void)
 {
 	struct pci_mmcfg_region *cfg;
@@ -133,22 +152,3 @@ void __init pci_mmcfg_arch_free(void)
 	list_for_each_entry(cfg, &pci_mmcfg_list, list)
 		pci_mmcfg_arch_unmap(cfg);
 }
-
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
-{
-	cfg->virt = mcfg_ioremap(cfg);
-	if (!cfg->virt) {
-		pr_err("can't map ECAM at %pR\n", &cfg->res);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
-{
-	if (cfg && cfg->virt) {
-		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
-		cfg->virt = NULL;
-	}
-}
-- 
2.34.1


