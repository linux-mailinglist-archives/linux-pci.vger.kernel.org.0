Return-Path: <linux-pci+bounces-44247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4BD00D92
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 04:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46E24300180D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DAD1EBA14;
	Thu,  8 Jan 2026 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V908ieta"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493122A4F6;
	Thu,  8 Jan 2026 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842605; cv=fail; b=Vi2NjeTJNdXWDLqjyu4kvLYb35rlC6R8K3DS9aa1kHTZJDt+kaHjyRsA4WUnrsZtIvKBAbx99lVK51FWbcDFtwpP/mxnLnmZOUy+Kv80re/tvaCaiXya6DH/YYcrEH1zzsJjb3ikzTXgJAiidm5Xd6rdZSmwLqzPaZTxczdCGCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842605; c=relaxed/simple;
	bh=JTmX0k/Eg3wyNeVOX916fWhiWBzcfo2kjyVrhHgUT9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0JNf3A/wwEFt3r/nlBYbw7asE1mQJq+dgCxT5PXjmcjnebr9yXH7reU3uoZrLA2mJq3jZ0yaWsPpCcaH6r9BsSzQTjzNsrLwOSGZq0GaWP4KEZpXakFwGspNCBimVk66/cNLohELRufNnIOMG7zuv8VGfaoptzApWH/AXEQK/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V908ieta; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXh1FgaLYd1olAwzjjaY1363oSI0AvWHBDDyyVBh13TqwDf8bvsTqPQpICYMxRKuUSmK/tP6qvYFKLJ9ikWMlyjag265pLP3eK0tjLLPlvPQzpP/QFmDwgLYkmr/BaLWk0iD/vew/7Pm7l/HER0PCGwHiTfOfMGm6leXWycW7UxWawBud+lT6bxDQd4A5yAGQWq8vA69S/0Qk5pVKvR0SOQya8FAQZDlVgkshVjkegn7J9ylamfDiU8PDj5rtddgyjWNjJpKOiasEHxbq3YS8HSnAeqJuZIXlDrgIB+Z+LTbIFTfxalSHnruK+tILqzr4GTWxsucF8yRdQb+LAnneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7y3spx1Bqic7FZfqMhPFLJI6X+F+BRR50c1QWqY+3A=;
 b=Re42oEpcOonEjvRYHoy/hE0rzpgeEivW7OY2OyltchIkPiZSXfc6Rnhwe7SQ5rzeULLdn4OCuEFtqCo2QvKfZKrsBs7EM09JwlVHKhsbg2Kn4INV399Jd/GV0CEe3ihbtZ2/g8wY6XA9jOKESpBWnhv2BtsTrOhZLvXpXIFJ/m/BNh32NE0uJPBKDdPt4/mrKpYBLDYI7R2Rcj9rxr+6m5WVRcPGgWPnvXGUp2azmT9Z+UqegtIrYbJl3yWrVoU8+q5kuFgka6+vhWsIMtI9rZ3asJHG4px6EVkC10ab8D9bDZ7MBGMHJHwJ8w0KLCXLiRI1tw43VVDUMcd7Yca4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7y3spx1Bqic7FZfqMhPFLJI6X+F+BRR50c1QWqY+3A=;
 b=V908ietae4mk51ALvW70TQRpHPO/KrXTEjvvvvY/RbhKAQiIgGrGJCU7MPliLUQy2k1aO8tAzIlocmaaLbOeJGMW2s+NGGtz1Giqz4RlWFhPxK+DN1DDBkYYwS2RvhPwlefefMtcUtw036FiFwI/YIxxpigUtWtZFoCg09Vc85/ig4hYQ/iThwEdaSaQX1QC1iORhhjzJjVSwzYR5P7LPmwRttptHFx1zYR5mBOQIymaENYg6PGdAY+gjFExSNDQmB23OPK9cNK21/XL6tBWEkIcPruxv/3sVN8USVoPqa9Y6duyubKscaTNPCWrQZHUzS/+9RlmEu7B8xqlwDnzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 03:23:20 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.001; Thu, 8 Jan 2026
 03:23:20 +0000
