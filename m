Return-Path: <linux-pci+bounces-5551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F4895720
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6701CB22CC8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5B135412;
	Tue,  2 Apr 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o5OEclIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2095.outbound.protection.outlook.com [40.107.6.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EB13540A;
	Tue,  2 Apr 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068487; cv=fail; b=RExJ1Ast4SY1VmdDJjvfZjbTOPR6zbeetNBB4ERiFTQbRz4yfEDGNO7wA6lnBshC2n7gMoZmIzNdyixxsqN4dNEUTydFZjiGiSdSnet6LdYARxrLv+n446Dy9fRFyicGQ/0UzeV4Gxktx0rdtlP8/1lv8B1e/wviwClrJyR2J2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068487; c=relaxed/simple;
	bh=VF3tYmlcg/VMfEHxTbMiyjtGVpVYE79MrCZJlbIsON0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ece0tBeaKt0t1HUaFj63/Uuxgjwh/axFgA80NnA702bY8V9DSifO71hNojZkb2cAOwqWBtejQpRPWmzUqbEHASsnqfIzm7tGTXRTYFaRFum46XQQTk9VVqJ8uwkhQZaFS0k5OxxHeeSwtV1x0yWkMiYJXFzXjuTLEzWGsvEZD54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o5OEclIg; arc=fail smtp.client-ip=40.107.6.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu7ju5+/qxo5n5Ds35taPNAK61vpJNJEghKlw3sXBi3kryR79wIP1cHHX1Y2cPCFL+rhmkVpduccj+u0OE0ovqH1FhXMngaCQ8KMI4dFQeMEDn9Va+XPtSrOIDaWJCGeKUnfsXx9qLMS74COXWc2bbfeiKT6Ycv6/1x9O+7Ykwqr1zQR8OTqfSzPe8Y8+5UUBm74cUyvf4x0SSio6Lsngjb1AXRKxz5Buf7ZIuYrzt4iL9/rJC3WEPSn/m9f1r0grCSRlDsMwqYF1s5rfltlz/95fS5PASErbLVY+0RHnbTnXBK4E+Ax4o3e3gJDK2cFjZjAPiyjjskT8UAgpwWPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bxf/nwc+muySGSCfmby0y1/0mJ6Nd25suYBqOpzqHU=;
 b=XvCJNSLzZBRCvuBmRkN3qrACYTrf4iAPQlhUjUt29S0CleNIwlU4dojfxAg2RlsgI3YD9VJdpp/gABr7SDU/4+vdWdFVZed1r3rmOlDWfUpkOgHwQrFJGFZMMiRAjxLGaoKyzLshgfjSb2JNQK6472gRMTEaQUIcKenk4HcUyimnVd8W3Nolw5w86yrpp6RQZyAxldHDF1ySIr1UyCDmZExIfOKugaNZ6YZQRr6Q3543KHit/3vbiBzwwNRauVbc3jiqQVkQR9N5wB3QJwaJkNhVe9ViGHARD7x3bgL/AnYi9AjQe1axwtwTJUiloKqkJqSYR5zgy+lLo5MoTMNLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bxf/nwc+muySGSCfmby0y1/0mJ6Nd25suYBqOpzqHU=;
 b=o5OEclIg2rUUHA2QYPBQ3VUPr9kKqvoEkBn9qnzavUIjutjnq/grPsD+MZLshsjPDzOeHXtZNGi2NyX0zguH7x5CxXs2U4q6IX3iUr98QIVBtjxHEsw65cYmZE2GTdLvyfVyemFJze1JieW96N8Cl5exNUb588V3JI4giZKhsjA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:45 -0400
Subject: [PATCH v3 09/11] PCI: imx: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-9-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=979;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VF3tYmlcg/VMfEHxTbMiyjtGVpVYE79MrCZJlbIsON0=;
 b=+0bKMkodHyRByDaCR8zT9fPtUbvsDh2UwDSNyTGQwxuX0FXqj7KsnrL1WCuhvdkesKrk0php1
 WC5Ua+HhfS8DHwGEw/dF2fnWyDeFZMfnh705gprCBcHkzVk/S0Y455z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8926:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ojUg0/t81jPuRCIV88+8hB6bwozRIdwKCSod9e8C380dm+2LxhduxL4+sm2g7soBPYv/hpBx+dZvpjTqcx6gJJlGj4PE6npXIELq7+6TRMzTn1mrDMpFDTADh/8d6ui5lqkIQlUaxgK1yssGYZHYuKDelTL/3cNykUWj9+IzhpGzqfu0Jwy5/Ao9Qz+5bivfgMynGprIr/VI+ooicRE20UQd2R4Md9R+yic9AOqGwIxX/UkSyp/IWstjPuksan1Tzaw8tOXduSBJ/GPKkpI4zBf/u4L+/+P0FuITNbczz87O6nGQEoKgGLG3BYYtCHEsAv0nAmxEUG75Xkiv3Pe8/1Y/kwh7ummdd42JChRV/iTObwJqtHSnaKHMS931GoW+FpAezmfvNY+Qzk+9EAmP/SOV8GRUNu6Yorlsf4VEL224iQuvwSMwMQpGGVTk0PT5PuYMoveCXldrg/0KEI2rxZ8GmSBZc6RjPh74dU2PmjDVmfYX5l6ZjxFZfQU3EK6bCufNFEaI++4otJZsI+SjTqAZOekVzLbpv2q8tYjGrQwepWgXEIb+7/8CeGZj/I8NtzKHUehKjE/vmJo2jSRwLoEvjxTmct1zLAUY3zRDNGIsTxZnsgoH55uidCxgaPTB3ZCYF+1Yaj8/rXoX6LbZXTlbB+cGU+YoEf5tBNW2KvA4JLmYMr0Ln8JfyVFyhpMlLx5oTnIcws0CwbaUH60AGjxaGFXPV2CsgRkFJuc7Ed0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFDWC9UVnBNbThNMEJqMFphUmpTd3VRSmJocG5WNjJDeTF2NWxXa3RldWh5?=
 =?utf-8?B?V3NlT0k0aUtrVmZkQ2F4S3I0bEQ4OGpoWlBDaFJ3Y0RLRU5ISFI3MUI1anU5?=
 =?utf-8?B?Zm5yNGVhVERXSTZpM3VNZ0toODIzRTVXbU82aVYwYU1xbzRoakluQThhNUlw?=
 =?utf-8?B?U1JWZTFwOEhkSHl5NUZFWWpPVzBwQUQrM1lhTXVwYXEvWTl0c2RETXR0bEdp?=
 =?utf-8?B?cDU0NTcrbW92SUlOR1BSZnpyMjZKcTdYSk03WkYvVFRla2FVS3huZ20yNGJX?=
 =?utf-8?B?bXZQWDV6SmM5MjNjVjRwMHltdUVNVVg1Wjh0dXNuMStVSHZTVndmell3dzBB?=
 =?utf-8?B?Q2cyWXdRaUQ2YkhicHRwVlhiRkN3S0laK3ZieDE4RG1kVFBCQ3A0WW9TNDRQ?=
 =?utf-8?B?NERCZEV1aURxdjdCSUx4UlNrL2d2UnVSR0tCenBxR0tvMUliVkd2U01YVFpC?=
 =?utf-8?B?dnVYcjBGTHZXdXB6eWt1T0V4TCtuZVFESFpRRjNrcmtlcXRQcWtxKzA2TFkx?=
 =?utf-8?B?R0RpOEdObi91bllteCtIVXQ5RjRJVmh4Q2hPRWcwNk9lM0pHdHcyWGs4RnlQ?=
 =?utf-8?B?M3p2eFl0ZnRkWWdsQUsxQTFEV2xydkNqVjJNM3hITlZ4NlNOdFN3emRma2ZF?=
 =?utf-8?B?ekdoMUk3aE50bCtsQlZER3d6ZkNYaG9TM3BxbVYwQ2sxU2VYa1JWSzd4L2J1?=
 =?utf-8?B?N2FtOG5hOE9NY09BNlhDU25ySzJLZkg5K2RFbDUvcEpObC9mTFpxKzU5dkxC?=
 =?utf-8?B?V2J5Q0RBRUFWam8wc0FuZlpvT0pzdTN1WXJneDI0NkhvY0hNSkRvK2h1YitT?=
 =?utf-8?B?VVcyS050SG90OFZOYmZtem9Zd3hNS1Q5TVdXVm1rek5iT1YvZ0xTQVpXa3M3?=
 =?utf-8?B?Q1JmUm5rRVZTTGdxM29LbFVBZDZWL3pITmQ2bmJiT0ZWck9nUE1Xb1ArOHpz?=
 =?utf-8?B?bVdSZzJSdm1WbHUyc3VoQmxzTWFUV1pHWEV5RFZDZUR5TWVIaFpkU1hpN1RV?=
 =?utf-8?B?Y0g1RXpLYjBMNE5JV2tUTStaY05tSGJvUGRmZVNXbnVncFRRdzJyUTQvbXIx?=
 =?utf-8?B?ZXJoT3VHbm9YMFVXbXNCaXZCQ3NXaDhqanVpUFdON05JOFRZL3hEd09tYWNq?=
 =?utf-8?B?S016bEgyR1lxSmN5TnBDSzZpUmptTWhZUkFJV0h6Mks1TDlud0IzTDF5Tkts?=
 =?utf-8?B?V0RveitaQTdFbUNzWUhVQytPUkxINEVOQzBLdFBHQUtvS1FyOW0wZzV4ZkRK?=
 =?utf-8?B?cnc5aXUyMnUwUDFKMVk4b3VLdXljMytyaXB1TE5OemNXcHR1L3RWWmQvMk9t?=
 =?utf-8?B?TGFjSFBmS3hpWjZUMzFlYStyRXhUdmxMQjdVSktxM2xrdlJHU2lneWNNYmQ5?=
 =?utf-8?B?QS9TMGs1MkQ0L2xvOVNJMWQvRnJUcTA4ZnBmS2ttNVJaL2x1VVpvTXdCdEFp?=
 =?utf-8?B?bTg0ajlQWWFVTGxsNE1qOUd5R3g1QjdLekZqSlRWYWk5R05PY3VrV3Fpb2FF?=
 =?utf-8?B?YXRtRmNwK0srZUdoMTI3ZTVldTMvZzV2bndYaDVTMFBpbk03MnY2aTJGaFZr?=
 =?utf-8?B?dTI2bC81N2s0aVNEaXN6QXFPekwxWDJLWTRQMmg5bHo3N0l0cStnSVozeG4r?=
 =?utf-8?B?ZHo5T1hJTHBBdHMvK2U4WjVVS1lEQkczdXVETEg4WW9XRXBBTDVGcjdqdW9O?=
 =?utf-8?B?UE1sd1Fpa2hGM1A0UjVGMkJCMzdzdEIwVzI4YjBpelZPS0pzb0VvNy9MTFpv?=
 =?utf-8?B?LzlHc1Vla1Y3TU9JZGNLZE5UQ25lU2FoVy9mUnBZT0hyL2NxbUZlS1R1NVBS?=
 =?utf-8?B?blFWS1NCUDdzVGN5MUEwUXpVNXpXZjdVdVExRkJldGVkUEVmV3kyU2JaTjhz?=
 =?utf-8?B?aTBxOHJGQndjMlhLYnlWcFEwa0NLRlRzbzgrUWtWS2w0U1FRY25PNElmRDVB?=
 =?utf-8?B?eXBOZklPQTYzZlBjemZLWk1DQWJkQytlWlJYbTRpUWx3Vnlsd29sUDBBS3l2?=
 =?utf-8?B?MncvNzVobUMyU2FSUldJRlltZTZQNzM5WnI4TEkyM0E5N1lnYUhrNHFWS2hM?=
 =?utf-8?B?dXNsUFo1am9WYkVSOVBvSmgxVWpwcC9LdGp5K1hROTkxNlJEdEk2cjZPcG0z?=
 =?utf-8?Q?A3FU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbaf992-968d-4cef-7b04-08dc5322093d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:43.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSoQH5eIknRw/Mj7mtP8dJrRCJrj87YPDX5cVXQusBZ7Be4m0EYUjg3zlwn9Pvh9pD42FS9rDMAGlU9opIWiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

Consolidated redundant if-checks pertaining to imx_pcie->phy. Instead of
two separate checks, merged them into one to improve code readability.

if (imx_pcie->phy) {
	... code 1
}

if (imx_pcie->phy) {
	... code 2
}

Merge into one if block.

if (imx_pcie->phy) {
	... code 1
	... code 2
}

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index 653d8e8ee1abc..378808262d16b 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -1103,9 +1103,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
-	}
 
-	if (imx_pcie->phy) {
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


