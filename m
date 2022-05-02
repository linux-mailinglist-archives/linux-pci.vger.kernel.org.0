Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA6516E4A
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiEBKqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 06:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384678AbiEBKqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 06:46:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC91D0D2
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 03:42:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x33so24592011lfu.1
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJW2hpX0jDXzFSio868cnZYVwu80EHBYg4jMatUzfuo=;
        b=H0lDuGWxfOP2AzWshD1t3hIT54ArwKdHMwwIH0aEvePpuw1tyEgIVWneFG6ipMo3oR
         oOWmxaBqh40ckpKhnMUqBkWG9N1QNb5X6QysDvnKjWCsKAPhU102olPSxYREqaV2GVko
         ZAcaCokSB0sxgrWDAjLjUW5Ft1SEXmXGQQd06Pz6L5Dcpb8zHZaKZkt7PZpnKFuEtKG5
         iRVAGDYHaefsn1A8cNCWBrmsDtKl+wNkRMbOZObbUBJb4a5NT+mgTEdPhADD0o6BmH22
         2teumeELF2eeF+0V98AUikaTZFyPfvEzs1lUhIo2XJcl9w1coq7Lj2hmhJyJNGbhaepc
         vmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJW2hpX0jDXzFSio868cnZYVwu80EHBYg4jMatUzfuo=;
        b=dDeKDiaDjGZsyy6qFDBcOtAxMbch/DZzM6nwJknuCm7umIWHAjW9oOAz8VrORB64c3
         EAb42rKL3ASNnEa2cE03N1IERJwBLOBmm+7ipx/mwIGtW/q7xc1KIAfvmzUzHFc8HKOy
         A/Rq1BpMOmTdB9EpNtF3WICKbD466CakIQ0aiGNyGTtDcV9mnt6cuLEpeldPyWPdgSAP
         JMoTxJ1bKoZpW5wenwSfBP1s+rZrojFRX4c7ZnipBA+DOMMWaErh2NNMcV0iw7AhAI2s
         llVS9WUzfde1ivC3W4RQvVA16lSATHIGhQT7lck9z1av8c1drJs1lYBWCMWliZYz/1BC
         QlqQ==
X-Gm-Message-State: AOAM5320CuQCyGiYkrQSETARFqfzIgCEz9Ac3zq/i9ycF4yYdbgDTwfr
        PlPx6xG6F+RxPDd/vI1b0GiVJA==
X-Google-Smtp-Source: ABdhPJwhS9zpzLBSwfTZ54BY2m//olODt6cmW03GY4OQEa2073XfSdto2TGmuUAYeO8WFx8PeClbpg==
X-Received: by 2002:ac2:4250:0:b0:44a:ff88:3795 with SMTP id m16-20020ac24250000000b0044aff883795mr8649215lfl.384.1651488171034;
        Mon, 02 May 2022 03:42:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b0047255d211dfsm670929lfn.270.2022.05.02.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:42:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom-ep: use qcom_pcie_disable_resources() in qcom_pcie_ep_remove()
Date:   Mon,  2 May 2022 13:42:50 +0300
Message-Id: <20220502104250.73311-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502044625.25210-1-manivannan.sadhasivam@linaro.org>
References: <20220502044625.25210-1-manivannan.sadhasivam@linaro.org>
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

Remove code duplication between qcom_pcie_disable_resources() and
qcom_pcie_ep_remove().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Could you please squash the following patch and repost it?

---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 80a9acf683ba..11f40a6467ba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -689,10 +689,7 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return 0;
 }
-- 
2.35.1

