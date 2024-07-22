Return-Path: <linux-pci+bounces-10620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629789394F2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 22:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854911C21554
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C981CFB6;
	Mon, 22 Jul 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9DNagyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013036.outbound.protection.outlook.com [52.101.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870083B1BC;
	Mon, 22 Jul 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681263; cv=fail; b=uAHPClWchs6qEDfAs4pvRIxwWWBe5ZcKZUHolqh26bJQM3A5GwvWi4sIbFmjaOR31Ehtvd1GtW077XNIttwJ8vQqFAnQ8eT9NVLOVo2s5dZO3RqjxMG6gAo8B1ZwHrPaZJK83mnLcJIDE4eAy96Vomn+iqDdB1FguFf9CvHquGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681263; c=relaxed/simple;
	bh=KsbrFF4UPRMupj3H4/3O5d0KDbihFkjHCCxJZz78X1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f9bmRgTsuAW3LszjVLclzh8oDz/aLOw2F+8LzXIFF0iJuP/SatIn4TthY/w0bmyMmTRFQpaZJWdeOg1Oy2qTIEQa0IAV8dp2PDdElynJGwCq1InSs6O3ae5iuHG7xLKLTBpL7I6+F0s/hT8VW0LWx2rJ4biWVplJ6so+9e98Ijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9DNagyr; arc=fail smtp.client-ip=52.101.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xy4QWJWGFcVyFw3ygFZSUH14N4o/gfVTuSmLFWHo9J8l2Y55hr2MtN6SPqubtsJsSsAcGIU584VWekxg28J9W1MlE60Zv8BWnwTCuzUay7Q4veYb1SgTJwX8hA9N1GUfWMDJ9CVRvVhJB30iTxKCF+HUY0Ne6sG27YNegeY+G18U+rxWolGBmXJiafV6FaAbyJH/an1aZjjfbSX6xdGkabyicQ7bxNkaU1pw4ubmWtBS+EcFV4YmLguz6Jv+qmvhBeZTnzYeDmXPtoiqOkz+SuFl7j6jb21YhmMr6VhTq441hdrRPNKSNlY0nxTbMRT86vOn1ydSaT9O1w70hWxzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FamizcMcxyj07Sr8ljW+LUdkTihuJmdiAlfcZEHwV0M=;
 b=PLv8UNiL+tvYVWqHO4W3at2Xx0sSmFUHJv7opDKVLPtM+x+jG2TUjSyWnjhhzlIFfpJChxXEE+xy1lvJ7i49jWfj6/++MfXT289Gz5ngLFFdY986adTUqJqDLatoPz+K/sAyvXnxIO/+teEtWBnxczb7EwpT+pw0jEYz7XqkhPfQ/2V3QKtbGY4GLdUWdlVzJu+zSwj43DIbWwz3QQ9tH1bi4ZRUcmVeCBVQ469qyaydV+cOeCBEoxZMn9DUCinx6g4JdKayf79//szmetOqW6lje2sf61SbEWtEL22TVnOYF/DjuxQENQizuOEYUJdFuYA/WiPMe+cNifQy8lWfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FamizcMcxyj07Sr8ljW+LUdkTihuJmdiAlfcZEHwV0M=;
 b=D9DNagyru4SwsVfdOH9AcyLvdSbITXBvQiJPhT9j2hFN1SCNtqe6kHpFPRCpR7sSc0Dp96nNHB7Oye/4v7k9BsqqwC1NaZ+lhgebuaT1+KFJvZof82l81qTDFOa0YoMAnDvfzRnyINr4JFY9JqmbWJebA5Kx+Lb7HgQNWenQzLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 20:47:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 20:47:37 +0000
Date: Mon, 22 Jul 2024 16:47:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <Zp7FYRaXM4NNO0oM@lizhi-Precision-Tower-5810>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
 <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>
 <20240722-displace-amusable-a884352e0ff9@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-displace-amusable-a884352e0ff9@spud>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3e6ec0-6b7e-4015-d418-08dcaa8f857e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JL6wDEU4np2gXiYup149ivE6Uog5+hN40nUzgil6PbFZoVXgx+CJnoHgQayb?=
 =?us-ascii?Q?WEMwHMwwENvNn6f3de/a7ZREIXbfW6B6poXwra9/n5BxaaFWSd/sGhxkwt6V?=
 =?us-ascii?Q?49bITHNOKv1lhy7JTA71+6I1RZLxKS1rS4CTdgjSwHTNibcNxwexQrozmdRP?=
 =?us-ascii?Q?A8UkRnaMyiBMPKA65ytBrhuXmfl01WV2P0cVvM2rTJlyV5hvudcQdTlYoCkn?=
 =?us-ascii?Q?8r5Uf2PAx1PY2i8AcW/F2p6LR2UaafETGTeE/9SHo0GswLMmcblPraMX7NrX?=
 =?us-ascii?Q?8f0ovOCkHk7wZeG+Vj3ZJnHRayURTSU/6Ew2VC7V8HSWNjYBGKVIpWmySep/?=
 =?us-ascii?Q?qHyrfepcrZGomzbOnNg4r3IFjJBnLVfc3LqohQvmVuxPq/XCNPDNryz97+M0?=
 =?us-ascii?Q?Libm15YRgc1OaUyadn7um3i3/YOCQ5l1nkn01CY4E46H0rBeZT5nq96Ojs81?=
 =?us-ascii?Q?So9uMI9poCZfl64RA2B6z1b+m9Rn1hLsmQE1HbJBJZHjuExQ1JKINAEd+BEe?=
 =?us-ascii?Q?TDvEUgvEvAP3dMYRdI3BHhFPjwYTkZqOG9Sj0fJjgOrgEfVbwmFpXi2G+YRm?=
 =?us-ascii?Q?zxlPTMZBc6/0B94MLchufTxbKBOEAacSPv684I/4lxaLSkDHvlQw4rWICria?=
 =?us-ascii?Q?KUzMd4EwdhnXUDhY6vzFZ7kwal0uSA7clM4TXL3PhhCZD1jMQ7/8RpY5TnCn?=
 =?us-ascii?Q?OIE5TdNoqw+VohAHYAldVzyixUYvpfsqYglwT2RyMRYzzM7x/kCgCVzg63bB?=
 =?us-ascii?Q?dz410pXKO6TWNBE4cBQFGqDpE1xqg+LavOrcYiNb0EOIsdUozRKFk8czC3yC?=
 =?us-ascii?Q?y5FwdOypwN8TBi8F1/7H7ah272Ndoio7+zkTKJWpwBUna8igFaxunF5yjGOT?=
 =?us-ascii?Q?+/oIe8WmWbqsYsoIDUd+D6Z3DPd77dzQ6Tb0uCz5dSYOjt6KGPgibhtNIWd9?=
 =?us-ascii?Q?OJhMjkhSJLUlarPXD9PO3neP31K5mr4xW1dTQPA7f3c4CbfxZrzlV+fiXvNM?=
 =?us-ascii?Q?G+RNYAGYCtfwp4UpKmchMLmpMd9ZubYYuEa5dqlYcpHJGEf9SeuzhzHldeHM?=
 =?us-ascii?Q?wAOaPFyn3t11p+Jd6Hvi+hj3dHSY4lJLofCg90Yja7u5FOsDi9PmdS7XXBCk?=
 =?us-ascii?Q?Kulyrzt1gr++N9fG7TqrYia1rk5AzPaUkLTqoQVpfdINMT3cpDlDzYzVwJxs?=
 =?us-ascii?Q?0ybXa/X9POZ6EfgibLx29zs9l4FyiSUatpHW9iotZBSynsUqo3lVhT5YDRCb?=
 =?us-ascii?Q?SvIAxupvkX5Lg8x4eARBvkjzQzu4dAH5kh/jRWcbm0byDXb9RH2QGoLZwOcD?=
 =?us-ascii?Q?Vpn82DDU2t3pRBzS9mSaLQwQ4SDu1Ckq+QE3rS2IJpunOXXLjthoY7rUloxR?=
 =?us-ascii?Q?GG7NhA179lcvQIZY5YqLCheTyQajo/f99te9AITHkgvkdH6lSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3NMDu8v+QmRvSB1IgPgV3hOgB5N3ACrOUZZmFSTh3t9wIeEZKsC4TEWeaTHf?=
 =?us-ascii?Q?+lOkNaEtmD9WBzlxqUXkn8BQzmq1EkJHOn/+hYodDpGVPbkoi4mCIekFXPC/?=
 =?us-ascii?Q?RUe4x7q0vyd9AvEuGEwxOt/KxQgh6BdFpeBS0Qs7UN7rRJhT6CdL7lO+44I1?=
 =?us-ascii?Q?hAZH0vWJfJR9+jttXOkaeVsyabYbrvXKQL+660u4LMf4NWMTXWOLzyhMvPLQ?=
 =?us-ascii?Q?FhLFAh0QUCWdBQiUfaLKPpG3btbU7xJ/nU5xm3f3W7NPWxsw9baFqxRyphCb?=
 =?us-ascii?Q?pL/hZK4XQ2bKyfu40rNwRz4AWU/bDwgwMhDgU0cZOfucOWqOY9SnPEo2cQyK?=
 =?us-ascii?Q?FItCUv/mUeAF+79QbZLtcu1BICfKmTrdaUIRhNaPm8wJa8SndEQRKqZnS/Hm?=
 =?us-ascii?Q?ZH1LzjQBM95MxDujPXNPPLbVvzkKKlGca0JSi7Q1cD0Bpb8qXQ6C09kUIZr7?=
 =?us-ascii?Q?xCr6otkcbdpXP96D4r14vjwBsETsnL8DeP5sTbV1HLI6nxrX0OUBVe3Dh/rO?=
 =?us-ascii?Q?CDM96fAlQEzG2H8BGTtc+yFlIaPwYu/oaJslv/SC9KICASsQ3wP7FkLLNdb2?=
 =?us-ascii?Q?R9wovHDDcmrMzl2EmSTvYiefiE2s5tPTEeR3JUiLhgeGNg+PocEzjDnZBNBv?=
 =?us-ascii?Q?3oD2zhid5AwJ7XSBVVcJDA/WZ+7R/AfCtCX1MWmpHaP6Nn/eagvOPoQ1k395?=
 =?us-ascii?Q?efuC4snM+hGJ17EQV9PILmOVBDNoaiqpg/b5BFg6LITh3rIlr6uJ3r/wx0Rg?=
 =?us-ascii?Q?e4HtlJEv5EGUS9ZxeRf+mTBTVbqJlZbYEkBD5YKeOb2ymoBliEHQMw1o0OY1?=
 =?us-ascii?Q?bbwJDTmBfNlqeFiHFtD3mIqE+8y8ev4bHEAyZKNpp7tQssDtjow8tH0FZ/82?=
 =?us-ascii?Q?XdCQK9O/N8dThXf7gFUjc0UgFPlfSRZOW3WN61F6kqFGtrj/iz2qkSwgtWU0?=
 =?us-ascii?Q?LQX4hB9QiJzJ9FsNG8tjHYZ2c2LNiKvwC7fa+846D0Lj/RhvpfzaYqhOlBoh?=
 =?us-ascii?Q?yRdAX0L/x+NMo424afNj7x294eRbNDS+R03d9irjfiGYFGqv0I0wpYaNZLAk?=
 =?us-ascii?Q?dNMlw8yvA+lIp3eUq4ZplTti4AIuRxbCskEY1QlNnW68h02oH8hohaOiJQXB?=
 =?us-ascii?Q?Sp8s9UVNlYr3zsUvzKwkVJkbugAwZSq2qYbro6sn4agev3f6ZXI1s1t4IqM3?=
 =?us-ascii?Q?2JjWCJoipZzN7C9klBrO90D3lno53el0+8R3kPR2FJ72TUPxeT7EjzYawTtj?=
 =?us-ascii?Q?leDQLcqPL0QWcRLybJ7txMLZZQ+311b1MwIpV2j4nvh5HfvgNG7jwV5pnl91?=
 =?us-ascii?Q?qtgbZ/s0xRPD+YuDOYlxZ7N3SndCc30WLiBwvA3tl/VgOy8P5aFnGJkVYceO?=
 =?us-ascii?Q?K/TFSY+MvF8sV1yPaVkYl8mvmUsTV8dgsY/YJ2+1iSb4Qg4xAVFsulyywqQF?=
 =?us-ascii?Q?klw11AtbPLEauOmmpcypr71hyetOLvz9jy1kBftc6ETtTlu+XvkVBpsL8T3m?=
 =?us-ascii?Q?5bW/K/xWqQdmwiS5O3k2icpPGVBYJ9xadkxeEFoCUvc1mF++KLamU3u+CPhK?=
 =?us-ascii?Q?bWLaNLiySaNAQZ0/Xlw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3e6ec0-6b7e-4015-d418-08dcaa8f857e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:47:37.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjUGHM2NuiYf45qf+y3uLPIHK+20lQXlgjk6unRHD5YPN5DlbbwfkvbzYvUUcIWMryaNRE3E7pXpthE/p/0xHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064

On Mon, Jul 22, 2024 at 05:37:14PM +0100, Conor Dooley wrote:
> On Mon, Jul 22, 2024 at 03:56:16PM +0800, Richard Zhu wrote:
> > Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > index a06f75df8458..309e8953dc91 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > @@ -65,11 +65,13 @@ allOf:
> >      then:
> >        properties:
> >          reg:
> > -          minItems: 2
> > -          maxItems: 2
> > +          minItems: 4
> > +          maxItems: 4
> >          reg-names:
> >            items:
> >              - const: dbi
> > +            - const: dbi2
> > +            - const: atu
> 
> New properties in the middle of the list is potentially an ABI break.
> Why not add them at the end?

Because it ref to snps,dw-pcie-ep.yaml, which already defined the reg
name orders. we using reg-names to get reg resource, I don't think it break
the ABI. Driver already auto detect both 'dbi2' or no 'dbi2' case.

Frank

> 
> >              - const: addr_space
> >  
> >    - if:
> > @@ -129,8 +131,11 @@ examples:
> >  
> >      pcie_ep: pcie-ep@33800000 {
> >        compatible = "fsl,imx8mp-pcie-ep";
> > -      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
> > -      reg-names = "dbi", "addr_space";
> > +      reg = <0x33800000 0x100000>,
> > +            <0x33900000 0x100000>,
> > +            <0x33b00000 0x100000>,
> > +            <0x18000000 0x8000000>;
> > +      reg-names = "dbi", "dbi2", "atu", "addr_space";
> >        clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> >                 <&clk IMX8MP_CLK_HSIO_AXI>,
> >                 <&clk IMX8MP_CLK_PCIE_ROOT>;
> > -- 
> > 2.37.1
> > 



