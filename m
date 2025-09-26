Return-Path: <linux-pci+bounces-37115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80749BA4BDF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03141BC788A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAE1A2381;
	Fri, 26 Sep 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bvfJub/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E915B0FE;
	Fri, 26 Sep 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906631; cv=fail; b=daJiJtd8DD603Q/yeaYtsQYjvRbC5o4K/73PeDy2Fy8VUy8dXx1+xISLrtCY0PGjijJ+O4cI8s49eF1hqiBfHYWIG5ykOxNIcg3nZ0TA9PbHTE6IriufGs7wr5ILgfB33L4tcuPGtey4TyCGxGA2l/JoMXGCNPRJr3JyHOuG4X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906631; c=relaxed/simple;
	bh=5ZSH7YHBLuKAZcYEAJxG7aL3K9Cb2VRp+gqRV9r8Dv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E2Wia36U5io+4SXi4d86i5jDWU4m3OHTUeIptgFcfJ5ftnPcqzeGEFn4ZfzMn0W4g8zB6systGfC8xqFfGpktGPRFQ4tK8Y4MurHUTEQ79AHPSlqJ8FohaYvMehaKL4czrfgGyKPn3BT4CLQvhjSwngbE2LaEUN3TxpXMbSev4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bvfJub/L; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVaLgdSr9AE2weual3t/QcMk8pkVAmnBqDIdrgW1Dne2XKRhv/9W2q3KXHMGn4XayedhHtd/rK500wSY1W/AZH5u8wgkGxfWlGWfqAxbYiL3/GKN3RDzIv0ivL8RR9ddsZWFQ52oKajDbNeVVp32vpXf/OvPgBpZyTF0Z+NfIWrT479ZWfT7EqyNz9pmBpQV56WkDZCKE4cUdK8pjyd7y0XInM0RHpbzwy1pqC+DXq0u5qcAbc3LOmF0nMRJ8rKZkiAdGSG1HrM9e2wIgg2wbdYPyq31rbziZqnwTGvbD0Gw1njindZIezr5sntLTrp6l3zBAJVOViRBtaajkunScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1+p5WaZA7RgEVl7QZwPQTsY7cL/nzC40e9or1dOeow=;
 b=dRJ0fP07sBnS2iee6GKIqIdkxg0j6J20jDs5cdBz7ufe2cPA3nBr/BoixtiamvAVzrUAS2Y6oSb9XfnLudEftv/UwU8q8zuNgUAcL29U+U/ZVslZOthpV8pT9Vz8CU1cObL0/RcnfyB8HR2I7vjjkASw31vwcf0o5jGIA8q306NgRAfCXgSCGt56C4dzYr/H41CMLWOazeWphGt+w8VLs9Sq6YRcTZ3qbvQXWxk7cE8QMxAvfzooTELbKzK3hQvaOdaTo+AGfA/sxKuBUC+CVrOMtlDgNNPVqAwIZ4gkVSsyVj3t0qcg7VPBKDT8a79w9g9d+nn6jv9x07NLMqBgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1+p5WaZA7RgEVl7QZwPQTsY7cL/nzC40e9or1dOeow=;
 b=bvfJub/LLiGE9Sb6jKQEhkTQRfYvRHz7uGkxQH4RnCuOfLvi98jHJpgk3spPYlah/JYuERltqLIph+u25idbFRRnxjKBslNZs1KLpmkcr2RXRhPXjj+2GaOIozpd/idMSOaBddSRrsfbQpj4mSqKMZrrHtFV1VI0t1hHna5g5BVNCqUmiA211oU6/po7kQ1ce6eaNVx/Vwel21a3aV5HlWPYUr68cmLjTfJj5PLe+jpGEj92RemxDlI3V+Ups1VrB+mfrsCjzBu+Xj2G9xtJnTpMtJu3Zvx1PMCtfxHsC/ghuB6Bp3XPGLgcZDe7YPpae+PeOwcEribs6kgHoZvEeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 17:10:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 17:10:25 +0000
