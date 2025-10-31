Return-Path: <linux-pci+bounces-39965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C1C26D7A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 374B64F65AA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189B31961E;
	Fri, 31 Oct 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwQGykl7"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5C31A562;
	Fri, 31 Oct 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940355; cv=fail; b=CWqmgGwzjTnXVcGZEY2hjuAwvq2XKlEAmOCy02FiaHNvnwLpEmbvChyQavCQiwSbpDhdytcya9fb6xokpMAL8uS7yoMjZ9vPwOeKpDS04AlfVB4kgwsLkZsbnOpnAn3l7e7UYinW+rW37ZuYDKIdaqwnk9xJF9Aoswod/BXrORs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940355; c=relaxed/simple;
	bh=jOHIFoA0wHBozRflN5AdQpOI28caT/J1OdftrSvp+I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvSN/c8E/A5RGwNOl9KduEkA02+c+ZJyeaBOhnjTUm5TxSPtOSv9nsP0j+cxsLb7FtRXcCJyV84e7qqJtyYKF6cwBYXi1uu3BZS08GbtBdwnbOoU4rzKaHL83nyRt8LnaA87K7h9j7f9AS6yxROwTlpEiYkYRinws6Oy1ZRVbCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FwQGykl7; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwRr7deDUZnVrtFc1UraAxgHte7uqLiLaauK/Me8AZf4ASpBOwTRVJdMaZcdXNpL79Xv6MGLvQpOUVTyvWCa5m4hnbfEsw10xbgBrivCowI0CspWyS8KkPNyeYQvEIIzxdMdmLGvJx4fomf67eQAkSwsYdBELi3HN++QQmbE2C+22tOYbvidb9BKyGTRs7iA9drUJ1V+MIyjrGwETQEaQXyT8qAnzHq3MPn0U4WWLCOJiYWe9VA0X1BjUtsj+iysp86EUqDCcEZMr9tmlPeHf3QtH00M9JSwv2QLG2qjHibf3h720s65W+3gKDapPXaaA8XNQ2CpeMWf/GiGkenGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/dx1YZcdZ3QZ4Q1yiQihspbxRCeO7M7YOdd4siuTgU=;
 b=bPcKVUmeex0S6z8JTI0rz4jSuV62puEELhZtvFdWu/QXntIc12c2xPqE3GoIY67j5zN85kYgLWYEknHRRdCwiiREQa/ZHRL4Dt7d081gufuQrOsjsnZDXYUMt4EpVkRUXEGwBqUxbgqmylmTK9QqqiFC12F90bgXlMr5jizPx6GV3xkydQzF4Lsn3iAgIsQdqKgqHEh5yqty0XpXfd/WOG+B6pSTAl80m9iF41uIY7IHGFnRC6mHdGMvTm7KPqI4Bcw1mqL13T1KOqZehH/D0ZqltmYDaBWl+wC0WfnjPBSG0+jOdL2G2+XdNjMgRQk5p7BxxqRzVGol4sBNbZbKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/dx1YZcdZ3QZ4Q1yiQihspbxRCeO7M7YOdd4siuTgU=;
 b=FwQGykl7J+/7g4K7cvZchJC2LkQ3RpI958FhpMEaWzoMdvgYDQmlZIiAAFiFrIxwmYeCl5NWld6grG1Jr5LZPfa+UDRdBzDhsyQutkGMCTUfJXtG3z27tROoklZM4tJW16dPNqKLuNfBdh7Be1GC8mCftrV2K25VnP1Ksri3c3X8R3rq7I8FFlNPQvONz/yBbt2OZIQJVjat8+xfjpj4+mEfastKK31tx83JLQhkfkTIlvCnJVQfBoq3y+JgLXDCe/gXERApv+gk8sd7D4DyLx/RwzorkgHpMTiLOxXshqGlDxpyJ7P4bXbpRkC83HXZE5Ih2qonVMJYvzQbdjaZvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:52:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:52:29 +0000
Date: Fri, 31 Oct 2025 15:52:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v2 6/6] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <aQUTduGoQoUC+Upo@lizhi-Precision-Tower-5810>
References: <20251029080321.807943-1-den@valinux.co.jp>
 <20251029080321.807943-7-den@valinux.co.jp>
 <aQJGlOIJBY+44Q0v@lizhi-Precision-Tower-5810>
 <5qafrtm7qzjcrl5p3j6lovahjaspkehzgjjyvyzchms6dbzksw@hb7hm5uopvh3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5qafrtm7qzjcrl5p3j6lovahjaspkehzgjjyvyzchms6dbzksw@hb7hm5uopvh3>
