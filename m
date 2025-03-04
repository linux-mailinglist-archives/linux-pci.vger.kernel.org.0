Return-Path: <linux-pci+bounces-22912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD4A4EFEC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0EA170E6C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEB254844;
	Tue,  4 Mar 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dTrKYTQV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5F1F8BCC;
	Tue,  4 Mar 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126329; cv=fail; b=K8TSaj945SDDIWpD1+I6aHZnv0nqTRvKFwuq89ywZh5Xl6GOL166VqLT5MVlRV7MKWb6OpAhR+wZ2ExxnzX6FqLP0ZWUjODdSBo9lhLqMV20lr3aKeh9f1yLXceyMV0RWDDgu3wBhkznROVWlCovHpevlGNLBHN5EOFlez7Adio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126329; c=relaxed/simple;
	bh=hX2Alz/uhTsJctFppnqn1UtSgnA+DdxIjb+xCUSDCVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XBahFyYNs/5e6BU5w2FwKOb7Z7CKFIPbp6zus7P/5D6xB/M5q25dKrBcZUL1KzloTfJBpfHGDyUyKUJketRqeUO8mlPbaJCJ6j6PHfOj9+zuKvOC1znyFOm7UTDnqVbRpFQnSf/l8xux7zDcKIDr65RkCxqiv0iozS5AEHYgHHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dTrKYTQV; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvOfhtdCUoAJeDTkV1MJUkF5DZS67x8odIfsTwx63DplkQRiXmLV5ox9YfWDSHaH2TIaNciMQzwfD3hOlyheHURZ4mjFjD+VI64R29mUrbyf/S9oNcXb/YGS7/sn6ExZ0ge3sAd+3E6GWNnuIbp5m66aIwZ+JQzuUVOZbjQdyic7BmQDiiqu35L54fP8i4RKmY5hd1AA0x++SIB9s8kfTPTRjDBwMQX/S2qyHmNa4VmZdt3CK4XyjJU+BOmn/KQ1ytU0mQ2mwSDLwXBMyTo/mASR2QU0f9vKAA9P9RCIUTVVNPyNHS02MDF2fUuOqTzdxikU/DncrT83dIcIhFrAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFpCZKvan2rL9yeZOoz4Fv21GYhsfQSAw3zHe9BT1w0=;
 b=Msh9Qy0wZiKzRARcWckZl95iZK1WP+GE0BBLh/UPAiGXQsDUOraXVHyQwoZ8DbL7kCg15PVqEEAwZEZqX0npehxNROLfgoArFCVNDJJWr8VDZVwlZcpLGDzHyulIEMV/k2OgcG8HA+THbFIaVMeXkl3cceQ9U0+cCUviso5+dUIcRiy1MD1vfBXwdOE3mlHUoMt/MhUiP6OQonVdzdPesyU3sVzJEdeb8YvrXkfqjO0BEAqkRYYBONmkGubJcnAU5EO4HCBRK6ERDVw55S84qhZB5O4a+SKtDq0QSrIBE6Ruf0DmVTE1sLDSCHmNybJm/LxpZapHPqR90RSInE4C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFpCZKvan2rL9yeZOoz4Fv21GYhsfQSAw3zHe9BT1w0=;
 b=dTrKYTQVBRI0TMc8eMI72+1CnRnfMROWGRuVud7IwA/nDc0Kwt0Ojh9Bvc25NN76d0Xam9AiRordrcC07VPuPujr0Ei8rQhA/DbJx92hbWdFYHYudrq44m9Rd40ZKTSHaK5tFdHoyko4ey0OVZVcQiCjs4ts0FbsnbQt3Otw1gf8rlDPwWhGIgLRnFSz19fqCUazGhpEy5G4MsPcXwRN+4I40ik7xqEpi4lRciL4l2kE9ao5LMVeyht3Ww3VmqgKu8il/BSmBhj4ZcWHn5nSM7x0cqmaIMEDhStBhCmEfSJwgxoc0S9FK5tH/UgeZegqZSolHYT76mpl7mgbz+M3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 22:12:04 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:12:03 +0000
