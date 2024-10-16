Return-Path: <linux-pci+bounces-14668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94F9A0FC7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9720B208F3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43D187346;
	Wed, 16 Oct 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A+gfipGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9818595F;
	Wed, 16 Oct 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096396; cv=fail; b=uU4054cuqvcvhOtZWB8IcnSGddm8uFYmyFgaept5NIt2gfmIK8TmoUYj4tFHlspol0qQRmSzmaCoXNjZUYegFqD349izdsh4dKENSYZ6vmZa+O/hFD60d0kOwWipPCQMOAc1v/FFQgLN6Tsm8SHX7jnO+8pSLZi9opgcY+MYKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096396; c=relaxed/simple;
	bh=J6XffPJ4QD4npyCwoNJfX6qe5YE68QHZ9fGeWjbWYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZxIs7iaKWgbpoqlM6Hq/6aYKa6rVdmSnbEr1MGZmaHw5jHnKY3fkvCBi18cQOGOqMUUZel1TR0+GgVXlkUvmBhWwklHVCbB4ppp8cKfkbA2mxIcnsFbFwjkZ1hbd2i/XQA9NWR8aqGKYbMnFSJnx2TbLSZHBUx5PIBppAofzJSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A+gfipGL; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+qxZUub+B3KmCOYt0k5TC5B4Ksd3t8T0vvADGv9FS71DblJs/ojeyT6e6GnB4jpXBxfAtRwS09Itj/LvABk3ir7JqrKjvu/W8fwugxj+M0YEzc0QF7HBy8aGYlfk1/k1BXc+XWHsCImCNxTveZHcI1VReswLZPXa/8+HwKIhufQuzj7Ekzk8LE+vLWFwkRFHFSIMMYDhGfY6e+yif5ibi3TozPF8cdFwtSumAGIuL00JKRUCQbrs27sJh5pJWeuBYnT7aZrbRtzdRo8wR/61gFtwWxJHKfbcxQZomgsX/9ztTIX1PimDuEWRs8JJMaOeTVccPcUlWfXU5asgpwuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I7BHAqWMkmoHgT3dfS0YL2RGI3+H3vjlCkv6Cb4DqE=;
 b=D9xrG/PUpMFYBmCBPZoOr45b9U/rOeoz4c4eXEyIZwKAsXvD3rpClGvbBlqqJJafNsQDFPvtP2XAZKyTl1yr2te3IkSZCCnI7BOaPyqAsaWf+Onjwi3eaKXmkX30fa4RVxnAa83Y7EcFOfui3Bw9ZSxAOinTNsNG8HP5xxfMs9W+/H9Ahn3MQZExVa6E9WC/BrHJUy7YZhP3tG3wRI0PHspSu+ES3OGs19ssTuBfZQsj2xVVdNt9WG0nrt9rJnuhSVvTO2YdnPwuCf0xXWQV829LaJJxRVuwvHndaKhBvwHkTf6JDqQCRjD3nTjj2jXE3H2SWvOLDKnn5MWNy09Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I7BHAqWMkmoHgT3dfS0YL2RGI3+H3vjlCkv6Cb4DqE=;
 b=A+gfipGLDmFG3bjB0YKSUKMl8veS+KzggfBDlR4j4JU6Rvf/fzag+L6KcdMJKmQRcznlIr9FPzK+vSpqjhD/dSgSkocRxNnIGAy1ywHQPpOzI5LGbwlh5yYl7Uq6j02LzkMH3IUS4LWE+Ew5E1jAJI+/L1utIUZIqJ/qgxCHmjrQSDwEXyz28u4j/O0y1HLYnRgJg7l/yczDrExdjnyOBy8hGxdhz5XK6I75Ob7L0rJk0vy0KOC74A3VjNSfbM3py0q/np1CVS3fRtayf47MmiHDerSIdCdDJymSPJmKxnPserOxgDWWXr/j7ApTiUBxAAKzon3/CQXgT5+RmNm2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:33:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:33:12 +0000
Date: Wed, 16 Oct 2024 12:33:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us
Subject: Re: [PATCH v3 1/6] genirq/msi: Add cleanup guard define for
 msi_lock_descs()/msi_unlock_descs()
