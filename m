Return-Path: <linux-pci+bounces-14099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2B9971B9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717E71F2AC19
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4FC1E22EA;
	Wed,  9 Oct 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ypfx90xI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8A1E1C2F;
	Wed,  9 Oct 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491414; cv=fail; b=rxlYCLVE5iUUf++ASA5VqTtcUPG9bzs0yFJLrt1zXUMpjlaIMolGRZl4ixNKOB6gbnrjCG7sYan7U8MfbL4+47QAkWqmhbMQ5wBs9QDjbR0oE+74/C84MgJf84KYT5U/KgUKNRxRCTelWI2Q1aHpy+V53oY2sdoHfYaVCFiuGpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491414; c=relaxed/simple;
	bh=mkEf8GvmwG0g4/H532gkj7+gHWfwuyz5VrIa31i1j/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwaQARZyZ/gFQ93uR+ge238SVOTOEgGjQpQQN68z6zbzWVuOTmiI65btkV8yVX8lswMB5AOmoafbdNU5JTlAEmoXvSPR86ConzcnOGVjmhpZl4SzprL0E6g7PXOQc/BZ7GY/HmQXj7fp2D12OQhs5pQLdF4deM9QdC+50rm3ve4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ypfx90xI; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZqnAIi6KJ/HWZaT86WXbw2sQ3UUSV/YTTf+avE54nrLAoH9pPmf8jiZc9iwxuey0Pcf+8Y2aVUiMT6C5oEVMC3H4DTTyMr4yY2Jua2sU2hMlIwTHjdTczfuixW4ocd9QzUUEBFC1c059/5gSJhi6mv8rkFcaxhtlPJYybjMEzF1C6HHvgHB85pCtZQmbxJE0/XLALCOxX8FLrAx8tz4Lb3C/UOGXlsLQMlxXtnSc6lqhhW0Jal91yb0iHFmRg9zDx1s/oTq6LS03I12UECMhFFG3TUfIRlkX861/Iyfy5CAQBQVw9w+SBr/JchirjdBaYLTVYlB2c3l2/jN6wQCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzoUDNFjbBFIzkeuFOLJZI9FKa7Wss4lOCpRDz5PM7M=;
 b=AsYMGbfsogaaiXiDepv76IVXE3h8b1XECuK8nq0mxW1o4cfJ3Ei92BopJwR5aE7GPAMJvalPc949n08yIl3EXYa+sIIskg0oslLjvLkA/PQJuv5+Jgtir71fhY65sGNnXkRqluorlBNOLd9NDNnYG+D7l0t2znrMCwwx/+fFxlcsAb4w8hb65+CUIqjxORgHTuIjVT+8W+TeMgyvY74tuauWunLZbs3AFWlotxVCNB+DhEDNmBDxMbP8L9MdaPZTiXWzbpRm9VYGsjajYyumPc04MKsW8QPdux/VRlhZbyfRyKSOF56/LyhqT96+ZHxKWiObOi1JtVkMObIlqtTwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzoUDNFjbBFIzkeuFOLJZI9FKa7Wss4lOCpRDz5PM7M=;
 b=Ypfx90xILCXkVJyMen70g2PfIec/Pd5TRnPwj+kkcZJiodRqziNcrzAh74GcXs908+rcACvIMEpig3Nm5YTx9Hws7fxjbVYoopF1s8+3u8/LxXpeBoQQ3RrJVxIcRgL0/BPhJ8x1u5j9POUMddZF8GAdVNHDhqZiNjiMJsxkx01gBYwq15LjeET1EIDcmUGwlb/yLG/dsempX35eayvRqOKAROBI5jMBHJFgsZ2uyAIvb2keq+eAEhgfw0AaD4RZCZ3UKumD3MzwC3EPMffwso9VaYfR6Fw8jH81b/dSbBgX7At8MY1QdA1jNmNEI7eh6lClE/7gwJm4KFXIQJ2mdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:30:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:30:06 +0000
