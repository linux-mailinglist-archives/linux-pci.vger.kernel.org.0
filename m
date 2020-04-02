Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1119C0CF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgDBMMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:21 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40997 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388318AbgDBMMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:19 -0400
Received: by mail-ed1-f41.google.com with SMTP id v1so3779327edq.8;
        Thu, 02 Apr 2020 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KttI8qOdzBUJvTdm2DycH2mhGQr6bcBP2m7vqzhEkrw=;
        b=EPceyKQkJ+g8H4Q7uMzo9CusRt4nh5Gh20IV4UFxrS46ahjQOiPk/CjNcjh/aH0wa8
         5jW+LSGYhKicMPyFawH8x1s0LMwN1zKkMMESnxAfUI3DtR2F+2T2WZkYEqxHwqFUrTxG
         dgDOaEoYGurOqFx6kYmqBxA4foAT4sbXnJW9RGk54XnXggZd1w6NsySHT2bhohly2/6f
         Qd5JnxYbcVUAvP93BO3ZOvuADm3SUQRBzdS8rOuYiTWLZJGWsv0txDOETxbx01oeHYmR
         uV+PDq4Lfx0l5KCI1euXJI5edskMXBrXj1Y/m5ay2fsdraD/WaZwfQuw0/mcGAMuha6G
         Plbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KttI8qOdzBUJvTdm2DycH2mhGQr6bcBP2m7vqzhEkrw=;
        b=hXRFOZwwDTVH8f5z35LeEsjSxXQS/B+dcfd6AZ7kZHHQ+c+8K9etowZXpEK7szwyoz
         lrtk8rDkj9c23XTTozoyRzP80W4IywNQCfDZOu9hrhMqBJQtWjh+SnqTz0EkeLMHXtte
         SBV0ykQsxulFAIubjnMoDMoKudLS3Cqu+7HuqWKADWHwjuJuQdIqGIW2lgLoQVn8H9M4
         RBDUdapDmrARhmYuBcP435tu9x8XvOGiWTGNFkzq9GXjzFBKyg23n0a3wWdybb87N7S4
         o4GZHLO44rBi6Tn5jkNvt9/pIX6VGyMlg/kvElbS4/k2f/jHOwIt7eUsskaBH8894wjU
         RMew==
X-Gm-Message-State: AGi0PubwB914YvxaMFNTH6TKChlPUHgPgJOZdGF5v7rKuC/B9FqjWmG0
        BN0r/o/7dUufa1pSH9ULOnw=
X-Google-Smtp-Source: APiQypIuiLL9wUHXGT9WJyDo+PNIhzQ/Qk/bsAXoGgBVWwAodTWeJ91SBKNAmGFGVHVAtJ6Auaue8w==
X-Received: by 2002:a50:f104:: with SMTP id w4mr2629088edl.258.1585829537287;
        Thu, 02 Apr 2020 05:12:17 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v2 09/10] devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie
Date:   Thu,  2 Apr 2020 14:11:46 +0200
Message-Id: <20200402121148.1767-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
In ipq8064 phy_tx0_term_offset is 7, in rev 2, ipq8065 and other SoC it's
set to 0 by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..b699f126ea29 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -5,6 +5,7 @@
 	Value type: <stringlist>
 	Definition: Value should contain
 			- "qcom,pcie-ipq8064" for ipq8064
+			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
 			- "qcom,pcie-apq8064" for apq8064
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
@@ -295,6 +296,47 @@
 		pinctrl-names = "default";
 	};
 
+* Example for ipq8064 rev 2 or ipq8065
+	pcie@1b500000 {
+		compatible = "qcom,pcie-ipq8064-v2", "snps,dw-pcie";
+		reg = <0x1b500000 0x1000
+		       0x1b502000 0x80
+		       0x1b600000 0x100
+		       0x0ff00000 0x100000>;
+		reg-names = "dbi", "elbi", "parf", "config";
+		device_type = "pci";
+		linux,pci-domain = <0>;
+		bus-range = <0x00 0xff>;
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
+			  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
+		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		clocks = <&gcc PCIE_A_CLK>,
+			 <&gcc PCIE_H_CLK>,
+			 <&gcc PCIE_PHY_CLK>,
+			 <&gcc PCIE_AUX_CLK>,
+			 <&gcc PCIE_ALT_REF_CLK>;
+		clock-names = "core", "iface", "phy", "aux", "ref";
+		resets = <&gcc PCIE_ACLK_RESET>,
+			 <&gcc PCIE_HCLK_RESET>,
+			 <&gcc PCIE_POR_RESET>,
+			 <&gcc PCIE_PCI_RESET>,
+			 <&gcc PCIE_PHY_RESET>,
+			 <&gcc PCIE_EXT_RESET>;
+		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
+		pinctrl-0 = <&pcie_pins_default>;
+		pinctrl-names = "default";
+	};
+
 * Example for apq8084
 	pcie0@fc520000 {
 		compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
-- 
2.25.1