X-ClientProxiedBy: PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c94490-77e8-4970-b09b-08de18b705fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Yor+6FXzT+Dr8gr39dPoGp7N0UE0KwojV7L8dk+t1tkgqkrkq+tLo5ly9k5?=
 =?us-ascii?Q?WILeX5IeWX31aZdVYOmWsTJ9mqnwY9p+gBo64YckNsVb7kb49USCocLPL5OW?=
 =?us-ascii?Q?2ARKLntnxp8RPXqeCR9Q034SE8v6GcrhoQ+nZ1YjQUQqdRdpWqx4vhMZCymj?=
 =?us-ascii?Q?6rk+RlmqGeFZDXRXs7fyyrpH3ZnUTnAGccYXBgMTs8k/nOwbuKzilw5i8mLg?=
 =?us-ascii?Q?s3DEs9xKjwslE2vaiHex0PS2HSssarKTS3DfnogKZsREj8h/yR1Ps7Wh92At?=
 =?us-ascii?Q?DMHv3WPs7Wi2N2IUS6DAFQ7GWfGGX7FAeBevr55Hk3H/8vqnmBWkQJir4q8X?=
 =?us-ascii?Q?baWnWA+Z1Cd4Wgn6G/gN838AdlcQ4LuMcALp/DMV8v3c3Miqp8OBdHXKEkJz?=
 =?us-ascii?Q?qyjJ5nnd3e4B058adMcox8s+JpeQYCLlBJBrJ+2nRu9nZbmMlIYAOOexCjjz?=
 =?us-ascii?Q?31uFETbyzwggMuZdWzH3s+8BoMmimo4X4TWaYRhjPOnemYZ/GpNO1s4+nzzD?=
 =?us-ascii?Q?3wi5E+x8x1rqzI9Xt2L3J7eYJVAGvuDM0/UnO0Zrq0IjarBzw/Paz5JDge4z?=
 =?us-ascii?Q?oSEuW5XyjJ7YIhjumrRbMNx2v2UU7r1HMh260I1EAhdOwneJEXpH5u6YlL6j?=
 =?us-ascii?Q?Yg1qZVRvS8BljOAsmgxEwC3PnwHsbao/UYy30SCpeJcb/+tWebcu2nC5kD/Z?=
 =?us-ascii?Q?kBx1J6x7vLFrvPgElJU/DS4Fd8YqiSRe6pugFLziOj4QdLo/K4ab08tOyH3X?=
 =?us-ascii?Q?hg6lr6sfNajMgB2MYVPLWuiD7HrD2rP546ecRgkB/eAbJyL4saKoIwwcrFwl?=
 =?us-ascii?Q?CVu6mfRNH9OgGU2O47mo2Vtdxdec4ZDAH+QkOI2F8wL9gKo7vd8uS5wTtv/L?=
 =?us-ascii?Q?QTzHoa55FqUovqpHgxrrL16aIwEFd2j1KhY5xzuY3/zHo+tJBwW/pCz1XeN/?=
 =?us-ascii?Q?xAf6HrZIUp/CiVhAoZQxfu+Px5Jo0CxHm8Nt0mXdc3PlcrPOC7qGMz60ypAo?=
 =?us-ascii?Q?ve3OWmpiAiGf9kIGmHizs3AhYenG8bY1tfbFZK/HQbEfQTmASYis9BkJPmLh?=
 =?us-ascii?Q?iVmy1JP5QtNZrTEq6mEHDnpIpipNILinE/rhemOb8No2rZsh+IuJoQQWEQwy?=
 =?us-ascii?Q?sMikvnvEnRzLfyfrXcsS2uUVPOO1s1Ay2QoTDlRSN9M3tcPhEEmUBikdwamq?=
 =?us-ascii?Q?qvivL9mKpb/wLBOVZrKjnSPlfzz2haBxrRn7dAeOcZeLA/d3j2YrfGhpROcl?=
 =?us-ascii?Q?zcz7ZJ539w+v/5Ocl9T9e3tLKPhdzNrZ2MEZ7AVc0TiVb6rFjzXctI/Zc1Cw?=
 =?us-ascii?Q?UTHe09TTWwyoO+cUGmJ8uVY0a4QEfnYAXY5OtR2dScJDsWi59p1qPsiMpMcv?=
 =?us-ascii?Q?JzYtlHIEjs/jD3KLWH9lYYochYgYkrv5pv4sDVndJZkfTSd8/Ckh9PICTytB?=
 =?us-ascii?Q?V6IKErcSRVZqOk8fiLIihFU5JvDQVb+/USCZJbPNfrGIHUV5pJu/ypc7NenP?=
 =?us-ascii?Q?FoGfZgw/COOSdFrVTESvx3HQund4eva+xitL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7ak6w9nXDSnVc9L0iXThcyQZY2/a63PRk0i/u/8Atvon9rZY+NYdV1dLqco?=
 =?us-ascii?Q?0CpEeIruRUoWvAkoHwww3lOnxwtit7DRc0x+JPOJoOmTx65XJqV7AqDgW3cG?=
 =?us-ascii?Q?KLtALS5VuoKOiLTSLA4L7cqgU6UkIDuPPkff5E6/jQStt9a9HnXQusBBxbar?=
 =?us-ascii?Q?zXdbIc1wtJcN1bdY7d8AGXP6QQmRtQUeN253Oa02guDFKg3l+x7LI/2cT6cA?=
 =?us-ascii?Q?vKBd/mwYHck+UObBDqx1n5HoxyR6gZHByy3KvJoUD2zmwSAnA8fErnCZS+iY?=
 =?us-ascii?Q?nvEu9ii+pQYXZM8wQPadz7UihM5DpsrbPY0iQnpPPfWvcnMcWdGqCPi+3qoH?=
 =?us-ascii?Q?KlOV0lIxZ8JfbWJTLdMXH7WyAiukr36hsSJB1VEG8kiJh+Y1S0zsvNKUlerZ?=
 =?us-ascii?Q?CremNmGFvcbYrH6zItD98N6n9JK8WCBYJ8Xg2ziAitK76X58OPE9+DC0D4wj?=
 =?us-ascii?Q?5NDDXCEsm4qzkxVrACKpEp58wmiry8FkQDmgNnrslU1IFTG0S5KFvkS3UI8A?=
 =?us-ascii?Q?MoXeeDHIsLbAOHqEiNzffCmiHOO9sPI0Kg/w5/mS5Ktp2IUp5AXMcQ03B0MA?=
 =?us-ascii?Q?bvgiNorbo+1fAlN81EvIkWRY0Gg6vMrrszlEXfjdZ0l4HpDYNpKvNot6tX5b?=
 =?us-ascii?Q?V+iyf+O2beQ2W//pRnwBo13iw0v4TvDQL7wI9JmOAzp22CIZnbXDPR5M2RaI?=
 =?us-ascii?Q?gcwKoIfllzqAZF9ogvzAtd6nwqii3M0tEIwTSTecZGtr0mR3qgBHOBel9FXD?=
 =?us-ascii?Q?/FYEZnv4rTxsxgtmkUrQJq7301wK8MiBBQBYhavaCXBeJAzP3zGM8mhecku/?=
 =?us-ascii?Q?Y7Y2qnnxdbPD1eadspXYIOvbqQCFzYOGQKMLvpeqtIJ9tT+6DmVzgNy8bPUW?=
 =?us-ascii?Q?gKZllLIksUXL3Xb0AJNeeMjXqOuTVM3yH2SEINOB8/UFKYFiRJXA2fkdlL/e?=
 =?us-ascii?Q?kQft3zVRryalex6oCtqjeQ1IMuL+Ab+C7sqeWrCBx8h+gtJjzoKRrB3gaJ3O?=
 =?us-ascii?Q?vfMK7bU5EofOEfNc0PrWAey7XhToK9AqPv72rRNkksKdCPbTOwtQBmVzlT+7?=
 =?us-ascii?Q?puL7CBgR5ZUIOA9F95IABTZRn3U+wTsrhNF9pMTkylfz0qgR66pvpQ7TllHP?=
 =?us-ascii?Q?f/mazkkH/vT1gaQSOm9JoNBEJGUwmTYG15GSk7F/a+TOEfWOrdTV8IR6Vsyx?=
 =?us-ascii?Q?h6JX4U8k6e9pH98YuDk+zv92XU1+reYZeod4vMJqauLUy2XX5Romct5kWcbn?=
 =?us-ascii?Q?tRuDRkAex2LxNCoXoyHpUOq4FDHoHAxC4j68sSpHbUu6s4uKl6AonfxKkP7h?=
 =?us-ascii?Q?LcLtDM4AJpFSNV1Iyi6IpWyjOSYnrX+UCeHEHsItQb3p2TOEnJeGSo1g1YZ/?=
 =?us-ascii?Q?p9YPL/WG5iqscF6lZMGlLoAXzeT6gPDr0bpAhH/ljDA+vr9aKEdwVdOMzTW2?=
 =?us-ascii?Q?ZGaq/xBVPk+4oFE3oNLWUnAROy33ZVsDQ0lTyU7ehAsQGskmzde+CJK4JBWj?=
 =?us-ascii?Q?sObXGH4TuZ7BfednrBd1ypzgzAgcWAvxhYYXYS9JUD/RoeXqEgJXOp3RFQQD?=
 =?us-ascii?Q?ZLzamtk8+BSuUoOPp/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c94490-77e8-4970-b09b-08de18b705fa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:52:29.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCXCQmex53WZziZrZ4PN5RzTZ7MnEJmV2aLNzW94qHFijNe0+skAVtjJ2AqS8vFApzk8WmkoDmvMFNNN/kRSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129

