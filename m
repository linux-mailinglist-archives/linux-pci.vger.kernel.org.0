Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E21F5892
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgFJQHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbgFJQHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6BC03E96B;
        Wed, 10 Jun 2020 09:07:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q13so1806876edi.3;
        Wed, 10 Jun 2020 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=k+bF1WhmemJGb7/rN2yMZ3V5wpG5VUSckwq4ZFRcihddXrKOGEAhX/KLNFKfr8NIT9
         2fqahGpki7zSY/17ubctHPUhyiGTOsUHEZsq2uLKwUGb+yrCujYIDO9Kphf5c6ry/iiv
         xqL0qxh3R/bzrokrJ9jkQmfU6NvjMlnLButsFctB5riWzebSevP83kzuKcvXubwEmsfj
         WNDQIDe/+/oQDZmsId5O1s8g7fsIaTvcFn/3kaBaIajCjQRXjfc97/Op//y7PlrA7jpH
         waMtfx3qAe+fVNp7LVQHw3kwwO0DrQPZ1wx3vWZU1pA95/xQd2KMf2lm2NeV1g0bX0ND
         AwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=WL9Mcv3i4RvmzTst9MfltiF4sd5gT9CufSUnf2VU3JNBOWmdBFYnMXxlLca5PD6ROx
         RYPFX6ObxL8yFMXmsGOqGjv9ofaylI8Y4EmhbxLWCbj6QOWaoAmh3fXud3hlFSTDs/ji
         6QOZdPeCuI27RP3BX0oB35FS4PO/2rfJM7mD0JQAfRjYF4hPb5+JnW8ybTlJJ/b6AUUQ
         WDYDu1RI5mS9YyWM9hH1vpmA5mJCH0iuDylkk1vsC+w3VO8z2HZ86Yt/7yvcZ/HPhOAT
         ztSeTBtCRKRRhdEXTCS3u3UXwRRje/L7qfwuf+ILVyJL5s/jAuUfQyfhu0pSmarqD64v
         dPXA==
X-Gm-Message-State: AOAM5331TN3aYyVGZdN9dn6dgh4NLZGGoRxPygw45fgHHh6ILf8dZEIS
        CEtgDY3qykAyYl0qRd4Ahas=
X-Google-Smtp-Source: ABdhPJwrLA8Bu4tlbBnnmWuLupJjY7NMw3oqzJ3tVY/+imD0cNevAFtZT9q8Xo4SuJqEIMy2yjlRNA==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr2917329eds.267.1591805239574;
        Wed, 10 Jun 2020 09:07:19 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/12] dt-bindings: PCI: qcom: Add ext reset
Date:   Wed, 10 Jun 2020 18:06:47 +0200
Message-Id: <20200610160655.27799-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
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

