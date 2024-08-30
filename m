Return-Path: <linux-pci+bounces-12518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFB966611
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8BB1C23238
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524081B81CF;
	Fri, 30 Aug 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dAsCrgnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DA1B7901
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032991; cv=fail; b=GKqEiAPM5C7PJbaxWPnKRY1J2BkYN8nre7gl740gR9c11NiZhh2T8E2UCarRNzsDhTIdZquLJlwcQFNgxSDhgyKFuIDS10K58buOEHbnx7RUoCEfhGhNB9lyPeEqwl6hCgmH37HrtiDQ1pHCPsm8JjZvpNPZZLY2VF0JZRwRejY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032991; c=relaxed/simple;
	bh=Ty3zcXksg1V07aV0KIaYuJS3xhzUTZ5ND5TbYOprnVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7ElNRk05Yd0Y1IvMyesJ8VMZUqhSFnGBKzWjJ9j1o3MWZy6S4nCiCQACioBU4D+gcyIQXuZ1c5TPVAAxBeF+/Ga6aLlwhfKxO9XgDVJqfieaTlekYsDxdZGhZOavhkU1w2HqU/SCHgpIUmRQY5sNHzxCGAyIjYN0UhFTk1HkiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dAsCrgnl; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDiDRJP4Mh+UGcQrMA42ISmuAS3L6pTXBryqfLPuzeYNjLSxd+T0wTDXir7UK46ib+CDnZi8qIfqVW/xn1CqldonoTZoZeqzKDltIkJEgeK08u+lr06F2ULYUhhqP6B1ixkNRI/fso5euDH2PS1QwF+ipwbuiPTZIBbGOfvJtPdap9/YlvJKiiOy9Dw6uBOWDkMRIIP8Uqlqjz3xFpgz6dvxEBPX4tLq32N1zvmgSvN9Ts9yq8Lis8dbEwaxnyv82QGlD8TKnG5xQ6pGkCHd5EgX4+upo4fdPxb0iCdl+mK4UrmES0F1tR+oU/PIkalFFavmqlnnhCHdydsGpkQy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx1voHaV9Jr04V4Wfz7uBx0QgCABWrSM0H/wfpI92LU=;
 b=KA+czPbf6jFUjee+37fBptJHs8s5Q57MXgKqKvTQs78hPih1xKUZosyQkfRA61RkymXDNuu9aUARSR/Q4+IRa5CuffLj5R1sM+CIpJleplfVIIfZd2ZrtykWWPjOHwHmuk2yEwmlbXG2JK3F+CfTkEaGgfaBYXicv2Jfg2H8rs4nwapF2bgNosu91ggCF9mGTLgRUn05SM8+H7FPJtQYra4ZI/3gseNXwpU0WwU3uxizLmIvtWVe8kMi7JaldSpgwj24pACaYrJnSU8/hEktPXnyJxjfzMnwhbsISq7vmeKz69QY3dHJYkvWNVbMnyvXdKBNE1w+r9ZfC5ZkN1joKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx1voHaV9Jr04V4Wfz7uBx0QgCABWrSM0H/wfpI92LU=;
 b=dAsCrgnlmO3AqwelAWnUcuX1SLglVje6UHTJFDxjE8PqfMIhpGjNh/mVGoSkogE7AolwkVVQMm2lUnYl4ZmUEAMV8WqR8PpIqUt7iA0CT3rQwxrwXelSrUt0yoIC8zjJWWMR71tnfVNaIWo7wS97bK5EB1BFSY3FP3DR86pE5FO2KaN91pQJohOcyPQT/dLA1jfIGiPpvqaj6O7MjM6qCVgEftojIIMrWb1Bau7fFz46958c36YCD3xbGNGicHI06Tru/d0TZLfpvByo++3ux4tETM2CFTaTRdDg3wADMm3w05UrHbyuGzIvnKhC8vTCprJUFtvprL7Aj8Ws91RFNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7941.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:49:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 15:49:46 +0000
