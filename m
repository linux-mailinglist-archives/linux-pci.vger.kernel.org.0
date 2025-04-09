Return-Path: <linux-pci+bounces-25587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C3A82A92
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0347A508B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5B266B4D;
	Wed,  9 Apr 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMwSm79d"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C825DCE6;
	Wed,  9 Apr 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212938; cv=fail; b=Kwukl7wjJAoZ+EjnjWKTFtT2WPP14SEcL+BtgMD3Wd1XXDyVuaMJDute7yU34bZ/+w+w61KtoFGT80BzIKgygELovwAfWB320o7J9RgI1jI7brYKy1e4GaQWxZcVFnzw20+bWP5ZZ6hdCdf61y4jHrffe52AuQqYtkX8lH0uidY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212938; c=relaxed/simple;
	bh=cAcTYBcFEONkOvhJW+jujZ/YX/oASJ9fHPslYKpzvYI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kUKVi236WiyODhOf71lzyIizkUb0mv9HWR7BpIpRvDA//k77uYy36nT4vtbqCQwML7seNOiPCy06PoDOzjE5MVDnFAgOSnqc00kEf22lNSzsq8sdVOchH95zJrEEhJCAow8EtQjXPwOO3+JJQuLOMsCbidK3u8+6NWXpY7k/SQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lMwSm79d; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v791GgKLs4C+XXrJYlPdkGL0kx2Ahn/SUGGQKgqigllFR+daIT2vg/z4ZSfKgQwQrKnDhhHPFnFYbPU0d3XELA0iZIzepZBFkFpMXOgwRVGMkD1PwizwyIrsOvV0JQLFkCsJWVKaFieqndCTS957k8b5tjJ4kfAt9gOvisCF6Oz4g+I7M4C6/c7b9rOPURiXE2rWY1TYm+i9geYVkJDNDJEo/eatm6Q2DO9HOtSGGpBoiomGnF3yhNN/tBVhl9YvHeEoq/BSMZEmUe3VsrkHGO2cVlj0fVxuRvdxmtktycf1AdaZQIdMDmfUo4AFMqYj5u/TrgEGqkjMOKAxwPwMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc+tlFVQY7L+y+6uxvolXrEzDyZFImXl/Wda6ws2u/w=;
 b=IEM2l/9pMXNQypRugAhWO9NEM3NzrIT+NZ1uCha+DhQsp9xDLDpxnbh+PjQUa1pexEQiQtdRNUay2/ly/HPJupNhCqXEuvr2pX3ZBfNEQnSz1xYBgqMqsPw8U0083Y9F0W1g8DKButKhMJcWhqMu8EfsWnD6D8pZio3/wLcf5YARHi0T88yoGX4KYKiWXx8LqbRBLEpzB0/4lEwpeNu7Cw87kzckYdUdq6/lqRYMy+z0AUs6l4A07wmrmm+8C1YJLvf9T0j71K9tT/Ks38mmVjobdIoE1o1n5tMoz5iG/NJw7kw0EmpbRsBjFINteStoxDidTN/1HMlHwIUXfO5UDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc+tlFVQY7L+y+6uxvolXrEzDyZFImXl/Wda6ws2u/w=;
 b=lMwSm79dAFoQj8jHuUAbxHC/qwmFpyBMJqA1JtuBy73HmvgJ9vUXhQF3iK5AZvMWsbdCgvWqcSX4OY/PhGXUY3Yi3awwfqRl3mO3Qvvde1siXSl40/tCQ7Dq73OsEPRiJm3QnUf6G5fX2cGetoErDh+Ss4Wydb1UYcXkm7aeE01QwdF9luEq4eyUjTMx/4vNXMr8gvRxlOdVa7SudMIiZgfI4ENqLEpdy5SVo/dVWnDdxSTe9+FX0LHn/h1XcWrvTBqGNIkktQaID8PnS/lMV/LbgT/3QJKPapJSZf9AIuPNjKp3hOZAGOHZoW1UxgdQ2ihqxMOfJVJOxEJwqQRdBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7973.eurprd04.prod.outlook.com (2603:10a6:20b:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:35:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 15:35:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: s-vadapalli@ti.com
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	tony@atomide.com,
	vigneshr@ti.com
Subject: [PATCH 1/1] Revert "ARM: dts: Update pcie ranges for dra7"
Date: Wed,  9 Apr 2025 11:35:18 -0400
Message-Id: <20250409153518.3068176-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5661d9-f77a-40cf-2355-08dd777c2ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SyrZafYZKkKN7SRO7Wsg4wjR2e2WI1IJMBM73JL6DF9Hpqy728s7p7WbrMrO?=
 =?us-ascii?Q?Bxkr6dzp0zqZHWZtNRmhKOm1zfimIPLX3MY2GAeA93MfEZsu9LvPKVvAOTyU?=
 =?us-ascii?Q?7LjZwRi/8AbVtYk8bhiYWIAFaKEuNyx10E9wiwncgonKbPLP+P8mBgb1PeJL?=
 =?us-ascii?Q?8r8xueWkmQSH4ILAcz2KA/ceLuaLv8oVcabFlFHOikY8/0KNfD7csXDQ/MmD?=
 =?us-ascii?Q?EbP5aTt+nnsXmt8GpbOH5Mq5BK3PGQjb6r7hoYgIVp5RND1cJieXQ/nW5xqH?=
 =?us-ascii?Q?mOTy7UoAlX77Y4Jlny8vKXiJykch7ZNIU7j5sgWIXvmCaeEuytLDAFhsjNI4?=
 =?us-ascii?Q?2dsqqHtitDX6dirvIllaEKXaMc00BZwC7/Ta7AQZ5Jxec9sz8XiuMMiP5sHK?=
 =?us-ascii?Q?stmn5bSbH/HRNXZBE/85qNKZMS/Hz2KPPq266fvi3m5uzBZrs2mV1pAhjRlQ?=
 =?us-ascii?Q?RukIKxsK2/n0S8HPg6P/lodoatdqeuE6bG7y9f1Pm4ZruP1Un1CkzJOYFhSj?=
 =?us-ascii?Q?KjXQfpm1RRu38SjC+Q5tsht4wNkGEaQD8vfzbVZZvMaHaTOkDMbt1V+Qr7R/?=
 =?us-ascii?Q?z/q5mFC7UJ0diDolEqAqZ9JFhQmjQqzek7M2oc9dW7UGjMtudvtkQ68AZm4K?=
 =?us-ascii?Q?KNOwqR3w+mUT5GS+qljBlsNl59nsdSHh2e6t4q8QPTYiF3+kQmeEqla9ihdK?=
 =?us-ascii?Q?RiVCfP44HklX7AiGWAOQXLWPvgIMf2wsRqNjeZjdQYmBpgVoqZPGeU2KeMP5?=
 =?us-ascii?Q?Qv3MmOOtmxt1EnjbyFtQZi+pKWa3jU+L3n77/kdNe/t5EIaEiWewzC2V3xNU?=
 =?us-ascii?Q?FktRUvsGvMfhUdG+cQ+6lxtKmDq6hCb4XDESHl6Y/1S5YiKocgsS/QOgfbiM?=
 =?us-ascii?Q?3qQ48+/GWWFQRrx6yTaTzVCfbJwLPRWYC2MmSJqKEOzt81wpC5zfnMBFVIDK?=
 =?us-ascii?Q?gmJiLENvlFZWxzuP/R5QhOUBHiSI8FEOru7cgrvkRRszMql7RokR1Vru944a?=
 =?us-ascii?Q?vYGszzFlNJxjoD5aC1medK9Z3ySJzXR14n6ZJi/54XL4GMjMt7oViw6Yc6JD?=
 =?us-ascii?Q?ceSlO3o262fe1kDYKQnapyV5M+cpJuAKfWhMvUyLhVHzJXfgn7hASM4dxIdP?=
 =?us-ascii?Q?wd4NFwM4K5tuRZSQwuFsPsxYAIpytdns5oMmrzFwn2CHuTH5ij/dWnYAS2Mk?=
 =?us-ascii?Q?UOjL9SFSy6ta0xwoag2NbUFx/Lr0lMSdfTG/hvpx1RmiwO9ir6EFjvlAH7Mt?=
 =?us-ascii?Q?9+4j2RMBp6zK56OOmwrbK3FFSNlIdnqeFrrgiWC14DadTVS1CWTnr3akQ3m1?=
 =?us-ascii?Q?iyhc2Bx3RP4FJCEGpstWw7IohZ5BXqaICk1AlKcKiY7Xv80N1olnzbaHEya/?=
 =?us-ascii?Q?p/AbZUUJkZfISDKDnlQXpNyKp2TzXjL1zPEemNTMM4KCxjCw84fqH4O6XTu3?=
 =?us-ascii?Q?wuFxDVtVSxqZOSlQ+4umgAmQOy7O2J8pLQF/fZQkxtkhbmny+06gzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NI0WiECNJSOPEEHmJ4teCD5t3ngSL4LHaSx+kSg0SpNbUnPIc4kCm3N5HvDJ?=
 =?us-ascii?Q?TjyUdaHl1bSfaeBbkCVSNxdlYY7GoesLesIzk6+vxXw/0AK8xs9h2mBdc7eJ?=
 =?us-ascii?Q?NAYcv0mGm21sdzoz4m7z9r61+o3rh3IqxDnx+36Chmns4leKFlQ2Wod1l9tX?=
 =?us-ascii?Q?MXVdYLQJTBjwEcEGxFwDsnEpyyq5lqk1HaA5tS9uAwa0OITBXlPUOl7yUExS?=
 =?us-ascii?Q?DZLoytNZOpyNmSc/CLqT4sJkTFYEyjgKXWUJvRBdUiRBLdOphh2X+3QNPI5V?=
 =?us-ascii?Q?G/tR0dcSAb//QkFkL47bM0nAfucFDiduAl4e3RZa4Sv16tCRJ/7psrW/58H2?=
 =?us-ascii?Q?179QB8mPrMmrqHMKdkbRd3ITdkJK7RZpx2TbW+gd6lopXk6f3iqhTAPsATwi?=
 =?us-ascii?Q?6icni9gc+4lCoDrV0iqWdtwDgSiVAQHxf3LTfFMuYEWoy+AhSyuATfZtXipd?=
 =?us-ascii?Q?9E+cNtnxvSImFxl27cp41+NBjQBBdW6KegeCirKsfRu5Z3NOTVD1AYscf01C?=
 =?us-ascii?Q?2CjZoCKKzWKrt80QmtchIKKWuxWCxSrWaJ9VkMZ/zt+PK79JfEaRtlvfC1fI?=
 =?us-ascii?Q?amRkyqTd2LVlWTaUZb1gaiwaPPlnHGIGhizWT8PDIQxxraWFH9Xnm6UDEVxe?=
 =?us-ascii?Q?4ObPWxgnwXE955Ayq6wj9g7X1nnVdEWpuDNxRxBZxPIOCVIZYfhbfcaDsBJ6?=
 =?us-ascii?Q?2eLW+/1kNaCXTqcAFDH0fAONsoieSyjseXhumynChKu/a7iuAzekdhPXhMbk?=
 =?us-ascii?Q?n9XRyWO+yIVtoaIVv2bOPFcoZGAZeg6lcCtQzOebaqJ2btrxNJOSb2ZwDpOa?=
 =?us-ascii?Q?PJJIhAKUt9GF5Xv+Zz0t/vF5lhqXZG4nOMFM2qtZMxbRvTnz86uvfunVsWch?=
 =?us-ascii?Q?jwXyDkdyaCEN/iPs29QuRquMSrSKx2NLhiWNh28vg5Ce2wrEsjiOU9XUq15q?=
 =?us-ascii?Q?BSG7V2pc148xNJbDl7R2WGK+vkFc1//9YEPWSNrkECtrSE2TRgvMMhRrN+DJ?=
 =?us-ascii?Q?XAPqDyKVsIet4qfdShd8/p3TQncX6wTfKdX7udmJBPvg1dTuoq7mHDsaDRsb?=
 =?us-ascii?Q?XboBxYzr2SBmRAIOjpiIPSNuN8CHQmqlXCqeheZVshsH/0bcoUv1P8H+yG7y?=
 =?us-ascii?Q?ln3aW6t2CMsezTCoJCE8iYAkGRU5NZwlg0dBdI5VGUultlS21odADHoGi1hg?=
 =?us-ascii?Q?BlivlGBqELlFCcuM2K9Z4Yv/br/M3x2OUjyB4bY0FzxTzTsX8FhtphifCBXY?=
 =?us-ascii?Q?kmrUNVu7ezg+NDZRBZCIEJ5019iQ7FZfMH8LCbs9VTUK6sj7MlmHpzg4qhmi?=
 =?us-ascii?Q?xOZsTOCHQ/sa9gcL2dIakWiygzf9JnUbP8iyXgKgS2evOjiJ9EQfheZS+Y/N?=
 =?us-ascii?Q?/DyWe9P7T6BL5++CILQwy+wjg0nOADWnXwDuIqP8MScWgSEmnXLzUdOvJqZ5?=
 =?us-ascii?Q?q0cSVIaqSjMJJPNWwjuaduAvB9UvjWEncwo3e0S2/oy/XeN5h1IjkJ0C7Ks0?=
 =?us-ascii?Q?xD7yhoL7Btbas/dV8ldKLiTN1dbXKU7kkyi3aHkPEPhTWScy+KKMn+Ul8j9C?=
 =?us-ascii?Q?0CrJL6xXuE5NGN+ukRQQLf9p1NINXBZQ4EInfzQt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5661d9-f77a-40cf-2355-08dd777c2ad8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:35:33.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEaT63I6npnYNEvQc6pBly4T+VZqxP73o78ZBhMndp/1JAPbXmWuRQViUTc26P7EbiLA24q7fkwUkbEh6ndMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7973

This reverts commit c761028ef5e27f477fe14d2b134164c584fc21ee.

The previous device tree correctly reflects the hardware behavior.
The reverted commit introduced a fake address translation at pcie's parent
bus node.

Reverting this change prepares for the cleanup of the driver's
cpu_addr_fixup() hook.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Previous disscusion at
https://lore.kernel.org/linux-pci/20250314064642.fyf3jqylmc6meft7@uda0492258/
---
 arch/arm/boot/dts/ti/omap/dra7.dtsi | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
index b709703f6c0d4..711ce4c31bb1f 100644
--- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
@@ -195,24 +195,22 @@ axi0: target-module@51000000 {
 			clock-names = "fck", "phy-clk", "phy-clk-div";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51000000 0x51000000 0x3000>,
-				 <0x20000000 0x20000000 0x10000000>;
+			ranges = <0x51000000 0x51000000 0x3000
+				  0x0	     0x20000000 0x10000000>;
 			dma-ranges;
 			/**
 			 * To enable PCI endpoint mode, disable the pcie1_rc
 			 * node and enable pcie1_ep mode.
 			 */
 			pcie1_rc: pcie@51000000 {
-				reg = <0x51000000 0x2000>,
-				      <0x51002000 0x14c>,
-				      <0x20001000 0x2000>;
+				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 232 0x4>, <0 233 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x20003000 0 0x00010000>,
-					 <0x82000000 0 0x20013000 0x20013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
@@ -235,10 +233,7 @@ pcie1_intc: interrupt-controller {
 			};
 
 			pcie1_ep: pcie_ep@51000000 {
-				reg = <0x51000000 0x28>,
-				      <0x51002000 0x14c>,
-				      <0x51001000 0x28>,
-				      <0x20001000 0x10000000>;
+				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
 				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
 				interrupts = <0 232 0x4>;
 				num-lanes = <1>;
@@ -269,21 +264,19 @@ axi1: target-module@51800000 {
 			reset-names = "rstctrl";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51800000 0x51800000 0x3000>,
-				 <0x30000000 0x30000000 0x10000000>;
+			ranges = <0x51800000 0x51800000 0x3000
+				  0x0	     0x30000000 0x10000000>;
 			dma-ranges;
 			status = "disabled";
 			pcie2_rc: pcie@51800000 {
-				reg = <0x51800000 0x2000>,
-				      <0x51802000 0x14c>,
-				      <0x30001000 0x2000>;
+				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 355 0x4>, <0 356 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x30003000 0 0x00010000>,
-					 <0x82000000 0 0x30013000 0x30013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
-- 
2.34.1


