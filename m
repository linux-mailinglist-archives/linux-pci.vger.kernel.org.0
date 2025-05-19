Return-Path: <linux-pci+bounces-28014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385DBABC8FF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75874A1A8B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319FF212B3B;
	Mon, 19 May 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTLoXdUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFF1DE2CE;
	Mon, 19 May 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689674; cv=fail; b=PBDMjNPLmO5pTKSlbTUFMm+UyNOY88O4ejndhPqOTRI2zgZfRdF6SXV3X3xu9xFdlzo1bPSEY1ck7aohi/h7/SwDmEH7Rgbs7ax6QU8XkmiJC5p+gJ0oXf0ERrVn3jM0SuM8pdQh8a3wiRCwyP0y7kV0N+dCbBcL1OCj+Sqy97Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689674; c=relaxed/simple;
	bh=PurqpqAHc36IsBPtGkq2JZ2Thh4gdI8ueIJbA2LA7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPtsq8zptgxQNpgacLNYOZmnlpylHnKGrjN95replc0czJN2mTDq8bOdXtVop8ZVUKYg5Hokfopa1KkLGGvyUy7qGOWe1RdRC7Jqz2sA3sIlOjwHR+u92WYv/tivxdfKrwjLBAhHBBq3tAeMaeyMVOnHINkjbXj2UV7sYRd3M4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZTLoXdUm; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLhdt1VGYj/TWVhnuDw9bMFFUdeGLtbmq71BESpjMSMu9ADiTOTLGAH25FKjxaAvFMintuo3mE5supZxRUel01nOoOIz0hD2mDm6qwiJciAw9o8efaWCGjwXghguz5ao3BVIRP9CW4sADZJE6P8pWAPaJYSa0ZwmpA9izAaVW3bVrGMo7KNHFY5V8YBTVBVigG+HP6w4lnSpxvMg19lmmHGiaLb7m+bl2O+dqnpfoX0fsOizh+jMsKW6nHzVWdoAto8UbHtDH/UsKk54XV0AL82I2Wx2JnY0B/+lRu+DZY4oWG+7qVpslJSCH2b3KL+yU/Ni0N1/9lFWzp818Zxz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDwraccmmPbvPddpXbAnoOFKaTup+05F1rqTPQ7zN24=;
 b=JHlcohcKU0T8K2y/feG1/XuuL4fN1lZV9+OwAshF1jiCoqGrER/KP6cIhl6fac2RTnbstIg2/+DmpKCN1QnTHEWjMGBy/iGUf+7H40MRktVyZjPdXsPf4Lh1WUwxSKmaFkw4sbAdgF9KHXQw4cHtY1pqNGN6jelbCFpqSpW6o5lEBAnPZGNIkI5wUQdJi7uN1ZXloPyzYFBUU6RYe6ISlOd9SYDjBhNdXndmiebR43hUJ0bvY9ICuumZQb3G25seJmXUM2W0Cv5M7KdmB33QXq7Pykask33f+6yVE6q1830EcggCYefJhQppy2N566GbJsoIbvLaWwLX+/D26OKsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDwraccmmPbvPddpXbAnoOFKaTup+05F1rqTPQ7zN24=;
 b=ZTLoXdUmYiAXbGlgbL/OzGyWF2XrH8+qXc3feD4M9xLoGo8oaT2td3gUDJPOspSupRnhmG8GMGXrzerEHWKy8LioB1TVP+umYbp8bbcUM5YOJ+3ibGB4H8wYuVCafqknYQScv6fmhzox52Be9gRXZDOYUGcgt6yYi8pXKb3Jpc/uoC9KM4LpLIltdT+acS5L+LmydwBGa9YYicIhJWUDBBcP1OwtAWmSvuJZBm52Z3ehiU04KIZEGKLu3hbuJ3OtaIJ9KXFvv2SVjxi1JIuMYayQPokMxZXO2NIHKcj+7mtokL8z6NN2vwZkNfM9+aCGWIr/vwol6BmxThSwofmGcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 21:21:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 21:21:08 +0000
