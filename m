Return-Path: <linux-pci+bounces-29278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790DAD2E29
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4501890752
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F927A469;
	Tue, 10 Jun 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4n/Nu8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F24221D88;
	Tue, 10 Jun 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538566; cv=fail; b=Z3BHLwRS1epuS32Wfw6ov7dJZkQqpcUtyL1SPpmtcTgwjcEra2L+Gf7J6a2ITEyGaRclUVMSP66YxR+yP8djWQgocMOrJijx6d3STF2Dacz7Hr4WQYWSlwmXINr6B3pU6NifvahfSUBK+pL9t47GpxtIWbda/ZR7RfLLRIOwWhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538566; c=relaxed/simple;
	bh=rHxcNI/jKQ/w09IaTqxGn+IVphFr/SqIjClot171EYA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv69UA7yy3fg2vfPELk7gkf2hcFvTkyL8eXZQGLH41pX35BKCLncW8+qV/WxMLzkyjxUh8EGDrrj2XXb8DdPGvvtr/swLKf7qNzMJtdzzeDdyCmcWGtREz6qRM2YegGFz4ls86x08/QS/GfARUev1MOwmLxRyjH7Y03JInoyMR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4n/Nu8l; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUs8KR5wkcIekTMNfK/PpR9fgivmpQBkZQla5+j15OFHNpgaMdS+c9C6yZ7hl8tubJu3lsG71kk5loxrAyDiuOK/baqplCLI3Cfa6KJQaO16mTnO5Papudi3T7pCZ8Hg+w8txoro8CtXg1fyZ68evLbvHvwK5Tu5jbn+SEbeuMefW38mY4GoGxT3gawrtuS0yNE+TzeoXzwiftZ1OOnj27KL2ViXqntZBjrKTYtNlXrGYiWeA6rsVi2Fl8vKkTS3H7HR2g3tsFssw7LQoKJkQX6T/NktfnMtn9ihT3DWOj3zrjtver8ZOgeTCEjcL+e6F7CdCCiRtoTPSWs/lhMuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMGdeZBBihZD4qE5JZtjkAH9CktW4Fc9fEH6+dZoVZI=;
 b=cb6440m7n1XnuVJlNCkyBF8eK67wt5xDaMO2e/uwtBVJ3ebjky74FeKEazhpg/ABcvnRVqZfrkPRDOmFy/zIVlk8eorQ0YM9MAa/0TU52xJPu8Ji8n96wsxiEePfFA1JrEaqOdmKHypKbTltDzul1HOjB7jJzjyLFhg89vrVkwiTl6Jksj9vds6Xb1iqleQ6CEB/1hBoieJ/0EHDbYI62/pXhror3nmQunOJ3VwX8AMNrhHEt7Nj8pH1UkJ7z7PujbU5yfER96kzxhMiWlGfdHRUcfUkL125gV/fsG1pGCIbJw5SL7+aWb1J8IK+yzP6Q9yq34KRpVcSUB98RuP1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMGdeZBBihZD4qE5JZtjkAH9CktW4Fc9fEH6+dZoVZI=;
 b=m4n/Nu8lRIiIsJy6GgejHOnSjAcIrj4dnMCvUk79xhAHSS1IAOo/h3gNRIhnHAdjmbrPp3Q5Td+7qYA0GbmD+k7KvnSrp7n4tT1Z3w/DcwypxNDO8dtIftuhfOY3yGWI5hSMPgOGrGSI2qii8KQHPBjWYPAtCb/92B2SGQYNdgpkKxbpafeLAcICi437jVeFSbMIChRnrXCKAet5jrylZEgb0C59Qi3HW3Q+bNOd0797511eXYGbtJg9MwkhhXu70MZcx6iRwpbh40w0sKTfMX4f4H1fIYpx0gvX9+xZngFO03LbVKLyAjhloZ+8JfUQQjUvwyDxSzlO/VIkrMQ6kg==
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 06:56:01 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6f) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 06:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:56:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:55:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 23:55:41 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:55:38 -0700
Date: Mon, 9 Jun 2025 23:55:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: Re: [PATCH RFC v1 2/2] pci: Suspend ATS before doing FLR
Message-ID: <aEfW53F8Gmb/NYs1@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <29cc1268dfdae2a836dbdeaa4eea3bedae564497.1749494161.git.nicolinc@nvidia.com>
 <34442ab9-08e1-4e9a-b08e-3b81a581fec3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34442ab9-08e1-4e9a-b08e-3b81a581fec3@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c366e1-a0dd-4347-4c7b-08dda7ebdc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irQ/AJSoj0XmGmzfuqeBe0/k57EH+3qqTe5g7+zaUhuhdJZdBWrWVKYZWfQq?=
 =?us-ascii?Q?HyH+GybPLC0o5lZaWXexEIJ9uvYHx+6WQPT4x+w3hzD/K5s3g0gNZD4LTlqt?=
 =?us-ascii?Q?xZ7LeHmDFfx18+8PWGDEjpJShJ1yd+Lx/9JzaJNBIzXDzm/IDR01gHiYDENI?=
 =?us-ascii?Q?LDhqmDCAqyODgnRTlunYFk+HZ4O7H1ruKZf5kX5y2GEeHwW+q/Zcc6ZIiGsS?=
 =?us-ascii?Q?9BhGfPA8/WWkR3tWa8ttoSjci7bZP+tavZGQl7BdSSgWvfI8aJ0uH3TbuOC2?=
 =?us-ascii?Q?dW3p1e2jumvnF73/Hpu2hpWiFBIZsiJsWfjg26o9hJ7IFJYceB9f4QIsbaq7?=
 =?us-ascii?Q?JZJWcrcEZ6IIFQu7CO9CGrHCrLoEBd34ki2ByNTFGUaorP802csqKuVjbSc3?=
 =?us-ascii?Q?xeN0WX/M5kqV6hvlzElrBEBR8r8p3I/MDOyZDGMkICyXa3+S6o9WJQrqx5og?=
 =?us-ascii?Q?64Hkmv4L6LYGaAxTHBBSb4pJmbkAwqW0bgETFPsLzomaMRWTWg0S+je6FaTu?=
 =?us-ascii?Q?1t1UcLlz6R+t4RxXfaS0zDFxKUF+2XmycBQ8zkeT9FCoP2VNKmsxCoEXMCb8?=
 =?us-ascii?Q?dpwjaXJ+ZUgRGBQp1RZuLzDLZH0z3xoLMNgn2w5nLG3a9ov0iDyYx5c3YOLi?=
 =?us-ascii?Q?9zQYXavjkiiKeupqET0gsfNfeXAxwUvnX3DcPwKUzVe7mdkaKSWIEchNJoaS?=
 =?us-ascii?Q?L691QWft/k1ARmM3nsHToOeqMrOcA9cEQJJdJBs5BTBDJO8YZjjQm56AEhnl?=
 =?us-ascii?Q?5XWYmY34R+klQbuu/KvXYUD+bGwFaLsUv4AS67k/rJ3Y0D4SOccMi3bLIq3l?=
 =?us-ascii?Q?engIAtuYa5MYbSwtIXIK4blWL48TJamoqegucJh9WF3AaoLSSW0s5eD0YsXf?=
 =?us-ascii?Q?F39ft3ezrn4nykrYmVsdpO4nUYsKH6AZtd7fKy2hUABFk3TToyopIrEEY1sK?=
 =?us-ascii?Q?Mp0Bl2mt1xbiEY0Ff+yu9tbzO5POLGjutes+1P4c2qE/S2mXZ9zuv0BTfain?=
 =?us-ascii?Q?N0m7hUHyfZrfjuAYaubrbmvLklk16c7QnKzH3xMTrOlSoMODPWTpwNPSmYvJ?=
 =?us-ascii?Q?3Ciy4vgZT7DpZKVFgoJfPFCaRcLPeARFRS2t1NHZ2xX15D7m5qiWTwGJ3DAR?=
 =?us-ascii?Q?CITgAcAnhBvu6ZaYic9/ThIujwEzyJY6rPa2Y+hdOMLUzXs/wlurXBCBHz1k?=
 =?us-ascii?Q?jx4F5pYxXUr8TjLYif83POOEKb5Vy8eSHYxsybzYcueZvykR1MbNlNHpsdxQ?=
 =?us-ascii?Q?Kfa7XV0TwBaMWi4pfHlmXGPhvndZVuSMds4Dt1aRVXEfqQXrFug376RutaCY?=
 =?us-ascii?Q?fRg4FubhUd72mYImI8l9FqIvrA05FbUsdVZcu3cX0p2WHQ/iSQddDbOwdp36?=
 =?us-ascii?Q?Lz4T7GD+wzNenKgyaXvMPF2RaDhcoGIguYaw4ShoqnJogGP8A2Xw8+mXy+4X?=
 =?us-ascii?Q?pKyN5Qwfe9FxOCZ2IFYF4qmtZVqsESPRsvl5wgDBnnnsabY3YlouX7b4q79C?=
 =?us-ascii?Q?mCsWSEda5TVAAu0Je/VOzA4m+DfvWES9/7B+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:56:00.6898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c366e1-a0dd-4347-4c7b-08dda7ebdc08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

On Tue, Jun 10, 2025 at 12:27:04PM +0800, Baolu Lu wrote:
> On 6/10/25 02:45, Nicolin Chen wrote:
> >   int pcie_flr(struct pci_dev *dev)
> >   {
> > +	int ret = 0;
> > +
> >   	if (!pci_wait_for_pending_transaction(dev))
> >   		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> > +	/*
> > +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> > +	 * before initiating a Function Level Reset. So notify the iommu driver
> > +	 * that actually enabled ATS. Have to call it after waiting for pending
> > +	 * DMA transaction.
> > +	 */
> > +	if (iommu_dev_reset_prepare(&dev->dev))
> > +		pci_err(dev, "failed to stop IOMMU\n");
> 
> Need to abort here?

Yea. I think it should abort.

Thanks!
Nicolin

