Return-Path: <linux-pci+bounces-25208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA2A79B7C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D6F1887C7F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374621A76DA;
	Thu,  3 Apr 2025 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RnWwJV75"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432E199EB0;
	Thu,  3 Apr 2025 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658881; cv=fail; b=RzY47Y1nVs6AF68iTZaMUC7LeVa7mvfXE3Q6ZmVBJXjMQtJKzZinNLXm8MjSqDmV0/BBpAujfSibwkLD6F1q8va+PL7ACzoPc8tBVXX6Ds6nZ8ctUElHL77fxS+xU5tcNqbyI+Uad2fnEzzoyPnWJVbol+uF9WP0xGry4sRPVfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658881; c=relaxed/simple;
	bh=Xlg+DZgYT2021uMkGL/McF+aEkBhDEkKf7BGzZFkKIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwEqYhTZQkzoOQmkT03sTbW1b7H1Pltc3f7BP8iHGv8+HE97MZ/I/n8vR7xn9ncZYSj8YzjNcyBFmIlf123HMpSkslmWjhS+WTi8y9/+UeVzW4lLRnZNskThphdyRdEs8ebfVbbFw6p7SZFa0r7azUBBy4cjMu4SREim+KQ++4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RnWwJV75; arc=fail smtp.client-ip=40.107.249.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiVEenypN0Cp8sq9S9CN005K7Y3NITT1x4WUqA2oq5tQX0EEVoGeRAX3IwmwJLITmMHd1WbXroL9rczhrqf8w3KX6OtWplY+P7tK+6QvaAbSXs3rsFYiYe/VMlpKnSHX9uZrjvZWISKN85IxD+5fyvsNR0sQ+b2filJW2jGTCLsDNjnRF+J3xvUFjzjGdz72N5/qpQUNTOw3rPQruNqC74Ak5Sgxpz49luGBCqsDE6AU54oUDn4l41744wdvFZ8FrHqo6W3iKcHXkiW7Jp709Xgp8tLckDnq1Q0a5yj8d0swNTK6uNPOP1CXsrcwdGjvSZw4cHVab3ZLH5Z/Bfm8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnBrFExYhqrcsrH8shIlvb/rzrmXl02sb0ZzR2qwk5A=;
 b=uf7ogZrFsV/pQeYdxYvDL3qvv2k9NRZ28q5iuz92bMQ6KPUb2LWBOFpLsUST0IGMXQbOGAuqkBrJ5/JnBwTbdTwPYfSDRWO8TFjaFbmbpzlkTE2HdTPLzEVFaQu7rOCGf7QDrPRM0FZbIAOUBU18yKCu71lZW3Fsu7vbpHqLJXmTUkZH/sJnhMtyPWqRtF+SlD70pFQOOWWEe0bySlvETnLCtNLxW8KzEoXZNOjVKoUMwaHpKLeXNhdho1kPBNTscXOUgkEeUAuHL9tb2cYWsQkyKLJC4ieIk4zSC1uB9D1cZ/WeHM/3O6Yuk+M9WpamyokBtVyydtnkB30B0BiibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnBrFExYhqrcsrH8shIlvb/rzrmXl02sb0ZzR2qwk5A=;
 b=RnWwJV754ZKwU3dAyD50NHDtha0emXiNlaihZNflRfOb/gtlyTPlwT6oYwN/HtiQTSLtF1FN5c8luZiYjMgWBVqZ2q8WrMmbtK9QYhWEjANyfnZLJpGAtl2/eun5TsPJ03E4JRb0vc1/GHdgXEafgApOwWHXY5nKWdf3BgSFfnMvNRvnc85VDrZmceBmQ5KyEmrRIrK4h77/W+vVCd1XOvQiK2nmzlSVdcIFDdp7GS+d62TOi2Oh5/0/jFucVrgv+2mqKogH0Oz8Ml8H3TUFa7gog04Gm2DXv+03zk45FvuIiwtAqoNlJLHFQ0X6NlpRYig/x7vI91mO2A231w5f5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:16 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Thu,  3 Apr 2025 13:39:34 +0800
