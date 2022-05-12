Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEF524AA1
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiELKqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbiELKp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:45:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75541FC
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a30so5943317ljq.9
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jeln1nOqXOPHjmOSrY41I26DIC8s/tVd6G1obr/WMTM=;
        b=oXPq4+GNjNB1uGrrgmDb8ExERwC3HCRw6gLj9YHXPzORViziKlblYKiZ6kcnUxvPyM
         OGWq4pksrBbo3Y7Q8Gxrd+PxnKpHOcOHKuzfwaiSbi7ueBcsCBx/6+xWUEC6lflWdQfV
         tL0x7DPCGcRjBCaQ9Q4jEWKW2wJHrxx90diFhfQLjEnvs4Jt2r6fhoZrd/0aUaR+ZTnf
         ugM1HB3PbLAsiqe8nyQg/uMgtybsexYLMYlC6Ts41bSzwysfscjYg+ACO9BNQqyskAl+
         QiqHphLd0Xo8Fnitt71NQf/xW7JSxVccI0gPzLBH4FFY05XWdjfrwo03cE24UFxkvEb7
         OWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jeln1nOqXOPHjmOSrY41I26DIC8s/tVd6G1obr/WMTM=;
        b=y/72TnuWV0tpusgwzlLmZPT/VZqUsTycS4+Rw/T1Jsrk/RVfqo0g7KemNqIV65LJ5w
         Io2ArGr+WrjxS8OJAgvHB6whqUBFUqWMGvJrCctAgojoSkVS3Q6BNOrfp5BcwHdppmZZ
         QEBrgOhWaYFCFqkoF2LZkLJXYKBhR52QP/cztalkacV2DbkCDZfBIbIjXToKmaaSgjzH
         47jMutABGXpWT/ml1sSqjfGzIdCDZ0MLCdJPtVWVnE2GpYpuFxmyi9zUOYPzRhuyitzF
         QwM3i/d0IqNPEiuwEFRJ9LfWRYuxVETiKKWx7fiEYBb1KEec01hYohEUsVDbH294Y/a/
         WLQg==
X-Gm-Message-State: AOAM530/qPUX06xd/83cWcUUNgwpXroK8m1hpzTNwaWpJ9A4y3zZ4snl
        OKlJDf8ui23Q+/qLobeC/2LftQ==
X-Google-Smtp-Source: ABdhPJxXikjeVPboDIIBrn72WCq9cJP6c6BxGGTXTbutQZEfAimtfF+sRk4/rsaLV++VYGP+QyHWwA==
X-Received: by 2002:a2e:2f18:0:b0:24f:3a5f:1205 with SMTP id v24-20020a2e2f18000000b0024f3a5f1205mr20847804ljv.485.1652352349624;
        Thu, 12 May 2022 03:45:49 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b0024f3d1daeafsm831660lji.55.2022.05.12.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:45:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 04/10] PCI: dwc: Propagate error from dma_mapping_error()
Date:   Thu, 12 May 2022 13:45:39 +0300
Message-Id: <20220512104545.2204523-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If dma mapping fails, dma_mapping_error() will return an error.
Propagate it to the dw_pcie_host_init() return value rather than
incorrectly returning 0 in this case.

Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0d4f35c7560e..5f6590929319 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -402,8 +402,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						      sizeof(pp->msi_msg),
 						      DMA_FROM_DEVICE,
 						      DMA_ATTR_SKIP_CPU_SYNC);
-			if (dma_mapping_error(pci->dev, pp->msi_data)) {
-				dev_err(pci->dev, "Failed to map MSI data\n");
+			ret = dma_mapping_error(pci->dev, pp->msi_data);
+			if (ret) {
+				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
 				pp->msi_data = 0;
 				goto err_free_msi;
 			}
-- 
2.35.1

