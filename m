Return-Path: <linux-pci+bounces-25217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE32A79D36
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3AD1897434
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86C241670;
	Thu,  3 Apr 2025 07:43:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7F1CD1E1;
	Thu,  3 Apr 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666221; cv=none; b=XLL2oEtIBXnq1mB5X8G5Wgoxh+VTqp/AHyKY5xYZe3KrLaEQ6ECqCeAbqvNCPfSIgXqFB/oro95VMWW1NfpvIJe7NjFlYTzPtS4kwZu6F7pJ4jSrGdz+zsp4ajjx5VtNJt3AxzH7fNVO8YOfXz38l2cwBTcsBO/BK2+HA3Yp/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666221; c=relaxed/simple;
	bh=WD1TwJfSnJZyF+/epWcbS06+blHm8ZwXsxzo9muDIWg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=gw7Jr6IsOSxueogAk3QrO9n3TZeTTACFljHVKtOO+Af3mtzgAOiL5B5oLojn9CJyibw+zjy39uQcKmPDjmOtMkkzRkVlh9Ipg2ygZ+mzFXfjwBF9CYdVcob9w1JeUVMsfug8+3ou1EaLo7uFfWz9DUMYBEe52GjCbs6bDsgKOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZStyY3n7Wz4xfxL;
	Thu,  3 Apr 2025 15:43:33 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5337hNMG078468;
	Thu, 3 Apr 2025 15:43:23 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 15:43:26 +0800 (CST)
Date: Thu, 3 Apr 2025 15:43:26 +0800 (CST)
X-Zmail-TransId: 2afb67ee3c1effffffffc6e-36053
X-Mailer: Zmail v1.0
Message-ID: <20250403154326411S4luMrK8A5RXovincATzF@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <shawn.lin@rock-chips.com>
Cc: <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zhang.enpei@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkcml2ZXJzOiBwY2k6IGNvbnRyb2xsZXI6IHBjaWUtcm9ja2NoaXA6IFVzZSBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5337hNMG078468
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE3C25.001/4ZStyY3n7Wz4xfxL

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/pci/controller/pcie-rockchip.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..9897824a81f8 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -230,12 +230,9 @@ int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 		phy = devm_of_phy_get(dev, dev->of_node, name);
 		kfree(name);

-		if (IS_ERR(phy)) {
-			if (PTR_ERR(phy) != -EPROBE_DEFER)
-				dev_err(dev, "missing phy for lane %d: %ld\n",
-					i, PTR_ERR(phy));
-			return PTR_ERR(phy);
-		}
+		if (IS_ERR(phy))
+			return dev_err_probe(dev, PTR_ERR(phy),
+					     "missing phy for lane %d\n", i);

 		rockchip->phys[i] = phy;
 	}
-- 
2.25.1

