Return-Path: <linux-pci+bounces-14657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC19A0D91
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DD1F23ACF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5D1EB27;
	Wed, 16 Oct 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="igcE6YGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCC15665D;
	Wed, 16 Oct 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091005; cv=fail; b=W2KKQj4yGqO6N4l4O8zu+McnpSveso3SwYnuySWlQOfTbiJq4utwPsjlS4V8eyVll+RpQGGi7Dw2CrwZDXOggXi7GX09A6ICswGZ6WTiga6Ij+qGIeaO/V9bCzeopuma9DesQX785217YvRA6bAcoM7s6lsAdgUT6Vkh6Oz0o1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091005; c=relaxed/simple;
	bh=wpsGDCCmTnMp7KkghvBxBXuZ5OhTbB3VGBI60AoViR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GrwEYnE3DGBYfrd9ROyJS/QsrmaC8iuLzHm/ai085a0TTxGGSNzdZxo3G4pOuS9rT+67z10LXx4M9ytpkmh4VpFAJxcbkG3mmz9qp0229OR6M10qWZkLwFGfFRIPqoClJjm9yrY5PRy09907F2/iN9HFsQpoMSvxptwTGIxK3/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=igcE6YGl; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxSWGiw7JBDpLG87zWmdgsbXu4zPffoakHLyRGbz5jh78mYMFijRktTu7MlL8kSoIP+2jJKu/jqDQlGJyYVcGQmxtjyE443VKAnrl32PWksaurQ4dg0Xs3cKm0TShWUfuASmEzBdLMqixd0DJR+3jkOmJnJp325wwFCmIm3mTSKn1Yc07W9boz5hLuw0mmZiPaCv4yewaDSACKwZE5zG5bJMGqndP6evZ3Egcn61YNQ0qtsb6m2uyYMkhIBWWWKUsPukp8LKqTEfbD5rgkpbjBK6yLZBOLO7RTjeskivwzOgC5pqh0a44xBjxz0Mdl9effoB8GQuAsx29ORy8uI3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zm2R2l/HIcZ7QBHBoIF0+bLdo1r9fAqlv/kLanKiSM=;
 b=Ss1uPp09so5rbQ0G1mx1Otgc9P6QwTmYWAF6TIy0tQ8Q+uWcS35+UQKqw6hUYeomsMRga1AgGl2rwAL9VHdD6UDof4WH/fYhCvgucM1MWT+h/6lDU/1MncTpEEMywUJEZbJKMI6jMsiblkMqR4uSPUuRLjAVd+v4dTP2DgvYi0FTOGfYe0pEGTD4sF1651N6uBtRJfDTHFoVoDgSS1Z4aMLimOGJXOV8iv+DEHt3nlQi3/CX3kHrkUIGC0DHpx/P4e5/Q55/ToJRv+1+lt18CsLoyvk3lbItWe1HTZe1X5JSpM0VxsnhdLCk/bfy1mo0XskSEjMIOTT7jllHAPwIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zm2R2l/HIcZ7QBHBoIF0+bLdo1r9fAqlv/kLanKiSM=;
 b=igcE6YGlszzFOPKQCoMG51FAf/lfCpX0uD+HhpYaepaJ5kt30S3YEOBYZ8xpPKDO8FI56pjP3S36k27PzC7ks7z+1AksP/QBqr/a4Z1R6NLfBYJ6wcsBVrkjqlPAUcY7i3XmaR74E+7oFql1ip64wGswAR0LVb0gKS6favLrQc0V4jWTz2CwkPhfZD1aev0L0WNZAMrDj/wrjh82LNcsHY0NEqvwRQSfNNT3iQ7+pTwe/D7bIb2rm7nlrRn68lgTunf32aCfxFaPS9ASlIqeWjk5PdqG+vJ3rrmnckgV+JyfCOLki5K4sXv3UD5Qxah3c7UJNw/PR0GkSR8oydPY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 15:03:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 15:03:19 +0000
