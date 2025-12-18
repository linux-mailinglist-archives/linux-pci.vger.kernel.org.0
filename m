Return-Path: <linux-pci+bounces-43282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5339CCB630
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 810E2307E739
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD433DEDD;
	Thu, 18 Dec 2025 10:28:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5B339841;
	Thu, 18 Dec 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053727; cv=none; b=RBzuQGbfU8RqNNBGA/w5QmwP4virEJOMq+XuQuA3vP1fCfF++ZlGcdFF/QjdjcGMZ/ZJNadFJPuXYQFVDgWFixPIQCAtq8E6pXPKAz+EzyDkPPLNxPLY7JtmUo3I7on+V5gr8FCGHscAs8FPI9kgjgyAltUPyprjx1O8NeSMYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053727; c=relaxed/simple;
	bh=CTlXptqk2mnA2CR8eLBvFSPqp9GtgMnEtWDeDt3waBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVGZM0KvBBDzDHrBVH+IHSD3wo7nZND1SFB/EDX0PjJtgUcWsLT7LpxeaKJ4cF1xoFgIGDQgtJ/HAt0nH8koHmeUc/M5gfxORkfzDri68OoVpZ4T+OlLKlqdH88KHdYq/fUC+aBy60BvLuH0TN7FViT2XvE+KQcMEPCWSQ0SRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABnf9ZM10NpPH0YAQ--.22337S2;
	Thu, 18 Dec 2025 18:28:30 +0800 (CST)
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
Subject: [PATCH v2] PCI: xilinx: Fix INTx IRQ domain leak when MSI allocation fails
Date: Thu, 18 Dec 2025 18:23:14 +0800
Message-ID: <20251218102314.1474-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowABnf9ZM10NpPH0YAQ--.22337S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UXr17Cr4DAw4rGF1UAwb_yoW8XF1xpF
	WUGw47uF4DJFWUWF4DC3W3ua43Wa9Fyryqyw4agwnrZF13C3yUCFyUKF9Y9F10vFW8JF1U
	Zr18tF1ruF15CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwAA2lDlnP7ogAAse

In xilinx_pcie_init_irq_domain(), if xilinx_allocate_msi_domains()
fails after pcie->leg_domain has been successfully created via
irq_domain_create_linear(), the function returns directly without
cleaning up the allocated IRQ domain, resulting in a resource leak.

Add irq_domain_remove() call in the error path to properly release the
IRQ domain before returning the error.

Fixes: 313b64c3ae52 ("PCI: xilinx: Convert to MSI domains")
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  - Correct the Fixes tag to point to the commit that introduced the
    legacy IRQ domain leak on MSI allocation failure.
---
 drivers/pci/controller/pcie-xilinx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 937ea6ae1ac4..e8cf320f3764 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -480,8 +480,10 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
 
 		ret = xilinx_allocate_msi_domains(pcie);
-		if (ret)
+		if (ret) {
+			irq_domain_remove(pcie->leg_domain);
 			return ret;
+		}
 
 		pcie_write(pcie, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
 		pcie_write(pcie, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
-- 
2.50.1.windows.1


