Return-Path: <linux-pci+bounces-22913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F2A4F071
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EA43AAF20
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814A2803E6;
	Tue,  4 Mar 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdje6374"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7827F4EF;
	Tue,  4 Mar 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127161; cv=fail; b=M/g8fiLrG3Ui/CgVWR7f/0dm4tUH0goST9/6SikgSIRAE3mB16qgKkZDI9UKTMbKpkrVJ/g/9DIpGgzU55I/40EN/V6f9TvTFNv9bljQUtxU1WUuXVZxS9aOFa7wgUuQPwaM27b+BtIJjShbygYZu3oN+BKzTV6MNHBPleFYieQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127161; c=relaxed/simple;
	bh=yD5fUYeIXKYJm5LAdctrKDPn/0fXCniOro4i/sjVPbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h8i/M/jDOEkZ+0GEfei+lmvXWtxEdGnLm35wPpqLuOhHorHOgd3N0Tk4TlVAccf80vU2rV3FdtyM2nxxTkujLRUgvhqT1E+Rmx6JpEDecUU4uzTVyTbe/8SmfbHwah2JzfWMgq8NPf1PIncDfL6i/O9Whv6c4CnUI+NP7lpl88A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bdje6374; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3VKtHQ+OnIrsN9dJVitnm5NgktQqch+4prz4+YXQlh2N12xN1fqDaTabjHENKHwepJzVqb+98kqL6cwd39G4yAL0rwv4cOLeToYcPqJBVczKsw8eArvjTWa5zLd+vo/y05oPzYOCifp0YN7ae9FMwjYfCWFFQe4Dw/DEaKSbeakuFOJ28f/HDiqdJbTjXiPZxn2LDGTmTG95gxiNfdZZ1fTRxA1KVdrbfxFtChKoBCaa+VYQe9xEbYh9tclNkGmGijlwY6+TZY457WAgf8wHU1z0bCwiGn4YG2hPC1671GsA3U3SeVD6nEY1MzwKtq9zXfxlG2AJ6TPyeC13FHRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwkDYmzVPNpZ2gk0RPESjpw1ZbZ0C1/i5yPC3xmXoBU=;
 b=lLNHcXmV0z9r1pLpE53ViFkPEkQYzVuEuYJRYyn3Yp0gVAt6aBqSRSmh7V38YT8NdYPynvj6Yahzv/+zbLu6C/+rSDJPUfA+RlX91efLFfoj84n9N49pQRQd0n1fx7PAnaMSvZ4kRpVndcBu9B2EPKqqs2iCya8ax9LLVb6zrSKzEhZGWPw3dNKNdRYdMkcMj1SZzNAY5/Q0ETiWW2d2ePKNIobgJ0Lip2lc1XoscBvQkv3CJsN8AFcEGXV6nvTvY/eEd6n3wG1cLrYGfn+Om6Xa+0v7TA+f146H86PVdUI70tSe7Hah+DobIVId/D1tEm9TVxVK3DdhpTwOUBoI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwkDYmzVPNpZ2gk0RPESjpw1ZbZ0C1/i5yPC3xmXoBU=;
 b=bdje6374JvOi4vrqF92hnEKj+hgQSvptWEd7ih3lBpZTpt3SsaszhqvBgALEEHJsQS4RIDHuGe4pUuIgerPsfJBFFpCM6R//9+D38KxgA4qMgLTcpfA19Ckgm+wwUD0acqB6jcyyTh9hjDMDfL5l0x8UDzIC9hL9wH1Wcy11fmLs3JbcXENQ1s4GZe2JAxqHKhB+2yIdFbZ7h4RKocqAWlWyXWI9Fnvak/EP+v/Aga4EdQon8zWbeQkIrqt6o2EmnkNTsGhJHV0ZgUS3dacNMNKJtgQnWBgj3fMnGKxu8EPei/MJ7SbPKsDIY5SMqELeNJAOCWD2CcYAXRkxqJK7gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 22:25:55 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:25:55 +0000
