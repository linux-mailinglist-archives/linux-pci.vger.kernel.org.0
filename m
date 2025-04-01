Return-Path: <linux-pci+bounces-25072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B1A77E4D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9610F3A6E10
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C782054FF;
	Tue,  1 Apr 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kSYq5gm7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009022054FC;
	Tue,  1 Apr 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519328; cv=fail; b=J1AyCZ9Eyz3qZ54lqyIoIK5wbovWa/TcTvf9iU2ZUQwuytJ5WT/nDIJpgsU7KVmSuKjUKdZObZN5kLeBaIQ+TKDZcnyAI7h1fv7uLVaYItIH25QVJhngDhrrCqaEV/ohXshAP+s16yvRS28TyYmf5gJH/d9sBUrSVxJjYne9k6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519328; c=relaxed/simple;
	bh=Ze8ObDIXYbQFqH4SRXJJBKkaJgSwmu8uQyRK9yK0/rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eeV0xlrZoS7vRjhws9sQ9H6v+Mkqmuo3+ipYTTg/YsW+Ps/NzswyMOrkHIHZIxsjztohXIHvKhsvBmNYZTIepMQ/b9Vub5Gz88dWb6lF0SeNMoGkZnIX8uZyWsEDl5fPiyuPLy9u3N5xsm4mUAxhqbJUMmut0O1wyoGsmx8Ww4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kSYq5gm7; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMMzrrBNY8/FhHSo0+f13B9WlEYDkaFO3wyYlwJFdNae6jJ+Bag2AFvj1u8GKMn8rMRkrbHG/xV8Qlkd+Noob1W0u6CqQ+a8BLAr50fzHGK8rEtqi6Jgn0opupGF8o5sX+B4Fty/or81Xg9P9n64ZHF5cKFuGnpPmGxzdTrceySwWYTMyRr8cudEEbz4tqGEQr6kdJHR+xnj6Lyw3sOjmoX5xHUKzTjzdWUuT4GKi3EwMrPQ6tHSOJS7j7ApYN9Lg0UFQk85XVn40yvjIRVZp/bJiX9H9iHHc30yhH4QYp3saeZAB5KhQKPxQWsoqoSpQYhvR0geQl7dFI67J+JQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRQyEUE0ND92GgRTUm0lSABUu6Tyt8V8n3W6zVzRqOk=;
 b=YhDacVimerm2GD7+z1pEsVqfMxEAhAztTFo3AzOdzOri8lC4iqoW8lKx8SzM9qrirtLrSuEnR1wKjczbD0a9CaxLuMS5Xro1tPkvmAIPGWFCvGhllb6SXLoh18pPEycP6NfZFrm6knq1Y0hrlGERoPplO/Z0x3tiZ19J5uMZXmBalV3VBASQrYRIH+lKI2U1OnNIWyHSLxR8gvHzhbu3R4Gr3vH3KYUSdcLOvzIav5giW0Iya+CKlswIKmfiqNQZDgqwa/UWXcohDkN+zztLU3lJaKjMKs4LT+Z7MGY10muPog3cSy/yuDWMIeg1fujzgOCI+VU3X5s3MmKC45Tp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRQyEUE0ND92GgRTUm0lSABUu6Tyt8V8n3W6zVzRqOk=;
 b=kSYq5gm7sSgpYNl3bg0qhahIrLU7A6QRsTM8Bb7jGyKvXe5OFCEHyKlfdeyhTOXTY+SPnIlE1B/BGheIdwf47qWp+3CfXVe5vtud4LJNI1eUT9lMcUfIUoN2a50DFZklqf0U6kL0XZyPqXyqzvAzBziBgEuj/ZnBftLk/8yeBRfJGi4pq4swqy6xHDw7dbqTLtVJSLmU+06c4iK+GLtBqg4HMSB775o6gfv/YwdyMZHjuU8I0rL8AFL+lONqE+TmR1rYPph7mIJbsPosoITbO4Zb5qz+T1wleGoXK5FZJIClcWz/RVxFoaI646NFZgKU4riN0N0PkwzQhfQlQSn4lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8743.eurprd04.prod.outlook.com (2603:10a6:10:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 14:55:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 14:55:23 +0000
Date: Tue, 1 Apr 2025 10:55:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Message-ID: <Z+v+Uni7PV9Nlstq@lizhi-Precision-Tower-5810>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
 <20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
 <Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810>
 <1jr02ctjoh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jr02ctjoh.fsf@starbuckisacylon.baylibre.com>
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a467443-442c-4fff-9d8e-08dd712d3aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LpC60/YJJ03+n9MdVtjqic/T8LK7oKsujc9X+nnPmVFSfaBem/YOPFJA8okX?=
 =?us-ascii?Q?Gb/cWXXxWoh4K9uzJkDpgRqtQaS9N00CGApj/VYFF6FvK6K60f+e6xq03Cr6?=
 =?us-ascii?Q?YFqUyNXkUJtn2mZSAwdeTxvSCHlgehvaeck3iYlz8JOXNNHfDj0NJhBvWr3V?=
 =?us-ascii?Q?XZzFc1FPKNSCZDd0xolmn7l0fYeVSyIasTylCBsbMRE3eEwGs6Ny6/tm2q2v?=
 =?us-ascii?Q?cm71J3Imaf/3azg8tALSPxwbQUxxhIb3QOuyY51aRSLbOlP1e4GLoivz3d7+?=
 =?us-ascii?Q?xAqZ+sbEIy0Gq7epYRFck7+GZVvl8CvpznGi9m+V0amgnlaUdp8xrwfYHnWr?=
 =?us-ascii?Q?PS0uJBz+Aqr1ZsZbSW8hbJ0AWmGtajy2PRjndr0TBNYXq/qPgfQZMSKHwAdv?=
 =?us-ascii?Q?by+UMW38u2majRYPRXPSushpWeJ9UEQYndkXk/h4I2mbzf5jugK4RBxV2VVj?=
 =?us-ascii?Q?/swuaL/Vonjs9k7JFV0F5XV8zcaKkfUc+LFQbAXMs/M/SXHtmgb/8rgsRfH+?=
 =?us-ascii?Q?9EpmFPOT9iAlzFcoLeGvni0zWdDiZamQ/1OT0bFIAmaxrwkieZ2rzd+GPaNb?=
 =?us-ascii?Q?/xkMtFilItNVBF8lJ/nfMlLzLQtso94SoRGhY0mwj4FB5Je+0Nodxovyg+oi?=
 =?us-ascii?Q?S1cXyEtIL2hQUF7msgruicrawRuO/aCWLX6mZAxOQiLnOQKml4BIg2crbSNP?=
 =?us-ascii?Q?sWauD/GWSW1VI/VozBBmyhVRzleUpiERMJKmokZAlfKFYIQVsA7K8DUb7ICv?=
 =?us-ascii?Q?WDClhQpH+FwTiEkdhg59dfhrj3As+u3kK/tTdbE2hoXyLEuhNOLT4//ayvDo?=
 =?us-ascii?Q?Uz3j1+2UoaWlg6HRiFETFl7h6glTjuj0NFt0sj8vUer01VfqFQIX+k+plzQR?=
 =?us-ascii?Q?coLlFKVvjly1nGFLemdsku9hlcQfhkuK8cv0Zmg+FGi0Gx4Q60iJTIISG2QD?=
 =?us-ascii?Q?GwhyOSQwo0sQMMeMfEd6TTsPOJ1ArD5h5t6/G2K8EzRvBEZxLr5hwMDzEtuL?=
 =?us-ascii?Q?eCSw3HtcAWIQLPAp5RFBuQB4cH4AAgnhTVeq1C9664wUtyB8pwnZRe9jqGN+?=
 =?us-ascii?Q?xD9J9k8kUuFs93s18cseXoAMwJbfx2QlDFprkDcwKXETyDP4UdYJgJ5Cr7U6?=
 =?us-ascii?Q?iXjGS+UppNUu2suS8xTYfQ2iW/WGmeR3K/vjJkCZzUvblPLzOraeQK9uWWW5?=
 =?us-ascii?Q?KYG8rt3PDmHL9joho6ZEAPlPHTDG1ZcqpCRQweMk53zGeFJXGg7gHqpQy7GL?=
 =?us-ascii?Q?MnyNjK6yVZgvQQEUtQrYOLqF3PE8FyAs7Q1icz89QfwKdyS2DSOxrDtHgNxD?=
 =?us-ascii?Q?YSnROkYWNm0EhGg9qMDkhlNJsQeoYicGgPEG9olY50QiMWifE00lp+arteRZ?=
 =?us-ascii?Q?vIOtfsUfAx9Rt9iiHgthLbacE54qbX16LwCqqw+g7V+gfrzP8wR5lLCfU0NF?=
 =?us-ascii?Q?YFrQkEyMskSH8Xn5/tSLTNxrQnrzqBW+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+vmwlk2PCaER9VlJ/CBlqftwh1gfrxHlMSsikpNAhp3OcmzfbkALgzFD+Bl?=
 =?us-ascii?Q?jqQMm2pM2LiSyOnAP4D872uRXTcbkt3P3cimDAH3pSojma7BiTPPNsfWTvDZ?=
 =?us-ascii?Q?re6G+V8Xy++SSg8relK7S/wtNmvA23+DuD75OsEUPV+ux9G0lV2etN8p9lhx?=
 =?us-ascii?Q?lIOID5JyeBT4gRa7eo2Q10GGljWvjvv/K4JnUaNJVuNrQn2vvvC1ZSEwW+xZ?=
 =?us-ascii?Q?vRiqMO3T4BmgPnHwrKr9RXe6Gg9AU2Lcu18FVXpuvQ56RGcVjJR9yrT/E/jy?=
 =?us-ascii?Q?eoSSwGkXYsms78kB851hjjZH2AO4zN9iejcFCSU/tn9lJJl7tBM0xbrmJxnB?=
 =?us-ascii?Q?YtqfG7wuOjFqim/YvhEPA031/ag/1XzJmk5LfojfpjmIVCtxbwhpPGZBPgpU?=
 =?us-ascii?Q?YLnI8jBC5Q/UKL9iAhNrP+s5P4lmEyQuJv2PkSXQZRSZd6kxK0kz4hGKQxkg?=
 =?us-ascii?Q?svmuWFcpImUzG1taukpH6XjCKeNpao8QKk6IUOkgHxwn7nuGMWx6ZrUx3d6p?=
 =?us-ascii?Q?d9hBID9FTR4HA00I8+fq6muT+ojGI+4dwkvWPmGKL+imMl4EAS3GYjKej4FY?=
 =?us-ascii?Q?aqTfj9aXt8VPcHsjZNOzLpbBvYVwXV5NADj09BsV6lcQcWRUWckxVmT5wUfL?=
 =?us-ascii?Q?IH5e8YE+Rgy4EbzDmrdc+/ZA099UsyB6W4SjBWszVDC0nROCycj4YVrlP3Ou?=
 =?us-ascii?Q?NiE0xVxen72Sb6PA6HYWRfNRaq4Bu+KXg/JY7WZTMUnfEVapNr/0aNvr49Q1?=
 =?us-ascii?Q?Y2hq84Hp6lShtHd1KqyViHgxmGmUDLFVoOBs1u3ecXxa0D+n/tT9EQdPeHsV?=
 =?us-ascii?Q?8FftXRpYzzkZIaK/WzIn3/8a/TvpxR1BB4MnDYqLK9qU2AFfHyHO28hgfNUB?=
 =?us-ascii?Q?UKE6H39hRzifyZ/4rO0qiOSBAVzgJ2CNzVLsEMfMH8uQiQrMAfAlLTpu6mM4?=
 =?us-ascii?Q?nBkLCWl8V11bjwUoK+mOXGvDjMt+LG3G9SeIZOYOmzYLhMVogAo0K+Nby72C?=
 =?us-ascii?Q?vt88uU2544mbwKu6svwUezmGYFf4YHN2E3Hwpe06ySyK+wuEWAQq0sk0p9p8?=
 =?us-ascii?Q?8N4iLkx+ZRt9I1o1A8T++gsh5CZaHcVz08B8GATNyN2D+Y6u9QyQPQgjNzAR?=
 =?us-ascii?Q?EIwiev4XeaOQhGEMlGK9hZLPI/yyoJ7d7iDDu5CeVarjN0EYyyLa8gAbDDhg?=
 =?us-ascii?Q?KyxK3nCL5JcUG+USjHR36a1ah8G5PJ20DF6ITTPmobjsTLg0mnvX68opwyOE?=
 =?us-ascii?Q?dvPaGmTJ9WCwjlp7tPWP3Yhbv0jezSoMi1x3x25O+eK0tHel9UHx/zEEjuoF?=
 =?us-ascii?Q?Njl6IhufigKcccMSZ+HiqqDY4mOntjIFen3ROglnfN0rOyfNhvV6ALhvQFrs?=
 =?us-ascii?Q?VxOA3xQDRGZ80/zLYXjx75kiswZ4fyFw4AyTvdIrRCz2cK4+L5Ucg6w/dqzJ?=
 =?us-ascii?Q?gD7BvNnnkEsZT0Tvl62KK7Da4actnbNEhXzoffjB97aIInd4IDdfK4p2qB2M?=
 =?us-ascii?Q?DNg0Wi5uaWHaisgQ5Bm0RGjSxjnN2Ay9O/GJDeaY+bttYbVzZATflQHYdxQ4?=
 =?us-ascii?Q?vJ74n0yKap0gG/oyXtf3aOVQzC8aNpHB49lBaa0g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a467443-442c-4fff-9d8e-08dd712d3aa5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 14:55:22.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoHNGbwRunrpbnIVUCGNVUxrLPyt0+uhezQcv9JKEQD2XsTs0URXCWWCzbKWWUfElhuBiJtJG2KoGGQGbOOkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8743

On Tue, Apr 01, 2025 at 09:39:10AM +0200, Jerome Brunet wrote:
> On Mon 31 Mar 2025 at 10:48, Frank Li <Frank.li@nxp.com> wrote:
>
> > On Fri, Mar 28, 2025 at 03:53:43PM +0100, Jerome Brunet wrote:
> >> When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
> >> should not try to handle the size quirks for the underlying BAR, whether it
> >> is fixed size or alignment. This is already handled by
> >> pci_epf_alloc_space().
> >>
> >> Also, when handling the alignment, this allocate more space than necessary.
> >> For example, with a spad size of 1024B and a ctrl size of 308B, the space
> >> necessary is 1332B. If the alignment is 1MB,
> >> epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
> >> been more than enough.
> >>
> >> Just drop all the handling of the BAR size quirks and let
> >> pci_epf_alloc_space() handle that.
> >>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
> >>  1 file changed, 2 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> @@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
> >>   */
> >>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >>  {
> >> -	size_t align;
> >>  	enum pci_barno barno;
> >>  	struct epf_ntb_ctrl *ctrl;
> >>  	u32 spad_size, ctrl_size;
> >> -	u64 size;
> >>  	struct pci_epf *epf = ntb->epf;
> >>  	struct device *dev = &epf->dev;
> >>  	u32 spad_count;
> >> @@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >>  								epf->func_no,
> >>  								epf->vfunc_no);
> >>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
> >> -	size = epc_features->bar[barno].fixed_size;
> >> -	align = epc_features->align;
> >> -
> >> -	if ((!IS_ALIGNED(size, align)))
> >> -		return -EINVAL;
> >> -
> >>  	spad_count = ntb->spad_count;
> >>
> >>  	ctrl_size = sizeof(struct epf_ntb_ctrl);
> >
> > I think keep ctrl_size at least align to 4 bytes.
>
> Sure, makes sense
>
> > keep align 2^n is more safe to keep spad area start at align
> > possition.
>
> That's something else. Both region are registers (or the emulation of
> it) so a 32bits aligned is enough, AFAICT.
>
> What purpose would 2^n aligned serve ? If it is safer, what's is the risk
> exactly ?

After second think, it should be fine if 4 bytes align.

Frank

>
> >
> > 	ctrl_size = roundup_pow_of_two(sizeof(struct epf_ntb_ctrl));
> >
> > Frank
> >
> >>  	spad_size = 2 * spad_count * sizeof(u32);
> >>
> >> -	if (!align) {
> >> -		ctrl_size = roundup_pow_of_two(ctrl_size);
> >> -		spad_size = roundup_pow_of_two(spad_size);
> >> -	} else {
> >> -		ctrl_size = ALIGN(ctrl_size, align);
> >> -		spad_size = ALIGN(spad_size, align);
> >> -	}
> >> -
> >> -	if (!size)
> >> -		size = ctrl_size + spad_size;
> >> -	else if (size < ctrl_size + spad_size)
> >> -		return -EINVAL;
> >> -
> >> -	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
> >> +	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> >> +				   barno, epc_features, 0);
> >>  	if (!base) {
> >>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
> >>  		return -ENOMEM;
> >>
> >> --
> >> 2.47.2
> >>
>
> --
> Jerome

