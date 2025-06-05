Return-Path: <linux-pci+bounces-29035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06EACF25E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C5417A719
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5552C324C;
	Thu,  5 Jun 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTEN8PXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD81A0BD6
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135282; cv=fail; b=fJUCDSISHSM0qRtD7Vh4NAZwYqhBGGYLJ9MmVXI8KSmvEDjxp4sIsCCeygFO5XI/MTNyz1LakL5CnLwcFuc8Hx3C+RgkfCMyYIU36eIJkJNB56chnj1qBh+rNhrVvBkYVdu2gPg0P380v0zPHHi9TX6lAoPMP27aeeG3pRSSo5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135282; c=relaxed/simple;
	bh=COXR96N+EKd3G4BZCSii+95IgHkFBUcXEvp+PmUploI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WTXpOaAA1o7QrU3Kn9V8q4mBWFYas7r08xKzLVXji+Jvx9QVJuXA/te/toWHXkKkuQQmjVmZXuyndt/u7p2XkWL9gPGqH5w4ya0Tt8+OSnh5pTgmyvE7XAw1VfCYG/JY8a4fGGFHe6eiWxWXlrc6PZ7/jGjqtsAdHjDCjAIS56s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTEN8PXi; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4SsxjesrQHs9SYLL/AHiNUMyLLohrQgnHxb/S5v75GfvPOl+WErnEHD6IrL32Hki9zW0EVHpFkWSgyXBYApHqYUdJ6yUs1oDWRNgIP0+XzOiTfHMes6QZFghvrUvnPlyRItDfsJFGlq7b9+U3N+2FsOxTv5edjim/t33jtOO/BIQhAEQ4JmDeV7roUNWTr+AkApdONl+4tV4ZKJGyshIiY7h+0sLg0FbTs3qWPApMjte0IY7t2BtlPonoxpKhne17JJ4VdtdzaNusweMCk+xhSHe7DfJYHMK6sCLQsw7cxmZXzhYIkzrcVXqY0U8w8gUlHrQ7n9r7Nr4n92YCkc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COXR96N+EKd3G4BZCSii+95IgHkFBUcXEvp+PmUploI=;
 b=DXEVec6F7N5AsQyl1f34NsygJQykDK3JakQThtMZQSopLnaOLGJkxIBaIJw+N4yid1llBX+SDuhaDrn8r5mH4EAAvgwfAEUWPfjWmzBy4EJOajv2seXcsKbDCzMGtN5uqfJ0KsREBaKMprZHB0W3mQvMlpsUFYvPhtWpmrBK/ntIlEeXV6KlrIPOHvb4NwMvrGt5Eha40nN3RPhxyppahFZUmrRCvZgLf5uKPzrwA93WBei4aCjjaJ2r79dzsDKNScaC0JzXfvi/rwuRVV6QhGwB5hcBU66zhw1gIpn8rFTq67hwGvVx68YR/weATckg0auRUbr7b0o3qGmPWUTr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COXR96N+EKd3G4BZCSii+95IgHkFBUcXEvp+PmUploI=;
 b=RTEN8PXiX0uZTChJoR69NKr9S4j0W2rMkPr8wLcXcqDGXZBLN+G0PgoNx0idTzbNB9ISWR6pDjwODoCiEkzs3r3+7PWJk9angbXsdMJSTZJS7TXMcdTHSBqjTxtvbIb03FxmyQlGv0APMC5gtV2a5D3W204TdwDbsDTw+ugdbK5VK6wwrZUZv+3Ye1rnLmRy6CGGIlXUJhej2uSKTM8aR21Kq11OE0EQn99fgE9gMwHOPtah0yrfr7fO0Oi+paFHQ020Zxsr1w4fYCPjSEvSvallyYbITjdMtZhFgikzLVsL47Ilv7oCoi2OIXdVmBbkCApKtP18krqjLYeTYNnn2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 14:54:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 14:54:37 +0000