Date: Tue, 4 Mar 2025 17:25:45 -0500
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
Message-ID: <Z8d96Qbggv117LlO@lizhi-Precision-Tower-5810>
References: <Z8YlySM6Xtr0beo1@lizhi-Precision-Tower-5810>
 <20250304175010.GA207565@bhelgaas>
 <Z8d6qpNaL4eJRQI1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8d6qpNaL4eJRQI1@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DUZPR04MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 20938421-f7c5-4ada-47a2-08dd5b6b8768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9S/u/fWFjqY8uyU9+N8GYcQG2sSunOkGr+9JqUguLZqUSt44BL540eNcBx4?=
 =?us-ascii?Q?sW9XWrlEYKTV3JH4h6zHhGcoLc5QU69uepYxdEvIvkAY5epvp0e2040njdgH?=
 =?us-ascii?Q?yFNvN5VJ30BnJzIunYnWKuSQVJ+w7zs5dekKWmG4vxvc00MXYdKnVv5F4/3T?=
 =?us-ascii?Q?/HhKZmqrqNCf0gUXugMvX26Y84ZqicJpGgrh+FSIBs9hI3S4aCWqOOc/wv8D?=
 =?us-ascii?Q?MUnrCLZQBgN1mkpp8+iQmffM9uAS855St7BXqfYYq36oVzevhu7RROg9RwIv?=
 =?us-ascii?Q?cNkTEp/RC7799qZkyJ5zgNx5EFkM85XFP4GbLCS6fla1kwEjxsJxTymICPDu?=
 =?us-ascii?Q?cgpSu4877Q06AcMKU2Y++7aDFtl5G2+/HAx2kOxMDRUlZTGWLRoM+vyDhsHQ?=
 =?us-ascii?Q?y1jfVK9L+60Pt5/qrMR77g5Ac+z+yL2mzD6q789mB/rs8yepjEkWvFVt6xgx?=
 =?us-ascii?Q?vq+CxocdNOoA1vGNywZVJrc+MoZ3GtTH0woM7ZNHzPFXfkgMC8KH02GFGVeh?=
 =?us-ascii?Q?nuTbznFbVpRMLzc2x2vdkYEqEjvgZXev80k8jNaxDwnrZ1EimM3c6Er7PbWv?=
 =?us-ascii?Q?yuAU6YtoESMmsdNOWozx9ZOVyZZ+z4CFFbSy8v1tIADbaEpUKrY6RbxpfwoH?=
 =?us-ascii?Q?8nU6ObiW7fzDh405vtWcB6zr3HQIb5AZy+YijHUmYuvpuBzVS4AYizqIzK8L?=
 =?us-ascii?Q?4NLxPBMBP3z+xWcW5Yyr24Cj7dv2vCqm2fgQ+oAvfHiRtZBnCyp77bQrM0e0?=
 =?us-ascii?Q?FgcFVpjJFxUHUQNL6DUiEtvAqYzaskZsnMXVdJJP7tS4H082ZBE6FzExMQG3?=
 =?us-ascii?Q?4trV4UhuYk2D/H0UfX7FEYuZ5gff57uGNl1PtLorKMQheYcPwM25up4uWHVU?=
 =?us-ascii?Q?zCdx7tK1YyX16R23/568qQ4eG9cQ4dk0QtLqjSAnTJEhEUW3Bdn5N48ldH0B?=
 =?us-ascii?Q?VMgCTGBA8xAD9UdwO7J+9zls9Td0v+4T3dozzO0xxGLifN9bqUMKo93yQrA0?=
 =?us-ascii?Q?hCD010nx16oR6yAjttVqlpqYuP/j5TGhKhGG71RKfal86z6ZOgjQ5MJq57ZN?=
 =?us-ascii?Q?5ZLJSEqbrl4CP5YAENc5oEkwRSwh6CDBK9BhU2dNDIprulak/Frn1Izic3cg?=
 =?us-ascii?Q?nH/twaQ2dOIWPwmz8ZtMUn0fa9m+FmTmVNiLefPzZ7ACLuX1FiCjgGO+9Kpc?=
 =?us-ascii?Q?Yx3cUCAc2+2+G5MZE2sWziw2NM8L5vfzN4rv2Sgbe+nlwfgWChFgYAZ6gD+u?=
 =?us-ascii?Q?peDEaS6hJ9ovArlF2s3AszNhwRPgG521b9BJ1uhnjbMOZDEK6KmLMhSOi+4r?=
 =?us-ascii?Q?BcTdcPoqstBHGW1VDVQ8cpQ/1g4yAG45yB2FTxaP+Oxc2uCGWpNFBMtGqbDY?=
 =?us-ascii?Q?nidtTymvcprM18gcKtDE3811SdPiqg8RhRQctLmDvEbXqduber1Pu0A1vDFo?=
 =?us-ascii?Q?pZfCA8XRtUKbtICeR45lYD4UQnGrHkR4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qrPpMwhfh8hYxGnzMMO6nGkIZhj9gHhWfVEyktf/YsNSyJVn1w7S2TZSMN/g?=
 =?us-ascii?Q?+NywnEnC0ZzF60cfF/gFp2oFXpXV6VPiJyJTMaaeOjROV+oIrf33JxN5FGBr?=
 =?us-ascii?Q?F1SxKhoSCFE+8w+ptlwipz6fcMY99fTT/Nawp/T7OIa6FY7vG6u6DyAsdbHg?=
 =?us-ascii?Q?ucpgVzq91Z4XwcGpL3jYnp06IHgBNqOZ1yNskeF9m69RvaBLbifshPAMV/70?=
 =?us-ascii?Q?BHXFpQvUSHFResichhJgmCFxIP+3l85qCSvGfjvCu21W2r/gia4f4ag1rtu9?=
 =?us-ascii?Q?NA2j61tdnoUvhIubi+8pk6QkYBnyGiYG2ofh+d8rYrTg2zmmbtmeqrR6bFar?=
 =?us-ascii?Q?dNxowNZZ0wzApvhX6h5bfYTOpaYKpEaw4tovIKgrzrbvLGq5jaoA6jB0GhVN?=
 =?us-ascii?Q?tcpQyCU6z6U/cF0sLfhtOOajhljkOPYFLzbolXIbp05GsBrWlXPLDft6Xp7m?=
 =?us-ascii?Q?2jkM/82/Xz982PUOyGWSHjqgEHME0jVMvHqPaFx297BInMXQqVc865KCiPAa?=
 =?us-ascii?Q?NEKVADPUOHIJtWpJaUKHHPsuIvNdcHY+VtmIETw+yUefO43riDMVhb0T1gge?=
 =?us-ascii?Q?K5H4O2Lm2N1/wjF1/lYJXaETFKgP1QSebXALoUiwYY2o+Cbsr7VffpXzBGsd?=
 =?us-ascii?Q?8SkCVxdZJ7Me8UA0wrcDDPSr2kBl5Hv4KPZlwSMwm/UeLdksHZNwzxKECcFr?=
 =?us-ascii?Q?zrPqHNiLlISDo13Ol8uivG8JMiyWk6I5FnSYGy1bpItpR28wA7d/hA05bFlX?=
 =?us-ascii?Q?ZgNZ20xlOudYvSDvJGmc+LxMwE67tSxatlICHcIdKZpLor8MNAOGzBkgrbd5?=
 =?us-ascii?Q?SFC0D++ch1J32b02H9AYaPrvLPoD9Y4VD0vhZlyu64dyxXY1WZtA3n8EtnlS?=
 =?us-ascii?Q?pP6Imqy+o78+ZwPA6JAezlR3PA7Yq8DH8BGUfZSFoaQZgnMt62W/Vk+vBFFB?=
 =?us-ascii?Q?U6vIcC3308jXHEv5UTRGva3VzinGCXE2mPGaISEDGXPZ6ARAAlWRGd2DcqqE?=
 =?us-ascii?Q?5hkWkVbIR6gqi0WyNvz6vI33cm/NpQOh0KBcCzLpAxv/5SKnOYSG0Cu6EjpB?=
 =?us-ascii?Q?ZRjWdV1nisjepw4DPpgVr7T9t7g41puoGpuesaWhBAnmwJeeBh6EPaafkY8a?=
 =?us-ascii?Q?ta/cwcVMUYRA6nbSJ7gI1Xkn1MqZ70Ye6YAkrUfqypKqs1Nkc+Va3vHffH3s?=
 =?us-ascii?Q?5iX0/WkmzhsZwES58I2pMQSnxUQ9EcYdK+z97OQsG9c/I0jJSK/2DpkmnmKC?=
 =?us-ascii?Q?9YtRA0upAU4jx541nj4QXs3WSYv1ERwmlAsPayO92pHQJ22dTntGOloLl7xf?=
 =?us-ascii?Q?ZN7Ih4HRBLeESgrmuxOcgV+cPFu5zu6YiVy7ePqetskgtwFgqMQj0NjxjZeS?=
 =?us-ascii?Q?OOWyYmJ9fhcNQNmd68riiQwuACsJcrMQiXb7aXEAxxvexw/FhJcybf/viYQf?=
 =?us-ascii?Q?VB3fQpkSjh2GGbP7ga9b9pj4DZ/SNE1+6P/T4YV5Br6pqu+69QBa7bq7K+rV?=
 =?us-ascii?Q?LXbsJeTtZdjo0xiA9F+PllFw8Y3UIzTYut0dU+OZIHJuVG/Z/+eTPIMWkR3T?=
 =?us-ascii?Q?GlueB/LZorNS7AEuePBYx7wNA0Tucnfn0YRPWUJY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20938421-f7c5-4ada-47a2-08dd5b6b8768
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:25:55.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbyUs2G3RrYfwK2l8FgKSEz/6rcn+38tKU3VP4HrVf+8oP3rdrG6CW0huIsrCKtQkaPi6MZcboYu/EzEkz2CFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793

