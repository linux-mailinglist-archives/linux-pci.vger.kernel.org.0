Return-Path: <linux-pci+bounces-23129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC7A56C25
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0451118975A1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4395621ABDA;
	Fri,  7 Mar 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYx0ceUO"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DA21D3E0;
	Fri,  7 Mar 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361574; cv=fail; b=Wdw7YQv1PPWS2s0UqjiFT9Uvqe+sEStEZr/+ks3h30iYqFEtKAtIjX5pQ0UAWxIorrDvND0c1SAX42Dz3bCikY1BtUoeOF6pTGiCel3f6A9cB6wlm7rB5a+D1ezB99W3NlNraD5v5R6DZvDpFYVzzrbTOuAZMUe/l0H0EMEuz0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361574; c=relaxed/simple;
	bh=hiw1nL6VlVUnguCuav0wCBHDyHJBCCFwKWfe2K7hu5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAJsjOaURqeKBVIWqW5gUer0a2UwkzAvYQxYIDkt+QWGTB3O3+KY5DlpXwdlswTEZfHylhnY5lUHzzZhZLQyx2FuOi6CR0OZtsiEnf8kuNNEgBnb/BbGwTS+UBo9pLvoS/1ppgT/38KSumWR3XFtVNmu1tdFTOlvD8BoFv6lzwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYx0ceUO; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCpLHIBcxO1NcTqznDJyrkk5fVCPbxrWgX+huZ8ajnLDRzRXOZiHYEO9fQy+Wt5l++WSPZjqC/PA3AEIqATit6lGx9h+HJBaygtAUjdaPI+MgLDYVQBjYEYX0zMqCfhrDsBxnvxb+w5eXRNWRI/u+f+8j7LE/eNzSVVgVEDzkDwl4x1Yv3524Wc4H7Tyfmhq0g5QKwC+OgYvFQuL+0go70y4ef3DAVKH60dj8Ad6wy3IW/dpg1tbvwgY6FndRCPRXuxxIfIx3ViT2TSpLAFZw86yKiMKUbZmm/ROEo7SeO0J+gv2a1G3+XtjFEUi30Bk35onMT1Dq0SUtZJAqg+3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOQlXyzhtHsrVIFymgPKClWNdiOOU+3Pu+dBbv/8Oyg=;
 b=ug3bNBvtmc0CKv3n2aI9XTXMmestp+aPzL700wllJh9jw/BxLCsyjoJUlpqKHHb/eLUx8lRSe281idxeGA04X2c+ljjJmsujf3pNStHfwXBBekYhwKms+ujyq/mysU8Z2qSrcdjdTzlYWhW4PGFNrzXtKx6P4PU4p4pCRT2x/6yx49B5CYFxHjyfsCx8R4ByCx/KO6OBf5V7KO1niGNloV6MunY2j8/pejg2+7lEr7DVy8J5+09F5QhDJBnYFlzOSnIW3IxpU0YpzHlq2aG2Npjzts/sYgNcOJdd692V3QD30jXRNHzsp5X4jmna5dVO6v09z0n2NRG/HSlZRhF+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOQlXyzhtHsrVIFymgPKClWNdiOOU+3Pu+dBbv/8Oyg=;
 b=DYx0ceUOSI0/QBdl7aHQoeRZebNEOuyaF7ZlpBYyIRMOxqQp1LBkrzKPGZK3yUfn3LtucEUrDkPXVEe5vf+dnfcxLjg2IB7m1GPdrY0asZk2UbEIBn9d5h3UiPewjbZ/3QJXH0gdWafw2QkLhw3sfiNW/nCybS0K7m3+NbqnYASDDr7okoy6EqNsNuQRalvR9htjefT/qojdZG6chFtHkwIF4EOx8dkZbllr1Dt5XpNQgzedFBg70emYpGFqG/zfKCItAX2qKYnATXiQkYitGfJhZcQs3ZjCGMs0Pmi+bx3/njWgypE1uk5bshZOBBNgrHJuSZxNMzUqvSuGGNoqjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7128.eurprd04.prod.outlook.com (2603:10a6:20b:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:32:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:32:48 +0000
Date: Fri, 7 Mar 2025 10:32:39 -0500
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <Z8sRl1c//SZXKhB+@lizhi-Precision-Tower-5810>
References: <Z8YlySM6Xtr0beo1@lizhi-Precision-Tower-5810>
 <20250304175010.GA207565@bhelgaas>
 <Z8d6qpNaL4eJRQI1@lizhi-Precision-Tower-5810>
 <Z8d96Qbggv117LlO@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8d96Qbggv117LlO@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e8fba4-6496-441a-6f0d-08dd5d8d50df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x6fvXlindH/ilyWA9QjBf/TdIqp9gy94vUhgv0rhCGp9myZlzr/Ktu6/383d?=
 =?us-ascii?Q?6AU6ZpY+YLZZe6dCvG4GRk7qvhgfsyELgg97u8aifxbwbUSEk12UNT27XRxj?=
 =?us-ascii?Q?FnwevayIXABYGf3BKPvkodHYTh8ABinMH3dpqa+4L+u/IOv1Xz4QcZADERaT?=
 =?us-ascii?Q?zx4aLO29ZqIiz068nCAn20eDyniwlgyrzjmV+y1xX4ZxTMypmVjeNWmXHP3t?=
 =?us-ascii?Q?LCUklX5vIK7YiwSOU6dj3IYOT7MbqJWI6ugy6aQYEck3DFEkF0Gx1DL+gdmq?=
 =?us-ascii?Q?G/w0+L3fpQNZ+9iM4AL9Exf0oPYy5wMwNFB3NbEQnNDAyeJ14sGdSV0BBRHp?=
 =?us-ascii?Q?KwWy+d0EvxIGrlE+qsW/WkuFqdPpBxofmxVa9EtEDucpWZ1YKmeVyRUEXwHc?=
 =?us-ascii?Q?5zpamQBthloUUh2NYVhskYmmR4WgaCo+RCRUWWkwSSeCBWs53pMxBfsrGC2R?=
 =?us-ascii?Q?fv9D0Il7hlK2bdhjTNaYwXYmOR+yw3AvKWvigIsfWBUSmhlTTrTPuwiQRQyI?=
 =?us-ascii?Q?0kh/hZ8X+a8m0SqWoAeBexKpr85adWeHdxLC/bM+r6SyElKX/b2izmq7jTXz?=
 =?us-ascii?Q?sJW9VqXw2nIU4m9Lpkuv4V3j/ZEpNntVo8RtQdVDHZETxgTugbKZ98B+zZpV?=
 =?us-ascii?Q?FjcS/SbryTkWeWwyKTVwTkaGlIAc/qmrbhnH34fX+XyNRGobtiOvVrFr4QeU?=
 =?us-ascii?Q?AtMNLoci0wqRuJ9FhAwHex7IedIYxkzXVvPRBGsBIVKwlMyKkArjxSyvI7Vd?=
 =?us-ascii?Q?nj7XKN8BPTGKr+zuY160FnNRA0flBGDffZ3XPsndaZe63R1rrEOeQ+Ss/yuZ?=
 =?us-ascii?Q?jpmYaElQ3e69ku0hmq7wz9Rf8YzE3XHK+TZZVOLYs+UKaHZLl1PcOf6fV07C?=
 =?us-ascii?Q?KRumKT9iikTY5dzxe35ThGLvv6ILGUfiwsoCYe7NF0m9U6EaNcqrt6qLVhxi?=
 =?us-ascii?Q?cpF8K1OB6nCX1dvJ6qDLv2iGQpO1xtfjJAfT1lseOVQt0UmlZrR/0o3RrsND?=
 =?us-ascii?Q?G/NuGHnikwtVxnJoKzu5UPbg5K98wvoTLWa+xlKwhKqZeNG1XaBHGGMCP609?=
 =?us-ascii?Q?KDXrzqIS2/XoFk/RkpqXGrH2ooVLNQXduhitDUnbre4s4aYW4vUZwcTanLo8?=
 =?us-ascii?Q?YD5CZrNs2d4CzjTwrcraJ4o1JafiNs6r7wGSXEm9lkOcBojMP++HyjdTRSUH?=
 =?us-ascii?Q?M/OVfVxOFwobwdmkIN3DjEBEEpBa0x1h31JsP2KV6oBInfA2PT29V2ToeMpk?=
 =?us-ascii?Q?4FagA9+IG+nbFkKxKKQDS9ZyKrOHJer1H4nMhJrpslCjXRN6lM/1aNq864D8?=
 =?us-ascii?Q?cH5PZEHzZTma1Lt7/p+2WXMd8oqTPTN7YTFs6xxkWHiGqe3xXJIC95ZWoorA?=
 =?us-ascii?Q?ug7BIQIn6Dge49nLavKugkda1IYx2xoMAipjY+ISYRMtdciuF8VofFhS5knB?=
 =?us-ascii?Q?17pAG1LYN9WESB+GpDaMZDL0eDe5QpVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+ieyhrylqb91jEISVtZtRpkNCUpWfXNjWo5ei3KndHh9vQ9mOFhSC7fpHsg?=
 =?us-ascii?Q?/W9J3VyiXtgUGBjuO1476jk7CRUH/NdfQO8zsQBBo5nSSk1B1z5nIRxdI4kl?=
 =?us-ascii?Q?K1zLDHIxVF4mQ/5Mpcil1o1tWlw4i8zy2tve3Fa5C6BTIPDKryscDobqhnE/?=
 =?us-ascii?Q?U0kTSPiwBPLadwPxzlSlokWXiZY43D5IMUbB5MzrSvj65RqBsmSxlJxr9aGP?=
 =?us-ascii?Q?v6cw6gWLm7OnMRX4cOSnbpTdAVM6I4tgyijvmpOoNeysbZwA/zTLTJm0mFq+?=
 =?us-ascii?Q?cPtNLBUaiZvHaSCTtQRk6HPw/pckFUwDEZgSyiKKrJt+8tMloNNNMZEPBqeu?=
 =?us-ascii?Q?pL8xAKynxyvKbBO00+PbypNbh5nZTrLd7A932BbUGTWujE6jNPhmWHp6sIqC?=
 =?us-ascii?Q?nZ5MzmIB7zH4B9mBlts5ZqQVAchtSg1bxneS7vqOY2XbFO7eGMNbGkGTYVYt?=
 =?us-ascii?Q?jUN7O5bBT0bHQ/SRXErjB63H17AubT+dx/EE7+DPGJSRbqma9lpgvELpWrcV?=
 =?us-ascii?Q?A6QUEJVMOwcGhuIBA8f2V6skQRkAtqt2oUmsfSnqOXxVZGR59kGfmZgyhLIZ?=
 =?us-ascii?Q?MJ8mmlKcNSSYtISSeLzl7WGjr7vYJaAJjcrezaEWQ45EshDHlvnnk6vIbLAw?=
 =?us-ascii?Q?UlCtVnUYmy+IlNgkr0NUQK8Kja4LJaJQ7I5zfPpm5CZwvmLC7++12805qeon?=
 =?us-ascii?Q?DOi7TIPMqmfiztJ9haQmAh1FvtE6NsL1V2gH6tD60zI1JVs1wgtPGnHTrPfU?=
 =?us-ascii?Q?LMEmQkkbq9vajINLNRCYmRpcf9jd9nXR/65n03mYdEJ40rgzZBkxmIyM96fn?=
 =?us-ascii?Q?KTtkvZgYFRuzY7/NSEDMufRkfo2NJ1iPH5sin8k+iiO43UxgjPWUBTcfc0qA?=
 =?us-ascii?Q?N4QYIpVXn/q6OojsphBgUFHoJ85UE1drecmQFu0GFmcNcnOQJ+Vf+oO2zdg8?=
 =?us-ascii?Q?UkM8YPshXrc/9KGvHi0ez3TUVFDfjyhzYxKD+he1jQenNJb1R9Tanb2Z2atW?=
 =?us-ascii?Q?0+sUmJDGQtu8lrGkQHzt7gXD6n1p6zDTAoHD6eqNUeLBA19jD+iz634GEIbr?=
 =?us-ascii?Q?qaRFh/YEkK27OlfwmAll6SB2KsD0tdxMLdYtVpy6BHCYRPgmn222NNaftFUR?=
 =?us-ascii?Q?TwgaJeRkisQtLUqrF9wP2Ov9sk2kGDnOFOFyE0hcyUFLXwS1Sh0dL8jagDXb?=
 =?us-ascii?Q?9yCs9+oO8aE9WztBBJI25uLKGlCRnOquODNBZtbasL/OO0H7GtTPHJQg3F9e?=
 =?us-ascii?Q?Te4GB6CMlw7yc827MNv5FrgqFeS3l0V1AQYoW+gKVkis4WTm7T4/QJ23TzMf?=
 =?us-ascii?Q?6zL+Fm9uqC28QEJ1/KmWTooaRV4uQckavQRUQRMPKDWyyPEOyji/wZpptxRG?=
 =?us-ascii?Q?Z8lWW+7FC+ozCE7aSy93hfDaWbBwWnpy6ALO7+21vy8EwPiwz6X9NxdqUy9V?=
 =?us-ascii?Q?fw81BnVQjyWGf9ie+dRQSi5WnOxFrAJulsY4W3i29SFp9F5zfUQi0FM39LcX?=
 =?us-ascii?Q?tP2nyJWqH5TFRhQ6fcguP/2evD6VzR/Y4mwQHFARazDkCvDfJNze6qm5pDw9?=
 =?us-ascii?Q?46sXxdQdfVAFVx0iCeD9C2Ni203iK42euPmWe8Zy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e8fba4-6496-441a-6f0d-08dd5d8d50df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:32:48.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPwP82bg1tBT3WyLIV7QTSqxeFYT1Srw6FLCYVicQ9ebKYc63xckpqYlUJtc7+pz2i/6/KlW04avTL9nZ9FA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7128

On Tue, Mar 04, 2025 at 05:25:45PM -0500, Frank Li wrote:
> On Tue, Mar 04, 2025 at 05:11:54PM -0500, Frank Li wrote:
> > On Tue, Mar 04, 2025 at 11:50:10AM -0600, Bjorn Helgaas wrote:
> > > On Mon, Mar 03, 2025 at 04:57:29PM -0500, Frank Li wrote:
> > > > On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > > > > > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > > > > > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > > > > > for PCI controllers with address translation units.
> > > > > >
> > > > > > Typical PCI data flow involves:
> > > > > >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> > > > > >   PCI Controller (PCI bus address) -> PCI Bus.
> > > > > >
> > > > > > While most bus fabrics preserve address consistency, some modify addresses
> > > > > > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > > > > > translate these intermediate addresses correctly to PCI bus addresses.
> > > > > >
> > > > > > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > > > > > PCI controller drivers.
> > > > > > ...
> > > > >
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> > > > > >  			res->flags &= ~IORESOURCE_MEM_64;
> > > > > >  		}
> > > > > >
> > > > > > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > > > > > +		/*
> > > > > > +		 * IORESOURCE_IO res->start is io space start address.
> > > > > > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > > > > > +		 * same as range.cpu_addr.
> > > > > > +		 *
> > > > > > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > > > > > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > > > > > +		 */
> > > > > > +
> > > > > > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > > > > > +						   range.cpu_addr - range.parent_bus_addr);
> > > > >
> > > > > I don't know exactly where it needs to go, but I think we can call
> > > > > .cpu_addr_fixup() once at startup on the base of the region.  This
> > > > > will tell us the offset that applies to the entire region, i.e.,
> > > > > parent_bus_offset.
> > > > >
> > > > > Then we can remove all the .cpu_addr_fixup() calls in
> > > > > cdns_pcie_host_init_address_translation(),
> > > > > cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
> > > > >
> > > > > Until we can get rid of all the .cpu_addr_fixup() implementations,
> > > > > We'll still have that single call at startup (I guess once for cadence
> > > > > and another for designware), but it should simplify the current
> > > > > callers quite a bit.
> > > >
> > > > I don't think it can simple code. cdns_pcie_set_outbound_region() and
> > > > dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
> > > > "resource" to manage outbound windows.
> > >
> > > Let's ignore cadence for now.  I don't think we need to solve that
> > > until later.
> > >
> > > dw_pcie_prog_outbound_atu() is called by:
> > >
> > >   - dw_pcie_other_conf_map_bus(): atu.parent_bus_addr = pp->cfg0_base
> > >
> > >     I think dw_pcie_host_init() can set pp->cfg0_base with the correct
> > >     intermediate address, either via the the of_property_read_reg() or
> > >     .cpu_addr_fixup().
>
> And chicken and egg problem here for artpec6_pcie_cpu_addr_fixup(), which
> need cfg0_base. But try to use .cpu_addr_fixup() to get cfg0_base's
> intermediate address.

