Return-Path: <linux-pci+bounces-37147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467C9BA55DB
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 00:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5831B26E11
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D281B3925;
	Fri, 26 Sep 2025 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q5Qu0/eZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E31C28E;
	Fri, 26 Sep 2025 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926804; cv=fail; b=lvkI0Vx3+UPQtk3EKiovc2aBb5LT2cr+TsWHQ/KXMJluRVjqVhnQtkBwOWi4NRxmjsJe+4nIELnTVWrfJJEsPCKen6JLqVKb4k8LJseB0St/VFZvh1fL49lhZkdQax0wHNwP8MYc1+ThpmIA7+2iIulQXNSVJJtVnRt4xwZfXfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926804; c=relaxed/simple;
	bh=giWQAvfQIl7OokIl3pBcqSKEWgphXE0Hs+fk+GdeyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NR6AiX7iQnSBXrFsXhSHp3KJEjnewYTzG5JOlFupe4qDS03ZxxYgZYfp11hbqXnJjhJLnqr29bSFgHwChUqkv9ideUpCT5xp/bNlAFbR4pRPWeES5fTR7L6N7QWG8pMJUzGrlzemhRJoiyrTnHkZIXnZApJ5lTWGa2TIvU3Jtrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q5Qu0/eZ; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/Q61mC6Hi6iFgoSb15m3DpVPZ+YDqVRr3G95aVSKZV7cqUMiPl01UPE88z787FMBWY00jCb2zmXHv+20p8QvbabuJhoYgrTosSp376f1yfWGBEv+d8mBlvNnFAN1BtPdCqvVjIx3UxpQb+aKKOwI5iNl1o0RjJJG692Rh6g9fONFrL+WmogF956l43XnlwpNRoP2QzZpTAwTS2RDdrV82kT1OLsIT0GUNU9ZnJwoOk/PtIXNzMqmssi6uE9t9nBI+MS0rKZcwXTiQXZfwFhNDGVT7FGhJ1MoM2mOlXyv8Y4PdvMN27wYKPkC89CFBo4dq088Ze0KI9vdbNgVIVXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3nyP4lcSV+Nf2BApSgxJ9oX51Tj9y78GaEhgcbnvNg=;
 b=u+x86dYttvt4F/geZjSqN6innB/vYuiHPoInEm8vxbTbqwKnngjt3uhhkhb+erB07UWYJ1Q7ET/Uazg1PF6vPIWAUiBXLOvMT+LOA3WnOGUbQvdi9usd5HrqVaphV75YfUZEYjDjzC7fq6Ivtilj+6gODPhhN8PVqTBwRCbfrY3X2ro/3tIcQYPTrklFfzgI27mxJ/+xzwM+I1nqKpW5ItzHf6pJeMNWPkv+zQUh4y/0eFiTFCQtcPAbQHjDqAhA9s4fu8pvcKO1SBk1WVlOYj9+dbLW1lUjJLrS4WcB9onq1ICWHtGTk2gpZtog3cLOQEGMq0dm76kh3Ql/aP+XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3nyP4lcSV+Nf2BApSgxJ9oX51Tj9y78GaEhgcbnvNg=;
 b=Q5Qu0/eZK0wRbIpdsbv6mAxYw2d9XeudojaJu49tIEFn8PMtoMAE1f1XePVYnIwikICpkLjUH/T0Yru6ve4Mnjh45G0qdIBuy/ERGRaciodr3teAuHOpBrvQvjxoBUE5Mmw6cQEyZYaN8zLFALlkAC5hJ0PWEJsiTr2bDRjpFLME1aAKqgPePwIyKTfjs9hG7uUWeifuGem2xSwQHKMp5X9kCRTk6WU/DeaWbagYWTK33P3ISzWw855ScHeQQIaP918VwLUCmFbExkVq+ouzkKdD4pIgvDXKRDPC/1FRIbNeiWfQvr7EHnva9x3WypiQzsRhlTkqJyIxNMzJ3Hcd0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 22:46:36 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 22:46:36 +0000