On Tue, Mar 04, 2025 at 05:11:54PM -0500, Frank Li wrote:
> On Tue, Mar 04, 2025 at 11:50:10AM -0600, Bjorn Helgaas wrote:
> > On Mon, Mar 03, 2025 at 04:57:29PM -0500, Frank Li wrote:
> > > On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > > > > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > > > > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > > > > for PCI controllers with address translation units.
> > > > >
> > > > > Typical PCI data flow involves:
> > > > >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> > > > >   PCI Controller (PCI bus address) -> PCI Bus.
> > > > >
> > > > > While most bus fabrics preserve address consistency, some modify addresses
> > > > > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > > > > translate these intermediate addresses correctly to PCI bus addresses.
> > > > >
> > > > > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > > > > PCI controller drivers.
> > > > > ...
> > > >
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> > > > >  			res->flags &= ~IORESOURCE_MEM_64;
> > > > >  		}
> > > > >
> > > > > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > > > > +		/*
> > > > > +		 * IORESOURCE_IO res->start is io space start address.
> > > > > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > > > > +		 * same as range.cpu_addr.
> > > > > +		 *
> > > > > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > > > > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > > > > +		 */
> > > > > +
> > > > > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > > > > +						   range.cpu_addr - range.parent_bus_addr);
> > > >
> > > > I don't know exactly where it needs to go, but I think we can call
> > > > .cpu_addr_fixup() once at startup on the base of the region.  This
> > > > will tell us the offset that applies to the entire region, i.e.,
> > > > parent_bus_offset.
> > > >
> > > > Then we can remove all the .cpu_addr_fixup() calls in
> > > > cdns_pcie_host_init_address_translation(),
> > > > cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
> > > >
> > > > Until we can get rid of all the .cpu_addr_fixup() implementations,
> > > > We'll still have that single call at startup (I guess once for cadence
> > > > and another for designware), but it should simplify the current
> > > > callers quite a bit.
> > >
> > > I don't think it can simple code. cdns_pcie_set_outbound_region() and
> > > dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
> > > "resource" to manage outbound windows.
> >
> > Let's ignore cadence for now.  I don't think we need to solve that
> > until later.
> >
> > dw_pcie_prog_outbound_atu() is called by:
> >
> >   - dw_pcie_other_conf_map_bus(): atu.parent_bus_addr = pp->cfg0_base
> >
> >     I think dw_pcie_host_init() can set pp->cfg0_base with the correct
> >     intermediate address, either via the the of_property_read_reg() or
> >     .cpu_addr_fixup().

