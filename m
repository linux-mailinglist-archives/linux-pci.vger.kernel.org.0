Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D122935F4BC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 15:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbhDNNVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 09:21:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12542 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351293AbhDNNVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 09:21:53 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EDII47023304;
        Wed, 14 Apr 2021 06:21:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=hM0mfHP/8PPVvLLab+h4xZmy+FcAlY75PMcmenqyIis=;
 b=e4AF0MAPcwZmmGPegb74KyoHamVS/zrlr9ViCw+OX31RrBu8JrppokgLqxmA6q5Lu0DO
 BSiodBdQCZ9JNfB3X8Wxyw4bq5QCWjYnDhwb0YlPobUjWeppm806c5ufRNgnGtyk1U/F
 5NU4rvN0jKXousx0ummL0p/rsK5zwcOmlgidXWLoUghcGGPdc5gclDOqDKjR92/F5GWt
 4HYhs6Pm8AreM79UkpNwPdDJsiGttMajzSgGv8cU99g6iHsfzat4n/uTdjuT9aEN4DsY
 6soLm8hAXZdKHxb0cA6jBLeSqEAXwAq/lHXdE1kzOI1iWdR5zKjza/MIGDM0GYEhwNd6 /w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 37wqtm1swf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 06:21:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 06:21:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 06:21:19 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 6AFC53F7045;
        Wed, 14 Apr 2021 06:21:15 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=20v2=204/5=5D=20arm64=3A=20dts=3A=20marvell=3A=20add=20pcie=20mac=20reset=20to=20pcie?=
Date:   Wed, 14 Apr 2021 16:20:53 +0300
Message-ID: <1618406454-7953-5-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p7_gtBD-RNQNkH_SBfi2yiwINBSNHiIV
X-Proofpoint-GUID: p7_gtBD-RNQNkH_SBfi2yiwINBSNHiIV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

Add system controller and reset bit to each pcie to enable pcie mac reset

Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 9dcf16b..eb60e73 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -11,6 +11,7 @@
 #include "armada-common.dtsi"
 
 #define CP11X_PCIEx_CONF_BASE(iface)	(CP11X_PCIEx_MEM_BASE(iface) + CP11X_PCIEx_MEM_SIZE(iface))
+#define CP11X_PCIEx_MAC_RESET_BIT_MASK(n)	(0x1 << 11 + ((n + 2) % 3))
 
 / {
 	/*
@@ -513,6 +514,8 @@
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 13>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(0)>;
 		status = "disabled";
 	};
 
@@ -538,6 +541,8 @@
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 11>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
 		status = "disabled";
 	};
 
@@ -563,6 +568,8 @@
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 12>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(2)>;
 		status = "disabled";
 	};
 };
-- 
2.7.4