Date: Fri, 26 Sep 2025 13:10:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aNbI+KrPJW4kgy4e@lizhi-Precision-Tower-5810>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
 <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>
 <aNaHrj0rwLTtSRS3@ryzen>
 <aNaprpfaeXIcqeGD@lizhi-Precision-Tower-5810>
 <aNauaSVs5ytzsVFt@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNauaSVs5ytzsVFt@ryzen>
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: a06fa5f5-03b6-45e5-b03e-08ddfd1f9579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8XPSvDVAYEPA714fW/0oVuiv/FnOzZkxSAd91q9GdCGVCKfoYh3Wc+YI8AT?=
 =?us-ascii?Q?CbG8oJ8uhpDr7SXWJ8otK7ioGQf8MMMWwjdvBRF4/QebxbLt9MA2czQKJCUY?=
 =?us-ascii?Q?2Bu3aHO8cbjLIGJiH8KItkT/ljbfUWRJMF7KCANiW4siRzY6ZZzxzPfSTigN?=
 =?us-ascii?Q?cVcIdi1ElhsmBu3P1kVmpqwB/vVzDo1mdzRDgYH0umoOCyY9C/cXknWC9RIw?=
 =?us-ascii?Q?b2bWy+WBHj1KrWckuc+BNzbavauL15kIH3QvQ5pXNhfZpOiPer9GGT7GZSKs?=
 =?us-ascii?Q?7D5gLWcUxQzl8XNbqA1JJM2nJ/kivXnRGUhaU2wpLrsVNCACtwYaVgi0S/nU?=
 =?us-ascii?Q?kqvnaPvIOVumjl2RbX3QSPAcButYk2DH94ebI3JdxukVAy5+DxFBK4S6ZMpX?=
 =?us-ascii?Q?BICLk4GiVK6qmC8JvR4vF5AhB/5uOkfOS9wOYPZWCxJfaVPfQVXnVbqRbeNY?=
 =?us-ascii?Q?KtSdOT3c8CfZonSjHFKSxCCRAcafiunnjfXGt0oF//l7xpNlooULh4B09fu7?=
 =?us-ascii?Q?2+10C51epgGzjJcgFcnx1viV9XSv6Qh0u5mOVxFhjV9lW59h0HbTbAFd8WAH?=
 =?us-ascii?Q?ufJx8WAtNHK5k/m+3H2LU5VXDndM9jzF7FGDAJ3gb10q/HKA5CrVo90LE4Mr?=
 =?us-ascii?Q?WbIt8KVytyvpwIxLC7Yml/GvbqU/rP8OSeBnBnzloeMG9BCGo31PKroLbFoM?=
 =?us-ascii?Q?DTibA++A9Zmqd+OWaaHwNAVePNyWRkOyUUwI7XD5jNgTFbR5at0mngTQtsp1?=
 =?us-ascii?Q?JMV6wP937Id4GacNnZciY5UVNUfJ3sDOjpetx59TkMkq/OepdE7t9j8mNMMb?=
 =?us-ascii?Q?hY3IDolrG4P+t1/YCka8qOSeLSFDFvni0tNu7B1W4ElDQb0b2h196iM+PPzJ?=
 =?us-ascii?Q?reKq+JMZJpSmVyo2B3X05oZYK0PuazNZO3MgGu9rQMusB3n70IJIy7eyMI+X?=
 =?us-ascii?Q?bhaTVvSwzBoWw7bhMtwXrG/Ezk638Zib2sPzjS8JCYlb3DGtaafkvepQorKc?=
 =?us-ascii?Q?i+bt9XO1o6HmnoNwRScGcoXkdziOBVYE9dlCLA760YMKZABa0irEy9M0CAhD?=
 =?us-ascii?Q?+BU1vHY0PWTrTVqCIZAdLOdsZk9ztbUhAFr3eQdH5L+9VAgaQXj6Pd0bM26g?=
 =?us-ascii?Q?GVv8P98s+wV1K9lwjq30rVZuh+jubThWei2pMzBUZnEsN8gE/Hyul/i55Eo7?=
 =?us-ascii?Q?aed6L8u9pUaNf4AvUfHy3HZJreDtIT5vMMfCR5ycxvCvK/VRnQxa1mc099mf?=
 =?us-ascii?Q?6jaCcNFjuR1woZ314mglHmOPC959NFbf4Ci9U0SPjnZhN1SuszOaGcp8y3Ca?=
 =?us-ascii?Q?XW+NUw8oJQVld5UDgxr2CNFEUzZXmrnBU2Vnrx+EN3bcN3ib/IwKHUvImwLy?=
 =?us-ascii?Q?aSup88Yi7bt0GaecG/Lj9SC0iUG0KGR0YATunwlsDT6PLaTbEBPKaQINC4fR?=
 =?us-ascii?Q?3EBuc8ss/Xh79RXSVkpydiiZv4EoJhKAwLWUtozV2+y3miYrBGCKYbMjvDnf?=
 =?us-ascii?Q?1VrgnqunKFi4dMPbdUsct6Mft/jKgv/Ps3hs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKTnc96LlYwYnpHpXx7PcK+ofMy5MDZwTMvW8kS7vFdXM3qgpXI8evtgwp9T?=
 =?us-ascii?Q?gdCRwx64Fpzrg/I9PDaeaSSNMKrxkQYX8kclu/sJzS62Pnfzs495GejKxoeC?=
 =?us-ascii?Q?fbOztFIFcRIp83TOSmGK7pG1cpoD5o1Mn6+aSYKQMS1Aq5mk5UHy5YssKz4J?=
 =?us-ascii?Q?SdKUmXug/oIDQSrphnwk5phueAT4KsRp+Zzle1WZXZNiEIV3fBkDsc94CCft?=
 =?us-ascii?Q?zsEm6CR5mST91Moqyk+9PxMf9QCrTn/kHzpAnHdAuZjlLZ3bCGw8XC3h2Mwe?=
 =?us-ascii?Q?QnSdNKyRXS9o7YcotDU73GUBMzh2Cr188u4XCC+e4yn5jtzTltPxB6FOlHS9?=
 =?us-ascii?Q?g04g+lTetNMYJ1Ko167lp1i49K8/qaOT+rD7vy6NGGEN0/pT7ziNbW2XOVqj?=
 =?us-ascii?Q?TGCQS/8rbWN7DBMKZ/nGlqdx6gAfJPVzp4SklxqFgxx3r2gEc7RzU1WvOa1Y?=
 =?us-ascii?Q?/zTtW/YB/BzmtK1GzNrlXi34ddl2UoiB0742EY0bG/Ar8ge2VoJ4B0gKG9Ka?=
 =?us-ascii?Q?L4ylV+uOCirtf2uVuUu7Rn57g9pvC6XyU27PWZNONwPSSCTRIkO/uXvvbRXO?=
 =?us-ascii?Q?394aZ6Yrjm+VRC+5nZbNFYdZ+XMb4WJQ4SiEdh80Z8FW0whBg+DuhwexgHVs?=
 =?us-ascii?Q?D58ax/NeWEErssTKw9+2ev8n/IAerHLKqrsWmzjJnvl/DFndSapDJOWD68DO?=
 =?us-ascii?Q?OdZ1FkEcUy/RPD3TQXUmw7WZ+6J3KMKnIczz7RGTGMRSdUVQjZM/97L0gN55?=
 =?us-ascii?Q?27gAVnTdGQcjnKPXtr+RLXP0WJAJeWtjZjSWDShO/56Pmrp+5fnnQ9sP6Jbz?=
 =?us-ascii?Q?nGN6whZ7hDwYBwZ3Km42/FPhAtVotiKPUl6T3Kb6duDVmHjiu9EJqkkk8OgI?=
 =?us-ascii?Q?+c9dipzVMLhqUOuzW9WaWSgDpwW4SeAEpigA5UxqeICxk/OHrWSXA/i7TgJc?=
 =?us-ascii?Q?K77OI5oQ+esC/uz0zqIZvCDa0aLWJptAYJx12HdOYcQWWIUwn8YUnbywTaJC?=
 =?us-ascii?Q?jZ0OGuKULNCNvSi4psguCu3kEWVc4axnZc9RiDjx3QvZw90IeMM+zXj4LVqB?=
 =?us-ascii?Q?11KyRXqIjcfB+8EZbp09D+HcBDPtyVAeu37iFmxvKWfqfCQ/Tqemr9e7/DQf?=
 =?us-ascii?Q?99r32wlbm/QhHpjsedFqeaKob/0fk2FN0kWFrdixPUZSVsYAt1+4gh6Gs+Y2?=
 =?us-ascii?Q?P9q4wuWnhBCyfKtdoFJ8mqzBaGU6zSavnsSgDQGwrNXOMo3eE3DvmRcjMlcn?=
 =?us-ascii?Q?QxQO1P7SbR2D208YNtioej0EwvrRVjtRRQCqXyjiGELIOIF85tPlXbW566fX?=
 =?us-ascii?Q?2W8sWyurbEInMvr0pPa+rmuaC5aZDC2yifec2C9U/Udzar2hnoxpfJY5nYQ1?=
 =?us-ascii?Q?VuBG5Zcq9sdxQrGULX1yAI0DIlr+bVoS6mBIqzHsd78LX1SiKSyOz6xLE1Z8?=
 =?us-ascii?Q?avz1tLVTeooUX807elEfW0Yn2dBfzGzAEDfjdjN55zex3pFP6MPoUmxEX0ns?=
 =?us-ascii?Q?35fValw04JQP+QyKKLkrlJ+9wzY9bXzSv1yDgNQUjsaurNPWFbLEfqbwBG6d?=
 =?us-ascii?Q?pw4XQsQZgZtM89KeG1NiogyTPpkGhiMqxMYNQ9LE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06fa5f5-03b6-45e5-b03e-08ddfd1f9579
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 17:10:25.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVNvrbt4rq7OFA6vB90PzqjYeOv4w8N8M3BaG0fH8BaYVD+8HMGFTE+Dl2vROb/muIEfvdjtknMpAl50ArLIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107

