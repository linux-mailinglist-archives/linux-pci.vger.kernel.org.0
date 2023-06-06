Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7842724173
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjFFL6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjFFL6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 07:58:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AACD10DE
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 04:58:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b04949e5baso52761605ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jun 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686052713; x=1688644713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zml7/O0Lnj0GvJyK92oFTeXRGRkWuEBPtxfKvEIaajI=;
        b=F6U9ovca0MySfgOFXNjUiOvOBBhVdVyMtZ6fJiR23Xn//ED4/OwnPtVbJM9LXqy/VA
         6uv3tDhGAousYkD6jHrKo07rbbo+f4JHqSWyxxl5tiBcitp+I9NyW5TJtipQWJlnCRfc
         UFuCz4HD8H6Cqr+pe5rtrJIZ+zJg3iW1jyvc5rWg2lErYyy0AsROuPP8NUrHnE8c6FeP
         FJQCWsDQR7MJEoaZsUkJderZv2Lv5vCJlG+Lek1H6iUnDBPICPqyLdj/DWGsnWxDWdGo
         iB9rH8GaYqLZcjHhLla1Eh2VJ8y55LJKcHrzpuBP/5LnmdK+cpDeMhESpnQ35chFMYXg
         H/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052713; x=1688644713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zml7/O0Lnj0GvJyK92oFTeXRGRkWuEBPtxfKvEIaajI=;
        b=d8iZfAiX25aPdMD8Gd+iJg6Q+C+iue0q+zNfH9R7qytVqFLNz4pOpeY/nRweHqr+Yf
         1R546i7RXWI86JRd5cc0fRr0WiTFzinkTxRG/WvO6YUMMclmoRuuW2rBeXr0PodRpNZz
         Xjg+4XcDhdDSgcksnndynMhsBu/A+oAZ1QQaNEgnqfbdcgFz9b8oJUI8Z476Oo3qUohr
         7N4hHWizo4b8XTiZHj7mrE94ITHQWcBZPYJ56fChegsL/P3b9kisMJRagFwYP5IdOfCa
         1wHYda0OGalE/MlfKt3Mj70GXqm17kCe7nszSIzEGEYqKOzN4o6mJnO5u2707oQnoyba
         YM7w==
X-Gm-Message-State: AC+VfDwfjpPuB/RUagbubsAG2b/0uS93aQqVFeJ+EdYOTl5uWHOVeUik
        ny3tVIstdp6/GmLzowoBxL1j
X-Google-Smtp-Source: ACHHUZ7jjbioYny5tpMpiu7QQ7ABSf6+m+LQWYVPIWH0hARAsPRMUdjK+4sj/xrWRk0U8NAAofa00g==
X-Received: by 2002:a17:902:f54d:b0:1b0:2390:3674 with SMTP id h13-20020a170902f54d00b001b023903674mr2301432plf.65.1686052713046;
        Tue, 06 Jun 2023 04:58:33 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001acaf7e22bdsm8419226plh.14.2023.06.06.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:58:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/7] PCI: qcom-ep: Pass alignment restriction to the EPF core
Date:   Tue,  6 Jun 2023 17:28:08 +0530
Message-Id: <20230606115814.53319-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
References: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qcom PCIe EP controllers have 4K alignment restriction for the outbound
window address. Hence, pass this info to the EPF core so that the EPF
drivers can make use of this info.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1435f516d3f7..cd378ce58b22 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -706,6 +706,7 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.core_init_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = SZ_4K,
 };
 
 static const struct pci_epc_features *
-- 
2.25.1

