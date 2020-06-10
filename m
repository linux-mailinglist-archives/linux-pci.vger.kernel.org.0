Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1851F58B6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgFJQHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgFJQHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E149EC03E96B;
        Wed, 10 Jun 2020 09:07:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g1so1796284edv.6;
        Wed, 10 Jun 2020 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=uQy9SEHaGtNMnsvTAeJWKrKMQ+cGjeS3LV6rQlyngG/2j7zOxKRWMoO3r+unHO84th
         q+2LZ9M/mtIWxOTzoTFlvstdJzxAoy5+ijY43i58WS1MhSZPkvsZoT7Cgjy2I91uJsWw
         JMrt/xphxDHbIsfDM+xOXvUtGLEoo+jIt22xaCgDhZg07G58YgeAnnwJo/aXMHhPeSnZ
         Yyd1L1/poEBsgW0Jvth+6c6vm4/kR67klSZN9AO0W0Tywv4ZLBQeFxFdXshr1AxRIRca
         JwjDyQHDfaXiG8qb/zPRU0WE5rNzHkv5mw21pXgNsMc8iCLKzwlo7UbsyTMsrrCZgm4w
         RP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=OlRQoP5FBzd2eydJdTHtDWr5IWrJwnkErEQ0GXUrqJLvFgY8u03yL25/VJC5fgclGu
         0APT7YJPKBjR4xhGnvj3TeRGQ31favmvKHQaJ9BnWX/Lw4uTxfK1MGH3F/SeQCeNa4Qz
         /RBpun15rTr/HjhQIY3G0jNufyiTkeRCfPJvvL6ytmyrNIeI/t5BMHeoYEhkMZjp976T
         v6eVodzhGuRQ6YZBr/JZ5LYsqwwALCI5MA+c1R3xLlS1eHWJIt2qC4KjsJUS1QsoNl28
         ENsL142pgLrjiP3fdJX0cmskxJGlPoAOf9L8wtA36HDAg+n1p5LQcgOWPIOrfwSWQnug
         4EIw==
X-Gm-Message-State: AOAM533Pb3++rsPFMg1gVZXpw83wdzv6X0XXU7BT6dFH7Rb7LYh+bdhm
        aa8z95Sy65W122lkuaNQhWY=
X-Google-Smtp-Source: ABdhPJxKuhR5NvldILEwnAyEs/nq65D+XrwXXqi18nQAkzvhQOAEBt6HvaBSyq30vEtGPB2IrEburg==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr3191750edr.175.1591805231622;
        Wed, 10 Jun 2020 09:07:11 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:11 -0700 (PDT)
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
Subject: [PATCH v6 02/12] dt-bindings: PCI: qcom: Add missing clks
Date:   Wed, 10 Jun 2020 18:06:44 +0200
Message-Id: <20200610160655.27799-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
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

