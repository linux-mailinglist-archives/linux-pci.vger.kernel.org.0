Return-Path: <linux-pci+bounces-17180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4A9D5386
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 20:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC1A1F2128A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACF5FEED;
	Thu, 21 Nov 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M91T9saC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E810B67F
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218212; cv=fail; b=bYkG+Mc55inhLnxYk9wEbheZuYKmP0qGZtvKk/D1lwdRa2h1mwcdKH19NiqXEfKQEz1n9BkvRZAfjlBLWDUOk+IDCTqsfOQ+7kMnqPszmF8S3hYR661tmkufPj6fkGQJwQPgjamIN16bRnsCVJtbZwmQJULPGiX4yF31f+9dFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218212; c=relaxed/simple;
	bh=tGJoZGDvS+rToCdbeD4JsSek5XzpcQLnJ+IOm8EEZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QJzkZvo6ANDApFtOdOGJFip101Qoy5ELCMIvxGXAgjiWUjEoDCwdf8MGXUCsCoFCOTy+gCyXjD08xZXvozF6V/9bKY4vlc8raIoHjmbVGNYb7LVNSpRTYJogOQAoglL22ZPvqqTO01HWh7UNVrp6rT7D2nL6Aq190joeL2URX9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M91T9saC; arc=fail smtp.client-ip=40.107.104.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o42jmmEmbeCX6IjS35+wlRS8Ortlk5F1M99YLSMxzu7UNaFNGtVmq2H+GGK8WAH1eFfwb6B9f7/BScqnpWQhhI840SP2QizVIOEoLgOhwHBpOY15PjiWS7wycP5SvjE3EWy0PqB4rKvn317yG9SQUaIUXpUYfBPK90ke+RZpeHuNqXaOMQZBR4qVAgcfJjtMLRwCqlxV1zZEtXDiVaPXXRC9L8blLiwuYyIQV6H7JDy3v0a5uYhBcZOA3OxYDKaHLid1d6f2ijrzkF4bTHJGvVR+06kDvsZPurRuGcOKNb/caHifUxJdnh1T5K3fjWjIfrJyJKBB0J2fkTHu/DIBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W4fr6bunjXxEYyneYHIHOaDdJLQFjET11BtjHSpVi8=;
 b=SvhoWDqLihtWWvn5zR06xIbvd2DFQLKXY1wxPZwGCrRw9taMopTGdldmHePQboej+EVkNL3XrvvB6mio4G0GVJtagdHhcX0QUMXxf4L6nkGdh0XQURNE17R83Xe6TrgkxioF1fB91QwlQvrZUcS+xZmBhyb6yCbvQgHHixdCnD8nhDDjzBy3S0CO48vXWatPCjTFWdXAb+ZHxy2e4Ar7cv3cxUDlle03KmgcMqKRQbFN4NBlqfVF9uqAXM3rP0uN649kCOnjkxKXbfuOu8nEU5iUBg+/eue3ObCZm44HFWbwpVLhyzMMmuvcYF6Clve5mVR//LcN4t+Eilyvp3zM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W4fr6bunjXxEYyneYHIHOaDdJLQFjET11BtjHSpVi8=;
 b=M91T9saCj/dlL0OpozgWGLzAtA8Ml+++f90YySfzH3551eGj5by5OlaRlksRBmskjMFvOFed0KOtcrWS2gFQxrFwdw3Q9DpwnmFM12DMvIBI5oKSRNiS/+QjTL2A5WiYjlYNcWD2GOGGyy+XQEaZOHd+xTsihfNoBoKeXZSRfrq4ZKCdi3DK58KKvSLCs9FkDPIpJYLJymPOqplyJM3BYuBr5bPMXBO3193tdHBm/BbGtZQU7Azzw0jnp5nF48f3oa1uPREdG3TfkVDBaGPuxveZEFGtvngdU3SjCfq0Jpa6UwTw2G3qt6UNj5HsgRxvxJ0m4tpzV9Rmwtk/7h6t1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 19:43:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 19:43:26 +0000
