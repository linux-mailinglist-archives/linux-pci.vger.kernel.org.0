Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B86354F44
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbhDFI7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:59:18 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:61025
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244702AbhDFI7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clcCytyJYULHWYi2HaLK038Bt2QqFstnApDrCrOo6EkaqVcEv3QAa2PxU8D+glaTZcKc62h/YyJi+QDjkM/lPKGhPe9bsrX9W/bOsFsCmi+Iu96QFK9WjaSIZGh0lf8hlXWvK1s/m4dnG8VOkFwU7lXP5Pss8yi56PZKhh4d6xCcZlaysjV4hb94PNGJchdzEHeK5IU44EQlCc8ZjdbkZeIwHHMbzjxIVVC7HYTNg9SA4ssbVVYXeYRdqqm1bOqcw2dPWAKaWRpXuOnxzfPkd7LdZAGD+3qaXmhvsbHTq7R2uvdf7u5bgveZN7lyTUjkt3VzqO+4hHg+K5VBuwqmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRr6s049ZisAC/rwU9lpizSmmHp4v+mlbbmWq5auA8M=;
 b=TyGIjlE2cJE/M5Kn8sepcnFEGuHOPdWan2QFStsY1TwPO+3aoKXHcEElAyfYXCEHIr1qB8EJN615txPj31jW79PDA7XxfcxslliIkd62ACQxgX+3EnOlJUqP/ZqAB9pmrtBr8YAhm+k9TBMw4tmm2zPi5NtBG3Xjaj2ITpUM3Jom0t3rKEfASL9V91gJTa9CCBVz5qXEbzNq6NRqWeTa0vpDvrDq/vDZLW2w/9sRHZqa7gxbc70mSjpSGuPA8BSgZdyyTijYUeZ2MdnlCdDXrHrO3RWJq0ZmkIgFTi0uAlYVeLIIIoty1aky86N2jIYkwLYaPzXhNhuMomV6Iap0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRr6s049ZisAC/rwU9lpizSmmHp4v+mlbbmWq5auA8M=;
 b=GSbDKVSX421Lc9yYaGjnJM9Al20RoIsQzhI/oiNNIwOMbqGRKXJBpHdSmOiLJ7+yXUE4oY8up/5MGn9xxxp6h0EuvzBWljk2J2ZYppbBgIDYE2n8sAwBvHNfqRSbsKbQXwWvQux80oaBHmO9Z5LHQIQ8r3j/WdTTfjfuh7MwCuI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 08:59:04 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:59:04 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 5/6] arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Tue,  6 Apr 2021 17:04:48 +0800
