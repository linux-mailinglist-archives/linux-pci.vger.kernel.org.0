Return-Path: <linux-pci+bounces-14225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9359999214
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC592822D3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA11B654E;
	Thu, 10 Oct 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JYVJ/mzM"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776519D889;
	Thu, 10 Oct 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588072; cv=fail; b=LYz63SRs1J1oWn2kndrq0whXiDoL2Q4oHUCohD2CDV0Z9mCCzW1GxeG/Eo9HWkOQJFY4pGnRSpEOHk0YhPWDvpEsEwEc6QRBJDkk+NpVqSan+A6CRWSJkv5wllLTW43L94Y5qtjt1dX+QY4NgyBzs4sLYd2ATd6fUzotinbzzmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588072; c=relaxed/simple;
	bh=of3igtqUr/6TnVTStFdu/yRoGc53TUcNOpIlo/sKLqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OI67OI6M5UQ8kT6DKvMijVObDAys6PZudUYafW+t6cAYPmI5d6zRBTRc6ijA8xBgUZgpaf8ba36Z7NP+dzvYjLsVbl1kH2fENEgeRCbWqgSPqZud6fGdxLkVQ1zgb+FHRj2sfi1onLg4UfYyIxo3tCylrXy5fi/H8stTEBL9Za4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JYVJ/mzM; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRoTQSFojz12N7IamqsHMeNkhioGVTzWMHO7WOSP0E4FkgCVy9ZISIN3DCT4XYwE/Al3vhxZDpz/TaDAe1zAAn+t33YXDAdaAb/Hv6+wvz4mTAoYCvy5ngg6IxFdTtdsKO3gaZteC3c3HVkwL9XfjCGq5+hrMu0s/GI15zYjcXH6mokCPI7kSFsc7eWufSAWJabzX9rEWWpVXbV0xm7t/luyTxdhRS+oQoX8oCZWD1YGlOH+wJQdKNo3+2S5Cm14C37ZBDBzzsWUBF29teEs6hdyw43riFX14hsTCi6AOT3PxRu00/aEuZ+mLzzunMS4FpJeidCNAeDFrmp7B3hi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q6ndB/PQx7qSd21uG797zATNhstuCbWX5WykZ7OgUo=;
 b=AMOO0rv8dRi+/RRBW3RfLIRwJSLWsknJvcoh20IeiDCBEYCc7dTE8Xj+3hVfa6YOAdyBANRBWJAX7zcb0QigiGqYbbIA3ZDoe9waLbVYRtW8DCZKcAoRykmgcSNTadZLwyg+Ub7RjEMeeakl8J+SBrWlae/cRDxD/un5HRNMgzgmZK3Rzl4kusgTjpO9YQ/Q9rmKkfP5CuZ7YSzpKedhD+a56mgYpRdmheEfQNgJWP6v2tYG4p7+r1WbermgDTTKLN0fw+Fyy8TDc9f/GF9x50iGlE6CJV9Udb86dTdC8G9etLHpujoT5dbYsGp1T22+SYhe1CcnVnb6Vs1vby1wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q6ndB/PQx7qSd21uG797zATNhstuCbWX5WykZ7OgUo=;
 b=JYVJ/mzMj1d2sBPbslX0Elc1a5sopniaJs3G3SR2YKRuuuZdyNWBqHP1J6uyQG2B/Vt7ynjGBNWUXiwczpkrKWCubGk2Nzdm5yn+MTxJgfPo3gzMHjxsuEGQpdv17t4ud/amFgxbb9AeXbcG1jOfAWSBYOvtcHcPmb2qT1otf1lu0ZAjdVkYpNzx7mhTzhd/YUKgE/mdyZc2waAPb5ZIk4wV7YGju39M17M8kSHDHooRFLpiBfPxXDFv6vQo0tPkpF9QsEpBmSTFqx898Nb60zk5ZCt60gm5AbNNbcxb41Gj56XkDGrHw9EgwHxb+9ZnKd3We/g9xbYfl3WmsbV6MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9958.eurprd04.prod.outlook.com (2603:10a6:102:380::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:21:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 19:21:04 +0000
Date: Thu, 10 Oct 2024 15:20:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files
 and maintainers
Message-ID: <ZwgpF3CJepAklWeT@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-12-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9958:EE_
X-MS-Office365-Filtering-Correlation-Id: b479bf1c-1928-4ae7-44d6-08dce960af14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxQS25lQMxk4J+sAhajPQk2mYX4vimDl50TGqP07LEDWWKRKNrfra40UD4vM?=
 =?us-ascii?Q?oMdy3MHGf7J5COWwj41QmR+iR1nf9d9dpFHIg5NNZPc7/ffnwcemIzt25WGQ?=
 =?us-ascii?Q?Ki01MrDp0VpsrbccBTRIntGDpC/8GemueeCzyt/6wc628qw14LXW0Yg7eHEn?=
 =?us-ascii?Q?txB+TCXMaiSeBO4mUWszU4ckwv/cRvUiGJYOcGfcP2kJBoWmXDsX7ROFstcl?=
 =?us-ascii?Q?I5KIt3kUYmaIf7SqHrhcvz2pRAxeJZnx95fL1GEwm+jFX6Rapmdy6BfT5ptN?=
 =?us-ascii?Q?hHho9rDINwnKliQ5amHp/4QFsk2dc3ASA5a3k1cN+h76iilUQl/JGBUgOHdJ?=
 =?us-ascii?Q?f5pgq1Kb+nKsC9pO/RWNJUC+qrHfEaQUNISCbcNGOeEsWl0r93UZGWdxYqa/?=
 =?us-ascii?Q?AuH6Uz2w9NcMNBcKJTlmCXUCVQxaLDq+pDCieqhqM9/Htr390yyswelaNG+k?=
 =?us-ascii?Q?3eLsiAFFXbGO+OLRaFA+5n5w4gkqaEyeP4ajSvtPsVDENs0SnapfU7lQVz8B?=
 =?us-ascii?Q?try6bubBGlyeE6BuGi9FrbRCdH3ODAeCA5pDMPIN9Ip8b75BLfkBB+hzDHjQ?=
 =?us-ascii?Q?UMxXzE/dcVtESVpM+lGstPL+4/FCspFhaN45pIibcP3EdJCcTUlxB/+DdVjD?=
 =?us-ascii?Q?krVuOvcxy6S1rlJsUbQGZUMF8WF0tM3wSFCrzkpmO6kBaSys/GDh88LdnbYj?=
 =?us-ascii?Q?C1+a8JwdJhhpl381bSoJHWPHuLQWfP/3Lcj3IkXoS9p7fgA72NBais+wgSZm?=
 =?us-ascii?Q?cahQFVoYtqbzZwtOeuY9klbDb7Wc9PXNF/n11Ji4Rc6oP1Q8/5SIzW69LwvG?=
 =?us-ascii?Q?TkOv+GPqrXCyESmE5eM8xkHVVY30d1g1pJ1b0MIDUQ5leRVRB3YY/E3F+LNz?=
 =?us-ascii?Q?m12zePWvI9/8HJeRGPdm8XMgOpB7ER/fA8jpLszDx4lR9Invl4dlXe+AnIsa?=
 =?us-ascii?Q?VlsccR/9EcaYIcCat4934sRXPrNo5ZwCv+SCEzoYczILr7qpRKn/zyd5FoxT?=
 =?us-ascii?Q?zEWdqOmn9F7m8cKlYMsU4yyH4ThTWBTT9yGdnAI31yKkkBFIppczfGFv3Kg+?=
 =?us-ascii?Q?/CQSO1zsDb3SBA1YV9/fLBsvFvs2EXcmfBi+mrSuRTH9oEGdtXIAw0wvhqdu?=
 =?us-ascii?Q?5rBP3qrys8JOt/sKK3f3I1qha+3CxlHMM5baRPf1C/lGJ9rPNC4PnwgK0k7B?=
 =?us-ascii?Q?N9taL3MtVORhwGs4mUBE56E93TLacBeapoz97LvHZmn7A0Yy6jQThb10UhhI?=
 =?us-ascii?Q?V1UipTjFbKLnDNn3fCtldou0K4nvQN2iYb56wueYQ0n+APQgAKDEWzbje7RS?=
 =?us-ascii?Q?JblKX4a/hhwrmqdoA7/QaSZKdtCWtLzOWr+8cMv3zPIZmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mXlMfo4t6uuTnDgw2GY2RKqsSFLVliTAyScGw+y2X4L0N1JDqWqEfVnZhf0?=
 =?us-ascii?Q?1V91tDQW5VpNyEKQTilWuqjqMQFHNCYiH7lMbPhef6OtJi9TstMTK26tHR6l?=
 =?us-ascii?Q?vTZHbLzcDcJZBQtsX8USjjA1/It9usGRHW3eZd+Lf21/+tHQ9ke3dF4BANCF?=
 =?us-ascii?Q?3l0OSzxjHXGy9y/jqQh9kPBM+MK+xRA6llzjRWU2T+yiOqcUX0FOUR7mmZeO?=
 =?us-ascii?Q?vSdCYDAVmsnjWg1S8AHhFN7uSg6ozrV9XgmbmWZgnxapuFyVBCA1pjOw6wWd?=
 =?us-ascii?Q?ch9bEWSuoxlX9YAR0nb+iy2rZZPIKiAV86bWbX/bhKVUt7+X0NGEUNsT9d6+?=
 =?us-ascii?Q?D2Dts6Mk0A5jsvaG26cP549VR5OVNjijClYw7Ooh+GdqMi86Tup/Xb6UASz4?=
 =?us-ascii?Q?UTZXFzIjobhGwG+L89XTyT0AfwFmEtnSv4pR8hbboUIPaHfHewlM16o1jg8z?=
 =?us-ascii?Q?MrIFdPDpsk2f+KOmW2Y72QCvtijMwsTyyTiCpeU56la0l8KbeuOjkohfHhGy?=
 =?us-ascii?Q?IXvPB3/8qJW4z8WOdigiq3BACkFAp0GbsIUNv2s7f0XM0WErl9fhuY7WxHV0?=
 =?us-ascii?Q?wlprBXNLLhbbxeJOZFHIY1Si2q83SY6fu1SCwaF4i3VKdA4xc8Kl1rzt5v/g?=
 =?us-ascii?Q?hqRPLsCPlniYWuXhOgYD2qZI0ylgZPFQVbOi7TQg8AMODbLIs4HnjgXWBeln?=
 =?us-ascii?Q?61fA8VeEkCskDlIjnKg8T+2sR3t74g/cijjgd7h7lxHER+/KooVPr7z1DNeO?=
 =?us-ascii?Q?KjAMq3CKxswCzbyDb/nQqhAWvZTJGJ2PpjZq/DO+5qxjtrcFsow8SjGreDhl?=
 =?us-ascii?Q?XEArMT0V+vKqeyrNcjepKf5+fyXYJAOhNmiAn92b/0tc1Dd7uIrgO/4ErdXT?=
 =?us-ascii?Q?wgabQNoe/qahimncbZ3fcYklnhQ46hrYGrDo4SRtQmOwqJXeAcAKdQQ3FMPn?=
 =?us-ascii?Q?V4sQs90AjyYfc8taTnnGFkPfz7cjRht+opEKmLUXGjkZ7VK/zkQgfInaBIsm?=
 =?us-ascii?Q?QNXP/4WGSGVj8+AzprmDv8UQ7lDQLYo5Vpj8hSxZTpk8ERWv0Nf7Y6VElhUJ?=
 =?us-ascii?Q?Cb8MDrybTC0uoN6AWdgFcc1XP/kVgwotGMS9qh1D/L26A/JCltj3BWw9X0HQ?=
 =?us-ascii?Q?5Pez+MUtDW8APw9rOH4jMNALuFE6goldbbBIemji6qUOkbX6N/6HeGq8MacP?=
 =?us-ascii?Q?kSgpt6QF2XbaW0nICgzG5JkkAjd2In4r3Mr/upczMBopr217KC2QJLqqX0+1?=
 =?us-ascii?Q?+OsU8paA+B4TjBa+EnOr0PlO7SIzz7phc60krpWBfMAEFDQZSAlmTSQqxlrC?=
 =?us-ascii?Q?yDegqER+oRv+ROSyXXE5YbBQucrEiIdH29Gc8KWT7NdFlifq7PK4DS7+/hlr?=
 =?us-ascii?Q?qA8LmUeYGp8UyLe9U+5uZ4CGa3eG1yYZdfIyrHTEcMIA7q/7pc1+j49hGvrX?=
 =?us-ascii?Q?lCsmKws4XQ/zfSebeHvZ+mQ+6+Lfztx+t7437ktXT9gG2AJpENsrdGi7D+Ux?=
 =?us-ascii?Q?+RmRMyxo8imd62nq7LcoazhXJdmZjPsYoRBmuDzym4pHQSn/JuBlLighMYAI?=
 =?us-ascii?Q?lVW0Z6/dLtojaMWLirobdUh9xTVikQSslT6zU0oj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b479bf1c-1928-4ae7-44d6-08dce960af14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:21:04.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOqmV2EesHFVXEqCNKmD5R1c7WhnC2UnSETwrUEd82d/6wQ7fnjvz4wCWreDdAZ0FmXz2R2v5gG9LjjA7FuBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9958

On Wed, Oct 09, 2024 at 05:51:16PM +0800, Wei Fang wrote:
> Add related YAML documentation and header files. Also, add maintainers
> from the i.MX side as ENETC starts to be used on i.MX platforms.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af635dc60cfe..355b81b642a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9015,9 +9015,18 @@ F:	drivers/dma/fsl-edma*.*
>  FREESCALE ENETC ETHERNET DRIVERS
>  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
>  M:	Vladimir Oltean <vladimir.oltean@nxp.com>
> +M:	Wei Fang <wei.fang@nxp.com>
> +M:	Clark Wang <xiaoning.wang@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> +F:	Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> +F:	Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

Missed enetc_pf_common.c

Frank

>  F:	drivers/net/ethernet/freescale/enetc/
> +F:	include/linux/fsl/enetc_mdio.h
> +F:	include/linux/fsl/netc_global.h
>
>  FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
>  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
> --
> 2.34.1
>