Date: Wed, 16 Oct 2024 11:03:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Zw/VrZYcT0SsZJi4@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
 <97b7e1e7-cb2d-4324-aff5-55b872f2faf3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b7e1e7-cb2d-4324-aff5-55b872f2faf3@kernel.org>
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b7c6a1-6620-412f-652b-08dcedf3aba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPJ9PrVieVIe1DbgyMHv/Nvg2H+Tcs5swA5wcj/SdT06gEGWN8itq2H3u7/L?=
 =?us-ascii?Q?wjv4EUxV6ufJnnO0+zFiR0D71lvqQV53dgVcIxRI4S2fkFLr50rvKIK9Sdsb?=
 =?us-ascii?Q?ImaouBAfNvvpcl68ut3ETCKhrqDcMzQ9cp6+7OEQcD9pLV2Ps3RlMm9rx23c?=
 =?us-ascii?Q?hGOBv0M388GTD82wxb90X/VtXB4ZVKoVT0JT2D3mxNvHofNmxnr8mWLogar9?=
 =?us-ascii?Q?rCNCMS4P0lc0aj+y1azSTBGmMB+F+Iv8NCxo06dS63V6a2/7ycOmisubq2H3?=
 =?us-ascii?Q?eckROlwhza7FT3BcoPTuuD72qoFO/fwCzEvIZ/H4xpYwl3oaPvGySjE4HU34?=
 =?us-ascii?Q?pTE9iLhmXtOlPoZq6KXNEZHM+OdkiJ7468bMevBm1ua50nY1w2anNx+5kUCT?=
 =?us-ascii?Q?L9rw4Z4ySaBzLrgYJKv8ZFeB+buP7+Hc7Se8eFtRFfbpsOIYpWkke6hMFlkC?=
 =?us-ascii?Q?wdWcKgOHUIZadlkJ3h6G6OwzSelLSn69mlCz0xe/HaVnqLeHqeZbZTL1FHmt?=
 =?us-ascii?Q?MStZ5ewnwk6u4gkgnlHmRHcLiXOZ0B3jW3Bvk2Eru/KDsMm1OhGGu8mQBnOd?=
 =?us-ascii?Q?retpbX+BiEqzYJo79IO8z4nWDFSpV6p7GaZPeerMk2lRGMPRchf4CudBIoDq?=
 =?us-ascii?Q?Vy98lqqosPLkGa4/QvGd4mSdJYv/W/dMZaJhkX0Qmj2718lfDWKxLv5H7Abu?=
 =?us-ascii?Q?jsqqFjhEGR39ImCDgncRGtXugDK4+zyKISIT+oMBrNcnWpoYvDpK6tYctmtr?=
 =?us-ascii?Q?mtKYDQZ4pmvkknYseTT+483mLo77EclyvFPAm2Ck7pDBedauLyIYrHuXHkTZ?=
 =?us-ascii?Q?7+Q1hS8034osd8XSADlI+UtIMSViLIepaUYr1Q1P9sh90wOjDvUxqxhr4m4t?=
 =?us-ascii?Q?Yp3apG1MW6u2SKvSKIThFAAL4J2b40ghV6CmoDqw5lXD7U3KmFL2lcvUGeAu?=
 =?us-ascii?Q?PNtCnYO+lfMj9che3e1aRRf3nAwQp2d6SCjb1DEsia1wz4udarRqA3upfIzW?=
 =?us-ascii?Q?I0gfg6TnN7PHcSLTEtbDHBuWkNFt8ygWt58xhqTE8p5IwtydeZb1GxCnRZ91?=
 =?us-ascii?Q?8BTK+kRGuDYzy/FrMD5XqFwwhx8GKgq9Nli0IcQyFgi5OLniCsy/9rrsgA11?=
 =?us-ascii?Q?6NCgC1XRqlOqrkBcVkl4u5lRL9JbhZhq5H/2P2KOxulTHM5SWcfkhaGHoJdj?=
 =?us-ascii?Q?qJIDska0jeDjO/kCsx7zYxfiF7wjK8ErGdWGN4SEaEg+0OXVuWNEZDgn/IVm?=
 =?us-ascii?Q?Kk3w+x53nHqINzqQOB70UgspXoA03FRIZJEQSLM9TRLoaYrhwm6AxX9YU62g?=
 =?us-ascii?Q?f/hNVh/4piT3RLt3nd9lGrZ746/JuLQ5tXDUrloI4VNpAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e0jf+uYGmVhYfkz/9vurmqOpaH+2dliaVugMxNad9qTqwTlEkNBW/4ZOGtUj?=
 =?us-ascii?Q?bTF/NzxcjUZ3/6eTH99Zya2qisEXzQAEaH4oYXv7wlPdk4FGtG1Zs7/0P+oY?=
 =?us-ascii?Q?2r8lvWkbryO5vGpfsq0tZwX8bE73y52R2uny7N7EwpK+6u+0weY4u/bawq7t?=
 =?us-ascii?Q?qSDYYU75g6T7G/7Nu3fiXzU0i/b0D8F/LTPRB/LSJKaGNM0vcOp4X/i0qtYI?=
 =?us-ascii?Q?MQ4exgZoNU+ksIQqQQTsCsbkepi9QNvo3j7K2PiEz0cPwuHuBrio3JcJ7Fra?=
 =?us-ascii?Q?5/ssnZBQCkrytpspHrJ0Cnpebw1b0iCIDJcmnl6WO0zFexCnmCQrT2Dpb3vU?=
 =?us-ascii?Q?l/J5J9KdPmQDqywJ74xxQSnDCoR9BN/J2/Y3QaZ6vp0a4lIFf4PD4PrAMSNu?=
 =?us-ascii?Q?iapB14oDTc4yQc3XIf2cjgo3od2FMB3zSyV8JIr5V1Lg9Yc6tXW2A1ygGZ5s?=
 =?us-ascii?Q?wb8IHHfu5k4fwY+gDTPOeCxvEn2dbgnLdAhZaluc91IBmYyRD2xlYmK+b28o?=
 =?us-ascii?Q?8c4OTpPhZo/lhAVT7imwQS9DQJmmSpaRRe7Fk9f7XwbQOL8JLeZ5hXSh2q9B?=
 =?us-ascii?Q?eJnrHxWodVJGJPndlI1MCbksC+oJuVhpU367SBPkF84EIxvYXwK5Wd1G0i1W?=
 =?us-ascii?Q?nXHGuKGiPtoy1dpeDXGCFLg92P8x7R+on+6gNchHrxbG5GAbCHqUIXT98VD8?=
 =?us-ascii?Q?4gAb1IIv+LUxhJppZ3MQ+unODXJ1Cy33WlgiNNuZn7JvwWuj3FeT6wIUF6l7?=
 =?us-ascii?Q?l7PAukA2wcEH5kdLVmTh+3FcSLWnSMNAxa2RX/7V7e9B28zcLN3jIBBOB40z?=
 =?us-ascii?Q?6y6g+/louMsEvAjAIDol72/yqGwEJUWS325CIjSwt5uctu6LC0uBTO3jXd79?=
 =?us-ascii?Q?290ePmBvHQXcYN3q5dXoI75P9cqCwLdvztrxPUZefK98ouJhsvffpvEg5r/f?=
 =?us-ascii?Q?T85dYTixmvjWXMPnq93dEyZElRnTUc073cvCZLxTEKCRY0K8vryBAzDn6X+x?=
 =?us-ascii?Q?lzHL7PqiMfPPr2WelZBfn8IOV4TgmFVY+WeGG2UUcy4hfazg7TFIfn0/g+CG?=
 =?us-ascii?Q?kPcSBQXHZzIkdTDPGdsneVV0x1rMmzLO8ogtPLdOT1eC583tfD/JdZCtWlpY?=
 =?us-ascii?Q?XmQK9Vyatu8uHNoEN/EcOQskey1RcWfkj71sjOvgAKZUjxJViczgZrcJig1e?=
 =?us-ascii?Q?IqzVBdba78aV4XMDWHeIC/geNmGpH2JdOBBLB+qQGCNgYbjwNT9jvDlmfV38?=
 =?us-ascii?Q?aaizE4yzxmW/fMfzHcgVy+3l04wnjSzVZQKBWPM/Eth6wFq9QvUt9OcNtibu?=
 =?us-ascii?Q?GcUaN2n7iVB+ZPJvd5WhIJSOTMXEtjmzZl8c+ooDu85ASyrL4BIaoLWLcJNy?=
 =?us-ascii?Q?S8hfzG1Vm0tOWBrPWKreMMyVk8fQM322d/Kjk9amJrh7F2fc1J/+ofDqaQ37?=
 =?us-ascii?Q?A6b00GHyk2A7xBNqw7wtqr0j8nkqMEX3pCibL+2+YSqdC0CyoSjVc/SdbO1/?=
 =?us-ascii?Q?QLgXmA/i2du0GII9nMfHJZRxLXkxzhXkg1vbLmDjwG/8URB3spmObanNmNd4?=
 =?us-ascii?Q?ms/zPUSjGWShcgu1b5nEpAHJtkHHCh43frDUeRfK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b7c6a1-6620-412f-652b-08dcedf3aba2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:03:19.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2BzOTiboeehyioe/0hQxRzSH11lpyoXHUN6gT7Ng/C2J+cEF+WV+6nhpg87LR088sVp4qvwYGHhrzSgIdp7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356