Message-Id: <20210406090449.36352-6-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e3ed4f-375c-4245-060b-08d8f8da32fe
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2297D63F416C2890612B5C3884769@HE1PR0401MB2297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp+OI8a9fFbTQps0vvdsTfhG++qX30SCPS/FHs3VTmH3gkCcJxNiKPFYaQBXIHNcjodv3yJJDU8HrfcKJyVoZLjxmsUgpvF/4kYbqphUkhC6psrAhF3y2uDMcDI5Q2atqtFFc3eXxYd3EKvhVVMbGuyxi0wVdp3R4vRI5N1/4EWUjVTlBylO7zH6L6GhLnGFYy1Yu5ef41MdeKpLM4sOn6jEt/uf+F+2ofUBHox88cO0akB7MoXLuv1aURMFHpRrZxObtjf6lmRadCzKzGEtUrviub8JRne3H9PsUnThXbNwtVqv7CIFuhoHhF2ojkqmX+FD3gPPnWo3UULrQzkBALtj/Z7GT5Cp/1fNw78vGMz8bACCvl/TzkS86+jLb5ck8Bg72aGgnd8sA77YmplC9zPu/O6L0Eui574p1Th3W9ocy/VCuczb71M1euYRz+Lb2lP+H6zNn8nTEIKesXRCKTQac/667ncu+nyfvuoeKDEfZN6ngi1s2f8nIGHQSOS6ke/5i0NmizoOC8a3pEWeX5qGcODJDKx6BNcI0M0Z/ulxOydCNlKB5QjZYjCsNOc3Ph6gxDbDQl0tDm74CEdTf/mFa71zvNvkO3vkxknkTlHGvVV+wQ458DHLflLAWZwMUXPAQWE7VJjzQzdw1NdCdfnYphlVXDR/SbJVpB76WnkB1PJGfF8q01/iFx3dBE5a0iIyPSSi4R2pC2Z1AWhVJslD07uWbki9BCraQYXkHs9GFSJvEMQUwHsOy3IGk3iM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(6486002)(2616005)(5660300002)(956004)(66556008)(66476007)(83380400001)(86362001)(26005)(66946007)(16526019)(8676002)(36756003)(38100700001)(186003)(69590400012)(2906002)(52116002)(921005)(8936002)(6512007)(6506007)(478600001)(1076003)(38350700001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MWHxWEeFIPg7Msvo2GnmniGINmaj5gpObtEN664PkfZIrTv1+siExh/bHsQp?=
 =?us-ascii?Q?GOt0yYkYp2TkW/WkH5IphsPW/NaikAfqJDlE+/2stqHyopS3zPDhDSmipRYJ?=
 =?us-ascii?Q?M1fMJkAxU/bOAClU73avPWzB7tpVuNfICFhyRKz2UpK6AYavkbG6zB5eIHlq?=
 =?us-ascii?Q?zqUVwPdZAvrBVfALPdsHiUvhnKMjXisTpuAaXRRz9raeegmOn07N3mfkAkaN?=
 =?us-ascii?Q?b7/Hz70mlkJX/1Pp8W76rRJ/BPhIJm8KicBCZPI4syzl5vPQmUDkVgudySNz?=
 =?us-ascii?Q?EFdyy/08CbbFI/F5wC8BINDNaskG4ZfEHmnut5YaaWCQjJAC/jvzwH1NlKal?=
 =?us-ascii?Q?WGfSPaw9ApOIz4Bjtl1w8YaxrxFPZTrNTEMhESch8Chmu/c022A8EAa+EYkQ?=
 =?us-ascii?Q?HlM9tYsTlG6jVlkW63Gg//oGAhbvpKm1WVTN/VGi3WibBbDH+VbOKWY77KDd?=
 =?us-ascii?Q?VsrtK6Aa9J7+/R7InvHfcCOL1XmzAMbpCzSiB31Ti0OiDRYcGKZbiiC4cNHN?=
 =?us-ascii?Q?BKX/T4lVJaGPzFvhsFa/GgLuu/Kp8Q2k90aMNbnHqNRqJlep02XfHky+0Aom?=
 =?us-ascii?Q?wfMu1h8FrCctWF4OCmxkgvUmmuL0i+2LFl5yzHIAxeEuKONxxG3Uj94T6EvQ?=
 =?us-ascii?Q?sATameCXEbBqNjy8OjkOk6nQuhUd0C0kpzFB3WbTcBgxvlV/YhYIO8wZQFHd?=
 =?us-ascii?Q?lmSX4q6C7cK+lZz+cTaCKZB5DEPBPr4F9veo2Fc2kD/qHNBm/Y3HtxA6jZZ/?=
 =?us-ascii?Q?evJSyU0SFx7KCNXllGGkbwXyXLpnExZ+hBAcasB+c1j7+RhPJRPm5gkNmC2e?=
 =?us-ascii?Q?tDtFkXyHbQZRW+fqmC5mkT/hawrc2aSN74yUFjzPWbbP1uQ4C/up5b8i4jEl?=
 =?us-ascii?Q?ZUlpiazPGDUhla1Ui3LtfcItnuBXs3Ihik6jR5n33hAwVlkhNqhH+Et89n/m?=
 =?us-ascii?Q?U2PBh12H/wP+TgB0cT9S5OK9MNN7JMUsisCwEesBChCXgdFp80tRtsrFicpT?=
 =?us-ascii?Q?Tz6Ub/fSD5jQOnauJhHjda7mTolzfnRg1xXtLxQyfqSvfOTbKpzI6w4UM+mh?=
 =?us-ascii?Q?9+82U0T4B/pBg7dH4RnAG5AbfJjOj/VlewmjIUgxszNsVIhBewUyIuoiHYgG?=
 =?us-ascii?Q?J610+1PTlp0rEHkOSZvyzjd2Mx3b1WIh51048dmjEEtPvKlvGIPv8UHdJ5mn?=
 =?us-ascii?Q?NVa5I3b1JYYeoC16pX5qbDK7ZIBBAWI8git7y39eUxEIF4KA6iSBNaAwE0qh?=
 =?us-ascii?Q?uMFva0G5YmaQa39NiMEjk+WVhd4FBt5p7dNeN2XqR6fWRrM2A2NXjB9ZC0Z2?=
 =?us-ascii?Q?8X4IJ+2yUaXyCLEW6gmaprZx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e3ed4f-375c-4245-060b-08d8f8da32fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:51.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiwpLituT7CmWow7REoSfpWuGk8uOWPnE+ILvT0KsdVKADyjpF2g2aF4V2it04PTHhvTo4FysYhKWdsB+jws2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller DT node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - Rebased against the latest code base

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 46826752a691..704e9e249729 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -875,6 +875,7 @@
 			interrupts = <0 118 0x4>, /* controller interrupt */
 				     <0 117 0x4>; /* PME interrupt */
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -902,6 +903,7 @@
 			interrupts = <0 128 0x4>,
 				     <0 127 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -929,6 +931,7 @@
 			interrupts = <0 162 0x4>,
 				     <0 161 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.17.1

