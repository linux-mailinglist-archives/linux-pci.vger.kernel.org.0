Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6B479B2D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhLROKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbhLROKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:10:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8DC06173F
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k37so10819516lfv.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkCGnjxecVs6iJ5OhJolrVkfI81Gc2C3djNJPu21hcI=;
        b=GFyZ96bt5P1Tdq7Rdod0rseW5Qkj+OeJeADZWdowfdTwcFDkf8x2BxjroPSizd1tPy
         zwUUP1uzUnxvrGZhAGfEI66MN6BCltA4Kd/HJLIn82oICdx5A/SfvFp2eMg6+G7ECvFR
         HrPOsxoPyJcuB41676w7LRSU6HL88vB5JUozjLMmIppYTPmOIf0GtwdCOXg11YNuUy0w
         YygMfwwbtUrkiS3ITRGoTkQ9NIpesQR5fFTIoYvfFh3pK0ZxhPEZEp9dnjgb7XNN74YU
         FqjBoM2BpbPb7N538F9vi9eT9TYO3pxjartRZjuAoIZ6CR/I9b6IMD22K/FmM9EourUM
         CbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkCGnjxecVs6iJ5OhJolrVkfI81Gc2C3djNJPu21hcI=;
        b=ZfqLYT9SFf7kQqLjsnZcQkWa29U3pWL0E/oh77rlRjrEqfRGUZZfg/QYDoSDAnmyfn
         Os0XW+uvb0GaQntyA29tqXq58V7yN7MeMFgiSnc0AtgCJQy/eEmxO/Gvc4CS/Rq6tP5S
         MUw9ulW6QnZx7evb+5o7wqJtllGwLXJari7qqgAdL/WasUL8Adp6BmUoOGOz04EM4cl2
         9dMppPJ5V//yyfDSpj+JpN6dbzomVW3GIkURDWSJ7nLaB0I5yJcT2k2zJ1K6UKTmQYH0
         Jc1LWX/5qMjsC4/4sPIlXrGtiFAucRQxq3dBWGWO0joutcqWtmpSIwVRiTC3ijODzafq
         qlKQ==
X-Gm-Message-State: AOAM5304GmX5YC4wQYmOTvFAGA/c8Q823rbZiIRSB0wLzibA+VLGf27Q
        BUvJM19Ib44+WM1wv1eY27AzBOpLl1IygTQL
X-Google-Smtp-Source: ABdhPJy5/t4pXWcG0z5Cg2A8VE9LuZpptJFuMFz/QjV74cxv/fgkZu5Wto1gxgsGm6nwyH2eDjJINg==
X-Received: by 2002:a19:8c48:: with SMTP id i8mr7449715lfj.179.1639836630630;
        Sat, 18 Dec 2021 06:10:30 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id c2sm145789lfh.189.2021.12.18.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:10:30 -0800 (PST)
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
Subject: [PATCH v5 1/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8450
Date:   Sat, 18 Dec 2021 17:10:20 +0300
Message-Id: <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
different set of clocks, so two compatible entries are required.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index a0ae024c2d0c..0adb56d5645e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -15,6 +15,8 @@
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
 			- "qcom,pcie-sm8250" for sm8250
+			- "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
+			- "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450
 			- "qcom,pcie-ipq6018" for ipq6018
 
 - reg:
@@ -169,6 +171,24 @@
 			- "ddrss_sf_tbu" PCIe SF TBU clock
 			- "pipe"	PIPE clock
 
+- clock-names:
+	Usage: required for sm8450-pcie0 and sm8450-pcie1
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
+			- "aggre0"	Aggre NoC PCIe0 AXI clock, only for sm8450-pcie0
+			- "aggre1"	Aggre NoC PCIe1 AXI clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -246,7 +266,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845 and sm8250
+	Usage: required for sc8180x, sdm845, sm8250 and sm8450
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.34.1