On Wed, Oct 16, 2024 at 10:36:20AM +0900, Damien Le Moal wrote:
> On 10/16/24 7:07 AM, Frank Li wrote:
> > Doorbell feature is implemented by mapping the EP's MSI interrupt
> > controller message address to a dedicated BAR in the EPC core. It is the
> > responsibility of the EPF driver to pass the actual message data to be
> > written by the host to the doorbell BAR region through its own logic.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/Makefile     |   2 +-
> >  drivers/pci/endpoint/pci-ep-msi.c | 162 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-ep-msi.h        |  15 ++++
> >  include/linux/pci-epf.h           |   6 ++
> >  4 files changed, 184 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > index 95b2fe47e3b06..a1ccce440c2c5 100644
> > --- a/drivers/pci/endpoint/Makefile
> > +++ b/drivers/pci/endpoint/Makefile
> > @@ -5,4 +5,4 @@
> >
> >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > -					   pci-epc-mem.o functions/
> > +					   pci-epc-mem.o pci-ep-msi.o functions/
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > new file mode 100644
> > index 0000000000000..534dcd05c435c
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -0,0 +1,162 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint *Controller* (EPC) MSI library
> > + *
> > + * Copyright (C) 2024 NXP
> > + * Author: Frank Li <Frank.Li@nxp.com>
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +
>
> Stray blank line here.
>
> > +#include <linux/msi.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-ep-cfs.h>
> > +#include <linux/pci-ep-msi.h>
> > +
> > +static irqreturn_t pci_epf_doorbell_handler(int irq, void *data)
> > +{
> > +	struct pci_epf *epf = data;
> > +	struct msi_desc *desc = irq_get_msi_desc(irq);
> > +
> > +	if (desc && epf->event_ops && epf->event_ops->doorbell)
> > +		epf->event_ops->doorbell(epf, desc->msi_index);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static bool pci_epc_match_parent(struct device *dev, void *param)
> > +{
> > +	return dev->parent == param;
> > +}
> > +
> > +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> > +	struct pci_epf *epf;
> > +
> > +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
> > +
>
> No need for the blank line here.
>
> > +	if (!epc)
> > +		return;
> > +
> > +	/* Only support one EPF for doorbell */
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > +	if (!epf)
> > +		return;
> > +
> > +	if (epf->msg && desc->msi_index < epf->num_db)
>
> Change this to:
>
> 	if (epf && epf->msg && desc->msi_index < epf->num_db)
>
> and then remove the "if(!epf) return;" above. Shorter code :)
>
> > +		memcpy(epf->msg, msg, sizeof(*msg));
> > +}
> > +
> > +static int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_db)
> > +{
> > +	struct msi_desc *desc, *failed_desc;
> > +	struct pci_epf *epf;
> > +	struct device *dev;
> > +	int i = 0;
> > +	int ret;
> > +
> > +	if (IS_ERR_OR_NULL(epc))
> > +		return -EINVAL;
>
> Is this really needed ?
>
> > +
> > +	/* Currently only support one func and one vfunc for doorbell */
> > +	if (func_no || vfunc_no)
> > +		return -EINVAL;
> > +
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > +	if (!epf)
> > +		return -EINVAL;
>
> Why do you need this ? epf is unused in this function...

epf need at request_irq.

>
> > +
> > +	dev = epc->dev.parent;
> > +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to allocate MSI\n");
> > +		return -ENOMEM;
>
> 		return ret;
>
> > +	}
> > +
> > +	scoped_guard(msi_descs, dev)
>
> I personnally really dislike this... This adds one level of identation and
> hides code. Really ugly in my opinion. But that is only that, my opinion. I
> will let the maintainer decide on this.

