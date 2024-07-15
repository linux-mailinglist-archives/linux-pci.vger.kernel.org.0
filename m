Return-Path: <linux-pci+bounces-10329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808B931CFB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D307B21CC2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E29E13D533;
	Mon, 15 Jul 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sI+g5lJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365113C9A2;
	Mon, 15 Jul 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081021; cv=fail; b=ap2Y++jrsEsJZSW7UWe+1J1C3QsjFzwvAiMpLEVxueafLa5mXjDPDzMNVmrkloVul3nkO9TNBI9OgYL44W5THSbU2jzpw5RhnV9+kG3TIZGBjcJP0v12W1Ia3bKHYsilBQfAWN2mL+yD0yOfBlQAX0/P/qhGF81pugeb3zYokkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081021; c=relaxed/simple;
	bh=CSyo2k5RDxC23T7APbpUXc29CgLj24IMPYwrxwcPnc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rGD2ikChVfw/7wIDcg41UgoqlJdgqEE/pOGqZy9m7mlyAe1PMBoRQxfuaDILxSDPl2cHwFtWFDE//CNqEYQT1dx/bEeD1DIG2kM8GRPM4IBc6RRTPZzSZhLttMPN/GemBWGM4dwWH+09P89hRpIDRoZQtc8R4uc+vg/rwoHXnAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sI+g5lJI; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Onpp7Mc9c6iakYhDY8dg2CggjmFCN1LekzjbLxAIHrQOQ5hF5p0u3bdeR+hMgNQIvm2eqvsxKmDHoOv7J9KS1oyzH6jRcCDpsVDduyPDZdQxpIRTC9SFNBGryjUFMMoMnmCxOMoY7nDFyxhxhBi7BJmQqcDmtV4ZH4RGDRgFC0QpTUM2NSKiEe+GXJYDVLizap5dlGx/JNgVvlgs1+pHrrDV3QZKWswBRcP42vM0TgsIqkN8jnhTKKMHv9PrqUWs6TpI7DxmwMr45rG2sB0rFgxJhjGYwNuaoMWJKfrRRGsI0V8DEl9zlSki/Yf19oP0xPfwykoWfUwM6Lc8pZg7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb0Kj/yQFPh7al/4R3fKkZkkpm2YuGLGxP2n7ttJRW4=;
 b=cCntKxA6opIeE+fBUeyhUMJww9olOsYLYDjoZ6C0eyl5EDq/A2dD45GlWHvIQOYUjWfZhltBYOoAlUcGd5f8OZsQ544D1v4ihlNStoNzprqbXYeVY/SUqzL4I214lONAF8h/CnkKh/b34fcIxbLNebK8XJthR2c120pARrSL/imHSGmiQjV/0AJACDOYL7RRPFVgvJS3GOsi+mSc+785ozQOI86TomDeTFkpP/kf/fFOOjyMvNuR3rMixQ487BwmAXwyw7WrHprJBrJAVvzobgCto9m2yCW+YaeVNE/TE7f/832a32uDTtcacjQ9RzvMsLTu3ONS0qZxgoomAW82Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb0Kj/yQFPh7al/4R3fKkZkkpm2YuGLGxP2n7ttJRW4=;
 b=sI+g5lJI0qVziMDe3tcb4wBFDmtSwaO+tezBmw7Quxt+CjzqXhU0J81VFZKzVYokldDBmr83tlxmND4Xd1lVKuunjhC9nTMRCKvolzCIDtq2r2ZmQeiTZbCR4Qey5tnaO6NND4R5jV8pI6DLfr3GWaHHLLZN78ZPZ0DC4rpMDrQ//5Y2I7bEfc/wfYn81BRpCRaYD/MQbWcZQGxj9SXds3sY0v6MDWu0OisbqKErFZar5FAMkQWm+GtaAxF6fyLe/OeZoh1VTUZegUy9zpQiSRRHqZ+N8suiz/RLQUOCHxR7Uldkew5uf3cEudaBmG4xo9BX8fIYxZxxIgu4hpk+Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 22:03:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 22:03:34 +0000
