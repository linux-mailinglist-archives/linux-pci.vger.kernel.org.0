Return-Path: <linux-pci+bounces-29105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DFFAD06AF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AB0189296B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD7289E20;
	Fri,  6 Jun 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMOo6gFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9E1AF0BB
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227703; cv=fail; b=TgdFKCWue/QI3zd3JJfoK+9ehf5Boe3Ml9y7IdE0JoHxdd58qv95Q0vPZGQNv6KWnt2qtoxB4RNMKnfyT4PgctCI1TZxPuAM29RFcr9tbexqKrTdBcWbT3QNJv2kvNIPTub5YpWTTediyKjIauXMvIX1Yi/CH77nnmMvbpQg8ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227703; c=relaxed/simple;
	bh=eXW/RJFH0wbeONbO5yQh0UZ4HkTtixFZEquUcUKmXB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DsDygTMgtT/XWxAJjmVwTQKPrnuG8mfoBvWQAiYi1FMTPKSOFSVl73knexbUa6XEIolsqxZimT1tfWTo1PNoEBY90UfQ2FhGoXwPddxYtpt2GeJuoU/riP5ZoEEE9xqTpWo5GfTFdNrLyZ3dG13uCyXHi1UNSC4z1ju2q7E0Ex4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMOo6gFw; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9wOgQM2140642RsqO63RoWk99r6vncJpfV8PjFBrdb0PPsOLiNxwop9LjmWY1zTZJ4+SaOtcYA41x9wNK4xOIoj2tax+7YfI/I0RMMf6xnxW+Jvi4Ba4EZVEA+M9u39RXyF+ZEEBUbTO1QD4k7+wI68OztNpo2PEJn94/vOlmby/UN9QEu29ouCe/12PEH33elMNWaC++8oCM5mYW6LChBtg3XTyjXFprSC9VPHckMc0zoFCcWI0/DtROLQ8nrwJAhHw2M+C2sAVMwssuffqKW7yBcw8MK3K8tKjx72O3xyi87HSFiKccacYb1QXStluhGtfF5FmDT1aj9/KXk+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlK5AYDFWaL5sALe3AKqLN2Mov6CIoH8SqSeCfv1VkI=;
 b=vrTe5vsVEFqzfEAXUbYXNTD9QOW3fC2F0A26lWd0tIiiWOZty1AIkzFDYrfzeLpQuAjfcD2KUhjE5Pzxtw2XAsruUo+L6fHboQwqTrhIAN1LKajvJQO6CqIIE35iR/O03A1CU1/dLJhJxRRbkwuRcQt4amxLy2tDisiWbjXWc1z0QDt2EqWh0uFzFIo/M3a2c3RYjlh385gd/MiUqW6q3DQggJ77OKzfZDNSQzfzkpN20H3ydEe99wJg4mSB7Q2WdjcY4Ly8iEBlwwQOfqlCXyszYHsrCR6lAPhIztI5L3sViqdIIYxtecaUyDRp7sxn4eCFzX0wOjXdOwzeLt9siA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlK5AYDFWaL5sALe3AKqLN2Mov6CIoH8SqSeCfv1VkI=;
 b=LMOo6gFwaL04ivOx8gdg41cHssGCUmRULMVhBCr/D0cTFi04p9xAEBFm5upN39YwipvxBPh2dmDuNywsAAeBoCPekO5VpiF9ZeR07xxkKSxmfxq8095p93bMvIs1XUJnFgf1wo7jPbF3Aaj45nSHcfDxmLZRXzqP4lj7CDs6OhUZusQwClJ/DkWShPeN6VfiMteQKNQrp8x+299XiddeNP+wkuG0V6FsmeYpKpCQnLBj+PBuA3B+GWRD9J2MpLN5BBxqPpsVo0EPo2b3GEij7cye5B5WhYxYbc9oGBg0sSQNKz80wLvotGzMxh8/TAxkNkufN8GaZBew4OyPd5kjTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 16:34:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 16:34:56 +0000
