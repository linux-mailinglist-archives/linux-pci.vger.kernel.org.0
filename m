Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C15A0E76
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiHYKuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiHYKux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:50:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EFA50F1
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m5so17023450lfj.4
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IWHTArq3vRBlmdLvVJMzGTqkwtxMTZUwrKob6RcAf+o=;
        b=oDV1kIFXY4I9IfHMKNJQQGZbawaB20FTpPwRAsns7HHxewty/PNTm0hgd5gOtXsvJg
         ywabHbfbPe5eBDkSRgQKuhojcbd1brbNbGNa4XHMb3OpJ4AfRvqf4kAfD0a1SODvzQvu
         0awQe31n/AV5APAp41JbR7m1gUV8WQqX4sFSUEu702BfeuJLx19JSOuKk9N64XD+oe16
         H6S/19QzVBM52ufggeOHbvAO0gBa+Ct9i1xAH5PGS0RBffRP/KNMDIYAPdelMAPR626x
         f5R9+Fbrrc2xfwYzYkEWEooebpyeYrtweMJu2KDHuLm3WU//n/zY4bastQ6Wgw9qR715
         MJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IWHTArq3vRBlmdLvVJMzGTqkwtxMTZUwrKob6RcAf+o=;
        b=N3tGZp9BNT2XRkduLLXamICAjUJef8WukHxPtdHj+x4sTRigM7Jjq/PvxooBr9ErwD
         H78XxG5pwC7cPqhBJG21KJsckcg/iBqhtjm3hh7buq5Yf5hAy+crZVg9xFFsAz0eOEUJ
         rI/u6lIpeXi4GGtUwE0oCnNr5cfCZvIiGf8agsxmMcrgnuEp6RvGgsOyS2B9TPGsuvwZ
         5t7dFwHFZrwjl0Cb03Dtwr6hcCPgM/8bcf8TGsiXhePh4Y/A2j53rIPFZBzZmuSPT34H
         sogJgSktQvD446o4Vf0uz+BCRkjTyskBpaaIV0UuS4WJBYYEXhNRA7yOxtDcXqYEzKAF
         pMhQ==
X-Gm-Message-State: ACgBeo3nmDgN04M7SYLodocEez+c3zif6/qOMlT12A52N9AuXDZz8Hes
        ngz77ahS44wehcgATGoeDjiceg==
X-Google-Smtp-Source: AA6agR7q6//i+gNOOwDvQNqXYOgFBvzTj4hj6GobSNlranN5aGJXK6M3Qbg2/BtpK/NHGHnUkUtehw==
X-Received: by 2002:a05:6512:3f01:b0:491:9b9f:a54a with SMTP id y1-20020a0565123f0100b004919b9fa54amr1030032lfa.160.1661424650970;
        Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00492f49037dfsm429609lfo.152.2022.08.25.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:50:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/6] PCI: qcom-ep: Setup PHY to work in EP mode
Date:   Thu, 25 Aug 2022 13:50:43 +0300
Message-Id: <20220825105044.636209-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the EP mode.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ec99116ad05c..d17b255a909d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -240,6 +240,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_disable_clk;
 
+	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, 1);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = phy_power_on(pcie_ep->phy);
 	if (ret)
 		goto err_phy_exit;
-- 
2.35.1