Date: Fri, 26 Sep 2025 18:46:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <aNcXxC7cJ6yha+ff@lizhi-Precision-Tower-5810>
References: <AS8PR04MB8833BEF8C043CB239DA074E38C1EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20250926202521.GA2235281@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926202521.GA2235281@bhelgaas>
X-ClientProxiedBy: PH8P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6ba488-9875-4eec-b5b1-08ddfd4e8c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3rdtvQjYuZF8m39WOo4aHrtRZ2zFVmxA2Abjg2AOdpTSjkZ7T0zazaAVPz/?=
 =?us-ascii?Q?ZhBv8YXVqCA8zPxvjVy9fFu3E7Zl1K7GhFI3Z/s4JwZEspSp/+6cp0S58K+o?=
 =?us-ascii?Q?eOWI7oEDLR1CoBUtP2A8p/0J4wSnd8QY/AVwipaehVcx1aEcxMVGNnLC3JX1?=
 =?us-ascii?Q?bie4bV78+6fCOte3ieg7PiNmawV4QPoZJkuUf0DWenZRUFc+Hc27qMra0Hw4?=
 =?us-ascii?Q?yGOIGooH7P19nGasZfCgiSVjHHGLfGoEgmamGJ/QUDDkiFtkO4sh/QNUBC2m?=
 =?us-ascii?Q?b/1nVrhiyijgerAEaNwQazlf+8cvPkACJ8UoT7kx0mDy1Sp6f3Grr0Gk2oz6?=
 =?us-ascii?Q?VxDTAFh+y1e/V/kVAnuQ+6/0JIw7tkVFV7kxJqRgYzSskVXwUR8UOHZQmaYl?=
 =?us-ascii?Q?EUMXgAfm/9jWSzVyMBo5KlnLeoGjqpE2gC743iykX4y3X0UCHAhQnOaqUg1F?=
 =?us-ascii?Q?o5YwtUiOpdvSbVST47VNXvy0Qcbz7BkfL5jJTxUgsU3Dpv57l0RoogklvPLX?=
 =?us-ascii?Q?PXmP4uIO8M0SoY2xfqqVmQvujgrP8HlnIHaOxy02Yp5fhiUBSeqklAKkT1vW?=
 =?us-ascii?Q?EW+VmKIxsMNUxFQrdGmCbNpuPQvjc5aJhi++XqCxcrcCUBRLyhpEPT/wT0S8?=
 =?us-ascii?Q?QHI8PsGLHfYr9um4JFYsadL2G1BcnFWchIT/ciA+e2BBQKDLWe/leME6ydLa?=
 =?us-ascii?Q?Dd7TaS0+cyb33O7II4BKEvRlgpCb0vRXr8kaJeaep0apJfQ7yy2+Z5k9s9Pi?=
 =?us-ascii?Q?ceAznMzA3FNIitGUi4MsnyIGygSzFO8j0Wqx/a/38AWFB1zHWzT0JPU14pnt?=
 =?us-ascii?Q?xqH8GlaGJGgzLGa/ZIbuca9vZEqB85HAY1uFI3vi2bftIva1sXBeMcRvRDZL?=
 =?us-ascii?Q?ahpVY+EDNLPg7CVJUu6B4J6R4bjW2goTPv0Gf+B9Gme2hMATy+cIEklH8zSJ?=
 =?us-ascii?Q?X7yRwuBowTTUgMoFPQJHblhJf40CTzV63OcNF03AnCed2r1XDfXSyciMWlzo?=
 =?us-ascii?Q?iA3LNoizndDqS3qFglQJyqldq5oKzBRofRNtlrDhhfZrFsTPV8toojjwhNIG?=
 =?us-ascii?Q?cCTu4wN0NkjuAsK8rzQlUHNMRg5NRtpFQvERWjtbZdSjHN1YM0IGXX/3hiuH?=
 =?us-ascii?Q?g6L+ANYtp/AYwbNSEGqQuGWu3oBel01lt1sQI9SwqGJgYfuI6TySBCsy0EtL?=
 =?us-ascii?Q?I5fjzDT1yT1aycx5VY3NgeEgyy42z3B+PP3uRImOi/dqFtMLL3szYfo+wFC8?=
 =?us-ascii?Q?SYxGWui7jzM/F4fYKB/4VQV4po8qjmn8GqiJ9ZNQ34mf5PN9pIXxqeTw/Tge?=
 =?us-ascii?Q?i9gQ1xVp9ePpNfyPdgf/UjMDbkT6FOZkQ1MHLuoGkePLsmQNNn6fEvkp534u?=
 =?us-ascii?Q?V0AgOpw+xiK1VP9PRMvzybAzDAej7ULZcQ47WYPy80xckLi2MLToikuQXLyp?=
 =?us-ascii?Q?uO4/lGptg/0yVS7DOKcR+FXz5q1PAVHbiBRVZ5jU4H4PRVDU0Gli/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7jbNGftzzNHMaV/I2MFzoC4rZNW6QKy68HQ/qKu6+cG9AEGCUehQh7NKJ0z?=
 =?us-ascii?Q?Bkq/pD716xDWupzZrFHVXoDlgfomWDeD2k1PoBWxPR9gOuhSZimxoVdJbXoc?=
 =?us-ascii?Q?fpSlhaOUBSLzcX3nfRFJP+Svbgo84iKKprwyEW4h8wbsHj7+RKp2Yyftt9nz?=
 =?us-ascii?Q?eUmljnuw6rz+nc23Lj67/zv7bfXlleFFOb74EgIUGh3ts2iVBOLXvRJJ9W/f?=
 =?us-ascii?Q?qaTJBm1jODlOjDrPwy1vG1SNQt37074WFNRZJZB88TiMa1MMrgrdbt6Yz5cR?=
 =?us-ascii?Q?PJt/zPjMciUszt2iA2XgNhPVZzPfboAZOcmpCSbcMNoRyBXy/bh8G58pi4p+?=
 =?us-ascii?Q?pRUcqzxixJYugC3VqRuuyF84ftOQRHCYIrOExu2ilkdyxJfUusYYpVc+yWNt?=
 =?us-ascii?Q?a0drsLXap6yyCfVu6QyHGMLjOGuE1ui3secgehOL72W6YUPpW8iRQfS0azC+?=
 =?us-ascii?Q?HhBf+rMFJ1THVVlMC8yu5qyJcsw8W7yqiIee5q3flenW+yE9jUHTvlAHjuaR?=
 =?us-ascii?Q?JHANxi2RbiGfH71KaTTOusWcHeMbWEFx0bl0N4EKZjRbOFha3NxCuwFGLHLE?=
 =?us-ascii?Q?6tj5KZtCHU0Qh01htr2K7rp9D6+jGn41y4zdfmEEGw8T1HcQ3n/rXLVllrpj?=
 =?us-ascii?Q?klTeBwHinv5IAb2cvDaiu7mNQ8PWtzxn2Vq3klDIO4MtMNS7XiAU3jM3UWRm?=
 =?us-ascii?Q?8SAOCxNLLSOcaK0+TWH2176COMAo86VRt/SuXF2/VX8e5q+qw4U4krySbLL5?=
 =?us-ascii?Q?uSMo+XA0Lday8hreuTlE61g4VmE0yJWX3Kz+nUGJcAuF6Hc6fitG1Wo0qEzX?=
 =?us-ascii?Q?t9Oqc1lD2NMwXCqs/3oyG24kEauyxt2lwWZNNQtDD7WqK/2ftHb+tcmGUxIm?=
 =?us-ascii?Q?nNCn5Poinn1VJG/W8Y0h4BPGZAPSfPqX/07BC/1AeAjnkeLC2DlVuYr+ulLk?=
 =?us-ascii?Q?aGbQrZ6LpYw9h1uvXZw87/qh22JLiSw62aCVyKiaISDPy8hiWQNlKiTYs5KT?=
 =?us-ascii?Q?67A8CNhUfaj05Nrt1IESTQ+PEfadD8OVuqZPgCvMUq24ZUmV+4FKlEWj6W3A?=
 =?us-ascii?Q?QXH+HfA4Ihne+IFMDsHZIsqQorTvwJx0tRsCaCvyBPBZ22BYMK8m18qtl9hm?=
 =?us-ascii?Q?9+7TG8dY1O1AnZPuJF4LjG1iGlHZX1ww5zUCIt1r+MPIWDpWR5d0x4VItu9R?=
 =?us-ascii?Q?0evwjIJyYig0YPY8omiP9PkKcgpawJFc6HtgFl9o9wc6wxBLlcbmOI2j2usO?=
 =?us-ascii?Q?kYXmJPTpYk8IpDKXQhXwQ68nY1+AplMMN0UuD0JLGU34O5ByiaxNkZaFwVvR?=
 =?us-ascii?Q?mY2A/EQQIe00T6QAeCNLAibZVP1YcMsT7PD0rOSVvYwTroxkQbXwiOevwd9P?=
 =?us-ascii?Q?q6qB2LF2X/133y6uKwIMB/V7HLJtmJIL+SEnKOokgMVU5MkC2s8ae4Zd5Rnw?=
 =?us-ascii?Q?VJM7r9+wFrXtPW2hLDbs1WiurfLI5p3OAUvelNHFsnZ+5RLF5IleG2hwYptw?=
 =?us-ascii?Q?zZAoNzvyRRly7OoZrhaR8Zbm3Z45YhLFrv30nnLCHp+e6zhC3TGpckKeOYc8?=
 =?us-ascii?Q?8RN1cmco4alLAt3SmQk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ba488-9875-4eec-b5b1-08ddfd4e8c57
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 22:46:36.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEjs+3BHkQfoLSdfHzanKCg35csbxZMOtR9b2AX8NVP+YkplDTKablK076pxs7BQ8cMAUPrkNikQBz1Sa1TXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152

