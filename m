Return-Path: <linux-pci+bounces-44079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3DFCF68DF
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 04:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82BAC304A917
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EEE56A;
	Tue,  6 Jan 2026 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="au6pELEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020116.outbound.protection.outlook.com [52.101.229.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37B3A1E95;
	Tue,  6 Jan 2026 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668971; cv=fail; b=iIK6QmAUKqfdr+R8TvRFZhVe3mQns0xnFOC7W2Iv5mN4CA213m3dEz+dyqcf47ntAa5a6ymOPPxv3xJQzQArfqCapNh/hfgLX05UPvidncs/X0Hs4KF9OZeUdYrLPJedlWcoViQnsizXHnJ+odM0cXeWaWXn7iXhs68YwTTArbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668971; c=relaxed/simple;
	bh=ZYPITEDynkzTV1zvpbwjhz4mRb8xJlFoo3FSDNqpIMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PAOes95FQMnhIQbrfy/zWM3VBBttYfXNgVUVk0cxUS9VHzZdTQL8hX9pURV6J2gNcaMtf8zS29mAMkJ8033zeklzrfzMVnZTBFJ8IMNEPRBxoqHIzeg8Ryz/B5k5BrxfiUVyxIqaafF+kx4fou39vvJt92kcso2eMUTOjn+FzXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=au6pELEb; arc=fail smtp.client-ip=52.101.229.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQWzZp0eb8V94Menc70ru/3QTE8hlMRh/mhTXeKRWYZMBwJSuz49TdH5mGrtjyKLo2WopHQkyL63Lb/qAsm2sOrku3vLUdbtnykShPZjJCjYDdvRpv//P+ppbIbQSvmym7G0GbKG1ADFuRF6+/riYdmVggAwpELehRjAgKS/2YQn+c+NSTNOd1mkZZPgPUMxiT81HIBvrGRsPkBGTiFSt2K+q/ZeekGwa/Hc8k0en4KWDQIZPJeQhx7+WB8QW2Xy2X58AC8sIVrmQyPGJyk9RXg0w6Jc079okvy4NQ5rZtljRFwrd61DFi6RSF2QJ+R5CKzb4h7m+cmCb8Bs7HxEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PTMWNgdmfD6tT5pLyoorLCQa5Wn4wMtaBkg+HKQWAk=;
 b=T0Kr1c/53z8C6UQsw/AQmsYYq0OOu2HUDbLR7SsSorXyYXV7oYSBakwgugnHqRjM18WrM06sYXYVQk0N2fjaN0OBk1snhkQ/XfLxX5sEKn3nJqJzXnA+egNkLL+aWAJNWZyEBWLQVh4WUoPjUUq9fiyqsesFCwoX8+NMCT6P7nq9KDOuF7KPkdlJ65G3yDwcGkFYOhfZ5YCn0ViLuLKz5RzEuoAxEQQvkI3RFEngDaMgpwyGmotiH2yDheL+0L62NeJc9/NLZWlAR4NijA0HmhFNu1YruZjbkiFVCZpI60coQcmiYFkFn+ApnWWqkvNrB1vBq8wX8hFQ16kCvSze0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PTMWNgdmfD6tT5pLyoorLCQa5Wn4wMtaBkg+HKQWAk=;
 b=au6pELEbjBqbasvjhjskA+k/A0omPvdVBLu6zVr0QRbaoZK4M/B9lW0V9rbhaYPLg7zvsWGs4CSB+0py+0nThljCO3ESheZ7L4i+DYB0ZZSigP27fd8VHGF2/pNnNf0sw+iccP3BhgLgukNJU+SJySW1gsha3B6aLsvEDjxmKWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6371.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:407::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 03:09:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 03:09:25 +0000
Date: Tue, 6 Jan 2026 12:09:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <o6swnuf4aplcyd5jpgbyhslxcxuhzt4j6a4oq773eujva6ynqj@wmkorp4mavul>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
 <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
