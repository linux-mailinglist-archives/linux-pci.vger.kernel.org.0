Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E2283348
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgJEJcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJEJcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:32:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C7C0613CE
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:32:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g10so3223802pfc.8
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZdgKLe65/5ZTL18bHaqdAUbi1xJI+QzTIn6dSNFRMgI=;
        b=W5FzCTGIcGLLqFmUZM7lpR2LjrhfTnCSTr5TOyFH6idDB0Glqr95RKRAIMFdKZN8Qa
         857kKhSHM+KDGoLceXV0ZxvznQOo57s2W7gaHbn1UozZF125Dc45Ep613XWY30ijcFOx
         iBO03fKsKNqxls1EyrQ4zXWpWWm74tBn0qhZIEmdp0Qo5gwcvxF/6jvl263K0bEaUgKv
         iqGSvkWPnENzfMX4NvaNUPMh/jU5b/6Cpxg7+G4/HKLw/SWTvUusmMX7PyxKLiOx/QTb
         uuwT5yqSu0hfmeoaZ+ILGb0unNQX9XuJOldNB5iUF1xqniaI150qUZTGIPhtrtFNfNwr
         82Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZdgKLe65/5ZTL18bHaqdAUbi1xJI+QzTIn6dSNFRMgI=;
        b=nT49VyACIr1+M0xJTdbzF7mnBPNRZVdyQ36Qe+LXw3CCa0A1lCSOF1/tSZlxhT4bW9
         Tuho05gtXKD95hA8LLiof4U3WVIO5djmf+PYvuU/zr+o0zathpDatKlGPdMFp1jDgdyv
         uW3V3Gv+zNT+gAnEysWwd0YFo9w44urk4cwnT48+Iq2LH9z4fnJWc25IrlicM12FJFrN
         pHru1xent20FI/AhkVlqfHmlv5/bjA19/lFyHmZsvdy+HIfdzNlVHIObOGMssT0TuoBx
         ofukCwiogVQa29JX94WVINldrrsJYQ7cmpUZZF28MBAAjLABWBbvJLwzYFUiEthl06bp
         WagQ==
X-Gm-Message-State: AOAM533amMqyy1mtkynrihRNRcGA8KTX4v8TsTwZRYP2D70SFFB00LTB
        h988qTFwG4wi+IPu6WwybGPb
X-Google-Smtp-Source: ABdhPJzYTFAYeZXW9XSuIlgnmqDfXeDBG0+J7rVRwEW/QIFDV0IykI8fb+t3RIz3b/ivg6BtIYCk1g==
X-Received: by 2002:a62:7c09:0:b029:152:60c9:43b2 with SMTP id x9-20020a627c090000b029015260c943b2mr8408885pfc.79.1601890340765;
        Mon, 05 Oct 2020 02:32:20 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 124sm11298894pfd.132.2020.10.05.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:32:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
Date:   Mon,  5 Oct 2020 15:01:48 +0530
Message-Id: <20201005093152.13489-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
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

