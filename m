Return-Path: <linux-pci+bounces-39959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D7C26CB9
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9914EFEE7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03D3043C5;
	Fri, 31 Oct 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GTMQAQlP"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35301264A76;
	Fri, 31 Oct 2025 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939537; cv=fail; b=cHy5ThsmvazqNzP/PbkDfynPIF7rvIrTMDQmUHJz+Chrq0WLMjZNOSM9m+nfgCV5R+3gWiansyzfPBAsFb45LN8mrWZFFdRuvLgeWlrjh6gfHwrc5+trOsn6JPTTb2XbXnl3MVzSCfi3+DI/S687AOjMEHVKRJSA2oWRRZTmjsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939537; c=relaxed/simple;
	bh=SYw6agMcI7oGIaPliar9DIEZrNlq2P4vhldnxtR5X74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tv+92k//8z/e64CxIwLd/KAm9v9Jiv4837YgmG/wUX45J8FtTxVFMRaqg//HFTGQxNTaDHA4SL5L9Ktpn83dIhXodhDH6GYFriL+hCxFh1EeBR3URVZ2LQTSejyNT2XTsP7IrNTaMy5GCSUnGwd5aYzVpZC9efyxkRuSIqWl3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GTMQAQlP; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mybKVNeogoCOI8SRlvSFlTgSt/EbFVJbZ8ZP50rg2hv2eDTfP7/wafNTNXHRpJssDueC9UsJPDToROMHpwY2Xd+1OG1PvtrVhBV4/GkFFAQEJRzhf9ACLaLg5gVdlMXrlv+Hk3X2Hl/bVlAKA2k9ZAkd+ryW9rm8phM91EHaQVzixpcYcuJSFoRqHCMq6Pmjkw1te2r688DrOJR6iP3UF1nVG/Hhfxy0uaP75lwkkVD+wZNFLEWs1KxpNePJMj5pUf3ey7fvrJIy4KbwR6ThD/Djd4B/Lst3ZFbprHVbJtmg2GxLDSeqzCvSOsZtYXfA4P7eOxTGCgmNAXcGdEbUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAOiQNPBel7v66o39Mem2iIelbHcFsqEk0GQaQno2pQ=;
 b=trw+Mn9Sif8XXcjZ6WyBrAxTrfffv4lJO4lbvrMZElZ0WAu4hFVqSzYld3cHCSQ/HyEZdTfx+zETLQ6kD1Iyxk15RdJjD/sL74SRaod703C1cFJZF4BRx74HS9fwdA9WKJAMwARiAh9MNidB7yeHsKkWc4gwTHpJqj/FlXVCIyjdNBiqwhMjRsJiiU/wugjy8QEWtLw1xoEoowRnpDbl7H5cEPa1bkGCD8brNaAQ+um53p0rb5+pSTJ69/GyCTtw7vMKyPQrFBW3OtqG2dYFPum5urOosNEktUYeUN4t/1lR4LnIWGS/i1GKJWnKx6RJrYXhwYpYZXxxaw4KGnHjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAOiQNPBel7v66o39Mem2iIelbHcFsqEk0GQaQno2pQ=;
 b=GTMQAQlPSvBfssx691stUSVOxst0IcLvF0qX4yjT4dcT9ib2RIVsaDV2mkgyxA0o6b9sx11jIeL3RgLtvf6gC6QqdUVvf1oWXQySlTbxm6ryv4tqXx1ts/1zRVPALp88blteZei5cy5/vIW4H87DlrK9Cb3+E6GkEZxhyMkFacPzZJKvs31x3oC18pnQA7IANCTgittt+SmBOSiJZeeY/bLa3gIBXvp4ts5kr6JOZkxPrB1zHtOFUGVYnjLYJY4Jt0O19vOLBp/kGaTPC8A58gjW9YYUJ5kxxGU7BqMH7XjGlyzavN5baE5irWA/bG7ksf1sNpNsXc3aoAnOcJ5Maw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:38:52 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:38:52 +0000
Date: Fri, 31 Oct 2025 15:38:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] arm64: dts: imx8mq-evk: Add supports-clkreq
 property to PCIe M.2 port
