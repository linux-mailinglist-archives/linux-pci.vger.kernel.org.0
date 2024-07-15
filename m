Return-Path: <linux-pci+bounces-10332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE8931D78
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91EC1F21601
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785A13D53E;
	Mon, 15 Jul 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Od/jZR1h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F620DF4;
	Mon, 15 Jul 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084626; cv=fail; b=cfAF0/95MlxTw1pOx4hGg+CsZRy5Ux8EZSLcqJeXYmvdLaO5ABWfAbP+x3VCYeXWly07j/P+qt+TQ7X4co6o3CfUxdEofL7BLvTwHMslTbHc+IDF2jrPmtVc8olT3mZYmgOcz/CyxsQmMQHO+znUo+XKF4RLcQuQHBxR2iuszsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084626; c=relaxed/simple;
	bh=jM4hX/yLheMV3Do4KFK5WVC3wAuzcNGavK/6jIXOaAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mbe5xnz+dCpk2ihFy7HGyzV/KIwzzGmKzpHFweThriscc5y0vlpNjAkiIqTBVTQVVAw8CuMN3ul4azkWRQfQI4e6nvO/l6tpd5QrmdP0XssB7q3pBZmeiom4BRqTTmw4uS7FaaF5QEnlkJXQg8OBaW4lXyUzfyiV7DMLCywbkpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Od/jZR1h; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnaTuAh1CEVLL8c82QUAZqf9TeCzHJj25oVe4zZHCCRR0mOEnV0AIn0YsB3sJTQEZtt4R71vew1pIt48pmrJT7jF877vl2LPM7X65Wa482GPUYkCEBkLgPLgFJgN60juGU+GFLqAe51VKwfrz7jY9SoPPNIH8zCwmtRPaU7VZCF8BCgBh63i8WYjV4QGFO/6UepGXfY34q+OH4l9g1ex/vGX37XNu8u4ldxYURAN/6HShvKcgRmdHbTB6xP1xA8NAEjZznSsJLISLMUrrmZTfMMMvzctlwbiOcTJ50cMGuslG5stFUteFObx69Nufln4Fap/dIZjLsAJfYqFIjD3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM4hX/yLheMV3Do4KFK5WVC3wAuzcNGavK/6jIXOaAY=;
 b=StFVURoOSgBD9FlGVyvC11Wt+/2zIwt1J2EouoMXgCVyuhdS2eOf7ZGTMoz62NjbpX9v4c9jiGDd9WxLiRorTeqJO8t9srcPcJjs7kC+SLlcO9oo+mX4mugv5PVp5lvb1XJC+fKRpZBhTipP1MoAx8TW/qAZHGYSmq3S2eJtdlSnik9VjPIM2E3B51Ol+o3IwgOtCluBk+LM3FEHlXI0pWmd5JQ71hLKPe4rc2Ki1ztP0iMMWrvRSpcEWKXA8r0jLrrS5UPWxDYrLM9r0xEZt/tIhkIpqqKkpmP49XjpTJB1uiIa1WDM4GpwOL+MmzDfrVkt10fDM5Mgtyj7yqAiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM4hX/yLheMV3Do4KFK5WVC3wAuzcNGavK/6jIXOaAY=;
 b=Od/jZR1hXjm/MBP+v8d1hVu4+/6U2ZkZl/eYA+aQN+/JfaiveEeYc8X0Sn59SkWKxGerZDj9m46+TKN/7AH/1ukqwGcenB8633Mc843BXVcaYyxk9OujjRTXQtmloO1OEZuGaANsqGNnYMWkzYk1eB55Sm2TJBPN1PauVH3DmYzHX+LeytdMIyqTxmPszhDKV8NktlcbekCXXTvByWFHmUGTRcZ3WzM3C+T8nlOpqLtaHRWunGhb/1aWB6bd3phb5ok542y9qP4Q2KDLlluhNJfjiZlwH+xmWkwS5M3Yqt8mVB+t3GsoCN+9Ocy8lDieYgeEV8cxpl0Io8jv1ywCpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 23:03:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:03:35 +0000
