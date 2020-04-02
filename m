Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0596C19C0C2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgDBMMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40590 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbgDBMML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id w26so3792517edu.7;
        Thu, 02 Apr 2020 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vd/7p4psEqL2YZP7WmH2AZNx5b6REDy2Ojzsc3JW1kE=;
        b=FZBpLA0hmzAKapT1JIktWT7j8Y3qsqYiFmbhovbsq2vyB8+043GUlaMPNT7HkDy4f8
         2sEqIiyeMkE9xDQd6UXO5ovpzZfOTri9/cMh4iuoCsqY1WVc7P0fQcwljHHJtkC7bCFO
         ey+IWTyAZhPrCFL/LuiH9aoxMXI+Z6TaUt9r/VghZP0z832+Dvg8Yb2mG/bYbaw2PRYP
         XEGhekc2Y7wVUKHTi9w76sb78nn3WbA6AW5OaXG5F0yWzDl5ez9FkLTg3vk/W/B8VSge
         PQum1kZ5taobwiMoHy4Pkvc8k9CE2xcgLwrjTniz88XQdTFn5XWhSRcVwIWxYDVR8uOt
         /CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd/7p4psEqL2YZP7WmH2AZNx5b6REDy2Ojzsc3JW1kE=;
        b=OHfueIDubw0oC36v4j9iM6qY0iC3hRbaXEy2qXJJDtCO5jXKxWCgSvTAyrpoPynbV4
         uDX34H9u2ZO7FRz4ACUtlpZOVMzAtixKZpNvMEry9809m23ofcdgu8hU0C3tB3OBGeMH
         vco/bwmb6GWTG2OkEio05ZWCzq187RF5lULKZLrwnWQ+GvqOB2aNWegBQLIkDSSw4apz
         O/wFJrFimFA6/6HQ4XfE3iVC/XB8psSzK9WPi3kwlsyKgUxogN2TswgErE303rE7bmdj
         +WkKbqBk9SJRYTUHU1Imgk0iMRv7ixKyy2XT5mMh0BkhRLq7XsZ1C7Kzrv7gDmvfFMP/
         78gA==
X-Gm-Message-State: AGi0PuZLLe/4vlhKr+hLYdErwihoLGkFkgRZvItuWrv6wuEOdQvFXE69
        ENQvVZxSBn7LhVZcEagk84o=
X-Google-Smtp-Source: APiQypJWnJ2q62yiU2KO5ZU6Luhejv2WdT8MZLMdKktQicVY32+VFVKljTVTVeAsE/JmaXnKzGORaQ==
X-Received: by 2002:a17:906:1e4a:: with SMTP id i10mr2801762ejj.169.1585829529575;
        Thu, 02 Apr 2020 05:12:09 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:09 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] devicetree: bindings: pci: add ext reset to qcom,pcie
Date:   Thu,  2 Apr 2020 14:11:43 +0200
Message-Id: <20200402121148.1767-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document ext reset used in ipq806x soc by qcom pcie driver

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