Date: Mon, 15 Jul 2024 19:02:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>,
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
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240715220206.GV1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bf730a-f7bd-4bbd-f709-08dca519f8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fc2Z9N7BYodnVZ4mt343FiSirtPYCI13iocAsk48ZzA/s+VR+ahQO+AvwR3L?=
 =?us-ascii?Q?ajXbBfl/xJ/OeMlgozkuDClOCd9mNPiCefMhU7X0IQKuZY1ILZyalnHE/HEv?=
 =?us-ascii?Q?eBLS/gMFuhUGecTrpNpsOj59uNFtNbb3DK1xDVe0y6zrAmkAwskQtOk+MMQY?=
 =?us-ascii?Q?SXkbRL7Bjx2z2yu4O8Yvin1RkE30QUDyt48rdXrLtwBDmwr0aVsqcypRkOVi?=
 =?us-ascii?Q?awH3ep8N3LywyGlL1YF6GRKiSGrsxqsOYIelt0RK7C6GKvEnp3zMK16RKW/9?=
 =?us-ascii?Q?NaGkuipnHMF4U0Kam+e9AxGZ9aCQUoNhGqfAptvyIaA2IL6lgTzmADgrUV5I?=
 =?us-ascii?Q?bxCPHqvJyoX7ZQO8sRW8ZjVSSjhg2ZUlbQjgmIwHFdWSODOOq9HSW3cvQrXT?=
 =?us-ascii?Q?1yXYxRYOMXrLZLRL2cH2jiIrblZlRa7/XGlPvV0VukoqweZDFaNUDnsI5Dts?=
 =?us-ascii?Q?SAAtV7hmwbgXfte9eUaZxAxYx5onCMRPBRZtjTfX9tbN/BcMfnl9kbsB0xaZ?=
 =?us-ascii?Q?ccyss+LnNktQPUhEub8CBcj5/uGDb1u3iWSe8yIzyJhittTZra+mDOuGJkWF?=
 =?us-ascii?Q?nCq8ZEtKbQ9KGe/oI4WbcWMRy/qxKyE7fxZMTQ3FaGtDMegHTy5F3bLox7Rq?=
 =?us-ascii?Q?/EMlexaz+jgsoqKpZjIlwg4q9zfdG2vARkUfOUJzlgQsJ1fwX59Vq+6FLlYe?=
 =?us-ascii?Q?AOEAEdSfRoYpCT9bsIL91ytK/6ylxON3wUI2Xz38l/G28eU3SvKU2oHiphP1?=
 =?us-ascii?Q?faj0hydOz7rsS9Fogy5N8IdcVcnzROVkPEzjoiZ6vsYmTVifbLznBA0KLgck?=
 =?us-ascii?Q?pO/W/zBhMqWPYMPsdpyBq46qOFsOlw6hMkmhcdITohjBpdGyrDLKpyGlU06m?=
 =?us-ascii?Q?/lXZ9PWqswf+p2hjH29gsX8J3CCCmero43PB8OSaBN9zvzsRjSwFLLeM2O3O?=
 =?us-ascii?Q?/ZNorzanfxnsGsHz8EQe7ljXa0j5uR2iNYa7boHKu69r5ud5az9c6zVUT/Cr?=
 =?us-ascii?Q?urYFHGLH0KHFoJoopxErEkvR7nS3HrBbaYY8Ko0MrLye8lGqM4D24CwDUZMC?=
 =?us-ascii?Q?OjeafRg+pxOZKZKmv4ppQF4jEXB6aGY61KKXigUqWMXyiIBGMwEsId5IbvQO?=
 =?us-ascii?Q?md0ZtF1QNz1voaXkM2DW08sEriuHTtsp8DL5+SNvO9DoyQ8rgZq0tApktVKF?=
 =?us-ascii?Q?bCGKuHlg4/+fJPb1tFdoCMEXVSDMcEBZp/gZspm2B65d2/Wqk8rv8F4+Dnwp?=
 =?us-ascii?Q?K2kR0okvLE/DTILLD3C+c9ANWInWiql5XO5bg056ZaD5rP32Bu9W8V4kM7T/?=
 =?us-ascii?Q?gVc7i2liVw1xHNF3b4AggqDoWLhfZz91C4NmNefklpThwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgt+WTOc4qDtK/rl/O1vK30ezrmcjOkPcAtMFX26PLRm5746/QcUqpiIgTK1?=
 =?us-ascii?Q?FqhjX97Yo66igceHUsmy/fQtMa6UchslT6wT8xogKnI/TGAhDeEyZalckVti?=
 =?us-ascii?Q?aow/qTxI+GwvtmsRGTOLdfP8yqHfEyvQeijbBgywwWsBqZXnNxNyjc3b2qtM?=
 =?us-ascii?Q?HaxLeh3dygxCh85AH0USNmdt5pbZ+C7vY97MXEQTb/0V54369EpDXxKTD5S/?=
 =?us-ascii?Q?8HRHEwa6bgbvNsSucVMbU8SDrAcWHQrOw6vBIp58O7aD/bk5s2duGCHmRu0A?=
 =?us-ascii?Q?KGLkGEbqXqiNRPQyeKd4FQQDCf/e8tI8DHyFuFP7/4s8zRxT6mrP+ga/4z6x?=
 =?us-ascii?Q?R7KWsmo27Rh7m4kRJvQJ911YzYQ3hRWKuZtvGEKrzFnJcBgK8DRTrotoO1UF?=
 =?us-ascii?Q?x4f/JiKsiuDBPA4FsjfCRKfP08RxRfb2LwVxo/ghFBPsTcYjfKaedKvbLMwr?=
 =?us-ascii?Q?QRfpU4pN2HUcVgmWBYmItMC2+p21ZaFZQilB4maYLp/lGy6A5b3tIBWktQJs?=
 =?us-ascii?Q?hdYsij6nbskYUlwvCDecAPJQ3Q/R7rWjep9G+sMUP/ZdpWFPZHSAMczi4Rfz?=
 =?us-ascii?Q?OmZz+EFoUHY6j48/oGo9Bi0UdPe9feXvNknpah3nHtfn+Cc0eYH/ILz1cpXe?=
 =?us-ascii?Q?XdUABOlmUtOgmgBGzSl29Se6Z+nVbBAjdKM37xPMcLpzLZY/9sDe7ADpcl/X?=
 =?us-ascii?Q?mLejZUe8qaK6bQ4mt8dG84CAK6wl5IjxxZ0xaLRu6ImUP+kkVAHJRoajgc30?=
 =?us-ascii?Q?OCp/3vfyWYhC69p4HaKuzDoKypxd7qKg1iQ+8ipBqCpXdBR2WLc1h+FmJwJD?=
 =?us-ascii?Q?Sp6ub7GgQd1C9lPwqexPFuYRUxj25TQkTZNvvzjt0JFobdj+sx/zE2skHD0d?=
 =?us-ascii?Q?SRlGXMSpvBs9MQao6HcsmwwZ/BVC3613sTUDWuUI80Zw+8FlvR9ZkHzBQ5Wq?=
 =?us-ascii?Q?+9GcnJaQnnGXgAOLOybPSyoNNDI6zr4MP54kCcOJcOM/iBfcU8+G/srlavGJ?=
 =?us-ascii?Q?2ZaYxuJNlh+lEyp1pnucDS3eje/Tmo8qS7HYSozOaekjg3c0ULALHTeV70sf?=
 =?us-ascii?Q?4XE5YV6E0ffuHUKdciqIHKeZW+AsvRkmYfOGOf6IOCoEUJiYrhv65wXewExt?=
 =?us-ascii?Q?+qMPAA397D2QEeeIHWyKQE8dwmiQ0B8zmPgGcX1OgKDqcni1ip267wRxqueI?=
 =?us-ascii?Q?Lk8R3V8AhgJ7cgCeAZPV6c/g/NgBwhNXUtuQ7/m49WoWxZz3dl0mFK+QEcQf?=
 =?us-ascii?Q?KVr4BrtiJ1m1N9r9zFrz0eP1DA16b1vmJK+JVCIza6ahBaPhgmdKenGXcIba?=
 =?us-ascii?Q?LuVbqkZmzyZJZYLXSBrUAMMkU0JZfE3nW60tMPfmEGf59J0hi+u9tQY3iuiK?=
 =?us-ascii?Q?o/+YvovSm57iah4UudCbKBBY/lUEHV/6oVQkBf6clEVVqKmtquPq0rkL7fVG?=
 =?us-ascii?Q?uvx9njATgR6dOuTgv4Tlm7mbc+FEGYlX6Xl85At9KszFB9J9mxxStHiTA1sx?=
 =?us-ascii?Q?ek+Ix79D2fPumW5J8HQSqJitCDjDTzvKFTYibjlN2vSsDTlMCKR9rfgPw3LX?=
 =?us-ascii?Q?4fP1f1Pgu+0jZN847h/pJ4I7s8Cdbwf3PMnkLWJh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bf730a-f7bd-4bbd-f709-08dca519f8d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 22:03:34.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESUs17BClhBRTcMVKVllsxgXGnqxsGx2GZb0+cDngHr+2iXx8l9EARWF//JMw8sT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Mon, Jul 15, 2024 at 01:36:32PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Mon, Jul 15, 2024 at 10:21:48AM -0700, Kees Cook wrote:
