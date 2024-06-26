Return-Path: <linux-pci+bounces-9298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8B91802A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176611C20481
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AA617FADB;
	Wed, 26 Jun 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IdjN2mpO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C9139D04;
	Wed, 26 Jun 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402609; cv=fail; b=s4EUdpWF90YqJ6TEieGSCNtws3XpejZfbevjN/uzEg0DComDGCDgVr+UvVBhL07iOeEZfDfHXhhYBvxdeet5ILDJCRcSly/Yt5NVooHgW+xtLj8RxtFCb48vJ1vE9vK5IshrR83POQjl3uzpmHKXLOrzUlEyZNfYxjsonG6nBso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402609; c=relaxed/simple;
	bh=eTK8ub7/hphrqyiPUG9xsKsBZX1Iii331+nplhlOe+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Noi/LjPMrDKchpah4LyXqTr4M/sLa3hCO9zKHG0+s18vmOTU2VEsLnOZzejhtK4x7eNd4Y/vFJRwcr1t8UejWd80XD1Hv75BDyx9chxwXvmD+Eorvc0GeD39iblV2OYLDTZ7Dc88lQfEnQzzaJKVrWc/vTl4HQ/jpOzqZyD3KQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IdjN2mpO; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq6AuwcN6oOqBbABHQY5cakqf95mkeLkVad12HG1oOqEsTp+Ifz/PY4GChR/6qzvCw6YBqTw6SGfZsEqhNm2zk6ukGDhshS/JfIvvU+0t4YdCjWLosIp8pHRDtf8Sa4ddFKP2End1bgmtg6iHfeIcJvROC+3lFKaEvoE0GlXkNYqrVGEj7znkbEfGsvaak6Yu7z6kAcKAwLSHtqGOOr07nLJTClbZIb9HLq1qW0GQWAtFgOdGHm0C+HpRhl9XBEkNE8MFBTkheoHquq5j8OQ0KIJuTjKHLLndj60ZuWCSdn9ct1/4EO+VdlLu/b3POrirs3GADR3N1+oHqV8+oLieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqL6UPIgW2aFM6zCs/ZNUXW9+lAIeB+HL+jDMBVi6GY=;
 b=gPV+BrjuN3PRf1JHzKZCwllGNQ5UFJRc5ym1XwX1gQ9YlsFTRWZnD7Lhw4uOEzDdySa4AzdRwLRvQ9mDtRN9+QFghIZdvHDMFwf0iRfw5yKoROOXZsSiDn/YSJALcUhjL1VG7lCSmh915uS1exz4QNHOsLKT9b4cGL6RJMsXi6e0kR/deVvvpgYwCNrTPMd6OcpnTTdRBosP645YoUg5n5A/zUc2986xb8kYPWWr+I3EeqfeB8ML7nlE3aqNwsCfD/1d9+R5yv9xQvKwAY9FkdDbVHaFcKNqchTgqtwycLGLxtjSepT7BSsZirrwNG3mjsKLOzWDmJBKwSzPEVSXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqL6UPIgW2aFM6zCs/ZNUXW9+lAIeB+HL+jDMBVi6GY=;
 b=IdjN2mpOwo81kdYRQQCLAo9YiVhJK0av6/xjYSHPSq2xgkOx7VO47PGNbPRWi+EZeOmkILkn0pPneQm18yOxFD0mT9JHDQu8ydWU5xOwHBZ+Djm5CNLWHis240RGNn2qdZmmNzZTQL0YbtFMmL45YyDFwVbp68mwiiaZ8wWjyqOkgSelBNUvrQ5rESFi9VVT6u5o8ZaIP2jW/YUgbM5l94RAVbUVCihHgQIJ3md1KmsUKt0FnmPQlXSr34H1v6ekiSIVP9vlLeKuXloKnM0YaWyiQA2JKsD0iphcMR5vSsZuICfZw6WRezS3I4M0UqjlzUORMuojdcEXw/7rYNGxOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 11:50:05 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:50:05 +0000
