Return-Path: <linux-pci+bounces-44446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA148D10254
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 00:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 428EE300BA30
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A82D9481;
	Sun, 11 Jan 2026 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cx2OLj9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74097347DD;
	Sun, 11 Jan 2026 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768173693; cv=fail; b=QGExeKgL89RkHkp1a1T9K5UH6+c68Nd71HX1iZVmlhzRzfVbosAGiZABi+PhKfMYNUzxp8s0VtVdiUXm3WZTku+Cs0pdVkr+IGHMO6ThRnagF5IRe/vJNB3LWBtW/rp8slw5KOvDsbWBHqMCkL7DKfwfHGLCXFPKQp9EEuMihG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768173693; c=relaxed/simple;
	bh=0+pbljDFf7QcrBMrUpVAmqkxt6+XD7hklqatGttSyRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SLiVy6ayuzJfFNFEvAvEXFqVHJmYik+0STlUdKdppbHrUqyOf9M8WlvhvvU0BjtgBB6f/NpM3290DxCb2UobsoLM/53TvP6p44ALbr0mpzEZhFywQMtl6o6+W2/BYNkIOGgwGFdFbYXZvBlq2H9BfDypIGL+NFiwvPlYEm+vmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cx2OLj9+; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvlMzsAiBP7vu7C/G9PELQ0cLLJKfZVfbiLgFwHHjRCs5qWChFPy/Tb36ZzqriKWDZvhI/hVZpWI7yp9pnpv0kYghQOabJvvIDS8M7DppaUlrdJ2d6odbYYjcBddV/fJTjI7lW0mIIP0kYPuQJsaEv5huz8cGxrczPmCmZXgwONBYQ2qLOMvRffv/nk2jnCA4q7WIhEk6oj2Epz5Gb0Oqh2K2bec6rHoe8iI+9w6lXyZfi83CdNHY2VDm2pKS6AfgdqxN9oAetWerEhOjVHatfDxRALDosW/AqpJBTVuTW3MeG1NAT+xnpd2If5mDB9ZLx3R1V2XiY3dsVSgcSvvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCngUvF7hhyZLH0T1CWE01Biwd5hHIa98WMVSmrS5mA=;
 b=ksg90iE1MlOBo8k2fAbNtq8PyuJX1lHgmv/UR6RCC5BCaaiaMjwKxdIdlnmiFNbvp5dNQzzMCxG4aOUHzYEXp/XQAcmsXlZdxn9I1xRQsuPMLn/Wk0Www18jRIr0fZxf3HYZkMEEHAQxBZoXsTENlmBmaw+WJgc4CoRCVnQHzf7OQ+IN2vduRqJC9kmYpOgYu4sdLQ+kxtZttmRDQqjmLqgz2p1kTZritxwPA6HioXe0xGuFKPmAJ9movi237AmRQgQ/vuZyMXoRZFXR63MVA+1Af6YI3W9slHJPM3tZolsReOlfmfQ607wjWT75sHGIcqRn5EEENSnBgiuRLR65QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCngUvF7hhyZLH0T1CWE01Biwd5hHIa98WMVSmrS5mA=;
 b=Cx2OLj9+5RkLjH+UxLSxrWDGIABLbrlHGsEWu6PTgHvemX4jUc6Fb7e0u+nz6sJitHv1eMTBRX36JpUypZd837gTTcGBZ91PVuTzepLls/bFap+NDqXt+CHUtNPfWTTbdVhAu1lC37Px3VgWUtuTpiHlj7XwGedtrbC19iL8V/I1EuHw5roeWDX4jqJtdM+V0sHzIIN10L4HK3cdFQ8JWASiAwPd57928tP3easGLWESesWzqzlHORPLfjmRRpw1hMzfPEJ2DtcFPtaoVLbfM33qaLxIUS06VrSAptUFQ+hujPJ3RDAqKLAu2BqSQDI7QkKq+NOEztM03FGnwyHusw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 23:21:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 23:21:27 +0000
Date: Mon, 12 Jan 2026 10:21:22 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <troogtjpbpaxbx34qu56a3qeu7eat36lzp4pvq4asoejxv3zbp@za7hekzxsgpo>
References: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>
 <20260109150342.GA544448@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109150342.GA544448@bhelgaas>