Message-Id: <20250403053937.765849-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c98f27-f58c-4bd5-dbf2-08dd7272273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/WAbdTONxr0tIvy/Um2/7K66wWgvFfhDMF54jTEd2Dis+DnZtNvNCluua14?=
 =?us-ascii?Q?aFluUES7R5GGktL7YXGv3VtckybGockx5GReUc7ZUjPfANIMntrLszLNSkAz?=
 =?us-ascii?Q?zIiuNUfxBl4/vsqJInI1WfggNr49D63h4u35bNsje+5d/RLWHO1JSVw/USk4?=
 =?us-ascii?Q?5yRc0dtmFNnpLNFZkGQcKGq4fsi5Isq8l+9pWUFRk53lTtNj2H9GopNID4wV?=
 =?us-ascii?Q?lSmBbqq1Xsu5XA7Fz/bI53XX/74/r6rOxJRkmlo6cKpdpzEK6WG20ye/jmiG?=
 =?us-ascii?Q?AG3eJmUX96Y4FSn5VCAXavbiKl8toYgq2ExvK0gDRVM/JS5CbMMQkof4ywLV?=
 =?us-ascii?Q?wXvnlmdoxnj4RBI8cowcPc2YDp7T3NgVcO5olfohOGH2bb35255qlIjuIGpl?=
 =?us-ascii?Q?DZyob0qcope8OEFiGGJ8E9hbRvdpV4vN6MLyIXCSTWHDxwBHx5Kj3hXpNxx5?=
 =?us-ascii?Q?PZ04fdU3OcUm+r6w0gha0NAwNAM4CbaXEeWfqsf8QITeAlrQmPT/MrEzQPTw?=
 =?us-ascii?Q?eWMzkfkNaR+3C4a5IUaftcLxGI2EN+ElvTjEc8w9nbN4f6R4gUcsEBfQ5I2s?=
 =?us-ascii?Q?8dgMMYZSSQTGzGQ/d7IMdF+8oeoefHsWzbwGjxViwGmA5zrSUX9zT+hFLJNm?=
 =?us-ascii?Q?mwUfB9qYjWk5nqRtCkpYqXHyIJNDDrsejEt4Rw/fb8Dp9xT+x+Rg48rl183o?=
 =?us-ascii?Q?lPD8FyTvLWLxP/Kgv77PSUZ17EhprUezvUiyHHcch750qmUkloVtR1QpcW9I?=
 =?us-ascii?Q?VWwJ0ObVTU5kXrdbUD7nQp5Cgfm/P/hA1+zkxt2J912iHjkOthx0i8GPQhqt?=
 =?us-ascii?Q?fxpEihDNu0qbdTbaRpepc+ks3dM2kYFsfR6bZnBLcil1WppJgcz9AtyXPBlc?=
 =?us-ascii?Q?uNHzCVXx+nqKEP/5sA2cZ0Y4fCOdaBwhf88jeGpzzbWndzEq19kxk74od8AB?=
 =?us-ascii?Q?N522VqtEms1cE1AYvWUKuU9AwEejleIEsH42/lG2lsnQT+cyyJNtjAaitzLh?=
 =?us-ascii?Q?XlNsUGplarq1aKUVrR8kBt/dyEDFQcyZEFaG3GjbeE+1Wqp6Q7rPNX+rDxrL?=
 =?us-ascii?Q?6/sMCCF66pX52BuSOQUjZ5UIo8qWL02g2Yg9PHCgHzs+UDU5Io99j7MIzmgP?=
 =?us-ascii?Q?Mrg/1ERL1LsTQWhnuTigz2C90qYblzCqQ1fyWMIGjkbE00uRjBHhwAejz8YM?=
 =?us-ascii?Q?Hsz1pjV6t9M4sldRrKO/Q6CNYNWSNJeUJIpQzF/c+21tIzys9G4blu5eJo4X?=
 =?us-ascii?Q?3t6ZkKyiUQr6BaBBLzOHDW6YG3MgrQZ04xBy6BgtGg5BWNSTv9GqOhN/5gf0?=
 =?us-ascii?Q?kJMKaA4/eHezJkxNgKnTu0Ura2CpUdSi8Fk32WDCctF2Q2r+Jxgj/1MJdbJB?=
 =?us-ascii?Q?/ek4tq7IK8dzHxbQhyAjWyP6g3aEqxRfC0EsEmY1F+5s3Tc1ahyWzFlXSTrI?=
 =?us-ascii?Q?LmeT5eMdqVZpw+QipLA8/g8wIwM2spqAAwzGIKmCovK9p/3srzhkuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXygCRBMaWeLv18p5mwfts1Itz01ITjKIye4C1cuQQjlGUufzxNX8cp75oMH?=
 =?us-ascii?Q?qy4LoFDAmUIgt+TWjkGkS8QuS12/RuA8TFzWaRpxQnHPv4kG8CwJDLOTmIrh?=
 =?us-ascii?Q?sXa1vBwFtJdwip+YPT7egMrd7Jv6vwbbOH4RM1TEyt1FBP1JDJ2FiDMaVJDn?=
 =?us-ascii?Q?V7vWdg16ytzSFSsUntYUzctpVu9sUlEnOXUGEz/k0sNGHBfBN5J/eFA4rTlQ?=
 =?us-ascii?Q?ztn9GaVXwuYND/a7/3QMqyhnlQuLh/k1derP/kGS/VAiSGriyuMX8RsPNEF0?=
 =?us-ascii?Q?qGoPm3n26g8VBs2oj5SEaxjwM6OI3MAB+0vnZRP0Q4E8GY68E4S9q4ky9Ov4?=
 =?us-ascii?Q?R/sw0KJEN+m7mJgHsqdUi5hD0URfbfhmHRJ80zXF/piG27lmXYMcL5tDBN70?=
 =?us-ascii?Q?Y1Jey091XzPWU9ZbYzQkZVj8Bohaq19xLnJfzgPI4snwhTbgvqzesRFkVGh2?=
 =?us-ascii?Q?9ZkFlfhA4z/XgT5qNPYxzhXXuNpeU7lRVaxkLjfaDfHxcBUu7Pni08O3Se/s?=
 =?us-ascii?Q?w7khA8nCUp0HdEvi6dpW6DIVfjmt09sGwnNHlW0uz3Vbgw4W7hK/rFslx7TS?=
 =?us-ascii?Q?H9mtgvS9wAvj3xHd1Jtf2IEHGEn4ERDnc8C4bToGXn3YLE4wgVN8nSMEor8y?=
 =?us-ascii?Q?2gUQXsamSB8a6n0P6GudKAX2JvvhXMBeZfx2j0573cR90OBw/MlsG6Q1yFfk?=
 =?us-ascii?Q?JAZQk7JLTCwtUsVVqLEsEWe1Svt5gSrD5LX1q2Y7pUaTb/1q8wR4P6ntY2FA?=
 =?us-ascii?Q?J4Ixqiqi+f4BZxrDXANnF85Jp24iepoQGr9AwdV5l831E+avy0b0ub4s7HLG?=
 =?us-ascii?Q?/Uon1ojIwSaqKL0gpE0XG5Tn7eMuxz/oDUxPufMftmfu73g+rFq+X3YwJnRJ?=
 =?us-ascii?Q?RB3vz6FTelvU55ZXzAKVnbAkk5Pxzy+Gisuc4QBFvV4rEGr3M2Q6uDKXCVZN?=
 =?us-ascii?Q?kxZeRtJ+P20bgo4QPRNo0P/PiVocysKosEi6IKSczymEZBON9DlqrgYvylvS?=
 =?us-ascii?Q?qWtpvOKnOHp4b2x1r3OMoaEBXZK954CGlC9yJWqaHKmq1Fp6ivQT+8Fl/4xA?=
 =?us-ascii?Q?NWQ0tbgnP2DzpPuNuu/8UEj5YEvKo35ly1se3Ih/Kadyw43FgJVnGowJEDcu?=
 =?us-ascii?Q?8xDnsETKjaIYGNOGuMUoJT75qYj03CdYzO2qJJ0Lr2KqjiwGC4pU+7A2hoQO?=
 =?us-ascii?Q?OdvopXAyj0oqmjApR9g9EtinutfFA16ulyUFvmEKTHt+yUwbbk/+NZh8P22F?=
 =?us-ascii?Q?YEwXndiP8meonBzJmD+WDM1Jy0vB+jICMUQpyoKByKuxm0U2UZh4lkAr7n6m?=
 =?us-ascii?Q?lZuwSamo4tTWiUw6P2iQWWubB6lz/qPOZzkpgmzUVNtuqOQiKwlA490JHksM?=
 =?us-ascii?Q?ZXWBrxRlMV/Hty/OtlIV8+QLwoqFBUaXCQbECUlEf614oQk298IYMWJFtkAG?=
 =?us-ascii?Q?URcbUXhlxHCIashWJSuHjPswGTnN1jIbjbzwCWVbSAWPuntCPTpX8cStON0h?=
 =?us-ascii?Q?V8wuLh5uNCYEY24YUQaWqabiGonmiNLQvGVEbAvYuVMkQGFd/8P6UQztYav1?=
 =?us-ascii?Q?wv8/jvE1z9BYeAgrS+ng1lOLcoPpi1TaDzz9AI8r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c98f27-f58c-4bd5-dbf2-08dd7272273e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:16.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKEqT2i5CLHtSPW8zdkVkuZY/S2yaiJNBgZeyCnGkCAOgwg6QbQ1FdiD+T8r15Fini92kJVorlDOaDwTEi4SDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a2d65dc88b66..abaf6b13a8d5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1


