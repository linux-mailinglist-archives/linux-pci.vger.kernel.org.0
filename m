Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D647129A5BA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508041AbgJ0Hpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:45:55 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:55521
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2508036AbgJ0Hpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7qgEeUgY7B4+0+oVrzv/Ofz1eDpyFV8TuNQr852p4bWx43Tz1TsFmmkZ38cn5QAyLoe0ZwtKRtf9D3Y5xc7Tz3CAvWhBcqy32Q8xsIBwhKecdvkQ2XeLHeS0i/tUJbpGBVYrwruPQHwdMaU+7xlM9piDPaoBjmAsXDlouMx9sAPRAPvUnu9/OLa2OseowuIHgO7ofaCowu+4FEo646pTx0O2UuCbQwdRD6CPOgRVUc0EvvTket9sclpSb5chBSsWSt/dt/oLCiKtqNrZsOxhcUgPk9pCR62YQF5F+RFHOQhnhBKJEc2uVTgul3nfiRK8V0iO/mXoJuRpYeAKdL++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze/uanjvDGeOjyHQEzfhjx0dBZ/4oWSUNg+9UOaFCtk=;
 b=SLNRAiPJfI8VhT1OttiJhm9v0H0OGFdxSg1cYXOzbgCD1SCpJawkgD8khD5wRMQLCP8DrSHbJkV8BS5WPfeROGIKP7PNooT1kd0Fk64yuUO7mk+SNpayqAcCsMEOwIu3SieFA/bSjUu+PwwUG2NDEtXb8XjuANHwqisYLR2KZchcRt6dauCjludCLgh/DdVvAictcJPXPC8TuS83dQoaDqU8NJG/UZ1u1fKi7tDSrLx3T7U+Hnjj7Q9G6dnYThOIlyf9d64EWSgILFJK/mSLEiB0ePr61eg/fo2ZIgbQp356lG+A4YTw5/OcaHeVVwK4Gxnzb4mfgJ99Xng7BEe+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze/uanjvDGeOjyHQEzfhjx0dBZ/4oWSUNg+9UOaFCtk=;
 b=qO/NjPu64XIWOXhhOF7rMGPi9hjjVi5o3fSlfUPA/cZ8x49YEG24F+HY/XC7O6JUD7f6wTPwpOFjILr5RLjDUiyUbShu6uXBadAd7BheB2jYA41HBjLcV/ID6CDMP1iX4kFgkg1pI+4SdH4ij8f1gpkGycNRAnJb5+sW7ymK8/I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:44:14 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:44:14 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 6/7] arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Tue, 27 Oct 2020 15:30:00 +0800
Message-Id: <20201027073001.41808-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbce7ed5-476e-4a53-93b4-08d87a4b82e0
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3371C94F593FDDA33D7ECEB884160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm5Bi235PWHEKvvNAqF0Ay2Jmg2/Hw5ZCznAbodrXsfyKXQuXldjC/37kS8C+uf/d5eMm8jTz/UtoIBKZ2cxbUYdJBQ98ZyIMPcybgadl1acJ0IpEbzcJIHM6SuSoOrztQXD3SgBgGOOA0NthfHALgRfPnmJed9Sd/pNdbsuYNI6P/6S2lxM2YHeENWYAEc1+Q6N7xB1B3HEACdN0Z0wN/kO1cXNi7ZkSopzoVWW780yXGFJt+ywvLrbgTF09sP97zvqOzgt3ZD/X1HURszHB4tzoqnimSFHWdGOCUCayb10RciO9jgkNj8/gnRsAHSUwwkUhdb6oKOchEKafc6GjuSu3X3JQQ9Vf1+VEzqVE3RSASzW5anfXt3E7iipI/wU0hHCSX1wL46k1OgeQ+gggg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(6486002)(6512007)(478600001)(83380400001)(36756003)(956004)(2616005)(69590400008)(66946007)(66556008)(66476007)(186003)(2906002)(8936002)(6666004)(1076003)(8676002)(86362001)(5660300002)(6506007)(26005)(52116002)(316002)(16526019)(4326008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JlRnMlKrqrzRfsKX/tWBDO1Iq/cbYOzdkxmqT/mv98tzp5HtZzUYqTTgSx+Z3gpAUuLa6k2xRLyTFh6iN4GWxYvFK7FxEAbPxqY48L2DZno1eEQwnoI52+lM6uu5iixG72a6guWKK72k2JV4UvemEEtgfisk51VOD9Tw01bOXcGQHH3RZ9EzGl6MyijSXEhbay+OtBa7DleYpHLXWjjl/eQw9MyEMl+RBCbdnMaGZXtGycr4Q9GvIAudVJ7Etbh/PGEbJPVkCJ34tM0AgxPOp5riFVr8JxgQSdIy/B4mVUiFLM7GKu9mXL5TZlhK6L5l0ysQj15dLth7bITZLKYf5JJyWBLidZJXBaYnTog7BefoNxq+jiC80kDVWbRId3jgBegcQu1yucfBA3q7XHnqT3Y4Yg1hdCxeyGhTF7mfk/2q0j6yt9AQc4qRqMR673cRmiZmG2vfBlL/OVq4DzinclDMwdfSbu6q44rhYHHbjp92FlrMSF0cqlwbJuyqQM7rLJKLBd8PfavJLvhaYvyBjGB+3hV+2aPjU50BxrtCaUolTGWc+goIrchDy+EhGbqoyDlkXNmnB5UyiWFFQX1NhXyXgfjE4++kPmN9uZd7Ntkd+70jEmj8YHeehU1zEJ0dHpDorDXQUnlrnhy3yaHSZQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce7ed5-476e-4a53-93b4-08d87a4b82e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:40:01.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39xx/b/plkCV1K99f7Zxt2dLpqFBC831FWJYl0UxivOYFPaaBPnzYfzVW1WuL9MDcSsiZC3uLQzPG/Yu9J1U5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller DT node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Correct the order of the subject prefixes.

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d33a64ae8b0f..23bf3796d98f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -822,6 +822,7 @@
 			interrupts = <0 118 0x4>, /* controller interrupt */
 				     <0 117 0x4>; /* PME interrupt */
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -849,6 +850,7 @@
 			interrupts = <0 128 0x4>,
 				     <0 127 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -876,6 +878,7 @@
 			interrupts = <0 162 0x4>,
 				     <0 161 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.17.1