Date: Tue, 4 Mar 2025 17:11:54 -0500
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
Message-ID: <Z8d6qpNaL4eJRQI1@lizhi-Precision-Tower-5810>
References: <Z8YlySM6Xtr0beo1@lizhi-Precision-Tower-5810>
 <20250304175010.GA207565@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304175010.GA207565@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: eae3049d-f10a-4fd7-8c26-08dd5b699805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebP2IqkCaVEllsE6rcoCzOQz1y1R3o5z+tR3kfFFmJU6/wcvKbmE94O3O13W?=
 =?us-ascii?Q?r5tW2kJebOXI3cASr0aRLa6bHmsob88bPnoBf425x35WbIKDS+PBuWUHqXBM?=
 =?us-ascii?Q?aLN+I/D366kL+zNT7t+5Bw0P/Hiksp1ljI2+5hI4Oi8QXqo7WhKyOV3vGblp?=
 =?us-ascii?Q?cV+lxZ+yWJX1UePpGDppMi1RgW4l0AeYmvpSbtBhxl91QrdLz5sFQk57UBuM?=
 =?us-ascii?Q?YZTukTkeDvyXnji/bTJCg/fxRV8+neXLOBDaOSAoLjt/qwSFO7TusOgv1pI5?=
 =?us-ascii?Q?HaVmsjlWT1UO1wL5ARzcFdLwYiOCN7rGI4eEO8rTeXbgdKZVizDu1t8TyVYW?=
 =?us-ascii?Q?MDEbZoBkdi9xM/TYl76Cy9VVwV3Q3VuvEYqZbcVjBAAmMOhv3lS2dnnpDOGJ?=
 =?us-ascii?Q?FbS2B7gw9lnrobTxxnTAWqjV93hcrVjoSWLOnPxR2bEyqtP081y7Z5SD6sSO?=
 =?us-ascii?Q?FwCSCy+MDFKI4VAihLzcJR+CVzLiu9Nba69kbiyJekXtegLUxsy8aLuR4I8Q?=
 =?us-ascii?Q?oTe9XQE/pvYavcWN/+XbFboLxeplWowFnqVCTdHYd8GycleACnvOTI1/CwgC?=
 =?us-ascii?Q?JKeLXPeJ+xOAxG6xJZQWC2HdsYiTwqVSPaX5UQPyK/tkLWwtqIPgDI47IAhi?=
 =?us-ascii?Q?aigOk4nJbqp+sxYPsc0ey/9cJfDYQxXtTfWm86ghVdifG/C11CS31DW0VJjc?=
 =?us-ascii?Q?9UQnXsG0hN9qLiQw1iqAIhTbbsnzNTAdaDSEeA40aW402oNpFEUPaUfOO8JS?=
 =?us-ascii?Q?cabM0jlsSIeIskHcyFFKdI8FeK6eFLgWBVE06XlpKQuY29dVnnk+5Mt92eyV?=
 =?us-ascii?Q?c3x3nMCnhuqsJPw+yOfCXKUIy2aCCr7W57at6zfIhZwMj0GiIQWf6YX/60Cd?=
 =?us-ascii?Q?qIhWhMuAOHVBPeXBPny6dLi8PGtHUYYPxQED6ik/uIC2hTMpuc1jM9CHsbe4?=
 =?us-ascii?Q?es60cG/z5B/LbHDvZfYWp8HHHiSZDCCoo9udSSTxs46VqUwYIfpNEYEM7TzW?=
 =?us-ascii?Q?+4y8q+XGgatQTz9XREnzolqeU6NVoqSOPhsq5Nd74b/rBFrBRfByj1JizdNB?=
 =?us-ascii?Q?loUionJmkXrV1wgJskgORGoNLxxvqDOA9RC9hwm4arlRpIxmVaHXQNSipGJE?=
 =?us-ascii?Q?W7HpcyD885nM9b/hSZrEHi0QJlpTBdPEfqqH6q4FgSHqGhtSvm8VU+mTist7?=
 =?us-ascii?Q?Vl8eQkP7P8f2QreMPHX+Iedc0Ep0ovjZOpWq7s0C6O93po7in59q87xMxG6l?=
 =?us-ascii?Q?Yohxsu0F+Fe2WIIOiiNm5B2tMZUyh96r+4Auft0GqzHQbFGzmM6Up5EgzFSC?=
 =?us-ascii?Q?TzedUNA8ERneT4xphhqNszqLaH3t44XjYZiir4zbY+pafhJ+EsqBGMk38m+c?=
 =?us-ascii?Q?pf7ET2Tq+OXypU9GI7Ra36PZ3ZM1mynTt1rNPaycWGXTJ5n7z4PsciSXhlGj?=
 =?us-ascii?Q?zoYif5w+s67OBH8mtaY5diEup3qnRW10?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sxz12l4mUfbnGZ2IY01Zat+HE8vlqYPwtV7qO+usa3vHOkeZ1LbqeXqpXSD?=
 =?us-ascii?Q?cYLH7PdPyMI7T3s2oQQyoCCAEgmuaBth8oN6doK/6WXoI5+E3uzPe5OONlYr?=
 =?us-ascii?Q?XH7eDuapZ3IKJ9DQZD+GEcyPLa0MRGDUfB4ybJvvHOu53Cmb9CXTKhkIKmEz?=
 =?us-ascii?Q?3BbESn+ScVEn9Iy4+xdxLeaYkcUjnnthMKeTzil2mmsYrjHKW5TWuQ06Mol8?=
 =?us-ascii?Q?dmVEvoPcuY69U1dsQB4fVjpQrl3SuTTv3w2uqBQsTFWaWwj41Kghru6ZgJmW?=
 =?us-ascii?Q?ByaTsdomlNTZ/iyDjgypSuetnUcX57x9djT+nu8JcFuJxyDzzHRiSC9YW80w?=
 =?us-ascii?Q?dIhg6nL7Fi48P77QXBO5mpLI5IZE54m4U9yUYZ7OTGYdWVLX01YmLhAvgRgX?=
 =?us-ascii?Q?+PKBEwIiW2U+rs8S3jcxi8ytlubWNcEGfQ10t7jrPX9jmofZ2GJ0sWghW4Q/?=
 =?us-ascii?Q?0aUs7PSXE60LKM8Hx/wwRUpgqH+pPGsQQXb5r3jzduRk0tRjRBsNx8L6KqgO?=
 =?us-ascii?Q?GYM1QC7UZt08vZ+DLH9Wjnw9QOw9ViOfCr7h58ToR2Pv2H3sKupgn5uXE3Oy?=
 =?us-ascii?Q?yHfdWL9TAi5Z4zsJH9ZU+K5QQ0zB6pSiU79QmaCW9P6x9sr66CjZ9NVbbIMo?=
 =?us-ascii?Q?4/Mh/puuKMqa6s3NyMmXs+Xk7O78JTUNmtEsq9sFFF5Es1Dm5lghJqeRLHjN?=
 =?us-ascii?Q?7CQom5IOXcaNk1QK7PGcIym7HGiiu3XFwgkCNZ3bwRWTAXLZn8ONqOvlUgh8?=
 =?us-ascii?Q?qvrWza6tOasoOy3yFt9H9Rv+BWnUyzU7cbX79tqhXflqYJHj/pseDN2BaXeH?=
 =?us-ascii?Q?mxVCT3BwTnJ454I+6J1tQvm7+X+Ko++Ao4rVcDLliIaNl9CV8LYcYC5076tZ?=
 =?us-ascii?Q?5oll8jfapAKpa5kCzJce9mzHtlQMhOB/rbztqmIGvduK5QB9VKJ4LC7qqTMu?=
 =?us-ascii?Q?EsSUXVeA0aAhIT3ePfp/cgkVzQrjsL3Y9xzbeVZhpVpxQRWLiz278+3XgSCo?=
 =?us-ascii?Q?/AtG70XrGxC7UFbVmE1SsSSh3h400q+g+EXlSVpkcJO53oH5S01iw+lHOBfY?=
 =?us-ascii?Q?zugMqmnIzZwhFv7FiG1NGH97bwOG0iFpc7ADUIn2xD/RYq4kUnMSmOagrt27?=
 =?us-ascii?Q?r4aoeqhPn9vqLW9k6z2iA6yzS+Ci2Ikb41J3wfrtLb+tdY6X3tyIApE6GZOS?=
 =?us-ascii?Q?wkvY2p69FRpkTYvZSQbaCeOxEUmLkPtCT6CSbYS+st9JRDVqUnLGeCmnmLBP?=
 =?us-ascii?Q?cNPfNpveCQZF/S0D7MegrdgG6Cj+VWjvO5pk7Xq1kpznn/78jZ1fQVauEezt?=
 =?us-ascii?Q?ba3TT83GO0PjchlpccEetsHDW5CweOWa0KgYImzo9a+8p1POjyx6+TkoYV4N?=
 =?us-ascii?Q?UyqTvt17L8Kx5FcwRfOTRQthnAmOnRjn5DpQ3P8boBjK2qQfXSM4OkzyjxlG?=
 =?us-ascii?Q?HAw7xXNhuV4dUZjpJqErN1T+YX4e3lQnOIObP9LdlAe8HfAQr0ewYaldnW9s?=
 =?us-ascii?Q?nnT4EGZclfcPCiH0rlZGQajPBGZ6d3cE1rXuqkw7ek2ShGgqxwDfiMZQUDHz?=
 =?us-ascii?Q?l+eJYe3NHrGwsut471s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3049d-f10a-4fd7-8c26-08dd5b699805
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:12:03.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdFymOP4zZC3VGXHam9YCXNC2e45AXfgeL609qpZDFgmAhzh+psjSDgghZtF1PM7KfBYG3Ks0DlrlZueB9MLhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

