Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42C19C0E0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbgDBMMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33303 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388239AbgDBMMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so3841414ede.0;
        Thu, 02 Apr 2020 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dGTHqx3bG6gs03S9XoD7W3tW7je5nP9W1EztY8BydA=;
        b=ilkvR70Sx0A+pxHqWws9O1/N3VKSPMn8ZoXhFFp/mng5/RYun7AYZHAQyZRGZM88YG
         G0gdJ3TWV8zMxooeAkQmExPp+anICrT7GDAV7EscDKlxteBAuHGQiWTq8ICicQnhEr6f
         7Pyqd30ahoZYiZJxsMrlKm8FtOGnn1+ZsWlkkepJzbdIvE3TgevlQf4DbS3Cwuu0etyw
         iFVUARt+Xsvt/gWB4ooItHtjTweQvrNwFsofidUwhna8bdjiOFDbptVItpWxxwSqM7Rb
         KZLJ5yMiC1beqWsapbSVnIvqMLPlm0g+FyfO5pIUd6DilO6HdHM5JQmhFmXQ2FVgOe4L
         Wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dGTHqx3bG6gs03S9XoD7W3tW7je5nP9W1EztY8BydA=;
        b=lW0zFj93OrTJRYWMEXypSR3++ktYZXdoV+B0y3OjNB2Yq0AyJPrynWJUGup9C47hpq
         tSb8sQwgLWTGmGYxaDIphPFRwI7yrVSpbo6fs2ThKt8qreZQxvwajRH5S7JPdPMHfifT
         qa57Ld5xlnLDhXN/LZ206qq3mX27KINJ6I1PFifi/Mg2tyy5df76id7QveF+7oO6ZfSx
         yMhMvQbZKjRO6X0ArudEM+hcvttA8LkSaHo2GyMWPypw2NL8pB5gkDAzeamFJStmfhAV
         yrp2OXbzdORL5Ct3r8MnEMr5Zwc/1Waq/onu7ej+bBXiOXAIPASUmK6VCzM1Ve3eH32O
         ISiQ==
X-Gm-Message-State: AGi0PuaJ9bxqUsPswAjOby6VS2kcUXlltsoak9NY5Pdfg+lbblPH217t
        LtLfNMNjhkiiEaXwQ6A0iQ0=
X-Google-Smtp-Source: APiQypKYxjtcBBgBHnW12cQvcF13VWJDWgS7QE+pl2tfSyIFd+Kdh7NemNhQs3sSx010992j+hGdXw==
X-Received: by 2002:a17:906:640f:: with SMTP id d15mr2959847ejm.191.1585829520480;
        Thu, 02 Apr 2020 05:12:00 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:11:59 -0700 (PDT)
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
Subject: [PATCH v2 02/10] devicetree: bindings: pci: add missing clks to qcom,pcie
Date:   Thu,  2 Apr 2020 14:11:39 +0200
Message-Id: <20200402121148.1767-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document missing clks used in ipq806x soc.

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

