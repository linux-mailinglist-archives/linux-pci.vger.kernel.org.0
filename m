Return-Path: <linux-pci+bounces-37149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63642BA55F3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 00:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156D0625ADA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3629B8DD;
	Fri, 26 Sep 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyP4LoBi"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD781A238F;
	Fri, 26 Sep 2025 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927494; cv=fail; b=QsHahc2XqkNdKBWTE0DYy9LnCjewZTPeaEaZduq+Lc7seLSp86FULDMnzSyYTD4g54W9tQToP1rhR7+z4itXRWzNeZH7hfG71q163AEyhWWQghfPSHX6zGI4LdpD71cvkGIEz+AC4/bZCOM3MekJJzSSWT3SxyJgwRVxGgkvZrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927494; c=relaxed/simple;
	bh=/3k6jvwu2CHIcI1x4hiksE9vmbaRZw2AUWwpQwzkcYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nn7txRftbELhEq0xUlEkxOQyurmrs/kKEO/KU/A68yyJKS6mfvKSjfygGZr3M+kxY/vNy44VJBz4LIMRAhMsY/1bZf5EaQG9SciDM5ihhgaJmT5G4qeGGirnZxfDB36awEooslXZFyB19+zgxksJg+oz/vAmFJPCAtayS876Kp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AyP4LoBi; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2Qw6iEhfNq4gr8U2HdpROMjaFOF38hg2zTqu8zwZ+r9GNgyAAG7P6+wKwoMkSbsmEwK2YO6+cTq0ifzQ0xhRbSkwtl0zniuCG8cDHpzuxJARjPD/3EQQ13erkV4/DrAddWG8AoWFpAMiq5PeWsljN/0fmmc7V491TDSlGTxh+1bjDwvlyBPkEJydKvPIWFiEAisICbT7y+HwFbckbbuTCDxeLN2VfisRgyqPUag7uEWhn9So6MQR5CdV5O7phh22ma3p/Pp+mERdRhwXtrX4rxUQHMfNz8O8o/JWU7IYAFLDG+BoRVSHBbo8mv4eJbamosKGAwM94MUv9ckz37m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q52z9WknD5N5TorbcuE3ZfEEzdfAB2T2WFDBhZQHQD4=;
 b=YLqkrLfw37w7I5SGX4GEmMIPsPeKFISkqwEAvpK+D3OoIi3f3U9rMNwzzSmYqxCpT7WDEUnC56/MdLf1PUpADy2K+aqGN6UdUqL63e/2FPH7MeHk4q8795VnzFlZbM82XNSttXsE3eUxIhot5sN3DLd7AvtpStxb2576rUGgk//JohxaVexwER9SK8JZToND25bkoidXkLRCyim6IOXhUSa6vKFfnLV22SFFJgNKyfiupSaoyi4mZLUaOgeQk3EgfJMEW6CshY+gBpJtyax1LfQtmnJlLAGnzHN6rkacP7a6eTNlrrbaTwPv+xaIZO6VUCSM1jcB4gpiwJ3JVs5H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q52z9WknD5N5TorbcuE3ZfEEzdfAB2T2WFDBhZQHQD4=;
 b=AyP4LoBi/2VM1nudzmZQEhKqeHVhp1z/JKdtODHQp0t8gTs2HeC1ceVl3OaQt3qcwNN+IXv0/oxBj2IDe+MLAZrRNA/Np9AGlCxE3aTywf90aG3BIHC9D5guBi4E1JQcvBtCVtufcdyPz2nNn0ub5hkyL35hao8ID2toFMomnY7Mn5c5oC5IgcREgaHd26oBw0Rl/f33XtLeva8J6PV2ltqyT+enz/yCm85T9EKzYFiEUilrOXbSZj15ML+QsdFCkIIPJGGGWGHRWySY8CVMrbGkYmHyorgysRJLIxoGBnawIt4Y8Uo1LuuEi6I3ktbb85Xkv8iNVx0NyAbt4u3d3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10636.eurprd04.prod.outlook.com (2603:10a6:150:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 22:58:08 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 22:58:08 +0000
Date: Fri, 26 Sep 2025 18:58:00 -0400
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
Message-ID: <aNcaeGOEvDsSOFYM@lizhi-Precision-Tower-5810>
References: <AS8PR04MB88335EEF20BA7FCF723F81208C1EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20250926202431.GA2264754@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926202431.GA2264754@bhelgaas>
X-ClientProxiedBy: PH8PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10636:EE_
X-MS-Office365-Filtering-Correlation-Id: bd609bd4-42fe-4bd9-45ab-08ddfd5028c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiKfSXDqGShPhaelSuvr9ezbLsa3XSW83IteLZ9LRxdxdat2XRIp4zUKLA6e?=
 =?us-ascii?Q?lDa/mDU2A+743EXmaZZT3QcoB/9xziItUpL0m6l5noJ8o+ILYWMnK6Yygc6z?=
 =?us-ascii?Q?/VMbVirZGveH8pnkSmeAmMBemCaROkARNHHGirGQxwwAKB56Uuu6MZz0S0hp?=
 =?us-ascii?Q?ueCSd23MxCmPkTzc8xwvzXZkmrUbGssKpeL3/ax+/4bDEo90dzH3IPaNbKMx?=
 =?us-ascii?Q?W4gbdmEHq2+1HAxLjouSK0Z3AfezncAAbyKi0sQcre7nVedH6NOjnYWQLCf2?=
 =?us-ascii?Q?kVIm4n/i15YK4Kw/yLwgTRPmL0HHgCIJQUYLZu4CXnGHbdME7w84Ctd1ChJJ?=
 =?us-ascii?Q?+QjE98uNGxdB18l24AGbNl/Tb1KaQJI7wUhVm9qdbxsmeUecPSj+xVxhNuqs?=
 =?us-ascii?Q?QB7/pfzErtPlu5O9TXn6qzpKYv3wDsFYHzuEtB/sda59vxQjU4FDFX5SHA0I?=
 =?us-ascii?Q?I6pySYGWtfXJixv8rMlc4TluPdHBI9LjIOuQqEcuzO5VCyZv/7OdsuM1+1dN?=
 =?us-ascii?Q?yeHltDIEwB+i8DAjfrPxl2YA3/88Lv8N4HWBAutpKRLd4UHrOEQWTDkF0skj?=
 =?us-ascii?Q?E5HKq3FHbv/su8dCHLdHEx9Ri61gmTGQLBum37gZuyusQxrSfi+vrH9mUwYf?=
 =?us-ascii?Q?+mlMMe/cHUa9aOC+ElKIlFB+aFINKK5FuoHWS734EMsD4aEhyU84srT5d5ip?=
 =?us-ascii?Q?1tnCErve4oMHNV6f1aeHKGeWfeFw2jOo6OE1yMnzxNC14+Fkn6RdzCuEAdVH?=
 =?us-ascii?Q?J/pt2DFHvoCEg5RM2V0ZcfggiMxOoZTeOdPBMa+fEqItEBarFfMrfa8VwIKt?=
 =?us-ascii?Q?BIvAOPh2DH3k6QL0UjRaI/nsE4u1YTQKMhhKTNod9zKDp5BUB2F2pdnLQoyf?=
 =?us-ascii?Q?xn/zs0nNWBz6v7jm9yI+ufNw+DEEmjUwkUVHZvHEdDi4KsemU//xbL7Mhx2P?=
 =?us-ascii?Q?1Iep3+DaEGFAmSgPlAb2nRwiBOrB6h3ugYW7FnaLWn0GI6eoOwdhvrQl8mqD?=
 =?us-ascii?Q?JEP+H+u+KzLMLptcu8h3RD0wyKwfUuBzb7BMEqxsuNH/Q5fU8h4o9+n7osLh?=
 =?us-ascii?Q?XrImwlR0C6sTG2T7vHdUOXlGtMtUrmZFoX6rcx2RI9Jea8IieZtfsLn4Jg2m?=
 =?us-ascii?Q?OGA5ngjDTDXAeE/lSD9Mb1q9YMvIw1m3hFDpTPpvUebdta1eNxvPjw9uMRx1?=
 =?us-ascii?Q?Vti4eZ9dzrexQobmw2EkK4nZXS4PT4iLtKmBj5JeJjlbj3IlBXbhz+Rp8iT9?=
 =?us-ascii?Q?LlY4inaXjQ40msWpGyIdBHuUKNU5m8ewt45F5YfbSo+J8RW+kZRosJif7vAD?=
 =?us-ascii?Q?hh3TANcNmaH0/+L1W3/DaInqizOj70UVAcSvgFkPEwZPkdY97kI50kXi3sFy?=
 =?us-ascii?Q?Iz2hgZ23p0PtL4dXxuvY7btYGNvAo/FDjOuPqiGFAJJuGVqXKY5pe8tnQd63?=
 =?us-ascii?Q?LfU68rbWg59IS4IANxal3A2QIWiE/YpSNh+iWZIneBYfo3YaL/QlnpAe99Z3?=
 =?us-ascii?Q?dPkfD1T/cxvDkzJA/hHBaHoBX+BVcHro8Ygb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwN+h0mEbwmepzqLYodwtcsalUjczU0Gerj9Jm6kZPI8xWUIqu/ZUPk/HD/W?=
 =?us-ascii?Q?SdU7EqNkvrZYGat+Y4uElAYtXOWiKLomrR10FMVbv8PuORDoqTGbWIvdStrc?=
 =?us-ascii?Q?OM7ezPeWK/eJsrz0hhEnBxsoZ3RLyDYLB5pugPe4nYC34MfpNqKQNTR07b8A?=
 =?us-ascii?Q?LaKwPPZlKjTXloPrWunBEnio/4t/Kszg5cvTl2n1lOMgYezecCJXHv34tpII?=
 =?us-ascii?Q?FPRwINqIk8EXosxQY+14ZZIgZwz79dYzwSEyhDXiHqI4ZDIlJJ0Dhz9Aww2a?=
 =?us-ascii?Q?ooyq/u5bDwZSOb3VNKgzA3dq/H7W6NNJPk0T9P7B1gG+r428XgfKuZHet0ET?=
 =?us-ascii?Q?asPP3m2wULER1L+Y6sGpfvDsR4gxbcmlF5vhkxR/hldjcto0S5kycpaT/cOw?=
 =?us-ascii?Q?AaJIc4z7SOUKlXo8I8rr5QlhHo2nJY1R44HWg3Sm7wXsVriEcB352LAFKrTH?=
 =?us-ascii?Q?JjS1K2M9ZPTDJWUYtY7Cg955njX0RyjgUIZn/kQMULA9pjpv9PvxuBnFMyFr?=
 =?us-ascii?Q?9cLp462m1m+smg1wXeuX9KfPeDYg9Z7tnqzJ32WGMEVSPH66hhrPxYKgHJJb?=
 =?us-ascii?Q?Uh2QPhWf8k4g0iL2CRUUuVBbBbeTd1QK4wKfXI/to/OjyI88UY9IshrYXVFd?=
 =?us-ascii?Q?0Q9P/8CPGsEon4otgAQdwSVw3blkEfOxx28pLo0XzIA82u0hqL7Y8r0amv8R?=
 =?us-ascii?Q?GOV2tkgYNOpjJUzThhdXhuOxrIYTel7wNYK68vSUYr0m4CyAV/iKZRTR2AKz?=
 =?us-ascii?Q?MJ9qDMXDKqi9Fs8f4ItwCmnd/fOk936Ax6xLm5s5HwdiPg+dXk07KePm98Rr?=
 =?us-ascii?Q?Jy2aGDv8vzAfLfwdvQuYRh+t4uQx8AyNceCx6Eo4e+LbJe8NumJaAB1sK0wK?=
 =?us-ascii?Q?/lOjEYY32R+VPSzfuUCpHnT4yYdthZvISlQIJWgn2I90mCHTbqDDxjJPkMAA?=
 =?us-ascii?Q?UTQ8SClCf6aYwzT7EalxF0vlkyh5XZSFoFOIVbXR93dkkw4659YbCGYYmx8B?=
 =?us-ascii?Q?JVLTA7r24DhJjeVodaB2oC6AKXDi3kVCR+03qLLAgYQ/ZPEaKAIH6t+RebZw?=
 =?us-ascii?Q?/s1vRckBhis/39mS4xyvXh7F3mKsD55Jbn8gfjwZ3vgxsaK2xFesBvVg2v9i?=
 =?us-ascii?Q?WgHTj20NZq/KjMtCfp4WZZ2UhnqGhft0mjTHgwyYXfJv28y4nnEGTniSST/z?=
 =?us-ascii?Q?wbpfibcM4SIM5waRAESgiX3vX5QTowlTx3N1msbJ5Op+hchlJ7WNmHMTF50l?=
 =?us-ascii?Q?4ENOd0CIkMAHtROI3eTk+JraaoRJOQRLXzlL5v93XZMxpxoIkcBop/l/M5FV?=
 =?us-ascii?Q?LHXXRWHjpTzs8fh1/P529t2KpOuefQN0TJPPxYtatRY1LQRc1FLzNCYDVfvi?=
 =?us-ascii?Q?kqb3o1zyExjAvVr4neDAKTxtHi3aZFySDefGUtaR2SbeOuzXMHTNr/nTybUS?=
 =?us-ascii?Q?SzpS76NKG2xq/auO3mLmsQjD7Ha09Qtc3QEND2uTM68ZAVWhJiBsgME8opeF?=
 =?us-ascii?Q?kqMV1dc7EAtFykQSiPW0BKZX4MZ1IJLcbFj7zyLRdfdLb9nCpZ0R3DuNVppG?=
 =?us-ascii?Q?SYti9XEMFj9605Wuz7B7TL1ttB+aABZMYomvZcrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd609bd4-42fe-4bd9-45ab-08ddfd5028c7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 22:58:08.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3j1Qr4YufBS9uI4RGosUCX5dB7dDdyFj6SmY86h8o1ht+joKIoB1GSoR+NuJZeh8jTYKqvw9JoOJFUKRa5SrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10636

On Fri, Sep 26, 2025 at 03:24:31PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 26, 2025 at 03:23:43AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> > > On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org> On Tue, Sep 23, 2025 at
> > > > > 03:39:13PM +0800, Richard Zhu wrote:
> > > > > > The CLKREQ# is an open drain, active low signal that is driven low
> > > > > > by the card to request reference clock. It's an optional signal
> > > > > > added in PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be
> > > > > > driven low if it's reserved.
> > > > > >
> > > > > > Since the reference clock controlled by CLKREQ# may be required by
> > > > > > i.MX PCIe host too. To make sure this clock is ready even when the
> > > > > > CLKREQ# isn't driven low by the card(e.x the scenario described
> > > > > > above), force CLKREQ# override active low for i.MX PCIe host
> > > > > > during initialization.
> > > > > >
> > > > > > The CLKREQ# override can be cleared safely when supports-clkreq is
> > > > > > present and PCIe link is up later. Because the CLKREQ# would be
> > > > > > driven low by the card at this time.
> > > > >
> > > > > What happens if we clear the CLKREQ# override (so the host doesn't
> > > > > assert it), and the link is up but the card never asserts CLKREQ#
> > > > > (since it's an optional signal)?
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
> > >
> > > IIUC, CLKREQ# is required for ASPM L1 PM Substates.  Maybe the
> > > CLKREQ# override should only be cleared if the endpoint advertises
> > > L1 PM Substates support?
> >
> > CLKREQ# override active low only be cleared when the endpoint
> > advertises that it has L1 PM Substates support or it always drives
> > CLKREQ# low.
>
> What?  That's not what the patch does.  It calls .clr_clkreq_override()
> whenever the link is up and devicetree contains 'support-clkreq'.
>
> A device advertises L1 PM Substates support by putting the L1 PM
> Substates Capability in its config space.

Regardless L1SS state, EP will pull down CLKREQ# by spec requirement.
'support-clkreq' indicate board design connect this signal, so host needn't
force it to low.

Additional support-clkreq require use open drain to connect both EP and RC's
CLKREQ#, some old board design use OR gate, which should not claim
support-clkreq.

The key point if CLKREQ# is connected. If clkreq# connected between EP
and RC, we can release override.

Frank

>
> > > > > > static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> > > > > >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > > > > >  		dw_pcie_dbi_ro_wr_dis(pci);
> > > > > >  	}
> > > > > > +
> > > > > > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > > > > > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > > > > > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > > > > > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> > > > > > +	}