On Tue, Mar 04, 2025 at 11:50:10AM -0600, Bjorn Helgaas wrote:
> On Mon, Mar 03, 2025 at 04:57:29PM -0500, Frank Li wrote:
> > On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > > > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > > > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > > > for PCI controllers with address translation units.
> > > >
> > > > Typical PCI data flow involves:
> > > >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> > > >   PCI Controller (PCI bus address) -> PCI Bus.
> > > >
> > > > While most bus fabrics preserve address consistency, some modify addresses
> > > > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > > > translate these intermediate addresses correctly to PCI bus addresses.
> > > >
> > > > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > > > PCI controller drivers.
> > > > ...
> > >
> > > > +++ b/drivers/pci/of.c
> > > > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> > > >  			res->flags &= ~IORESOURCE_MEM_64;
> > > >  		}
> > > >
> > > > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > > > +		/*
> > > > +		 * IORESOURCE_IO res->start is io space start address.
> > > > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > > > +		 * same as range.cpu_addr.
> > > > +		 *
> > > > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > > > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > > > +		 */
> > > > +
> > > > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > > > +						   range.cpu_addr - range.parent_bus_addr);
> > >
> > > I don't know exactly where it needs to go, but I think we can call
> > > .cpu_addr_fixup() once at startup on the base of the region.  This
> > > will tell us the offset that applies to the entire region, i.e.,
> > > parent_bus_offset.
> > >
> > > Then we can remove all the .cpu_addr_fixup() calls in
> > > cdns_pcie_host_init_address_translation(),
> > > cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
> > >
> > > Until we can get rid of all the .cpu_addr_fixup() implementations,
> > > We'll still have that single call at startup (I guess once for cadence
> > > and another for designware), but it should simplify the current
> > > callers quite a bit.
> >
> > I don't think it can simple code. cdns_pcie_set_outbound_region() and
> > dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
> > "resource" to manage outbound windows.
>
> Let's ignore cadence for now.  I don't think we need to solve that
> until later.
>
> dw_pcie_prog_outbound_atu() is called by:
>
>   - dw_pcie_other_conf_map_bus(): atu.parent_bus_addr = pp->cfg0_base
>
>     I think dw_pcie_host_init() can set pp->cfg0_base with the correct
>     intermediate address, either via the the of_property_read_reg() or
>     .cpu_addr_fixup().
>
>     If dw_pcie_host_init() does this, then we don't need
>     .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
>
>   - dw_pcie_rd_other_conf(): atu.parent_bus_addr = pp->io_base
>
>     Similarly, dw_pcie_host_init() should be able to set pp->io_base
>     to the intermediate address, so we don't need .cpu_addr_fixup() in
>     dw_pcie_prog_outbound_atu().

