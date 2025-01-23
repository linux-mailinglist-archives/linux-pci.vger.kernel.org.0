Return-Path: <linux-pci+bounces-20304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB9A1AA25
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6090C1666A9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246AD1BD9E7;
	Thu, 23 Jan 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="edTmdIEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF915ECD7;
	Thu, 23 Jan 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659725; cv=fail; b=bjsUGSAjf2cx6ow9/Og8vH7PaPjVk+u78CFiXaE6oA+OCM9uEcxK7mwM5qaqxV1wGxxpJk2qE2okfgyQFdUmF6PGPJF0RyvIUBss6VkntKW0ufYpthFhbs4zbOD2aarRlit90q1QLjUEW+t+BHXTo65R0GAeT21IE6boN0KLD8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659725; c=relaxed/simple;
	bh=S1yr678ezWPo3ClMIVmgcrU1oiryCdYSL8KG3XN9h04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EP3GC2guuKHv+smLetLuw53Dajp0oFqKq9ef6I778cNKj2ZnaGxJ8Iy97DCcbb0wSOM0861cenxtCyVJwAJv2ohVWXyPRwZz0fvTFs0OjPnx5W6NMk6GpPhR83YzNiUqPrsW/u0QB2t6FgZJYIixX5abp7ArJb8XLv9LNnRYG28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=edTmdIEQ; arc=fail smtp.client-ip=40.107.249.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOoLkoiLVFdwljJ+ytyI1K8QohB95A3TAANFPxwNThDunKMWgan1kgxef73N5QnpFIgb0uZLVkc8AngqausJ8v/9iI6Qp1CkXuk0UCXK7TAOsu9Ag7ur9tbeGGV6xrd+5k5Tj1ua6j+LXGdJxcdZ9y8QBMRoWq5c8Pc6fxGKPD/KdQV7JdWlUCcNDaBlE7rCrJoch07UEtcj2s0mp2Bqv4ecjnrkgZ4twz/tN1Z5BNkgypoVHALSArlBWkRjx6U/xF2hs52AL5y9ncmV/T/I+D7unFKkfLQEkjN8kxdNmgiW4wCBv6WzcJtBJmOuh2yPwQBQ2tBkGyCJbO5wW/tqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEChO8CfT9er1OzC+iE2ALg9AVGN8eE8N6fJbM5jCWM=;
 b=vD0nKZ3+Cx9RA+HTnAG37lRrDhdhxTw7wDWNzOP8Urod+1yB//cPW3EwqKuDNUFLrremHcqJYKpdUIgWaJr1GUDT9Hms4AfpFRlRzCtB/jUPpUoGSdYxxsw2mmrqiGME32AWblARmfiFuGCb6Tqk8Rx9tF3G4YDGcl63uV8VZwHNVfuzyEaSVky+oqHA2otND8BYctrEyAFe0BSDJX/3APZMDpA1TOkOm+phiDho/LCCfLfLsz5FKLHLWW1Da+iuPr1jwCpesoAbqyERDUgceTSrTPFlUJMApu2MpIsBmD/dPPbOo9yRR1X0BR8+bFtpXEEQwa3O5ThdhaxCyFhoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEChO8CfT9er1OzC+iE2ALg9AVGN8eE8N6fJbM5jCWM=;
 b=edTmdIEQXrXzbTfAbBuHYFPiKRVZ/AHDMNW/XogGN0MXeTed4+G0ah89gT3l1avkRBde5jGhQgVb1NSRDoEyMw97tswjIAlVjeoiPLGNuzfqQaxQrNoV9Z1v5e7swrVHADfLOGiY8RzNehr6q5I7wVsAGzsXD8Ex23HLurwv5UR5HGZXtxhTkL//NGXj5efSvPM5XUOx5i7HgXWEvgisAma26xuZqGJ4r3DRWE+LUvQjfkqdJ40l/kb7WmJuDy//Lh16HvQr0lOmLnRYaxTAi7STCEIKf5d/EKrzf/8oGexxjJjtxhMQtLYU0bvHQFDfkQPMiuVQeVm9n9MpS4yfmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10870.eurprd04.prod.outlook.com (2603:10a6:150:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 19:15:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:15:20 +0000
