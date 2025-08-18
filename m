Return-Path: <linux-pci+bounces-34217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F259B2AFAF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0916636B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D063570D2;
	Mon, 18 Aug 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZmATUor"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCB3570DD;
	Mon, 18 Aug 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539133; cv=fail; b=R0gjreGPd0l7W1XqXMLShje9f4obFqyRAYpAwt5CQdkug7Xmtl/MY+KolZ4QXZ6qsdReJAQEHE9sA+lVUjX0niyXn2BErfgkqrYNtqJrsZVqTWKu5TPaWwfDNXkoMoFCOPC2oaOpI9piLvPDShKQsRZ/U12gu2BsVCZNaHHKLr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539133; c=relaxed/simple;
	bh=Cr1PtJYvK7wTpmw23fRkw9QrnsB+W26/BPwQ9bjbOwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhq60iiT18rMpfbGe3KHtrIwUmmuaInnjFhcW8HxtYswgGmLDSN4hjg31lI63YOXhbSgS+utNEZRtjbBx9p+LpqpKc4HChNne/Q7vS84Osr3QyPWII5StGxKAKY6IfdF0wwdzVEBHv0fsk1ZdAJdJsHIHFdxwRm2fD+JwJxYNFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZmATUor; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncbgU2vL+h/+/rjM6WQM/DgsT8wTGN4NGvIc7JvoMoqSAdwjCOcLfMT5KHWgVVR+2vc/TIUnp5BH4gbem5M7yI+lbq8K7lXfKY1Wn+Tud4nFexeCRW/74U/tHq6leeYsr6tTbfiRUUzg5Plfqb4TkFcAVoiMnmk/L60j+r6ANW8Rk71pdyoIZa8sLaW2Ie5gCpB1Zm0+N++lihhvi7UfbACIA0qvO77pQaU7Oszpnb8+V3HDRMCHgWL/QZxztGeLDdzGeCeDu8hT66d7zPW8CMB2z8/yZcM/3COPI8b2MydPCZChtMziV4OVoLOYYGn9qD1deZ/y6IaXmax41lkuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkndZUYW+8KEPTr+EqB4P1ChdAe2DTUcaIc1k1IW1I8=;
 b=KcvAoFziBowhbLvfnmT5a0GeroWfrJkrH3Y6awCUDovFIJF+F5QVORXsR9yPfo9ExX39PQqyHr/oKvUmb1RCdan9XUvUvKK7TxDkNhhZfO5QQXkM3ERri13h2u1uqXCpjqDUXC6/fWh7Xi9g6Os0150lPhwKZSczunU/M96LsvjmKissRpmjh06/UBYnGR1RyUszdPRNWptZSzQckXq8B7qM22v3nQogt2tI3/cFMOZ1VR3tbP96142+bELTUFR4bSaUJjzU3ZZ1UEYKbcHydo4CxM6E5iTujXoxBsxcBYBOle9LlnLiQ1K0/k+NLGPwjqQYAqi2nj2VymRmKI6WCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkndZUYW+8KEPTr+EqB4P1ChdAe2DTUcaIc1k1IW1I8=;
 b=SZmATUorSJYXmShmM8JQpiHMbjv5c9PAzUqoAMTLIvVupJI4IV+Jept9rUVYvXjWJKTeDu8JuzOb+LYehvuDOaISCCZ3vgI/s/5DxgBicqC3+Cm05ZOhkMqAElv1sLNhNJxh7UmEFCQM15ERknt0cw3fbyyl6y3GspivcwUlkB4lgPI6e2E1XM9F+eVWYfMuPiPPLchPlb6k2Wo7GJFwmk/AREwsLd0kkmEk7hIMC0Q3oXG2wSrRMYbHC89Lnj/q18jPw7nLWaka1b1i6AocwP51aUvbBbkWWinCj/i1md2USHZORiegb3pAo1qnje5WTlIVV5obh4SX/VMMC2fKZA==
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 17:45:29 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::99) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Mon,
 18 Aug 2025 17:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 17:45:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 18 Aug
 2025 10:45:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 18 Aug 2025 10:45:09 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 18 Aug 2025 10:45:08 -0700
