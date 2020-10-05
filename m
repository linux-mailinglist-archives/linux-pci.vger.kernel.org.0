Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D32832DD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJEJNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgJEJNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:13:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE78C0613A9
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:13:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x2so5202996pjk.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZdgKLe65/5ZTL18bHaqdAUbi1xJI+QzTIn6dSNFRMgI=;
        b=f2t7lvS24tVVJqV0MihUDCs6DheTIibTnFv4yiwHRgZ+a3IhrmApWH1UjwOtYmo+Zq
         iJyenEUida+a/FcajZHjmLQIRuLWIIoW4uACNRRgjS9xZc5vxBR3GupWrlFC7729Mdn/
         J1kO2rfmLixioBgWpaUBMquHHI9kXU5LoI9GT3RLeN+6dSpWrWI7w694ptfftLKggSn3
         CsFxaK7A52rBH8lLlWeeSoptqZqGLERyX8SNhrDZovlcCCJen6IKBNKbXSlgCL7C2UQR
         P9Da6vLSe3QfpEDRZgZX2HeguPL1EiG5xkuIOROilkD/X0ti364DlsXmLbjOYH85NZaQ
         O9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZdgKLe65/5ZTL18bHaqdAUbi1xJI+QzTIn6dSNFRMgI=;
        b=aXirltR8IL3EewQ5o2s6yWwv4X4ne6coReD2GP5L2dD+POFPcfbWXy+OuO26fA+NmX
         W4ZMNKtswtPLsuEyQz4PYLAiWgH1GSBFFYrV1xAHUHRTMl6Oaudbr2MViNdfmPXBvl5S
         viQL5F+pUP2C5mxBgv2okPq70WxmKwmw2Tqf9pRbL5zZry7mmHuMnC7G7x6c1PmZutuM
         x+4fAI/SGoMN064c9+oqfAJ1+y2vpfOX3WiQxJHGn4VyukPSIowrGa3OgNiZxGsInROz
         ipdwO9nCma4aoKx1/z8pwpMBOqTbYoCHSc5LydVCTrU5S3BQagkTK+JfEa09haVU1RH5
         4KWQ==
X-Gm-Message-State: AOAM530PiiN5qutu9TzgAq8+W//uIhNcq9ZRSwRnt97CVgyShnvfVx+A
        NVZum3uVjcxqi862/P10iua2
X-Google-Smtp-Source: ABdhPJzcTUOR6tchxr55/BxMSt6DwR7qE9UW+un6FEMV2klT6SlE1ubT8J+7qr+yWq5KmhRsSeUy9A==
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr15596914pjb.93.1601889187120;
        Mon, 05 Oct 2020 02:13:07 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id c7sm11255028pfj.84.2020.10.05.02.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:13:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
Date:   Mon,  5 Oct 2020 14:42:32 +0530
Message-Id: <20201005091236.31770-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
References: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the below three PCIe PHYs found in SM8250 to the QMP binding:

QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes
QMP Modem PHY - 2 lanes

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 185cdea9cf81..ec05db374645 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -31,6 +31,9 @@ properties:
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8250-qmp-ufs-phy
+      - qcom,sm8250-qmp-gen3x1-pcie-phy
+      - qcom,sm8250-qmp-gen3x2-pcie-phy
+      - qcom,sm8250-qmp-modem-pcie-phy
 
   reg:
     items:
@@ -259,6 +262,9 @@ allOf:
             enum:
               - qcom,sdm845-qhp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy
+              - qcom,sm8250-qmp-gen3x1-pcie-phy
+              - qcom,sm8250-qmp-gen3x2-pcie-phy
+              - qcom,sm8250-qmp-modem-pcie-phy
     then:
       properties:
         clocks:
-- 
2.17.1

