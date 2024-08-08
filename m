Return-Path: <linux-pci+bounces-11519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401B94C757
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 01:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59D2B24A74
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AA15F3E6;
	Thu,  8 Aug 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e2sIaBLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34F1474A5;
	Thu,  8 Aug 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159490; cv=fail; b=W+zQlfiZTKj9m1hm6vgyslBn4rq4B8C4hZq5JgbEmwkChfRu5GYI19c/jKPvywcAuENCHiNHIqN+gk7RXpmCC0bk3SiPbZUX6IT/stVoACJq+3ix1I/yT3z2GpmS+ADH/QU0XqZTJ1yt/lyw9VE+XCVKCi1PWQJf7eUUV8sqegk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159490; c=relaxed/simple;
	bh=4ZDnL7rCvAVoqQDG+1OFKJijV3fvtYs8PXTfRQ2L5jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UsA3nMosRU6O5d6J+1sIdRGYfOPicddOvobnUA7SPxNkjTwosPRxB+WklB+EaQe7q+NqkqXlKGDJtB0T/MlqU1yYsTNspp0LzEbQMyLUrEumRE9e3g8Cw52Zx77O0i2nqS2MTDwoOA5XEGkuHP0+HAjWOUzqGbKE7Rd8c6K4uUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e2sIaBLR; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USmMoEtvqVxBaAe1Q6zuqxyuXQxdUSs3UadU8qsfZieTUWG2Is4Fx2BQd5VC/Xb9XL2DR9Zh0rybo+dFibAbMDoGbOob23K3Jl8KgOVdlF3g3V0Fs7zCHXCPKYfKfkeUEABX2uZA38IbmbibgpO11GObRhNeLVfRgmLGj/pYfvLzSjwiB2xPiQ0QomXwnwM4oro+0kIdjBSg/GeulGtF5TKwEOTf4OB7sRgIPMcFtcPWZwvjQoKjJ1fC1A8LhlSPAoXiBAoANcdTN6lV2uwqK/yUEdO7WkYPQubGXSF/jjRpBVfhNlz5nSqDFqvJ5wV0vnyncCtiHc/pfJQsM10o+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/jC4KcRDatWcpwkEjUfcRQzaY6mSKLrXDY9NUof+po=;
 b=aY9m2n84XuKQsMWjDVvdRa+e/TQFtT1aTFNvsgxuSp0ZS/4ipuODwvEahvmuLb+LCsXjNJCWfIXe8fygjdbDuvgZDVxQzMA72ep4b0LW4yuoTAO0tjyIRWRTEIjECCtu24Eo338xE2mSHBLo2gB9ARha5dD9SMBaOV/PEJAk6NrdWkMxKKLbDP0j0CwByjo11s8Soifk0jx6ruUFT8fi8hArx31pbGQf+fY7Xvgy3QgP758SrFNaFTSb2W+QVRDDeiMhIvyjHFRvCaViaaMmW/XQ4hiKapFnD8A3q3IBCAdTJ9/nmOgsXvVhr4yS1+JriwINAHQVMATka40ASG+esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/jC4KcRDatWcpwkEjUfcRQzaY6mSKLrXDY9NUof+po=;
 b=e2sIaBLRmc/Zr8KwhxItzQiHYGe0EL3C4oh5yMeG7H4R60WenudVJbjlYeU+s+Uruwe1NS+EbqceTD7wyANfGoWEejEZY8kHlI/F2fKPS4kqIknTMSzKWn9OPSXoY2uwI8xJUUvpI7CV3EMtFmA39IqKL1KeGKdVglooxSS6tKZXh2SXAK5m7lVvdC1WUv801SGK1m0vxhpIzhWEwQlOD0vtbvXLZYuacFLW52nG1Ei1Dx4pismUCJLemIfSFpD9koNOzBSpK/sP65MFZb3sq/bJsm1a+tOcawwcrT/44VRznOec0CiX+S6HVI0k47Xm3RRWhI+DiaXIxkv3nUFy0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 23:24:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 23:24:45 +0000
Date: Thu, 8 Aug 2024 19:24:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: host-generic-pci: Drop minItems
 and maxItems of ranges
