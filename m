Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77A1C09EB
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgD3WGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgD3WGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D12C035494;
        Thu, 30 Apr 2020 15:06:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so5859923edv.2;
        Thu, 30 Apr 2020 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIh4WZ/DzQGFNuZWC55hswdxMMaPYtsqIl+LPMHRbFE=;
        b=KOgyeYgd2UrMZzgUPPX0zevKc0K5HhCrApFGo/tkCjeVfJ7DEqRa7puz1/alxsxuWA
         FKk/ZjJBV/s84TOBaYX4XZzZHcs0VuxR4tjTjFUpXDvZzVr0oEhWdMPNymrtD7usoO7h
         l7SprQyUEmNTHb2fYlQpDNXxKepOJcc0mFaqetgcwID7Ff+M/XqfG06lYzsKOg1VT+dc
         R0dWKDFDC1nTqpetZi/u+0CJSoJcWUaNb9TQCBGBpEvitM4semj6cEQinV5qBQjvoWik
         xz1RYcwU6FtDsNzfshiPmAbGI3Ux/blsNLgitsahx3VcvVXwreyKde1uw8iCc9YKGvAf
         9jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIh4WZ/DzQGFNuZWC55hswdxMMaPYtsqIl+LPMHRbFE=;
        b=jVwcRzyqyQxu2iX3eE9BWhA3vvUnp/7EZy9TkuvJqBaFxFhFNRYtsXC7w7T6/7EbC/
         AFSbry859/WFjCqTIThMSYTnDlkXB91fMulkGjr+bcgQ/nZN9CCgkdK2afE+Zg34uNKX
         TG/Yhzt7HPDBVFFnTpWrSdoVPPUkthCHoutYqqSKVbfAi/eo9W1VHwcgm1WKGSKabVUX
         jvI6AMWRJ/hZieLkJx2hE/xcWkOcD/TJwq/y9JMdoFDF/XqTsnobiu5dzf0RpudEfy1k
         2/uoxXofY3lJsfnq9+Ak3OPykCg33vas/1oOqPXRKsDq93RIwdUOqB/GxkR/aGNO0XUo
         yLEg==
X-Gm-Message-State: AGi0PuaAua2B0JaHsHNckRk7iYqoItPyj4ZroUcha/9wQonzmu/BVLRN
        tT6vcgS49onbDqX7UinztQk=
X-Google-Smtp-Source: APiQypJe3oZqbiWz9ac5ISUi4os5aD4cY2cMgVvOHyjpiuLokM2LWzlQ5tP5a7iYAYa3J2msNFsS1w==
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr1092884edb.336.1588284397811;
        Thu, 30 Apr 2020 15:06:37 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:37 -0700 (PDT)
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
Subject: [PATCH v3 02/11] devicetree: bindings: pci: add missing clks to qcom,pcie
Date:   Fri,  1 May 2020 00:06:09 +0200
Message-Id: <20200430220619.3169-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document missing clks used in ipq8064 soc.

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

