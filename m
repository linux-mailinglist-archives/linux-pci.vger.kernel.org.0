Return-Path: <linux-pci+bounces-29323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF57AD38AA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B7117D688
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B37299A8E;
	Tue, 10 Jun 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jz2ovjAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EF299A83;
	Tue, 10 Jun 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560665; cv=fail; b=sCHI3mmrI3K0fBHjRisXsIBJ9gLSkZnJEZsE+RVjH0r2iPNtN5VMHgHijzuHGEg0Wf9HETraKgaDOLjuPan3cEheysnik4++0ZkKfRXxE47hFsS7qHPDGhSPYBlAwChvcaRLNmK9fPJQIJEfBC/tMVtVYX3RvjUYZj15+X/cneA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560665; c=relaxed/simple;
	bh=gWS0Tag0sW62GSrqdWIgKRJad2pEasMgVMkedC+A/FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhmYKZ2EoVkq+UckiAM1Ya5Pd5R/Pjw3rSmWQnznjIn57lZ6lP10GtNyWfSuyTaBFPoQIhueRM7Q5Ki+pZV9ZB96TPq2l4JUvEOcghCElDMGN3Qzk5R7tfehQw1BBq2IZd8TJ4fRLQ5NTHp/DwJDFR3gA0FhqcErgcwo8xmQpOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jz2ovjAg; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKtrZeCHTDqaZqMOv8OaJeZtyLmKYYZSFXVeYbvXPrZGj/1SbyEiTgucDrol2kmzPZoG6cE8SXuFxL36E94gYEjTIeMIJLDyT6vALL2s3UiP2JyjA66fkljkntI1lh+UHtxeF+VH6LIY/gXwtBFy6kS62EhLXAHTwXXfK7NFHceBeewNINseGajr/N/wNQJA/+r3GgBf3FHq8YNi73ND2eGvAGNA16567QEaRM7Weq5WWDGE8FDwMTVMeW2sp6WgInRSgEhHaeW/zE5T07o5cqcrRA8trVPQowmiQMou9QJNKtCHCg3JHKAEtzGyLinzNqhlWJiATG9j3bkVB1A8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVwuGjSzujyFs+aGPG/Mp9A/Xn3JFHmxkdNtAgbGJ3Q=;
 b=dJeFp5Nat+0aPsEvZ+PNnW0nxZN3nCZtIkVOR++BwcwAFzUm0uU/q4rsPCqk6Y0bTkgtwol4dBxHL2pt3iTJKvZMULmCsAcAozvES7IBosTrPuZNK38zqUBLS6i5tuTmClXBeWEPohB7JagNOxjUtjf6inVNa5wrWvLgasxVNobTyJ2FJAllUi4aAoJjeiLEmlfrheHrdUfwRt79OfYFgoLe90ymhK1bScYr8R34R1k2maTBZclxnGkPePQfTCjRrwEQ788yqfX0B7KNUwI4AnAv9FL3a3tYiFdxfIWTBL/2ntIVlnOZLZTAORRUtosbE7hKZCMLCr/Gn87Al1yw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVwuGjSzujyFs+aGPG/Mp9A/Xn3JFHmxkdNtAgbGJ3Q=;
 b=Jz2ovjAg4q0uzUM9RDby6ZuaW5d2WBHhGiN4BoHxu4ilqE2f3yymJQSoZ+vkxflE1txsVjqWgLHsaGBvwDFEh18alJei422673XgjdKWnZ8aMbW6y36BPtgmybFN+8V25UwoPxKNPFf1lDXAefRvhRTObPj4fzYEDA/Fb1F5xLgL9ug3yEnbE8X/oWnqJH6timf1x2pQQsGHMvfSr/K7R+IOusBDFhHi+63Iinzt1NFGfsEtLAvj0ntV+nI16nunJJgrO4RKJY+esYJt4CHk/pg2J6W8c36zF8NG2dxfwIHw9kyyXBrTDSWRQifYuxaj0S3WpDLcsE4oPhPct3q/ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 13:04:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 13:04:18 +0000