Date: Thu, 5 Jun 2025 11:54:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250605145435.GA19710@nvidia.com>
References: <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <20250604123118.GE5028@nvidia.com>
 <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: bd107a9a-0d01-4ec3-d171-08dda440e430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UC12ifrV0jas177m3zQ5bvuv37WlLCWrHV2FgjDu2pKkuuWygRS/wCUkf5OL?=
 =?us-ascii?Q?N/neiTXSitydX9+MDRQYa95A2Jegt+wpwZRv6sbwYJWJ/SQQ/AGEqL6Mc5gx?=
 =?us-ascii?Q?Fxd9M5j4S0VZJU1UvRz4kcVi4fd51VN62gce/I9o/ZB+auK+lI861JMuVLtj?=
 =?us-ascii?Q?YLVsKGl/jXSuKEf91fWmO1sJ5qtPTt4At+9TCIU7fnI7m6U/s9MsoehmUVXT?=
 =?us-ascii?Q?6k5opbP2fKmVinihqnEPF4MMlI69EvmpyQwiBUC4zK1DTuyV56nteufIV25e?=
 =?us-ascii?Q?LJdWSRxNPx+q+bxuIRr0yNsgqVqjDEmCPE7U8cKHBRQ0MAXDDc8P8Ztd1gdN?=
 =?us-ascii?Q?47UUJM+22SjT2oKhBSjtAO0gk7sgCM/kR4HXQJJ4YoAzi/BzP8HlLZHio1IW?=
 =?us-ascii?Q?oKYgRRRzIstv2mn8XYAgeEu+Y2X6PGg61Z+lybN8/yUXQb3ITfFCk2RXRt+q?=
 =?us-ascii?Q?ZcRTgm4ZEydaHPQxjnb/07uIYNFZui3LcnoRQXiahbwl3EiNAB5cjRIivmvl?=
 =?us-ascii?Q?H+3bdolkSh+GcGlZ3fMRzPKxSJmQTDwJv5xU0YbJ5cByFTPZC7EMgiUU3eJd?=
 =?us-ascii?Q?KKxKOPt8rFgMbrXTeyXbeK3R2FO6F7qM2gcPQ7fmh0pnCB/j2WoNLyMLRHcp?=
 =?us-ascii?Q?TlV8mvS57Wtm7sOWMwAXUFqIMedAzJK0UheqXX2hq9uq3ZzU5MtM/xG+Ns5e?=
 =?us-ascii?Q?vJjsOFIBwgAQ+3X9kf/YEUTBggV8lzVAjnznBmF93O5+7J3cjnxE6Sw+9eIz?=
 =?us-ascii?Q?qE6/A9OKn6mIyoY18KNUc+DbwW39FWwCb1EYkZtewWL3hYF9aNImf/LxkZNB?=
 =?us-ascii?Q?rLXpKET9fA7XsQRCJkLvOg5+3aFWXxq9b2lBOXcL1bdfjamsCw6L8/hv3pzz?=
 =?us-ascii?Q?AyB9JkeHcgBSx/YBgpwmEDc+3hI2b59uMIIUuzGafXljSoGC2oz+xKLO/fID?=
 =?us-ascii?Q?ZMXLoB8jh+zlzzqr6zXha3/AfAFq72mjTUYtl1AKUKARL2nk3Fd0IH+5CnTs?=
 =?us-ascii?Q?QFpmxXMNf/T9v0Detzg+z74Tz0su21Klpp7VqUgr3twvrCOuw3OO2VbN+HfN?=
 =?us-ascii?Q?cKatPDyP9QF1eB2SEIHYBvUwSYLEippdoCP/2dMdAiO2l3fAmBQ11u5ofz0I?=
 =?us-ascii?Q?5i4lEbCTlMqvYvDFXVB2iu0NpGCV1SK5scTsGE+ytgs0VcNXTIUFUew/4Dc3?=
 =?us-ascii?Q?hOCE6HMe2f1vqrFr40dWOlbeMiYHSAiQGyBQt/O3ZgcTwq4hDRnBoHMn3Vhs?=
 =?us-ascii?Q?pilBwuMPjhN1FaRKNwy6zwH0kOc3gyfzbz5mYwXCZac1guTDzuHi+A0XiG7y?=
 =?us-ascii?Q?/6K8/s/V8gq4SMU4K7gps7F5sjUtqVJs0hCDqOrCI9+B4WH1uTKtDTaW+QmM?=
 =?us-ascii?Q?QUfaeiPwItnEM58MDUtd0lOIULG3qfXuoJQHJyO4aRlS3zbY6AjS3wrFnA1r?=
 =?us-ascii?Q?jS71rocIMxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzJ2A0QpNCeahG30UWSizm43ppgJXp+ZI7fSyRA3I0wgmfGUrovYGx8ixPwr?=
 =?us-ascii?Q?2ufF8048/voNugeeR8yBjvqP/98/lsARv1nFYIgLQ99pskwphHS374ZOdqyU?=
 =?us-ascii?Q?liX9+H+yUs8XyMn6X/IMwSLEF5YruCPkbfsVBmOcUUB3AuyzCRtJNgcP5EDu?=
 =?us-ascii?Q?W28kdj4E9kmgAS3WJX5oUxQKz6VHgmYT2E87QUtgDhZzXb/BT+yL27Q3IzGy?=
 =?us-ascii?Q?lEOw6RjZr0Iib5WVNQT7a6NQkqpogQqCKF054VR0qrCAhbwY8psHW8NWvAxN?=
 =?us-ascii?Q?Xcg8G2Z76CLwxQAtbxhzW1cVZqfhHM8A5JIBcFw1KPeMxpom/SLDpl9XAzfz?=
 =?us-ascii?Q?9XqtlDeh+JbECPLpjPi2HcFi48inC7fgQb+eTxolVYdtMdtNT2fMes04B1HH?=
 =?us-ascii?Q?tXikQeLSbt2BRia/vZ4B08gld045jcTUd+Q7O4RBHXdCy9+WowfRHOAIPveR?=
 =?us-ascii?Q?ezWmYrn9FI3McfusgIn1qkMBHrBjZiLN4PuhWl2MhH/uAwyw5Dh5WtjrmnGP?=
 =?us-ascii?Q?SykNBxWbMfqwali8BVDyph9EIwlsfEJ/Y8joBKUOy42R4VjLmcTVo+VoW/Ls?=
 =?us-ascii?Q?xfhh7XC9YOO3wZRRdZzl32YfHQ+3RmurnRgPRqjeRUeab9hLUmYiXp69ois2?=
 =?us-ascii?Q?BKZ9oVWU++3cek4WycPzjZh8Y3RQ4kV7ZOdq+qyoXYKh1HSs3qXdjGGj7+I9?=
 =?us-ascii?Q?btk4VvFxXmqT2czyypK79nXKJNzUkIKNVHB7cJfSmvEKDg0uwznlFNJtMABD?=
 =?us-ascii?Q?B6Jv6HFPFy4Sg2RmnLuUE8ALhWQO0LYW3L4RRmU8RKT5UflGBDNUqElf2kH+?=
 =?us-ascii?Q?idqv2hs+lUFcZyk0XvNd7NdL5W34d0w0QpySgbHrntppjH5TO5Ye48K3FW9q?=
 =?us-ascii?Q?YH9dJoMBaj3MSl/vnUmNyRPibWxOZau7iI6Q5sorAriZ9e9HtlhJQV17eJEj?=
 =?us-ascii?Q?lRR5TCgi+z5z3cQCKhTuLl0xJsZpx2u8jYgHqrDe8Wcrkah9nAt6owCXYsq+?=
 =?us-ascii?Q?KZKHkUJu5j4dmJfqMMM3uVlQm/w3MLLGgfFS84SGv81CHmPsB7PF9ducerTK?=
 =?us-ascii?Q?bO6RAOfN/03xkrLn+UgZPo14N1l/cX7msQ5psgXijmhNSRRjzhaxS2srsr/A?=
 =?us-ascii?Q?kaCh/inHAOl+yTS/k7N/Rx20dfLiv9MumUm0Xegvl2TxSYH643dTsU+lf/uv?=
 =?us-ascii?Q?pp5nILOaQjNsM2W5nXscvSgyMdTs4oWlVN1hupdz2zhIKqlicVCBkFOxRVKg?=
 =?us-ascii?Q?CwlxC0O71vH71xot3uMDT2C9tiJ/q1BWKFjL5znqGvBdBTPTmPHHMh/DvLqM?=
 =?us-ascii?Q?DYwi1t/nSPpYVvMr73kLf1m7Zgnip/sTIxVMEs4SNwrOLYbG+9zVdQeCqPxe?=
 =?us-ascii?Q?vHP42+7aWYXRgK0HA1IkzYC+ZMxYY+5gwcrmE/4PyvWyjOQhMniztUeu+oDU?=
 =?us-ascii?Q?47jKRb30aCS+BxhR2tnq8fXsBEbr6nP7aKJR91tzAqxghJn0z+CZCVuL/5KB?=
 =?us-ascii?Q?CAsMVJ6vNfgBaPsqT9LDc4XxjAUl88M3EsOXBdZU+0fRCkfQs4aK7tkcTSW2?=
 =?us-ascii?Q?KrQ6GfHOTHoU/IR0ckk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd107a9a-0d01-4ec3-d171-08dda440e430
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:54:37.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnSYNsHfxqaiLgrwVxQU11wE8Vbk5Z6EUcjmiaOVeyumT18/cIqLf9JszcxI4AcM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

On Thu, Jun 05, 2025 at 11:25:29AM +0800, Xu Yilun wrote:

> That's good point, thanks. S-EPT is controlled by TSM, but the fact is,
> unlike RMP it needs too much help from VMM side, and now KVM is the
> helper. I will continue to investigate if TDX TSM driver could opt in to
> become another helper and how to coordinate with KVM.

I think it would be quite a simplification if the iommufd operation
would also cause the TSM to setup the secure MMIO directly from the
pPCI device and remove hypervisor access to it.

Then you don't need DMABUF to KVM at all.

The create vPCI call would have to specify the base virtual addresses
of all the BARs from userspace, which is probably OK as I suspose you
also cannot disable or relocate the MMIO BAR while in T=1 mode.

Jason

