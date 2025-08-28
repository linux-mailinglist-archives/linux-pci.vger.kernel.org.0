Return-Path: <linux-pci+bounces-35053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07DB3AAF9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6973C3BA373
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419A270568;
	Thu, 28 Aug 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Drtc/X9M"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6B25D1E9;
	Thu, 28 Aug 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409728; cv=fail; b=FCy9BvhlP3ZeCENDlMx1P7t6DVB6hJSYv90d3+gS579CucZm36SmTqZpRtiQrKEk1ZHeMaAFw7WvR+89IgHE4SroD2jqLs1GaiyP1abv3Hk0WgmSL4YNvFjhxUYPD8AJrNE1zAXjBP/p8bUaV/pxz7O4RmDKji9e9JWv0KxpptA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409728; c=relaxed/simple;
	bh=QEm4HwmAL4URzKrDR3wXyu6utypi8ZKxdBWlirDbaK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaKQikUMsNJ63qu9mhLMGNoBqKK5yi93B9+70+hgrbzmgcQ5e1Hpj2n7n4RWFojjtDCb+skxy2gkFLgYClr5Ez+VLNJPHhzYoNLeDFGOBAOfnorPihz4SRatEuLg/Zoe0YYORAIRJM/0H8gB3FK36hDuLL+yfgrfXpPommz9eGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Drtc/X9M; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9OWX3nWOEybonKoVbiT86kw+E7+SYHk10VRm9cbA5DzZu3IGid49YUzcF+fSso+DfFDVLIi/ClFQK18VB6HVeOGLHnIRcgJqvH0LlZu7gyw1vvJabukeGFzlcbOIDDqElnQlSvL2pyQXsTLPx9poON4z3Rlb0djh9vXRYy4zh2JdvPOHYhAcY4Wc0YxkNmVxq3ADmG555P8qusa8SoPKQJTAeWsKFMbxec1pih3xWoQBXhpBD6VxkX4KamomBGJrDuflmWxieNkoyenZQcG+Gxk3ogNi9PR5U1SlnYHy90SrGnq3cws8dGw+VRzjnTlod4bZLdghyOGkbhx6QA3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XgMkENTR3L73wyAV+uXRRvm5qmOP1DhbV717XUFyRQ=;
 b=ZuztEisGnpe3nleZbKooQQIjc69pUHihdpNog7SMFwO16cGC8lTOR/gCQBJn7HEYF/H6ClMFNf8sknlFQoQKcenEmIWPQVJWIa2zeQCpI2bIY4vjU86ZY3c1JldMXMLD5U2ssl2lEMgNjvMaMH/4lGaCED8zlOLasbKPbXTwPcZQUNvnTwHoByFzNn6UKSo4heH0ODgANGrETKkMvayxN1KdUEwdsYsPyXdi1cQdCtGVryHlLVJjqMArWpco4Dq/7SYgkPid8FT58z23YnPkob5v5wTC1jLJdrOrQ041uf0zB5b39iQmQhvIi5vN+HMrwq7LDRTadYOrxIrG6+DaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XgMkENTR3L73wyAV+uXRRvm5qmOP1DhbV717XUFyRQ=;
 b=Drtc/X9M0x3sl85D1j3q3L3pfca8Xm/td8slz8tY/SfIZi7BfnimXTLHW/EGrQvwoT8WgoHDfj3CDnRps8klxbO2hYzAJFWUBGO2c6N14ypJ8lq8gV/GVLUtYYELZpDr/qGdJUL4LipNufNniI7rbrABPCthXmc6KruXuOhU0q7rE7A2nvqBMfSDX8sdk3vnsNwa7hQjQbvi5eL7VKNUqpDKsu7klk60S++33/ic3tc23IFP66+DbxUGhP3pHGRkrrmtGBPfxJTgm38KUGn5aHM+fs1hoYLUpCfxQ06Gbd0DjMOz/xFlT5Sp7QUNM2GX7zj62xF4sTniWhqMxY23yA==