Date: Thu, 21 Nov 2024 14:43:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] misc: pci_endpoint_test: Add support for
 capabilities
Message-ID: <Zz+NV312ESzPdp/a@lizhi-Precision-Tower-5810>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-6-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121152318.2888179-6-cassel@kernel.org>
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ea4551-f7bc-4c59-70e0-08dd0a64c48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/oqPzcX9WHfJQprqiEi7HkhCidoYfvZIuP9R+eawgcHUNt0TKhdwgBNa8Z+?=
 =?us-ascii?Q?JEtqCiQzSMcBx+nPI/RHN682MoMRuFKg940CLijvLS9RFx91g1ELIY5+D2HM?=
 =?us-ascii?Q?Mjh5XTBXMfLp/JH3i0iCFeVLpf0iFgTf143E/9XAkdD94T8SN30IOxZzRoyN?=
 =?us-ascii?Q?eKE87Hl9VQ1zMTDDdjXdj50lGLYyMOFResEV5H4jvAJXD8qTfo586d1n6CL1?=
 =?us-ascii?Q?A9P0NOdjXC0ijJgNFEyItDKE6SjmEyRnSlK6GG2ua67Boxu3Drz81Q2BYhOT?=
 =?us-ascii?Q?MGI6rsvzVdWNyEsjbqHNVC5t6o04PCVrPmmgQ1B/i1H+FhCzqzMZV+yvfYbb?=
 =?us-ascii?Q?wctoTEEqvaOyJwOjsvoiBA92Wo7n7qvp6dZ4ya7mo+0h32SUMrscsXqT9tpW?=
 =?us-ascii?Q?6UyXbZJlTplDhiXgbmDnh4sImgNGL8wnsBn+vQuz+xpBQFZaz9CRUiUoEcW1?=
 =?us-ascii?Q?1YitWU3xD+4rY8Df8jo6/E83mbm/xFEDIiO+AxFYSuuexW4x5vjmV/gNU8c5?=
 =?us-ascii?Q?Is50oSZmyozAXhBq+oLh0SjE2Hrb10TMnTqzPJ8+lT3tvYFdqZNEljA9LrFx?=
 =?us-ascii?Q?Y5OmvSPX8U6ehitMCjhzphs+uhqzQZ1Lf4JkceKr2laJ8QuAusYdq/2ltczC?=
 =?us-ascii?Q?c78f9JrddTru74rencHw8sxpcJtFUafEsun0Zw7dt5vp2pCpV9kAtauUNFb2?=
 =?us-ascii?Q?gszdTCvXAOenfzTx2/iK1nrq/v5p1v7mfbi6sca/p70NoFdineSgXwJPtedm?=
 =?us-ascii?Q?sk3yVmlXQkB7azdiP1wmPeCoTzvO9Zb5aRhd91KjPy/B65qb10qP6/7dzmpP?=
 =?us-ascii?Q?bkMmsmYoLoYOdSpi1xn/0FTzr2PKIEDDG/u3ymDTyIWXzghfVvN+2x8cocgk?=
 =?us-ascii?Q?OJVQoGAvsKxDCAxmFpDAgfDxBzMH3MEkb7VDQ5RHq/PudQptrBGIhN1wuvE/?=
 =?us-ascii?Q?7pWx3JRqfVi69F/O222PSp0GYN7oKjRQ4sB0ycMNhFErbfqZVYwT7wvQDB7c?=
 =?us-ascii?Q?pOh0bkQ0woxoQdUXHZ4dqRaWd7XE/4E5zTusdNN8U4DBlA6kq1c686oFDRAF?=
 =?us-ascii?Q?1jtdm42PjyQgvUOMVGuyaDLPDsz8kVNplDPSad6rZZuKvG6oQRLP8vfS5leu?=
 =?us-ascii?Q?wd1y39vfNtkYSgDE1y2HyyvzF9IK04mqMvhdW8D23Xz2k9aMVuYcWxr+hfqJ?=
 =?us-ascii?Q?NVfEg655DcvrY2fcLbIDyN0KZcDclrX1IEJUpaCkXu194xCgZwhj4CZLAHwf?=
 =?us-ascii?Q?O7N5XXahbVCwNeeydaz4yvdlKPay7FF8uoInnFsgCgymDvqdVCXv8/ZAamH0?=
 =?us-ascii?Q?e5mYeSeLSJDjYcTjLNlijUn/E8ChIUg5+F4V54D+zz732rtFNyWIP8Yp5VJu?=
 =?us-ascii?Q?CI+EjYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lE2rQRbfNRtbYz3geHu8i6uZKqvw+GAAoN1+EEW/DqgeSQZOOlQteds50vWv?=
 =?us-ascii?Q?kYn4CAaBxKLzxkif5fFQCxLWnnLGxRYn4KMhOrfufgaBJnvsOzVkzor6ODdZ?=
 =?us-ascii?Q?8YtquChDmwXfwuDoZ3pnR++Z0DOfwSVYDYG2PA2Z1iB75YB8qnYkShOrgwJl?=
 =?us-ascii?Q?zHSldzE3VYHdLv0TBQLPweEvYEeFwT6aPRqYCuHmAtqg/zHKeTCNYNT88/IP?=
 =?us-ascii?Q?mQybWPnRONljoNwegbqg5QaOiueolCuHobrDFF3AUJTpU5NQ7vkeN+tuEGhA?=
 =?us-ascii?Q?xZ/sHXvtxyRGO1hLgyhNwEX4RA6W3nnSFbsVojlNQi5MgidPb3wRR265qMry?=
 =?us-ascii?Q?s9pX9Fe+jaEjJ1SfSeQ0FN+/5GsCjhEtCgRrEbY5MvRPRAOLpb0NBQpxr7wp?=
 =?us-ascii?Q?iETKGL/1mZtITY+n7YEzwBvZ8DqpWajTl3GZmVpqCsVrQ6sNuYlytKuibMlV?=
 =?us-ascii?Q?Wguclku98sg4urlwWAzB9+gmWgi3cK42ytO/p0LipoYh0E0cBCRzIYtgnXt/?=
 =?us-ascii?Q?matz1duQBjjYqFGkkTdKVpPL02KrzVOKO7hYwk1K6z32JXhax5kshFEG8IQC?=
 =?us-ascii?Q?f4EalrjpyIFo/Yb9rO/EvhehXvV5NTiPRnhz8brKVSHUwbtxs5KvQCS/GPgI?=
 =?us-ascii?Q?mAZfRM5PlL0aCG6dWgtqtSt/+Ujq5tAPNH6qWF5ci+ykoI41iCl1JRtZBCR9?=
 =?us-ascii?Q?OCKkgwFrh5K2XZk4n4nuNxjM6k5a8W9+EmCvOuRKd/Nh6Tqzz7yGmGU6mtmD?=
 =?us-ascii?Q?LEezIF/isdPs1UkkbpJr0yW0UpghEqfo/69QZGzf68safcmZWEPUNnfjo8c7?=
 =?us-ascii?Q?eehMyZWoW8BLkVWgEu4KXRXiFwbbVdrUsRbI3tdrQUMNVsNyUrWSgu51HT3b?=
 =?us-ascii?Q?/EZlseTKfzjKRXJmTQP+nlM7n0U3CkDlOpADn9kfKNgv07AEj6NDR7pGe0JC?=
 =?us-ascii?Q?Q8loSgebHhQyOHKNjtOPNLiAr/G6IL4u+DWOJZmgHBtwpz3vlP3rs/TtpQ8f?=
 =?us-ascii?Q?w8+RCPAldYY1XAxKsftKaHt8PiU5xEutUlY+tdxFF8Op7iHsnnCAyEw/sfOh?=
 =?us-ascii?Q?wGbG5+RdQfr27ctCIAiuxS5oqpVysN83nrsVnCqj7CZpTlhTlrhffzMo8ijt?=
 =?us-ascii?Q?Q5A03NwUutp7V2tjeTrg1vzzkwA4zVDxCTu5K9CJOWiA8MR1JzhrJpauLpYd?=
 =?us-ascii?Q?mN0QRPHMW9UGCazdNl3D8gy5kMTmK4iYOBCEhkoEDOte6w9m59V72jAL1uWW?=
 =?us-ascii?Q?iwU3L3YBt5rqxxRWXgHrNCZzcRdFpzxiFs8SJcvwcTVoSj5OJPNaS3ywtqiT?=
 =?us-ascii?Q?0a98KObfhmWTuRFkVK79ssRO0gjhItS9KSJ6bUup05jWmROApFuc8sYL5tyG?=
 =?us-ascii?Q?PkSOVxsFqROTjfoyQoXbZnwYU+n4SiP3z47SQ1VRFem/XX84Jf/+xf/wzVH8?=
 =?us-ascii?Q?QJrFQPwpPploAOiyi2dXP7XfU8VomMMv45EQB469sReYVjs6TupiBGHSP15m?=
 =?us-ascii?Q?wCm50F6LQKVi5yr6dBQ/Gl+lYMmQzNIbg+JcdIRS6xs5Pe9vJAFRy3S6wvUZ?=
 =?us-ascii?Q?yDf1bWuCqv4W4pQgh8M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ea4551-f7bc-4c59-70e0-08dd0a64c48b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 19:43:26.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VITzymgwG/tgi2mf+0kB/iz5xqdJtWmScnoup48V8z3+G0NGxievXExtdmqspOuPzZYe8H4urcQz42lIW7OZdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966