I found some driver's cpu_addr_fixup()'s implement depend on the
initilize sequence.

for example:
	pcie-artpec6.c

static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
{
        struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
        struct dw_pcie_rp *pp = &pci->pp;
        struct dw_pcie_ep *ep = &pci->ep;

        switch (artpec6_pcie->mode) {
        case DW_PCIE_RC_TYPE:
                return cpu_addr - pp->cfg0_base;
        case DW_PCIE_EP_TYPE:
                return cpu_addr - ep->phys_base;
        default:
                dev_err(pci->dev, "UNKNOWN device type\n");
        }
        return cpu_addr;
}

This implement require *cfg0_base* and *phys_base*, pp/ep, need set before
call artpec6_pcie_cpu_addr_fixup().

static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
{
        struct dw_pcie_rp *pp = &pci->pp;

        return cpu_addr & ~pp->io_base;
}

this one require *io_base* and *pp* need be set before call
visconti_pcie_cpu_addr_fixup()

Because I have not such hardware platform, it is not trivial change and
it is hard to involve bugs.

If move .cpu_addr_fixup() too early, it will cause kernel dump.

I suggest keep current overall sequent and try to clean up these driver's
cpu_addr_fixup() firstly.

Frank

>
>   - dw_pcie_iatu_setup(): atu.parent_bus_addr = entry->res->start
>
>     Here "entry" iterates through bridge->windows, and we should be
>     able to set entry->parent_bus_offset at init-time, using
>     .cpu_addr_fixup() if necessary, so we can apply that offset
>     unconditionally, regardless of use_parent_dt_ranges, and we won't
>     need .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
>
>   - dw_pcie_pme_turn_off:
>     atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.msg_parent_bus_offset
>
>     This should be the same as dw_pcie_iatu_setup() since
>     msg_parent_bus_offset comes from the window iteration in
>     dw_pcie_host_request_msg_tlp_res().  As long as the windows have
>     the correct parent_bus_offset at init-time, we should be all set.

