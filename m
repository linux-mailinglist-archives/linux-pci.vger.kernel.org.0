Return-Path: <linux-pci+bounces-44447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A311D102BA
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A726F3046428
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA2CA52;
	Mon, 12 Jan 2026 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eknuLY4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E339463;
	Mon, 12 Jan 2026 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768176756; cv=fail; b=VAqH8bfqHV1wkg6ZzS0nZmo9mXfPQ18ez3lHrVftmTxrIyx/QNLBqT0BVQjLwiU86QqhObuh5xhxNSsluzyjAIoCZVrmDx11tA+SXbiROYKnbDwBjaDL/nrhpPr7IgKMh4owJM+5l5Wzr9l6msTMiEUfDt7jRTzObekFF5EqE20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768176756; c=relaxed/simple;
	bh=X/adelW+oAhPe/IfcK6EwMo4MilYdiapbKqREYyuhrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWduS+Aq1rQcnRvobqU26UPRqnpLXArPoxwVI1FDdzDJVsHdDExHoeirMv2gOIooPnxLWpFqQ1bQVHXm2UH7T22RmTamt6yUmx4RZpm5+iMg1YVIPUeN9xLSuWr+hGfSl/JGyPhDvYlK+B2tZrQzp2knTG1pOfv7UWhao6CjMLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eknuLY4h; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgKJq4JjxNb3uWFJ/eBvSZEvErn7v7FHbRz5Rq5aCXCf9Z43gMU1rKoO+WIBdY2QWnL1mC1lvzjtk9jgXyjobL6hhmidqhBDMpWYnX0s0ZPmRKmfR0W8V3BYRfIgDrcvBgrh3SufN3O2p4wy96/SJ21Q72/jrHXunEcgrbVJAs27vXlGi+w0mdRBFqvVxeXE8ALHBSRORnIfuYZ6o3rqvlcvyoMRoka1z0s6DZML7+F0M8ayjiGVopG1Se13l52EsqiRFDvL4QYPyJ6SlO0kpGJP73wvjWxzABKr3WcmMIZhwJH3ljwgvXsCdJLnNti+MPLAAPMUIbfAuAyD+BFkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0OzLhJhGm9EuRbujJSiqZY/XHYZ+i+apWmzMF4/u6k=;
 b=qCjPy9ie7QrdP6uWFgKzWZcBjktHpSbDefz4ohhGJPUAlcyx5kTXOhYVjcb6+GjFV0RiK7IrH/SEZeJ65hhYZt8aEBqzkFue0RmYIx+1omsAW+bqcNH7iR7gQ+1G60DrmVWaHys101FtI01PzlPPeDne+raHgBxa+UBbeKtUi1sfnzuMrc9H2Ske+BcYGmNdKxCWBVP1niglT4GcePn+dznXT3MvJHD3djKDxjWVi4ArDEbTw7G2tyxJoNEkvd9MSnYIGZiNdMCrMCBhZsHFXdZ7qDlOpJ+kN6nDgDEzDfujVnxViBirYhgFNWcjGgTgpzP8d0LZFGw6xXWJh3IUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0OzLhJhGm9EuRbujJSiqZY/XHYZ+i+apWmzMF4/u6k=;
 b=eknuLY4hEbkJWEUuR/0iz07IB6vz7EobN00g8NJONnwxsjaqu7Q0OlcxSve62VVJDoKKHcMYgAwEdg9wm5e5hhhqBiZ6EflaTrkUinxc5l4HBpcLlN4a/xnZTuEFmbCrz56+GwhbYgDZ04SiX1Z+z34hVq/sqgQ35qLDKW5n6tXIvyheD1kVLOBiSiuaPTUvut6vlbU3QNXA8kTipKx66TUng2f+793o36u3Ew3ismlII63yrZROeYkSo1SoMcrmncA63yYp6oiqERKbcVcLx8cQLKvAvVg9i4/1HQRA/rKl812NIjk6w7wbjd0UK4k37g0oQi2ooNVuDXjujCcEyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 00:12:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 00:12:32 +0000
Date: Mon, 12 Jan 2026 11:12:27 +1100
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
Message-ID: <j7uozwnjzvcbhhwlhb6qgwlrve26dfhvwdo3w4uk7lcp57do37@v4dczubjeoy5>
References: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>
 <20260109150342.GA544448@bhelgaas>
 <troogtjpbpaxbx34qu56a3qeu7eat36lzp4pvq4asoejxv3zbp@za7hekzxsgpo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <troogtjpbpaxbx34qu56a3qeu7eat36lzp4pvq4asoejxv3zbp@za7hekzxsgpo>