On Thu, Nov 21, 2024 at 04:23:21PM +0100, Niklas Cassel wrote:
> The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> which allocates the backing memory using dma_alloc_coherent(), which will
> return zeroed memory regardless of __GFP_ZERO was set or not.
>
> This means that running a new version of pci-endpoint-test.c (host side)
> with an old version of pci-epf-test.c (EP side) will not see any
> capabilities being set (as intended), so this is backwards compatible.
>
> Additionally, the EP side always allocates at least 128 bytes for the test
> BAR (excluding the MSI-X table), this means that adding another register at
> offset 0x30 is still within the 128 available bytes.
>
> For now, we only add the CAP_UNALIGNED_ACCESS capability.
>
> If CAP_UNALIGNED_ACCESS is set, that means that the EP side supports
> reading/writing to an address without any alignment requirements.
>
> Thus, if CAP_UNALIGNED_ACCESS is set, make sure that the host side does
> not add any extra padding to the buffers that we allocate (which was only
> done in order to get the buffers to satisfy certain alignment requirements
> by the endpoint controller).
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I think 4byte align for readl/writel still required?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..caae815ab75a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -69,6 +69,9 @@
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>  #define FLAG_USE_DMA				BIT(0)
>
> +#define PCI_ENDPOINT_TEST_CAPS			0x30
> +#define CAP_UNALIGNED_ACCESS			BIT(0)
> +
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>  #define PCI_DEVICE_ID_TI_AM64			0xb010
> @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
>  	.unlocked_ioctl = pci_endpoint_test_ioctl,
>  };
>
> +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	u32 caps;
> +	bool ep_can_do_unaligned_access;
> +
> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> +
> +	ep_can_do_unaligned_access = caps & CAP_UNALIGNED_ACCESS;
> +	dev_dbg(dev, "CAP_UNALIGNED_ACCESS: %d\n", ep_can_do_unaligned_access);
> +
> +	if (ep_can_do_unaligned_access)
> +		test->alignment = 0;
> +}
> +
>  static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> @@ -906,6 +925,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_kfree_test_name;
>  	}
>
> +	pci_endpoint_test_get_capabilities(test);
> +
>  	misc_device = &test->miscdev;
>  	misc_device->minor = MISC_DYNAMIC_MINOR;
>  	misc_device->name = kstrdup(name, GFP_KERNEL);
> --
> 2.47.0
>

