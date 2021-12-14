Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA2474E46
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhLNW67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhLNW66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:58:58 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF20C06173F
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 13so30481548ljj.11
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Gomy4ei7qSbDbo9NwD3wFRtHE34eVnEHILbspr7bME=;
        b=Z3VWMAewwvLv+zL0H226NTFNhnnM4GNVE5NoZlH+wpu4OPMo10OiKy1gcgQjntJoUU
         SuJVl1qRWnKBI3ODoChCoLWwT3UQAQZOVvDTKIKtJGWGadCX3Tg44S0WFxObpzdMXMSl
         vYpRETIGN6mz0PD5p3bn38aQj3UuXOWWtK4e53HBYzlLIdNUDamZ1SeGRYV1b8g691of
         9ikCHKiDgYBOv9sNov5jdC5lGLLuFHw083XLP65mDUsv+INJC8U/IngDRMV4fuHiSyBk
         hpmuBFVnNRa5ER9GHZNW8q2XQeHu9tT/HhO8xQqcGmTHvnbgQQ929rF7dKsD39/u0RSA
         76ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Gomy4ei7qSbDbo9NwD3wFRtHE34eVnEHILbspr7bME=;
        b=jzk3i4E0vbIWDOF4uai+sngGm36cV5Hmyb6HGTF0yPiw4IjaWsHnoWLIyNsS+t5m7m
         ZBho90QRHH9gUMWMqw8AvI0fr4xT6eyYBzlDTmuXCr4IB64NpDkfBUMjQsIEoXe7Japn
         fVkJ7Fo5bfF2Pu6KGl6RHAPxcc+UzHdOijL1ed+3HgsMbC7b6jP4ZFeYc/KKDJg0Jb8M
         06jVIP197UmRNa0zMotzUxkbfTUy/PDqiFBwW+FlOJy/W9xptW/q6Qn63sbopWaXfug9
         VXJDziU8f5f863XcEufJGhVv4xWKqLADVVvF4Vyc/5Qwbtrb7wOOoXGkY3NbknxoMN6I
         flUg==
X-Gm-Message-State: AOAM532mRj8L96iDoo8P1+cA8eOdbsTxr3iibu8sltBE/g9EiJEdkRfu
        Ut15iXTDeZtSvNQTbczLaxVJzA==
X-Google-Smtp-Source: ABdhPJzkX8S9auCejbfr9NolWxTiJ0jAaRfO+D1Ny8lCmFVFFuJBF7RlJtrhw/4VH+8ubGp9JMRbsQ==
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr7603572ljg.8.1639522736348;
        Tue, 14 Dec 2021 14:58:56 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:58:55 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 02/10] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
Date:   Wed, 15 Dec 2021 01:58:38 +0300
Message-Id: <20211214225846.2043361-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two different PCIe PHYs on SM8450, one having one lane and
another with two lanes. Add DT bindings for the first one. Support for
second PCIe host and PHY will be submitted separately.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index c59bbca9a900..d18075cb2b5d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -50,6 +50,7 @@ properties:
       - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
+      - qcom,sm8450-qmp-gen3x1-pcie-phy
       - qcom,sm8450-qmp-ufs-phy
       - qcom,sdx55-qmp-pcie-phy
       - qcom,sdx55-qmp-usb3-uni-phy
@@ -333,6 +334,7 @@ allOf:
               - qcom,sm8250-qmp-gen3x1-pcie-phy
               - qcom,sm8250-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-modem-pcie-phy
+              - qcom,sm8450-qmp-gen3x1-pcie-phy
     then:
       properties:
         clocks:
-- 
2.33.0

