Return-Path: <linux-pci+bounces-28039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83948ABCB17
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826721B65544
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85B1F12FC;
	Mon, 19 May 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZuXMDtz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3221CC57;
	Mon, 19 May 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694696; cv=fail; b=iXWeKCar9o+el6WZDywX8+yTPTpk9Kflb93MLxO++YYX8lwPyVlk1R0soHQpf0cQ+h+/6BiZJro0cHtpMum7KIqjr8NyhnOLJeClexR61rMisKM/W5tXTGhq34dRfBcUzzhnghJLFXp3rLiVYa6R7E52oUjss/a/zx10CF1/IRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694696; c=relaxed/simple;
	bh=Ih1iRgfkmcUYhE2oigAkBQjpETJhVbtnYH6hP95luXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C97bG1N543CFfl2KrYKaoMBd7jkgKioVfpkV0IapW+ZrNKCYaEET1tr/BaQ1TN0t/ZclrmZTyvzsyjifx8/RPnUWVO5HdYYbf/U4PNTLFaun7tmOqODFhcrnvSULAp3raAobpr2oPgbRxR+60lpyUKQy5A4iHyMIoYMBFBWKVgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZuXMDtz; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or15bGbf6ZGGI3JhlPvpmgLxBVuaS26Ty2I9UEom+f2dRuCMvCErbSKIUM6SEMhpAJBG/XxKfdgQnwzFFWVwIx6IMY8BBud2lYNTCsRgNlkVYWQBE94DTCXJkADDKDmiFIgL/AqEIAxPIef7ZGGWaN4iILhhatj7tGwx3SXuzggKQrqaa8juOtmck01Rj3L6CP7ZnV5Syv/n4XAp70F+V+mfhkv5Sh/9/E2pKhNl+cZlHLc5e+uQbkX6edrpP2RHUVbOCHH93x2OjYssgAdGqgs8T+ZC723oRXBkezbYzc7RlmnnVhQmhKTy+ESrM6EonWbIJUWYnFdlSufxyOc03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUWSmnr1aQP7FbTpLRpdR6suiLIOpXC1UkVLok9p3iE=;
 b=E8OJqTYg94WCfUpuUBxDnfaPmcMqoAgyVPYUyFEVtJoKAKvQesDzTPMjxtFs02SFlx5mxOvGcEC1KvCRy3O/5AT/Rm/ZeCCsv6Uvm/Nekl6r0EvbDJR/0E6akfESWl+JEz0Sw28D6OLsR3m2+ziYd5DKy6DqvYIJu8hQOJ9Gt+smK2BrHSvBZxJ8tz2YltZi4ZJpEn/5h3j3KT+ymcOS3SnTMz3KCNpsttEnPztY8qxxcfHodg/ZJxgwTz7KAP8oosP6/1V2jzq5bl+N+lF1wMJ//fumgLuiELUAIwNzqpNCjG784UPUcvFnw9yjHFaDMPOhakJd2ZZIRAWtAIhvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUWSmnr1aQP7FbTpLRpdR6suiLIOpXC1UkVLok9p3iE=;
 b=EZuXMDtzunr3qh+1BER4Y5BQxjJ8vFXFXWBNLeJ+6fcaCvdlC+6+LsAziAbOi4ecsLrd2qjLcEezKkMyd/243ux6QOPlJb8/o7kM5c1wYkPT9D2fWrgIUiPkNdecduVVPI/Blkl15uMaHqa7BJ6uSUGWkx888UCgBZDsXoAfuGu4sO/tVZAjyEK3KheSY7fHc2WdzCFJCEIKnov6QhE0BIrmRq5V0RQi2ustFuknkpGcNtHhmugi8m7MPlNLZ22jT654GgWZs2IidcP/5xy2WpKtDYDDSY6ghLB2H0wQwuqRydcfi/6vUVPzGOkoHHypSQJ/A8y+Cr3443mQXTCeZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10074.eurprd04.prod.outlook.com (2603:10a6:800:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 22:44:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 22:44:49 +0000
Date: Mon, 19 May 2025 18:44:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] NTB: epf: Allow arbitrary BAR mapping
Message-ID: <aCu0Wem4KkaybW4f@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com>
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10074:EE_
X-MS-Office365-Filtering-Correlation-Id: 51043432-1f48-4441-0673-08dd9726c2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qG7YLJjt+i+5tJt6Zk1MnT4Za8Y8yV4w4Tq260GLsJ1O60E7LOlrgmt1V7Ik?=
 =?us-ascii?Q?+LTov4X2wjEheQBDWS5RWg/i4qRMcHKJSjptbWXaVoYqaZZ0ao3oPN0IRYqk?=
 =?us-ascii?Q?9XxyJ4eR0wAPTGjN6gb9Znfu/MZB6zSR4kf31tFwL4NrDjOZIAOLTS/eX19v?=
 =?us-ascii?Q?xugAjO5WrJ99t4lIstnv8+HDypyiIRhaBOz8c5zFann+wX7edTKvl0j2GxtD?=
 =?us-ascii?Q?kpHtToEWO7AQhn7kgWrXfd9PbG2I0pVQ6PaLsLXobVd4ZkgHX6oEY3/LulLg?=
 =?us-ascii?Q?qxk7VypwOw0lt6EBDUkAN07P0HMzfX+2PQZSGTjPryBQZ+xI5XHoTmWZcrex?=
 =?us-ascii?Q?2UqMFTIQZe2zwZlN96Y0d9yYt8ATQQCooWFWSmo3aY8UxBcpPbqJYa8KRq74?=
 =?us-ascii?Q?zKeQHUKzaypipAyb1BJxAoqFjYZ2EHV3UsdV/cJUvTUu3SGczPe+xSgwtoKe?=
 =?us-ascii?Q?K7d1gskukJFBF3c7HGSDpdqJp/Al6j7oZ1r1xH3wXJN27XV8Wr7axLLItGdr?=
 =?us-ascii?Q?dwHVEq2u0P9Gy3wv+z2B6juOaGt11Gw+a0b9dmnBLXCQ+DNoLA7+XSW20JKy?=
 =?us-ascii?Q?ArnkVo5ucMKyyYUJBsYdBcefcUB+SzRNOx/d26J1yyyPO+e3rQQLfXU0rnqd?=
 =?us-ascii?Q?/XWF4E3fAkQLpgY9sQasgdgCYTFmz0wRoxgIlUC2hrGNGsqWyYaEASZX1Qri?=
 =?us-ascii?Q?X6Ewlcn8DpDzTj6SDuUKmWPyqIXJ0693BrMXTy4o9X/gjZsJlqTj9FiHNBpG?=
 =?us-ascii?Q?QE9rVcAnUdnpjobNrgSbA+bCZkd4YfyuMpObF5DXm39sVt7vg82gBy/fGzN9?=
 =?us-ascii?Q?3zhzx/4zNnfHcyH7GXfhRQM8tuOECjtXG9Yb+1+mL0WQ4riFOM5uE0Exmsbb?=
 =?us-ascii?Q?oIzC3LoXE8Gj+biTDdv3+DiWF/YSe2w/PncDZBOwz+FqVAqX+5fq3A09CzHf?=
 =?us-ascii?Q?GHbHK/+eeMSwwY6JFVqv26etRKPu4RBF/1EDZlNcNgcpAc9tbuTrCYTddreo?=
 =?us-ascii?Q?kaCXqe/Ol3bvGnpNYOrbpPoHRda8JjZ2fsPU3enxxJo0UYf2cdaqR/NIBmVH?=
 =?us-ascii?Q?mAx3+fleoK6MQ9W+MKge1hxxVuKakK5y7+RM4wgHJRSy8THvWJbpXmMp30LX?=
 =?us-ascii?Q?xtCvcI0pwkLR+P8icm6Tl9iokfJfkL078utBqX2M0SiB0dy6PeF3/ZIz6Owt?=
 =?us-ascii?Q?2yN3KrkgD2WD7SV9S6hNFeX66mTbxOvyFXnXFa72awOycC7z8HzSRVCTb4UJ?=
 =?us-ascii?Q?maiHZgv86Bsz64xcAvnhvw0EI/cTeXXrPyruXNlmX6UM0VdhKK2SZfD13+MG?=
 =?us-ascii?Q?FTCAGsm/DILpf9+DokYoJUmFNEnvZYIPnJbJQ8X3pFhhrA+frh1XDyeejo2h?=
 =?us-ascii?Q?itoVhu82P5gKkikVlvFus//jV7Qj7R1OLAUevygPplosJGw+qu8+Q1etUEu4?=
 =?us-ascii?Q?VD57z44yz5Ku9s13EEoZQnpftgBO3Az/VPu2l3pC+lb1Kin+BPN8hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wutt8N57cwre8xmU8IA/3JsefcTMiWIeFTIGOLC6bhAovvffisBLquF5eZgE?=
 =?us-ascii?Q?laAT+Eb1I+HMTV7NM84lzMExmoJcNQsLBdeGSwOZBQVxWIQOHWPavn4Iba7e?=
 =?us-ascii?Q?jHi3Qpdjn7GesT+Gf0EvgciZ97TRDApPv7ChgbcRMdR7QEPArwpM1iJk016s?=
 =?us-ascii?Q?mXd+H6RmwwYwamvc3C6w+kQapoyw+FTMLPW9ucKp1W3XHPoEe+nCzpoax7VF?=
 =?us-ascii?Q?rtD1xhNptf9KJ9Os29rltwpwQ2tKAcQkFfVL1jjmRhZxmdA0yXAJnE8K0tSu?=
 =?us-ascii?Q?tbaJbN7bejykAK7zqcI+q0ZvRPZvLsHDurFeqQ6wUF4+pPl9cTiPtfrICFFb?=
 =?us-ascii?Q?g6j1MGRj1i3TOnK9OHO54mVk342NE/r+89cFxTzLlFR09duJ6AUMjckdMkLe?=
 =?us-ascii?Q?4lp5uFKvHN+zfkNPjL8ZSOxcYelzkuh2zZpEmeJ2ykftSYNMt+NARKIgTHvt?=
 =?us-ascii?Q?S0ARUuCWmUqsGDstKHQS6cLce7/lllr7RoRKCwBqRNVzzBKG5WxLGlWRob4x?=
 =?us-ascii?Q?uHMqUFWGwdN6AXs2HjBUt4c+G8ck+QtNwqF4LH3zBm5NNh4LiBInoaQH4glo?=
 =?us-ascii?Q?T8Ss2CWWL/kVHXO49TxNz+W0/PpmTsetOyD908O0ofvlJ1bhpGHoXDaqfS4K?=
 =?us-ascii?Q?B47jVl/e6ad7szJK6S3LXbJkvSvg9Hg6QfqRVRXS+SKU7k6ZUggHrlkm+Dnb?=
 =?us-ascii?Q?aE0VbpCkE4SVVfobqznq3eG+/8sJuLOQMqGu13x0z8BKFRi2qy/gbPBpgPiP?=
 =?us-ascii?Q?mjMBCW5j4SrZ4HG9FADUMLDmc4clHT9H97lKezs3YGvBTDQSJAXJXLJIU28M?=
 =?us-ascii?Q?MAN7CA9ACTsh+I6L7LFwWhm7Bp8gCsQsD6YL7Iioo5FwNMJmVD+enTXgAT8z?=
 =?us-ascii?Q?LmrEMUo8ltTBOZpk6OYVbUlYcpDWl/OkC+Y1qpNaSneu2HtcxHYmWjFxYCWb?=
 =?us-ascii?Q?8dHrRqg4xr4aDlP9ladYK3Njd3v9bld8SW+NqCLUiiLkFK6+eodoztBGSGpb?=
 =?us-ascii?Q?GZw2+coxOUakmPJaDQyG9uSxq1k/JJZxy/N/vBdxS6hGk66j9IAbewkBGYZO?=
 =?us-ascii?Q?/XkAB0P2tHvBFlvz9ZnnaU9OG6YRYxywx58CbzJPRA+Kj3BY5XQ4GC0YxbnU?=
 =?us-ascii?Q?YJyfdae8Qeu0XoiWAcI0ntaNfU/Hg3sd6OGmueUFJSI4z0ORBxdE0MIfLirU?=
 =?us-ascii?Q?yJn6C1p+bX7jOFCKpCKZjylNzMr7qlwFp/CT36kAFpbqvs7/Rn1i1N9we1B6?=
 =?us-ascii?Q?jE4X6baulqjEPIm7aUs6FEcyFrxpfgAssr/cJsWfb8uuV0oQf+C4L/TxZK9B?=
 =?us-ascii?Q?ov0457Ilq6FJJk0UrcAMbSG4e4xJWzsxVSzf9dLr1MPwVitbrRJFCfFFD4mS?=
 =?us-ascii?Q?YfQmE2S5epvvWL2IpX9h1/I3/XwwgPtv/PfQ3wgwrtogMu6yAWWlkT7W6KYl?=
 =?us-ascii?Q?Ao6/FV7hKA3/bJVbBVTsvVyyHBN2eVfBuLXrK1husTqSxYxKWwNrYT+3v3g6?=
 =?us-ascii?Q?4hmqgMfq4q62T0qx1BcZHsS7CNeXUz7kwqlxA+dkxT3NBpZtz4iAd+76jHfR?=
 =?us-ascii?Q?CupCf7vQ6QWKVmerDxeL1/3CO/T2QEFHgFnPJ4gZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51043432-1f48-4441-0673-08dd9726c2b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 22:44:49.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nE7zCLBVcVuMSGgu1Q78/0TnzxzjT5OPlM44TFHiWUaBTA4yp2q17sW1nY5N0TEq8O2huH6zkCmePm3U+T4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10074

