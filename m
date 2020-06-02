Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91AE1EBAE9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFBLyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBLyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CEC061A0E;
        Tue,  2 Jun 2020 04:54:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so3056986wrm.13;
        Tue, 02 Jun 2020 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=OPGilbj7UjSYk9ZchqbkyFuPkLvGV2w71w6eB3yzbzyhyzclPQ6a+w1TnzeVAX8FEd
         DOgv6gdm72XTP6dUvVblAlud4o6+I7AN/J3h65S3yNZXcuaQNSXJvhIhsGjHVv8BGCI3
         690nYPxqXv4aPnkxF8lfjnJwkruYOkCEGMZ7jOKpdC+CMrY1kLZ9ZgbCgNM1frYrxOqu
         Cf2KkUccSmBBw0BHUe7Pc1M2lNkXGAeIAXPEXoo3pZpsYi3IIMBvDTs709pU7BaR4xn0
         s6Di564UkLwo3zbedA3SlEkJD5KaLcQElFO96G5P1sVAU0OxTuFucb6jz+Oi+efzHxNX
         3lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=q6DKXQFWAuB7B4cOnW/Hl9h11gJ7O0RbTo9uxUnMlK+PU5JMw0zPvVYxnTU/gyx4tm
         rkefGlqolE1y00IjnonaPaATx5z1YE08c51EKKQVks+fynKaEgV0ljLd7/2bp10bbzWF
         zaKEcG6xphBSUjemgcLE5Rvdt5ECvrmXCAugeEokSWyLw559G3kOFuhCJU9hSDoMM4kc
         Ig12VJqAHXgZJfMl5XAjpMfL6vWOm5rz6MrwswEqhb0sbbj1mtLOjwj2f3Z85YGaQoYm
         fqjjdrqV4KTUsOOYdDlEfIMAV04e0mbtRkasy9gB/w8DoFOTqfaiWbPf/mYEapWXip9+
         3H5A==
X-Gm-Message-State: AOAM530buXqNc19f153JRqLj6ccbUQy0zu9cbGRX8OGZnYVhWyXw1y4B
        LCn4Qu/gS/DxHKkJ+n6Cy/E=
X-Google-Smtp-Source: ABdhPJxWvG6gP1xb6MNdtvpUdYbBOn0bBHaTVxTJUwCJtK+32mQrYuenIXkSvpxLIpAmxnmu1V9dpQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr25594162wrq.325.1591098874758;
        Tue, 02 Jun 2020 04:54:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:34 -0700 (PDT)
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
Subject: [PATCH v5 05/11] dt-bindings: PCI: qcom: Add ext reset
Date:   Tue,  2 Jun 2020 13:53:46 +0200
Message-Id: <20200602115353.20143-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
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