Date: Mon, 19 May 2025 17:21:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: endpoint: pci-epf-vntb: align mw naming with
 config names
Message-ID: <aCugvDoKTflV9+P0@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: bc72e382-e638-4b01-887d-08dd971b11db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsXEAszDKb4BKmgkVZ7dKrpu+ukwQlh6/89z0wSP1Ou+r3f0WcX7Adea0aXv?=
 =?us-ascii?Q?rIIxOI+1whISfz9cL3iwEp2EF/A6ZSuzfn5QYXVd6dda2UTFBbS6dIx+o1XO?=
 =?us-ascii?Q?karJ3XrbnZKRhzLPcC2g8pR1QTkJGXzWjEkKSAbVUFDGS32KGBHP7Y6gS68y?=
 =?us-ascii?Q?PYox7nFaIJ1jP+zo4SBJWCoNFHML1uJxKcdLo/+9F37WqTcghTWXoV/2KM/r?=
 =?us-ascii?Q?egsegT1syrxnePrlBYCwhN8jaN3HI+9RakbioZIoQ2FnqTCys1gHYj0W7Bfe?=
 =?us-ascii?Q?af7pqka2FW36CXO4A5tWYHX0l+hnvqZODkF+sGeRF2smDXK+IUwtj4pxWlOm?=
 =?us-ascii?Q?7k0jeoFXQfrHOEV5FtjcCFijQGrUqiXWbRgxNPA/iBWdqJNbE2JrNtrROIiS?=
 =?us-ascii?Q?qOHimOUM+30SV2amcK5T+0EMo/35ANpVw9G9DXbtxbV6jUOJY9tNGDfqYg+R?=
 =?us-ascii?Q?QNuvEPbSXA5YHo361EItmN5zChuHOspVQsRbnYayIakTzS5ILqwuKQfMreiK?=
 =?us-ascii?Q?I2MI5HXg8YAFij5AEjctgLZ8aTUY3Gl6xFdQgKxqQV3rLPk0QuKIMLuF1x9P?=
 =?us-ascii?Q?IcmESFU0SLF1ZN4FrNl5wqNHvzvRTy+Lc9Y2Yp7bQebZNnIJ83nUQELrBrLh?=
 =?us-ascii?Q?EUUNAiTO0Ejyco+SCJGkeWSvNzpsNUIywCMqLRdM262fMDemDKKngBOr11X0?=
 =?us-ascii?Q?loy322bz/t4ByY+NsvOfJ7mqFLx119EQbbI+HvaX3FDA7QoC1fT3cI7hLoIk?=
 =?us-ascii?Q?E6u33e6wzjErqMvesf4a0PlTWn435b0VC2bT0j03VJjGgzzg76DFfCk77Q/f?=
 =?us-ascii?Q?VCiCD4Ng6yDC0yt5Xy4aF7wrRhJwqtVhCPFNPkWMDvFLMAKq1Jw8hmBWJedb?=
 =?us-ascii?Q?tyi93P9fyjkMNzM9fYY16ZbXXTnEDBlWS550/zS7FKVeusSLIUtIKImaTZqV?=
 =?us-ascii?Q?jauM9ljm7C4iZNs1wMgjuMrAQ2rmJR6P7B7VeeCzGSDF7IetpIzGrvCn5NX/?=
 =?us-ascii?Q?T+KWfUvLLhJdZxvSfzRhb0vXrJJxDNbqrJLKZC0QbvCKoz69clyWneXP8jSW?=
 =?us-ascii?Q?UtizGF3PkKP++3XB59AtDXgkt3RkrpSrRCXdLordvsWDKsHSDcPcWaMQvHhE?=
 =?us-ascii?Q?k7i3KGa7Lo79rXVyxEk9c4TUq97BsYZsVED1T+WK58HfOaBxOhBBbakza+GG?=
 =?us-ascii?Q?JEY156blNkkWMGy40opO/ezRox6gQZ3OrbwX5L7AANso8w/n7naqAVLrx5E+?=
 =?us-ascii?Q?TKouei6sym2ia4UxA+AoFpIqvHs37N685xHg43jUYclj3E3fRfAGGnE+/Ycn?=
 =?us-ascii?Q?ifmjzOl+I1g1ODBzX4xKx64Zn0vUdnJAJDO1HTdCctlgkDluEaBiacYNMwJk?=
 =?us-ascii?Q?4GVClfcfMpC7a0gjhPUrN5aGmy6TTJZRV7wfKmh+VbWKYkyW6dPvzfiVwl61?=
 =?us-ascii?Q?se/5s2VlzsdI4T9m9lTQ0H+L1NV0K/e51whi8ZsdZnLSvlowHD6BTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YtQoXkGIibAfWBpR/0ZFoaNvardW7L8qCjaitw8T69M/fZVZhXXWOKKcaqhc?=
 =?us-ascii?Q?aou+ZR8kmq4zhLcx42oKhMcmOY3Kkv38EDpmudFZWKIBHs2kLT4SAYKgC9P1?=
 =?us-ascii?Q?4dgupkywUdx4JPS2o+ioiGVXPkotaNfQzONkXQDRlR0AFXS1/xK6gRpI/0zG?=
 =?us-ascii?Q?sHxWAi+7sQdei6o87Ke5Ipzfma9ES7qf+/oKvS+WzwHLUc8rsU+fgBn409hr?=
 =?us-ascii?Q?nzpJsVgvgZWkd1kXwSnTjCRWZMSxRSj11ThOvfE5IZRymYFmRGMFqj6hgULU?=
 =?us-ascii?Q?WYjiEppF9iLrr4ihAajYLxp8d3hhzz/Nz23heCpyxzSdaijqHtNZnlpEl6Ni?=
 =?us-ascii?Q?BXCC0I4G0yIoSnEooJoq9jz6HjLZ2lXle8PuwMegNcjxYcoZlr2OrJwBh8az?=
 =?us-ascii?Q?BDLREf/Joe7f3LbUV+MKmkXWm0Y2dzwTtoukoNnb5OJbNUiYLtIZgzmKvohj?=
 =?us-ascii?Q?edArgVfv8Tlt30IxFaMPlv5sJjB+5c84Jffk9+vwTrWzTmrfzIyxYgb9dNPo?=
 =?us-ascii?Q?vGJ1XXbqnLG4UMduD7TIokw3w7aNrtEP1hEut44GkWzlBZF6DNmMAxQmp68C?=
 =?us-ascii?Q?vHjpdUlGOEbBlcAEkG3Ho7QqbR3qkE3P6M8qZLep/NMK32fJcZC0YPt0Dh8k?=
 =?us-ascii?Q?RBFpc0sZZt8O9fGAqfFRDrrbZVFd3gs8nsHWMqknxDpeHObJCg+fMiTOhw8a?=
 =?us-ascii?Q?kFGceTVuBzGb9BmVnB7tT5hGzemX0h7Ja4MaRqalWy4/Y/pjy9rHbnL1Dojo?=
 =?us-ascii?Q?azMZFmWbvXxk/ER75II/R22OP3NfyzIj6rAAyI0SSkSPmFYzdFbVfUnKobUn?=
 =?us-ascii?Q?eHSNtI8f3r6/EAak0lpPe6Aatd0wzIkDxcZnqScAEg0oHYSm9p+Q3CqRgdUv?=
 =?us-ascii?Q?jp7E1uauz8H2k9HOtcw9MDSybDaFLcCMljZlMrp8OE+0MepS32ED7koez6um?=
 =?us-ascii?Q?zqxdpaedFmkxqekd5m6Rl9NeWErNzqrtou7o7GauQzekt2mR9yzTVwJygJpz?=
 =?us-ascii?Q?n4I+WKHMRZvJbJNwctSL5cpFVbU8x+0mx+vAI5d2mfVjQos/w8urlALG9RVd?=
 =?us-ascii?Q?TllGztfcobSkL9oSFZ+Zzh0mHLFNmGiekx8phIiOjhJRN4jh8skCHwvaKESo?=
 =?us-ascii?Q?JJ6E3Y3NwO6Fo0PXlmY3KuiR6oT4rS5ImwCwNqNlJqQ2lRYUdRpTa84AyTMa?=
 =?us-ascii?Q?GPU7QXlI3BSK+lyv4P3Uhh5G/oJo/nnWU8mBERcv6el0ZpQJirpuue8IEBNG?=
 =?us-ascii?Q?gvzpjqdbVnKus9W2EWkAGGwXgkUTwb0Ed+Ulg4avXQ7PasWDk23BI+gUikTH?=
 =?us-ascii?Q?bPmKsE2cjnwC1d8JNTnzZw6R/OoLU28/HII35OoXhlUP2Lfxnr9zB5wHSRSc?=
 =?us-ascii?Q?1plrIn8nw2K/LNFk61wzmEDt124NcGPvPTCT9wmrfASs3aRVmFQvALsaajJ1?=
 =?us-ascii?Q?Wztzhrcnkx7/5O3Me9rE4+h5bqUdBiU4kv4BVxWB5DQT2VNPji+ysnLzHC4t?=
 =?us-ascii?Q?2yIZYnxTlSvJfzR9m2IEXEkZz1z68tJov4r13uDa6L1ErZuGcyEiwBS9ngcr?=
 =?us-ascii?Q?9kiBk7TEk/sMhEuyW1LS3Y6EvcOJxLWOUWO+EkkV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc72e382-e638-4b01-887d-08dd971b11db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 21:21:08.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2xk2NQlXqxZTIvi7IkpprMzsL1B2XNdK4cFj3jzxgiyiCuzFLq/qgjMif399vk1vGn8kbHKDaZ0FkSetNVJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524

