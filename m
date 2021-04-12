Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A535C9E8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbhDLPb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:31:56 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50708 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242898AbhDLPbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:31:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFUnNG024627;
        Mon, 12 Apr 2021 08:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=GymurhClTLZ4ST/n6Oo2CGklmnbA31pLqRq8fnRk7Yg=;
 b=cItsbCT3D2i0nD2xiPTTA5PGk2PQJGfSUoIrw1TR0UmN6x2suIhXj7aAw4iLBPuJC+Zm
 iLzobZlbS/CUAP3YxUkaCBvAFHVkKgpjRtVNZb1VkA8ekgrjv9CDholqalW/MtoqND05
 o7QImIRnHUxmqmbDfkHBAtmZUNZsemNWCTDFtbhyR0/jWyTuPAVvYGAYv1NILIXeBrN0
 0BrOwOSnm+W+kCb75v8Hwo8zq9vg0jgYx0Bj91lZiNYgBGwYj8VH5R5UQXD01ayCAEhI
 HqwPaRQIboe/Ufs+SHP9U/GnxwJJmeJO981Jx3Mn4nxkIAgMhWN6vzPDRlAMXY5lzAK6 wA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 37vpuu0d4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:20 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:19 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:18 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id 3EC3B3F7050;
        Mon, 12 Apr 2021 08:31:14 -0700 (PDT)
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
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=203/5=5D=20dt-bindings=3A=20pci=3A=20add=20system=20controller=20and=20MAC=20reset=20bit=20to=20Armada=207K/8K=20controller=20bindings?=
Date:   Mon, 12 Apr 2021 18:30:54 +0300
Message-ID: <1618241456-27200-4-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZvWg6RacSjyd6IIIF1KGIgKw8aW92UQF
X-Proofpoint-ORIG-GUID: ZvWg6RacSjyd6IIIF1KGIgKw8aW92UQF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
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

