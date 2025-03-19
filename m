Return-Path: <linux-pci+bounces-24083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE63FA6881F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E1F3A6920
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECC2561BA;
	Wed, 19 Mar 2025 09:31:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F360255E44;
	Wed, 19 Mar 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376678; cv=fail; b=qgONWqAzMXmVShPI2HeU9fyib4mP5mgTjDRKuMaZOwFMuIUqy0kE1MqoI4WVJlHvFw3Rsz3BqX/pmWjEPxP5qfkHVcX4KojVnDKMvvQK2nEJK/1mYtofvlKDAaueXd3q0jDacz9qMjr9iYyREYK/ONhw+ISzekFMaCs3LMWcgyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376678; c=relaxed/simple;
	bh=TxS2usu/30vIgxooPZw3O40OhwA2v25uFHP+8C67nFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BinwG0VEqMPbEoz1Bq7WSqrJENDVKiW81Qk9nwaFHZbGpqcV/pH7MPDPIlOrsd6/zIWGvnIXMtiub208dUXylJH29sE1Ix5vGYSPqxEDnRG6RpsTRxMSpogoCTYOgabtOlA+xaKKuuNri026ohiGhjfgbebF45akqQtR9LVIvGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnwOM0joVNX+SZhCIhil4tXaMqZe6JvTe+ihdw+qAkfIfWeWu/omLwyQXhg6NWDOKaroV17+QZABP3Jzi3D3uHNUzFdgT+KqCR4WIr1bKq75G5KDwaogs4g7OXz24KkIXE6buWe22VxWioHFq82Ld6fz67jZ7hXsHS6dmm2OE2adu9ITGkL1KNcxqQapmYd1kxcMTj/JZPR2+ZvWfSQT5+st/Bam1t5Hg4EBNTN7C4OPFrh6IQxW3KzpwRGwmjhadG8DY5WM3hq9q8XXpBA698/mNWzgVcYyCOIhhuIBwWc+vAOBMChPGxLuofknBH80ZHcUGI90Js7Ws6p6OelUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wamUso4b1WGimo/sIrO/N6kBi2SFz6qid5Yg0KAIl8s=;
 b=ov81ySNK/dNPNv/KUp+CHWC36oCOU/ncwYlBwYfdEaFmxoXrPKdWvwFW3lu3RHe2QTqOTE7dJ7BDLXoBlZ2QPN4fmVkKCKqsciLsu876I7et8S9Nwe//9UEZPKu/n3XKDfNLSKvuHV1B88M+RwcSWXujTzphtPPhBaFH99zY7ovmcG1+vffpA0jb89oJvqh7W+OAe6kxDY+EUtPqLGJ5a+Cvzsh5qTgIw4YoyI09fglwqS0RCI5jXIJ8UzQXOWSczBK/k2GrXjhD+pINjEulWMF28XdhYn4EJTzInPF7uCVm1/C8XN/E0ivCATJBOQ6XSE1V4bTyVfSRG+VaoDvbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) by TYSPR06MB6900.apcprd06.prod.outlook.com
 (2603:1096:400:46e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 09:31:09 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::b8) by SI2PR01CA0036.outlook.office365.com
 (2603:1096:4:192::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 09:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 09:31:08 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 05C224160CA0;
	Wed, 19 Mar 2025 17:31:07 +0800 (CST)
Date: Wed, 19 Mar 2025 17:31:01 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"wojciech.jasko-EXT@continental-corporation.com" <wojciech.jasko-EXT@continental-corporation.com>,
	"thomas.richard@bootlin.com" <thomas.richard@bootlin.com>,
	"bwawrzyn@cisco.com" <bwawrzyn@cisco.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
Message-ID: <Z9qO1f5MgNcwO5A4@nchen-desktop>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <Z9pffxeXHVOsoi4O@nchen-desktop>
 <20250319062534.ollh3s5t7znf5zqs@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319062534.ollh3s5t7znf5zqs@uda0492258>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|TYSPR06MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc306cf-f9af-4ae5-b6ac-08dd66c8c776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgIQtoKrlMmWie5lenXMooAs9Whn9Kl8+q3easyt1ueI0+VfKxE/aKMP+44F?=
 =?us-ascii?Q?yMNOtYrJ68h/dWFWFdDRN67bAb8TvxU/iBw2H1xVKc5fUk7qzyQRZNqpE9ZU?=
 =?us-ascii?Q?g4d0s5zbclW23H5wfjY6a7VzUBytaZ9p4yXLJ7rEaVkh/zsDoTwExHrtvdKr?=
 =?us-ascii?Q?brTmnhIcsBU7bzEcEIqP4u7tS5GeB0di9ZcBDhaKny1O2Ca9E3k5NsFB9rUS?=
 =?us-ascii?Q?q97Gn34Kq2JqTkiPyH24L910/n1vZyrWwD4K1w0w7g86J4dZaIc8kiD94Mct?=
 =?us-ascii?Q?lpeWZ0eMCrlnZSRxXt3SbBPq+IEwkzF/rTjw3LbkygG4qRjKhe7jxqati7+A?=
 =?us-ascii?Q?adsymHpb2YDTeZD3qKfgiz4lWgWTmyyl84+fnQXX+xn+bQKN00AGngQr/Vr7?=
 =?us-ascii?Q?ssb2wYvea3YTy14U3IVCgkBBGfR56jD4utXPEbt/usHZ6TU4PB+NqmjDQod7?=
 =?us-ascii?Q?lrb4O6mSjbj8ZAF/rwjd9x3WXVPq4KUX1OJg7QWKCfT+6qUKEcnAD+U2/1rN?=
 =?us-ascii?Q?8Caxq1pW9gJXgCGxqePcvbxDisnNevCNE22YuhRfsemJRkYtf0hnN+SzQJuG?=
 =?us-ascii?Q?Kl7xH9bKOuYPo12Q2o3tD6pb+bnShiDFh5LhMh6iWyGtE//xwQxbe8nkYaZn?=
 =?us-ascii?Q?dxaj6cDGkt1RpKyI70Zsf3UnEXmf5S1CdZhKokN6sJir68PHdbOmxbxqrKu4?=
 =?us-ascii?Q?yqUDUrQ0P2Q+++0yyLt1Bf3ibEdetN3jxHLwU5CNU9LM6w3j7XWvWdmT6rmt?=
 =?us-ascii?Q?jP4m61SzJOuegpze/36XlfOZYgjeFWFk5WUo8MbLsF4k/asmSzsZ5z6Kn89T?=
 =?us-ascii?Q?J3hMDS89o4bPrVn+Qax/pv2WzSEbvTlxrIGfutk7giAZzcXLxIXUhSjxSOhy?=
 =?us-ascii?Q?+wOVKcT1fmm9SI9NWYbrkEniCBdLQZrNROn8wFHZe1ni3wVz4zA/cz03uC+l?=
 =?us-ascii?Q?yzxWGBXJQs71Bi3rCV3r4jIY35bufniJTTigHQEfCPCp2rQ8uXUHHsbxoMZv?=
 =?us-ascii?Q?XC8S8qxPeMgNSP8VizuQiXUT9+watp4aXLZLEr6+fBhvRey62TQ+SIhiC2q5?=
 =?us-ascii?Q?OYkykyRU1odGA1v21wmg5L6Tq6+y0PoRqGaoMzkkaeseonRX0uSEkayO4lbP?=
 =?us-ascii?Q?+cLGKSy1ggF+I+ogs6D7+eHRS6PZYeqm0fVoScoIYY2dcK6c0VEP8iFcHfNS?=
 =?us-ascii?Q?ftUrckhM3DYoALUdFuqYjPxkclQUc1UBIK534a6aIGKhKgZ0oc0E61pUauy8?=
 =?us-ascii?Q?0KBbaUOtt4z26Bqqli+aFMxgNTEiHCS0q3E7mr4w/AuA9WYZkAcNSwaf5OTH?=
 =?us-ascii?Q?2bZoKk/FabjcGiXhXlYaSnkGcz77YaNY1vDEBiR6doFS1i9kZa/CSCKw+Aat?=
 =?us-ascii?Q?04WYV5bCnSaVddm1IAR8KS2QgwUR5MGO2QyUrjOHR3kU3prSXRdHO9hAa0Br?=
 =?us-ascii?Q?wnvj4MSbtHFNXJuBLIv0iL2WoTC+dq6kB05+BRdvkdfZenaFSt25CHDzos+N?=
 =?us-ascii?Q?CpB52NGxutAXfVo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:31:08.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc306cf-f9af-4ae5-b6ac-08dd66c8c776
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6900

On 25-03-19 14:25:34, Siddharth Vadapalli wrote:
> > >
> > > Hello,
> > >
> > > This series enables support to build the PCIe Cadence Controller drivers
> > > and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
> > > Modules. The motivation for this series is that PCIe is not a necessity
> > > for booting the SoC, due to which it doesn't have to be a built-in
> > > module. Additionally, the defconfig doesn't enable the PCIe Cadence
> > > Controller drivers and the PCI J721E driver, due to which PCIe is not
> > > supported by default. Enabling the configs as of now (i.e. without this
> > > series) will result in built-in drivers i.e. a bloated Linux Image for
> > > everyone who doesn't have the PCIe Controller.
> >
> > If the user doesn't enable PCIe controller device through DTS/ACPI,
> > that's doesn't matter.
> 
> The Linux Image for arm64 systems built using:
> arch/arm64/configs/defconfig
> will not have support for the Cadence PCIe Controller and the PCIe J721e
> driver, because these configs aren't enabled.
> 
> >
> > > @@ -209,6 +209,12 @@ CONFIG_NFC=m
> > >  CONFIG_NFC_NCI=m
> > >  CONFIG_NFC_S3FWRN5_I2C=m
> > >  CONFIG_PCI=y
> > > +CONFIG_PCI_J721E=m
> > > +CONFIG_PCI_J721E_HOST=m
> > > +CONFIG_PCI_J721E_EP=m
> > > +CONFIG_PCIE_CADENCE=m
> > > +CONFIG_PCIE_CADENCE_HOST=m
> > > +CONFIG_PCIE_CADENCE_EP=m
> >
> > The common Cadence configuration will be select if the glue layer's
> > configuration is select according to Kconfig.
> >
> > Please do not set common configuration as module, some user may need
> > it as build-in like dw's. Considering the situation, the rootfs is at
> > NVMe.
> 
> The common configuration at the moment is "DISABLED" i.e. no support for
> the Cadence Controller at all. Which "user" are you referring to? This
> series was introduced since having the drivers built-in was pushed back at:

We are using Cadence controller, and prepare upstream radxa-o6 board
whose rootfs is at PCIe NVMe.

You could build driver as module for TI glue layer, but don't force
other vendors using module as well, see dwc as an example please.

-- 

Best regards,
Peter

