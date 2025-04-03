Return-Path: <linux-pci+bounces-25219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0940A79D53
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AE47A552C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8D193402;
	Thu,  3 Apr 2025 07:47:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D89DDA9;
	Thu,  3 Apr 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666429; cv=none; b=kaBgIAU/TJLAUVGImQCosaMAvoeAmCMLcke/YWDbn7IDBxKJ1X30gW9VuCxU8Sb+zNNthWCCAFhMP08ZAucynQxSMz+xs4D7D84eQFs3u1kF5bZAR4GyhBAPK6gwunluaHM4iWEqeP1eiG/z1aezBzuRt8Ly67hwOsm2M6gnJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666429; c=relaxed/simple;
	bh=BviEtD6U0kzb/GrQpAF5uBBfH1RYfmg2EPVJVqAeRpI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=qp13MZmkNeHv5ymhR24PHBxBZAowV9sWdIs8CmVFWuqpO+E2+ifRcH3ueERTjwwq4074bAZJqarelGmi3XKcb0BAUbREMPDtaBdGQmgUysTVrdCzHdHxTRCvxfglPeVe407UqMT1K0onmzl61JZYjnJpXE+oUKInJF1XVp6ckGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSv2Y3PJ6z8RTZL;
	Thu,  3 Apr 2025 15:47:01 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 5337kpK9082996;
	Thu, 3 Apr 2025 15:46:51 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 15:46:54 +0800 (CST)
Date: Thu, 3 Apr 2025 15:46:54 +0800 (CST)
X-Zmail-TransId: 2afb67ee3ceeffffffff9da-3bdb9
X-Mailer: Zmail v1.0
Message-ID: <20250403154654546Uoj1gN_pronbxhSLPEIUn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lpieralisi@kernel.org>
Cc: <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <michal.simek@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <xie.ludan@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBQQ0k6IHhpbGlueC14ZG1hOiBVc2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZcKgwqA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5337kpK9082996
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE3CF5.001/4ZSv2Y3PJ6z8RTZL

From: Xie Ludan <xie.ludan@zte.com.cn>

Introduce devm_platform_ioremap_resource_byname() to simplify
resource retrieval and mapping.This new function consolidates
platform_get_resource_byname() and devm_ioremap_resource() into a single
call, improving code readability and reducing API call overhead.

Signed-off-by: Xie Ludan <xie.ludan@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index dd117f07fc95..238deec3b948 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -753,8 +753,7 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,

 	if (port->variant->version == QDMA) {
 		port->cfg_base = port->cfg->win;
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
-		port->reg_base = devm_ioremap_resource(dev, res);
+		port->reg_base = devm_platform_ioremap_resource_byname(pdev, "breg");
 		if (IS_ERR(port->reg_base))
 			return PTR_ERR(port->reg_base);
 		port->phys_reg_base = res->start;
-- 
2.25.1

