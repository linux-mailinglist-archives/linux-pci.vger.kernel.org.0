Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB684A6775
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 22:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiBAV7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 16:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiBAV7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 16:59:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F266C061714;
        Tue,  1 Feb 2022 13:59:51 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u18so37058078edt.6;
        Tue, 01 Feb 2022 13:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IQ9T9sp72rZCbK23HXVkU74AxMIU+hvKwyjpSG2+kw=;
        b=L7qXpKfkyWz/+3ZQh1rWtKKOYKzRNKtAYJbFgcCSDDNJBhsFtbUlRf3I3BVzCiQNkx
         Krffa4/GqO2m0kAgECPnb6RAWVgU4Ynq+pu0kMsPGN3kuIMKRCamRt0T1gAThLYlerVB
         UL7BKG0NTwu+Ub/KFs7E1JfSRoh3g1zg+IrmmCGyPNoDRvCPeEQ4MADExnu2WBOMM4Os
         h5Uh4Zf18Ruoa8pRf2z07goqZ2ey9G9oHznIRSC3C6aElmcD25boY12wsAcS8DdI53uJ
         QK4cEjURIcF/A7pua9hk9jbUnDRnEHtOcz/3O3OCo+mWyEt8I8ZKi2gqeAp6YSwtW1kf
         yOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+IQ9T9sp72rZCbK23HXVkU74AxMIU+hvKwyjpSG2+kw=;
        b=2JpR3b2xwOTpJj+CwvCAVH4SEjvrmnobFtqwnvVinJUkYzQgRWOsBlzFlK2UbZ+GVS
         f5aBrHmEeGyCBJ8aV27cuzc4+cW05XIrywZKdA8fsSBId6P68xIqrAEoro58PJVtmLgo
         Dhb9BRdH6y6E0NNOGEWgyzhdw4FwNXlYeO8xEYqoZuC4aVPkys2N5i4NucmxGS2jEyA/
         NdNCcPxUyIPHhOe6M7nWKXBADhrmolBRAlMeC7leOzFtUAQf2kbbpskYoq7yH8Vn7pV/
         rSy86prmunG/TG5Qt9D//N1IEZ83GAWW1kfvgegrkEhCDROhXaMLoWVtNUiFJ6FG9opL
         QpUg==
X-Gm-Message-State: AOAM533YIPX01N+zLgfdhkjXtbZIVI9cDiW1Qa7RQ+ryej/5o/pnNBUg
        TCIweF504oirM932zpQGX3IaaBKO0yG97Q==
X-Google-Smtp-Source: ABdhPJxkM3AfJdhK5+xND7KZAdQAPx48JcUh7iGJtGP4lyN0EUqrtEbKHY/+S4MqmzWyRrbvro+RFg==
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr26889279edc.58.1643752790036;
        Tue, 01 Feb 2022 13:59:50 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id g8sm15369073ejt.26.2022.02.01.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:59:49 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH] PCI: kirin: Fix kirin960-pcie probe failure issue
Date:   Tue,  1 Feb 2022 22:59:41 +0100
Message-Id: <20220201215941.1203155-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

of_device_get_match_data() will return 'enum pcie_kirin_phy_type' type
value, and most likely the return value will be PCIE_KIRIN_INTERNAL_PHY == 0.
This will cause the PCI probe to fail. And of_device_get_match_data() does not
require error checking on its return on devicetree based platform.

So,this patch is to remove unnecessary error checking to fix kirin960-pcie
probe failure issue.

Fixes: a622435fbe1a ("PCI: kirin: Prefer of_device_get_match_data()")
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index fa6886d66488..e102aa6efb7f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -781,12 +781,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	phy_type = (long)of_device_get_match_data(dev);
-	if (!phy_type) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
-
+	phy_type = (enum pcie_kirin_phy_type)of_device_get_match_data(dev);
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
-- 
2.25.1