X-ClientProxiedBy: SY5P282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: abbfb56e-d82c-4240-6e35-08de51682478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9gq8qC4tM2TDQyA0W//kk7+PunPZi2Z7XoFTpLomLRTihrVbAm6e4O3Pbb6?=
 =?us-ascii?Q?pc0ZRZuGtym6JjE39fwRErmvwYPTJBlvd+MbYZpaW9Adxw82+5yRC6iQjRlW?=
 =?us-ascii?Q?3TZrRW4BNXkBAz4tSBgR0kqHGzL7hFwjqJcCvU6hTnKFnWaZiZiWNCzV+CbB?=
 =?us-ascii?Q?byFVLBiV2s8KmghqQbtHmsloXdYud4/DvX/Bb14JJdEJ/WQmUTak4gQYtM3x?=
 =?us-ascii?Q?unMAKSI7tWcSIleKIg8IrF/nbvw5HYWt7mqZrW45P8BuxNZcVPjX0PTt84vt?=
 =?us-ascii?Q?QedBGWOkFvgIwn2JLarqZUbf5oK5AkKEn0Z7f/5bEKhBpjNNcm6RIAVPDAEo?=
 =?us-ascii?Q?ZDAj0a0w5FNy8bAzwNDOA0PLUY6K3cI1HkPQhNkrCszvkBUyLgbbi1+R5ksO?=
 =?us-ascii?Q?HUmSMby6B06OIheCtBChYIyVEjTZahBTB+nTXGnHpsUVU8s6d3MXbLqMbZhE?=
 =?us-ascii?Q?pl3Xfg1FF4bU7k7xADgGog37Cgbcf5HSUjGrrnPxrLJtuf/1m3o3qOOyPRkS?=
 =?us-ascii?Q?SUo1gTy/jfH5fv/GYDvGFA3qX6nRDfpMIADFephnP1uvek76p+Uw/xIupDTT?=
 =?us-ascii?Q?C6OwayTq7oKBsorFCUNUNu8zqNhqm5hNKImlDVadbyGiB6pD0Q6J40YxYpHP?=
 =?us-ascii?Q?GtNIbQ79IzFCQd2bC9EIPYIenVuheq0thyhIpM+lxhXLKxmocPtPaAfBLMFr?=
 =?us-ascii?Q?6XI3dn5FC8WF3AHYVz2wAR5VwHm4xDd2DsNtTOXwvq1DzZEulO0Jcfwbmsc8?=
 =?us-ascii?Q?0hGDRVFcBmtodRQvBnRXgQLnNyvJSx2w3UruDlnf3ITvioqNDUVza+GuS3ka?=
 =?us-ascii?Q?BPooY9YjH7IRjntBqd498cmjv7wlqPPRMSG1RORqCK+PabjrTZzNotmVtqPR?=
 =?us-ascii?Q?4J5Y7vKGtv9d8wNSrCW2MBIo4g+Q+K2Xzwi6/qlBbfygGRqqwHTZvnDO50oR?=
 =?us-ascii?Q?v+M6aohY3sI1geh+da9egNcab0xWZhuSoe7D7GEogxo53e9r7bYWC/e7fqXC?=
 =?us-ascii?Q?1t5dsmgMpMay5R5ymhP5G7SI3WtNqjgHx+cEkcG2uPpcx0bnjRhab1eeVtvB?=
 =?us-ascii?Q?W5EQVoeH6QOV4HP/JJD7bmSvA4X0vTenP4WeI7BtB6S6pzSOZjhrGywcGvCF?=
 =?us-ascii?Q?grmxxOKszjbM4Nm/j4SNV3klR514/cC9xGDV5k6JDLTwbGEN8V1uIYMcemLs?=
 =?us-ascii?Q?tkRNYdBgMX2EIj/WzeblAVXylIBn1Hqw/6N663IZz41w+G9Ow21/uFSYz51o?=
 =?us-ascii?Q?0B0v4zuSqVdWckHqXlgw5dWiddbYlVk5gWe2nLp+UMF8lNXl+c3SfLcI6hGk?=
 =?us-ascii?Q?2drpzo9gF1sotEhBMtu6T72bFAPeZ8rVJ992zFqEofgizoRULAPN10MVlij7?=
 =?us-ascii?Q?CBs2TWjB2A7v5vGV/dkyI7w+vROh/Avo0NP2QigKql1+dgceAiz+zyTOxDe3?=
 =?us-ascii?Q?kJ0mTJUASETGExXw+lJYfZ7BCmX4+W6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zc/KbPCxdpOE3GR4EEaJkqJrROE4T2xNcQe0pYSD5xJGalXB2j8jzKmb0Luy?=
 =?us-ascii?Q?gvW0x8/miLTbojf52xc5bpuLNxSHS2a1I1wGd1BQXaEbAdKctO74Q6BAQRey?=
 =?us-ascii?Q?dXbqAbGKI7mZmt/tesxP5kxzCYmeA26CSgbftcbztqwVS/4f5ahxxmW4MZA4?=
 =?us-ascii?Q?6dADRzJaWzYd6V9JEhxw0Q+NpEtjDMwj5onFyIh60KEkgWghn726TPX5dFel?=
 =?us-ascii?Q?QUYIEwBFH5ZvXXEl9qdFSwC5sY37IoRjyBnV9dckJNTBC6cRQEscOh4nv7KF?=
 =?us-ascii?Q?FietdCsVHLhsaOcmsbMm5T+HlDFgtDg/xU7dVrVurX3xTsNKWG8H1UoS8G5D?=
 =?us-ascii?Q?SLX/xO77ObGO6feIT3OkW34VdyMLqpzkJ8AKusG5E01my4STgZ93FQwDTrgZ?=
 =?us-ascii?Q?FMstoTDQAUIlkDxVQOykR0Pi/ty3pnMOMBeX5k/HTJuoQiD3EkUtm5BP0N9R?=
 =?us-ascii?Q?naInitflvXcvnndIZA3G8yxvYAnusjYzztmrEu/EWW6XqGyAdvrPde2nrTeH?=
 =?us-ascii?Q?LXdpphQ8onVMcgqiOAW67lVoCVNLBEK8f3dgPM+Iivp91KjM403tYF34upvz?=
 =?us-ascii?Q?7+P46WwY5P5qsLI3bZ/RlVyfBtUxCbM5hzHmvF8ew6jYoVxd1Y5xIFkvzdXf?=
 =?us-ascii?Q?6TZLYr1p6HuxWdMPvABumMh64T0aQXXBMN5RaeBYDamLKzpGI4EHQJ3t/KYu?=
 =?us-ascii?Q?JYAT8JYNkmRITcZ7Ah/Ph2hNGkOdv5xvzUm5XCqyBJ3yw5x/F3f8l/azW1aB?=
 =?us-ascii?Q?fODx/2dfeAr05keVT0IjdidZiBVjUVuV3OsJUoupI5miGv/0Tolmr3/5go2M?=
 =?us-ascii?Q?Idskr02PzFPrQuvMrlNUbCT65cyXuB+Yv+8Yl0KrK4NDenTowOOypJzxCqwi?=
 =?us-ascii?Q?RFmbQcYj6ov+1HYxtO+1iv8AlgSe9ceO5Ma+fylf3ZXEMwwhTY4m84oTFKxR?=
 =?us-ascii?Q?nYvm745cfIrcZjY5jp8/Th8sZzTdSRMSAbwF5SaRDb331YT/sxDJBx0ZiQ/y?=
 =?us-ascii?Q?6k9XQzrY8EaWkYzzuWpUA7fVa7Io/SNDM3IHoWyaTH5nnJJkl2Ln77uBSs3X?=
 =?us-ascii?Q?Eywrp594oJP/JVwX7+bPJOcgQdazLQq1v8rU7SC0wL7PABWOevvyp2RoX2Oy?=
 =?us-ascii?Q?EycoSiGtY7HiXy8guCI0YJ52HY/WuyJoSju6yCRBPVr9sCCUpWpak1YWo3lO?=
 =?us-ascii?Q?WtA8JyS/8sVFfKTLHZd95FM+yeMZ+IpbSJblT7KxtXiwszwmzkQwcr4fiBY/?=
 =?us-ascii?Q?MeAThsrk5TYX8j8jOjRoN6WL6GttcD/ObvSpb2X2/dALZYkB0twCXu8P+DiW?=
 =?us-ascii?Q?KaFs3B+x38VBk4WmJBQWisjPO7KREIuT1IQq6yFELo2DaQRjjpHsvt54K2/n?=
 =?us-ascii?Q?er5YdSBvHOeCsrfocaIamxPufhXlvfiUixJ99KptqS9uMHCSI7SSmw9A+rc7?=
 =?us-ascii?Q?u+VV/mkSm4tqU4GoonT8xz13qa2qo8jX5MXpfinI6lheMk9xDkJuVmWL9bsT?=
 =?us-ascii?Q?9lOJ3DwBF02TNflAfSK00rA5kEqG1CkYETO1AprtKdeBDxU94/IPc+ERRQuk?=
 =?us-ascii?Q?AQOOv8i1Zn1ZyJawK0aHkX7vKwk11/pn5+N2SIdPyGQJ+4IYFzza4XOMceI3?=
 =?us-ascii?Q?xJ6h/JQQJLS2hmPRO9ovFhNvLRsigbnPlfKu8aIWn50PiJt5/jMW/gLZAC2C?=
 =?us-ascii?Q?pLFXtRdnbweq5S0PN8gieGLTRU/3gwrkL5AU199iEMQYr0g9qpJYQJ+elxMn?=
 =?us-ascii?Q?3QPvNCtlXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbfb56e-d82c-4240-6e35-08de51682478
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 23:21:27.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVHgBbzMSgTiLM58oiUGG1V59PQxr509tnfmXUpFXA8FXUXMO5jL6GTMQohskMdY8GEjXC4izFumZBWG93zC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

