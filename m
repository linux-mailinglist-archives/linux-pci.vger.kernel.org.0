Return-Path: <linux-pci+bounces-10333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71319931D91
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929801C21AEF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F31422D1;
	Mon, 15 Jul 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o77DpKaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C022626;
	Mon, 15 Jul 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085719; cv=fail; b=JVq6ucLFnZpAtH1JT6F4rl5XRiqUh5y5H2S8wk2rGnl9DI6XyaBbQxamxecoRYeYiI2Klrp/49Td5HmOkn8RkHg6GF7CSDhd76SddAW/xiRSoYUhGhPb0pGC6PgjlPSXEzGoAExq0nx6CRnBokTPDXugneD5sFlJlPYM//a+ibY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085719; c=relaxed/simple;
	bh=WeUBtERRrzjEkoT9LtWx112GpogHiplbpwdYFqDT6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXZ7uEbuyvsE3O28n1VqOVjjXizoAgkK7mNaihdu0iZIxQhHmP7S6DXvBguHtFRz4aepMz2j7A9HrI8yVeqp9EmRS2GfGFFhDjokqSYdwwZlJQStqLbZasJrlvOpRM0lI4V7QaW3qgIG3cE1CISAKG3UynWdWpTHnvQ3xjxpLnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o77DpKaT; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxGJoS6ypJOVH/eJQQIgS8Sphi1eZAJKYJPIVF/mTTwbIB2DUYM1prRBc09qi9n0DsaMgS+FTX/4NHOSPQQrGUjIE0/4R5n/sfhg0AsgCJ2vbnu5kfWC/nGo2W7zs2kNYyp44IbjU9kLEMYqq/8xxcsf8KpPrkbVEO6+MAzEObevKfySkEi8NBf3tLwFseLk1ecHv2y0xlC4r3mChgu4luVOuAxgOyyUasaOj1MhCP//ZkL5cfG4T4tZkD+SXxo0QmWeAejRIYa7CJk+li7ojIRTeqPOYEnUDsWgJONKqp3jmOAPNOWG/OqXZVwCHrvg1Ml3SCYejPmd+Mtu4cgflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3N5W8ElMTOJDOJzRFP3g2ETjjU9mpbf473kG6Pmmo8=;
 b=C2phlnoB93hyNmZf2mOWbUZXCYTJM021AboJwpaSK3oY6xEO051aUR81by0IW5V24iQTUwoNOycg1UIeBt5ZHFIuN5tmptXRDQGchYv+Kmtizlcm3dbmJb9r3sFK2SyCKnIdkKUebql9DXAnNp0yv+Vq0wyVqfIfeFFNOIHlc5JurG7+b5pech1Z2QeL5IS+2R2PC5gfyGs3+znOjwxAqLj/dGSifuiyD1rqCpYIs9WxabcJUtA1XogZhWmbnA+wgI7t6wlWfnKE0ymzWRT+mGhhqdKeRlvmCAfyWVXc9qm/6mH0/b5uUoAwha+AbJ0sVMAzMBFqgoiTykLIj2dNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3N5W8ElMTOJDOJzRFP3g2ETjjU9mpbf473kG6Pmmo8=;
 b=o77DpKaTvtLZIxtW85fx32megEw/wkKRtWHfmOER+zw939LCc6shBVtwQZtZmHl7qSNu35K5Lxg6+Sle2qSWLG3g8fVcMtQKoenl6cyGlQkTQgKXVAeBM2vMVYX1+plLqEIGcGimuUC2nj1TNfYegbEXuXbqTQSOSV/STeO96M6lcyorNy2qtOkbfx07zvhrTqfuCv7gzTjA8lhbM/NamGSf819pLpLdixLPC9qpUuxoyWFBidcnGeHRuz1wzllfikhVFB9r6Hj1LNnCQuzjoPnn2jmTxJIqi1R67E+trNlHWwV5v8AU6HX7scoorejcEsX+HrMuRu4/jPTEZaMJ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:21:53 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:21:52 +0000
