Return-Path: <linux-pci+bounces-10669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889C93A819
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F243C1F23429
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF514372E;
	Tue, 23 Jul 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MCfnyQEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92613C9CB;
	Tue, 23 Jul 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767200; cv=fail; b=Gx08BLMfWQrw/MvHwRqHZM9FrpCEm/hBPiin+P6la3MBgTYsBaqalHlg2c4rpXHaFcW1Hgb73aFuhYbQ3g5eQU8C0v11CykHvM0HQDgG0Esn3rd5h52MgiP0GorSz4onru6/C+1cDmAAFtNLAHqvWsOsq1e28UPLugNk9FWZKaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767200; c=relaxed/simple;
	bh=7I4SXQhbrLTTqNVkRlS177yJZrjtZM8/iAOekO1DQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzbbaxYEkkAnCpaCID2WXXqiQiLdZ4zMNEGJ111EWKIpD7OSRdej/pQvbFFvEQ0s91g/Fee563ZpxO4kLswNsuOdDDVS+vEmUmJ0a2W3qTvRe+J4hs9+rkJNpg5LEhlopfgbO3p5m3RcfG5s/dRwVeRq4AWQdMO09dLNqc08GwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MCfnyQEp; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVzqZqpDu81t8nMy/yEKMu8pMwggfi2C27xodeEWLDFr8MKAVVVXHkO0yWs9db90NSbi6BFbY6Kh4TucDoyn7FkrH/wtNv6/mPc8h7LbFeYqWW7dfvXwEEVGeQYORo6cSvof+ISf2PX8xCzmED6D1G6MdWvlqFhiiSMfZxIi4nE1GBqYS3sJJNO8XukvmTfIxMjpwGe5tv+2OiD3YAXOa9Xqduc/J105FamofvRTbRsSxFgbzN5c8om/mv1+P6Kclz686zHnVs70nupIhyLSFafnMicGR54UB1OTHHz2iRGn17G1SANUwbvtUqIlVwy6wjCKGwGtAzhsNYQa9045cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm1GFrFAQ7U0L6a32VlotoTgIKupd0hGH/EEjVKMCjY=;
 b=vp6BhCf8GiL058Opej0zzOFKBn/SaEfoSyYsLovSa1yq/CQbgJikAQigPxxOOGn20YjmwR/53Z3CWO8fFGrd9sa/dWj9ErfGw/NRc29MUax9/0wGkb4WI1KW+XmI2rpGfx9ElPMBd8MOV3GTMHsJbpfZqcqDx7UlgzYOdolLFJV8PY4xU+Vrpne3hUVL0+TmcdVGcjkOsfNYqQ5f5P0aF3D8wAMJQ7QEVgINO0rZ5PvaoSLqUNquCwE7t709wrV9Dw/TU1pnkzLmg4t49b9JI4+76MglBudfMOMF4lvJtJrA9bwnZgFW9L8AFVYlJ6yEsfsQpD0MX43gsUm+0mAzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm1GFrFAQ7U0L6a32VlotoTgIKupd0hGH/EEjVKMCjY=;
 b=MCfnyQEpf8xJd53p+YuX8uAO0C80B8sT6FgvIf9lOG+jG9TinO/QpwC0dkP0UxeRTtsQdHKlqTNNaYseCYFdU7dqdjFg+SDOr+OwsuEPPJ5YVEEeWyPW/zK3ZsORAQ76NI4dwhAwSuKLBxXAAcppKkG+Okj6goYUHkPXkcbQFX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7692.eurprd04.prod.outlook.com (2603:10a6:10:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 20:39:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 20:39:55 +0000
Date: Tue, 23 Jul 2024 16:39:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <ZqAU6Yqq7182T5Nz@lizhi-Precision-Tower-5810>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
 <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>
 <20240722-displace-amusable-a884352e0ff9@spud>
 <Zp7FYRaXM4NNO0oM@lizhi-Precision-Tower-5810>
 <20240723-spinning-wikipedia-525130c48dcd@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-spinning-wikipedia-525130c48dcd@spud>
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0233c5bc-9e15-4be9-d6d8-08dcab579c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgzV4xFYlH7uXaYdEOdHN9T3uweeoXg/GWmA/d7V0H116dl1+UKIqLdcbFuD?=
 =?us-ascii?Q?4EAgJG4e0XJ99n+6Nr8jG15+PG3FRvz1h+bWNLC68lSG/twt0rpnDuZ5zy3k?=
 =?us-ascii?Q?ioErt5ahGsx4DtUbbKnZtipFSv8irGxLkqvB/8pBB8m4UjxsA9fP04EXwyFT?=
 =?us-ascii?Q?4ju6C0m+H/7/xGOWlSCeL1G1FKIW+ZfAqWR6/WvySGKomW0s8YAJsacB55/Y?=
 =?us-ascii?Q?OX33z1ZQLAYJPcfxJuQB8uSCMEPHH7AdKPmuIlCJTLnbERvWVDydtw4DUKwR?=
 =?us-ascii?Q?Fl+UwSKNCkoCCZvxrROtnF3gqk1IXMw7F3bwk9WyQZwT+YE9y8fde9voE/Zq?=
 =?us-ascii?Q?h4wHjRf658ICoIR3Xt0ZeKBggLHmUwo/M56WitvtlBhZwhM4g1Y+Gzhcre4F?=
 =?us-ascii?Q?uAOaU95LOPz7jmQYLasWDKpVGp9sPnIqpQgmPhVFjWG1oUD+xwsWGWnU5jMn?=
 =?us-ascii?Q?YiRFgdWUGqtV203A11r3rcydaSwa7MxWGEVXrASujgNlFHcoqoaUl/XSNmKN?=
 =?us-ascii?Q?JuGauXRlUaFKAhhXWnrA6GB83LJmdBAqRkuZCIXsln1pQJlFohlbZjK8XVxd?=
 =?us-ascii?Q?J9ECaYX77VRw9YWkDVD2LxViAkK0Wk3MOkYDCCYsfj0nfB6ZA7YfRJPLJSeX?=
 =?us-ascii?Q?TO+iNYxAgEi8BtMf6GAauGr2Fb2KLifqyTzc5MbDXagMGcn/wo2VzMB8NOLx?=
 =?us-ascii?Q?ooehX35SSsOMpGGWuDebDp1F93klRAOarTB+mBO9Dxf+cDg+q29+1BpAN53q?=
 =?us-ascii?Q?Tjci4tMIf0L9PuScM7+Iwi634e+39w1NXs+TXJsrrf9gI+JFsf1I7EMQEBMy?=
 =?us-ascii?Q?96JbOCLzOlywuO9nR9JHzKUDl34wKhXKYI9DbQWft6VSxsru81LM3aPM+63n?=
 =?us-ascii?Q?QlvBCg3gUqUTR+zhaaxGP7PUowPKKLfqmtye9YW5Q1mtTt/zGYeT9Vja3okG?=
 =?us-ascii?Q?7LlebaBC918Mo0GtCV8Y6AuHjJkOyHb7wY+2UJw3kF8VkX4r181HqOMNXY6W?=
 =?us-ascii?Q?aVETgOsEkIyjbo4KQJWXUeAJdEAu0ek9HlKHx9lmu8bMXz2usbaXh5n5+Vdy?=
 =?us-ascii?Q?1AN/VxL048gK2Z69dfdS45A1bXp+oCZm2rnswBExCS8CB3vf3evV9FzbLM+g?=
 =?us-ascii?Q?2MDJCwA0Vadgi2RsHD6oi3LOnDHc2sA3DgXuC+JSRH9PhjM+5Dr20Ev7nmec?=
 =?us-ascii?Q?ve5Qn2ugeOz+7/Es4bitgSni5GyPMooBgvl64xI7IFskvv9ng0Mb2UuZ3nQO?=
 =?us-ascii?Q?nj9P4AfhLdimsOezqFyQNzMkUOjGu2FP5Yd0SaIbCTksEuF4Da6dQYb8h+6F?=
 =?us-ascii?Q?DI0SYkYyIBqTrxuCEv0iNllwybT+OjbVdjSnOrLlAeRjtBxUSG2Nslk2JdnV?=
 =?us-ascii?Q?EFL++xT0rzb1yPu7QKsE0uP5uuvLActBpvyvKy5hjCSBdhvgRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdyRcCnjGAlbfnV73aRRKd+FRuPu1XkG3qArPsVifvJX4lfsSTBfSlNyOK4O?=
 =?us-ascii?Q?QIEdl8NKoX0K+/69d7eW+2FkRPC2fGs8C8L5wWiFZ7uujBRGbczgYnP9Gezz?=
 =?us-ascii?Q?JZs2iYpwt9wENES51Bgz4EmPU5I0PtNmZD14zEX4Y1uuxFrq0wsD932vmFu/?=
 =?us-ascii?Q?l0dj31HdQBcPIO3gGh9hipntXK/ucOfw6a6oejOaFRCtKdvYp/+lxHDlQEgz?=
 =?us-ascii?Q?iIZHYzZnKREZLQn+fla7LsPX25kxmgLyuvzcVP6tl3KZXf3i3U7hxpHMnupW?=
 =?us-ascii?Q?TEXVhkW/ICM3IdI9LHWyw2xdUaPe/vJBrS7V3Gs8g4VUoyhnaGqkqAgzMkcj?=
 =?us-ascii?Q?BCqgh1T1NYhFxbtxvVekBkHiofUVPUfA3dCtScz8/h+Wj8kQNk5Ce0QyH1GY?=
 =?us-ascii?Q?RNYf/pVlp7fEXyT4jgKicqt89bunx+fsAa4xTdTzIRetFkuzYCFr4FVe6v2M?=
 =?us-ascii?Q?7dcefZoZfQFpai0DDqKAq+1koUyQvNfkjHipK/wj2qSZIpyGHvRplrudunoC?=
 =?us-ascii?Q?whcHfgxNtxWX1XO/+TELLmCS0PEg/hxLRw9W0L9DAUQIe2i9RBVcczS+Zxtb?=
 =?us-ascii?Q?03egn8bV8duC/i8Obq60BKroO+9ux3339o0yPv1fxM/bA9UeSMlt1YIFP6d3?=
 =?us-ascii?Q?J4jGhAtRebKtwjoBihQfwAyc9RJ94KfDpZiAWeWe7fWCEwjkme8VnC6LVbxm?=
 =?us-ascii?Q?zxbxH5PrmEQDnmE4iV2eDrxxija3YBYwttFn4Q5hx9a2rjncVMsSKcN9azGS?=
 =?us-ascii?Q?vSKLL5fSFiwwsvUnzwZEXAtBG3bXrP/GlTECI6GS3RdLN90bRhaTxLMBFcpZ?=
 =?us-ascii?Q?kw1qhATuewXlT7oTPvbJ1hPISA0G9IxHioTAxnK9OBu4+FZMRVJAR9v3GvUh?=
 =?us-ascii?Q?AIaX4OSbAe2qRABnSsi3kCcBNPY9FeTbEP2v95Dtj4Oun1apwY0HTl2UVEUn?=
 =?us-ascii?Q?wnCS5/daQ3aKKWZ2RrnwyBtvJsd1w+lPfIZyPnShmtcC+DKbbHYUDHJ6ER6E?=
 =?us-ascii?Q?M126UHbCTRM7U6O2KVeEHHQxxcztAle1dtyzwOHVSHHNmQZYIp4PdC8kr4uj?=
 =?us-ascii?Q?NsTOTOdOnUtMqSO15Uo8dsgUU9LpjetWsB4qhsyO5eWitOQveILa2ohybjuS?=
 =?us-ascii?Q?X5JEywLtZYo/l0M2YvShV7gi0Ab0xLb8GPrO2Uit2zobB4rgSYK8AHYzGApi?=
 =?us-ascii?Q?YmWVLo1AMy/wR24t1/lGQgCoRwH75Cmt1JUg4D8eOOWN0It60mv8X324kJJc?=
 =?us-ascii?Q?te/jdCj5YUYr35z4HUqaB9iQ2Ta4+/GM/aKI1NduIGdztSmbYmGyB+uoM9ua?=
 =?us-ascii?Q?i/IUY2TDt+hwe7lae7hX1ePRrqIFXgGWuqWZToQvRSuZRFJOESniVh72iCQY?=
 =?us-ascii?Q?EPcH3wyMKnYppVMnqvQRLu3YtrzKhYzRGc/XuFQjFLBPB/Hk9u/ojgjNx4pe?=
 =?us-ascii?Q?wcO+D4zBVpMRmXIy76CC68MSp1ua6ART5/LO/zpBQleVI1r3K/2BKKTCitae?=
 =?us-ascii?Q?AtKoFdthPYIVWKzWazk47A4IK2O1OVXiwRxZ/ZaEVlYkt2KM5idod3gDZ3w5?=
 =?us-ascii?Q?dZj6KapKfBWFKraPYUw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0233c5bc-9e15-4be9-d6d8-08dcab579c7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:39:55.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEzDelJQy5+++ZjmRdVNSqxUtP5tslFP6FuTbYpWKMkxHLvMooNmBil3AiIEBCkeTmVmb6QiwmRSYRj45GfUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7692

On Tue, Jul 23, 2024 at 03:35:11PM +0100, Conor Dooley wrote:
> On Mon, Jul 22, 2024 at 04:47:29PM -0400, Frank Li wrote:
> > On Mon, Jul 22, 2024 at 05:37:14PM +0100, Conor Dooley wrote:
> > > On Mon, Jul 22, 2024 at 03:56:16PM +0800, Richard Zhu wrote:
> > > > Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> > > > 
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > > index a06f75df8458..309e8953dc91 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > > @@ -65,11 +65,13 @@ allOf:
> > > >      then:
> > > >        properties:
> > > >          reg:
> > > > -          minItems: 2
> > > > -          maxItems: 2
> > > > +          minItems: 4
> > > > +          maxItems: 4
> > > >          reg-names:
> > > >            items:
> > > >              - const: dbi
> > > > +            - const: dbi2
> > > > +            - const: atu
> > > 
> > > New properties in the middle of the list is potentially an ABI break.
> > > Why not add them at the end?
> > 
> > Because it ref to snps,dw-pcie-ep.yaml, which already defined the reg
> > name orders.
> 
> Are you sure that it defines an order for reg? If it did, it would not
> allow what you already have in this binding. The order is actually
> defined in this file.

Sorry, I missed oneOf in snps,dw-pcie-ep.yaml. You are right.

Frank

> 
> > we using reg-names to get reg resource, I don't think it break
> > the ABI. Driver already auto detect both 'dbi2' or no 'dbi2' case.
> 
> Linux's might, another might not. I don't see any point in breaking the
> ABI when you can just put the entries at the end of he list and have no
> problems at all.
> 
> Thanks,
> Conor.
> 
> > > >              - const: addr_space
> > > >  
> > > >    - if:
> > > > @@ -129,8 +131,11 @@ examples:
> > > >  
> > > >      pcie_ep: pcie-ep@33800000 {
> > > >        compatible = "fsl,imx8mp-pcie-ep";
> > > > -      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
> > > > -      reg-names = "dbi", "addr_space";
> > > > +      reg = <0x33800000 0x100000>,
> > > > +            <0x33900000 0x100000>,
> > > > +            <0x33b00000 0x100000>,
> > > > +            <0x18000000 0x8000000>;
> > > > +      reg-names = "dbi", "dbi2", "atu", "addr_space";
> > > >        clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> > > >                 <&clk IMX8MP_CLK_HSIO_AXI>,
> > > >                 <&clk IMX8MP_CLK_PCIE_ROOT>;
> > > > -- 
> > > > 2.37.1
> > > > 
> > 
> > 