On 2026-01-10 at 02:03 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> On Fri, Jan 09, 2026 at 11:41:51AM +1100, Alistair Popple wrote:
> > On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > > On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > > > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > > > From: Hou Tao <houtao1@huawei.com>
> > > > > 
> > > > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > > > forever when trying to remove the PCIe device.
> > > > > 
> > > > > Fix it by adding the missed percpu_ref_put().
> > ...
> 
> > > Looking at this again, I'm confused about why in the normal, non-error
> > > case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> > > percpu_ref_get(ref) for each page, followed by just a single
> > > percpu_ref_put() at the exit.
> > > 
> > > So we do ref_get() "1 + number of pages" times but we only do a single
> > > ref_put().  Is there a loop of ref_put() for each page elsewhere?
> > 
> > Right, the per-page ref_put() happens when the page is freed (ie. the struct
> > page refcount drops to zero) - in this case free_zone_device_folio() will call
> > p2pdma_folio_free() which has the corresponding percpu_ref_put().
> 
> I don't see anything that looks like a loop to call ref_put() for each
> page in free_zone_device_folio() or in p2pdma_folio_free(), but this
> is all completely out of my range, so I'll take your word for it :)  

That's brave :-)

What happens is the core mm takes over managing the page life time once
vm_insert_page() has been (successfully) called to map the page:

	VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
	set_page_count(page, 1);
	ret = vm_insert_page(vma, vaddr, page);
	if (ret) {
		gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
		return ret;
	}
	percpu_ref_get(ref);
	put_page(page);

In the above sequence vm_insert_page() takes a page ref for each page it maps
into the user page tables with folio_get(). This reference is dropped when the
user page table entry is removed, typically by the loop in zap_pte_range().

Normally the user page table mapping is the only thing holding a reference so
it ends up calling folio_put()->free_zone_device_folio->...->ref_put() one page
at a time as the PTEs are removed from the page tables. At least that's what
happens conceptually - the TLB batching code makes it hard to actually see where
the folio_put() is called in this sequence.

Note the extra set_page_count(1) and put_page(page) in the above sequence is
just to make vm_insert_page() happy - it complains it you try and insert a page
with a zero page ref.

And looking at that sequence there is another minor bug - in the failure
path we are exiting the loop with the failed page ref count set to
1 from set_page_count(page, 1). That needs to be reset to zero with
set_page_count(page, 0) to avoid the VM_WARN_ON_ONCE_PAGE() if the page gets
reused. I will send a fix for that.

 - Alistair

> Bjorn

