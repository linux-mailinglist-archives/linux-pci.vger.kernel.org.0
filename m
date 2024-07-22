Return-Path: <linux-pci+bounces-10597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C880938ED2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 14:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399C4281878
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C816CD3B;
	Mon, 22 Jul 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HeNHSYs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9817C69;
	Mon, 22 Jul 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721650011; cv=fail; b=YjSgn1rxXhT35t7hXOQvfkWEP17J2kDhkg4UrM5xTZ9hDpXsEfBNz6PKxobeNpwhDt+gdP+q+3oNwaG2xmMUI3jDn2Mp3MiJNRucfAO17DC39tpadLc01zMPcNdNuDzZF7mR84bCfQ5O9ZrFCyTSVAF4vDQvFGwGk4ZWbON06Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721650011; c=relaxed/simple;
	bh=rLodP0pTpBfFtGPAOzmer0turGtxJOO6NjJ/fqFvvOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HP9slapVxjRM3MDqeKn3H9RU4PxLrmOksiwwp7D146OjPy7t49d6VmYFOMDtesrX9NGCEc4+wcPci8pwi4SdWbHZsc7/i3gmJoHjH841x4QiR9iDLga968VHaLsSVMrGofoXJWGZN8va+y9PDxWjohSxPrJ5Lmauw+gESiwByCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HeNHSYs9; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9yS8GkIl1qgO9e9Ooi4o24ky7/I2SF0f408uKnHY3RFBYuKnW/yVtn+0MpEZJEWCoY2eELzOHPlrfejyvjnxw6fuFrVO5TeTq7x8Yt4ZZwlUvPttO67z+Mv197sb53p8tqI88m9bcCJ/pmJs+l513YWCorLITqMXG3qkicy7Q8oS2RJorg1I18h39dhiDKs7FLJD5+ra9wNOJb+I//mBRMOmJIAX0FTamt4H84AyUM8Z6SUHc3oUVB1i9mseV1du1/tmn1Y4xrBshX91Jgdun9W67iSqyDHGr7AxEIU2mrMU4T+nFhAfnXhVYQsFCkknmZJ0HzP1O3zxxi+i+5ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLodP0pTpBfFtGPAOzmer0turGtxJOO6NjJ/fqFvvOE=;
 b=GRfvYpMtwgu5LoINffhisHdG+lZ5EUo2bY6IPMz7otBlXe+EJPNcchTOrKDBSB/8XvU7d9IPe20Ghs0MhLXl+hHtMHbQSi95IBC37hmREABFOByFBE8Ij/3yGu6H24Cvm8bCXJWbk1kEbGPNmWs2g6RAbLYWzanX7Q0y/cgmcIojQ8D71xedhkZT1cqUUK1UJxBaJYEzIDN62vhFqINN8WQfcMq5lAs2RB43Bj7Ae1y2OlXe4hW6EdG5NlKPq4k5088IOpKUr0nzIuIO3pQAQ45c2ZoM0AhviS/9Yjqjo9OciO1+ZMr+K4Scn0o35YF2raiE6tW+G8AFVlN7N5OZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLodP0pTpBfFtGPAOzmer0turGtxJOO6NjJ/fqFvvOE=;
 b=HeNHSYs9+mD+rCXAwr7GbW9KuhCB30SJLqFmvEgsi8b6Wi3diDPcV3Mnf6a4miAC9tuytHnMndgRHxyF5/yFblmYqzOqG6hk9rHkEoBOEfVvXKGqBVBuvtpaDQl1z09lUuthSOlF8PUbhQz0UjFDvJEzhk/MNgJGYN1P3r2yjUOz/9iwrpQMV9z1raO+tk6oNc6t2gl4jf/7xd5dXSpZGDN9ZSpmxad8lXZdIJF5HtdK1ZGdEMMDn8j6jh3VOAHHEJGw1etZMoaQUKhQu8x6AsCAYs8PcviA2ARIPXTNgpxh7/x2qacy2cl0aQtmOV7P7l60JkYfu2zgGEBbcdImlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 12:06:45 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 12:06:44 +0000
Date: Mon, 22 Jul 2024 09:06:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240722120642.GI1482543@nvidia.com>
References: <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715235510.GA1482543@nvidia.com>
 <b297cfe0-c54f-4205-b102-ba53ec40344b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b297cfe0-c54f-4205-b102-ba53ec40344b@amd.com>