Date: Wed, 9 Oct 2024 12:29:57 -0400
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
Subject: Re: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Message-ID: <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-3-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: 889c6479-b5a1-4707-f179-08dce87fa299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1HgKWB0JFSXdRZUOIzWDadGlLgpIn5rNetQR8cYav5grSlXu70OWzWN+HXeQ?=
 =?us-ascii?Q?9whyIB7hYFaczeRxozw7q0xYG1CBYfe8XU68t9zehJykrS9ZsRVliJHq0/2Z?=
 =?us-ascii?Q?oJkzSS7Lf/XrAum4bU9UNoFclhOEp1jKWOwpgGOq1/bW+KrwjORD7U+VzLPz?=
 =?us-ascii?Q?hurSbzadm0rg/BMUUmuKoP+3M1jEAdcFmlecMtCMO33oD6Kg9gvmKQ67Xygl?=
 =?us-ascii?Q?2Qs+HyxwoUao01m/2T0XTkotju1y65MvrzQKVHWdEIh3zguyQysIWzZCsa4g?=
 =?us-ascii?Q?dLZZGQ4Ggxpk2U+iwcnl79aJNMgOEC2ITeSzCNeGkXJy/vb3dIAff4VVbGIK?=
 =?us-ascii?Q?wn6JWWQPbVeQZcKnFNosqXJeNZo9665gVzTud1ujbG6s1zUHDl+CDBhcFWva?=
 =?us-ascii?Q?cjqGyeD26VOGPHT90Fb0jfWx90ugRqeJ7piERf5Soj4Zz1X/6DXtMTIyCgJg?=
 =?us-ascii?Q?UmwIklVcfpx5c11b1p3BxY9tPuoXnBOAYzpkjN7RkpNoR+TUT8Zf3pVkru74?=
 =?us-ascii?Q?NtNbSxjKd1xAHp59M07jutELgBh+j4kv0nGnQhh9D/pgMYGJii6uMVKTbq/k?=
 =?us-ascii?Q?tpoCLL3DLO3QaXHIeWhclcAUQ5sH2m2sPNOJVGS6QIgskqQI6UyGh3IS4T7F?=
 =?us-ascii?Q?7cNA1lakJS3f/hylH9+EuIWPDAT+UQffO8f0F1ZrrTNobkGKtY4sJCAyQwWk?=
 =?us-ascii?Q?P2mQEcKynAWnc5b97sTc6wv6MUOJiSZ9zvI64RwybOPiPSsWhMxKg8mMCX4l?=
 =?us-ascii?Q?Of5ak2GiUfrW2E0RbKjVJzYjYp22aB0C7Ma2IhrwpEcT6CQV+vUsZiheSgQo?=
 =?us-ascii?Q?UP5TYNaBp1+FE10eymYsBkoomw1+t1qOwdmlPu7X6C2FqzOFQZ6N7Ul+OKH1?=
 =?us-ascii?Q?Hn2eSp/rouh1cxXLuki5Pn7/vJi45RGmXECskmLvbISQhZjPWEO8f17AFXSV?=
 =?us-ascii?Q?F4vA7a0Lfij33v0swwSsXmlMuKVTZ40CVuCeWNTgytuEboua3j9vRT/SvNJ3?=
 =?us-ascii?Q?3VO0FGmsXCI4XqXV4SHOyM7syColD7wlhphUwZE+D41/kj1J+y1xNKEp/nAU?=
 =?us-ascii?Q?h2YsWOSLJkUT/+AbQKs0wXBjsggKt0Hm1HbU5fzb4R+Z/UpEx89XJ3EYqiwL?=
 =?us-ascii?Q?rAtFW9pU3LJJd60rEfqTMW/wtNtC/PxUYkAYgN0wNFnMokiDr9g5mMMRU+OR?=
 =?us-ascii?Q?JTiBWdMX+3Ljmq+PTVJpNw55SOKaldAVAQyR5wFYv+B0JiqUDL2bFAMA+qGz?=
 =?us-ascii?Q?dm73teC/Q3zl32ac2R/VRjuph3Owmqz0a6Gk3x6mwX7cTKbEeC6HMZ8EBkWP?=
 =?us-ascii?Q?d6q9dCubFEZ88WdxJAVlUBErysfjcehcB6aTXxrRvSeBnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3NjgmmfV9kjk+5+tmB2ee3reEJE2X2ZIXEg0CtSAxGNAT2MyTPkYUOkPYRWx?=
 =?us-ascii?Q?oZR8oNWaSiJ6lauFkIAVwu+uddaiKck8tGxyFv5JeBEaf74VaWkRlW4+hD2S?=
 =?us-ascii?Q?ZiNNR2Czljebksvp0ciLplfqwsT9kuXu+moo5eCnVMGays5UHBXXr3GOV94Q?=
 =?us-ascii?Q?Ya4i+jkrUUQxGL24h+G4/umHyC07YBqAMhxMZwjyxelZPqqZxAW9HRdfxs4b?=
 =?us-ascii?Q?6V7dLGmRxqEiLLWLSy9OanaANph+jSgOSX1D9b25EpPhIHpklQ9NfiffkJ5r?=
 =?us-ascii?Q?mehoKyx9aJa/fDnjyi3GzfbEYLcpV1n2g8KCV7vn5krQOAoCYjk1a/oeUSJx?=
 =?us-ascii?Q?dAXq8ZgSmuIhm8rQbVxn2tS6F3WyhUx9smjFui6K16edq+KqSGSLs8JI/wYq?=
 =?us-ascii?Q?DFeEDOk/ooY2nB4Ssh9MRZO4whZBL7lmLPEH/gPg/7JuONcrUS6+mSrSAvpb?=
 =?us-ascii?Q?mZkGUWnDVHsyWnjNI8vRRsBguqxsO3uh3oABdc/wTdqm/VCkiPpipbiXhyzN?=
 =?us-ascii?Q?ta2P12I800RS1iLfSqlSORAy4WA6tOK6/KRi8jXBm4G2AzfA2ZEud5nOPWiQ?=
 =?us-ascii?Q?Ryp1xVcuTvOC+1DzBCX4wjy+j3t+PyLIhD7v2SqXgonKg44n0uMvoUVKoKh+?=
 =?us-ascii?Q?+CGbzeCZYLPrarJ9yWBzT/OC28xH3eARU9I74l/TPiyxhXzLQBhcC8op9H48?=
 =?us-ascii?Q?HVnTjrpErX0ILps2d0qx9PcKRLjoDVHEvH7L1ozXOaoV5+edf4QK/7f4jczt?=
 =?us-ascii?Q?fhBpRLOHNs+znmlQNp7uc8Ig6EXzaZaZbyqfdouE1y9MCoBjZbwPV18EeIXU?=
 =?us-ascii?Q?tsGIBYpP8s0NNbXdoPHObFms1/OWN9FX20uyoSbzJpT0wkboJ2MI/q+e3dg7?=
 =?us-ascii?Q?9nIPMNbIcQIcv8TDwt+eGwOEA5Txx+4W9L//WMjMAVdaLuPTQRwDywXtFLk/?=
 =?us-ascii?Q?uI+ZbijbaVuWC7mWG3bWAL0q03BrNX+5dXsWwtT9qHfzqWG757BKzE+Jj0dE?=
 =?us-ascii?Q?FY+g6/2f2xBxgFKTyBCXrxgnPZBj/+LHt4GGp97OqonPSfx0gBMZChoWbtoA?=
 =?us-ascii?Q?7ggn8J5JV5mAVEFND7PY2lbB8FPyjM9cgmz6ykK50ZeZEzFzTVmGHxP5lFV1?=
 =?us-ascii?Q?uuDrdTw7Gf6TI4X/6PcrpHOEv2gvcYedOou8CRu9xXgvLzeNjrXg0uu1bY//?=
 =?us-ascii?Q?wOffvJpREsn99yxsKoPctol8K6RiZxZ5xWJW8xvxeCldiHNJCD5b54RUbuM6?=
 =?us-ascii?Q?OXVAS1r2Gy2NKIZG5WnAm/k2Dqn7Rvzl37uBhZOOxwdS7I73Vn0gT+laCGSt?=
 =?us-ascii?Q?9UAJ1nB9lf+nMMiRET4mBDLM+MnG4OuQV+mOCFwB1LMmeV066YP8bU8JyXBx?=
 =?us-ascii?Q?ve2gwzGOO6XsL3un5FthQQu4p0LjlhFRoK5X2YOD4/Qq0C58TP+iTlAET2v9?=
 =?us-ascii?Q?t7U5YJe8Rk5ZdjzDnRVmphuYl1X0fSdQy4kkZ7UV2zNqeKpjDGC0Uoz/0jca?=
 =?us-ascii?Q?Wsm3LBJQMbE/P3XJbYGG+krrjw+PAbnEUPVPXsiZ2mBA+SdgrBxLX0w/VoeG?=
 =?us-ascii?Q?XoQhVMcj++izkb61+98TueWadpL5RLKh/M8rxh/N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889c6479-b5a1-4707-f179-08dce87fa299
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:30:06.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT3Hm2g7vv4Xwy6W3BF164C7Gy9ThehDpAXU2SzB/vw5c/4lt1zz8rqn6Y0tHyjbY2oqxijMjkUOg2OnjxDx8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836

On Wed, Oct 09, 2024 at 05:51:07PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..1a6685bb7230 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,29 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
> +      - items:
> +          - const: pci1131,e101
> +      - items:
> +          - enum:
> +              - nxp,imx95-enetc
> +          - const: pci1131,e101

    oneOf:
      - items:
          - enum:
              - pci1957,e100
          - const: fsl,enetc
      - items:
          - const: pci1131,e101
          - enum:
              - nxp,imx95-enetc
          minItems: 1

keep consistent, pid/did as first one.

Frank

>
>    reg:
>      maxItems: 1
>
> +  clocks:
> +    items:
> +      - description: MAC transmit/receiver reference clock
> +
> +  clock-names:
> +    items:
> +      - const: enet_ref_clk
> +
>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> --
> 2.34.1
>