On Fri, Sep 26, 2025 at 03:25:21PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 26, 2025 at 03:08:30AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> > > On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org> On Tue, Sep 23, 2025 at
> > > > > 03:39:13PM +0800, Richard Zhu wrote:
> > > > > > The CLKREQ# is an open drain, active low signal that is
> > > > > > driven low by the card to request reference clock. It's an
> > > > > > optional signal added in PCIe CEM r4.0, sec 2. Thus, this
> > > > > > signal wouldn't be driven low if it's reserved.
> > > > > >
> > > > > > Since the reference clock controlled by CLKREQ# may be
> > > > > > required by i.MX PCIe host too. To make sure this clock is
> > > > > > ready even when the CLKREQ# isn't driven low by the card(e.x
> > > > > > the scenario described above), force CLKREQ# override active
> > > > > > low for i.MX PCIe host during initialization.
> > > > > >
> > > > > > The CLKREQ# override can be cleared safely when
> > > > > > supports-clkreq is present and PCIe link is up later.
> > > > > > Because the CLKREQ# would be driven low by the card at this
> > > > > > time.
> > > > >
> > > > > What happens if we clear the CLKREQ# override (so the host
> > > > > doesn't assert it), and the link is up but the card never
> > > > > asserts CLKREQ# (since it's an optional signal)?
> > > > >
> > > > > Does the i.MX host still work?
> > > >
> > > > The CLKREQ# override active low only be cleared when link is up
> > > > and supports-clkreq is present. In the other words, there is a
> > > > remote endpoint  device, and the CLKREQ# would be driven active
> > > > low by this endpoint device.
> > >
> > > Assume an endpoint designed to CEM r2.0.  CLKREQ# doesn't exist in
> > > CEM r2.0, so even if the endpoint is present and the link is up,
> > > the endpoint will not assert CLKREQ#.
> > >
> > > Will the i.MX host still work?
>
> > Yes, i.MX host still work.
> > If the endpoint designed to CEM r2.0, and CLKREQ# is reserved. The
> > property suppots-clkreq wouldn't present in this scenario. Thus, the
> > CLKREQ# override active low set by host driver wouldn't be cleared
> > later, although the link is up and an endpoint is present.
>
> Do you mean 'supports-clkreq' describes the *endpoint*, and you need
> to change the devicetree depending on which endpoint is connected?

