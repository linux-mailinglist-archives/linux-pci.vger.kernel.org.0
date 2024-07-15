Return-Path: <linux-pci+bounces-10338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0719931DD1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AB8282A6A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5F14386C;
	Mon, 15 Jul 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Co5nTAVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231A1E890;
	Mon, 15 Jul 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087718; cv=fail; b=kQBDDNfVl/D6uUvPTRNT6uB6PkiOK4K7Pa3i1uj0DhyajjJ5G4TRs8EsNcGVT7Wh4aPxw0sdxgtsperPetKKznu/to8XFl+RHEJdmS/FiHhNoQINifcI9aNC+gK08R3sG9h4DJYCXexJ0fMHoGODQc6SiPKLFp0vNQOyqKKO1tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087718; c=relaxed/simple;
	bh=CcGBtjeGbK310Shkbup3zDeQT6UPJ+wp8ZBkLum3dIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHCe/Oa/CvWNfJ0OooBXy0t4cADwJFsXFN+X1qUuS0aQ55zryG5nl2QD+hmI2K9ZQK4BTNMwWAxnCPXdOW2qnb7jFBWmo6aRrAwrdZQzPL5EN4W0P0BNsULEK7cuBfLS0CpcV/RYT9T8THl1krfFQ+I2wVVo2ZAUzBPzd/HWYOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Co5nTAVD; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7CnWBTxDyMuW8vWkQcRF9oxoihkLK14wORiUZsEPzFmQIvMAjWVxPfZ6ndfLuBPvAXGYMQTIpzj2fQWie3bM+EHijBbjBYYtPzWlVtQlcIybuDCLfPgQj/7EDCVrRMPsapWUrvs3Daiy0/zGar5vXOsiu9yTb1yWRvBiJhrLsrnTXH+F2nqtYB6BYzGSp93GrPcP3oWcDHwwwZ//+Evw1s/MlyzTWkf+xDoV64fbAdmtasf/5wxcjzZkJpVpCsN5oQIDhKzSAjKSgwO0dNjObfZ7xDzL0wo/vphChf0uXHn8cWn2BNZMheLuep7v78Qv/1DhuuNOyD6hFxE349u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw9BBFva6SDUa69KKikH8ye5CwmDQXPU/P2CSu4JlCs=;
 b=zSey6U1IKbS98S/GC/N8NV6i3vVLNiUb9miTUKlkBfpULJR2+Camh5jyjfv2Ixso1e89ZUvBKeoWe4824mI+Gkb/WVSpdWk/AafERjToCb4gYnq8XbGC+spytr6c4YjWik76YJPG20gvKsHoNkfbFLb+Am7zYkv9lwG6euJAzt1kgnnstcjChXqX5Cd4RI1+NX8JZRnr799vHMgnzPSGJV5mFmQsghFNVnmSk8hgki5/D8+mIc6KNPVebFbYFviFO2oCzvz4DpyE/jAr9m2V8SlbSGa5z6M0gJXBs20BoGsUbZ5vjieOgMQmFchgN1/f/d1iG63iHnyJ/LymbYpvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw9BBFva6SDUa69KKikH8ye5CwmDQXPU/P2CSu4JlCs=;
 b=Co5nTAVDTyT3yUe+E7aC/ziVp5T6sT8mIzjkqOjvSXl6s1wjwjLL+ZShxLajTE2rfcn8GMM3Vn0ikqFEmDWf6Ng37Wog1tP8wsJbcZ8G0Gv6QTG6rSmgJ0pH2Y0CwLR1XaQVkcavjgy2ZToSEiV0lkTyW5udPvq56dsKauLQ855FdyhxBequb6HWge9Lv13Pg9/Td/hl7ocMte/JLWhgrqXQX9ZuXgwdC/FFBeawqrd9QoBCzM7eemLRA8sJbuGKN+xzStlgtcdJI3HWdI9BikZVHw0rQO4LQZvBKzfh1rsLtCwPL4Y9qMeeoC6bU9h+EvPX4P9MPGyKVBU5jLVJfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 23:55:12 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:55:11 +0000
