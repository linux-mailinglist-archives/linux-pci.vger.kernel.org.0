Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787031A3D7F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDJAr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:47:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41885 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgDJArz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 20:47:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id v1so532004edq.8;
        Thu, 09 Apr 2020 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZSQSUlLJFkzUgf1NTHH5zpRsFkN3TikFBBnNLe5wGw=;
        b=NP1VPhz21BJ2RjboM81BtD5W0D5gGBZBCm+q7FPqOrKDHZqBmqJzCnXkCX5XinTmXu
         dksMqSUAbWADIl4wmV5wKtfqQd+azgiOqIGDi1Jag52UOKgEfdUvtD+wmiKvU0vlwFBI
         Rz6VmdU88kNS7oAi4ou7Bvh5A7+yeoCUvt04vm0ToapQxV9Cq0HT46abbl0O+Z/L1Pdc
         y7HXy5JIOmhNLF9MWCRqCKWEFZMfB7Ctz9ujAJU5mH1ht7XNJ3I4ctrzrdQzkyd1QFLf
         QUeBQoZ6kdUqkJvP4scZfPfsijmyv/DD/7bDXsWksrx2cIOvuKQskrEJl+RYqAi0Q1FS
         oxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZSQSUlLJFkzUgf1NTHH5zpRsFkN3TikFBBnNLe5wGw=;
        b=QnNmO9X+cWib/ti7jVL0n+hBjhRW+GStgzkLPJ5a979TXKxP8D9/DNTw+4bfS8oKmN
         XEd54wG6jZEcuXeRcbGDApDt7l6fhNgpPpkvXPDu0dtBVVDoiTTeCFUVEBhGuCN53b4e
         H3HpCps9IP4Qqb3QgrIXZceITG2bWzD04NVlA+2/3M7/Fcws51Q1pvFscB0WJBTVk2WU
         foCdD14ARnwLIfvLIbu6DR1snDji7PNhxIToB+f70czpEi57Ig+145jJb3haOjl4zOXe
         a9V+007mnIMkrJz/3Wg7EY94tyzji5b4Vl/AxKmi32b6go72awv0e7hCxiJQG0twDoG/
         m7nA==
X-Gm-Message-State: AGi0PubOwr7KLotUfKZGZ9yCHM4e2V36tENwdBvBCFLTo0zIHEV3W2TD
        FLR+XwhfOQbp+c5BF5gfz8nYVqJhG+m5P0lU
X-Google-Smtp-Source: APiQypKMU1IIRbXXOX7ZyvwbWFJXHKcSefqZALP0aOt7baR6EvEdcg5UT0zqWOvkir+IkPg5Rc6TiA==
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr2747689edb.24.1586479673383;
        Thu, 09 Apr 2020 17:47:53 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.googlemail.com with ESMTPSA id z16sm30523edm.52.2020.04.09.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:47:52 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm: dts: imx6: update pci binding to generic name
Date:   Fri, 10 Apr 2020 02:47:37 +0200
Message-Id: <20200410004738.19668-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200410004738.19668-1-ansuelsmth@gmail.com>
References: <20200410004738.19668-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename specific pcie property to generic name.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi       | 4 ++--
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi | 4 ++--
 arch/arm/boot/dts/imx7d.dtsi            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 37c63402157b..55bf77fdd65b 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -328,8 +328,8 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
-	fsl,tx-swing-full = <103>;
-	fsl,tx-swing-low = <103>;
+	tx-swing-full = <103>;
+	tx-swing-low = <103>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
index c41cac502bac..45c7edea94da 100644
--- a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
@@ -392,8 +392,8 @@ MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
 };
 
 &pcie {
-	fsl,tx-swing-full = <103>;
-	fsl,tx-swing-low = <103>;
+	tx-swing-full = <103>;
+	tx-swing-low = <103>;
 	reset-gpio = <&gpio4 11 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 4c22828df55f..0ab55f66ea79 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -190,7 +190,7 @@ pcie: pcie@33800000 {
 		assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_250M_CLK>,
 					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 
-		fsl,max-link-speed = <2>;
+		max-link-speed = <2>;
 		power-domains = <&pgc_pcie_phy>;
 		resets = <&src IMX7_RESET_PCIEPHY>,
 			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
-- 
2.25.1