Date: Mon, 18 Aug 2025 10:45:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "will@kernel.org"
	<will@kernel.org>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "yong.wu@mediatek.com"
	<yong.wu@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Message-ID: <aKNmo/O5aXb88GKK@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250818141751.GN802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818141751.GN802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: f448f1af-1d98-4d98-3032-08ddde7f05a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0T58YcpWRzYo/1yRG1+keCM9QSVCHa57+69a/IQS4ZkrfX59sxxuFU/6coK?=
 =?us-ascii?Q?D4YqgtLU74MUpftpTwUrsPpay9yXs24YxSGXMYwXb/tcAhlRmBR9KbI5Me7T?=
 =?us-ascii?Q?EXt7RslZEC5CifbZ2fHbKIbNeWIH49k1d/2n47oYuB+RMXP7ekvsd1h5FIOF?=
 =?us-ascii?Q?H4A58WSc0lEqJfhf/DuA9yMxmgrKhF28GoCYkLLc6n6/SBQxQvF8qw0NBlAH?=
 =?us-ascii?Q?0TEaMACEHAjipizLu0b/CRn2txwd9NtdUu5L6rWNLDmlBuXMpI2R1837herT?=
 =?us-ascii?Q?GDjHXV1eAdi3go8h7iScRE+v3HASCRcprT4HTgqikFwOn+QAYohM8JB56Lie?=
 =?us-ascii?Q?k6OK6Gtqzf+lm5PmSEr02JacGYWgqauwtrUV4wvMeH0IEg5h3nlAEXfyAJeu?=
 =?us-ascii?Q?8DeWHowVwjAGy+S+GsEV023x6WsZjAnnCTLAk+YUAES35HgWdXwrGH89V6r+?=
 =?us-ascii?Q?61Iwn9emnHcmNSJSVff/NW1+aIUCgVaIca2S2mC7Pjssnw0EArB7tgQoUIO/?=
 =?us-ascii?Q?/4HeGYu/a+/3wzJyrLK/tEpgxCR9Silq61Mxbv95v3Vdr35x2k29lREggYCr?=
 =?us-ascii?Q?P2XTh67Y5YllGwe6db+QtnadIckcIQBsVeN8BLfFwaSDIdD8JNK5qg9eAWZ5?=
 =?us-ascii?Q?2R4cCwgFutPpX225fFK9hVRNohIHPjoSHGaREdgFZG9Nc72EIGmvCE52j0mQ?=
 =?us-ascii?Q?ZGcvM+JldPLhYy8Oyb79AG2eVbjTIkUofJsSkRFTd0M/bwMci/MWhhtEMP/5?=
 =?us-ascii?Q?dNUe2ncjtohZkuGSCXQnrfeqJvqIa6Sh/0dU8HF89Ne15y80LsZwuHlEsvke?=
 =?us-ascii?Q?l5/3SQ/aDNQJ5O5Po0ejYzDySABqEs+m4mengvzUmj5Euh0AMEz4nYQ6KTNA?=
 =?us-ascii?Q?Cobw/HiE33JY0K570E9wYMkYvYEVw916Oz9Jna5r5bTAuwpfm/Pa/Lt4Zc6E?=
 =?us-ascii?Q?s35RZIohR1L+vKMeX29Fg+ER9lXPQ7ekFSyb3WB0FR/t4SBTilu/9NnbQwtq?=
 =?us-ascii?Q?MfOkJlZtCSmuVC53y8LIlEo/3GqLP5MFmCrsi1moHnZZmzRn7X77CMT9JORY?=
 =?us-ascii?Q?Bv5Ne0QmjiglPuYc/QRxHPSlHDuwxBK39NQ1mo5pueCOmN0CvxLFatniZZ3/?=
 =?us-ascii?Q?boFkxky5Z8AAgRZZ4grDkeaiREge5EUI0/1Hpqfiodmo4iLW/zf1++qwVDoL?=
 =?us-ascii?Q?0Y8TFsB19R4mAc6+JGbVu01KgaY+quukOq1U5b6Hro3bZlO8sSwuluBD5X6h?=
 =?us-ascii?Q?8Nx6cUDdOBDmqlAjiptis5aq8iZkcM9NHbDJDiU+XXeH2hqdskT5Tulvz6eS?=
 =?us-ascii?Q?iyPyO7/0hKt8dc+UqPxDg+5gqUaR3Ga4vZqIHEiAwW1JDuodIDAerkNuWxiO?=
 =?us-ascii?Q?yMNXO54Dvj1h+8/aiUYiA2Qvp+u+t4JCZ0jE59UVOSN3ZuNcqY8Z+xaKpZNg?=
 =?us-ascii?Q?HJPN51qYv+ffsqFPvZsyVn2WN5TVylpFRg19ufMf5iVxezbUkgxKN3yRgnWN?=
 =?us-ascii?Q?MIHtH8ZG5LztDJbHjqaE35HDZCfy7Mlkstsu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:45:29.1703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f448f1af-1d98-4d98-3032-08ddde7f05a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

On Mon, Aug 18, 2025 at 11:17:51AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 15, 2025 at 08:24:57AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, August 12, 2025 6:59 AM
> > > 
> > > The iommu_deferred_attach() is a runtime asynchronous function called by
> > > iommu-dma function, which could race against other attach functions if it
> > > accesses something in the dev->iommu_group.
> > 
> > Is there a real racing scenario being observed or more theoretical?
> 
> I think the commit message should explain the actual reason this is
> being done, which AFAICT because the new lockdeps added in following
> patches will fail on this path otherwise.

Hmm, I can mention that. But I think that's just a part of the
reason. It still doesn't seem correct to invoke an attach_dev
function without the lock since iommu_group_mutex_assert() may
be used in the path?

Thanks
Nicolin

