Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7660D1D3EA6
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgENUHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729278AbgENUHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262DC061A0C;
        Thu, 14 May 2020 13:07:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r7so3428390edo.11;
        Thu, 14 May 2020 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=odbfaU8QQyTd6B/aQ14LNap48BA3Otq70Gg2JclcfAqZtKtHy1fTMkObb9x2amkEzi
         y3Jwj4MoiMC3AW6obB2fOFkaP8myTwp4/RWuXRDrFrJLmtJuEk/54NaRuq2aaQiwqf4p
         H+/sgHnO09oI9Adpaj9U/9830FiHWgQ/jVxdft4n8ceSm7o7St7WIYN5X1SZtn6W1WHX
         yirfYEZZDQL2E1du2yNqqHEA+zu4LOupw5ZLrzJkR+nrhQkFbfgrmSnW3XnetLsVoUux
         nicQGmK2FXbzld9zrlYVkA10PfovXFABfQmc9CRHNiClfLtuXRiKxgfiiskN9IYEkuJK
         XzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=DpWdUg8n0++5NyxHM3GntV22w0uNKr2LPClFbt72jc8LP/SJtxzEfdFM5gAMJq3LoS
         GY7DniZ49ECpxINHvXs3huZvJLFrf8SFt3/cuh17luyWJfDPMRhFW9f5tX78IyZ4T1VS
         8cihPwE7bArPo0M5kGbkyZU6hwn1gj8bBTeg2nkNzkmXyJQtBW3F09nqpFlhVIe3d0Li
         a2/lOxHZpl55RxGg3ISv70WNytDKef+LI8MKJFr2DdmWXVhN8H4MAf4r+eF3i5+On+s8
         MTeipRX0TRSkGMV4RcuzrH19kNRyk+KyNGJ+0BuCRsk1UuhtWmvmtCJ8aBvYJFGZPATV
         SZHw==
X-Gm-Message-State: AOAM533VBC6RY9IkEnPsmpmCv9Rc7Zi06TnXXilXq6nJYgu29lZ2HM9q
        E46waafMppMK8X7ZDmTSwmU=
X-Google-Smtp-Source: ABdhPJxtB7MJ/utIyZw9JYXFlKXZSZ9dcbAUANdjuBraviAEv58tw5+D3OKtkpQNDgfGea6fylvLxg==
X-Received: by 2002:a05:6402:204b:: with SMTP id bc11mr5450220edb.114.1589486854233;
        Thu, 14 May 2020 13:07:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:32 -0700 (PDT)
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
Subject: [PATCH v4 02/10] dt-bindings: PCI: qcom: Add missing clks
Date:   Thu, 14 May 2020 22:07:03 +0200
Message-Id: <20200514200712.12232-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
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
2.25.1