Date: Mon, 15 Jul 2024 20:55:10 -0300
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
Message-ID: <20240715235510.GA1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715232149.GY1482543@nvidia.com>
 <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6695b29d204e4_8f74d294f8@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 6971ed58-3cef-42f7-b76a-08dca529906b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmRZZg5W5Z88+20NLGqSedeRsaGibCSTboTANzExvULxpA5c6j7URl3HcZ5O?=
 =?us-ascii?Q?vIp7VM6fPpYnIWEe9IOchsEDmtNYLFw5rYMzyA2mnbiLZWbtw8I9IPMZF3Nu?=
 =?us-ascii?Q?Py6rlSw5miYZvSJ+0JJwz+Z93+QuMZWMArG516xGVIMg+8SaZzjW34qg4K8A?=
 =?us-ascii?Q?qsSQBe6uYIRkGYl7yOwIrf5g9F9p+Y8pC0LUcMZuczLYl0A6SqkatOkHdaPJ?=
 =?us-ascii?Q?ttx7FKZrraobnRnsir9TZkzXfgYYeNO1HQw1zd2D2WkhJkW2RXE6eGa+ioHM?=
 =?us-ascii?Q?mxxxHIOsMFIhbXbLNYtU9c65iaP+lx0kdOWokQuXTC8fgX1AIQm5trolHm+q?=
 =?us-ascii?Q?Pl/Yr+E/dlvupowUiWw1B2l/HOiytuDbrLmYpdyoL6D2tcisGawB+0xbNYKT?=
 =?us-ascii?Q?MfFaZDDZjKHCXteoZUZYlbnw27V6wthhofHzQ1N9MdfIvwkaFppOBWzzVAY8?=
 =?us-ascii?Q?9v9pvdrr1x1bGzakXZ2YDJzlh0WADavt+KsD/Q/34FqZIqLDOpx1rchNIOnR?=
 =?us-ascii?Q?Toty9wdYK3tEAS7WCcH0QcQVR5Lz1GaIeWwrtP1CXBtxgMSTV79nF5O1MKs6?=
 =?us-ascii?Q?UUy8TPoT07Yn519BHwxI+KEsEsApvNEi1CQ4rU4DClpphIXP+TQF2CPa757B?=
 =?us-ascii?Q?0KVWiUJ6JvGPmKBHXQBdMh1T3/55C09P3HGVbgE6icHNDRyUpnaIhty96LdW?=
 =?us-ascii?Q?VDEEts3QXp7bHA/kNqibqG/cA3aXW8F6n4goojjLNctdvCpMjEdhHRn3a1NR?=
 =?us-ascii?Q?alsQkqAdlEc1YQ5s+t95WScuSR9fuAiibzyKoY7Vtb9qGWIVGcIPIniY/xnI?=
 =?us-ascii?Q?tU5mYG9lwNn/38K8KEcqgJEWgKm2B2B5tC/1RUD7jSHZN43mSrup3NOEf5iL?=
 =?us-ascii?Q?mVs1aQeDeaf5nNsrqU3MjONMno7rAfved0e+tZnM5Fcottjkd6WH8fleWxGL?=
 =?us-ascii?Q?be306T5KnRK0yRtJ+Ytvx2KRO1S2DnnAXz102EYrS8T97AJwZckMrEjifid9?=
 =?us-ascii?Q?ZXusogdiEL0KwWCDuT8LsJFX759x4py4e6T5jkeD24xn89K5GGgvudZ+eoV0?=
 =?us-ascii?Q?QDAzodRkEUnjezTEktRErRBG1j2QP+ZpOPuOnkgneYrykmebGd3XisPcVpGk?=
 =?us-ascii?Q?13m0/osQKA88bv4AOpsw6yq2SG1Rs8LRxXPoSMJ+vjoCTPH1svvQaLoEYx4l?=
 =?us-ascii?Q?OW7ubBFoAUxR8e4XZSVbUzlUTdMn4YbgKsvZFbNEJhaSlfyPirZmYKaFdQKn?=
 =?us-ascii?Q?vbd4P9htxZ8jFaulAJ8W4if2joIWb0Wp2Gg+lX063WfvhyGaDV5YD64PfSWf?=
 =?us-ascii?Q?DA03UYhBE1IwH4k/Mh6vAJCVJzhTwBAvD25O+8m8qwJw0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rh9I3UC3mPq4trv9QUzvDI8sIoul7agxWByT2VTEpmWGejo6Ns1DHNPZ7z8H?=
 =?us-ascii?Q?t5Zrf+3pQqAyGjMHDDtJdX5XMmiQvzyj5Bpvy4nlQIMgORG3yfEd9hHaGTl8?=
 =?us-ascii?Q?b2t1ace5kEMwvJifqpt3e/ynHPxWAuC3NTjTfbzjR2+b0fFs7dpmmvNUgpIN?=
 =?us-ascii?Q?Tci9ZL8JkvfWH0hxXUvv1RFooSRazKWk1WAdhqcasrwDzcjr5TmKx7ufJi02?=
 =?us-ascii?Q?5dm0u92VVfH0F0VhfQdlbj9tzFvGcQL65Fs8Nm4Hxi0NNfZMrK3mGt0ksgO0?=
 =?us-ascii?Q?JhD2PngDfTkgirrBfTXjx7qpreUjJMDGBWVslRbf1GYDEVs4Vk8O6Dp2/3dM?=
 =?us-ascii?Q?3jIEobDbiU64bKfmLPRE9SfGOMU/a65PfovaPaa+XY1TxtSE16LHfVbcAeET?=
 =?us-ascii?Q?dRSXdU2psiyCSqPgz1R6847UW5NDPnIKmGEAHo9Acxdyw1xge0SJC3izXwf3?=
 =?us-ascii?Q?rOSzpsS/o89IRjdUwNuTjDUW5cFh47CjJcbmxe5NfzfkYUswPAid+83ZB3Q/?=
 =?us-ascii?Q?N/brlJBDFrpQR1R/TwggrtPjy/ZoqEii1TaZadhX7n11Ayz6BBf4uf4yveFb?=
 =?us-ascii?Q?CELKJp0Uki2SVIdBUUM/OtR6rbPCeX1oZVW9LX/xlL64s3Ws1WoZsqKXL+gq?=
 =?us-ascii?Q?tby/Z+LUJs4uuLeYTi4qTP47v+w9oQ0Bh04RV77OqDjygsP6AHYBDRzu530m?=
 =?us-ascii?Q?3S34LUUN6VtqaocQld5A4HpYErmLK322vZmAGcd2+nAwosznw9OcA7Gku3u/?=
 =?us-ascii?Q?6lqBrJ4ksv9CrJALsX9Msfq64mLPDv2A2NBAsJu1gu4aQtLKZPjLf2BnHD0j?=
 =?us-ascii?Q?RiYcMw+1wCO5a6s24Z1jhpnie3w7q2p9RVT7fazxObUGzQfUzwLNgRLXPHeS?=
 =?us-ascii?Q?bKmoDZCUyl2cU4942lgkIFz2XiNHMw09UlR0EXxjg4EBVXcJArbz9mw9lRoe?=
 =?us-ascii?Q?A4HVNKDjKda9aSyf/1hoFiOUUszQDbZlEqRzReEC08EC2i0qsuv0c9uX3UGN?=
 =?us-ascii?Q?RgX7vrPZTo4f+0S7qEUQs4R+lu4tY4pqL02m7Af3bqFm9IFsYFWzIfudS4H8?=
 =?us-ascii?Q?qH/MSDjQle3YSum5Z7QKElD7ojIxzzrAD/n7/aqHsnoveJ45zIa9RSboalTR?=
 =?us-ascii?Q?razbCTfM7kaF3k2FxmlSlXen/hJEASCbJnvyBmGhJqTWuKj8QRUX46i44nOr?=
 =?us-ascii?Q?B/zeqAuSdjlXd1cWNjoEwoODWDq8QeJgtZ17ymDVgto9sRmZQVN8nWNli7mq?=
 =?us-ascii?Q?81wmrinD1umD29ZNOqVOYm9wlbSLPYES3evNWZIRdY7tYyo9APWKccH6kWWf?=
 =?us-ascii?Q?jOtlIFC4ZO2ettA/BpmGIKJN/NQt+ikZGeKmMnv5OwSNChn4jrnhDonoMNRM?=
 =?us-ascii?Q?sKImVeMlU14Biw+8nEx4R+RkQweQ+uQvp9ZWnGfD7+s/NbuX3o31ATio7Ot/?=
 =?us-ascii?Q?CvMhziGvuNgb+d/hKSfW30p5U77hWgYY1PR4u0BxjDXvHC+ezQr/El4fKBMj?=
 =?us-ascii?Q?9zJEDKXn2Euql311YLLrarURVrXsF0P976xdRUWYj9nkU8SdzlQxlMJYrfiV?=
 =?us-ascii?Q?ypwrjWPzJ5QF348cizteaLAxjeinn4oMItvQZciJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6971ed58-3cef-42f7-b76a-08dca529906b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:55:11.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjWIS+wiVXHryCB/R18BtJqavHoFAOxMRrsAXx7cbNatpdKyEKOGSvOqfawAmVzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056

