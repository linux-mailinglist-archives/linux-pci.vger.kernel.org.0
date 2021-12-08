Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3767B46D95F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhLHRSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhLHRSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 12:18:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67DC0617A2
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 09:14:49 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id i63so4942206lji.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Dec 2021 09:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjQ+4ebAvK4TgGM0msltCvsHoQYHGywItHMmPjFkemE=;
        b=F+YB75eAU4+VnIscZjwlg3KpvkeQcqQGAPfad+e4MWNIJjy7sJQ/QRUFtPtLaJcdTx
         cewORztLE2EXONA4yCZ0pfwQkw0OuabI8kFjcTRZVXSa1YN5yGgV/lXhOW2yAvbwr2BX
         /8umLnlt9GDu/peOKMirQCcpYD3fe5CILMuyluzWFNc7DVNdtLqQsW0AWQs85hskcAm6
         4INrhSrvsGBf/4ESEXDLfOWj+vNlelTWqQpGpmRTEVlnERpqq+QUz9Ai9uETULYB4hmB
         1+/NNhnkd5aSDeguuRjdf7qPJrmoxkS3xwOk+VvV/zUx3RpR68JIe60w+jUYlFZ84e+8
         A7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjQ+4ebAvK4TgGM0msltCvsHoQYHGywItHMmPjFkemE=;
        b=bHb6Qewi1e8DFIbYUEw7HxJrQaFMBs/lLg8VsSSgJi83j8DsbFk/ZFS+Z7hXBHJqhY
         FmbMEixYa7PHU2cJjkMhGK7DzSz+r8QlOT5WL2c6f5vWKkyPNJLHIatzxfuSA+Tamlk6
         9WpcOiD1o3LqNRat/M1+e2PqUVNek5+m+lqVB5O9uhSuBmE64TR672GSCc/sW3aCduvD
         BNTggPV9oUSpbRNAj0k81Um1k17pt32XuodKxEsOBTwpRsAEQSJJ2tLtcY1Q5SoOtq3/
         V1FstanFEuOghA+6/vUH308ghKPaXpyHTcr52r3HrtgYGmi8DRBfKHJxIt2IHkHGXaer
         85sA==
X-Gm-Message-State: AOAM533tmAUzQ0St1g5OfICUUbBNvmZX8Wi0xoFlVPjt2xSyb9Nk7JzQ
        P6LyG5j4XSXgcvF4GxOhiqjo4w==
X-Google-Smtp-Source: ABdhPJyz6P6nKJo7YPgJedqZFrFW20JXqTwDyoDTi4tl3rnRuIMtTdTCVwJQAc5vZEC8ctIbp5biUg==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr774710lja.118.1638983687525;
        Wed, 08 Dec 2021 09:14:47 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t9sm307213lfe.88.2021.12.08.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:14:46 -0800 (PST)
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
Subject: [PATCH v2 01/10] dt-bindings: pci: qcom: Document PCIe bindings for SM8450
Date:   Wed,  8 Dec 2021 20:14:33 +0300
Message-Id: <20211208171442.1327689-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8450 SoC.The PCIe IP is similar
to the one used on SM8250. Add the compatible for SM8450.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index a0ae024c2d0c..73bc763c5009 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -15,6 +15,7 @@
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
 			- "qcom,pcie-sm8250" for sm8250
+			- "qcom,pcie-sm8450" for sm8450
 			- "qcom,pcie-ipq6018" for ipq6018
 
 - reg:
@@ -169,6 +170,24 @@
 			- "ddrss_sf_tbu" PCIe SF TBU clock
 			- "pipe"	PIPE clock
 
+- clock-names:
+	Usage: required for sm8450
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"         Auxiliary clock
+			- "cfg"         Configuration clock
+			- "bus_master"  Master AXI clock
+			- "bus_slave"   Slave AXI clock
+			- "slave_q2a"   Slave Q2A clock
+			- "tbu"         PCIe TBU clock
+			- "ddrss_sf_tbu" PCIe SF TBU clock
+			- "pipe"        PIPE clock
+			- "pipe_mux"    PIPE MUX
+			- "phy_pipe"    PIPE output clock
+			- "ref"         REFERENCE clock
+			- "aggre0"	Aggre NoC PCIe0 AXI clock
+			- "aggre1"	Aggre NoC PCIe1 AXI clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -246,7 +265,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845 and sm8250
+	Usage: required for sc8180x, sdm845, sm8250 and sm8450
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.33.0