On Mon, May 05, 2025 at 07:41:48PM +0200, Jerome Brunet wrote:

PCI tree require keep consistent at subject
git log --oneline drivers/pci/endpoint/functions/pci-epf-vntb.c

require first char is UP case.

Align memory window naming with configfs names.

> The config file related to the memory windows start the numbering of

                                 memory windows (MW)
 then you can use MW later.

> the MW from 1. The other NTB function does the same, yet the enumeration
> defining the BARs of the vNTB function starts numbering the MW from 0.
>
> Both numbering are fine I suppose but mixing the two is a bit confusing.
> The configfs file being the interface with userspace, lets keep that stable
> and consistently start the numbering of the MW from 1.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..f9f4a8bb65f364962dbf1e9011ab0e4479c61034 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -70,9 +70,10 @@ static struct workqueue_struct *kpcintb_workqueue;
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_DB,
> -	BAR_MW0,
>  	BAR_MW1,
>  	BAR_MW2,
> +	BAR_MW3,
> +	BAR_MW4,

where use BAR_MW3 and BAR_MW4?

Frank
>  };
>
>  /*
> @@ -576,7 +577,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>
>  		ntb->epf->bar[barno].barno = barno;
>  		ntb->epf->bar[barno].size = size;
> @@ -629,7 +630,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  	int i;
>
>  	for (i = 0; i < num_mws; i++) {
> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>  		pci_epc_clear_bar(ntb->epf->epc,
>  				  ntb->epf->func_no,
>  				  ntb->epf->vfunc_no,
> @@ -676,7 +677,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>
>  	/* These are required BARs which are mandatory for NTB functionality */
> -	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
>  		if (barno < 0) {
>  			dev_err(dev, "Fail to get NTB function BAR\n");
> @@ -1048,7 +1049,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	struct device *dev;
>
>  	dev = &ntb->ntb.dev;
> -	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>
> --
> 2.47.2
>

