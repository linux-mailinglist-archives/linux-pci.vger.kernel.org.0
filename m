Return-Path: <linux-pci+bounces-25220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F955A79D59
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4560F7A5AC5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E71193402;
	Thu,  3 Apr 2025 07:48:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D91A23B9;
	Thu,  3 Apr 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666522; cv=none; b=aA+ieKSyYonwQxKOuOSv8c4IaPvIVe+fArDccbKbhUJkLWBdHK/3geH/4HB7MCpp2fhJuY7O1Bs25Lk8eJOSVrNcW7jiXFUsujxADmMBF9vlA2qXqPnLKEcANQDigsccTwpbxlyq3pMmdxlRnUvQf/6Xr4a6jyZ085mzQGBa5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666522; c=relaxed/simple;
	bh=bmoZkPd8++72qkDPN0upiffFV1CeiRK99wl0awuNofc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=rHNCSjY6VoTm32DWL/NE2ekqzOpwHEgS6/sFHG+senV61myPAfUcGkHLOGFs095ELKoU6G63H+yQcgev9lK3XwwuATCWUeMfDIxy4zUm0ps8KVpbiQC29P5xI8JdmWqF567pZXmlMDdEfyV4TWQcSQG/WvJGj/BZ8h9G5O4VaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZSv4M3GVHz4xfxL;
	Thu,  3 Apr 2025 15:48:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5337mUi1073671;
	Thu, 3 Apr 2025 15:48:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 15:48:33 +0800 (CST)
Date: Thu, 3 Apr 2025 15:48:33 +0800 (CST)
X-Zmail-TransId: 2afa67ee3d51ffffffffff5-453cb
X-Mailer: Zmail v1.0
Message-ID: <20250403154833001aNpIIRBQWEw67Oo8nChch@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <jonnyc@amazon.com>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBQQ0k6IGFsOiBVc2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5337mUi1073671
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE3D53.003/4ZSv4M3GVHz4xfxL

From: Xie Ludan <xie.ludan@zte.com.cn>

Introduce devm_platform_ioremap_resource_byname() to simplify
resource retrieval and mapping.This new function consolidates
platform_get_resource_byname() and devm_ioremap_resource() into a single
call, improving code readability and reducing API call overhead.

Signed-off-by: Xie Ludan <xie.ludan@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pci/controller/dwc/pcie-al.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 643115f74092..f0613d442578 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -353,9 +353,7 @@ static int al_pcie_probe(struct platform_device *pdev)
 	}
 	al_pcie->ecam_size = resource_size(ecam_res);

-	controller_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						      "controller");
-	al_pcie->controller_base = devm_ioremap_resource(dev, controller_res);
+	al_pcie->controller_base = devm_platform_ioremap_resource_byname(pdev, "controller");
 	if (IS_ERR(al_pcie->controller_base)) {
 		dev_err(dev, "couldn't remap controller base %pR\n",
 			controller_res);
-- 
2.25.1