Message-ID: <aQUQP2x18ODq8zwT@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-6-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-6-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8cbb92-0b86-405a-fc2b-08de18b51ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L83A3FUNQULlxdVygQIffKlovqvKlWQBiXlQbdLMBqvCb8ktusDB1oHIIh5o?=
 =?us-ascii?Q?FfjTo9Z1XgohFGzTbbPvdOXt0U2WAyshn5V9JbF3Ls9fteJ+WkvupSmmoDFL?=
 =?us-ascii?Q?J6vFLgr6sE+BS6CEw5pWBrLg9SFs6Lb31fFUlqS+i5dnquQqhd86moRBqDLN?=
 =?us-ascii?Q?Fpun3cZZblfalniPauBuYw5Q0XeAtHjbokH3P8yAApvMO+0jPFF5fxsl00ci?=
 =?us-ascii?Q?GeO5ToJw+Z8/j5btBfHZI0Vb/ZJ9Rb92tbiG3CBfuZj8YPkj4xRThVnms0bb?=
 =?us-ascii?Q?qW/6Mr3E+cwJ7oKd4BBOjNC1i/SAT1rfbAjVjDaBld6X3X3xbIkqsOdupNwr?=
 =?us-ascii?Q?ElYgLM79fu7HKfQPO/yVIw122439027wincfo3MJ3G96J7FtQUECXnfUQJ65?=
 =?us-ascii?Q?NQnuhYxmcZVD1r++euxcA0syzgO9M5lcf9mgmTwWRpv1U4IOG5S8Bn9SpE0b?=
 =?us-ascii?Q?dw66BMehPReqE4XOAgYUAZwgfBznndJuVYNjCP3rmUwz9G1y2KOZHWviCrDI?=
 =?us-ascii?Q?5ndt3d6JsP5sZ8AALMlC6kZRtZG0CeWEFS0c9lArU8CoBroN69fjuOTV0U2P?=
 =?us-ascii?Q?rRpDiK0WLEFR2EbeteDsQEEw7aDU7lLokxl/VkeO7BQBh2MnbfgIL2ufGzTf?=
 =?us-ascii?Q?2sFyI8i8XhdOEbYApSR5J9VPn7cP2YziwgJKrPk8G45LE30EPtzzUkXuJJkC?=
 =?us-ascii?Q?8J1qhObpvVn7Q2OsHxiFXfbkqlYrZ+dQ+23TlOSxZ6jmqBldKCVzSRmjbUF5?=
 =?us-ascii?Q?PFpUBglMdSqamH5v0xSH9FSj7mTQgJtbFZYQ4KJoh2fVM4jDMhe9VzGAfHy/?=
 =?us-ascii?Q?7KBWNslnuSHW6rj2IrvbL6rCBE/n30prp0ByjnvKk2F+7+ftl4QRc+/XrfrZ?=
 =?us-ascii?Q?tvXaNnRnsMN9yLQ7ZSTFuHz01xE7jBen+62t87O58b5X9H29iNzTf8fXXADm?=
 =?us-ascii?Q?PzNHIKwxACLCr1ZHFOpKes8hUmNRizw1VKbtx//fUbcndMLP89ux8131F/LV?=
 =?us-ascii?Q?+ZrPtSMBbG/aU9TEXrEW6WFdkY1/x9W3Fryl9WPY4IzZbPxXVJ7Urzyml7fH?=
 =?us-ascii?Q?kshP5vRIpcJc+RMJE9Zgf5ZwzBPNm2gcanhVQKKFhiMl49WAkGyDP1fv5qbU?=
 =?us-ascii?Q?WFKjpkxLsxFi2xkYJOgAbASI8/tZAapCGIpMPN4X0dah9RR24B26CMWnj19W?=
 =?us-ascii?Q?IDcmTtcIUiXnLVniY8o+cPsO+8P8HO0X6h+9YxZBnIDMTe/Pd3jdqHSoa/Nr?=
 =?us-ascii?Q?rp735eQRwohRqEDsm3bWak82hRItgZ1nx3KQSEKRWXed1eIETlaZZWDUG5o9?=
 =?us-ascii?Q?JYlX6VLwLmwK2LojgOaaBDQUtUqBjvzGYtacG8pn3We7SL3UWsde5PQopGns?=
 =?us-ascii?Q?uULMVV8ra9zJzVcOAxJnlqfs2spf4/JLHC8Jz3ElYbdlo+cZQSSbyb6whaNY?=
 =?us-ascii?Q?0i7kGZoPzmcrhNdY/KCTKRVkNaCKEc+mxFHd0joh5fjk8TrpYankUggB3O4j?=
 =?us-ascii?Q?bX699FIlDHcCu2Hc7OC9CP/9o8hCsdD7EUXb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXgOOZhtH1eLOHxDxbHOsVA+0vHmncD2mr5hwgvDIspmSH+VHrv5fBtBTYCE?=
 =?us-ascii?Q?XbdAyYxyPhSdXr6JIaXUt2XNIAXCmIeNdtJCXo0qoL4M8MKm46tr9NkMTkAA?=
 =?us-ascii?Q?qn1v8cSXQsDLYb8MCcaXxnihpX9id8j4BKiEQtHk+VT/HR/R9G56OD2hhQgw?=
 =?us-ascii?Q?q/D7k1tokhpPPLgkBigkZv3vsVgx/qpKpT+M1G7nKynsPU/wb/ImMTLVSItB?=
 =?us-ascii?Q?YoUZK0D09dntum4fZfZuriUqW9mVA1m6frwkrtKrI1ySg856RU0QcaPMohNW?=
 =?us-ascii?Q?Q1426gT12Y/jIIn6HTfGEzOIDl1dW68y+A2wwV/ABALEMPv3Etr4vHyn43lO?=
 =?us-ascii?Q?e1jCk6aljUnB8V0du95k1uW8HhGm9zDk3wc54Dr8sFsd/8xkhHDhSxgrnH86?=
 =?us-ascii?Q?5wKEzzwoJ6yABP6niI42h56rQqQaIzdOKcQD1iYDnq8TKFtZq2CIlZPEBxCv?=
 =?us-ascii?Q?X1n5jG0llxktMSe1scm+mAUCjtcJ9YF1P+Tu7KklZs9iuzeuZiHRIsx1UMqd?=
 =?us-ascii?Q?UyTiMnzqXFNop87q2DbA3/eW32fs6Wmp3EfzNvp+uuDDZC2P4ubDzIZ0Z+RI?=
 =?us-ascii?Q?PJX83nqoIEZtPg6TIGxV6C0QJgc6YnWv8Lr6XA17rWUpAZPt2bFK2VWvOGE5?=
 =?us-ascii?Q?qqQkYfnOdBUrO1sax67HFLkngWRTOtMwgrL+l57sRfTfAJwPrP0ue1qB3snu?=
 =?us-ascii?Q?cwBnPEVTjucBgfuS91ttI1Nd1N4uE8T6rjiwK8pVJXTNl1Vbu43vx/suXzfq?=
 =?us-ascii?Q?YEC+wS0aq28bauGTfp79S12Jkd4ilSCYOEFRUpu1DbOtTRNEGB2RBuUqQbd7?=
 =?us-ascii?Q?+pzBU7tP4kUdAAAun9baWZfaPqhzsyaRuagiQxOFTBzTNiWMi6wgs1QsRlTi?=
 =?us-ascii?Q?AnfCmZK1YBd2PdXI/HXqAUU5T5smKv+SexI6Xv49TZxkYElVaNhXtTCElQfY?=
 =?us-ascii?Q?hzA1Bt7GXGR9IVm6eUIPZ16cu4JG1Wzbpe9CZ+V3ZVY2C7zrRLJPs77IOiO/?=
 =?us-ascii?Q?id38L+0x/bzu1TaRQUjJ0xQ+zM6TQHCsxNwI++K4tNb7tS5Eh1LrGV2+nepl?=
 =?us-ascii?Q?sCiPbap/QgpXfRq0uhUDqzsP9cOgK8CB++VuPYO4AfsWurBFXjgeUAXOvS/M?=
 =?us-ascii?Q?aD3HZxxmWYw4FT/Rc4BpkSGEW8N8xo0jBRoJvKWOorCeQ0YiIk/X9vivyAVC?=
 =?us-ascii?Q?vOMzHFKhjO12DOkkD/3TMOW62h6lLVTbVdKD07+tUv2BO0JR5rwpIbUMCrju?=
 =?us-ascii?Q?JGODMGfhE8KiRkb4jZPDhXQe7YxTGTZWALQUS0EFNjs3T44JWjSszUDwptAI?=
 =?us-ascii?Q?9J1hDBbJ6BhN+awS3ZvNTaeZbcrrI6hyAc3/Ir2Yhgt/jhxk1WPcLErg10oi?=
 =?us-ascii?Q?iXv5OcvckY+N5yTUQ0u0gWMHXmj2jNRJfHhG3Oxbc/LQzcwHYdqWasgHa+oz?=
 =?us-ascii?Q?FfUncjkesIUGzVI44cAVykp9Po3IHSiNr2xXyTECdgig+YcX8M3ikGFdz+JY?=
 =?us-ascii?Q?6P6f9KEzSe6SumoBF2tU7h5E/Nx0UPAosf10KQDiuTW4WsENDi3GJ+qD8m0N?=
 =?us-ascii?Q?K/tC0hzbs4EWrnAxQpc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8cbb92-0b86-405a-fc2b-08de18b51ce9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:38:49.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YB3p/DXDOW45nKmPf8IQRE/3lcGEML6YivjsJ2usEuGvjuZDpPeRmkp8JTXiNXJKAR5kbB6BgBddL6KAN2yqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:22AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx8mq-evk matches this requirement, so add supports-clkreq to allow
> PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index a88bc90346636..852992b915a39 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -375,6 +375,7 @@ &pcie0 {
>  		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
>  		 <&clk IMX8MQ_CLK_PCIE1_AUX>;
>  	vph-supply = <&vgen5_reg>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> @@ -398,6 +399,7 @@ &pcie1 {
>  		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
>  	vpcie-supply = <&reg_pcie1>;
>  	vph-supply = <&vgen5_reg>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