And chicken and egg problem here for artpec6_pcie_cpu_addr_fixup(), which
need cfg0_base. But try to use .cpu_addr_fixup() to get cfg0_base's
intermediate address.

Frank

> >
> >     If dw_pcie_host_init() does this, then we don't need
> >     .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
> >
> >   - dw_pcie_rd_other_conf(): atu.parent_bus_addr = pp->io_base
> >
> >     Similarly, dw_pcie_host_init() should be able to set pp->io_base
> >     to the intermediate address, so we don't need .cpu_addr_fixup() in
> >     dw_pcie_prog_outbound_atu().
>
> I found some driver's cpu_addr_fixup()'s implement depend on the
> initilize sequence.
>
> for example:
> 	pcie-artpec6.c
>
> static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> {
>         struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
>         struct dw_pcie_rp *pp = &pci->pp;
>         struct dw_pcie_ep *ep = &pci->ep;
>
>         switch (artpec6_pcie->mode) {
>         case DW_PCIE_RC_TYPE:
>                 return cpu_addr - pp->cfg0_base;
>         case DW_PCIE_EP_TYPE:
>                 return cpu_addr - ep->phys_base;
>         default:
>                 dev_err(pci->dev, "UNKNOWN device type\n");
>         }
>         return cpu_addr;
> }
>
> This implement require *cfg0_base* and *phys_base*, pp/ep, need set before
> call artpec6_pcie_cpu_addr_fixup().
>
> static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> {
>         struct dw_pcie_rp *pp = &pci->pp;
>
>         return cpu_addr & ~pp->io_base;
> }
>
> this one require *io_base* and *pp* need be set before call
> visconti_pcie_cpu_addr_fixup()
>
> Because I have not such hardware platform, it is not trivial change and
> it is hard to involve bugs.
>
> If move .cpu_addr_fixup() too early, it will cause kernel dump.
>
> I suggest keep current overall sequent and try to clean up these driver's
> cpu_addr_fixup() firstly.
>
> Frank
>
> >
> >   - dw_pcie_iatu_setup(): atu.parent_bus_addr = entry->res->start
> >
> >     Here "entry" iterates through bridge->windows, and we should be
> >     able to set entry->parent_bus_offset at init-time, using
> >     .cpu_addr_fixup() if necessary, so we can apply that offset
> >     unconditionally, regardless of use_parent_dt_ranges, and we won't
> >     need .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().
> >
> >   - dw_pcie_pme_turn_off:
> >     atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.msg_parent_bus_offset
> >
> >     This should be the same as dw_pcie_iatu_setup() since
> >     msg_parent_bus_offset comes from the window iteration in
> >     dw_pcie_host_request_msg_tlp_res().  As long as the windows have
> >     the correct parent_bus_offset at init-time, we should be all set.

