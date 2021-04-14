Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE735F4BA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 15:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbhDNNVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 09:21:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13864 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhDNNVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 09:21:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EDGEr1020572;
        Wed, 14 Apr 2021 06:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=GymurhClTLZ4ST/n6Oo2CGklmnbA31pLqRq8fnRk7Yg=;
 b=Tn6a73rZ0cIRXAe9X24yzdxGBoX+lfwLF1tdiHyglQAxRJe7enBJf584xawLP59u1Q4m
 sdSo0mtzhIEeVD9PlOs9vm1AzWKSJeIGWr9QvMGasb32Y79AavVpotF61/pqldsLFhPN
 L4octCOqcl8Q1npTXRlJc43vctBA5F5AQG8/Zo4Mj6Cu0TeBBpyzzqSuB8mbtHSZEh75
 K53YVF8pIv/iTjX8geCmdAQtALUUwdk89nunVOxdt6GyZn1GR60uidgAlzMgBBJJXn8I
 Z+Ppvu45rCHJu5UGPfc+s1slbYuRqvRpfwa3x8yHEWhAdc2ppE7m6o0T+pfpavQ4rPYu nw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 37wqtm1sw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 06:21:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 06:21:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 06:21:15 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 0B3EE3F7040;
        Wed, 14 Apr 2021 06:21:10 -0700 (PDT)
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
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=20v2=203/5=5D=20dt-bindings=3A=20pci=3A=20add=20system=20controller=20and=20MAC=20reset=20bit=20to=20Armada=207K/8K=20controller=20bindings?=
Date:   Wed, 14 Apr 2021 16:20:52 +0300
Message-ID: <1618406454-7953-4-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mfDONwb7ygtDSHLNtSxgPUiQ5HJDAFUC
X-Proofpoint-GUID: mfDONwb7ygtDSHLNtSxgPUiQ5HJDAFUC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

Adding optional system-controller and mac-reset-bit-mask
needed for linkdown procedure.

Signed-off-by: Ben Peled <bpeled@marvell.com>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index 7a813d0..2696e79 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -24,6 +24,10 @@ Optional properties:
 - phy-names: names of the PHYs corresponding to the number of lanes.
 	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
 	2 PHYs.
+- marvell,system-controller: address of system controller needed
+	in order to reset MAC used by link-down handle
+- marvell,mac-reset-bit-mask: MAC reset bit of system controller
+	needed in order to reset MAC used by link-down handle
 
 Example:
 
@@ -45,4 +49,6 @@ Example:
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <1>;
 		clocks = <&cpm_syscon0 1 13>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
 	};
-- 
2.7.4