Date: Mon, 15 Jul 2024 20:03:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>
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
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240715230333.GX1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
X-ClientProxiedBy: MN0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:530::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: dce07613-dc28-4232-8f18-08dca5225ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrovsy6dXWE7MR6pwLm/6jOzBNMA2UUUiVCT1YLdBkeeRDAZ2ZBA7amFT0JB?=
 =?us-ascii?Q?LHcFds2gTYjALDVI/NeYzGTED5f9Ex5n+Lp5cv+iBLapmwtg7MhwbqB/F9RO?=
 =?us-ascii?Q?rO0jnEuRDfXg6upJuV2cM9LirkP4DxvyU/VLjsM4Nu0XnyT6Mh8JXGpQNaGc?=
 =?us-ascii?Q?DHbBxPfSQ37G/k1teNow5XBzE60K8A9OLY5TFG14NQ/mVMjs3bF06Oth2KF3?=
 =?us-ascii?Q?LauFuSfG0OafFoPJ9urFSEsRMHgxeF9Rshf14V2j1HbB9ePui1HFkoMPFCcO?=
 =?us-ascii?Q?ei0i/RtoQrbKna2BSQ8OJFAq1En0DbwYmlkdjXL33770rY0mO+b+LsZjlryc?=
 =?us-ascii?Q?BYfJoYnjC1b3W6cTuUX9b2wnnUfxcoyL03pndxkgX0yYDapv7kURBMNnKIjO?=
 =?us-ascii?Q?bkAz2w7WV1NZ4lTdRvhAhK4AmnmsQGlG1zDhr5V8KUMdvrieb/1sF8tfH6ho?=
 =?us-ascii?Q?tVW/XKYyjSTwiJQXmFFXmJq/I7r0c57xHdDULkm1ksipAcbWyXmg6Q+QvikK?=
 =?us-ascii?Q?0IrUpbzdz/Hm6oODRFT2pp3rCyQDJegO7ssZnRkuiAP8W6Djcb6Wp6ah9Ohm?=
 =?us-ascii?Q?ukx9D9/29W/jgVIwJWGNe3XeqM9+KQCGrDz/9GFw2XlKFvLV2Li2CNRWawYM?=
 =?us-ascii?Q?ziNuprCQzKH5sAmMPGxqAmf9nTxgbG9QNazp3QMCgXKHzUKD35YBmFFnb9Eh?=
 =?us-ascii?Q?1mYx9rQJuUm7LIirxFS/SUF5cl17rx3o8ctiH2lf8wUNU6ADeoOVFSgsY0Hm?=
 =?us-ascii?Q?FaEDg36GWNCr4eAKTjgedFQipt17a50nsR3WPOjsGLrClH6k331xsd723XHn?=
 =?us-ascii?Q?vx8fERSf2R+bLCvmIckqig13ZiXwVPgxRzP93tJDO1rqyheD+XubuywMto6T?=
 =?us-ascii?Q?CoOubb43a5OIganG5bXFIckUnzTf37raX/py7nHXpUk1QP/990sqthQr5ZZE?=
 =?us-ascii?Q?CAoOaYF+QWna+6LBG9SkcUy+w3Pf/4X9MPSxr2tOZP67mSze5RUmzcG55G3Z?=
 =?us-ascii?Q?musWIBOjZSksDidVIS4sbqkRuA2GZDdW8gsqVWGK6vvq0R1zRqICXB3Xqekw?=
 =?us-ascii?Q?5rSP69v4y2l7745o1SKVzdnDt3A624ir9FwY/4FB2RMDHKlbDB81d8GH37JX?=
 =?us-ascii?Q?NvjKvxZD2b9QZIEDz2/dSi44Wd3BOolIRoG7U93AqFFQfjgiDg+TjiattnUm?=
 =?us-ascii?Q?jiVhyzhpZSC3W8ur7stRkq9KIbph1KAOjsESnj3+LxUz4gbdj4lUVuvWAFZ3?=
 =?us-ascii?Q?feRpdfJc3KaDTmzAJLmoq90skFSgzeqgYX+2upSv094HDUr1o+3revOOK78o?=
 =?us-ascii?Q?aHgTQKTP3bIYnk+VeHITgtk+38++Lr5BjiW7ynr2oPJU2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42Lsz35cUE4EdI/zmfYhyhNxJzcisxAtO1sAXYuBODz4jmv5nEguORWJ3z3r?=
 =?us-ascii?Q?1J2SMUsj9WohQRsoAliTTzAyiirYg61XicVLIZiAM6fpNExevieMOMoW0rjK?=
 =?us-ascii?Q?8UccQl4esf1flV+ByaHn7SSn+vZiyyOraYKOFFkxC7bZBZ/g/nBXBoEPmP5G?=
 =?us-ascii?Q?LHn0r87HzFKUaPsoK27HQfSnCVwdrN7xjIgSacKTHLfwOYuFifLlGOn5etz1?=
 =?us-ascii?Q?JU2j+CuNiMbkJKu6mQD+EL6YDmzSVLrPrSCtKHNnB5NkR2gQE/zK4r6Jwqn6?=
 =?us-ascii?Q?QugSDlkb5S60qM57D6Qfhtwao8WaElcrr4uUACJJW312FTW7nImlFj0jW6xf?=
 =?us-ascii?Q?dji17Yb8eNyfA57/hPmZ0LfmEHpTeOsEmLyyZxudS1DOQ209urzh3Sb3gGVx?=
 =?us-ascii?Q?Yh9WG+9rb7DCeBqRFzZHIZ4Imziq8u1xdeuIyOBdAX+Kn+u92ICCg0FfEQ3X?=
 =?us-ascii?Q?75BiZSML8H9nlxWuOIMm4kfniWYx8atJOYEx97S5iAeWIiQ42pmtPQLv5S/e?=
 =?us-ascii?Q?PB7ncVRu82JBYwh/QtQCetg0q9rRx+iKTfG/rTR7xU8IlTUJw90lyThaFZrc?=
 =?us-ascii?Q?SyiMVDaZlXCzloIcU0tZGrEzi1kX4mKL2RuChRvm1DUiU8JT0nmQgFuUA+Ov?=
 =?us-ascii?Q?7qLEgh1Z1c+L4fShuCq/Dm44aVtn7pQEIWepDiSh6xZwg6ptaEqSR9WbD8cf?=
 =?us-ascii?Q?vB/5FIjLD7IIKQXUBGMHl5lVN+kK3l5rL1CLiXOAQNhRPEyWr6CIhwxop72o?=
 =?us-ascii?Q?LfesHDeKG+LIUjTjjr/mNfz73Xs7cjtc7a5JgyLLWUX+vaseM1ayGtir9FLi?=
 =?us-ascii?Q?L+m6EpQM8yyd7pI3ReFC5tgpCcOB/1ABz2iyk+RbueR/5AXasiBMmvvufITq?=
 =?us-ascii?Q?XIH7XM8xk9c49RlmkPseykFXdZIctZVdq6+Wdzgo/3LyQBVMh6E1Pvmxa7yD?=
 =?us-ascii?Q?Ac9aaCvax/4ocU99EXUeWra3GIA4sZ/yki5LjLpS4bwIeBg83BkDR2z1k3Vf?=
 =?us-ascii?Q?UYdg5+yf+QSajDf03nz7XaRMnxUb5rTihsUl/vVbnOFVcsirTqkQaF9s1f8f?=
 =?us-ascii?Q?6lgf/k7i4F70ToV6b+FhyFVi58r83DE49NoXzu0K29DNlGbj/Ll3l+6dbZET?=
 =?us-ascii?Q?T3Z2TDEwy5sSn2Srx7CvwZ7UfZMO1jjA0ZVFYJLz0Xy2/w+yKnE0sh5iQrW2?=
 =?us-ascii?Q?ID/47CyMe0iJGbDV7MlmrSUdQ0aG/0ViFDWbM2JjMEt3IHRijLoNFrrDt25t?=
 =?us-ascii?Q?pEKpWaq3wYTYX6kH17ZCuN7oYvcBiKv+5l0hmK+IPuYzzeugqiUJ5EuFYi+2?=
 =?us-ascii?Q?4kdgtIbFIVEepufXjLLoGFAoVX+65J+r/AMRUj136i+jLGl3x+kpOdEhgDyd?=
 =?us-ascii?Q?8ZbKi6YeNZQRswMZXkWj2Bh2VZivUL29wlnxAYI1K9Tzq5RFlpdRtiY9EEAA?=
 =?us-ascii?Q?vizCCpiHKz79gBx3AYMDd0LyxpxPKajjmrRkW5MtYQBxKhnJiJlTBCZIomyo?=
 =?us-ascii?Q?KffQmz7Cf9eLmjBAcFn5yIfegjfkD+uK3aNKozWCtSPY5jzcZ/wv8KfMigN4?=
 =?us-ascii?Q?mt5E3oYc97626T3ERX3mvtRH2VSQVeXaB6o4phVc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce07613-dc28-4232-8f18-08dca5225ab3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:03:35.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjC6kCldL834qbL0IJVIwFCriSZiGCKqGUlUjalhBzydjgXLbUvAjJ7Msrdd9H8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Tue, Jul 16, 2024 at 07:17:55AM +0900, Damien Le Moal wrote:

> Of note though is that in the case of SCSI/ATA storage, the device
> (the HDD or SSD) is not the one doing DMA directly to the host/guest
> memory. That is the adapter (the HBA). So we could ask ourselves if
> it makes sense to authenticate storage devices without the HBA being
> authenticated first.

For sure, you have to have all parts of the equation
authenticated before you can turn on access to trusted memory.

Is there some way these non DOE messages channel bind the attestation
they return to the PCI TDISP encryption keys?

What is the sequence you are after?

> And for PCI nvme devices that can support SPDM either through either
> PCI DOE or SPDM-over-storage (SECURITY SEND/RECV commands), then I
> guess we need some special handling/config to allow (or not)
> SPDM-over-storage authentication as that will require the device
> driver to be loaded and to execute some commands before
> authentication can happen.

I'm not sure those commands make sense in a PCI context? They make
more sense to me in a NVMe over Network scenario where you could have
the attestation bind a TLS secret..

Still, my remarks from before stand, it looks like it is going to be
complex to flip a device from non-trusted to trusted.

Jason