X-ClientProxiedBy: SY5P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d89e5c9-1dec-499c-a7b3-08de516f47d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnQftnjxoNR5Dl511Tung3Bhp/ajRbgS5bY2Sd+N3oXG5jCI7u0KHNYGX6gX?=
 =?us-ascii?Q?LK4olF4cKbC8BeeJYfER2O7dB7AbZ7VF1JWbQu1lb7l4SzwpwPFGH3Plm5Du?=
 =?us-ascii?Q?wE6MrVfAjRbcFXoSIi+gCCohx4jMSSsmF5kNKPfd8Cnreg53OWVEa9iTuf8A?=
 =?us-ascii?Q?cpzlS56G+pdiknTMQu3wHjBhg+F0yDb4p3BYgykTftmCX9fhyCR6MmB/TGmI?=
 =?us-ascii?Q?S20zKfRC/NIs6UajfvZS/AFlmBlbdUceY1k/63f9hkCN1APeR0TF7e29xIJB?=
 =?us-ascii?Q?fXT604j3PzKQwZPX/44IizsnDS8Vq5Ri/0LlR8S692xh958mgust7dHJVrCH?=
 =?us-ascii?Q?RW+pkWl0nI/pIyu7LPVPdckHOH1cFrGuYArelfnJiT3VtLFYIsd4lifOhbM/?=
 =?us-ascii?Q?htHjGt0J6Dgmbl5ySz9zR4lNE5lzjNG0zRDfUkI9Ghhm46Oh5Sor4ZywAKzf?=
 =?us-ascii?Q?qTnkxCZWUi9hjQlJ/4PbQhQUVvd+W2sAWQhZqlRPZjAKk90mRL/ibSEhUywK?=
 =?us-ascii?Q?9YQOX5k+Oh0iZCVdKL0rUuCazGwLfEfqu7wJUY/2A6uI4jmZocMci5eM/sSh?=
 =?us-ascii?Q?1PAGOiyP7wZQPSwuUwfdgwehg071P25ZYvGdLHjPWvoVZBVi1sHRmz2bmjGg?=
 =?us-ascii?Q?bGJAZEflAW/qGUI5IPVrW0zLEs0OFMru4ClKjIDoHZ4wXsRde/QTtlkKdXQr?=
 =?us-ascii?Q?eIf8F6dUnCsTzhaHxiBGEKdAqBBK0H59DI/kaTu8kziNNIjgPdgf8qbYduou?=
 =?us-ascii?Q?6/B5WKD0wM/k7lSiJ71n77a9QIwvBaw0ZL7DfZ5aF0jRp8Mg6fAlDTFd8Fh9?=
 =?us-ascii?Q?YVg5OPVuiUv+dKcTQDMJkLi8nyOOTxcmwWEpkEYY5gGJjgdU/c81vRnfIBc0?=
 =?us-ascii?Q?LvPAZbqmPg4qTv8Q6/N7bTxl2g81auIBiGKbH7hmg7UFBXy2P6OLe1SWhj7t?=
 =?us-ascii?Q?T+fkueDPdYClCD5twlRY/0HO400/2d6B4cOtZe9tat/59VwccGvuGnCGOByH?=
 =?us-ascii?Q?FEXbkiBX95dgHzDHgRS6lkZGU3SL3IjnfQM80IsWrwnDrpXUJpGlhqf9PPRX?=
 =?us-ascii?Q?Pz6aGvN4rXtjyUtQAFY8Mry7JDp1OfInn1LKJkJcP3geeylEDQU19Fz4cXkO?=
 =?us-ascii?Q?Ot2cW8SqJ6trh/ktNmeZpLyjKxMUV+/Qcn28TKtvFcLPNXyz54IojgfvhbQG?=
 =?us-ascii?Q?CDrnD5AcKJw+88eVn47I5nRNz8nL1VdDPregVzmCYsa88BeUhXGfmaIPUw58?=
 =?us-ascii?Q?dFd4gfTAVeJjpfr+shwJR4GW6papTHdZqPAuCo2iW75Rvgt7iFaSFWPsodFR?=
 =?us-ascii?Q?gMq9hDpwKQpJEFy7cmofuCg39IGUEuGBLNDT88w+TQAyneZzZ6NK4zAlR6KN?=
 =?us-ascii?Q?yX0pyAR5Q+kN3UsQS8BAGEvt1bJzNMWawhty3VOhliwXnepucx48aG6bvdwJ?=
 =?us-ascii?Q?YNNNJDrTj0PjhoTTst8znmt8oWIgwIgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMg3rZEelALfMwj/dgSEswPHiC3aQzGHZb1off1s6H0xbTRYudIOwecbm65C?=
 =?us-ascii?Q?yB4vUNYhpuT8uuPMvbyU30umiJD8FVq6g6cCt3Nj79YDmGUqo0ejVkYoh1sC?=
 =?us-ascii?Q?ng//5sxV7oX90j13nBt02hFqye5fvqAwRnANI4Rz/P+7JTGiNtFq/cwvX+Uo?=
 =?us-ascii?Q?zLDtxjUdkRq0IP8e0YGDHlD3LjcQUc2YPSh6Segw93q0vOlzuiEoRGQb7GhY?=
 =?us-ascii?Q?SEhliS1KqPPYVPTKtCLJLkTxpjQ4hBbioL4bTAFwqJQ9XNjsTGFUDWLqGgY1?=
 =?us-ascii?Q?5mDscUmeKUuv9OydoF5sqSOedKh72WCe/4mXPnneBoqjeH+F2DdiXv9qAM/+?=
 =?us-ascii?Q?DXSAYO1MI130CPvIX1iDmXaiD0A0NBpsrxo5jji8f/oCaYlup8Gt3qP0W7in?=
 =?us-ascii?Q?eJ0+gK1DKauSWAZl4ddCE9KMVzawM6AcH8BVtvH/AdMUKyvD1ASxYHX9A7xQ?=
 =?us-ascii?Q?alS6feNBQ3a29I7J/3LQJmV5+TLzqgx5udo9nTtST2Ef1aeuT+dKJisNiq1D?=
 =?us-ascii?Q?ZGWNqvZgFukudq8pCTCeutX2MDTYVz2cVMdafSh0zsBAvtFHGRRvZnFFCvkk?=
 =?us-ascii?Q?8buDVyY9cPzuA4XuaiiTJJ69rHl/SviRQDor8MCQpN9PXrBrvIS4f8/+2wis?=
 =?us-ascii?Q?gGOSvQ8nnne91PuIZyzUXISp9Pkz8q0YFcQSt1lNXwglPgNyCCbEdjKJuUA7?=
 =?us-ascii?Q?7bfqx3PJk9Hm2MKt2FFmBiRuAa99qDv4LItI61rIccxyR+lmej18bSRIGwQa?=
 =?us-ascii?Q?2jA6XXNUHhwTlteisNU/9F/Ug1ME7OitpVefT5o2SWRwHA/+4cyRCxeo2iff?=
 =?us-ascii?Q?ywXmKeQlr98ynILRrDbE1hV0T1CHKRDCA2hu/kb6uTc74LPkQ6iwbaJSs9Kl?=
 =?us-ascii?Q?Z1Wcf4AiSL3tVJ6vp6+OxpENJpcAqnkDFAPOoJGJBb/BBoGEbURnWa2SoDue?=
 =?us-ascii?Q?y49+3SykTNuexFX0sGMvEqAXTFO6vpVl0E/H18qC2Z1PS3m3dLWTUdne3Twm?=
 =?us-ascii?Q?eNvEPKP5arYidLDz5cubwubXOf51Hb9xRr47P7obYTWhny3peNs/5TBju2zr?=
 =?us-ascii?Q?y2PsU6ifuoUXgeiRNovwwSJyrjOZkC/7JhA+kVdxOLqeboRv5JAcMVzCzocj?=
 =?us-ascii?Q?xtHVoVQ8Um+Ewx316WG7GoTH++NqSHwlK3RZTjLdT5YUowDTx7snCi6Thwaq?=
 =?us-ascii?Q?Kyds1srL2rj1xuK0NPZVeRCtDUrDCAIqCb+/AhwuRqeij9KAczJzKkshj1ux?=
 =?us-ascii?Q?3NC5cEm3UVHTonTqAaYREvyh1POIqw1tXCbgdRJahpz23SK+cGXAZGZmLUOt?=
 =?us-ascii?Q?FQNPQ05OsENdvMsnwRq3+LxFX4ITUqACq2pa6YlqmUnbizzvDf2cAZjL0AWL?=
 =?us-ascii?Q?pMxsg0WRTK+w8tJiKVhrYhpSmqyVh1R1bWrgOZd2zsC579gXgMIpdDDLrqnr?=
 =?us-ascii?Q?YkcNQW4qnll2nCJWnfPdX7nEJSex1U5vCSUPuGVQY3luRh1srdYEYG+dWgKT?=
 =?us-ascii?Q?+t/YdCQgIS3nKeFw/x4/h5UqALgyPAL3nslj1vdmGa3HXSUWSJBJ7WfCqriM?=
 =?us-ascii?Q?gKH7KsfPE7jVudUKYz4gSE3XJ88riwosk+S2pnPs/ip7r5W1KVM+JG6FYyv+?=
 =?us-ascii?Q?zMnvOciGI/ZnAXsW9K8gqnKqpjdLY1lIT157jj7t3/R98PniVlWvd9X3OiGw?=
 =?us-ascii?Q?SO9ksxyMUlQtH6k+t5bkm+kcL6zoy4oQ0aEsn3VDbJnNmdqKW10p9DHuxpHa?=
 =?us-ascii?Q?z5XG1i/Y0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d89e5c9-1dec-499c-a7b3-08de516f47d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 00:12:32.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7JukLyTBjG7/RPa3TIOs8ZG/5TY00va7MpIwW7c/PJ2i93eY8SDPGT41EsKuDBmXt23yiWgUsZGwP8LnnL8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631

