Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6946650B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358490AbhLBOV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358508AbhLBOVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:21:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C820C0613F1
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 06:17:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u22so55139710lju.7
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqI3xY0pvVoBQsxGGFtLbY7ZwwclD846C8Wf2Zpc5JI=;
        b=Qz072+OVsCJ5CVpMCyIHIw09YNYH7GbOPhpyIQeJ2rUgTjq+h7vZiRleND8F1btLYN
         TfkwBQiqXG0kX2kz8vjUB3ll7irIWVmZRAnKb5MRVWed1rPYYmDmrUwRvmmz8CL2er4S
         ux6T2VU2IJfci8xBN0xWG9qmSObB+NNhSeyWUcNKTT8VbXEb3fjBh5OiZCETonJFxhbz
         DQJ8sXCBNpiU0EN4JFbiFbQ2WlNR69aKt+/t6SpgGo9xyjglnqcnoIfVtYIfxeXHmc9j
         Guq3CXI46ixg9A46zqg6pnXOJeMDnBhmszBaMdk16xckzTk/78wrn/XbsEx8HMv6zvxV
         lC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqI3xY0pvVoBQsxGGFtLbY7ZwwclD846C8Wf2Zpc5JI=;
        b=bKGTluPLERzudxUMPgchxSALtSJm1EYMaW55uzN6UZdRSsOhucPmrOFSbbQsHt1Crg
         v/9NvHNqZ8PvO/sOTFmfnGSOePIc0iEOWP1B7fBC8aBWWLDyFlER9M4p4U/v9IDJFiQm
         0RFeo2JLisPJe9xBUyVNAiN0w/bxdtWDNjBm6JsZqPvfEWbZzwFd3b3E+W7yzW4DVsOq
         hA7p+NA9Pq65E8o4MIcbTL+trWM7RoDKj7Xymy2FBw0cDDbLzpfrlJnRhneVZZ1lhptU
         nTpluly8/5oOyHlbyEcuiDp9IxQWwSUhuiL/HVtwAKz2tYuo7OdeXha7xxjNDlNBmVmu
         4o5A==
X-Gm-Message-State: AOAM530Q79xBbsiHqTuayG3W1lFFJOviY6cQBERaZOXV4tnusGKnSp7P
        a6guei2QF9iS6Slqc4FZ7BHbCA==
X-Google-Smtp-Source: ABdhPJxoMQNCP8EWnMrmq9jByGLRIQ/uPFv58dRF2c8p1RSH22b2+KPHsCvOTzTInoQ3AP5mC/XvxQ==
X-Received: by 2002:a2e:985a:: with SMTP id e26mr12260167ljj.265.1638454653505;
        Thu, 02 Dec 2021 06:17:33 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m15sm362487lfg.165.2021.12.02.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:17:33 -0800 (PST)
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
Subject: [PATCH v1 02/10] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
Date:   Thu,  2 Dec 2021 17:17:18 +0300
Message-Id: <20211202141726.1796793-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
References: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two different PCIe PHYs on SM8450, one having one lane and
another with two lanes. Add DT bindings for the first one. Support for
second PCIe host and PHY will be submitted separately.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