Date: Tue, 10 Jun 2025 10:04:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250610130416.GC543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEfZlKNk4xfb41RR@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be36b20-db61-4712-ff2e-08dda81f4eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWq7QMsoxWRROa3gB5CAz+9eW27hRupw2u31ea5+MAQw4HNTiv28nsUl1DJL?=
 =?us-ascii?Q?6m+UlIJDLtynY5jYkLYn3rl4kbm46oLPmQUJrGzt7KTiGGiAtJ9ZGsiTg55h?=
 =?us-ascii?Q?hwY1ycH2NlqEUWL0ke7IMJem0edUTqEv6x/8/6QIJfEoF7z1/QjtFASod8cL?=
 =?us-ascii?Q?nD8K8bIpR05rI/ujmGvPuYkQjDzXsVTMcQx5Y0+bhl1hjzR1NOsTJinPl768?=
 =?us-ascii?Q?h3qkQZKfCyBcSvOje+ccfTO2j/omxKUiYSTZ/73eHCMRziOq8RQKq7oN5dUA?=
 =?us-ascii?Q?0OCesv2Odg2ZQEciOj0eh4Z+gN1WCu230EYk4IbS04K9ftjsk16bHrYN/2Px?=
 =?us-ascii?Q?T7Oa94iv2P5mCUg/0oNWIacmyedWwCM+xJ2UXxZaohNX5QejgbVejqZRPjy/?=
 =?us-ascii?Q?iSGEYZ7AwXVaDasOaQRcWvyUwHsvpp8icAYOy+ceNaMfjgLVXqVSJFStch2W?=
 =?us-ascii?Q?Sb6eiew/+BLXEUlNJWeu3IZZ8DbYKLWUyz/lAwI32hnk4TIALYGT8E/dIWRp?=
 =?us-ascii?Q?dHFjv0f51RhMxif9IeOqp1IsFlYrNSqwLvLHm+/PdoPZNyRL+X+URmSJoGUl?=
 =?us-ascii?Q?qwfwWi5APzfO21DtEMMwRL+7Gq+XGmgUg/GkGqZptKVgid9w0mUf1zGznuFE?=
 =?us-ascii?Q?lyKq1bqxx2TvS1ZN6rieRuR7+TyCqSVPwT+K4T9KSgW8MHuBDDhMB55sZCCJ?=
 =?us-ascii?Q?047WHc6yTG9OkrS9ELQ8hZp56uZsXyBHlQNH+9sH6IbiGJSm6auaCW86UkOF?=
 =?us-ascii?Q?tcjAO5fUIaCkUTd7KWoioEXlIqtDIwY7j+Slh9Wmyq6xC2WyVkT8p+LwmCoU?=
 =?us-ascii?Q?xHicTSF8/RLnfgpgRtVaQupKdBVnnT7CGKIHklOaolV8RoHrs2giJQVLWB9K?=
 =?us-ascii?Q?D5c5V76wgGZbYjx89QOD+XtIpUd+mg9kARB5UrqP+gT4RikaJKknkH4YKyde?=
 =?us-ascii?Q?wRhKmVKIP8PN4Ew+Gv92zvXNEG+taK0xZkkoQE9Hg26s7vyQP0wD0fV+/rDo?=
 =?us-ascii?Q?bTeA7zNiRRpMSXJcnm2/1fmQmIriwQ3GLJTG424d5N4QXVdx8FcbhpYOev42?=
 =?us-ascii?Q?R+Hed9fhSyruU9JRTF9fAD7kc5ELoF5Jp3N1LVMg3ZcDjarJrWey5PKrDDBS?=
 =?us-ascii?Q?mN1NEQiwUmOZABBKN6wjVj3LFUK1kYMxVXypG5KTa21B6qpvtTYegIpgbd22?=
 =?us-ascii?Q?tSEW0mf1nyXR7tSBbjUHMdZmgPfcCWQHT/FOBaP/pFLR4y6iJbXlmheXr5yM?=
 =?us-ascii?Q?145VOVYnoNygPF988p2bRlhlx4otyfSVSi35FedS1K36PY5f4eQCbLt4Vidr?=
 =?us-ascii?Q?AN2kkVorpCLqYkiZF19Jw+BA2IYQ3TWznVrGfhJneRGCLEFRVgy9JEH1QSSo?=
 =?us-ascii?Q?WGjogYOoDFM0OvRP70iGMR06ndiwE/y4DKBrl3dm98Kyv2+nGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bf5xUhHKkjzW98VBekwzoS5t86g7TmiQLt34MufF3o5tSUm5pkbXdjwTlA74?=
 =?us-ascii?Q?AgyTN0c/aHgXuyFZfPYIhw8gnIK6UOLuB/FBXUvA0Om+x8UV7D5RbvagCNyA?=
 =?us-ascii?Q?TkemGZaUIiTTpV3X+FEaOklvKMf5IUJ6YYZMhPNW1Pd9iAdkHivax03m7q0a?=
 =?us-ascii?Q?SxeyMbKqJuZwSny7zsi4Lo/crEnODkqG/M93au6kAfJMGX/hQmS4bp1gGPt9?=
 =?us-ascii?Q?mbOO51D9GW8KroE9mZyhQEofWeN5QWEjUorkMZXYcZbqAlKsji5g2qrhZXPV?=
 =?us-ascii?Q?CAlHKgMVGxIfUNZjgkxoKkiQoAgJNmFACDihFCNFc7JpXPjUSufn6qvzLR6L?=
 =?us-ascii?Q?DKyn0OKDDaq4vEfhqWuq09VWAZpZJzDrDvHX7Q6chPigHVda0v7rWKWFTd0B?=
 =?us-ascii?Q?J1sX3AIy/XNZAflYGRAlF6GYYTBfQyzyWtIwAC1zT8KmmiAo+NXrRyYvbEdh?=
 =?us-ascii?Q?TJtRaz9L927k4wmcw5oIZzt4d6CPq4qv1vGV/DVHoRcZxkcgBkpwRnKEQRa+?=
 =?us-ascii?Q?Uu3MsGlciEc4qw3MbULh8bN+Sil1xhhL49mmH3vU9wh3WfUf9cXTpod8XXBG?=
 =?us-ascii?Q?RCil6qiZc/IBrGSivQ3907xGezy0CVza4wUqPX/iYcmQA1qlGN1URya232Pe?=
 =?us-ascii?Q?4s1q2hLo+cF8ZDjBVup+Lz2dF70D8jHbAPteIR2A7aVhH4rl1cyxTsfpE6wo?=
 =?us-ascii?Q?yG2Pk+fkQTzCPX3RmZ60DyFWbS4upo7U1dehG+djPTQ50rY0QS21tOsmLheE?=
 =?us-ascii?Q?dklYrmyLzTaqLfkYO9RbOdbo9ptXA1HZuLAJVCwJ4siQt2NPy6dCNTuJwyYO?=
 =?us-ascii?Q?PEDgVZBnH4ResbDia3O2EkJ2p4O8bnXPti1tDHKWxBG/vfRtC0AnAHabHQbg?=
 =?us-ascii?Q?U4oWZ1WMdhGl3Ws1YKVMZDEOv7insjs/I8vZQzi0bK3hjtBgm/YMOVhI+7c5?=
 =?us-ascii?Q?A2dyLlLs8FEp7tBoA99hchpuGoheYriNQiYReZ1JYkY0LJp9FrU2cvD2ry49?=
 =?us-ascii?Q?RNumGrdAD2kBulS8D+NwnkmcWMZHflM1w7T17IQvI61mgUyn1ac3GWVd9wBg?=
 =?us-ascii?Q?xCTrLhybqhgrgJOvePnVlpJvk2vRY/h7pPo+lBNS2HOKXZ9wEdouCYLxvimM?=
 =?us-ascii?Q?EiuXmed4wO6vPxx3Sudk07h7xTLHrt2kfqWQSbLaz1sjG1KnUTAGehTcrZ6J?=
 =?us-ascii?Q?X6Sd9it5oTo2SFOGgSD9KH15Q/XUxGBlTW45Lz03k6iq2VNTOSR9CbC0Inz5?=
 =?us-ascii?Q?Uzyaec8DgKIw1Q/cYmKYSG/P+WRBGK8HrvX6oy7KmPMsaH1whrN/v1JOYobo?=
 =?us-ascii?Q?/EnSYg5lYhJvyYDK6LKCX+AQaSJJ1lB69y+VHDZ1qcb9Tw3B70xO74cZscgB?=
 =?us-ascii?Q?zd7iOQqqQSAxk0562ZNY6+WkoPtfwL6jU9rxFK+OovaQxNjoGOOjO9fbZLqN?=
 =?us-ascii?Q?K11BnTeALlAFeCssat4I4dJZ6vddMrDEdBMdprHYzKOMuZqI2MnwFDvmtnxw?=
 =?us-ascii?Q?DOdD2M3CBq4lifgBhUvcc79AR0MODMzaqaShE9pM/xYEOB4+urW8SLhFnX0H?=
 =?us-ascii?Q?Z4hy1iKGc/JS/9cAHnmB6OBYWySZxouPTFUuF9TU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be36b20-db61-4712-ff2e-08dda81f4eea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:04:18.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrV8kke+zwDQnVLwGhUXmRdDudwbJR3gDU5btY8+AjlOgr6kKXu0lujQvf5awyHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124

On Tue, Jun 10, 2025 at 12:07:00AM -0700, Nicolin Chen wrote:
> On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
> > On 6/10/25 02:45, Nicolin Chen wrote:
> > > +	ops = dev_iommu_ops(dev);
> > 
> > Should this be protected by group->mutext?
> 
> Not seemingly, but should require the iommu_probe_device_lock I
> think.

group and ops are not permitted to change while a driver is attached..

IIRC the FLR code in PCI doesn't always ensure that (due to the sysfs
paths), so yeah, this looks troubled. iommu_probe_device_lock perhaps
would fix it.

Jason