Date: Fri, 6 Jun 2025 13:34:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250606163455.GI19710@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
 <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
 <20250604123747.GG5028@nvidia.com>
 <aEML7kUPSibTaAYk@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEML7kUPSibTaAYk@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f9ff93-fcb3-4abd-ea55-08dda518125f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4xsQCScLRNk0F+BBVczaEhcozAYWaIYgzSPaZRZpsaQPnJMtSoUyhWx/P8w?=
 =?us-ascii?Q?+eIi4dAqun+wpVNQBoEc+u/JkfLyDT6Dc1dYFxL4/uaG4BgVDw3rrEXyh1ge?=
 =?us-ascii?Q?ArqrvKCOxGX2ynT469GM+1CdrwgYdjeX3/41BkTF//1/wWL6HB+ZPqhWA/Ya?=
 =?us-ascii?Q?Gqoa02y0MXN8+o2mGxhkXw0fqk9byl5Qn300KC0Lvxpvrddofj/d+PNiovS6?=
 =?us-ascii?Q?iR5gQyZfaDQ1U4VAx2YO6gJ7wDdqF6Mzq1B/0gqpatDv3ux2DD3WFho4pqFP?=
 =?us-ascii?Q?M75RB/BFHrhJ5T7DNGUW8V72xSOzazjnSik3wak2hcp3m+8HhNyKCtGQa7Dq?=
 =?us-ascii?Q?0Co/+jOkClcVLTEJXIdXJ5EZ4I7WRkKwH0MGIdnZfhdVcwXDlSPHycDGUuWv?=
 =?us-ascii?Q?lrGICwt7OPs/S82ZAifXuwHJPnMNVrw9R+iz9DKN3PcXzSWwhFdlIjLkXyHL?=
 =?us-ascii?Q?3NjkLYTtoxfuanI1J0g+PzamY9KQAxdI2tVR9HbGp+qyLIVZFD7nT9yO8WDC?=
 =?us-ascii?Q?Cx+fsthCo2rn3fck0DpQ2NqMbxNtH4PbBYfsxp5RDmwP9zXA/3ma2FllJ7uT?=
 =?us-ascii?Q?aeVNw8cYPPwj0zA2DwXGQBIEY+0h2GzuMy/0oMoqiUl0k3vc5Z9j4hFzXryg?=
 =?us-ascii?Q?EiN8gQ3WuvW8TWBCksYCRkmr1Fabu8mdWwsNKNzPWISHN6KmkXJfcbk09fbC?=
 =?us-ascii?Q?PSFZDGkjFETx8UUDmAN5xl/IOcu2KRjqQPDgHlYpXJX0BYm1Fe0E60r77Qwg?=
 =?us-ascii?Q?YTf2ApXi5CVhg8KS2QYg7jWqWIs14p+uNPcBJVretR/iwMCHtkipDpNGXUwV?=
 =?us-ascii?Q?hT9ahTJVtS1JWByNIoNXOff2zOwNuxirlBz4P4b+hDk68LATt2N7lu07vU3r?=
 =?us-ascii?Q?X0Dg4j6msZetkpUKvqMfcE9987gde6RqJelRaa2t6U923xMCdctCkxd73mpl?=
 =?us-ascii?Q?PVUEvEyj3xIh4QXDw0clB1ICNfR2SQaGpkjDdpEydRwcBGXZLfKVfDVORLxQ?=
 =?us-ascii?Q?k5ELoy4ZCVCSvjAuTU8SZ3884GYpZI6ayr+cUjVwhza7t9CpMhh3xWIOjYr5?=
 =?us-ascii?Q?xcxc1xwju/s8YLANnDOWEyHhbz3HjdOVbkVx0rlf0JeA2+foLxPJzXz5a74R?=
 =?us-ascii?Q?7L1iai3oWrwOJLvnUVp6iHz0R21ywrmyDks+my10x4/Q0N9RjTMusB92iQHH?=
 =?us-ascii?Q?ZvQgr/9GNHagJtiI7LNA4WzS8pW/FDZwHbCIQbdxSIh70OpV7BiISAsRkora?=
 =?us-ascii?Q?sFNIH3tnI7Whm2a/XAb9dQZDk89vPhCv9Y0f9mDQ4stnp5Ye3uJ5dlJHiIvq?=
 =?us-ascii?Q?+FQs3/DVvwdaHSOcMVyYkyl+FeA+zWnINLfN2DdDwLi7XkyRFRpPvonAhomh?=
 =?us-ascii?Q?FViHpS8S+ll5lEMCpdGjfvfpVUGIxozBzYyR1T30gzFQOiG0dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbFeEBqn47ir3skWkprulr7xDiqJT9dVRu8Y+BW/gaL7u2NL7dkEhdn0VRqQ?=
 =?us-ascii?Q?my1Uq072MQ7927ZnGwZeE3LjF/WKMFGrLWngXTigdpAr+CcimjJDqZL2atLL?=
 =?us-ascii?Q?uVn7pS3h4wP3g8xUCU0DoTMU4W5WYbhtqDjQ3cpoewsV3gF2shdoUZZa0x49?=
 =?us-ascii?Q?+eBFPnkjt2NdNRssSpC1lNUGvTkKfqQ//KYhGpSKXzdolSR2SDKoxiYZbqSd?=
 =?us-ascii?Q?DgUZgAVnpE8YSDdfEQBf1ybeRvCh7FluREuRYpztBrEUgdnlBTVpIyEabWd6?=
 =?us-ascii?Q?jjJsipY0n9oOWGoEdgMgW/rdgRm5JTGsDEu/PSYs7T5/6Igit+/+5xrqE60j?=
 =?us-ascii?Q?nhQaOo2/drz2D7knZhuJ2klFtyTVxodsk5L83HfFEaRkVq3jSt+PwM/C3uID?=
 =?us-ascii?Q?v1vBK4nPLTDaMEQS/zW6Vzt4lpLIqWn6Fxy5l1y+TO32he060XNDsYjyoB20?=
 =?us-ascii?Q?EWU+Ytm+8TARj5sE5rtRpsrQzXoMW9eHTKhGcHdwCL5N9YkX/Jlm0OdlpmQd?=
 =?us-ascii?Q?ArmtIUKG6PNOYilrLWC/cLOeKeb6SU4wqc26qgDJcNwZHiF9l4pqgSjjs73Z?=
 =?us-ascii?Q?CLVJiPIDZ/r/9DXaBvK4wdIV3vmEHp9Gzz2FW8XXdA1iFsYbcqbnYVoTz30+?=
 =?us-ascii?Q?FFRRQ7nnJy92lAtLWXNQUWdvzyLW4KExiYyb5/07+ECAEN5Zj/3BGHW8snHP?=
 =?us-ascii?Q?bDeQPNEOsTH7gwOCLM9P7Iy9ye5vAd8GgvYcGypmSSfUAiMkEmf8bZz2zWdr?=
 =?us-ascii?Q?cuPOY64DJIzalYb88WCAu65SEmJuYH8dfCv/XHdGHBT/IkfJ1pSq66pke1oK?=
 =?us-ascii?Q?aR2m8RSdPNX68EeSUGfHh5uM3YxyGVyDb8Hitx4tqXmqjLqP4/awmEfFRNHN?=
 =?us-ascii?Q?OUHp/bH/Yk98ui4mn4tNWo7UYZiT31zwYWNZqZYeiYmyq8+0cfw1W+MNG+F7?=
 =?us-ascii?Q?hH85a1nUAF/m7aG7dSe6AqNHjn7TGyssl6i/tIj+/F4omI3CNE2vi/harigf?=
 =?us-ascii?Q?HtOgfLn1QqY9JqzJGuveQ4zJo3mK1XQR6BnYXrtuY/Jua0/gtWlX7Itn9GId?=
 =?us-ascii?Q?VNNO2rYvwHrf7Q8jXFdXzbaV6ZK8XGd5ygTSlBRku3JrUhmvoZLs57Ris/nR?=
 =?us-ascii?Q?bB7m9MS0tgakUl2D8hKM/12OYJRUnH9s1qZqhUY7aQ84BEDCVd8Id3jVidbb?=
 =?us-ascii?Q?zpIH5LgQiIWJp5pmRsLXvg3VdLhWQYA8oHwnZFEGKK1zrtyRcJphivpZ+lmz?=
 =?us-ascii?Q?6o0R0HhUTSvv7JwnRzxDh6xPbEFSSlAbW5q1MFyy63vu0sPHE4PBM0H0UOFJ?=
 =?us-ascii?Q?1sefNjMYbIxaVvqpKuYGBHa7MdOip9PbKmMKEGP7KQT0XSu4mJu3mGtDmkDk?=
 =?us-ascii?Q?/IBkq4hPgw8xbpbudU/ttPz4nUtBIVSbDNhBjYLsaIzbStapJAVijm4PPgcl?=
 =?us-ascii?Q?haK1e+f3118gUVEtDvvnC4HupzYmYereiqnkg6Fth+KnUL59Z4WpaXryPga6?=
 =?us-ascii?Q?W830inZ/NjS4TqPVvZ7Nz1+SulGLahd/v66reeONHiNC5u6Y4+jYfYbFvJZm?=
 =?us-ascii?Q?6SM1+MGqU3iBMsqqzbw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f9ff93-fcb3-4abd-ea55-08dda518125f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 16:34:56.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrBLaQso94n6X6bBbHXNZreAe8wKOrnAumNOygp+J+/fQickF1upSsePQRHDWYCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

