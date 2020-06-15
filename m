Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38201FA264
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgFOVGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbgFOVG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4707C061A0E;
        Mon, 15 Jun 2020 14:06:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g1so12562126edv.6;
        Mon, 15 Jun 2020 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tnxzeLrebInQm8RJ3dhvveUmV0mvvYaTXd5mudNeVI=;
        b=A+VMjeDys94CDeGa8so1cw8SK6kOKajtWmtZo61PfDLIDos9vKPvMheTSEtwpPOMDq
         fOtAu1eaWEYYD+13Rj1HONQ0HzKBHo94pLkaRqApcbWqpgnMzGRQPRiFhPK+XOoH8nHR
         WOrKiWMvkdzY1Zk0uWXH/n9niJY4zCJL3o8hH6OBhFSwTbk4k8wRLoiY8Ea92htc6SzG
         1KpSu4nRqa4yIKewL4CLxH62EHKSgifTk3w+44lmiWcW9UiJlfkDPJpUCjcy2L6vDSsU
         6aKcp7+utM7lKOhdZHUDXOPagPy739DmtTcu56696qu7XFFrAXVyeEXrLvFHRul7sIAy
         vFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tnxzeLrebInQm8RJ3dhvveUmV0mvvYaTXd5mudNeVI=;
        b=Crca/0Qhz1pY+pVB0tH9OBytST4Kvqk2FJ9UA7phvLSbtI1Ldnz9gEIGrXJQFIUkRv
         jpYQ9X4bix91Qsk/4+RCBv6BKTowPYn59LNvXzOcW2e2fA9OTfBpNSaeNUB/5FT/M7u3
         S10txvHaK7E6FS4YK/obyfQPI5UlL6+9ldeHsT3pMhbckfpJnUZV3hqno/P3b5+uSz27
         9Yl5H/gvMildniyU9f2dXVzaLDD7hC2wTb+XMHmna4MOvoBJzrAjXX+IzEO/OYjjCc41
         DN4Vc5l1+0K/JRfe3slD71KC9yLTpBEBwkLd07+CFfr8oFFiFcdFccyjiDHz2G47aGfL
         IRhA==
X-Gm-Message-State: AOAM53276eBlvgvi0zhxUhX0Bgw4WxhKIyoaJytcQ2kRJztdd911pZTj
        P0BgMeX1Poj9VzBNC7PnTSc=
X-Google-Smtp-Source: ABdhPJwycVWBkKUbT79y/6ixRAVaDmgCQO3Wcl78/yG0bB8Fs0uCTlcD0tWDy3ht0ECl+4iTADafXA==
X-Received: by 2002:a05:6402:3c2:: with SMTP id t2mr25485628edw.361.1592255185458;
        Mon, 15 Jun 2020 14:06:25 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:24 -0700 (PDT)
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
Subject: [PATCH v7 05/12] dt-bindings: PCI: qcom: Add ext reset
Date:   Mon, 15 Jun 2020 23:06:01 +0200
Message-Id: <20200615210608.21469-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
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
2.27.0.rc0