X-ClientProxiedBy: TY4P301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: ff091091-acd3-460d-6846-08de4cd0ff65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VINO+czonFKOR5DAlaAqZpeEqmMxfxcJubjQMgm78AsERoYSeqojKuRXo91k?=
 =?us-ascii?Q?vg583k4jjIoPx+sbvjU81LPM3sObz8/2y1Hq9Nm4GaFRdttR6o7GyMPwqly/?=
 =?us-ascii?Q?ddHUOy43KeXP9rtmRdCPQmvqe5ZnXeq+0N2VsbqHeqWoAEhGIGiokalmUHYz?=
 =?us-ascii?Q?ttbTHKuSayWHOXiRHVNzp4eRF1rhNw+THJCxpzoy5M4FIXFVRGsc5wJ9tIpb?=
 =?us-ascii?Q?H4suOlhex/JWY0DT0mpQP5zAnx1bJ39W7XV2aJvGjuc1lWzi7xkvOknFxE4W?=
 =?us-ascii?Q?DnpSke20u+ZyItcV9yGxWiSwb229xH1hTXzg/O1gV3T/UDQJWK/FmtwrqZNA?=
 =?us-ascii?Q?ZBrKnpHgNYLnvhwvb1zlsAvmNE3HUkqBAqviW49ivlle8qqfUom1Km+537CY?=
 =?us-ascii?Q?vMmBERXBLPXfD6+b1ZRkxDQphmPMd1MXL7sOPrtbX7rPaXpZF23kU6Ht6xz5?=
 =?us-ascii?Q?QCUmA4Zsoel0xxiWkmIZ81uFmTvffXDDP5yAUnKVd8/Lx26DZODSXpDd2VCC?=
 =?us-ascii?Q?huEw83KwAefEYBI85ge14Sj3a+9OMVDbTAA+9OwPOsmhd86pZH0pWcBqkvyf?=
 =?us-ascii?Q?WsWGAgkTvrJZDz6ostX8cT9cgkKvYFtrtJ4aOP680Zg2rYWoN2ft0xTYaVAp?=
 =?us-ascii?Q?XrkXteKwPcuq/MkHkyiwOJocuoY9eWSfR68QFfqNffyMMAvN73TNjtqYxArG?=
 =?us-ascii?Q?Kjwh0cX7r1CW8Ti94ySqsM3FP0W2kMP7lAr02ckfuFIJKzEw29zfizUHyN3m?=
 =?us-ascii?Q?zCj0JXsAegmn+oJKGSFIlCVm8s5keCGYzTct0WasNXAosH1+/scZJZOJkum1?=
 =?us-ascii?Q?aRgBYVEfR5Yl1q6ZJnB7ln9sBrPNfVVdhp8Zsh83W0pcygKY626U0p0AEIdJ?=
 =?us-ascii?Q?NYuiV42Bd927p0gbCduC5VJypT9vaEuujVffXgQBdPbWBtGn26Pnq2kATlxA?=
 =?us-ascii?Q?t1B/uhFzbe9FEO40w1Qxk9ejV9e2GsPooVFTOsBZQH2P3nleu376OOO54Cff?=
 =?us-ascii?Q?WSp0cDYq9ie23ecpP8OQeeo0zZ1pogYoZjoR1QlIManwC9/FBR4WbskPK5mQ?=
 =?us-ascii?Q?b+RPd6vM3OXT1wtw9SEwPnWmXFkPF9pRLoYtkHkLIULP+gd5LGs+GocrmTKp?=
 =?us-ascii?Q?ssH0+K4d2GZYT2naMtViikFqgfkoMrA/iSWnDzb6/wtmHI6NrGaboWF1pbDd?=
 =?us-ascii?Q?NpqWJQdUO8jqdqvuYJ9KXNfZKC2If6MP6UpXJmdIgbqOEONmvXGlYfNb+whQ?=
 =?us-ascii?Q?x/1b5x3pbNJGVNstZ05s0RYePUTBeTqSL3OSsC2vr2hC59wDSfufjIspfzir?=
 =?us-ascii?Q?8RdagsEH+auzmP6pJ241OdUyCfbUzXRHgUGbeYr6GXwvg1pS5D2tlr7ckG6Y?=
 =?us-ascii?Q?IiTRp6Sy/lmaiPTH6WDpYNjShHLmb1Xqo4a7EJgO2zm/hySbcDW1VaAXW0WI?=
 =?us-ascii?Q?U+jSE+EtQcPDQje15tzsgnaNapAf5WFryfo9LfvwQV+cwS65LfyPDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16r0AKeuLFZcbc9iWQXMCz+di79Anhug+4iY9v+7ANpUI3rIScA8qPopWKEW?=
 =?us-ascii?Q?JP7xrhtArZR+3Dxfv/hEECQNHyAXUe+kTv0DRIYPsajgh60yi9TFSpWScPj/?=
 =?us-ascii?Q?q3izqLxdROQasEkjIJ64gAtrePHCi1eat9ZYnz3Ur2QvP5qu4ZnRHoP0yqbP?=
 =?us-ascii?Q?nnvzbfY1mPkxIIPa4NayeilJAdrbOgsjBn05+vd29nQtixqxrUs5dcbBXKxa?=
 =?us-ascii?Q?2bLclpNSl8xHYCWPMEfVtIp/n+kMtbxqFpTxg6ttTJjg/V7hM6MCh5OD2jhg?=
 =?us-ascii?Q?Nt6Q17uCjJgXXr9HnhkAVCdbVPeAoQDElf1GzkzUMZbPp7ay8GAX24KjNrLV?=
 =?us-ascii?Q?HOeUmY2Izmi/SqDz2ChaDvDXrn48jiHmNg+7s4wZ3eaO97w0FAlRA92oPksm?=
 =?us-ascii?Q?OJD/GebHjW4uuhOjwzVSqSrBM3zNvLNrclRiQKfO6GQIyOTDq/xnHGiHBymN?=
 =?us-ascii?Q?sMBE0AHWundvXVHhtl9U6NUX2n56Z4nAbXje4bSq2rtGATSEECR7wK7aiU8E?=
 =?us-ascii?Q?hDtwr1U3q+wD2qvSXn7UWkj0JnoWU5PJQ+OiHFE83J+2IorZVjfYzeH/Nc8c?=
 =?us-ascii?Q?NtoHgSnUr1KPnnJat8VOCNVm+n5DebuKcJBAB4y3PS++AiAuvK5qREdofpML?=
 =?us-ascii?Q?+Jk4zyGqRKJmwHiytXCWGCEtRWyl/wgJdHELOv58bTN/TA8MnTdaIwcs3tyO?=
 =?us-ascii?Q?rpzHvKtHGsb7uqpQV4tGYkGEIRKsA5gJhootQxqwumzZPrMhJG+LYB9jApkc?=
 =?us-ascii?Q?17Un+wBoUpWcj7rJ4zylyffBE4pgjEorp9b3hDxPXiZ2nBa7q31jBMDflD6Z?=
 =?us-ascii?Q?y+MXgF1NeNDgak1ymyMmtiI2LRWmeOsc4X0LO7KzxQdCKL124Voxyxd+QsiG?=
 =?us-ascii?Q?RMkSKyXQ0ZZ0d9IMiB36A8xWS0XKVRuROgH5c2RlPLMlzruL/IQaSCU7jBIQ?=
 =?us-ascii?Q?JQSvDzkVuy6fE2G7khUQp0od8zyt7+5jfieszKBT2aAavKqkgaCUhm70hG9e?=
 =?us-ascii?Q?KLmgZJTCHitwEcBdvNAFD5bwxu9ydlfqW8Ysq4KAAcUV/9kpWBqnZV4GLiHx?=
 =?us-ascii?Q?H6Mpy6MqftKlvOM6EjXhtDfKrBHWvVursBHFVkkC/F4e0AKc4JHNv9dLfxT/?=
 =?us-ascii?Q?e2qrg5srdzT8pOgGMM60tyXoWKcfuW78uSEbvOQEXReRkLRPcsZAxy8Pruds?=
 =?us-ascii?Q?r1vqyQ83AfLbXxTOFLaIHjTDREO2R4sf7AWlaOA2QON/HkNEhab1XTNIN5sY?=
 =?us-ascii?Q?sKHgHLWLpbd0ry0+8IRfpKcz6CBV4a90DusDnE74IvdAO8ECYZuw4tTCpFmB?=
 =?us-ascii?Q?46t7g7/a8Dk9TYBHA3TDXmPZMbBM7/oGWfclb5uJAke/cRYRFPqwh6FswEY6?=
 =?us-ascii?Q?SiDT8XTb1GZqcBs7QGuklvDB5/xMUvIVqsrbIiUTRD6bftBUxw2X1DhYm9Jp?=
 =?us-ascii?Q?NbB1gXUM81PM0IbG1Cwj7VOeKL684teRq4kQHUXYmBogtIF+GsN4jFcKIG5G?=
 =?us-ascii?Q?5rAQbA3WUs22FSpnWyUjIyV9UeIW+bOPzIo65lIts6lwl7PVmp6og5908Nv9?=
 =?us-ascii?Q?LGiHBGGq6bL5TjsbXWa5xYLDW+J/wYWosSnrnJdouqVBt5I45pSt2h577nyw?=
 =?us-ascii?Q?FvlsFlhuOiEUT20821yW+JdEejskZiMYO6VHXXpcjoIHDBybehlG2OaXljB0?=
 =?us-ascii?Q?nD3tx//1tdgJepld+jUoC5Maf1gPuy1v9iVNq6JFZ4KGkGfAE7kK2opLhj3u?=
 =?us-ascii?Q?/0DSm6JuysChtO4VFyD+qz4Xn24HqiCTsXEb74f4Ho1J/u8a0XDD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ff091091-acd3-460d-6846-08de4cd0ff65
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 03:09:25.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exlFhwl83V8/MRlgY+EdqDBQtbIkUPS0Q5+WJaqJDZjghYxGrY3CRp1/uYpIoR0fzOeKGIu9CthDMIr/5A9BUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6371

