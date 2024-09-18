Return-Path: <linux-pci+bounces-13273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCD97B8AE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDC2839CB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C75175D32;
	Wed, 18 Sep 2024 07:45:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7F173347;
	Wed, 18 Sep 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645549; cv=none; b=lS96WGPyvZTTaYOD0UDuAJCl7moDxbr2/YCmvAKOt1tnqCkDJ/cPxRHFNo91sTzTzP5Fnt6BuwrmVSIczjVANaH3bt0NzbWKmCqlIhZv0UNnZZMC5Ev8h8gVW/ktKyejHDdonDYe5qRZuVENT1ljeHJWPpZMW8NBirISEp0d5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645549; c=relaxed/simple;
	bh=F4d7DGoY7oLwoq+KRQNfhkdDARMVIrtWh1tpQuw6P54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKwaIkddIrWtGDAZK6UlVPc2HZAdPj1ZLd1QImE+mUmJASu9K5wZDTfm0mQg+26tnM0cQtBGt5ACFOATe9HGoiARWsIQxkGcMLd0daPjoeobrJ95bmPCMwtZH1o1sOh3lTQSbLjHbL2SWR2nDtxyEh5P8sm5Zs6ZJqK9BZkYxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAnLqIOhepmIlxgBA--.15444S2;
	Wed, 18 Sep 2024 15:45:19 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	cassel@kernel.org,
	ukleinek@debian.org,
	dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Date: Wed, 18 Sep 2024 15:44:01 +0800
Message-Id: <20240918074401.2221146-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnLqIOhepmIlxgBA--.15444S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur17Zr13CFy8Ary5JFW5Wrg_yoWDCrbE9r
	1DuF47urW8Cr9Ikwn2yw43AF98A3ZFgr1jgay0qF9IvFyxJ34UXr97XFn8ZF48Cr1akr97
	Gryv9r48Ca43AjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8Cw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRmjgcUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

There is no need to call the dev_err() function directly to print a
custom message when handling an error from platform_get_irq_byname()
function as it is going to display an appropriate error message in case
of a failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1170e1107508..3770e566b597 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -450,10 +450,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return -ENODEV;
 
 	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					rockchip_pcie_ep_sys_irq_thread,
-- 
2.25.1