Received: from CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 19:35:17 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::5a) by CH2PR17CA0030.outlook.office365.com
 (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Thu,
 28 Aug 2025 19:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 19:35:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 12:35:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 12:35:03 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 28 Aug 2025 12:35:01 -0700
Date: Thu, 28 Aug 2025 12:35:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Ethan Zhao <etzhao1900@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <will@kernel.org>,
	<robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <aLCvZOm11EAvrpx9@Asurada-Nvidia>
References: <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
 <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
 <20250822140821.GE1311579@nvidia.com>
 <aKi8EqEp1DKG+h38@Asurada-Nvidia>
 <20250828125149.GD7333@nvidia.com>
 <aLBw3UTAX6F0IOCf@Asurada-Nvidia>
 <20250828184608.GF7333@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250828184608.GF7333@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: d826f1b6-8c1a-47a5-9cde-08dde66a044b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQiiDQjtGvO3tPwOgl97upHNXlwinnf6ipSL91H2MjjTgqjKc6e09UMw7YFD?=
 =?us-ascii?Q?mzhPUcGo0tEq7qp73+5QGPBXcmt14mz6Z5vNHO6n83UO7RzKyf7mFAaAZ18F?=
 =?us-ascii?Q?Uib8+0TuuadJx6FJ/2V8Qw90sUz1A1/1XqPwlTq2L0tacWyAATOR2EiRxA12?=
 =?us-ascii?Q?MTUT/Vext2rutI3hLdoGSCyHUe7Q4AiTuHb4jRWfrWU3b51JVLkDQNsRZxME?=
 =?us-ascii?Q?/YkJzYJQBDJnJ9sXQmEhIv0tdPbEqp/qmQTtG1HzqIiKUySxYBoGLrgEVza1?=
 =?us-ascii?Q?yb9HwXVqa2wmoscDmbhlmjQRVXhBK8aiwLFGAB2/uIXQr5dRBq1ZFf/LKO2+?=
 =?us-ascii?Q?XTZeRURfbHffCbB3Y7fjDcoKchDCKVubcWf/5HNI+blLQk5bka0ggNcUa2uD?=
 =?us-ascii?Q?tC74fXaBzj5UWxuzwx4VI2vlADJiOmgPE0fewu288TLExvx+8eBdWhqtU282?=
 =?us-ascii?Q?T0V0XIVDLDFmuIChbYi/idGMkYkVs4lKTHNr2mBcUhmXpfXlJGdUKCEvm/II?=
 =?us-ascii?Q?bW2RKQCwP220ZFFbJucljmuTGRXGcpNs48HmMpBDcPTgQgZHNKKOEf4Bte+7?=
 =?us-ascii?Q?0z3eFD1hxijadvhZfhwJzlEvito6EthT5WmfaMB5DZwuhORYd1issvu3HjFB?=
 =?us-ascii?Q?IanDdHz1ETXx5KVK3HaYNwVE313ZtwuF+LRWTlM8uDbl+7ilacFBc8+xsIZK?=
 =?us-ascii?Q?wFaWp2/ZmGxNxSS2iNQQSUnocIlstN9ddxHlEuiV/8fIpfOlZErrL3SDYpus?=
 =?us-ascii?Q?xY0SsflxI1QWQURDmueWRySDrV+crCGIXoI5RZjX+mJjxO2a/WiuqGqyA+IF?=
 =?us-ascii?Q?NW7PAfwEQTMYAmEXM5nYoWVqaqSK+Qz+dz/Cq05sjGFwSA0hhOMUYwuzG2kO?=
 =?us-ascii?Q?MccpcH06LGeoZLzUN+QbetImWEJq0x/soAPi1viKIr2JQX8FAGJ3y5ErbzeU?=
 =?us-ascii?Q?55L9QdH0D1MA5SV+sDJRlUB4SfytDElTFxKv/LgIHVnFUYcncIb3u6ZL58bu?=
 =?us-ascii?Q?igl4O81gpYaSX2D9n7Yw0UprQjCSD3a9u4H7vwFdJW8gW45VWkqOgbp7KUgD?=
 =?us-ascii?Q?mmrJ01Y6XqQ7km4L916GbTW2CWGyKDTbxdR6EC/tPaCQeRYFPtGVdre4UMc2?=
 =?us-ascii?Q?g5rPdmh4zlaKpzDLADn+XyJpi9x1f4K3z3o8RaMB3VNeo00mKhLSUkS8ySrt?=
 =?us-ascii?Q?qnBnED/OquG8U1vPrG1/X87hTubH8/zOrcnQWljonWyfa/QwsDAEk2vfXCaf?=
 =?us-ascii?Q?gu/2S6IapV+MdUqhkW21WjXVbvMxW2P0+X62sk5bwAmttNi1YpD3XQzPpPAH?=
 =?us-ascii?Q?KKs5I3APqx5iFvYHIlZgWDkrdjquJUS0dWUehNuXht7bnGLBO4dOSIqidtxE?=
 =?us-ascii?Q?JA7+4VfCfJV1wsW0FwCzkLdnVICzbbIGzr8vptPXTioMTx/pZzC+Da3guwGg?=
 =?us-ascii?Q?MntshWPsi/CWOcAOUw6EFAm8TM3d/fNfTnIYHnBX/GQz0GWVQwLeUs2Tweiw?=
 =?us-ascii?Q?plupT82O3BVNWGZvzh19twOrNWrIbVTGiD/z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 19:35:16.7969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d826f1b6-8c1a-47a5-9cde-08dde66a044b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

On Thu, Aug 28, 2025 at 03:46:08PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 08:08:13AM -0700, Nicolin Chen wrote:
> > On Thu, Aug 28, 2025 at 09:51:49AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 22, 2025 at 11:50:58AM -0700, Nicolin Chen wrote:
> > > 
> > > > It feels like we need a no-fail re-attach operation, or at least an
> > > > unlikely-to-fail one. I recall years ago we tried a can_attach op
> > > > to test the compatibility but it didn't get merged. Maybe we'd need
> > > > it so that a concurrent attach can test compatibility, allowing the
> > > > re-attach in iommu_dev_reset_done() to more likely succeed.
> > > 
> > > This is probably the cleanest option to split these things
> > 
> > Yea, that could avoid failing a concurrent attach_dev during FLR
> > unless the dryrun fails, helping non-SRIOV cases too.
> > 
> > So, next version could have some new preparatory patches:
> >  - Pass in old domain to attach_dev
> >  - Add a can_attach_dev op
> 
> I wouldn't make this more complicated, just focus on the signal device
> case here then we move on from there
> 
> Just adding can_attach_dev is big series on its own

OK. I suppose a concurrent attach on a single device will be rare,
so failing it won't impact that much and thus can be a Part-1.

Then, for part-2, we will do can_attach_dev and support SRIOV.

Thanks
Nicolin

