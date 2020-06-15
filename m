Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8521FA253
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgFOVGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgFOVGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8DC061A0E;
        Mon, 15 Jun 2020 14:06:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so18970722eja.7;
        Mon, 15 Jun 2020 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ny7VFcxsvYKg4f+n4WOuXVu12FivhYhgkhTSalaSq1o=;
        b=g5NacBgIxdFzpLhC9wXirlN9cuKXhuOjymYkv9LCeup3ZKh2QUAo2TwiGXysGLXCXw
         t+hJ1LPooMx/mx4Amd741IhzdH0M+egeJaO8efrt+yjB1dRxKXmh88Weun7FYV/dDRgY
         oCkr24DCknaoAilnpE9abK7/7/E6oxmELUsplz0l04/UPAereIO1OCjSoveo3GnHG7UC
         yRq/6cahvTU03jKNb+jW2K+01FGm28MYo6mnWGI8H6Ni+SkVQwwygPC49Ko4qV6ye0Ng
         CwQHy/BIUZv3qJqfWaGMdI0gjE+B/yI/FuoYGLnp+qmJd8d+5nLaTMeuHncZ/ZBGVm0x
         83Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ny7VFcxsvYKg4f+n4WOuXVu12FivhYhgkhTSalaSq1o=;
        b=LO9+6t2ekc7v8Yj76yXDuXa4y8MEZ8AowrRTTDC0FWiC7HwA7BjTc285GYqRjJdS02
         kgWy5lNYFCdicftDSHemySizXdiF8zY8ddBRcARNfAkSnNObH74thETsvNNmHgroplZE
         Qq2sixfkkHZmuA+z3Uz0mmjjbKEfyewXBHFyEfnpv1XN8vFnRrLWpwTX6Q5Ob/Xrjg+x
         V///+zj/wD4/MLd7I8oEHtRivRpwYfDcxb3jyR8rxf+LXVYi1asz1iAwCfg3ScmjUT6e
         LR6ItBTsvDh9U6an3KNVV+qgVuf3taoeL0AWmQ4ekDiDcIaIhRcd0A6zQHyqjZ5koign
         GsbA==
X-Gm-Message-State: AOAM533QGycr/cl4PcvjCEiKCi69uNDBDpnctMdIzza1ixtZmhqL1BzU
        oj5kVa3Bdv8W2Bht1F9bDDI=
X-Google-Smtp-Source: ABdhPJx3ixPAnnbaJyJLkyhgJVkLG92eNr147cfvyRIh/mdS9RocY6L78KcsY5XqUsDPrshmJvKJIQ==
X-Received: by 2002:a17:906:86c5:: with SMTP id j5mr28474078ejy.88.1592255178156;
        Mon, 15 Jun 2020 14:06:18 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/12] dt-bindings: PCI: qcom: Add missing clks
Date:   Mon, 15 Jun 2020 23:05:58 +0200
Message-Id: <20200615210608.21469-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document missing clks used in ipq8064 SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 981b4de12807..becdbdc0fffa 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -90,6 +90,8 @@
 	Definition: Should contain the following entries
 			- "core"	Clocks the pcie hw block
 			- "phy"		Clocks the pcie PHY block
+			- "aux" 	Clocks the pcie AUX block
+			- "ref" 	Clocks the pcie ref block
 - clock-names:
 	Usage: required for apq8084/ipq4019
 	Value type: <stringlist>
@@ -277,8 +279,10 @@
 				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 		clocks = <&gcc PCIE_A_CLK>,
 			 <&gcc PCIE_H_CLK>,
-			 <&gcc PCIE_PHY_CLK>;
-		clock-names = "core", "iface", "phy";
+			 <&gcc PCIE_PHY_CLK>,
+			 <&gcc PCIE_AUX_CLK>,
+			 <&gcc PCIE_ALT_REF_CLK>;
+		clock-names = "core", "iface", "phy", "aux", "ref";
 		resets = <&gcc PCIE_ACLK_RESET>,
 			 <&gcc PCIE_HCLK_RESET>,
 			 <&gcc PCIE_POR_RESET>,
-- 
2.27.0.rc0

