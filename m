Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082C11C09F4
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgD3WGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgD3WGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1CC035494;
        Thu, 30 Apr 2020 15:06:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n4so5986508ejs.11;
        Thu, 30 Apr 2020 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=rVoqIolote4X9C1I0c6PNlb6gnRNhHFT8EXsdJeOL8ty8dDGcNTCPeougORtlm+mtz
         tHq9dQSO0ExlP4bsNWMzacBhOuyDw+VhSww6VJ0pQ32MN2VG8Acz9sYhyreFccaoZrZg
         Fo/5HADccKHjCAsV3z1hKzRQTBOWc2LgRqGU84EqcaQh/07d4vbFgWNoXEfP9N+3hzju
         /QaS0d2T/XUc1thWJUxEpbVOrjLhueopUkgPsh/SLnDzL34GdTl44CvHhtAeovyjKoTV
         Eummq0flBolE8DftniHk7tM/9+jvWzOJWe8PLS05+vK1Rz1ZHL19vo/uaHrDZRkUW8kI
         qEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=AZ/JSeQS7wyl8l+ViTBkGTJwn05Qo5Trg0GwyDVKEz7zLOjPCTp1taAY+trnfIRuCW
         rdjMZ68eFq1Qpj0vTWMNHq3Wz6EOQ/VntMxvazpw+3wjgE+45C3iB7uVZh4qdZ0VeklW
         g4PT9tDyf5gaYXllHFDWhXkjSoT23BM+tLnF+ZynAsG6cF0quG4NMXnGepl46pBGpt3y
         C+OBSB5auIiDuW5JupChkwGdS6eTkudzoVJif57cLzO9EEORQJSA+DlOJdrhRXytz7G/
         KzD4y2GVp7DV4AcIl9ljtqLkWGwXSnH0Wu6KEeXu14zSd3FkwDSfNIWzMgELj2W9xCqg
         MpRQ==
X-Gm-Message-State: AGi0PuZ67GwODbcSYXEbzKY5nmZKh/WUutTMkMO/E4FC0B/QyiorQRGP
        64fvoOz1orPuKNL3rTdcDFk=
X-Google-Smtp-Source: APiQypI827LtyTZBLnMvq2Q58mux5B9U+d8uj0/ZYhol6Y3cmda7uE+aLFUtJAekXh85JuyJs3MzVA==
X-Received: by 2002:a17:906:17c5:: with SMTP id u5mr540900eje.275.1588284406587;
        Thu, 30 Apr 2020 15:06:46 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:45 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] devicetree: bindings: pci: add ext reset to qcom,pcie
Date:   Fri,  1 May 2020 00:06:12 +0200
Message-Id: <20200430220619.3169-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document ext reset used in ipq8064 SoC by qcom PCIe driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index becdbdc0fffa..6efcef040741 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -179,6 +179,7 @@
 			- "pwr"			PWR reset
 			- "ahb"			AHB reset
 			- "phy_ahb"		PHY AHB reset
+			- "ext"			EXT reset
 
 - reset-names:
 	Usage: required for ipq8074
@@ -287,8 +288,9 @@
 			 <&gcc PCIE_HCLK_RESET>,
 			 <&gcc PCIE_POR_RESET>,
 			 <&gcc PCIE_PCI_RESET>,
-			 <&gcc PCIE_PHY_RESET>;
-		reset-names = "axi", "ahb", "por", "pci", "phy";
+			 <&gcc PCIE_PHY_RESET>,
+			 <&gcc PCIE_EXT_RESET>;
+		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
 		pinctrl-0 = <&pcie_pins_default>;
 		pinctrl-names = "default";
 	};
-- 
2.25.1