Message-ID: <ZrVTtu0xtn5NdO4R@lizhi-Precision-Tower-5810>
References: <20240704164019.611454-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704164019.611454-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: e980dd3c-02a8-43b6-7033-08dcb801497e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ag5hNNPpGvhSGHS4uvpw2t+O2O1awUSoyHbsd1j+dZwkxDFcff0D/WvIXg6d?=
 =?us-ascii?Q?5s4tznmGhaMK9HMnssd/Qs8XHp82jxRS7WTZX53Xzvvj0Uw2Vtuh3RETUYWr?=
 =?us-ascii?Q?zcGqOYvobSV2rxJD5ZchWmt1piDBspZH+f63ljG0RMSFxeNDGOIvSgvYr3dz?=
 =?us-ascii?Q?DoAnXjcxROSESrUTfPCnOUpjXsa36fzQZFuF4TCYHJjIt9CXAXJZYifJseOr?=
 =?us-ascii?Q?9WJgAApH2d3qwxQBcTk9VH5Lf4mzmsKZjlIOG+ZUvdVQ+dc6p3OkjrViNwLe?=
 =?us-ascii?Q?K7a33gIZe5sW3Np3FBtDnlkM9naCkPzhk57Dm5IZBrUQdHEizOH6so54dJOK?=
 =?us-ascii?Q?RqgiI8MYVr0d86JcLlSRQHJ1CsC4I0EWOPWnR2VNfo7oOJam4m2MpDG7rC+K?=
 =?us-ascii?Q?Du1bDQ7ye+GRcCrgeRRN3VIH0Fo2shGwH9XO1JE6p1mi7IicJjACzvqHejHO?=
 =?us-ascii?Q?YjIyI7UZ6hKlTWTuzI0x0YgGyN+RqJTiVIXewy25+O0CRK70+kwA4FLnGMTL?=
 =?us-ascii?Q?P6QQqUGU6ngNqSkNu5lH5VVjheIns4uSX+JQ9lMg/vdkB0MO90i+HdeSAjAa?=
 =?us-ascii?Q?6HT5ZLONQrZa90rVW8Eu9annQv5rqLIVdGiFtwWgpl4gknIQY1cOo8VBZvyV?=
 =?us-ascii?Q?3tG6PpG2B6EfX8WxtK+ftuHITCF2gTw83s+qPU9OM84YLDAn81SA7YKquDQO?=
 =?us-ascii?Q?TvT1Z3qFZ5kqT4fKVci/hPpDhtBnce66apLrWvxlL+VwYdg7GwExmW+BuWad?=
 =?us-ascii?Q?W5aFwSzKNw/7gbrak/8k8+1oDaaaqhy6GePnluDmanvn9uPG7ukT14Oh1oOb?=
 =?us-ascii?Q?rMXkhayXlixRz/QMal6+3KYIJaNWpPL2+/DJNCUS/t9uoZ6VOX4gy7USFuCv?=
 =?us-ascii?Q?3XgwCoIo1qSllQrZQ3iqxD3pQMUVh4SUHCIDuYzmmxedpl/lnU+XwQyF78Mp?=
 =?us-ascii?Q?rIzs7v/7PHoUATJGRgV3JtFA7GDHiFjkZrP1gBmeP6u9zYXC+OpTXHhPTxYO?=
 =?us-ascii?Q?RCva6R5uAfMWNsy55ikQ4b1AN3KrL0B6xnkz4poOlZlchCFF3o5Ij9Bwqc5z?=
 =?us-ascii?Q?ASwH0dloUSch1qw/4acfPBg+HuRjdVIpg0tayAPePrLldZcFjbNsHg00+r+w?=
 =?us-ascii?Q?ocQaJS4fb6l0nseT8C8j4qmoaEEE4lMQY7hNuh6gLcNm+epMKlhz3toMyaAx?=
 =?us-ascii?Q?c1HPEPfQbk7PdiByQ93IViQKLeVfbWiO0jPDC6dfcTei//owQP7wCfYmtVWj?=
 =?us-ascii?Q?3Mnx5Tg8eZoE7qkDD7Gl7ayDhS8ufTWibwDo014tViGU6pH0MfiT8MUPt7si?=
 =?us-ascii?Q?d3v7ZoQ+MI7B+zOniwUIt0tqkgqMiXajj1LY9Hlq72tlqOu6e3+qTLy+KlTu?=
 =?us-ascii?Q?f6ZKh2eQck1N2QOggoDNJcSzD2oLq2RAu8XUVeQAMGJDwmu0eH50IWCj8gcQ?=
 =?us-ascii?Q?a1D6mThuH3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y150XHLRqj07YZ8BYvPsEtxWI6kK/C/xoVEkFa/1XRvwh+Bn4ECNdL3ikc8b?=
 =?us-ascii?Q?bnSBmEqCmvYiX8iUwuMdihOdZCkht8+Ijdrl9HnAe0YF9n36f9HnqXSoIJZR?=
 =?us-ascii?Q?vEI6WifteNjOBkGRbb/9U7ISrZu2fuVG2aWUK6gehLxY9wjTQtIxd5+d0Kkm?=
 =?us-ascii?Q?6PAuNUTjjUzrRimYgLfHQlcsfwnV+GaM0Hf7qTaJ7NHfM4Ot8gQSYmaxyZI7?=
 =?us-ascii?Q?+PEw1Rw9KQBoHCq+1Aq3Zq2JjT3VTSnAOKro1ri/ZwfAnnYUASCqgT/ylL9s?=
 =?us-ascii?Q?f4wf4qJeAK1HqUaGibWcr2OQbFaO2TeA49nZJEAMi+aBmWUSHBu5cPNj7K1V?=
 =?us-ascii?Q?DhbAcsBi0uX14EWrO1xXIQiKFnhXpFjKyjGeg88x9sRu4bEN78JwKL2O+d67?=
 =?us-ascii?Q?u6gTbYJPorFMRV/MFW4lTMSXccyIiYlgm+J3csEMwXp6NdPp+zbRx7VJWupH?=
 =?us-ascii?Q?MisGTtWfceoFVuzCB+VqSl39vkDipOJJKBKiUvghPsTRSM6qArreRgLxs/Re?=
 =?us-ascii?Q?VNBjGCm2GnOHbnlYpRECiuUodh+6PG6v4LSadcs624WNo2jjoQOMkKYUmfPq?=
 =?us-ascii?Q?ZfsTXP8z5HyLZZIqbGxLcVjmrby2hW2VkSaAyDu2vLjiii5SN2e6kIWD0y0k?=
 =?us-ascii?Q?3hvHy78RGd47YV1+TblQKIjLb+ncRq9spX+9iurHB+vVLAVZf5SUnQ5V4s54?=
 =?us-ascii?Q?IorqVXvRhsimbhle772fvfWcRHz3hbrDypFUQW46uCiCliC3th+nvoFtoq/k?=
 =?us-ascii?Q?BndrFNGSJicQWeQNeOLhxTFaVWUi+LNFvDW4n1xWMqJiHojZG1XVRTTppQM9?=
 =?us-ascii?Q?+MpZWVrdoeDsoXCAeYLMgyJFwj7Qu16DVZI7l2SMxhpIeTsBH47pli1m/vQB?=
 =?us-ascii?Q?SXAr6VAfcNRD3zESrP50D3amu2dpzo8qe8Iac4bP+awSjG6YWgAilBNtq7ay?=
 =?us-ascii?Q?xrwk5fZhfc16/BEBSsAxnOzUUuPuKwVlWDWo3uzu02yGqy/+jHte62GRcTNb?=
 =?us-ascii?Q?+xSpePowCIpAeT+V5lEb3dNtx78duJCqI8CdhwDKVYq4rra6g2Hj5egzl95a?=
 =?us-ascii?Q?OaWG08S4UYLPH9ROhI507QsEgI9cELv5Javwd0/7Mv6VMJ0FJFqH2FLuPji9?=
 =?us-ascii?Q?ospQDXBLNwsGl1spIj6oIVkJ62U8SsUrleN9mTKcYfEEVOrMtXy7YBwO7Pz9?=
 =?us-ascii?Q?mRjfGuaA6wCJIi4ahZe9ufjSZMe6EN4I9KYgTvgwZnZDDsSKTuBQVMyV5Dmv?=
 =?us-ascii?Q?e6riMK+3xnYClGP/rupyYaQiwIjdYd390zTkWQ3tELf5LO7WUxk0V/LiCbst?=
 =?us-ascii?Q?DZEMsaWETblMKljws6iIZDC5pwXOx+stINiQqsaFu82WArASYI5XrNo0hzzj?=
 =?us-ascii?Q?fQvr0gytR/bn0FxTFH9TaHrm82UEhwvRDS+Sm12wtaSkC7SBdsTFjDKM7GaD?=
 =?us-ascii?Q?k7zG/+4gG25CJU85NAiL47zJmuQlWwG4GhujcmHpwNJsr3fH6ue0QVHDgz5o?=
 =?us-ascii?Q?WHIMtcYAcyDW0zPNYHdu5pg+U30bPBRdIv+zN1Eu4RJwjyBeeVme6IP9Xcbv?=
 =?us-ascii?Q?GMlrT4wUTmfW5SSkKvU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e980dd3c-02a8-43b6-7033-08dcb801497e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 23:24:44.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYFjRJ65MOsmihT1iO5eu9HvKO8jfI48j6UaoswnMA6Ll7JI8dBjjLx4b4zon6q1YXQN1mymaWIA+0hhbdGYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008

On Thu, Jul 04, 2024 at 12:40:19PM -0400, Frank Li wrote:
> The ranges description states that "at least one non-prefetchable memory
> and one or both of prefetchable memory and IO space may also be provided."
>
> However, it should not limit the maximum number of ranges to 3.
>
> Freescale LS1028 and iMX95 use more than 3 ranges because the space splits
> some discontinuous prefetchable and non-prefetchable segments.
>
> Drop minItems and maxItems. The number of entries will be limited to 32
> in pci-bus-common.yaml in dtschema, which should be sufficient.
>
> Fix the below CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Bjorn:

    Rob already Acked this.
    Could you please take care this one?

Frank

> ---
> Change from v1 to v2
> - Rework commit message
> - drop minItems and maxItems according to Rob's comments.
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 3484e0b4b412e..3be1fff411f8d 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -102,8 +102,6 @@ properties:
>        As described in IEEE Std 1275-1994, but must provide at least a
>        definition of non-prefetchable memory. One or both of prefetchable Memory
>        and IO Space may also be provided.
> -    minItems: 1
> -    maxItems: 3
>
>    dma-coherent: true
>    iommu-map: true
> --
> 2.34.1
>

