Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3162581B1F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 22:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiGZUeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiGZUeK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 16:34:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8509232ED8
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 13:34:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so16790403lfd.9
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWHTArq3vRBlmdLvVJMzGTqkwtxMTZUwrKob6RcAf+o=;
        b=qiv/9bpib4HrEbQrvHC7aijDxAAo/UjSrBjFA8hKinrLrL9jE2a+gFDPWQq1IE4Okg
         js+UCpu2mvHuxRPgiashEQKidrsBfXLWHqoJ/Yj1tBYMRDHrQX99wIMO+1puR5j++fhX
         bLXE4OtWqZ0ky8zsASSBcc7wdcgsbnBzcOig80xNuRRGu+3LpQEnIcnQNiqp+FdpP/6C
         3zVjCK2vO34K8ZEaNkXGxd0rkgpUFyUrjuBcx8vEZ2+KuIMMXBS712UzdBUlJOL9Qsiq
         MRj7FAVn+Jv7P8aIrurrfpubBEXxbg1dX3WUXiGx6hVLUDd15mpB6VvVIoyE4r4ov971
         s0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWHTArq3vRBlmdLvVJMzGTqkwtxMTZUwrKob6RcAf+o=;
        b=hYsk85rLFEq93Q7Kv0CvpufsYlaZa4ElRq6Om3blqcP5gA6/4Hk7TnIaTtxW11Urw6
         7vTPxxFLYySV2a7Fy1jLoljiBmzAmDVQaVt/U4OuCiSFNGDyLDCpkjGuwuHfrI3gRT+E
         ln8D4nad+f3HaA6VLnWJ+clvxyQZ/7AjtvjZQF9VPJ6BWzJ8uf2EtN/WqMBfljFczgsN
         6xg0i1IjkYRxup4w50ELfx28Xz++8hl8jy5/xumW/f5UQUGog8krfEYgV64wOPVxWYuS
         rvSFxJtqRCjsHQG11jORJQIvzcWmIvgwCwa3NeLZe5U9irtGHSWRqOPi2QrLIXUbzEQm
         CB8w==
X-Gm-Message-State: AJIora/YhuDGDyluMt301XTeLsC6JbsBTHk7Krn67dWrq1S61/nPp3Lk
        gH0p2SsmfDwK7a+AkUrg30+l8A==
X-Google-Smtp-Source: AGRyM1tnZQNfL6elldk9osbjUkMufj1KK0faPCIo8ly17ucAPQpBNt5SR9VErOUFxovgFAWYyPRP9w==
X-Received: by 2002:a05:6512:6d3:b0:48a:1219:ae12 with SMTP id u19-20020a05651206d300b0048a1219ae12mr6637437lff.623.1658867646763;
        Tue, 26 Jul 2022 13:34:06 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o14-20020ac24e8e000000b0048a8899db0fsm1468548lfr.7.2022.07.26.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:34:06 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH v1 4/4] PCI: qcom-ep: Setup PHY to work in EP mode
Date:   Tue, 26 Jul 2022 23:34:01 +0300
Message-Id: <20220726203401.595934-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
References: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