X-ClientProxiedBy: BL1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:256::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b1def3-f4e5-441f-56f7-08dcaa46c0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGg1RNugkS5imetrzJ1ffiiIW/7vVZsxi+TufAod3AGLz05Iro/HValPRGi9?=
 =?us-ascii?Q?1y+y15JXXupCEVaGY/mY/SkgQSsZkXx4hb8fRkl80IghfHtr5UhWacLkt0Ey?=
 =?us-ascii?Q?yOLnnV/+qCc0ht6rkwWcMvoym4VJi1Lrog/TZc7Z5ikW/1Nnl+I9T/kwmiJw?=
 =?us-ascii?Q?5R7oZGVm++eKUL6DFFkf5XVc8XPU7iVytoQ8EahLETErAsgGPPMyOmkp2WHR?=
 =?us-ascii?Q?CrRofHuTYOMNQwj14DSyXedMHbP6b0qIYXmDsVuW3Hh1+KrM8sP55jwI/Qa4?=
 =?us-ascii?Q?8Vecu+jl+zWhxMLH3w3k+OWYLQXto6XrBDnB4tfQMTD7XcjCIOvZQLYMxiR5?=
 =?us-ascii?Q?kXHQvZ5bsdDKnNrHVC2LlPvTRJEJkWBlWDPKelCHLunU5tY8aOTq3ge0c7Gc?=
 =?us-ascii?Q?Mzbuii9bbm7SADkuiyNKiX9+iXoIqFyusVLz4A3QuuFpGUAsgFWgz8XaGVHk?=
 =?us-ascii?Q?VEJsPSOZn4WZ0m6fTC8m57qfrEgRB+Mi7YYXeZNv73pXnHw9oK555PKvQqL9?=
 =?us-ascii?Q?eJvyzs6ILMZloik2V2UNTH95T8B2BwVjFqrlZvpZNSfOvJIOEqHgQglE3Z8M?=
 =?us-ascii?Q?EQA95/4DS98PAIweFJmCmlRI5h3aWHXGE4sg3diTF3AEqH/K25S/rvH3eKJd?=
 =?us-ascii?Q?pAW7zOwIwdynIBz4UYxUi45oFCZTbX1J9KMrJSgxIJPiG9UMBCZe8uKTNBJp?=
 =?us-ascii?Q?HC9CNg6jkGjH2FFHPkp6tdoIRNk3YAp8R+AyMzSM8cgiwZfa/L8zI+IQPquf?=
 =?us-ascii?Q?GU9TqINJskM5kebqyT02AIfHwxCPQgssn5etCDBnF0AqPfbujEpmi1HYul5z?=
 =?us-ascii?Q?A4xCKvsQ7qiFrqb0yVkXSI3I+jGOkK6eN+FUZQMzBYjnXuG+u85QRCSjpftj?=
 =?us-ascii?Q?daIAusWTBdK5EZmjKhkKUOaNXaQ7Wrmmjx6RiR8ylu9PJ+djLibyynPKdFOe?=
 =?us-ascii?Q?eeCGsIUiAV2nkPAztwzvOdsAKBMojJN3Vkw9+gBK4hEawgoJK9/J/BOyXwpo?=
 =?us-ascii?Q?3LJ9sqWO/71pZkhmx7ZxbtkmUMqcenjzdPhl31mkDgp/H0vUz9iwb8k1s60t?=
 =?us-ascii?Q?o25oEBQ3uQOb4EFkJylRxBg4p9PqRXbGdXJWU92DPZzKkJBl3dv3A/21UQCT?=
 =?us-ascii?Q?eRBmWEwh9WZKR+65a5KQd2t9Q1BZbE9HtNWACzcasw0sgBoob9ZJdDD+jKYt?=
 =?us-ascii?Q?lXb/I6n4cOjPkTPj9hRzbfcLwFjqtUFZWIPp1yAXTrhqVVExbiyiQV2Dj6xS?=
 =?us-ascii?Q?U1h2VQnEih4MLrYKuzuMNpXjXMt7QNaOj/zOCLzbn4bpFJ6wLpvbEadBwPuc?=
 =?us-ascii?Q?Birdo0ld6oA4e/ICp7nskWusRSpmY8NDxHv7l7bGVnzeSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLf8/bUENy/sbtN4MgMbwEnh3U2Ct9jkRy449wkZMQKmi2ef+SwZiTrOI/kZ?=
 =?us-ascii?Q?a8rrPhup0zOC61X6JE3duDl0NdjgWnd2LTb3WF3DjejpfH9lo1X/LXvmK1Na?=
 =?us-ascii?Q?ORev9DZkg5iAewFSIAuB8D0aZ0/6pxr+/MwJhYIgz4YZLFzZ+x1RfHrM+3fr?=
 =?us-ascii?Q?P1jW//tb4F6pKjA3n/PaTU3MTfBQROvGxmLYfWAY9o6SRPG1+xSbeHmZb9WA?=
 =?us-ascii?Q?6yz8/BzYE/31bajXdw5vKQkqIjdPUgdPe5m/GDUhzRID/1YXKYuXPoGjyxzc?=
 =?us-ascii?Q?1BDstgPWYyi+j2WNueXSZyS/iBTTCMX8PJ3ogYqCHEoxwrr2VTNBTmZ9JUja?=
 =?us-ascii?Q?UNLG/Bh7JW/XIS4S1tfL1QAlAVH38fKbEiOGLcBNvHn/i/ol3Y4YvXzTO1cy?=
 =?us-ascii?Q?eFDpu6QnIDSYwQhjkC5PYvB/JUWFtBmLVsCqbbN3pXAkwiJN6eKWHOx1gcak?=
 =?us-ascii?Q?cotKlL9Ofazlr3+KUmLGdeev1YfyZRg9ocYCADmyxta0q5xktXjznhOMK3pU?=
 =?us-ascii?Q?gYHMOgYqFvrDUYq6esiY50UbEG20D9DUOZxwLMhJfBu7k+2Icpuu95pQIzBw?=
 =?us-ascii?Q?x8Btby1ywl2a7cuqSQvivaV7IBafg5prEeA4yqbB+j0ZswEp33ZIbxGiuJ1q?=
 =?us-ascii?Q?Wy648owLgz9wIUZ2yDz4h64Dczj1NZvh7P+PmsDfQYUHrtomvHe/0QXAfF8i?=
 =?us-ascii?Q?uAwSgKHxT9cvcylMG5VZe/S9ZOvucYpE/lz2fAbLEiwfErf8Hebl6AKG2iHa?=
 =?us-ascii?Q?vsyFfsf+QcQkti2SrOofVzzVcLE0CpBpVjkenzxaXs40Bh8IHfd7qzMd80EQ?=
 =?us-ascii?Q?cynkr3OOW/7HWwY9ne55gj5a5X4tjy4cTUJNRpfIgrV6hkz1wAm8IJAoUXJD?=
 =?us-ascii?Q?xAb8IYjAnN2O4X8nqlPU8LBbE189hm5cKkYnD7UjCIlASpTU+dkD0RvysLgo?=
 =?us-ascii?Q?7nEVnytEqmtfr6jeoMXmDub14uSPgro1mtiJPIVZlWdOstSqzxQTxDcYq5AF?=
 =?us-ascii?Q?SV44YeJtOzKoSIqJHeGV6lSAmZA8RXpK+ujWH3zYOulvEc4nI+1ZlfrAEftg?=
 =?us-ascii?Q?T1DbH1VNYOsjQn+VSkqJWuMkeSs88Hf8BI1DaitjRR2ZnykS7oMZuC9kYsic?=
 =?us-ascii?Q?8UdOWyhiOQICOyT0SU5A+nzomkpV20lnNA9y6dIotsR4tVpG6SCiRuJrs1SA?=
 =?us-ascii?Q?X2UsN4LEP//sYJ/4QOLKqiuEbufMTk9tC0zkgP+MZx6Ckp5vosLvEMLZVTyJ?=
 =?us-ascii?Q?NuGGPEqgJUy0umZv5oywV5oklQe07ASRB5xUdR1478csOz1agFLJsQ2drrKO?=
 =?us-ascii?Q?fGdPVZiQdchSrVqOCaH5DYERrGw9wiNqnoiWjMDfQDSSaO71nyFvkAtQdToE?=
 =?us-ascii?Q?a3HjWajOqVLO8YZMvdXj+pknDNci8285IsaZAmJuDkAyVOzdKS5kpU24H9s/?=
 =?us-ascii?Q?1jn9ohX3Q7PKDAFuhM7d5btukbKXXnkq5tR122Ny1+3jssltYLU74qdytqaw?=
 =?us-ascii?Q?10jgAgwCLRR1fkjjTXvFojI7xVDSwbD7X4VWI3VitpBzTx91NuO54vABeE1L?=
 =?us-ascii?Q?Y6TlhVDkYO4H8Kpplqg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b1def3-f4e5-441f-56f7-08dcaa46c0f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 12:06:44.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiehYmmUHc6Iv0TcVGw7+DKtegYKYOH55Qg2tnJGK37awbUaPXNpZ4tEcvP1ML0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165

On Mon, Jul 22, 2024 at 08:19:23PM +1000, Alexey Kardashevskiy wrote:

> If there is vIOMMU, then the driver in the VM can decide whether it wants
> private or shared memory for DMA, pass that new flag to dma_map() and 1)
> have DMA memory allocated from the private pool (== no page state changes)
> and 2) have C-bit set in the vIOMMU page table (which is in the VM memory).

Not all HW supports a flow like that.

> My V1 says "all IOVA below X are private and above - shared" (which is a hw
> knob in absence of vIOMMU) and I set the X to all '1's just to mark it all
> private.

Is that portable to other implementations?

Jason