On Tue, Jan 06, 2026 at 10:52:54AM +0900, Koichiro Den wrote:
> On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> > Hello Koichiro,
> > 
> > On Mon, Jan 05, 2026 at 05:02:12PM +0900, Koichiro Den wrote:
> > > This series proposes support for mapping subranges within a PCIe endpoint
> > > BAR and enables controllers to program inbound address translation for
> > > those subranges.
> > > 
> > > The first patch introduces generic BAR subrange mapping support in the
> > > PCI endpoint core. The second patch adds an implementation for the
> > > DesignWare PCIe endpoint controller using Address Match Mode IB iATU.
> > > 
> > > This series is a spin-off from a larger RFC series posted earlier:
> > > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > > 
> > > Base:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > >   branch: controller/dwc
> > >   commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
> > >                          to support 32-bit MSI devices")
> > > 
> > > Thank you for reviewing,
> > > 
> > > Koichiro Den (2):
> > >   PCI: endpoint: Add BAR subrange mapping support
> > >   PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
> > >     iATU
> > 
> > I have nothing against this feature, but the big question here is:
> > where is the user?
> > 
> > Usually, we don't add a new feature without having a single user of said
> > feature.
> > 
> 
> The first user will likely be Remote eDMA-backed NTB transport. An RFC
> series,
> https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> referenced in the cover letter relies on Address Match Mode support.
> In that sense, this split series is prerequisite work, and if this gets
> acked, I will post another patch series that utilizes this in the NTB code.
> 
> At least for Renesas R-Car S4, where 64-bit BAR0/BAR2 and 32-bit BAR4 are
> available, exposing the eDMA regsister and LL regions to the host requires
> at least two mappings (one for register and another for a contiguous LL
> memory). Address Match Mode allows a flexible and extensible layout for the
> required regions.
> 
> > 
> > One thing that I would like to see though:
> > stricter verification of the pci_epf_bar_submap array.
> > 
> > For DWC, we know that the minimum size that an iATU can map is stored in:
> > (struct dw_pcie *pci) pci->region_align.
> > 
> > Thus, each element in the pci_epf_bar_submap array has to have a size that
> > is a multiple of pci->region_align.
> > 
> > I don't see that you ever verify this anywhere.
> 
> I missed it, will add the check.

