Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AFD18D743
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCTSfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36097 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCTSfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id b18so8337943edu.3;
        Fri, 20 Mar 2020 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1VYvZyyGPZyXdBVA/5CvMYrP4xt0r9STQ96DGzN2ng=;
        b=TUer9SL6kQp1I9bams9QQ+Ex4s09SBwSnMPFcQ+gqCS1zCUsiAEkvUgO5SUYWYrYDm
         /UYaBac2EmNPJC28HooJSUdEBQKVTsilUYvtXuib7IZ/t7D+GrKIn1SxjhsNHdZW7do0
         vcwq8z0RGarsMhcFi+42RDga/gEiNA+6EbSeW/puwxfa3IMqaQcEZmDDw4NhOsaZ2MMm
         QNYeJqGfJfL7+0y3LWdFJZHhzkuawj1JIdQZeDsjPHahqb3BugargO5ixegVnB/7KDtO
         HOypDSoBznyVZfHpa/0DfBz02xaVsQIrDao7Y3OrKarvNS8FuSPn/S8SV0WA1s8zudgF
         hsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1VYvZyyGPZyXdBVA/5CvMYrP4xt0r9STQ96DGzN2ng=;
        b=GNTGAhovJR2BHVM1gLDsrEL3bnp4d+JGKSG0VzG/Vw70bXNM412FaNigxE4cTqk/FX
         byTACxW4px7JstlJuAuJ6Iw5/iVX9Ph05wdcpdxfd6+i/r1sBI2CAOQ90WJnt54s9oaS
         ne1LCGwqLkXaRTBldd04syo1h9+EMb1qAId6WmTSAcniDUyO3jaWi6utNwT98T0s+m4Z
         GmRiWmFwpVZFmLeQ/gW3hCY5RwUC49R69Lk0jqOc0k6SgJAILGD21iJNciGYS0C46p6Z
         0SDyb+wYgwAkr9eaOB7yCoQCYfOMIhyizTbdm4c2S1zQJrntQaspYJ9iGcXsuhxPj1AP
         pNXw==
X-Gm-Message-State: ANhLgQ2z1tszdb9h/yVfyuuVUcBxoUA61lULIg8LvYpH7WsLvke95rYa
        m1X1n27+Wn46XfFGtFvohg0=
X-Google-Smtp-Source: ADFU+vs4niaWE6EQ2dqQSFkoRr8yu9PRvGsmXL8eUFpJcYsno4Gykm4xqHp4FYdJgx2adWgljr2PMw==
X-Received: by 2002:a17:906:c4f:: with SMTP id t15mr9821145ejf.193.1584729318447;
        Fri, 20 Mar 2020 11:35:18 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] devicetree: bindings: pci: add ext reset to qcom,pcie
Date:   Fri, 20 Mar 2020 19:34:48 +0100
Message-Id: <20200320183455.21311-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document ext reset used in ipq806x soc by qcom pcie driver

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
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