Date: Thu, 8 Jan 2026 14:23:16 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mm@kvack.org, linux-nvme@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <46lz5szq44vz3chzj6unh2sff4cfnpyvih7zty6fcnitzyrulu@6a2xdopoafxt>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-2-houtao@huaweicloud.com>
X-ClientProxiedBy: SY5P282CA0167.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2742a540-83ae-4cf6-5d59-08de4e6545f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TewcMrgEDt9NIjI5LLIDwGY3XN4ccvphZdIz5qvEDdL+qFeb3uBVfE0Ue1GW?=
 =?us-ascii?Q?1BcDOdsbC4KR/8ha4fzt/kAq5gfg15YXYntCWm9h96jBJsNcMhys1RW5++Uj?=
 =?us-ascii?Q?R4MN3Z3CrSo2hiNlSJnnEiq5EaLaSF0WyP3RqPWZHeK2LiloresDHexnQCxm?=
 =?us-ascii?Q?LGogx/ZlD0zjcYe7zScl0Mi6WC2kMQ9jtsd2tJwVk/Utu8NJ0+vD3sSj2Qeg?=
 =?us-ascii?Q?sVLhOlvKRqOPJMFss40eiTvEtwIVh978pVKoMV1dyhLw53XmMzRY1K4LMoVl?=
 =?us-ascii?Q?xDUcelCrHH9PrgkJLoXGlt8OVaaHHaAjb6sk6dLQWZ1ku5OxonIyoPaD8XC3?=
 =?us-ascii?Q?q55+c5I2rHMWrhrHQBSGJifSfGsLVWptzDHHcO/uCVtqMWGg5AY1A2OIHeRM?=
 =?us-ascii?Q?MXJVwYig34ItEGhpFsab48Kueahq98nP63FQ0DxSu8S3Nm5NLhL1C4/ETiv/?=
 =?us-ascii?Q?RIbYdOoXrLI0sXuwbaji2VnaJlAGFBmXxFibLLlQx2B3oWZMUkpM8Aql+KaP?=
 =?us-ascii?Q?3T1lEUWSZR2Gt7B+9ZpsR9N/kV3NiQh1lJ7LSJcHZBqQPqWsFLQsWToNK6YY?=
 =?us-ascii?Q?x4r/1vStjIGAwUSwOP5gMPKpeDyxh3pXz1jU2cRT+rOKD+c/udgT4OWZdWom?=
 =?us-ascii?Q?r67s1QaY4Vu3hs6j8DCi4O24JWROJAzulOEW9KQmpT/PEUj/hHjWS7QiVI3S?=
 =?us-ascii?Q?An+Yj3hDy13l42Ew1YTWWxYR3pJ9jIDxrm7MFIIX0zw1AxFNq7QKoC4NvPYs?=
 =?us-ascii?Q?NPoM4U97XSI80tbm85bMdPW5lf/Ax2ZYoVX6wD++tv9jP2WcE5M+y3EJkq/7?=
 =?us-ascii?Q?YVDA7ZznZ70Zs95E2facoctVzzVWIguKz5rXGHpUNMwfZvtqxqflKhLOXysy?=
 =?us-ascii?Q?c5BKfWG9uKJQ/fATpCG4yh/TEoyTh2+Aqeh91HvcOUKda49Te86dHD4ppPpF?=
 =?us-ascii?Q?n4l8DrlEXJrvwsRdPesy6vp3OYZeeCHqQmG85WLm0DSS8poaQviaMszzTzDq?=
 =?us-ascii?Q?ZhL6WrEEx0MoP7G79/OZoiAc3eaH6t9RjG77IJUnTR8bx7JDPg8UbZnvMkWY?=
 =?us-ascii?Q?Kg3Pr8ZZ7T30JjI6Wel5etDeycPKP9nATEWDjPZK2wPGPKfs6BB/bor88kr+?=
 =?us-ascii?Q?uV3mrWfS93CKj01ww1hcEwHVPVK8oDwjyit75BHX/bcRDHvhRkZ+Enb3AtqH?=
 =?us-ascii?Q?RBGoSGLltJr1fryG/01okJ1YU9CxbhwqPZvn0yuulntuVXdWfVydkj0q5TNL?=
 =?us-ascii?Q?zwnFoh4BDdjVLwXSr8V+95PJ6TbX7XcjhVd0+oHAU92KfLQaiDMOYBS1JFYj?=
 =?us-ascii?Q?Qs6W9ing2kjZVN9DuWxJ99pX9D+pk8Txb2bKEjZP4qr9Nm3Y4HiG5XQuc3a0?=
 =?us-ascii?Q?ari66JjGEtknIO6QlavLnRJTdNcHB3sanxHrwEq2gkpL7KLqdmfT2dPkcQOy?=
 =?us-ascii?Q?UfNdFVTPbJrJ3lbyhvgUWCdcTAvGuXRm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNJBNuetYyLHrendeP9ct6xHAK6HZJLD2KtVpLEzCG6a64zJhhIGlEtjLZaA?=
 =?us-ascii?Q?e4qAzJ2FYntKJU0SrKOSSDGT6e4k6TTxSeY4Iujfk0bBlHocVco9pnWlt4Pe?=
 =?us-ascii?Q?8LJz7cG5krgtHXiNKS+VOIeYitrjyt3Ejuyhe4FQmRlLbWifcD4vRCOSVoD0?=
 =?us-ascii?Q?h1sXLx3BU3r5pD85nUt1d+Dxsi6+AtdJEG7GW+vCrFy38xej3Y56t5D8pbQz?=
 =?us-ascii?Q?LdNt0ECgmzWzRetSS5NVG1y9mdt+yodFHRxIz0jJB9pK/1gBJFqWEhRQTgVe?=
 =?us-ascii?Q?V+49W7GxZASJNdLrQZwWi6X3mBqwgM3/QFZVDJWoEZ8q2Lo7qdt1DJ4dkNsa?=
 =?us-ascii?Q?2KwS84X1q3JQV8OMyKhak5haycuUx+KTwk8Uj3VBC5Z5JmRpbpOyKTeAX8Uw?=
 =?us-ascii?Q?s0jHKE7z5ie8i+T1vuOYP/L10qA/bwhmdMXktmsf/wFeovUHFSUQlAASAvMF?=
 =?us-ascii?Q?MlED7xHWt4+pbGmP/dYc2/jgpyijwDq4lk+bc22Ccmda/JhdwZkZHe248hXo?=
 =?us-ascii?Q?z+/SKC1abiLXSZg7MGOUQoprGt28l4QCBkGj9NWdizMP6dyz+T1NFrFwLMeT?=
 =?us-ascii?Q?Jgj6O6wPgOiPtLNudKy8TnARYqEfvO5YkmBoSq1a5nNeimIRh1Nm8ib+N5fF?=
 =?us-ascii?Q?VY4ajGpC3SUr0V9NFxf08RGIWIzvJqSkfTZ+yVwoo7+OU2PhoubY47xTt1Ec?=
 =?us-ascii?Q?6HkB0DtWXGRlDE5QMzh4pzDY3TxSdfQqDz5LnmmP6QZN2RsQmplPyCsD/YHE?=
 =?us-ascii?Q?I+Y6tBU6MXBnvAqlb8tpuStwEziRX1y0XOeYoDtmrMGvWoenD0a8XmNsIyp0?=
 =?us-ascii?Q?WAKTlcGj/wrs+W7moUcriReOrOLF3XmeqH3UVFv4SfzrGHo/1G/KpZM+9hVG?=
 =?us-ascii?Q?qaFJtTQeFFeGENLzsVv4F5veUIh1p7e2C7dYS/Cxljsgtk4oQB2CXAkY5WYh?=
 =?us-ascii?Q?b1a4Xshzfzl4JQ7DXUIpBgzl/fvVojqI0vCN7/w+W/XNWfQpi5d7wE3AqvhD?=
 =?us-ascii?Q?ShTvKNoYXDtl+Oh20Pvy5+M7sYj92rVvbejxb4fgrNhZ5mwAiwRAXhKXf5YE?=
 =?us-ascii?Q?jAEXsNnYepJgtJaPXJ//6UdCryCHp1bV6jBfMWLfvbcM3pJ610n7IZNkUyWa?=
 =?us-ascii?Q?ciOhlAOJIsmpiQInxurGIJL6cpWIgvDaXb789SJU53QxO40HVMfZ0uEXQrjt?=
 =?us-ascii?Q?GZpHcXd+QxbxJK5yaRt8D6OOd74OWGiDJSVj1A0ytnFKHnUBVNiG8KmbpbBF?=
 =?us-ascii?Q?yLKQ2jqmalvAla2rjVfg8xytzKtNRKcH1ZlMpz95vpTVkGbdbuVeREnB3qg7?=
 =?us-ascii?Q?EVf9/TwHwgx2U1zNLp736eMn1u4UmRK44EXDMCYV4oOwpFf34aVY4+4ihs2V?=
 =?us-ascii?Q?DxFYA4s23pArGZoCD/rtDaTOkUrkrR7J8dPH/iXqHJ/v8lHAusPeZoxWO+yP?=
 =?us-ascii?Q?tJRzuJUyZ5NjD7rWpVDLeMHS3mOqQwpEDr1hkdBXH1i9JAg1QCh3lVnstaK3?=
 =?us-ascii?Q?2mG6F92xB2zI6nn1G7o9CHRw7typoUxlL61mO5gSZFMaC72WAApRV0E/MD02?=
 =?us-ascii?Q?u+pCR8azH3NXPF+uR7e3W0c7nqStunLN712o0tW7lacmhm6+omBoTVoz5MXk?=
 =?us-ascii?Q?rrWknZmdcz6+9TAWfEjfMPmoY0ulaz0ToGHh/yaPqo6N5LQ3Jj95SUyk/ilQ?=
 =?us-ascii?Q?4/HR/sUmOcmD/U4Ks9B1hZV4KlMssdXkho4V3Jce7/bl0TGubvuCEFjZiL9J?=
 =?us-ascii?Q?PoGzY0Pktw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2742a540-83ae-4cf6-5d59-08de4e6545f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 03:23:20.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+ZwdkJNQDhigZYPG4XGggbydvitNsrQueBVYEkgLkn3HyOqRL5nzK8h1hKcl2loVH0GiGjIQA3SR1gR0LIDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> From: Hou Tao <houtao1@huawei.com>
> 
> When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> forever when trying to remove the PCIe device.
> 
> Fix it by adding the missed percpu_ref_put().

This pairs with the percpu_ref_tryget_live_rcu() above right? Might be worth
mentioning that as a comment, but overall looks good to me so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> 
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4a2fc7ab42c3..218c1f5252b6 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -152,6 +152,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		ret = vm_insert_page(vma, vaddr, page);
>  		if (ret) {
>  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> +			percpu_ref_put(ref);
>  			return ret;
>  		}
>  		percpu_ref_get(ref);
> -- 
> 2.29.2
> 