Message-ID: <Zw/qwDLN0oCMEKJk@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-1-cedc89a16c1a@nxp.com>
 <87frowauht.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frowauht.ffs@tglx>
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 49eaa9f7-2978-4fc6-b20e-08dcee0039d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pLShPrt4w8XnltwwqfUwAsY3/aaqSHDiKyQGteUaSCVj9s5pieln9YGvVi/n?=
 =?us-ascii?Q?qh0ng7FLW5ESEgGbPvIr5fzVTe9A5OZB+51iIqevKsgdzj1bbGs71e5iucsD?=
 =?us-ascii?Q?VRLBRVU5jozSh3BgpsyssMsX8rceAjKGSBIsDmQzNQ41ePKdWoa/7L5RrGX1?=
 =?us-ascii?Q?AubMcWVwD76c1qiNoYKtRS2SQjD6PoYm3sBkgjsW/Wsa4vxucDnGxcytGa1B?=
 =?us-ascii?Q?iQKdVc+N00QXENZ3f39mTS9wYIAZAh+VjpwI91YxPQauSK+1iNqBO8AytBwz?=
 =?us-ascii?Q?ulnl+CYdbBNnTERcgq8a3Nt8mMDEACG1weH9Wx3qZyPSCfpG1fbWgjDMalHH?=
 =?us-ascii?Q?JrHXKT1z3tfmvFsyoiokHm7I3EIYZ5jAELAS+NlAC9U+9nxLlmBlwCUPT41A?=
 =?us-ascii?Q?AvnFrD2AsNSaZfqEodc7T0tHvZEWQlv2Kf+U3JYeXVMRBkJOTeKjeVODL+OF?=
 =?us-ascii?Q?JEmZsF3hv+gUoJ34KDtpbzxV908HcokMVjK/7NZS0EojPsBIKf16BghJ34nv?=
 =?us-ascii?Q?0UZgcAgMtkW0SVoaLBGrDBuStQA6ugdHiM3Y5qloGScaRDI7suVtqD/9fkh0?=
 =?us-ascii?Q?pFl/qYMCOU+XiG/RXsmluSSc7XIB/FtFMpzXni/WnLiAqF7aSR+h87nFnsJF?=
 =?us-ascii?Q?tzwSmBsOQ+sOQcD4ptUag5Z6ZpXjR3svkEKrkS8xdUCCzRRAFUaqpHg1OI8v?=
 =?us-ascii?Q?/k/2GNRcDGiaXwb2vLdRBslltMNiTj9PXyvFGmvydvzJpVjW6U775kLNrGFg?=
 =?us-ascii?Q?AAMdohlEDl42xDpn42NsZ7a++scNBjhQVEruMjjlDwPUvJc3ytqczUNh9sXF?=
 =?us-ascii?Q?H6h2MmwANMwepn8O31sCCDFXj9yrdi2iiHyHff/DWiSfm+vp3Q4AWysbSpaw?=
 =?us-ascii?Q?kXV8PsGocAFvNqz4m9rpTH+qzAmtNi4OpSPIIozd+Prq3mUVUw0ngw/n6H6y?=
 =?us-ascii?Q?4ADjca01IBHbubQE/kGfuv8x1YIBiEQKOO+MSODB+1yO+DMuOpicrXKKviWu?=
 =?us-ascii?Q?T5bWlpmWHlc5yuLQa6QQWyyxd588Y5Gq/BhEO5EiMMrFoGwyAo+k0+0Wm5Ms?=
 =?us-ascii?Q?5GIO/MvILx4I4yXLSenh7xuaIid6Oh2UxGoU3LTDVBtqpRKIdmIOxEN4OD0K?=
 =?us-ascii?Q?P8O3Elk4sPFeEsbUTuuuTUenPC5hBOs89Jf7I4u198Ye4aRSsGMBvSRptBw/?=
 =?us-ascii?Q?c8/qsMVlk5nl+xB/6lh1Y3KvaIuYiagG890mECi2DvGLBRsicRHllTc/RYJ4?=
 =?us-ascii?Q?2GUo1qii1X6abIlu1a9GVzKSDaI4gZzAvCnzC1SuWfa0YzHhP2AQ7uGK4QPN?=
 =?us-ascii?Q?XDJs4nFioS+JHGYCr/e5fWY5maR3pj/+LhQ8f6D6jOCiLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BX4HKoGcoZ6porUFR6IXXAlH6LhcBDK/BKnKdGuyfRMyGD7pjWdJwMpwxqVV?=
 =?us-ascii?Q?exj+4b448ZFovSUoMnm6yJBwkTx1U2fU7FEYKaNFopXOl3UaC67qfp8EhnzI?=
 =?us-ascii?Q?y5I4yS6nQP4+EXMdJ093+p8Cjf5NpX1RnIzRc7YgytqrJWT10/JjjnQmSW5v?=
 =?us-ascii?Q?mai0Jh0qsXm0HoQpKQBpZUpHB9MUzoB+a+vmfR3RACSbQB/JO5X3u90VxuV+?=
 =?us-ascii?Q?fpe9DDMWnhJJIwVQWz4Z7kNSavu4ibfvwuPniPwwwpxqbirPh3l6rWrbj1nQ?=
 =?us-ascii?Q?5wcVRbEid8XFzLIbWJKat5t9e1++t5lW/RFkuvSZ8+a+Xl4Lanz4nuJ3gpOz?=
 =?us-ascii?Q?zL744CD0mFJT8C+BM0US1SCF2clwX5N77j4l30iS8KwxmURhFr3N1D0CC+n3?=
 =?us-ascii?Q?xXxDd2SCk0QTorgS5VYxNOWfforOvH0x5MVhX1EspsMSTST46m228cjvmjpM?=
 =?us-ascii?Q?veSSY92M/X60zp/mz/zqK4oVt/ld2eOCwUSZ4cnGsIGx5h+XDisQSIK/vcMY?=
 =?us-ascii?Q?5y97eJFtFNb7t07rBeiUMJwCVyfA5BPzCybUtA4k7JLZwKGPGXEVx41J8Lhd?=
 =?us-ascii?Q?Jk8d3wnIdcLApF1a8XiE2Ai/DhsMiMiCzMXEgSv/uDopps4gnh7JpCjt24du?=
 =?us-ascii?Q?0QRliYKOF8uQAfP1WOyYDyiNxD7aNHXACiHk68K4nyQ19f2cF4UQ4y219wS+?=
 =?us-ascii?Q?Gnw1jeajnWESptRadprCal9J//rWpn96MnAZOuLfhag5tbsNwNlGS1iyIYoN?=
 =?us-ascii?Q?VSVP4lTRMQs2uOmV84s9dA/B1cK7bQxlHDcy+A6Q7I3yt2JBktV/4KVr5hs3?=
 =?us-ascii?Q?hf/rlAg3cAKTAnWVEe5ch9VwgiEeglv1QjIsW5TO4ynPHF1TDH4llCf5/4Dr?=
 =?us-ascii?Q?0WNvi6dsWw8aZAp8veJFNqn4tsD4ui7viiR3pG5lqev1oDaZNp27MA1n/C2o?=
 =?us-ascii?Q?JeeundvUrqPfDu1AmkxRMsjgq3NjYaY76SXwGCD2JIWS4c4iuO6R0IAlQ6ty?=
 =?us-ascii?Q?8c08m4Hgf6W4EP8uQg991vcrLcGDl8rUlnmo7pdGprB5prmxXKdKyPCl2aHK?=
 =?us-ascii?Q?0Ll9Nod4EATOEZHBAgA4v3OEUsX4ewLm4GkjkuGEdObpbcSGs0D4ly6NkXFN?=
 =?us-ascii?Q?LjuSOnoXuqHli+Y4NU8OFd3n8NnA2/Te8/bM6s10n35YXY1iigHfbWjjF7+V?=
 =?us-ascii?Q?dB8hLf8s8BMZKwzfjrEZBY8Id5TTQxJQqQo6sVXOzSRqbaeHrY+Mslv7aNMl?=
 =?us-ascii?Q?j48LfLNPYSprr+TuoEZjagZKCb3zgDQ6Sd8GSYwhRcjPM92Lb2OYjjwtP4uj?=
 =?us-ascii?Q?ioamSflmtBJt/i4c19THVq8aXT7DwWhjOi/QdtxisRkw4AsiBndGnTshnmNQ?=
 =?us-ascii?Q?AGNSJKXQ0WRCeF9MPb6Q5rgq7uK1DxaU1Xah2dHA7xmJhRh+QOHr5gaDpiN4?=
 =?us-ascii?Q?F+lwrK85vfwipfPaJ65BpnIOvLwI4k+oqlY/L1ipZyxIeC0QFOJ3040NLt35?=
 =?us-ascii?Q?3bnPBiWMB5XN6zfnqqUAw0OwPcsMyuJ/CON3PoDvsBktq2Se7ydNh3e59Lyc?=
 =?us-ascii?Q?XflTKI2nHzRoffuBLOE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eaa9f7-2978-4fc6-b20e-08dcee0039d2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:33:12.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np5i1G73ykNoBQXVMjWMiqx7lblKu24EXSl+hmnwSC5KQx1O1W72t+H+d3krdoAJsI6L3qJesXduGxVvrsj6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786

On Wed, Oct 16, 2024 at 06:21:50PM +0200, Thomas Gleixner wrote:
> On Tue, Oct 15 2024 at 18:07, Frank Li wrote:
>
> > Add a cleanup DEFINE_GUARD macro for msi_lock_descs() and
> > msi_unlock_descs() to simplify lock and unlock operations in error
> > path.
>
> What for?

See [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller

scoped_guard(msi_descs, dev)
	msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
		...
		if (...)
			goto ...
	}

So cleanup can simplify unlock at error branch.

Frank

>
> Thanks,
>
>         tglx