On Fri, Sep 26, 2025 at 05:16:57PM +0200, Niklas Cassel wrote:
> On Fri, Sep 26, 2025 at 10:56:46AM -0400, Frank Li wrote:
> > On Fri, Sep 26, 2025 at 02:31:42PM +0200, Niklas Cassel wrote:
> > > On Thu, Sep 25, 2025 at 01:01:47PM -0400, Frank Li wrote:
> > > > Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> > > > size and memory size. Prepare for adding support to set an MMIO address to
> > > > a specific BAR.
> > > >
> > > > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> > > > confuse.
> > >
> > > s/confuse/confusion/
> > >
> > >
> > > >
> > > > No functional changes.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change in v3
> > > > - change return value to int.
> > > > - use two pointers return bar size aligned and memory start address aligned
> > > > - update comments about why need memory align size. Actually iATU require
> > > > start address match aligned requirement. Since kernel return align to
> > > > size's address.
> > > > - use two varible aligned_bar_size and aligned_mem_size to avoid confuse
> > > > use 'size'.
> > > >
> > > > change in v2
> > > > - new patch
> > > > ---
> > > >  drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++--------------
> > > >  1 file changed, 53 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > > index d54e18872aefc07c655c94c104a347328ff7a432..2cd0257831f9885a4381c087ed8f3326f5960966 100644
> > > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > > @@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
> > > >
> > > > +static int
> > > > +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
> > > > +			      size_t *aligned_bar_size,
> > > > +			      size_t *aligned_mem_size,
> > > > +			      enum pci_barno bar,
> > > > +			      const struct pci_epc_features *epc_features,
> > > > +			      enum pci_epc_interface_type type)
> > > > +{
> > > > +	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> > > > +	size_t align = epc_features->align;
> > > > +
> > > > +	if (size < 128)
> > > > +		size = 128;
> > > > +
> > > > +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> > > > +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> > > > +		size = SZ_1M;
> > > > +
> > > > +	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> > > > +		if (size > bar_fixed_size) {
> > > > +			dev_err(&epf->dev,
> > > > +				"requested BAR size is larger than fixed size\n");
> > > > +			return -ENOMEM;
> > > > +		}
> > > > +		size = bar_fixed_size;
> > > > +	} else {
> > > > +		/* BAR size must be power of two */
> > > > +		size = roundup_pow_of_two(size);
> > > > +	}
> > > > +
> > > > +	*aligned_bar_size = size;
> > >
> > > I think this name is wrong.
> > > The BAR size has not been aligned to anything.
> > > The BAR size has to be a power of two, but that is a requirement of the PCI
> > > specification, so that in an inherent property of a BAR.
> > >
> > > Perhaps just name it size or bar_size?
> >
> > there already have 'size' for input.  It should match epc required's size.
>
> Why do you need both "size_t size" and "size_t *bar_size"?
>
> Isn't it enough with "size_t *bar_size" ?
>
> The user can supply a value, and the function could update that value.

If not 'aligned_mem_size' in list, it looks fine. But after add
'aligned_mem_size', I think use difference varible for two outputs will be
clear and consistent and easy to understand.

Frank
>
>
> Kind regards,
> Niklas