Date: Mon, 15 Jul 2024 20:21:49 -0300
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
Message-ID: <20240715232149.GY1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:208:134::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7446ac7d-3e27-4342-3740-08dca524e835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSQKPqn+l3leWHQhQXz0HfV2w8JlMbRWWMwlZaiFzivqvuzigsz7clWTPcgG?=
 =?us-ascii?Q?splxaaYPBCq2dOmOEphRS2zs3ipRJGAy4bB3Tb5sdkOf8J8r2YKDqYmslb40?=
 =?us-ascii?Q?kIQ+IlyLugF+zZPSkudK1IeMKylqFk0tGF64qC/wRqcGnQRXUUnJjrmEj7sv?=
 =?us-ascii?Q?PuzCwaKHjxUq1q5opHS97Plm1UEDIiML/Goq593iiNhtdRdbvTHGdglJuQ9i?=
 =?us-ascii?Q?2q5WsR/mhUOfQXGg6OppWCnoa4SVLC1wxZhia60vBxR3iZHsKYjrg2El9dSW?=
 =?us-ascii?Q?0I4Du4AAsuegDc6jlGZrM08IPA0kSg72hKAPrZ9dDzlFoN8Iut0cubhtfIGg?=
 =?us-ascii?Q?GtezV8E2nwTZL3x2D+3yIJhirIVkoTsUv6BCXTbgdMiN/Q79d0cs01+sk1iC?=
 =?us-ascii?Q?uw4jyAsHpzA9xNkmaC2L/ZZpNAyzdf7bqQSeNntMy6l1glMk6jwQ62DSx6ZH?=
 =?us-ascii?Q?FKDSA1nKEozQzhGg755oAu4x1Eb66wuR8qOBLqBjAoH4+6fN6efjkyYmciTO?=
 =?us-ascii?Q?ZwLIlRYsuwuNPlOweZu5ZRJt8muVrLN6Jh12+qe3+JVbluH1hazTeag0yhzq?=
 =?us-ascii?Q?frBKmOvBpNCd28e3G80Egqbev1kTrIOUJ4S7s5ha/FX49o+ZI4hLper/PxGr?=
 =?us-ascii?Q?lPXPnLnEgRwltuf6speC3qnb59FmkSo2ZVJMKNd8i01J2Q6guq76Btc+fE0h?=
 =?us-ascii?Q?CKc1JSy7G/4WpnelsA01vf2Adth8LaOcDoZQZUZFSWJk620kr9XFKxZ/d5fQ?=
 =?us-ascii?Q?6JUgqxM1jyrv/JiVs+pH62UA6sAedUaB9pWu1M6xBYteaZpFRsi3l+lxxMZD?=
 =?us-ascii?Q?vUpQ6V8Fd7i3yAztJRPmBdcWTU+NZoD/fxOQeVVxlmQuGbGwWehSqSQ4LYFE?=
 =?us-ascii?Q?m2A1/iV4iEXlVL7RHuZIrpoUX/BoHfq4kJgHsZCI1CyXaJJHlTk6wx/Vyfyr?=
 =?us-ascii?Q?ZuXhxtijRcNDyT7ukGxW1JrK3gtatG1B536b1p5nmcWdwsu0+wwQFrrH5ITC?=
 =?us-ascii?Q?MLW+1uyW6KH7MPCBkfV/24IRGoFCk662BNrGobBkWWccCor5GDRxDyZZOc0G?=
 =?us-ascii?Q?SkQuGpZZrNGW4Rty6Yb63xH6n/0IMrQ/yRzPbpHpsMleYBMONcfUu1Zlk3Rp?=
 =?us-ascii?Q?RhUn22TJLlvSIJT4GZy/md6HGFWiQZx+LFHttoMQiYhK6wGJsz7voboDSuGw?=
 =?us-ascii?Q?QxwReCeJ5gxdyfN0bFLplmPwCy9iaLPgZk8/j16M4HEgRb4CKjlC4fIG+nB6?=
 =?us-ascii?Q?ESW8FZFWumNesW28M4NuzUK78pM1hZIvsCWl215l0tyAiHw/7Bi50Mz63Dqe?=
 =?us-ascii?Q?iGxz3zk3Q6YnO5FQOfVVstX3AOalW4Wa8nLJKqj4OGQRtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFmR0zPWx4rJiWNv5A7mZp/JF/pfz5NBNF8uTy0bJg4lUcyQosVyk47u4KhV?=
 =?us-ascii?Q?SaTbDFB88RRHH+aUo5ldFl/F3SYdmq3xrHWVScJXw3voM3T9UTEuH5zUtu3p?=
 =?us-ascii?Q?rv9hSWeOiGuZakOIrUTn0DERNKFn+hFVBsmo4hTeWRN8Soja4D+sOuBSZyyo?=
 =?us-ascii?Q?nsFnFuM+1gbUjgVrkC7+bTXKuS6z5Ht34v9hH7Jv6HzR9bLF+KLnYqTD7t6M?=
 =?us-ascii?Q?e7IV/87hqI1R7SHT4bM7XJuIyn8cvfCcEia9fNFYLCb5fo+nz7U9xl4QAvH8?=
 =?us-ascii?Q?RpKmdI2C1wrp/wkULf6GRu+WLda/SYFsjUoyRYt28OiQbgqcOxD2TFU8chzz?=
 =?us-ascii?Q?0qe4f3Ek4nJ0AXK8jXzhrWhxHFBsbhylIjwhIKMt2SUbHAQSMg12pHVcSqI4?=
 =?us-ascii?Q?01JKfhUIXocuUQb2sSFzTtKk+aXh0bi0UTDaJYuEwhl9Vt+JI840y//A/kNT?=
 =?us-ascii?Q?zTF5d/XZp24DUVmeucHC5hwu3wiqanqUqFqhgZiEtTf8kjbEGyJmlmzMt9Q4?=
 =?us-ascii?Q?pB+iCcDxAP2dCMPZ9ECT9pf1XJUNFFR2ZUDS2GwQRb2b0I7Zw+qLRTGUKHBL?=
 =?us-ascii?Q?Akw+M/maeYaLYO+LIrIpwSqPqDYXHd8pfo2OKtNV+JzFD8O9J5eVNyPbUng8?=
 =?us-ascii?Q?Hk2fhQvLoPRjB9DFVXXLEdBbVtA9VjZeuH7r2rdiaNGPut+2xuVwwtQ9lg2o?=
 =?us-ascii?Q?nUI7s94wWeDLcV23lDq+JwKcYObzfinM7thHnxF14WiHEhCiQCQMBDZRY9nY?=
 =?us-ascii?Q?+8otXtgmiCom6MFAYaHjEOQSa1/yDcIgCzBxWC9l0jFv6Wz8fX1Hatm1XLHA?=
 =?us-ascii?Q?vvEZiN56irPiiF2rVy2JlmHEASUHortOWKrr06zl9/bKT9KR3gYa63DTKuJe?=
 =?us-ascii?Q?3Ivi6niB0E9Py8Dt17Nm8ynYM3NKJ/zPICRA4pSKXfS/cpkYewZv92QngFHq?=
 =?us-ascii?Q?5AbGzbViP+hvnyTgnzXIOsK6QLG7kIkfiilIuzzfDjAI04eb+q4qJALvwHXU?=
 =?us-ascii?Q?QJuf9CKmriJE0Rgk2OqcLtQsPsQgRF99tsrGV/VpT4H6cUNkYPQVbGtX0/2K?=
 =?us-ascii?Q?+mg8w3nd7lpDuaHFawVOnJ0Dsiq96yY+nYHg7TaNEVIFkIUEketrGxMbStv4?=
 =?us-ascii?Q?2P4W0lLoXq6zEv7TqhAVl6FOrpvaYtIdwQJp7YtH5T+dHXoAz8lbF6rLCmkA?=
 =?us-ascii?Q?N0AV+cb7vE72t4DA5I0Gs3tRJF3TIms7+Y8zUWZbJkGH2F66e9wkCqnFahXf?=
 =?us-ascii?Q?CPHP9D1ymq3FK2D5C/RHd36MKqQtx0dC+yqFmN0M9mDfR9JS//CvFm7TWTkq?=
 =?us-ascii?Q?lGj8oMxhSWAW/f70nIbOgd/ukx2EPMeIQwXq1HCoUmjd7M0D0UzUUfxfR3dx?=
 =?us-ascii?Q?NUGMB15RnFSfiV7Tt0aNMmSJU8DPFfeTfURDwz22sKL8+oeNiO4xon6gB2Mt?=
 =?us-ascii?Q?7ulRCsnzK+FJl/eOovB5Ee5QoH/vYZPqg5ZqkIDu/3NrZwvbtKTHBbbxC9Mo?=
 =?us-ascii?Q?ZJjXafjBy4vnastIqOyy1FfA3lLaTnwYQgBDwkNF3o92v1KP1NuLUXzVMzdN?=
 =?us-ascii?Q?IwbENt8JnuuNWL2vVsG4i/+C1qiiSPVTdXDNgeJL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7446ac7d-3e27-4342-3740-08dca524e835
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:21:51.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdUJ9tzj1PNnsvLHf8fIDotIzxgpp51B2ARgLNehKijH8fMkLNZFGcl1prGVswYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

