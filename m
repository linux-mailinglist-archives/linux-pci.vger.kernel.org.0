Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF318D723
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgCTSfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37553 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgCTSfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id b23so8333990edx.4;
        Fri, 20 Mar 2020 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQ0Q+G5JHB2wM7K4BTcO70sOln2WeIX1gFNwP6RhpGg=;
        b=apXJslcSv6DC7tOJCgLYYYrV7Uplua56Od4xMZ0ChU3xw5lwqCUcaRvDeMQVJ718nC
         lIN/rx3MUNJ4VpgfEJlHp8ehGN1L8yIdGbVA57igSjDUsRsevHYfRk4NcwhEpC/qDq7C
         mUPGo9j8A5mlZaevqvNT3+34ex12nlDlL89Wg/Y8KUb27OwNxAP/VWpk5+i/vhrpx0EP
         ydt3z/yAqFx96y/MFkcHqQHwoTVTtcxfTNWETO/WAXC4rZX6yMqat78iXAbvheQkgNWh
         IL1Cgr0omLPpNQSd7K1H9n9n2xc3sJY5d+8Y/0ez0sU6j+smuEfkjYBAQUNuWlp/RJ1z
         hQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQ0Q+G5JHB2wM7K4BTcO70sOln2WeIX1gFNwP6RhpGg=;
        b=tpkfcge3waxKDXg+PsEEnEKe4ktNUK3WPKKm3zUIuOSlG5ZpiL1R6f9/t+r9WLAahU
         sbxuupMr8AHJWQDKIN7P82/hoEh89ZMS4/HMxAkmG3Z+SCsnOK5TIrBEoSrTASKe4aam
         O0vhLVmvSb1FTq5PJtl8RVLn2PuU6qbMfjzOvenPkt1/qelurQEqZ6A+oc+CIrbiO2f0
         yhljLWso5QOV7V2IvJj9aHFeaOtDpFO4wDJgWPAfr6hNqKMxch967jadKBq4VQkXPQNJ
         gGQatWpHokO+ICHEzrAsAYLrh97BiXNuqVZ5UQCRLb+XHm07HLdP9kGEss7xOaKFSlZk
         pi2A==
X-Gm-Message-State: ANhLgQ2m5XTPhZcgoE78y1GZvLVHnid6dfJ3+Uupq6AqWOdVCUFLgSMh
        isoDMkZJZHYu87j+vAGrtFA=
X-Google-Smtp-Source: ADFU+vsaA6XpAhj1+J65GLanwleRzVBh4W3oXm2qIL37/3iCYgGQ2Uue7Q0ibo2tLweZ+0IKexqPKA==
X-Received: by 2002:a05:6402:2071:: with SMTP id bd17mr9532397edb.160.1584729307682;
        Fri, 20 Mar 2020 11:35:07 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:06 -0700 (PDT)
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
Subject: [PATCH 02/12] devicetree: bindings: pci: add missing clks to qcom,pcie
Date:   Fri, 20 Mar 2020 19:34:44 +0100
Message-Id: <20200320183455.21311-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document missing clks used in ipq806x soc

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
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