On Mon, May 05, 2025 at 07:41:50PM +0200, Jerome Brunet wrote:
> The NTB epf host driver assumes the BAR number associated with a memory
> window is just incremented from the BAR number associated with MW1. This
> seems to have been enough so far but this is not really how the endpoint
> side work and the two could easily become mis-aligned.
>
> ntb_epf_mw_to_bar() even assumes that the BAR number is the memory window
> index + 2, which means the function only returns a proper result if BAR_2
> is associated with MW1.
>
> Instead, fully describe and allow arbitrary NTB BAR mapping.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 108 ++++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..9539cdcd0f8fa4b5c5e66477672f8f97d5ec4e52 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -49,6 +49,7 @@
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>
>  enum pci_barno {
> +	NO_BAR = -1,

Not related with this patch, but there are too many place to define
enum pci_barno. it need be consolidate.

>  	BAR_0,
>  	BAR_1,
>  	BAR_2,
> @@ -57,16 +58,26 @@ enum pci_barno {
>  	BAR_5,
>  };
>
> +enum epf_ntb_bar {
> +	BAR_CONFIG,
> +	BAR_PEER_SPAD,
> +	BAR_DB,
> +	BAR_MW1,
> +	BAR_MW2,
> +	BAR_MW3,
> +	BAR_MW4,
> +	NTB_BAR_NUM,
> +};
> +
> +#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
>  	/* Mutex to protect providing commands to NTB EPF */
>  	struct mutex cmd_lock;
>
> -	enum pci_barno ctrl_reg_bar;
> -	enum pci_barno peer_spad_reg_bar;
> -	enum pci_barno db_reg_bar;
> -	enum pci_barno mw_bar;
> +	const enum pci_barno *barno;

barno_map?

>
>  	unsigned int mw_count;
>  	unsigned int spad_count;
> @@ -85,17 +96,6 @@ struct ntb_epf_dev {
>
>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
>
> -struct ntb_epf_data {
> -	/* BAR that contains both control region and self spad region */
> -	enum pci_barno ctrl_reg_bar;
> -	/* BAR that contains peer spad region */
> -	enum pci_barno peer_spad_reg_bar;
> -	/* BAR that contains Doorbell region and Memory window '1' */
> -	enum pci_barno db_reg_bar;
> -	/* BAR that contains memory windows*/
> -	enum pci_barno mw_bar;
> -};
> -
>  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  				u32 argument)
>  {
> @@ -144,7 +144,7 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  		return -EINVAL;
>  	}
>
> -	return idx + 2;
> +	return ndev->barno[BAR_MW1 + idx];
>  }
>
>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> @@ -413,7 +413,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  		return -EINVAL;
>  	}
>
> -	bar = idx + ndev->mw_bar;
> +	bar = ntb_epf_mw_to_bar(ndev, idx);
> +	if (bar < 0)
> +		return bar;
>
>  	mw_size = pci_resource_len(ntb->pdev, bar);
>
> @@ -455,7 +457,9 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	if (idx == 0)
>  		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
>
> -	bar = idx + ndev->mw_bar;
> +	bar = ntb_epf_mw_to_bar(ndev, idx);
> +	if (bar < 0)
> +		return bar;
>
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> @@ -557,8 +561,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	}
>
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> +
> +	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> +		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> +		return -EINVAL;
> +	}
>
>  	return 0;
>  }
> @@ -596,14 +605,14 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>
> -	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
> +	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno[BAR_CONFIG], 0);
>  	if (!ndev->ctrl_reg) {
>  		ret = -EIO;
>  		goto err_pci_regions;
>  	}
>
> -	if (ndev->peer_spad_reg_bar) {
> -		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> +	if (ndev->barno[BAR_PEER_SPAD] != ndev->barno[BAR_CONFIG]) {
> +		ndev->peer_spad_reg = pci_iomap(pdev, ndev->barno[BAR_PEER_SPAD], 0);
>  		if (!ndev->peer_spad_reg) {
>  			ret = -EIO;
>  			goto err_pci_regions;
> @@ -614,7 +623,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>  	}
>
> -	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> +	ndev->db_reg = pci_iomap(pdev, ndev->barno[BAR_DB], 0);
>  	if (!ndev->db_reg) {
>  		ret = -EIO;
>  		goto err_pci_regions;
> @@ -656,15 +665,20 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  	pci_free_irq_vectors(pdev);
>  }
>
> +static const enum pci_barno ntb_epf_default_barno[NTB_BAR_NUM] = {
> +	[BAR_CONFIG]	= BAR_0,
> +	[BAR_PEER_SPAD]	= BAR_1,
> +	[BAR_DB]	= BAR_2,
> +	[BAR_MW1]	= BAR_2,
> +	[BAR_MW2]	= BAR_3,
> +	[BAR_MW3]	= BAR_4,
> +	[BAR_MW4]	= BAR_5
> +};
> +
>  static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  			     const struct pci_device_id *id)
>  {
> -	enum pci_barno peer_spad_reg_bar = BAR_1;
> -	enum pci_barno ctrl_reg_bar = BAR_0;
> -	enum pci_barno db_reg_bar = BAR_2;
> -	enum pci_barno mw_bar = BAR_2;
>  	struct device *dev = &pdev->dev;
> -	struct ntb_epf_data *data;
>  	struct ntb_epf_dev *ndev;
>  	int ret;
>
> @@ -675,18 +689,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	if (!ndev)
>  		return -ENOMEM;
>
> -	data = (struct ntb_epf_data *)id->driver_data;
> -	if (data) {
> -		peer_spad_reg_bar = data->peer_spad_reg_bar;
> -		ctrl_reg_bar = data->ctrl_reg_bar;
> -		db_reg_bar = data->db_reg_bar;
> -		mw_bar = data->mw_bar;
> -	}
> +	ndev->barno = (const enum pci_barno *)id->driver_data;
> +	if (!ndev->barno)
> +		ndev->barno = ntb_epf_default_barno;

I think needn't check it because all .driver_data already set in ntb_epf_pci_tbl

Frank
>
> -	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
> -	ndev->ctrl_reg_bar = ctrl_reg_bar;
> -	ndev->db_reg_bar = db_reg_bar;
> -	ndev->mw_bar = mw_bar;
>  	ndev->dev = dev;
>
>  	ntb_epf_init_struct(ndev, pdev);
> @@ -730,30 +736,26 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	ntb_epf_deinit_pci(ndev);
>  }
>
> -static const struct ntb_epf_data j721e_data = {
> -	.ctrl_reg_bar = BAR_0,
> -	.peer_spad_reg_bar = BAR_1,
> -	.db_reg_bar = BAR_2,
> -	.mw_bar = BAR_2,
> -};
> -
> -static const struct ntb_epf_data mx8_data = {
> -	.ctrl_reg_bar = BAR_0,
> -	.peer_spad_reg_bar = BAR_0,
> -	.db_reg_bar = BAR_2,
> -	.mw_bar = BAR_4,
> +static const enum pci_barno mx8_barno[NTB_BAR_NUM] = {
> +	[BAR_CONFIG]	= BAR_0,
> +	[BAR_PEER_SPAD]	= BAR_0,
> +	[BAR_DB]	= BAR_2,
> +	[BAR_MW1]	= BAR_4,
> +	[BAR_MW2]	= BAR_5,
> +	[BAR_MW3]	= NO_BAR,
> +	[BAR_MW4]	= NO_BAR,
>  };
>
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)&j721e_data,
> +		.driver_data = (kernel_ulong_t)ntb_epf_default_barno,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)&mx8_data,
> +		.driver_data = (kernel_ulong_t)mx8_barno,
>  	},
>  	{ },
>  };
>
> --
> 2.47.2
>