My reply above was wrong, the region_align-related validation is already
handled in dw_pcie_prog_inbound_atu(). I don't think we need to duplicate
the same check at (A) (see below) in dw_pcie_ep_ib_atu_addr(), and would
prefer to keep the code simple as possible since this is not a fast path.

    (The below is the code with this series applied)
    /* Address match mode */
    static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
                                      struct pci_epf_bar *epf_bar)
    {
            [...]
            for (i = 0; i < epf_bar->num_submap; i++) {
                    off = submap[i].offset;
                    size = submap[i].size;
                    parent_bus_addr = submap[i].phys_addr;
                    if (!size)
                            continue;
                    # (A)
                    [...]
                    ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
                                                   parent_bus_addr, pci_addr, size); # (B)
                    if (ret) {
                            spin_lock_irqsave(&ep->ib_map_lock, flags);
                            list_del(&new->list);
                            clear_bit(free_win, ep->ib_window_map);
                            spin_unlock_irqrestore(&ep->ib_map_lock, flags);
                            devm_kfree(dev, new);
                            return ret;


Kind regards,
Koichiro

> 
> > 
> > You should also verify that the sum of all the sizes in the pci_epf_bar_submap
> > array adds up to exactly pci_epf_bar->size.
> 
> I didn't think this was a requirement. I experimented with it just now, and
> seems to me that no harm is caused even if the sum of the submap sizes is
> less than the BAR size. Could you point me to any description of this
> requirement in the databook if available?
> 
> > 
> > Also, we currently have code in dw_pcie_prog_inbound_atu() that verifies
> > that the physical memory address is aligned to the size of the BAR, as that
> > is a requirement in BAR match mode, see:
> > 129f6af747b2 ("PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()")
> > 
> > This is not a requirement in address match mode, so you probably don't
> > want to do that check in address match mode.
> > (You will want to keep the check that the physical memory address is
> > aligned to pci->region_align though.)
> 
> With this series, the call graph would change as follows:
> 
>   -> dw_pcie_ep_set_bar()
>      # For BAR Match Mode:
>      -> dw_pcie_ep_ib_atu_bar()
>         -> dw_pcie_prog_ep_inbound_atu()
>      # For Address Match Mode:
>      -> dw_pcie_ep_ib_atu_addr()
>         -> dw_pcie_prog_inbound_atu()
> 
> and the size check that was introduced in the commit 129f6af747b2 should
> not run for Address Match Mode in any case.
> 
> Thank you for the review!
> Koichiro
> 
> > 
> > 
> > Kind regards,
> > Niklas