On 2026-01-12 at 10:21 +1100, Alistair Popple <apopple@nvidia.com> wrote...
> On 2026-01-10 at 02:03 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > On Fri, Jan 09, 2026 at 11:41:51AM +1100, Alistair Popple wrote:
> > > On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > > > On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > > > > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > > > > From: Hou Tao <houtao1@huawei.com>
> > > > > > 
> > > > > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > > > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > > > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > > > > forever when trying to remove the PCIe device.
> > > > > > 
> > > > > > Fix it by adding the missed percpu_ref_put().
> > > ...
> > 
> > > > Looking at this again, I'm confused about why in the normal, non-error
> > > > case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> > > > percpu_ref_get(ref) for each page, followed by just a single
> > > > percpu_ref_put() at the exit.
> > > > 
> > > > So we do ref_get() "1 + number of pages" times but we only do a single
> > > > ref_put().  Is there a loop of ref_put() for each page elsewhere?
> > > 
> > > Right, the per-page ref_put() happens when the page is freed (ie. the struct
> > > page refcount drops to zero) - in this case free_zone_device_folio() will call
> > > p2pdma_folio_free() which has the corresponding percpu_ref_put().
> > 
> > I don't see anything that looks like a loop to call ref_put() for each
> > page in free_zone_device_folio() or in p2pdma_folio_free(), but this
> > is all completely out of my range, so I'll take your word for it :)  
> 
> That's brave :-)
> 
> What happens is the core mm takes over managing the page life time once
> vm_insert_page() has been (successfully) called to map the page:
> 
> 	VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
> 	set_page_count(page, 1);
> 	ret = vm_insert_page(vma, vaddr, page);
> 	if (ret) {
> 		gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> 		return ret;
> 	}
> 	percpu_ref_get(ref);
> 	put_page(page);
> 
> In the above sequence vm_insert_page() takes a page ref for each page it maps
> into the user page tables with folio_get(). This reference is dropped when the
> user page table entry is removed, typically by the loop in zap_pte_range().
> 
> Normally the user page table mapping is the only thing holding a reference so
> it ends up calling folio_put()->free_zone_device_folio->...->ref_put() one page
> at a time as the PTEs are removed from the page tables. At least that's what
> happens conceptually - the TLB batching code makes it hard to actually see where
> the folio_put() is called in this sequence.
> 
> Note the extra set_page_count(1) and put_page(page) in the above sequence is
> just to make vm_insert_page() happy - it complains it you try and insert a page
> with a zero page ref.
> 
> And looking at that sequence there is another minor bug - in the failure
> path we are exiting the loop with the failed page ref count set to
> 1 from set_page_count(page, 1). That needs to be reset to zero with
> set_page_count(page, 0) to avoid the VM_WARN_ON_ONCE_PAGE() if the page gets
> reused. I will send a fix for that.

Actually the whole failure path above seems wrong to me - we
free the entire allocation with gen_pool_free() even though
vm_insert_page() may have succeeded in mapping some pages. AFAICT the
generic VFS mmap code will call unmap_region() to undo any partial
mapping (see __mmap_new_file_vma) but that should end up calling
folio_put()->zone_free_device_range()->p2pdma_folio_free()->gen_pool_free_owner()
for the mapped pages even though we've already freed the entire pool.

>  - Alistair
> 
> > Bjorn
> 