On Mon, Jul 15, 2024 at 03:50:28PM -0700, Dan Williams wrote:
> > > The motivation for the security policy is "there is trusted memory to
> > > protect". Absent trusted memory, the status quo for the device-driver
> > > model applies.
> > 
> > From what I can see on some platforms/configurations if the device is
> > trusted capable then it MUST only issue trusted DMA as that is the
> > only IO translation that will work.
> 
> Given that PCI defines that devices can fall out of "trusted capable"
> mode that implies there needs to be an error recovery path.

Sure, but this not the issue, if you stop being trusted you have to
immediately stop doing all DMA and the VM has to restore things back
to trusted before starting the DMAs again. Basically I'd expect you
have to FLR the device and start from scratch as an error recovery.

> For at least the platforms I am looking at (SEV, TDX, COVE) a
> "convert device to private operation" step is a possibility after
> the TVM is already running. 

That's fine, too

The issue is the DMA. When you have a trusted vIOMMU present in the VM
things get complex.

At least one platform splits the IOMMU in half and PCIE TLP bit T=0
and T=1 target totally different translation.

So from a Linux VM perspective we have a PCI device with an IOMMU,
except that IOMMU flips into IDENTITY if T=0 is used.

From a driver model and DMA API this is totally nutzo :)

Being able to flip from trusted/untrusted and keep IOMMU/DMA/etc
unaffected requires that the vIOMMU can always walk the same IO page
tables stored in trusted VM memory, regardless if the device sends a
T=0/1 TLP.

IOW the secure trusted vIOMMU must be able to support non-trusted
devices as well.

So.. How many platforms actually did that? And how many said that only
T=1 goes the secure VIOMMU and T=0 goes to the hypervisor?

This is all much simpler if you don't have a trusted vIOMMU :)

> > And I only know in detail how the iommu works for one platform, not
> > the others, so I don't know how prevalent these concerns are..
> 
> I think it is an important concern. Even if there is a dynamic "convert
> device to private" capability, there is a question about what happens to
> ongoing page conversions. Simultaneous untrusted / trusted memory access
> may end up being something devices want, but not all host platforms can
> offer.

Maybe, but that answer will probably be unsatisfying to people who are
building HW that assumes this works. :)

Jason