On Thu, Oct 30, 2025 at 11:20:22AM +0900, Koichiro Den wrote:
> On Wed, Oct 29, 2025 at 12:53:40PM -0400, Frank Li wrote:
> > On Wed, Oct 29, 2025 at 05:03:21PM +0900, Koichiro Den wrote:
> > > Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> > > or stopping controller and linking or unlinking functions as you want.
> > > In fact, re-linking and re-starting is not possible with the embedded
> > > design and leads to oopses.
> > >
> > > Allocate ntb_dev with devm and add a .remove callback to the pci driver
> > > that calls ntb_unregister_device(). This allows a fresh device to be
> > > created on the next .bind call.
> > >
> > > With these changes, the controller can now be stopped, a function
> > > unlinked, configfs settings updated, and the controller re-linked and
> > > restarted without rebooting the endpoint, as long as the underlying
> > > pci_epc_ops .stop() operation is non-destructive, and .start() can
> > > restore normal operations.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
> > >  1 file changed, 52 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 750a246f79c9..3059ed85a955 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
> > >  } __packed;
> > >
> > >  struct epf_ntb {
> > > -	struct ntb_dev ntb;
> > > +	struct ntb_dev *ntb;
> > >  	struct pci_epf *epf;
> > >  	struct config_group group;
> > >
> > > @@ -144,10 +144,16 @@ struct epf_ntb {
> > >  	void __iomem *vpci_mw_addr[MAX_MW];
> > >
> > >  	struct delayed_work cmd_handler;
> > > +
> > > +	struct pci_bus *vpci_bus;
> > >  };
> > >
> > >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> > > -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > > +
> > > +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> > > +{
> > > +	return (struct epf_ntb *)ntb->pdev->sysdata;
> > > +}
> > >
> > >  static struct pci_epf_header epf_ntb_header = {
> > >  	.vendorid	= PCI_ANY_ID,
> > > @@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> > >  	else
> > >  		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > >
> > > -	ntb_link_event(&ntb->ntb);
> > > +	ntb_link_event(ntb->ntb);
> > >  	return 0;
> > >  }
> > >
> > > @@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > >  	for (i = 1; i < ntb->db_count; i++) {
> > >  		if (ntb->epf_db[i]) {
> > >  			ntb->db |= 1 << (i - 1);
> > > -			ntb_db_event(&ntb->ntb, i);
> > > +			ntb_db_event(ntb->ntb, i);
> > >  			ntb->epf_db[i] = 0;
> > >  		}
> > >  	}
> > > @@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
> > >  {
> > >  	struct pci_bus *vpci_bus;
> > >  	struct epf_ntb *ndev = sysdata;
> > > -
> > > -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > > +	LIST_HEAD(resources);
> > > +	static struct resource busn_res = {
> > > +		.start = 0,
> > > +		.end = 255,
> > > +		.flags = IORESOURCE_BUS,
> > > +	};
> > > +
> > > +	pci_add_resource(&resources, &ioport_resource);
> > > +	pci_add_resource(&resources, &iomem_resource);
> > > +	pci_add_resource(&resources, &busn_res);
> > > +
> > > +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> > > +				     &vpci_ops, sysdata, &resources);
> >
> > look this part is not belong to this patch. just change API
> > pci_scan_bus() to pci_scan_root_bus()?
>
> To make things work symmetrically and avoid crashes (when unlinking),
> pci_scan_bus() needed to be switched to pci_scan_root_bus() to set the
> parent device, like no longer existing pci_scan_bus_parented(). Otherwise,
> pci_epf_unbind()->epf_ntb_unbind()->pci_remove_root_bus()->pci_bus_release_domain_nr()
> would crash.
>
> Perhaps I should've added an explanation for this in the git commit message?

Can you create new patch just convert pci_scan_bus() to pci_scan_root_bus()
and explanation at this new patch's commit message.

Frank

>
> Thanks for reviewing.
>
> -Koichiro
>
> >
> > Frank
> >
> > >  	if (!vpci_bus) {
> > >  		pr_err("create pci bus failed\n");
> > >  		return -EINVAL;
> > >  	}
> > > +	ndev->vpci_bus = vpci_bus;
> > >
> > >  	pci_bus_add_devices(vpci_bus);
> > >
> > > @@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > >  	int ret;
> > >  	struct device *dev;
> > >
> > > -	dev = &ntb->ntb.dev;
> > > +	dev = &ntb->ntb->dev;
> > >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > >  	epf_bar = &ntb->epf->bar[barno];
> > >  	epf_bar->phys_addr = addr;
> > > @@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> > >  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > >  				PCI_IRQ_MSI, interrupt_num + 1);
> > >  	if (ret)
> > > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > > +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> > >
> > >  	return ret;
> > >  }
> > > @@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > >  	struct device *dev = &pdev->dev;
> > >
> > > -	ndev->ntb.pdev = pdev;
> > > -	ndev->ntb.topo = NTB_TOPO_NONE;
> > > -	ndev->ntb.ops =  &vntb_epf_ops;
> > > +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> > > +	if (!ndev->ntb)
> > > +		return -ENOMEM;
> > > +	ndev->ntb->pdev = pdev;
> > > +	ndev->ntb->topo = NTB_TOPO_NONE;
> > > +	ndev->ntb->ops = &vntb_epf_ops;
> > >
> > >  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > >  	if (ret) {
> > > @@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  		return ret;
> > >  	}
> > >
> > > -	ret = ntb_register_device(&ndev->ntb);
> > > +	ret = ntb_register_device(ndev->ntb);
> > >  	if (ret) {
> > >  		dev_err(dev, "Failed to register NTB device\n");
> > >  		return ret;
> > > @@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	return 0;
> > >  }
> > >
> > > +static void pci_vntb_remove(struct pci_dev *pdev)
> > > +{
> > > +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > > +
> > > +	if (!ndev || !ndev->ntb)
> > > +		return;
> > > +
> > > +	ntb_unregister_device(ndev->ntb);
> > > +	ndev->ntb = NULL;
> > > +}
> > > +
> > >  static struct pci_device_id pci_vntb_table[] = {
> > >  	{
> > >  		PCI_DEVICE(0xffff, 0xffff),
> > > @@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
> > >  	.name           = "pci-vntb",
> > >  	.id_table       = pci_vntb_table,
> > >  	.probe          = pci_vntb_probe,
> > > +	.remove         = pci_vntb_remove,
> > >  };
> > >
> > >  /* ============ PCIe EPF Driver Bind ====================*/
> > > @@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
> > >  {
> > >  	struct epf_ntb *ntb = epf_get_drvdata(epf);
> > >
> > > +	pci_unregister_driver(&vntb_pci_driver);
> > > +
> > > +	pci_lock_rescan_remove();
> > > +	pci_stop_root_bus(ntb->vpci_bus);
> > > +	pci_remove_root_bus(ntb->vpci_bus);
> > > +	pci_unlock_rescan_remove();
> > > +
> > >  	epf_ntb_epc_cleanup(ntb);
> > >  	epf_ntb_config_spad_bar_free(ntb);
> > > -
> > > -	pci_unregister_driver(&vntb_pci_driver);
> > >  }
> > >
> > >  // EPF driver probe
> > > --
> > > 2.48.1
> > >