> > 
> > > Anyway, following the threat model, it doesn't seem like half measures
> > > make any sense. If the threat model is "we cannot trust bus members" and
> > > authentication is being used to establish trust, then anything else must
> > > be explicitly excluded. If this can only be done via the described
> > > firewalling, then that really does seem to be the right choice.
> > 
> > There is supposed to be a state machine here, devices start up at VM
> > time 0 unable to DMA to secure guest memory under any conditions. This
> > property must be enforced by the trusted platform.
> > 
> > Further the trusted plaform is supposed to prevent "replacement"
> > attacks, so once the VM says it trusts a device it cannot be replaced
> > with something else.
> >  
> > When the guest decides it would like the device to reach secure memory
> > the trusted platform is part of making that happen.
> > 
> > From a kernel and lifecycle perspective we need a bunch of new options
> > for PCI devices that should be triggered after userspace has had a
> > look at the device.
> > 
> >  - A device is just forbidden from anything using it
> >  - A device used only with untrusted memory
> >  - A device is usable with trusted memory
> > 
> > IMHO this determination needs to be made before the device driver is
> > bound.
> 
> Yes, and it depends on the device. Some devices should be filtered
> early, some devices need to be operated against untrusted memory just
> to get to the point where they can complete the acceptance flow into the
> TCB.

Operating a device with both trusted and untrusted iommu
configurations is complex to manage and depends on how the trusted
iommu HW works.

> The motivation for the security policy is "there is trusted memory to
> protect". Absent trusted memory, the status quo for the device-driver
> model applies.

From what I can see on some platforms/configurations if the device is
trusted capable then it MUST only issue trusted DMA as that is the
only IO translation that will work.

Meaning the decision to operate a device as trusted or not really has
to be done before any driver is probed and probably needs to involve
the iommu layer to try and do something about this mess in some way.

I have yet to see a complete plan for how these details should work :)

And I only know in detail how the iommu works for one platform, not
the others, so I don't know how prevalent these concerns are..

Jason

