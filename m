Return-Path: <linux-pci+bounces-29783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D46AD9729
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7293B331E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D252737E2;
	Fri, 13 Jun 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BwZkKE7s"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE1272E68;
	Fri, 13 Jun 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849041; cv=fail; b=Mmfoa6kFnUy56NT6adrtkWGl/9fBqX/yD9qBz+G3ISx17sRVJqSD87lS/kDgmod4Y50kWwgiVGUdmJ0C2ue9rkfYj+tLH3euowaxAJrw2j7gi2xCiebJJXpHwmZF2J1vVFSNy+grwupqdJoa5At03ikRqnypbH9/xsHT/C8Por4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849041; c=relaxed/simple;
	bh=/p0OuZ+dfIxYJtuqw3WJUoQ9CqNl/+Rc6kRUV97M7Ak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7BKvMT2wicd6tohg4hib+DCVgR0Lol1NiKnFwurf1wOdIczqPrWrNTncKASa0CEY7qBTbUt7MTPUICYcnIEANPtS3ExuEAGfOjhN/AYAUbV6Z2JDzgLT3itMFHL4wRC+SYpBNpzB+4/SnqKvWTtYOp+OHWyiGkv/H+owJNf21I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BwZkKE7s; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqBVNvy96oPEXorOlF7xpfhrckw9t6Byhw6TrW3XoJPbrFBPK82txNKa93ojlbveL+tSkrouOHT89X7sGjczOOMiRFuGPnuegKuL6p6zFo5nF1k4CrPgy6vZTtpR8z6+cnuVD92q+Xi7vW8g2QUAgHYhrGEJ6WecjlbzuggMkVCvyrbNHdvjiTCrvWTjaknyo6fkD3eBqTXdWadUf1EYpo6eoMEGt49nfbtPVCJG6b2nKAuEuRRFQW1GiN5DZ8HpWV70al1vS7emjvDPycN2iiN9sPWJ/shXM3L4OB2OP9OMpZisAyowei8/r9MRqSKElXcLirTJ9ngbGvkcMpRkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+URw5bHkI8YkIVb/QgBPiHBJcp95HvR/yygtjmxnDsY=;
 b=AGDhHJfnMfpR3+ep0tmYu+A5btC4Q8iZNgZh9LBjtirJ10L9KqLT5s0QAKuCc6aq6hKtht+H77QKy1uMiI4zqt1/z7U4xMbx01NrOyIwwYiH8OQstFFFb5nSZBM/++ODtBwzNIGgI5TXZoylNON/qfbVACbTsVwlOScWhOPuZFFp35FipZP5DRK0yOQTHY53AOYuRNI3tm5sKuPewpNypCrdAOyMELV3Opbx84bb6sHhwKO4cf3Oq7aWaRKvk/8WManEMql2HXm57O8/Lvezmjx5IMPnRxSwBiyFA3lXRpgAKLTaFNsPWX5WT3450iiTjcH0R2wfYHT3MCFWWtPbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+URw5bHkI8YkIVb/QgBPiHBJcp95HvR/yygtjmxnDsY=;
 b=BwZkKE7sjg+auNlNcqh5z8Fj+ZjeWWEUVYy7Oe4yZFkZi0shOFnaK6bTdI8F7d0AKTu1qvpKK5cJOw50B0nIMAZeigwbqz3H5YI2QAPsDPCP2LniRp1x59l7F/jB3v+Q3VaAelfqX8YGQKv0zNGPd8c+3vBnIRFa5zpCQcdmS4bBPzA6W8ifY7PlOCT2iEaoaRQpYOgwVbppvN1LwFnRym8AZoiwmSFeuzeqUjwnUwzPrH+NkIRTchpm7Q/gRQv5/GY/Nkz7QBOc0BJfbTc9CghBc7kS/exTYqQngnFucADnf7vCik7YJf0LLeeSrfc9iEc1RWI24BnwOI9UaIbvUA==
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 13 Jun
 2025 21:10:37 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c7) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 21:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:10:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 14:10:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 14:10:21 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 13 Jun 2025 14:10:18 -0700
