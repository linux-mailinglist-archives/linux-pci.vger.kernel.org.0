Return-Path: <linux-pci+bounces-32767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CEB0E8D1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 04:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788E516F954
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 02:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB6E1DF725;
	Wed, 23 Jul 2025 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBArHKUs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB29282E1;
	Wed, 23 Jul 2025 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239248; cv=fail; b=S2JY5jGGRF94scp1/15QuqIHnh4l2eq661ntF0XfFOUaNuzUYSZAA1F0lMF+vIGkNQ6BipKBAZuGYVscZgsHHVzcvFLoACKasBBAekru+XNxiViuPH59ZupjoqXW39w7Wy1Ci7bkMkn/eSJ8Vb6ipAB9uHmSylJV6P/f8aCSZsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239248; c=relaxed/simple;
	bh=XiCeRCUktmAj7eaeUU/61JdBGBODCpCZNb+MBwNqAt0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOQ0NzEL9dtLeKBjcvhSiBWtZwVCsJvjU4FVcqMSksLXbBo0FTpiAwlZQSbVaLr6pLPOdb0WNGGqaSb5oL4ulZyVOV/DLlnXhTZRtz6GCDK0UGcfspMU7oQyYgUuKX2y3htue8TBwYL7Ta1iMWitqX0miSE+oT9+jj4dwVZgA14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBArHKUs; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGCW6SJiJXklnEa/rxL89L6a+2nsGPMdfUokS1XqPjSdcWiezt7bmCqRo1/yINcUpguXKSD2eCrH3vXF9C8zyI0ut0uJgNfs7H4KqWAne9VyHOCREz3wD9ENR8oIEoZJyDTNLGm+H4JE9/aMaHVSpTO7rtMdoaGbWAljK3d6TySDmLyPRSqYHSQrAiYDLE1oqFPn4fBNriOItSLA2CckMZ12BCluWcVSD3RVjuu/WtjRQOPm1SpkjfQLpSx1LCKVpO1salVQULriHmiYfvA3BbidWB+fZmQA17iUCLteKbXwMbXi6ytcqR8OWu0pe+2hAcoyZ57YRUEYTxz6eB9+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUX3IVEZTifyss8uyWu2gTUjFdWteWeYuWY227DW5uQ=;
 b=g7O9sWGJzgUE82ik2BvfQEm8CayMRySgMNTwJj9lk3eJGYAqcgZTbXnHN3NPCCCOEUspBzhaDu00mTFcBnLjqPN1UH4yPIJc5Jd0edYVtaRX4g1WqN8RiLQzeasjuGVHdDK3eLDVPSnIThjXC6krb5EgF18UA3IkR+fuocQYHLJ9Pq0sgjKvuAS8Xr8UoHJ2q+uGw0gDz56p8wQxo3gtV1sbRaod5hetVPti0j5NwfP1137CI89zTV2/008v69jOByHdmFcmA7E4AJih7jvI8gEGTG2jZ0xg2AnKU6ypBNGG4qzOxZiSnO8evQyLXiKqBSFABk8ccr+89Sfg9CVq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUX3IVEZTifyss8uyWu2gTUjFdWteWeYuWY227DW5uQ=;
 b=rBArHKUsCl+8OTRGEAvk9nFVVY1N5E5H56mcDE4qDAghWh8VhHZRIh/TKWqXcdxMD9lndkRPHGY91JJDvpvv2FanCLAGM+VGn77CR3xzbyyJ7B4wrIHgcZ6nfjnDKVz6BuNXdJisGKeh+8RtfUlwnWBqkeuI93PJs5hDj7ICsmIe1iXcytEu9Epm0Xw0eH5znL4WC2fy5Xhz8UhisXWySyTLmRIEXk49onwKDOd3cZXmY/ySgUTGg9n5ohzGJKLkvTCOCvt09P8BAHuThvavnn2dDXCgT+GLsf9GUD63df1z0bUzM+Ffx7BH23CE+OlOppuMzdnXf3hRHOVcvNwhzw==
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by MN0PR12MB6125.namprd12.prod.outlook.com
 (2603:10b6:208:3c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 02:53:58 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Wed,
 23 Jul 2025 02:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 02:53:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 19:53:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 19:53:32 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 19:53:31 -0700
Date: Tue, 22 Jul 2025 19:53:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>, <helgaas@kernel.org>
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aIBOqSkbQ/1sub0M@Asurada-Nvidia>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com>
 <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
 <c57ba058-4b25-42a9-8076-98b72b304d51@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c57ba058-4b25-42a9-8076-98b72b304d51@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaf7022-13f2-4631-d1d2-08ddc9942ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+sgh1bQaB+CaPMrNJGdgFcjkdGz7QNobHVNfFeTGuyed3azAWqgc5m0dJ2c?=
 =?us-ascii?Q?1WQ5R3zJU5opD/qiQmEPe7SjkDI3XlQIAniqqjFcvvM8ukq/rtpEam3k3Fgr?=
 =?us-ascii?Q?vBCvdkW0zeCcEAstex+HGol/u7iJp79lkHTGLr7I26pSox2KD7+bIe1NfAmq?=
 =?us-ascii?Q?onOUWCoc1ox4/ag9486j3gzjXPNvC6GLKu1a33rCKJPnhTkGcE8XXxfUrGD4?=
 =?us-ascii?Q?C4YGN6WiBBIJ/uAThs97WAntkHnd6YpdGYWK7XxBNMDde415fAcfvbZAxJDU?=
 =?us-ascii?Q?mJ0onycs3q6J4ksqvGSqiRf0OASycE6anIHkelifXl+PkGTkJgeRLw0ISyuf?=
 =?us-ascii?Q?UKKtWFzhctSy9nLGQ1/bWEzbQav1T3NshpgTCYvmoiQJtJCB/iinay9iO78M?=
 =?us-ascii?Q?/lu7OD2w6ypMEp/TTl14iO7NLFMwkvCds/kr78ooY6Dz0eQBHHOA1gWi9YV9?=
 =?us-ascii?Q?4eRyk1kIAiVtR14uVLtuK7cDaDANTpl/DZ3OluC0HV7MXBtLhO6JGXqENGJD?=
 =?us-ascii?Q?NelO4EIviakpFXWYwlSRlBpo6DZjJPD4mmoB/hh+9AvOJ/0UPZf7KkAdYFbs?=
 =?us-ascii?Q?cPlgu5k9qgAZQBJKh9C2VoBD2386dEKCE9wmgqpfrjFizr/+CM41rqRYTxQB?=
 =?us-ascii?Q?4GLrV5V0UggVv4d4mUdNqObOS6g7IY7FX+hfBCIDXMbdh49zAC7bX1jreqno?=
 =?us-ascii?Q?pN5Fj+bkcfmlRSb8rJ55dJEuuCtgzG12DH5rbCYhP0wDiDQ3bTlADYrmdj5R?=
 =?us-ascii?Q?4T8fUSaquqq+qsUGhwWR2sUUAyoSDBvVyMTg01IMNMpt5Ebl9hToj6X7lqBE?=
 =?us-ascii?Q?isrwni+MCsR+digQADNDA4u6HXf1xaAciLZ5c9CSHBK8nsCtTqmQ3Iazz3E6?=
 =?us-ascii?Q?8kxAj5vlmQSbv75f9K8m++851wNxDDo67nC8BLfV6/bdX1LD958tHa2VSBNr?=
 =?us-ascii?Q?UaM4/xZtiQXt0nz4xI9B/liBmj17ycAs/V01o4uLjPUWpzvMW1z9F7WgbLvl?=
 =?us-ascii?Q?5E6MTFbkaZJ6dVnaANqc37QlOuaxQB2Jvlx/DyEfb4NKWeoaH+QW6sX7ji95?=
 =?us-ascii?Q?KloQ72DpRt1ahPgBjDnirlMvWtKp6XU+7v/A45/XM+auVG/ToT9T3OLi+tPx?=
 =?us-ascii?Q?IEsi7RtKsjvdJgsXAAIMlkReiocJb/vEshmFbw7jCYMZPyrirEKK9HUs9Z7f?=
 =?us-ascii?Q?Rb1jvWScTMRNDHPSEYNjD2iLgOCTtdfACtEpxqKwdenwULIJQjpsF3qc0S4t?=
 =?us-ascii?Q?YWmDUoRW+F7XO1EMVIrhg3Wkj791ip1o4HKspqznhw3nTdgoRcJsCLEI2WX9?=
 =?us-ascii?Q?+n0AVFY9gZrYCRQWzgprc78j44tAvDjvMxayofqNbIL1LCLSsKVMCwwL2cqf?=
 =?us-ascii?Q?XwZt1Ge5hF1lK6bzYEq5skuJmjH0czcYTkwhhYo6BhNi8dErEgWHl5vjvcbg?=
 =?us-ascii?Q?epm2MnABP1fweAG9a6Bu30/3wBTnyKexHKbNGePIEgb87fho0VDcOA9yp0gg?=
 =?us-ascii?Q?AsXxJ+xMGqlU051lj3JCBkGz8oR39wGoSN++?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 02:53:56.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaf7022-13f2-4631-d1d2-08ddc9942ae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Wed, Jul 23, 2025 at 10:21:41AM +0800, Baolu Lu wrote:
> On 7/23/25 05:58, Nicolin Chen wrote:
> > >     return 0;
> > > 
> > > guard(mutex)(&group->mutex);
> > I recall Baolu mentioned that Joerg might not like the guard style
> > so I am keeping mutex_lock/unlock().
> 
> You may be misremembering or mixing something up. I didn't see Joerg
> express that opinion. :-)
> 
> My understanding is that cleanup.h could be used in new or refactored
> code, but people don't like converting existing lock/unlock mechanisms
> for no real benefit.

Ah, thanks for clarifying. Let's do the guard() way then :)

Nicolin

