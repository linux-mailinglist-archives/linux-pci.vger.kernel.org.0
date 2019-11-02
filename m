Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECBECC60
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 01:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfKBA12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 20:27:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43794 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfKBA10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2019 20:27:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so8091577pfb.10
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2019 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abIxfgc9fnK9AD2iU1nPxC91Bq9pACN+MgDiw3wopZA=;
        b=IGuurnjl4UUmE2MIpNzi4yc1Xq0voatd5HcWslq5OxsHLpMjf9QshCggMb3dZeE+E9
         wCQ1iVUDzlQqODnJ+CbhQ2MPDmf2m3Ls9xdOiff+v8I33micCp2BKoLBscEML0IvUugy
         CtL7sje3+8FKtTnKc/iV+ENMbpCU1CilE22WSSOc+e9uW3miPfdBTZGxw/CNkvYIXMmg
         CkX5yxVP0QOKtOMmXJbBn4dCUkVEAaTK7O0u1be/u7wACFHwbmQCw86Ngn/yZzw2dkti
         eyRoh9QVtelhrg8b526tPQySNDciS3rV5lgv5V0imvIvsiyCAH6/YhfFdEFT04gNLrxe
         4Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abIxfgc9fnK9AD2iU1nPxC91Bq9pACN+MgDiw3wopZA=;
        b=nqNH/Gp9hnBqj4MZiJOeV+/bsB01yNch7dzthTDa5RkbPi1XJUtXw5rLHrcJ2TVo9K
         pl/bqq59MCCrPXpoJahXU2CAesY2VugyvuVNGW6F7z43zOXgntTntYJDMo4NO8+j0Ywc
         eOoFE7gEgLuBlttw/a3b+PXOqZ90fMmLY9eDMt4L7/rYM/BCpUzCAL+WnjQqAIwi8jjJ
         jbE3jqudmV7l/ahWulMMDk71hBfnzpEvZn41Hh1LbVakl4r9LhYvwycLWsHLnLwbhshD
         m542andESFTs+DYFamO2+SAfuQwoZe1SLVtdUrcmugQzlcxJUZ6BwLVypap7Ush4r6fC
         1WRQ==
X-Gm-Message-State: APjAAAVWYIzE7WubLPULV7jOfAEAHIevO6T9yocMCQ0p2BYP0c3eVZlA
        P1dnmEXhjaPGEKfWHE3R/UWNfQ==
X-Google-Smtp-Source: APXvYqzLVtsJ1+fsQ8wcZPN8Jupl4afEmh9yjGDk6FOTJl6qSh/nEobh8X0ZvvPxM2UgV++BqVxE3A==
X-Received: by 2002:a62:2e44:: with SMTP id u65mr16597100pfu.103.1572654446194;
        Fri, 01 Nov 2019 17:27:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm9395910pga.17.2019.11.01.17.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:27:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add support for SDM845 PCIe
Date:   Fri,  1 Nov 2019 17:27:20 -0700
Message-Id: <20191102002721.4091180-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatible and necessary clocks and resets definitions for the
SDM845 PCIe controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Split out binding in separate patch

 .../devicetree/bindings/pci/qcom,pcie.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index ada80b01bf0c..981b4de12807 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -11,6 +11,7 @@
 			- "qcom,pcie-ipq4019" for ipq4019
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
+			- "qcom,pcie-sdm845" for sdm845
 
 - reg:
 	Usage: required
@@ -126,6 +127,18 @@
 			- "master_bus"	AXI Master clock
 			- "slave_bus"	AXI Slave clock
 
+-clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary clock
+			- "cfg"		Configuration clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+			- "slave_q2a"	Slave Q2A clock
+			- "tbu"		PCIe TBU clock
+			- "pipe"	PIPE clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -188,6 +201,12 @@
 			- "pwr"			PWR reset
 			- "ahb"			AHB reset
 
+- reset-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "pci"			PCIe core reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
-- 
2.23.0

