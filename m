Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE46B89D8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 05:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCNErV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 00:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCNErM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 00:47:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742094388
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso13911505pjs.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG6X0V5nxXAs/7mwFsePGG2/rhZWHmM/NsTiFkA/mm8=;
        b=A/G8tI3v0j1rlyEl0eaG32lsjFEdk1zArRvol3guPW7i0h9EOjCk00P7X/LsJ2YK8l
         uTqzNwCuAWKeabTDbjlaudLGKlwvVPt0uBFsh6ijip4jsSfQu99w+EKxcAcZ5wlprSoN
         JqK+zY3i/cCv93euqmx4wiDeiGEQQg89YGE+qQMHMZQAr/rK4gAPhicIxXy2MesqYllj
         XVJbJMnDakXv0ZShVsTTAtJqwjHbGFu63JypBaBPJV97ZjgcMqEJhOt9/iN66YDYoyIH
         LluzbtIpnsLOEvSK7Mgvcn8Gt9aEPK/Kh6GiQOpEtn+cEaNe00GOu3alKuiOtY0Rinxp
         MdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG6X0V5nxXAs/7mwFsePGG2/rhZWHmM/NsTiFkA/mm8=;
        b=F1QpkMD8dVxk1cdiFl+niGPPUCtn8bop8tA0VpL73/CrxtwOpZgHOWCv5Fi5jRcBhB
         Knzbdn7yLu67EHIaKYlurWKBNMOKIP6GjiiZmWvSOiEI+zfW6Ec06lJWTTr6MjRkZU+s
         TNqLXX88gnsMRpU+vJbI3sgwfQjOsVJsa6SwI6OHsfAK3lnq5yrxbdNHq57Q832xnJbs
         xxWTonc5KD0UbbDyM4f+NrvkSMNTt9Yx+WqzVrfL+hnWMrzqSLwUpYOnLluUxwupmJ3S
         EZeT38TEmQRw2LbYrv67v0zQ8Q5Aya2I2nqSaiiqyAolkwCFt7WaVqKdGcbFABEKjyPx
         H8UQ==
X-Gm-Message-State: AO0yUKVHFT81hnBdZZOD0PvF+5csn8UrTkcW9A3HSLze1JFiSR8Nysjt
        kkVY3iExxamokVbvNbF1IfG1
X-Google-Smtp-Source: AK7set8OSV63BSA+E/ttn2ZwcEN3OhSt6DhmT5RebmOqiHBxl90RJMKB+EYqEKBgMpDqcFtVZYo/Kw==
X-Received: by 2002:a17:903:1205:b0:19e:dc0e:1269 with SMTP id l5-20020a170903120500b0019edc0e1269mr27282300plh.7.1678769212290;
        Mon, 13 Mar 2023 21:46:52 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/7] PCI: qcom-ep: Add support for BME notification
Date:   Tue, 14 Mar 2023 10:16:22 +0530
Message-Id: <20230314044623.10254-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass BME (Bus Master Enable) notification to Endpoint
function driver so that the BME event can be processed by the function.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 4ce01ff7527c..1435f516d3f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -573,6 +573,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.25.1

