Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646A58F26D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiHJSf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiHJSfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 14:35:51 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C84F1AB
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 196-20020a6301cd000000b0041b0f053fd1so5965192pgb.6
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=StV40VjCzIbs0ONKjYL2l7pJgoeJUydvC6NjtajotZM=;
        b=TR2sVuwAFo5AhL42uNDy55fzgvtI1X0HYToqFodl8b4HADyhB+NrTON+kGuUDlJQYy
         LNm8U/xv49HkfejxEiK1ITOeKtXfpbNxrVJxsCMA8EBgnSibCtvxJlf7YIb36PbYwDqv
         3AaZJvVwNmuQTW+h222Tpyc5MEtA3RpmEJPGBMQVxumH0IlOdRPRGG2ZcSfHDyTJ585x
         hzOkft2/U3k1srnhMDrW5upfvxZkQuJwqs2i5YJfu6EL/pRwvsYJsx9X1m+2of0ZassS
         bIrMr3UlCEDgXJONNB4qSSJzPYfBPlP6//fPPkNGqC/kgsrgOYlKBO6fKN60Yzoumu5Y
         2xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=StV40VjCzIbs0ONKjYL2l7pJgoeJUydvC6NjtajotZM=;
        b=iRJwp4dZNcwVJQhAFOLyTNKOw3YWUM8++AC5Z77naKSqAnouG2TmMHrN0RMnStB44r
         fXpP9KXyUCIAfOFok2hH20ETK597FTM60yj2O6tOayEWAvQtCbC7MIxc+tmPOh7BphK7
         p0mTNO1nTR4aOoCsyBcTedK1yMPYssrZMWX3J9RsVOuLeHJ94Bv0E1C/NWf1k+NnQOmq
         raTVH2rcYW6SLnx9/mmFAuX2Fx0u5ON3xn/f6GNq+l7Ul9dVSU42bqXfF9bp0ggn2aMy
         9Ev5E5an1njR0saIVr2oqHTa2ZJPysgjZO3/l+bDHEUoAn2UhStxoOMpP09zPsmvEfXC
         gqZw==
X-Gm-Message-State: ACgBeo1X4qD74VTZTNcFxsW/6p7aMkFnasNkbkOGsPGXRERHSHGtmXTS
        kuYg9RQvk5t0dKMutoILDvGdbkJdcuriPV9sSQw=
X-Google-Smtp-Source: AA6agR6l7NljeD7dazk/n6QicN0MZ8KfMR4WFppBfLuOpPBC8NjVf0HWlA34iD+MLsLCNlhmPyP75F72gs62DN568uk=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a63:1648:0:b0:41a:49f9:77ae with SMTP
 id 8-20020a631648000000b0041a49f977aemr23985662pgw.377.1660156549486; Wed, 10
 Aug 2022 11:35:49 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:35:34 +0000
In-Reply-To: <20220810183536.1630940-1-willmcvicker@google.com>
Message-Id: <20220810183536.1630940-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220810183536.1630940-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 1/2] PCI: dwc: drop dependency on ZONE_DMA32
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
which uses the coherent DMA mask to try and return an allocation within
the DMA mask limits. This allows kernel configurations that disable
ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
the PCIe host device will fail to probe when ZONE_DMA32 is disabled.

Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7746f94a715f..8f2222f51671 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -272,9 +272,9 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 		struct device *dev = pci->dev;
 
-		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
-		if (pp->msi_page)
-			__free_page(pp->msi_page);
+		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);
+		pp->msi_data = 0;
+		pp->msi_page = NULL;
 	}
 }
 
@@ -375,22 +375,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-	pp->msi_page = alloc_page(GFP_DMA32);
-	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
-				    PAGE_SIZE, DMA_FROM_DEVICE);
-	ret = dma_mapping_error(dev, pp->msi_data);
-	if (ret) {
-		dev_err(pci->dev, "Failed to map MSI data\n");
-		__free_page(pp->msi_page);
-		pp->msi_page = NULL;
+	pp->msi_page = dma_alloc_coherent(dev, PAGE_SIZE, &pp->msi_data,
+					  GFP_KERNEL);
+	if (!pp->msi_page) {
+		dev_err(dev, "Failed to alloc and map MSI data\n");
 		pp->msi_data = 0;
 		dw_pcie_free_msi(pp);
-
-		return ret;
+		return -ENOMEM;
 	}
 
 	return 0;
-- 
2.37.1.559.g78731f0fdb-goog