Date: Wed, 26 Jun 2024 08:50:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"galshalom@nvidia.com" <galshalom@nvidia.com>,
	"leonro@nvidia.com" <leonro@nvidia.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"mmoshrefjava@nvidia.com" <mmoshrefjava@nvidia.com>,
	"shahafs@nvidia.com" <shahafs@nvidia.com>,
	"vsethi@nvidia.com" <vsethi@nvidia.com>,
	"sdonthineni@nvidia.com" <sdonthineni@nvidia.com>,
	"jan@nvidia.com" <jan@nvidia.com>,
	"Dave, Tushar" <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kthota@nvidia.com" <kthota@nvidia.com>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20240626115003.GD2494510@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <BL1PR11MB52718B54937B888AD9E394D78CD62@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52718B54937B888AD9E394D78CD62@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:208:32d::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ff61a1-6697-4e8b-14f5-08dc95d61e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|376012|366014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nec6linUD79wQgQdaMhTWUaHGeJIBtAHCWcl/qM6KhOVD4vcp28kd1OTZpcD?=
 =?us-ascii?Q?zoLReK9Cwwdf9cD3TxJarVb/OQvZ4UIW+BRxLJrJKl/JTZEa51bvf6kobFRV?=
 =?us-ascii?Q?cFSImZ5nc8NxiFgzC6SkPZjx2vzVt4GSWbg0QJoJUTe3epduZCWInyXRZO+R?=
 =?us-ascii?Q?yXioVui6XTllJRxUlv+C4T8BYPUNiIkXv3OLjHt9ZRaskc3Nv+DCAG31YV6o?=
 =?us-ascii?Q?QB2At/SXrj53PucxTV2NEvoLU0mJLMSt5QxQT5585ixJim5vMPJR4S/qt4sP?=
 =?us-ascii?Q?PuJ9nwoUPnOh7UOW8nlcOB7T4ubMgC1BKKUQwxqafgTNog5mref1/iXtJ3c0?=
 =?us-ascii?Q?sgNhnhqCe8FJAkSfR1pxicBH82XBpYqOT+5P1Q+f43H2Q32CwIAW8T9kNwNo?=
 =?us-ascii?Q?aU9uCpQG5QoFXeCo2PbWn+6+Ym7+iUDYoDu24TitSjA/NmvIIKX5AZb76TKd?=
 =?us-ascii?Q?TU3WdEyEAK2UgzyI7Ltmzi5a1Mz/eBR8RE6Xn7Q5LhM14ZCSDpmyrtAcLB8a?=
 =?us-ascii?Q?onCM6sQylr+Dq6ZS1oEnGGdGzJHsA89FzIACLs9+AVtNkIwsFlkpNxN/6WmP?=
 =?us-ascii?Q?zqBlILK6NTxLD3eHaXcjGJ0LwkL4PqL/1ec33uoLwxfei85T55gVKJrUS2qV?=
 =?us-ascii?Q?uqVSkoq5QZf0csy3WBDDZ5yBWvOPWqWYAy2IRJ8UuWV+gedgkRRjrwqEJsRK?=
 =?us-ascii?Q?12mgT4XuZQ2p1oFGIkz7Arw3uDRMyCFcMZqi8djuR45v45RGFQ6jIZ3HJ+O8?=
 =?us-ascii?Q?i2FBVG2pddKLYrSAIHtskDFfUo87QxESZ3Mg/KKmaplp+pkmnTtDMWA/kSo3?=
 =?us-ascii?Q?4g3fpDk6vaAp6AgW1Q1Axa5w/DwkSh+C47s34dFPQMRKIFrMtbOdu1y12vRP?=
 =?us-ascii?Q?StxdJ5+qLilgiPp03bqZyT644/hFm3hamQWucQixx4u3CHukNVZes2c9RVia?=
 =?us-ascii?Q?+xxl/dJxHRaZlDnCMTraF+TEAaR66ea1eFmpfVoLEP7cwXTCQcsRW/JFu5M6?=
 =?us-ascii?Q?N60ZtfNnq9nVuplbIDHiz6Z1r1T1VZ1mftiRAwC3PapZOFhWZ+x6RlwxSP2f?=
 =?us-ascii?Q?yXi3zmzP3dnCExQXF0LJvJJvnoBaJYoaRUQTzO5qvAtbQN9triQ+jfQPkvl3?=
 =?us-ascii?Q?AElB7LrSeMBIH4iard9OEm6kVeEE/8+PPdWu/qRIDzrLRNlkzvNbNJ870RVl?=
 =?us-ascii?Q?KDftxK0osjtH5YW3YRVt9XrxgwbsJCo8kUK7/2ryrHF1yvNU6GqTN27awshg?=
 =?us-ascii?Q?FR4/yPurRgtz2uzK4VLpYlj5qbyAQLrepbqTCmutt7ddWWDAyCeNB0+h/Ae8?=
 =?us-ascii?Q?I/ET7R9MEfOg1WMrux9RpBJF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(376012)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1ZTcgrZ9Qc/ryk3r8Ub8DfieaIzvjtoc5T6I5iAHa0Wge9odr+9GBf446Tu?=
 =?us-ascii?Q?IsvrUCdQ+fW59sYv+4EReSilJLGOrHlHMffdjEIZjcud70rK2PK58Yt6kRIi?=
 =?us-ascii?Q?2YjYmph+gBLUZrE6sHdn9OS2blu5YBfQfavx8roNRbyBDe7VRrjP7Yg3dTeq?=
 =?us-ascii?Q?bFJHUSL/3VXqILOUt/5kYSKQScbgiQdnOhdqB/v3h0faNn0NogHqLCmcyXbU?=
 =?us-ascii?Q?soofh9pfJ4bq64UGtxo631GkzPTSKvXr87BND8rfiuADj+VsjttN/ttmVp/j?=
 =?us-ascii?Q?9lMcqhgqReTmXIDpTZdvqISqCHsGBuA8MLcfiLA0pbakQNa7Jdg4TTGsTbls?=
 =?us-ascii?Q?lxYw2iZTRUnVqBo11Cb1WbgSFPG7iaAXiFmp7EZRmnBE89w8Mu+VkCoLiehh?=
 =?us-ascii?Q?4wWRBfJ2FKqrI2lHCjxCo0PaRqIeimzzB9LBtTjzdT4xdiJNVhEfUWTV/jbQ?=
 =?us-ascii?Q?B0ppWJ5dSft2xR40GfCBIuavlkMB9FxQAgNcJtuhEjKxsONjCgVnwJej6KmU?=
 =?us-ascii?Q?YwhX11c1X24ua/5wPm2IdH5/f7TG2mEDyVjwy2qiTsYf7omnALrAW/BzA1j+?=
 =?us-ascii?Q?ybSl4QsjZzcbt1EMp/4VDUzjv+rLPW9Jm0QJxl9nDubLGr3gkx8zqsERMvci?=
 =?us-ascii?Q?lo5UjeoBYm1143+7j5UG4C989MOvg6KYIPB3jnA0dtJ5WNvEJ2RrH3BfU4ei?=
 =?us-ascii?Q?jgPdv7/gX3c54QkAyWgrnzZjVi84XvyyEAnjQKBh9n8Ulc5/x2gRNE0qkFSE?=
 =?us-ascii?Q?0yis311OXlw61hjpPpvcm/hUKxzLQT7Gpdcm0VIEHUt6gncLeFghzYIc2/PB?=
 =?us-ascii?Q?pS/TZQeZ3Oc1gJt5oQqYVDLglKDcngxWaDjd80JqUJoqQ2qqL6A0FjTA0Pk/?=
 =?us-ascii?Q?B8eeQ+n+VWuORH8YsJ+CvCSMhm9tCPTY2MsNDVsBgwZ3M8JNW9ErkK8Tw8qn?=
 =?us-ascii?Q?5747zNohUltWjocs8vhkaUOywBAVgO1oH1dLMQtnVfN+y1J+r2cYZSD7IkDV?=
 =?us-ascii?Q?qlye3N5fr1XuKGtXBxGpGPeVtoDdn2ZZ3dMoxnu3gsZQnVDU1Ch3SsjiVB+A?=
 =?us-ascii?Q?uaHi8b7mXH2jhONCsBjPKj7QPG1vFHND6MjWyPhlOhucpWNoY2rCOcVWHQaj?=
 =?us-ascii?Q?9biGyMB3vBNX1LYDy4ejTMjmSZolL5QPjp4XbtmmQaWEuRzSIzGePeVcYpvw?=
 =?us-ascii?Q?tMdQj1EZkjvjsiMpDc5I5D0T+WqesKIWGyojiPwfhHgIAVrl8BkRzVjN2oUx?=
 =?us-ascii?Q?ylUC9Ee9BZY+R9mpwksuQACTCl+CjMhHxkVGYE8P/12V8a9lFSfGXRnrEbAl?=
 =?us-ascii?Q?FlRvAyKOgkKRAHaoLms42uBEFCnGPIZypT5zI6S+v0yN7r99+8N9zNK6aCsP?=
 =?us-ascii?Q?BetS2JFJJJXz+WtPHus7Eq2tAC4odljJnkj0pGd8rUdTRN+7SY2zlICbvmO0?=
 =?us-ascii?Q?zcku8v9sQ2tDXwjSYCvhmQSo8yTFwdiAXYtrcJ14AKWR4af8FjVJcW0RKl6G?=
 =?us-ascii?Q?dUGMqQhERvgauKZZmlI5aHLorJ1En5DrxtP3B9b2d4k/Jp1UFPzvz8ptqW2S?=
 =?us-ascii?Q?54lahmQTKoBka1wE0xsJj22A8jwpXwudT0eM44fA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ff61a1-6697-4e8b-14f5-08dc95d61e70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:50:04.7756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FkRzBz4y40Qua8EtdBFnuH3GBGJIZ+BCgkyDXvSsGCMckHJqq+fTnnf/KuD1aji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

On Wed, Jun 26, 2024 at 07:40:31AM +0000, Tian, Kevin wrote:
> > From: Vidya Sagar <vidyas@nvidia.com>
> > Sent: Tuesday, June 25, 2024 11:32 PM
> > 
> > PCIe ACS settings control the level of isolation and the possible P2P
> > paths between devices. With greater isolation the kernel will create
> > smaller iommu_groups and with less isolation there is more HW that
> > can achieve P2P transfers. From a virtualization perspective all
> > devices in the same iommu_group must be assigned to the same VM as
> > they lack security isolation.
> > 
> 
> It'll be helpful to also call out the impact of losing other features (e.g. PASID)
> with less isolation:
> 
> pci_enable_pasid()
> {
> 	...
> 	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
> 		return -EINVAL;
> 	...
> }

Yeah, that is one of the considerations that might go into using
asymmetric ACS..

Jason

