Return-Path: <linux-pci+bounces-41566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D2C6C66F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8267D362940
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 02:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F662877D8;
	Wed, 19 Nov 2025 02:33:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F22874FA;
	Wed, 19 Nov 2025 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519639; cv=none; b=avs5deTFJE4WXmfpD5vCAWXM+uRHa5dC0aYiTtg5/Y39vZ2UKvoY8rQutm08wfWrTpmhOVY2K7vK+OzQzK5PHlVjg6/doB7xSa2jRU8IerRITFGvgsNnGauJol61WLVj7z87PT5ozGIGamW8hJKEJuks2IKqnqvz8u+VIVHrb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519639; c=relaxed/simple;
	bh=DXG+rCmKJc9/jLf0GuitEvKPWyqtgBLs76v8WiHpn+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBAYxH17A72HS9QCJogxUoL1neanPFNQvAvJV/7w+gtfg1V5D1GLXORdlQDiqGhNJVQ9RG8ZKR9PKLlkyS59fhiYSVUc44Fzl7zOxTzaqVtB6RA94TXhMtvanm0frCRsFyvSGkM8YlUJXqQI3lmnVq831c4YB2G1EZzAeMaCdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABn99mDLB1pFLw+AQ--.115S2;
	Wed, 19 Nov 2025 10:33:39 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] PCI: mediatek: Fix IRQ domain leak when MSI allocation fails
Date: Wed, 19 Nov 2025 10:33:08 +0800
Message-ID: <20251119023308.476-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABn99mDLB1pFLw+AQ--.115S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4ktFWfAryfWry7tw4ktFb_yoWktrcE9r
	WvqFsxW34jkryakw1SyFWF9Fy29asrWw1kKFyrt3W3AFyIgrn2vr1DZr93XFsrCry8Zr17
	Gr4DCF4fAry7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6c_fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRALA2kdElFuhAAAsM

In mtk_pcie_init_irq_domain(), if mtk_pcie_allocate_msi_domains()
fails after port->irq_domain has been successfully created via
irq_domain_create_linear(), the function returns directly without
cleaning up the allocated IRQ domain, resulting in a resource leak.

Add irq_domain_remove() call in the error path to properly release the
INTx IRQ domain before returning the error.

Fixes: 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/pcie-mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..e0bf667c2b4c 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -575,8 +575,10 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		ret = mtk_pcie_allocate_msi_domains(port);
-		if (ret)
+		if (ret) {
+			irq_domain_remove(port->irq_domain);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.50.1.windows.1