Date: Fri, 13 Jun 2025 14:10:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>, <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <aEyTtwcGLHq+ObVn@nvidia.com>
References: <20250610163045.GI543171@nvidia.com>
 <20250613192709.GA971579@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613192709.GA971579@bhelgaas>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c17888c-95fa-4e69-6711-08ddaabebe67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdiPoIVsC+0Ne8MMd4hNM8iYBZETO8lI3Bnj//39pAD8HHEvogv9WGZXWoel?=
 =?us-ascii?Q?mEObVWe0t3kfIfHnYzhf6lmPjIkqIaODr65UnvPf3M6LZ/GhZfRXAppVOPTi?=
 =?us-ascii?Q?D7pr/LoVXk8fv/3spWwkAlb/VQOoakhsUujQhL3PrbJi0QMok6A0ZIUf+9UI?=
 =?us-ascii?Q?JzHNwI3WE9coAOvyd/tvEQdJag2eVfB8J5x6RgWEBTQFSI/cvXJ4+ueZu64L?=
 =?us-ascii?Q?IlIj71U/ygNMnY6nMnoy85PucMzTmsT/CsRw9NLrO/xWO4qJTFCkzQjA7Bkd?=
 =?us-ascii?Q?HD2ztrel0ceLLr3xqCquNZg65AWkglFrFI3HkRufK2PcNuXEOhAJDUP43DTH?=
 =?us-ascii?Q?6rON4C8laJr7X6bdjw/pYCOSrgorF+d4+VNCTXECENKwK1E8ZkFK7dOCg4PU?=
 =?us-ascii?Q?c2c4ehFnXtaKRJrXEBMK/R6XPENiaccpYa4L43LQuQf8ejUpruwImanBUQMz?=
 =?us-ascii?Q?+y7VF8Sy6pIcT7PW+zlkw+b5sLFLuVSlX+B8Wy4Wk0HANCNm0+8g8AsTmRcm?=
 =?us-ascii?Q?9x5lWmnq3xFzx+7ANY9qcfdXYkyK/380Fz+WVvj7feWdFni/O94xjfTfZ9Zo?=
 =?us-ascii?Q?T7haY9pic8r+lwwJG9drv/68kc1Ur7uz8IQU9gTs07WKR4Q1P3iuLYRUOuEA?=
 =?us-ascii?Q?XK4YDIEsJ4h3CenHsuTjSJZj0gn5KKC7iDKmq8af7o6kTpIQFXheL9Jj/GI4?=
 =?us-ascii?Q?rvMuPfa3VOmV/IVcLRV6vwq78qkC3eeafQCjSbcBV32Rn9JMhKzPSDUsVw7a?=
 =?us-ascii?Q?725RQqgM8Ra4w/+gC/jFGNoOD/rftD/I190+FW1qV/+5383RwHCkVLguNMSi?=
 =?us-ascii?Q?Z6Z8U/I9AJnV+lhAB3FaACUWi7uDQcvhPPTXnWDl3w9NiQ1Viwe8u2IvydwI?=
 =?us-ascii?Q?shdQsLBPQjfckqMPLNE3kzgWN34me8aTJXIUhyfCVVxFoKtgg5RxVe0fYDwu?=
 =?us-ascii?Q?GcIkTI4PWUxQHmfJq0vs3rCGTZl07JtiGDP0dQ2u5/O+PSfF2T5BJOxP4fvq?=
 =?us-ascii?Q?Rd9H7B9/MNjFOEPBr9C2V0cA+M0YmolS41S0uUFMkWnzEnJSv+6WLBYnsyqZ?=
 =?us-ascii?Q?IRZJ+2UcZFJkz07zfMXa4/NUhUGGnA34V9hi9xsJ08qYM1AIgx1CnEF4+U/l?=
 =?us-ascii?Q?vmC6VEufOH7qhHTJ4UOdeAfnIyw2PDi6iELjVBeNTQK4tkO0UUAiMkpRtt+f?=
 =?us-ascii?Q?191igHt0bzqot3Tooe/c4erieuc2+iYy24OXsNrJsNSkjAdtsDXb93FtwAWm?=
 =?us-ascii?Q?jxd28uoiXAqiueKam87Aq/gxgPJVJBtkZV4PY4tevh1Y5lfkhVP0eM7/XUEL?=
 =?us-ascii?Q?vqS8T5eGHU0RO0D4kdCwXkWV4t8zJJKYFej+vJ/3uyFzu3IQe3fichIIg2Zd?=
 =?us-ascii?Q?2vVwZQfVsnSSZGz+mXHGUjsyacbbt9shq/nHCEU/JWMswEteP5DrLxZkIZyy?=
 =?us-ascii?Q?ungMf4PODuPfhlJk56L8F8NRKJihWI93SnfH2XknhNce4Z5sdpxPaGlXiaBN?=
 =?us-ascii?Q?o8vCSsXQ/c7ugNEAuu8gAiYlKPPFRF+/YsTK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:10:36.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c17888c-95fa-4e69-6711-08ddaabebe67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

On Fri, Jun 13, 2025 at 02:27:09PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 01:30:45PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> > > On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > > > Hi all,
> > > > 
> > > > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > > > before initiating a Function Level Reset, and then ensure no invalidation
> > > > requests being issued to a device when its ATS capability is disabled.
> > > 
> > > Not really - what it says is that software should not expect to receive
> > > invalidate completions from a function which is in the process of being
> > > reset or powered off, and if software doesn't want to be confused by that
> > > then it should take care to wait for completion or timeout of all
> > > outstanding requests, and avoid issuing new requests, before initiating such
> > > a reset or power transition.
> > 
> > The commit message can be more precise, but I agree with the
> > conclusion that the right direction for Linux is to disable and block
> > ATS, instead of trying to ignore completion time out events, or trying
> > to block page table mutations. Ie do what the implementation note
> > says..
> > 
> > Maybe:
> > 
> > PCIe permits a device to ignore ATS invalidation TLPs while it is
> > processing FLR. This creates a problem visible to the OS where ATS
> > invalidation commands will time out. For instance a SVA domain will
> > have no coordination with a FLR event and can racily issue ATC
> > invalidations into a resetting device.
> 
> The sec 10.3.1 implementation note mentions FLR specifically, but it
> seems like *any* kind of reset would be vulnerable, e.g., SBR,
> external PERST# assert, etc?

Yes. I forgot to put a question mark in the cover-letter, asking
whether other reset routines would or not need the same trick.

So, let's apply this to all the pci_reset_fn_methods.reset_fns?

Thanks
Nicolin