It is NOT descript *endpoint*. supports-clkreq descript the board design,
which connect CLKREQ# signal. Because standard slot's CLKREQ# (PIN12) is
reserved in beggin, so some old PCIe card have not pull down this signal as
latest spec requirement.

PCIe Standard slot with INTEL E2000 1G ethernet card, which is producted
around 10 year ago, PIN12 is reserved.

So we don't set supports-clkreq for stardard PCI slot, only set it for
M.2 slot. So stardard PCI slot in imx95 evk can support most cards. We have
not vendor card lists, which already connect/not connect CLKREQ#, so we
have to fallback to disconnect CLKREQ# situation by clarm our evk board
have not connect CLKREQ# to make all card works, eventhough it lost power
save feature. work is more impantant then power saving.

>
> The schema says 'supports-clkreq' tells us whether CLKREQ# signal
> routing exists, not whether the downstream device actually supports
> CLKREQ#:
>
>   https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870ef1362bb711925f4f3/dtschema/schemas/pci/pci-bus-common.yaml#L155
>
> I don't see 'supports-clkreq' in any devicetree related to imx6, so
> I'm not sure this patch is needed yet.  Does it fix an existing
> problem?

The patch adding 'supports-clkreq' in dts is on going. No funtional broken
because it just impact l1ss power saving features.

>
> If it enables some future functionality, maybe we should defer it
> until we're actually ready to enable that functionality?

Actually, it fixes i.MX95 19x19 EVK second slot problem. At least
INTEL E2000 1G ethernet card can't work at i.MX95 EVK boards at main
stream kernel without this patch.

Frank
>
> Bjorn