On Mon, Jul 15, 2024 at 04:37:01PM -0700, Dan Williams wrote:
> > So from a Linux VM perspective we have a PCI device with an IOMMU,
> > except that IOMMU flips into IDENTITY if T=0 is used.
> > 
> > From a driver model and DMA API this is totally nutzo :)
> > 
> > Being able to flip from trusted/untrusted and keep IOMMU/DMA/etc
> > unaffected requires that the vIOMMU can always walk the same IO page
> > tables stored in trusted VM memory, regardless if the device sends a
> > T=0/1 TLP.
> 
> "Keep IOMMU/DMA/etc unaffected" is the hard part.

Yes, but that is not just "unaffected" but it is implying that there
is state in the VM's iommu layer too. If T=0 goes to a different
translation then the DMA API must change behavior while a driver is
bound, which is not something we do today.

> Implementations that want something more complicated than that, like
> interleave T=0 and T=1 traffic, need to demonstrate how that is possible
> given the iommufd maintainer declares it, *checks notes*, "totally
> nutzo".

Oh we can make the iommufd side work out, it is the VM's kernel that
is going to be trouble :)

Even in the simpler case of no-interleave but the same driver will
start with T=0 and change to T=1 is pretty complex:

 dma_addr1 = dma_map()   <== Must return a bypass address because T=0
 goto_t_1()              <== Now dma_addr1 stops being usable
 dma_addr2 = dma_map()   <== Must return a translated address through the vIOMMU
 dma_unmap(dma_addr1)    <== Well now you've done it. Your kernel explodes.

Maybe the "violance" is we have to unbind the PCI driver and rebind it
to get the goto_t_1() effect..

Changing the underlying behavior of the DMA API "in flight" while a
driver is bound seems really dangerous.

My point is if we start baking in the assumption that drivers can do
things like the above without addressing how the VIOMMU integration
works we are going to have a *huge mess* to try and introduce VIOMMU
down the road.

I'd be happy if V1 forbade the above entirely.

Jason