I think it is better if treat 'scoped_guard' as key words 'if'. There are
'goto' at error branch, if no scope_guard, need unlock at two place, which
is quite easy to forget one at error path.

>
> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > +			ret = request_irq(desc->irq, pci_epf_doorbell_handler, 0,
> > +					  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i++), epf);
> > +			if (ret) {
> > +				dev_err(dev, "Failed to request doorbell\n");
> > +				failed_desc = desc;
> > +				goto err_request_irq;
> > +			}
> > +		}
> > +
> > +	return 0;
> > +
> > +err_request_irq:
> > +	scoped_guard(msi_descs, dev)
> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > +			if (desc == failed_desc)
> > +				break;
> > +			kfree(free_irq(desc->irq, epf));
>
> If request_irq() failed and you want to cleanup everything, I do not think you
> need to track the failed_desc since free_irq() will return NULL if the irq was
> not requested. That would simplify this code.
>
> > +		}
> > +
> > +	platform_device_msi_free_irqs_all(epc->dev.parent);
> > +
> > +	return ret;
> > +}
> > +
> > +static void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > +{
> > +	struct msi_desc *desc;
> > +	struct pci_epf *epf;
> > +	struct device *dev;
> > +
> > +	dev = epc->dev.parent;
>
> Nit: move the affectation to the declaration line:
>
> 	struct device *dev = epc->dev.parent;
>
> > +
> > +	scoped_guard(msi_descs, dev)
> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL)
> > +			kfree(free_irq(desc->irq, epf));
> > +
> > +	platform_device_msi_free_irqs_all(epc->dev.parent);
> > +}
> > +
> > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > +{
> > +	struct pci_epc *epc;
> > +	struct device *dev;
> > +	void *msg;
> > +	int ret;
> > +
> > +	epc = epf->epc;
> > +	dev = &epc->dev;
>
> Same here: move this to the declaration lines.
>
> > +
> > +	guard(mutex)(&epc->lock);
>
> Another code hiding trick... Having the calls to mutex_lock/unlock(&epc->lock)
> would not complicate this code and makes things a lot more clear in my opinion...
>
> But more importantly: you are taking the epc lock in a pci_epf_ function, which
> is a little odd... Shouldn't this lock be taken in pci_epc_alloc_doorbell()
> instead ?

Yes, lock should be epc part.

>
> > +
> > +	msg = kcalloc(num_db, sizeof(struct msi_msg), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
>
> You can do this allocation before taking the epc mutex lock.
>
> > +
> > +	epf->num_db = num_db;
> > +	epf->msg = msg;
> > +
> > +	ret = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_db);
> > +	if (ret)
> > +		kfree(msg);
>
> Looking at this, it seems that pci_epc_alloc_doorbell() should allocate msg and
> return a pointer to it (or ERR_PTR). This entire function would become:

There are callback "pci_epc_write_msi_msg()" need epf->msg. So need
allocate and init epf->msg before pci_epc_alloc_doorbell().

>
> 	msg = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_db);
> 	if (IS_ERR(msg))
> 		return PTR_ERR(msg);
>
> 	epf->num_db = num_db;
> 	epf->msg = msg;
>
> 	return 0;
>
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> > +
> > +void pci_epf_free_doorbell(struct pci_epf *epf)
> > +{
> > +	struct pci_epc *epc = epf->epc;
> > +
> > +	guard(mutex)(&epc->lock);
>
> Same comment about the location of this lock. That should be in
> pci_epc_free_doorbell() I think.

Yes

>
> > +
> > +	epc = epf->epc;
>
> You did that at delaration time already. But this epc variable is used only
> below so it is not really needed at all.
>
> > +	pci_epc_free_doorbell(epc, epf->func_no, epf->vfunc_no);
> > +
> > +	kfree(epf->msg);
>
> This also should be in pci_epc_free_doorbell. So something like:

See above alloc problem.

Frank

>
> 	pci_epc_free_doorbell(epf->epc, epf->func_no, epf->vfunc_no, epf->msg);
>
> to be consistent with the changed proposed above for the allloc function.
>
> > +	epf->msg = NULL;
> > +	epf->num_db = 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> > diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
> > new file mode 100644
> > index 0000000000000..f0cfecf491199
> > --- /dev/null
> > +++ b/include/linux/pci-ep-msi.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PCI Endpoint *Function* side MSI header file
> > + *
> > + * Copyright (C) 2024 NXP
> > + * Author: Frank Li <Frank.Li@nxp.com>
> > + */
> > +
> > +#ifndef __PCI_EP_MSI__
> > +#define __PCI_EP_MSI__
> > +
> > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> > +void pci_epf_free_doorbell(struct pci_epf *epf);
> > +
> > +#endif /* __PCI_EP_MSI__ */
>
> I do not see the point of this file. Why not add these function declarations to
> include/linux/pci-epf.h to keep all EPF API together ?

Mani prefer a seperate header file at v2 see
https://lore.kernel.org/imx/20231020181008.GF46191@thinkpad/

>
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 18a3aeb62ae4e..1e7e5eb4067d7 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -75,6 +75,7 @@ struct pci_epf_ops {
> >   * @link_up: Callback for the EPC link up event
> >   * @link_down: Callback for the EPC link down event
> >   * @bus_master_enable: Callback for the EPC Bus Master Enable event
> > + * @doorbell: Callback for EPC receive MSI from RC side
> >   */
> >  struct pci_epc_event_ops {
> >  	int (*epc_init)(struct pci_epf *epf);
> > @@ -82,6 +83,7 @@ struct pci_epc_event_ops {
> >  	int (*link_up)(struct pci_epf *epf);
> >  	int (*link_down)(struct pci_epf *epf);
> >  	int (*bus_master_enable)(struct pci_epf *epf);
> > +	int (*doorbell)(struct pci_epf *epf, int index);
> >  };
> >
> >  /**
> > @@ -152,6 +154,8 @@ struct pci_epf_bar {
> >   * @vfunction_num_map: bitmap to manage virtual function number
> >   * @pci_vepf: list of virtual endpoint functions associated with this function
> >   * @event_ops: Callbacks for capturing the EPC events
> > + * @msg: data for MSI from RC side
> > + * @num_db: number of doorbells
> >   */
> >  struct pci_epf {
> >  	struct device		dev;
> > @@ -182,6 +186,8 @@ struct pci_epf {
> >  	unsigned long		vfunction_num_map;
> >  	struct list_head	pci_vepf;
> >  	const struct pci_epc_event_ops *event_ops;
> > +	struct msi_msg *msg;
> > +	u16 num_db;
> >  };
> >
> >  /**
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

