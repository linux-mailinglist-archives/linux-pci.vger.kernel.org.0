Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A811D3EA5
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgENUIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729278AbgENUHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:43 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC12CC061A0C;
        Thu, 14 May 2020 13:07:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h16so3459503eds.5;
        Thu, 14 May 2020 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=GtSzbFugKXUZLfIGhS+lGWTCnLshbSF1JRUkZH+02JeQGSSHJvXuU04N7PFHtpvCph
         jDrfm6OXEey0Yult4YjLTHi8ilKeMa+sAT5PIK7kSky98WtwzkWMUSh/UykuEbn3nTyW
         H+FkpMQ5SA70GwSWmEaOtbzmSED5MFgxAoOUo73yo3CyNIqDQTCTPgQBBbpnwqgPw7Wb
         S6dNrKVF1aNaFlQ0CoVPpBTB5P+l94OLWUoUgkBkbgJ85MUhFPGyLb6qQUFbDHa6vBRm
         LgkExgyHxWI1wJ4hQsdEeEHgDbUoYcg9DzkTgbvkMRAKe+D0nZOdczddC6ieRB+uZy1L
         7kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioo9tN1eVsbgycuXVtXW3j/mdJh9pHsUFw60B6xaAJg=;
        b=XlSFpIpLLI01Gt9PLV963g7Bk3FytgioNR+nkJbBuXVwJE8vNQ0HMX5MmRliHiOqeC
         NcfKm3iE3e9ME3xFM1jmf7DGD18L0/czs/2N/8Lah5WJtDwspuOBcjcH0FBLDllswvyX
         64TfHWW6jmWm4PfJ6j0smSOlXKmYOYUqVJxPPY9cVEuCB9IPR/okRO3boY03o8HytH+D
         sy0mRLTpUdQng6+Cq39csUOphUnv3uIZ6OvrPWcKA5AU9yxh+k+syZowIwk3/NdQ35e0
         sU5Vn/ENabpbciVnu8onq0ZMnGRYzyB6LuehhFNSkNAPNfvNbsWk1s6/INTannh+bCap
         YLhQ==
X-Gm-Message-State: AOAM532ajUKgdYjHZC8WYl32/ncb3WfHt7kz4EGZlwLOpdWJtrrYNTw9
        znSC4Z+cqHnPZ06OfEdK6OM=
X-Google-Smtp-Source: ABdhPJyt4UuV2TMAZZyM8I2pUJSWcQuUc1x/pxGNfo0AGSIDTCiuplAOe/iA9oVWL1HR11F172Qx+A==
X-Received: by 2002:a05:6402:30b2:: with SMTP id df18mr5357586edb.323.1589486861453;
        Thu, 14 May 2020 13:07:41 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:40 -0700 (PDT)
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
Subject: [PATCH v4 05/10] dt-bindings: PCI: qcom: Add ext reset
Date:   Thu, 14 May 2020 22:07:06 +0200
Message-Id: <20200514200712.12232-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
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

