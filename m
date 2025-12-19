Return-Path: <linux-pci+bounces-43342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CECCE40C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 03:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B96E3011FA2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 02:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298814A4F9;
	Fri, 19 Dec 2025 02:16:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA53D76;
	Fri, 19 Dec 2025 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110618; cv=none; b=tGfGE8A+0Upba5My9gFfksGE7qga6BS3Hc0ff2Fh+Lg9rtyWvCGAZiyQ/lTizB9PLP5zHsQIeorOc2+m7YOKf1FYMvFd/I6sa6dTquQY1uS5gq6EW3qqG85Bv2wgdNnuoG06zet2t6X9vJCHsv3JrsKafmaKQJ+R1KjsSyEcK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110618; c=relaxed/simple;
	bh=YGkjBjt+uzxJPYSxbryV4F0YgpdbOxHWJuEcdO+Yrpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcMgGtwmziYGzMa+xYwUsqIYqcRLG/1Q/ob3i42zP4wfzakISWiD5KzoyNzB7zRpf8uf3kQaossSxqBoiBjULmfyddL0s7oaHeLYnA6rwWv2QXiFgOO3pDcdP54a1PSGAp6rbETCdsMN42RCzA7cWAfcW1D7mdU4kFqFog4a880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACHGAyFtURp2kMjAQ--.22672S2;
	Fri, 19 Dec 2025 10:16:39 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	michal.simek@amd.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v3] PCI: xilinx: Fix INTx IRQ domain leak in error paths
Date: Fri, 19 Dec 2025 10:16:15 +0800
Message-ID: <20251219021615.965-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251119033301.518-1-vulab@iscas.ac.cn>
References: <20251119033301.518-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHGAyFtURp2kMjAQ--.22672S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UXr17CrWxtr4xuryrCrg_yoW5JF1rpF
	4DCw47uF4UJFWUuF47G3W5uFy3Wa9Fk34qy3yYgwnrZr13CrWDCF10qFnakF4FvFW8Jr18
	Ar1xt3Wruw47CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREAA2lEGBxvagABs2

In xilinx_pcie_init_irq_domain(), if xilinx_allocate_msi_domains()
fails after pcie->leg_domain has been successfully created via
irq_domain_create_linear(), the function returns directly without
cleaning up the allocated IRQ domain, resulting in a resource leak.
In xilinx_free_msi_domains(), pcie->leg_domain is also neglected.

Add irq_domain_remove() call in the error path to properly release the
IRQ domain before returning the error. Rename xilinx_free_msi_domains()
to xilinx_free_irq_domains() and add the release of pcie->leg_domain
in the function.

Fixes: 313b64c3ae52 ("PCI: xilinx: Convert to MSI domains")
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v3:
  - Rename xilinx_free_msi_domains() to xilinx_free_irq_domains()
    and add the release of pcie->leg_domain in the function as
    suggested by Manivannan Sadhasivam.
---
Changes in v2:
  - Correct the Fixes tag to point to the commit that introduced the
    legacy IRQ domain leak on MSI allocation failure.
---
 drivers/pci/controller/pcie-xilinx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 937ea6ae1ac4..4aa139abac16 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -302,9 +302,10 @@ static int xilinx_allocate_msi_domains(struct xilinx_pcie *pcie)
 	return 0;
 }
 
-static void xilinx_free_msi_domains(struct xilinx_pcie *pcie)
+static void xilinx_free_irq_domains(struct xilinx_pcie *pcie)
 {
 	irq_domain_remove(pcie->msi_domain);
+	irq_domain_remove(pcie->leg_domain);
 }
 
 /* INTx Functions */
@@ -480,8 +481,10 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
 
 		ret = xilinx_allocate_msi_domains(pcie);
-		if (ret)
+		if (ret) {
+			irq_domain_remove(pcie->leg_domain);
 			return ret;
+		}
 
 		pcie_write(pcie, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
 		pcie_write(pcie, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
@@ -600,7 +603,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 
 	err = pci_host_probe(bridge);
 	if (err)
-		xilinx_free_msi_domains(pcie);
+		xilinx_free_irq_domains(pcie);
 
 	return err;
 }
-- 
2.50.1.windows.1