Date: Thu, 23 Jan 2025 14:15:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <Z5KVPg/DuJHci/77@lizhi-Precision-Tower-5810>
References: <Z5JegF7i3Ig2pLYB@lizhi-Precision-Tower-5810>
 <20250123190422.GA1215672@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123190422.GA1215672@bhelgaas>
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10870:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fafe5fa-f8a3-4e55-1039-08dd3be24735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTECq5qcZIrYqKsh+v4XHFHGwSKGgU2PQRkR4Y21vPjSnCHPYhtNiuMXLOpw?=
 =?us-ascii?Q?MqdgiZz6kRI8AH5hK9onATdw45+eXUtJydwOlfThM3A3IxW8KnPsvDR9Wfj/?=
 =?us-ascii?Q?vFQehDh4V423ZVmfPu3Ro9CSI9HmH1rn00qj21FzZAshmtL5dub+wOzCcCQn?=
 =?us-ascii?Q?ACBNf1Hsy2GPevnFTiYX9wG+ptZePjvTCmJHnJJFvKppgqlihBFXw9otyT9M?=
 =?us-ascii?Q?7A/cj5EAwCAdMrkU4L0kM78UR2zuG2scwhOTTVgAH/1qy491Xb1ZUvZ09C9Y?=
 =?us-ascii?Q?xwtw/VL2GBT6Ma/YPD0dKTqKWAUNYrgWXf8QdcQRCc3VJUd8J02IiJUE4Txm?=
 =?us-ascii?Q?f2J5kLH+IgmiHCGNzQSoN7D2sqgQiZuvUH9BBemv3FifXpAsW+ErDFGANs9V?=
 =?us-ascii?Q?PIeE4Q2VSddZfO1n0wyqv86aXcwfhEy9fV61BPBPxgT6UXUR+mnEpRwK0sm4?=
 =?us-ascii?Q?667qdej+bi+9gamKuj/biQGKZJ7uZJU9c8hG7GQnYjk/3gfz7L7Jn1jS5CET?=
 =?us-ascii?Q?NdU3LbvSGMmfM7j1OGsBZclgifUXe442ykeljWal6Gz1rBG3Kol+IoijevJq?=
 =?us-ascii?Q?8NRVyf8MB69nbMHalzycz+mAv6VbO+3rMARMEhQpPn8XX9maz8JlpER9Evor?=
 =?us-ascii?Q?mfE4JZRoaBzb8TI8MaVlG1iotytRwz58b8KLmci5l7GtKzwp0pxsiLRQof+7?=
 =?us-ascii?Q?xFCJ4CURlHV/dDzHm03sTgJGrkgznXXR1Ucb4y28Dc1ffksmjRhJpIG0l8e+?=
 =?us-ascii?Q?4Owo1WQMccuDjciyVNsM93iyDR0cYYoCvp4cUtuMCO3xVP3mSTIKYCPmE/SH?=
 =?us-ascii?Q?eDrodJjW1gvvF7x+D8YbIxvvGTXKj0Yh8/6wwLiTyQy3cRWI7jLnuvjJdsE1?=
 =?us-ascii?Q?V6NsF3C+NxJEQoVIYuGT+euxgEpjEVN/mrz3Jfp2equ1U5vR6JKLeHBpXalx?=
 =?us-ascii?Q?MUPj0T6hPkzsbPuZGc+kLcHScB7Q4DcwkmviQ9ITMH6kgbvSMXJ73d7W1p3m?=
 =?us-ascii?Q?lDclAL9O9FJudTgK7KgCNTZxlKnOPT1HSRBuXkPYDxjIlD3x6cgk0KX+8u17?=
 =?us-ascii?Q?OwFlrmYrGw7YRzg5RWWHn4GPV2GZLP3FjGNhbxi89ook5uaHX6C9ao9c1/JL?=
 =?us-ascii?Q?r+N9LjPDWCihwjB92HbplwpX265/z2uu03wQFtEVQ3qUbbcyHjvgDQQNb4K7?=
 =?us-ascii?Q?HASyISrm3iWxY9f6MLeUjxRwnyiw8PrPFiSxkzwzWX1A5k663KU+OwDb8XEH?=
 =?us-ascii?Q?XeRk1Gv3zTBit7yFCOotha76TOtenYTQohAHoZ+PprmKPzq2tONyLkgqTFII?=
 =?us-ascii?Q?G4aA2rNG2d1AUtmzTYzBBS0SvMO0UExoV23yRFeSWMPf66XrFmpX6vrSEXDj?=
 =?us-ascii?Q?G+mM2elUSxvDI1d1V13TL+ZuAwr8pPycfuZLM39YTsHq+6vA/nihPuvcmB+H?=
 =?us-ascii?Q?9ke4X2vqjnJe/9dNWVKSjk626Bf324IW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HrtsvTZPGXcPrgR5x8F0Hw6GIaPTCqpYgt//U9uv6p1IJfejWzNWdJ1cd1R4?=
 =?us-ascii?Q?CQxixHYFOzA712qiv26ZRvUXL+w1uDZ7TvGNBVz4+5XWGiMXemhD3A7+sGRG?=
 =?us-ascii?Q?wvNMQnccvoyL7DUoXZr0ZIsCp3V7rQmVjDP+CVFKVpNIk6dS11sUndROOuBO?=
 =?us-ascii?Q?TuMyxdh5phARQ+FY7+DjPn7BXhxXrf0+Bga6bJyHnXkSAIFBpZ5xLvLbfKC5?=
 =?us-ascii?Q?ofmAO1KTqcmWqOmeNL3KIeDmIvfegxxeT0PmpjkH4SilVi8/ZqZYcI9B9wqT?=
 =?us-ascii?Q?VYZKo/OLfT/G9ldvPYUEfy9BwARpMLFf+D9rmWIBD3JWg5pXpVCzT5KCvhvT?=
 =?us-ascii?Q?pzgTSbGEPFHAcNKfcFDYitqtc8Aenp5mjU+0aUkvPk5M9RID7SBm8mTMCHGv?=
 =?us-ascii?Q?xpJYOd/4DBNecHmW31rYNsLVdaddfwlsWKJmvGwBOYo3CvZpPWfxl/0tfHv/?=
 =?us-ascii?Q?6BQk9Lz2GobavIruahbi4BmcYOvrbK7I9CI1XRLx0rqM0PzmMbLtAsmwjUF0?=
 =?us-ascii?Q?+PV0zkKRcgY0SLog5mvAzewbqflz26Ul6pRKMscmSs3ruS/fqfoBX+7N6fcy?=
 =?us-ascii?Q?YBnyhMCZkApMx8UyYmV7e94iSIEJOjNnQXV7On2d+d7D50Ri7lq38fzMiBa8?=
 =?us-ascii?Q?nFxP01ZKaBTWo3b6oLfuyqH47YD/Lo3ZVS5IMhXMT5V+ZiJMbr3Er4tTApBB?=
 =?us-ascii?Q?a/Ya/3cw8DnmX1i2GV+PG4NOg0K8I0fU5hzWqHqePhhTUGZCQ7D3I6/VQGib?=
 =?us-ascii?Q?DpCmLZtmtzyeH6qYsyFexZBw5whRczD3DiC/55MmzWhMk6HE2k/QIKH4qLhs?=
 =?us-ascii?Q?7q17aEuGHPjLFfcVW+eksl3SgFU5pkUBMKrOnIk7nSV5o0qGfVYeeYfYUD2V?=
 =?us-ascii?Q?S6xneAbUNt6ZIHHUqUbfAnNfJ7BgWxkIM2ZWR9AQJvhPEDGfnXbBsR2wDyqy?=
 =?us-ascii?Q?F6DOyagPGGxhhSlNLUscBHBfnQh+2aNJFdmlMORlgRQ7ABl6axxp2FQlsgG8?=
 =?us-ascii?Q?RKctND+ghGOQdFl+H3ifBgZ0I5qOooQIiNuE4lth7BzzSpD6VWZ+w9atBgYv?=
 =?us-ascii?Q?7l+1K48vbt/smqjQorMNpI1qQ6yNc/NPti+J/4COkrnCx0lSv7JyQYejEkjt?=
 =?us-ascii?Q?bCzywRYp3c2AVLYjnUgFgqUqFkfDJnDG3czDSSBPut/XAM+EyCK1LUwn/vDo?=
 =?us-ascii?Q?pMr01SySl5nsfCHVUGtzTIFxsp6A3iLFRNCKGX8EWKvAcyRvhig5pILQ0dUi?=
 =?us-ascii?Q?ivP/AYCIzmDVWJ6L2mslrW5um/Hnd5oMH63AowftT+ysHyYCUKFDaFghYg27?=
 =?us-ascii?Q?ZvZncrlpKjWimLZz1lkmtlw06YihB/HKr9bV7sLnl6XK5LrPJhDYlEzxAN+J?=
 =?us-ascii?Q?Idmt4ATg16jOvRmdJ5LBnL1WEp05k36cnScu3Y5J9dwrGM0777JAYo2qXLAI?=
 =?us-ascii?Q?Jg3a3zAZQ6M4MCGxpWHhS6UEZLgsY7J6g6HmiM8gi6GS0ihMvW9zNU37LKcx?=
 =?us-ascii?Q?V3pjZGJc2YzdrpGlJqxwZ3ckYfUqPCkBNY8SXWkntchxmz0D/el34w3GEHFJ?=
 =?us-ascii?Q?m71e2YhaRk7aEcclMQ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fafe5fa-f8a3-4e55-1039-08dd3be24735
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:15:20.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bIE/DD0s2RyIuw6lsVlyt+EQFdJNpBxE1z9ZRMRxWBpp5XNZG0yuXOsXjEYR/ykIgGjFcMFnqYY/Khi5Pdgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10870