Date: Fri, 30 Aug 2024 11:49:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <ZtHqExOsk2/tl69w@lizhi-Precision-Tower-5810>
References: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810>
 <20240829220005.GA81596@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829220005.GA81596@bhelgaas>
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 11350960-c052-4951-b5a2-08dcc90b5f9b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4hAx4Y2hXsSVhUmU64tKcuEIhXsaRmiC2kVUUiddp8DY/Ws+8BzIqCdCpPIQ?=
 =?us-ascii?Q?XSNYxryx/8curKMpSHLHua7NHE+rpjGAeax2/ABJeog1O1hy2qlhXVZ05YDd?=
 =?us-ascii?Q?L0esOA9Wynqh1+2K4l3YqfE1tfOSey1dxEv1keP5XsLvn2rclc5nS9IoRg7T?=
 =?us-ascii?Q?204lUdaxCa3ncPVIj3hZngFSIfFmdv3LbSvsueNLioEIlvb3nT1WB6Qw5W8V?=
 =?us-ascii?Q?kA3HMff7SkvCC9u08YBUFKxYEQOIg3ioOfhsOLdtcKdaxxj9yvtojn1cvvyT?=
 =?us-ascii?Q?QBQ+HO/nv+2+q1gysJZs5w1cUq2rGU8RYdQYPl9FvZWUuR45YGwSeIsPc+SF?=
 =?us-ascii?Q?LD1+eU7QqC0saKKT8TyJ6Hp5uDlMiFICEkzR3/weh5s+yAXw68lSZAzAopBD?=
 =?us-ascii?Q?dMxbkM0Jc5lnnMRaxBIGgtYXEQYqf5/l0l6nhhvIi/c/79bLU1UppYWjhrUk?=
 =?us-ascii?Q?F60oEvieWDpH5LSian9CTwhpWxg35KTDxM/ds9R6Lz9S+JgMzOLj7kXKy3wl?=
 =?us-ascii?Q?KjuzJYLDfuOFCeiOuZg3vIX/fS9lPN/J+sI3tZMQQNDHlgoeKn/Ub3ZYaZzT?=
 =?us-ascii?Q?xiFwwTnnDn4SKT9AYyN7ixQ9n48cH9Ggn8mGitl4NbaO8/IGlCa5JfwM6yra?=
 =?us-ascii?Q?9UaxDIGt4TSnRT/a+g89H/eoCJX/seu5ck5rzNg8HXLgHHBr6Io9SZoTFFk3?=
 =?us-ascii?Q?HChdkFIbyBfdxmd66rktcQhITWXEac7r04+2EuBUr+LKHGHPr487THK2+P2Q?=
 =?us-ascii?Q?Xz8CE6CJC39ijvQDVqqKfsajE8SXk7Q6e8JW/kqRBnHUV0lYI5X2lg2dZP5o?=
 =?us-ascii?Q?X0dfxX9hpwwILLkh31U2ZZIu4KeOYsz05rLtPBIsX6R9jk8JaRpTnrvAey/u?=
 =?us-ascii?Q?w6feLV+mgzEeh63laEOxfGgQRDQGsu7ki5ix3AdbDQOy9frjiqJJWqf19fl/?=
 =?us-ascii?Q?YjYEq89s83odqXcZioB4nNe+zyZ9nE65BzCvEfENQ1xUXjhx5fBID4D/1Zro?=
 =?us-ascii?Q?BJPHIXMjkTjBQImYHdqrsfYCh3RVQVEDv6OKb/9Zrz43zzOn9YoYV9oLvxBa?=
 =?us-ascii?Q?9LNeIu52PBNTcOgsq5d7Mx1ovxe0KiFvp5gF9b5JHrBuhNwBGRnyMHmzVYRq?=
 =?us-ascii?Q?aJnWl/QlGNxTUGCUAptLdw/7TyYElxMoXVs87KR4cu0KsCKRLtsrnrj22n/4?=
 =?us-ascii?Q?nOHv+yZoqAWP95O27WsdF53LuyA7o09Zkzxgb5wL68tEQwV13GoY62oFQoHs?=
 =?us-ascii?Q?+1yMVnm5q5lNnsv4TZaKGeIAL8ZYu1UXjs3OSAXT0QAJdNM9mtM0AL1Vpzg6?=
 =?us-ascii?Q?af+e/jJm2zdHcwhn2bjfS4Jpw108aAdP9/uwsB8aXUgyEGWKLGnQR2fV0Lxf?=
 =?us-ascii?Q?Q8xPf9oyynSmqbBZLKCr1UvuVU2RU51d0JqIs3hqq/6q3HSiTw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?z0jQYzvAT02+e7icy07GwO2EF137ca/r/gfHIpMd2eUyrLge1ZihxC0aUBBc?=
 =?us-ascii?Q?lNleFyxgqOBtzbf1QPQD6cdFQICsZO/TDWELKKh9mguSJ2FH1Z+yuJUt12Ya?=
 =?us-ascii?Q?oOQDUrVZzF9+yY1fqzHHlEuPhgrUg7garWyfFnyLg1dLVFG92PcxAuX3eNcY?=
 =?us-ascii?Q?GnauGHFCy4YWATsZqjw1e5XfEFbSAqWzgVGvOjnE3Akg071E0i2S1/a2Qdct?=
 =?us-ascii?Q?bKguZrfngnXWjTfMw/YSek/UDgak7uAigeArJ4tuMdUBTjwDf4hEGzyrJEUg?=
 =?us-ascii?Q?6OTbXsdR3BkqTxW6gu8E71HhMrAhXTubm1aPrs48bbPu9oK2r9FHHG9S6VLa?=
 =?us-ascii?Q?9Pb2FjESQMsA6xJw9IUzbdA91B1TJkexqjrb20jTtzgRpP4hYRSc+15ir+x0?=
 =?us-ascii?Q?ACWIxBpV0RoUH7eYwOHB7E0riYn9vXBmQZXKg+6Who1E0dKUZFR1gNJfnxzQ?=
 =?us-ascii?Q?YKUOEmKPse/vZRdfhex5HsmDUIooZc1CIaQ+5ReFGjXRPklymkBdkDrz4Czi?=
 =?us-ascii?Q?GT4ONK2t8SUn/YjCvG1Oqq4boYnBMH1kDWSUIHjzxw3JcTONL+06EC4s2TQY?=
 =?us-ascii?Q?LwVfCk/tk/Xe0PJ/WguR70UlQMWw3naRoGnYsfOHXGYIJQs82FUTAgHG3dMl?=
 =?us-ascii?Q?MsoEu1enwBBzdGnyjdu8TlgjykO9L4rdHPxNE9ifOqekenZLaxcyyAUilrvx?=
 =?us-ascii?Q?mLi7ZgCqN59MfRpy8jiMuhV+fEP/giYDE7P0yXFHOqF1bKHOGjG27/1IVoSr?=
 =?us-ascii?Q?XnPrcKThGIXmuLP4GhUTIckWeOZ75Cb8DkwRolRh89krAMuN1UdNeamNtahz?=
 =?us-ascii?Q?1DP+r0PSCPQGP1fy3VRYhCEIcgyMBMo8tvk0E++voBe91ScyjxhGs9gqkTYQ?=
 =?us-ascii?Q?px6seKfWRxOfU8T3lTc7cIyZVDivNySgiRf+5wCgpB8zC7o2frYw8wTwhlXD?=
 =?us-ascii?Q?s+22j5AMAv9Ca/WLr8ykAikgqz92efK/MThvUXLZrFMyWXGTt6H+DRJZjR/K?=
 =?us-ascii?Q?KMAl8EMH1w1LEYKnqmAOpVDhI3edzVHDrPkL+yP1sfk4YbyXmnIs3eWt4Tes?=
 =?us-ascii?Q?K6kECXwh4Z/ZbKAlnPreCOZFeP94fTLnZwKeA/XJPG+44deFh9pMaqIKyUl5?=
 =?us-ascii?Q?VQeHmkWQS3p2RwOB+AlW3mvLUksEYisOZKiyuDieCtg6BBuh0Gi50+qPRno1?=
 =?us-ascii?Q?pkeg83GVV2yCZDeHxJtcHu1v4F/q9bjJBQKfCATqT5RZAEJM7yXsq9ZJ5/RM?=
 =?us-ascii?Q?qSe+Yp9Q0TbeLPoTJDDNyNTftEnWHwKwbAQTyN9tcCHG38/xTB/VUTs4tQ0b?=
 =?us-ascii?Q?rDqdlzoWRlHEWzSEIp5FCVa+CSam9V3FcAvb72hhqI3vBot2jh8as1MOP+wz?=
 =?us-ascii?Q?7SELCk6+YeySJKNxeR/o5naMsqORAjoZDPnI5/Wq0lF5uXsIILCmHcgHZoXT?=
 =?us-ascii?Q?HJSG4CAyjgDa/e1miMcbMfeZuzlcC4bL+jUAl0cCFP9IPbaRHM+zGWELClP6?=
 =?us-ascii?Q?g+i9chLOiRahyrxIhthLIMveAZOlnfFResVX/wis7A6caZQQGWiZI68GPkXJ?=
 =?us-ascii?Q?DE9psqtSOAmGxrTupY9u4W7cwzjLlw27e5iy6wSA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11350960-c052-4951-b5a2-08dcc90b5f9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:49:46.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wr3lmETfxxV4oVKN5RhCBCofBrQ5unQ14K0dQMTrAHg8Md+2BjAAzCiXozrA1KMGUwhVYsLPO0U2vSgMDQ77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7941

On Thu, Aug 29, 2024 at 05:00:05PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > Greetings,
> > > >
> > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > device and the device is not getting a valid interrupt.
> > >
> > > Does pci-imx6.c support INTx at all?
> >
> > Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
> > we tested it by add nomsi in kernel command line.
>
> Thanks, Frank.  Can you point me to the dwc code where this happens?
> Maybe I can remember this for next time or add a comment to help
> people find it.

I think it needn't special code to handle this. in dts

 interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
                 <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
                 <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
                 <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;

It map INT(A,B,C,D) to 4 GIC irq.

Frank

>
> Bjorn

