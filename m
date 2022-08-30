Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627CF5A6C40
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH3SdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiH3SdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 14:33:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DE6D56E;
        Tue, 30 Aug 2022 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884380; x=1693420380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XXGsy3iHg2TGWxhTSUsEXSInjBFqhM73CeJFq+RRHnI=;
  b=D491yvbJBVAKmD2w2RRpDOrwBDE3synaWHE3T6K4szirt7xagndnB/wH
   lwDLlvTzspn0O7vhqv4idEJG3tnQCNNZdmVGzOJk9cJd8Ccrp8iDvEgmp
   +a5OkuSxCv6icOTDttnP6QV1/9dkCnusodFqv4pyQzk/ZeWixhM+Q3o3O
   QSHGRFxN6Rdf2LhdPf/AVO1z0N48mG9m801L6Pg3nm9TQyM/71roj1p3F
   Z/4pFHouCFJwiHORM/k5U0umiySo3ueurvpTxaAbgI2dXT4J/4W5s7yqH
   rRqgcPrjlHO69weWeOnkqY5LADjMHjpApUIPMN0qkIT+jzVNEIlYJk1YF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282241956"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="282241956"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="701099213"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 11:32:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99E77174; Tue, 30 Aug 2022 21:33:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
Date:   Tue, 30 Aug 2022 21:33:10 +0300
Message-Id: <20220830183310.48541-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As a preparation to unexport of_gpio_named_count(), convert the
driver to use gpiod_count() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 7f67aad71df4..3bde045e20ad 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -366,12 +366,11 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 				      struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	char name[32];
 	int ret, i;
 
 	/* This is an optional property */
-	ret = of_gpio_named_count(np, "hisilicon,clken-gpios");
+	ret = gpiod_count(dev, "hisilicon,clken");
 	if (ret < 0)
 		return 0;
 
-- 
2.35.1