On Fri, Jun 06, 2025 at 11:40:30PM +0800, Xu Yilun wrote:
> On Wed, Jun 04, 2025 at 09:37:47AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 04, 2025 at 11:47:14AM +1000, Alexey Kardashevskiy wrote:
> > 
> > > If it is the case of killing QEMU - then there is no usespace and
> > > then it is a matter of what fd is closed first - VFIO-PCI or
> > > IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee
> > > the order. Thanks,
> > 
> > It is the other way around VFIO holds the iommufd and it always
> > destroys first.
> > 
> > We are missing a bit where the vfio destruction of the idevice does
> > not clean up the vdevice too.
> 
> Seems there is still problem, the suggested flow is:
> 
> 1. VFIO fops release
> 2. vfio_pci_core_close_device()
> 3. vfio_df_iommufd_unbind()
> 4.   iommufd_device_unbind()
> 5.     iommufd_device_destroy()
> 6.       iommufd_vdevice_destroy() (not implemented)
> 7.         iommufd_vdevice_tsm_unbind()
> 
> In step 2, vfio pci does all cleanup, including invalidate MMIO.
> In step 7 vdevice does tsm unbind, this is not correct. TSM unbind
> should be done before invalidating MMIO.
> 
> TSM unbind should always the first thing to do to release lockdown,
> then cleanup physical device configuration.

I think you'd have to re-order things so that vfio_df_iommufd_unbind()
happens before the mmio invalidate..

And if you can succeed in moving the MMIO mapping to bind/unbind then
the invalidate from vfio won't matter.

Jason

