Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9735C9E9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbhDLPb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:31:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20124 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242880AbhDLPb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:31:56 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFUmHQ024618;
        Mon, 12 Apr 2021 08:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=hM0mfHP/8PPVvLLab+h4xZmy+FcAlY75PMcmenqyIis=;
 b=NvzmVdaDTX7SIxC5N+a9C+XhaKqOODONJp2dp0zFdiMEOriFqTOeZGPVSMbJdagT+PdA
 XZ/PTa8i6tEpu4obQQXen7PD1cwBeEKeqWwjzEH5UNACuB78otr79QELNqx7zEELyZZJ
 nYoXI8d9caarsmbHQTbZ+eshRVkMuGL6HiozYlBXL6BU/itHWY5nZLYTLNoYvNW3nsYJ
 041bbbig+18XmgcSpoKaMjCU2mOr5vqiLqNALMF1Wk+Aesi/mzycGnAEpgF3TMRMFU2h
 o2ikoInRcNs+oWDsI+Saikhuq+haGqYFUyym+SVpJ4cbjqXisVFPax+5wdRObd/y3pnh WQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 37vpuu0d5g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:25 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:23 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 9E8273F7040;
        Mon, 12 Apr 2021 08:31:18 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>, <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=204/5=5D=20arm64=3A=20dts=3A=20marvell=3A=20add=20pcie=20mac=20reset=20to=20pcie?=
Date:   Mon, 12 Apr 2021 18:30:55 +0300
Message-ID: <1618241456-27200-5-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xxF7JF9ABn3SlXK77lCc09HyVPk6wxZ4
X-Proofpoint-ORIG-GUID: xxF7JF9ABn3SlXK77lCc09HyVPk6wxZ4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
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