On Thu, Jan 23, 2025 at 01:04:22PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 23, 2025 at 10:21:36AM -0500, Frank Li wrote:
> > On Fri, Jan 17, 2025 at 10:42:37AM -0500, Frank Li wrote:
> > > On Thu, Jan 16, 2025 at 05:29:16PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > > > > > parent_bus_addr in struct of_range can indicate address information just
> > > > > > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > > > > > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > > > > > map.
> > ...
>
> > 	I saw you have not picked all of these patches during you rework
> > pci git branches.
> >
> > 	I know you are busy, do you have chance to pick left patch for 6.14.
>
> This series had a mix of things: several patches related to
> .cpu_addr_fixup(), plus several unrelated ones for PHY mode and i.MX8Q
> support.  I think I picked up all the unrelated ones.
>
> .cpu_addr_fixup() is a generic problem that affects dwc (dra7xx, imx6,
> artpec6, intel-gw, visconti), cadence (cadence-plat), and now
> apparently microchip.
>
> I deferred these because I'm hoping we can come up with a more generic
> solution that's easier to apply across all these cases.  I don't
> really want to merge something that immediately needs to be reworked
> for other drivers.
>
> A few of the things I wonder about:
>
>   - dw_pcie_get_parent_addr() has no DWC dependencies, so it doesn't
>     make sense to me to have it be DWC-specific and copy and pasted
>     to other places that need something similar.
>
>   - It doesn't seem elegant to iterate through for_each_pci_range() in
>     devm_of_pci_get_host_bridge_resources(), then again in
>     dw_pcie_host_init() for io_bus_addr, then again in
>     dw_pcie_iatu_setup() for each window.  Maybe that's the best we
>     can do, but maybe there's a way to capture what we need on the
>     first time through.
>
>   - The connection between .cpu_addr_fixup() and use_parent_dt_ranges
>     is clear in the patches remove a .cpu_addr_fixup(), but not in the
>     DWC patches on the other end.
>
>   - Ideally, "use_parent_dt_ranges" would be the default and we
>     wouldn't have a flag to indicate that, and drivers would have to
>     opt out instead of opt in.  They basically already do that by
>     implementing .cpu_addr_fixup(), so maybe we can take advantage of
>     that fact.

Okay, thanks. let me think how to improve it after 6.14.

Frank
>
> Bjorn

