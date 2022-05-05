Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC751C188
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380123AbiEEN55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380164AbiEEN5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 09:57:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6657B03
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 06:54:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 17so5703749lji.1
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fpTEUNCvgnc9AMwKVJD3wLMKlj8TQ48QZUL6p2NQR8=;
        b=mfaEKuq2amzs3YVCEviUXEYTlhxwyCvstORZ8MJcOJkfRTiAT+1i16Xtv0QHh0K5E/
         cVYhSpF2741Rqo9oqsyYj2w/lVjLr9kYw1iVXJtiG4IE0Z8FNiYEIJ8x7sy4GfQJm7gr
         xIPGZf1Viht12uv3hayGDwkO3iNiT1lrW0LKGwLBBVpw1pakkBdG/Yi3ZroSHfKaWYoG
         C2c8WVgz7VcY90s3N4OBGDQrNBK924b6SyDC4OD4Pupm7UgLxhY98STIO3WS+DoM4kL0
         /tiqLaJn5/YT1/iuHi6yYY0nZqXftbXrL0ZvsOsbwamiKPGsl+W+5eJ31tWDQFr/Jbws
         HZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fpTEUNCvgnc9AMwKVJD3wLMKlj8TQ48QZUL6p2NQR8=;
        b=acka/zYMEwK5vWueusKnKiXQg9pdDqmgiIN/V1zPo0L7VtcyXICiybvZl/X06aI0rM
         GC4bjdk+tLXduqgkVPglPmMJVTN2+q9STN5e1daliaUkPbG3z9Y/H1q0y/fIqA5AYBly
         eNSmkN3Bd/iE0am9qo3qW8ag4WMnth8AC140VE8ungebzGoomf40/9oGNhWYH33Uix6T
         mCu2pvUL/FvbQtIrCzvla+OEnjZeHzKU3KnCVE7a1pFhIEkWxfqWpWSsv8aXSJ8jPY5j
         RgooNxpI9Hua5UCINHR8PZL2x6JtyDuAqPh1kNyMyA5W36x3UFlM+gRWDAO2vn3DNjOd
         Hnng==
X-Gm-Message-State: AOAM533CTZ56xLGumSf63q85My/u6BdtJO+ePc/XyB0tlG6JAP8FMMjw
        sT4HuYsrsaF2n4CHdBeJFWPG+A==
X-Google-Smtp-Source: ABdhPJx7HdTwgZd0KGReZXNkSu9uCoJSzSO9byK56YL9zFRAzM6/ixmMqCYxbN+NpD7QenmeUpdxhQ==
X-Received: by 2002:a2e:94c9:0:b0:24a:fe13:ce04 with SMTP id r9-20020a2e94c9000000b0024afe13ce04mr16853973ljh.52.1651758850382;
        Thu, 05 May 2022 06:54:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020ac25df8000000b0047255d211ccsm221788lfq.251.2022.05.05.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:54:10 -0700 (PDT)
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
Subject: [PATCH v7 3/7] PCI: dwc: Add msi_host_deinit callback
Date:   Thu,  5 May 2022 16:54:03 +0300
Message-Id: <20220505135407.1352382-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add msi_host_deinit() callback as a counterpart to msi_host_init(). It
will tear down MSI support in case host has to run host-specific ops.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 43d1d6116007..92dcaeabe2bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -424,7 +424,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		return 0;
 
 err_free_msi:
-	if (pp->has_msi_ctrl)
+	if (pp->ops->msi_host_deinit)
+		pp->ops->msi_host_deinit(pp);
+	else if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 	return ret;
 }
@@ -434,7 +436,9 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 {
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
-	if (pp->has_msi_ctrl)
+	if (pp->ops->msi_host_deinit)
+		pp->ops->msi_host_deinit(pp);
+	else if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..e1c48b71e0d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -175,6 +175,7 @@ enum dw_pcie_device_mode {
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
+	void (*msi_host_deinit)(struct pcie_port *pp);
 };
 
 struct pcie_port {
-- 
2.35.1

