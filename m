Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0752A20A
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbiEQMwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346472AbiEQMvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:51:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C35848319;
        Tue, 17 May 2022 05:51:50 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 34E81BDE;
        Tue, 17 May 2022 15:52:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 34E81BDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652791966;
        bh=HZHoV9nR2DIKYsbB+TvwdZXcaoF4FGsdbHzcXXADxzY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fuTlpm6+qjpTzy6X/gRzVwfBT7mXwOgMveNtpLauN9jmBAFtTW7x0G655OdJ0rNqs
         6QmJWGi43OLn7HuFLK7gbc86TMIp9f0mSVZl5YO8ae2P1OAlf7Xp7kESzi65uDZAnn
         fIyz9Vfrm+2mWWKMvIFVU5FrPOcF73th6I8iUORg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 May 2022 15:51:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 13/13] PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
Date:   Tue, 17 May 2022 15:50:58 +0300
Message-ID: <20220517125058.18488-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The denoted forward declaration used to be required to get the OF-device
ID structure by calling the of_match_device() method. The later method
invocation has been replaced with the of_device_get_match_data() call in
the commit 5c204204cf24 ("PCI: designware-plat: Prefer
of_device_get_match_data()"). Thus the forward declaration of the
OF-compatible device strings no longer needed. Drop it for good.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 99cf2ac5b0ba..e606c5d5f06f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -29,8 +29,6 @@ struct dw_plat_pcie_of_data {
 	enum dw_pcie_device_mode	mode;
 };
 
-static const struct of_device_id dw_plat_pcie_of_match[];
-
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 };
 
-- 
2.35.1