Bjorn:
	Do you have chance to check my reply? some dwc platform driver
.cpu_addr_fixup() implement have dependence with old initilize sequency.

	Can I use original method? If change each driver's .cpu_addr_fixup()
implement, it will involve more risk, even more than directly clean it as
my RFC patch.

Frank
>
> Frank
>
> > >
> > >     If dw_pcie_host_init() does this, then we don't need
> > >     .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
> > >
> > >   - dw_pcie_rd_other_conf(): atu.parent_bus_addr = pp->io_base
> > >
> > >     Similarly, dw_pcie_host_init() should be able to set pp->io_base
> > >     to the intermediate address, so we don't need .cpu_addr_fixup() in
> > >     dw_pcie_prog_outbound_atu().
> >
> > I found some driver's cpu_addr_fixup()'s implement depend on the
> > initilize sequence.
> >
> > for example:
> > 	pcie-artpec6.c
> >
> > static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > {
> >         struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
> >         struct dw_pcie_rp *pp = &pci->pp;
> >         struct dw_pcie_ep *ep = &pci->ep;
> >
> >         switch (artpec6_pcie->mode) {
> >         case DW_PCIE_RC_TYPE:
> >                 return cpu_addr - pp->cfg0_base;
> >         case DW_PCIE_EP_TYPE:
> >                 return cpu_addr - ep->phys_base;
> >         default:
> >                 dev_err(pci->dev, "UNKNOWN device type\n");
> >         }
> >         return cpu_addr;
> > }
> >
> > This implement require *cfg0_base* and *phys_base*, pp/ep, need set before
> > call artpec6_pcie_cpu_addr_fixup().
> >
> > static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > {
> >         struct dw_pcie_rp *pp = &pci->pp;
> >
> >         return cpu_addr & ~pp->io_base;
> > }
> >
> > this one require *io_base* and *pp* need be set before call
> > visconti_pcie_cpu_addr_fixup()
> >
> > Because I have not such hardware platform, it is not trivial change and
> > it is hard to involve bugs.
> >
> > If move .cpu_addr_fixup() too early, it will cause kernel dump.
> >
> > I suggest keep current overall sequent and try to clean up these driver's
> > cpu_addr_fixup() firstly.
> >
> > Frank
> >
> > >
> > >   - dw_pcie_iatu_setup(): atu.parent_bus_addr = entry->res->start
> > >
> > >     Here "entry" iterates through bridge->windows, and we should be
> > >     able to set entry->parent_bus_offset at init-time, using
> > >     .cpu_addr_fixup() if necessary, so we can apply that offset
> > >     unconditionally, regardless of use_parent_dt_ranges, and we won't
> > >     need .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
> > >
> > >   - dw_pcie_pme_turn_off:
> > >     atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.msg_parent_bus_offset
> > >
> > >     This should be the same as dw_pcie_iatu_setup() since
> > >     msg_parent_bus_offset comes from the window iteration in
> > >     dw_pcie_host_request_msg_tlp_res().  As long as the windows have
> > >     the correct parent_bus_offset at init-time, we should be all set.

