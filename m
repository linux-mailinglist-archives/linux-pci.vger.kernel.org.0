Return-Path: <linux-pci+bounces-22860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BAA4E401
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3232E19C46AB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53781280CFC;
	Tue,  4 Mar 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08S5uFDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E475255241;
	Tue,  4 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101993; cv=fail; b=YX3dq2ntTBGehKSWD26rPq1pGd2kGcndsttaJMK5geLLMnyoutr/u7SQioDGyN4wxUzRwnMRIcx+IMD6WX96fTnh1g4F+gnegBl2fYC28PgRXdnx6lOcWIxPrA7AYsofNqfkpurCBg/QQ44lp3FumUBIXbnaYyaIShCGNC//JoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101993; c=relaxed/simple;
	bh=XbAH7eSG51BTYnvep0ToYyp14tqHNkAKBTCnY6rWQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kvjAbfq82Y9nX5M78RHxJDK4Lwi+o1tK557Nj3D755qkPFKkECq8z9D0qLng1H9eqz9dmeVxP01KjounAEUU5c3USOOeyOK0Hrd1twjUQBT+tL3CRJbc1NHrkymzECnVzyDc206J9PYdDXfAFZLUtA0UxEptK+YewnEyB/xutLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08S5uFDw; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j94EJfpPfCiCGoWyxg0qrfW3vJtpU7nVX2OYYLJfRiqFVtT1gtHOoDgB9cmQxZ10klRqGM52N3jfe3CVWlGnv5dgUGEGVG2ddfCQgmvef+QIEPe8WsZ7RcK8RJeHXfiD73OOADfkuCCDj1IkXp0tV9LApj7A3nTgNrDwdt6U3d17uiCoXxjBkEeFD2pVnMIbcy8hvFXKMQiySFHkbslaLPd2cwaRpUJQcPrfRcDThUgRQnN02M8pbVY9xYwGfuleRbAR/44qUGpVhlDwlNYAgEoD6k8VdyIpQD5fBq3c1JW32yNcjhOIrLPV6SiKXDC3RYRXXYzrEIHRt61FHr3UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dy2bmzxbeFNjspNrU3Pkbai7o3dsmhQLaPLKdhIhxU=;
 b=jqbI1m62kx4/ZXhatunheJttj9/xM7Icg03Ct2ppla4lnRtr0sHOzUGEjeUHv3aKGFXwGzqqJzXVRoJzM0dQhP4B+Y+sR/+FK3Ebvi+XMkJz+Lh8PD7hxDtrAd9Rht3+MwdC+sJ92jDSJCWdKdRTearPU+Bj5E/iYlSRLwJJq0b5HqSbM97bELZu66+5EUZ5m4XSxyaQ9tgxQ2H6MhO//Te8/cdr9babyNscWI5d2ytgdBWRudefXozdu/PKeZs/3IJfkLsCsH9k5+yPUdyxjAHGd9INqPKnQMx/050yCdYEU8SGY8X2CtRrfkipXnCOifExKEIBWT9H6maXpVslDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dy2bmzxbeFNjspNrU3Pkbai7o3dsmhQLaPLKdhIhxU=;
 b=08S5uFDw6ge/EvKk5uf+yzqXMctZ4+93KHLSQTTBr7X+jhQ9YO/mEBJftXjB8LwE7lRtklsdyBa/XQVSJ9vZpHew+R5+KasDyvKV7am5cNmiiHXeIP0NNmsPAhEGHChHxZsRkak8MZkDZZDgDqLGA0LwIjPlOP94djTB9oPZHXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 15:26:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 15:26:29 +0000
Date: Tue, 4 Mar 2025 10:26:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, "bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250304152614.GA1785630@yaz-khff2.amd.com>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <Z8WTON2K77Q567Kg@gmail.com>
 <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
 <20250303184208.GB1520489@yaz-khff2.amd.com>
 <CAJDH93u+9KLBVSrFnQm3==9E4VaVohavq+FZT+UqWdRs9FHn-g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93u+9KLBVSrFnQm3==9E4VaVohavq+FZT+UqWdRs9FHn-g@mail.gmail.com>
X-ClientProxiedBy: BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 7523aba6-d84b-4d73-3b32-08dd5b30ef76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7avRvBZJYCU6QEqe3CT9VcCCJ9Mqie4iPlZqzpkNdnDs4BFPBDC8DYNMp2d?=
 =?us-ascii?Q?gfijP6IXUW0jhoA2+7ojr0W4p0nW0r3+1+fV7vAIUhw0zmTCpThQKaosxWiy?=
 =?us-ascii?Q?FnMeWjmr7lSwGfKlZ3CWYVrI8Bu2oxirwLuftJLvociBEDI1XPK0Bm3/x9X7?=
 =?us-ascii?Q?26/DZFe1wvvGlq61UgrrJR1S1Ir1HFiACs9/FBdEsAPVDo1Dtr8F0nG3J0bL?=
 =?us-ascii?Q?0YkVOTkA5ONxZdP/rzWfPIctPfuNVASmmIC/kp+eOivMbTxIsI+d75cJrMq1?=
 =?us-ascii?Q?dppbzLtvR3oCbmHL1JE8lo5HtdUMhw5FfhpSwmwpn1tUvsxgjJHwRKiJxQR2?=
 =?us-ascii?Q?ZRoy0s5l0JNtJbpn4xB/SpFWTrdfXnSaM0yiQWGjSEcmVYal7kRKQrNtrNsh?=
 =?us-ascii?Q?y9d8oxSDnHZi5lDBqg9M4GQnZj0uCHCmS2Cjk02LLUs52csw1UaO+2YO9yAy?=
 =?us-ascii?Q?dPzDjQhwGqW4s2ZNzEyLz3bX9pAQtTPkBDSQRxFMENui30CFSOIo7a2MQJtX?=
 =?us-ascii?Q?+iXXTOdcA/VgFMEw1EweI8Ge+XjFmiM5HhffbZ3y8MAW3CZLy0FQlZmioJbB?=
 =?us-ascii?Q?f6MlLJI2S5FeoVb7b3ENHO8qUb0XnDPbxLyPr6dwA632LjIdO2g9KwXquwft?=
 =?us-ascii?Q?bhCOBDDbUecDk81UE9PC3xop3/D8/s77Zk1uSruDZdDm9NkMbSFUaOg4gGpC?=
 =?us-ascii?Q?DUIuhv6ryUA+cGvfC15+fDWEo7veEUVyOvFw8ECtSW7gjsRNwWY+Zvh7f1NT?=
 =?us-ascii?Q?7eLOPw6gKbs4R35h5UNo3HfZ4LB/rdogwQy1PmQ0rjqmcrnUyAgTYD0tumPm?=
 =?us-ascii?Q?rHM22yw2MpWJB3Wze4BMd8yA3E0j3aj7+V0HVIZMEJAVYJvQbcLk7SVt1BkQ?=
 =?us-ascii?Q?fs9QHxRnH1bVT8216EAC85FSw8zmNcsuW6A34VtRJIn6a0LlXtkyUWOg/RCs?=
 =?us-ascii?Q?bQyNNUaGhx8N7CIxFhi97Fk3YMY7bJRnaIe+JT55s7g089OWg8rSOT02Itfo?=
 =?us-ascii?Q?boQazcr2F5qp9mxtvTjhmlQqEric8Xh/ErGrhSRTFZjpnL6jwEgdbF4Qjg4x?=
 =?us-ascii?Q?unBRKwDFRSpaGLSkFJZaC2PBnNmyK4s6bxgV8nyPPmOeCeK6NqmfXtaCVnC/?=
 =?us-ascii?Q?uJtjhYhnGRCH8UklzJAJryvLp7L4krKa9Ht/pCCEnAZz51jgal+DMajo0fxj?=
 =?us-ascii?Q?E4PfEojDstZSPaiN6OvAbBuJvla2b226hace96Fl2txx2VN7jIKXqXRG1HrJ?=
 =?us-ascii?Q?ZJBU1v3clkFwOaCxt7h5YB3HZKTKBCD1LOuJOTWUYh8Noh3+AyX0Jygfnt85?=
 =?us-ascii?Q?t4CiqoaIlhU+iYt+NzK12KHGeeX5HZRLLkN1KNY6DZInhPhBza/WwLTx5+Tj?=
 =?us-ascii?Q?YzV3//GhlvsptuXLXfDQ3ChBHZCG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXZg5Af/SNJ97ju3W+WPB5SblERP+T5Nvig+oOj5d4nGOpYvTMpoB2FKvVuQ?=
 =?us-ascii?Q?zTJ5fnSGwCRWliu85NsB+uyeJC/3w4xzUI3jY8pOasaCYW41ztryjX1l9y9J?=
 =?us-ascii?Q?XnIcbx8C4/tQbfndzQCsWBptIXikzogEx1sYiES/RhW0NAYISE0H5Phztna1?=
 =?us-ascii?Q?HUejf42NDvZjoFNbt30lZO+qrLFrvC9YgSv6qZ0SMG4yf1uKRhp8oTWZP5TF?=
 =?us-ascii?Q?ZICIU1T+FEY399v+yKNLzcgNiBHbuOu2PxnIxNrqp55g7Ez7YUwxuv3sg5OZ?=
 =?us-ascii?Q?GI+fLo+nGmUqyWRmUyUq79MIi9rhfNNLVLg+8xbETkVa7RgRojeZ7ozEY9Mx?=
 =?us-ascii?Q?KZrSpErjgR0USI1WPtUqRN5nusDWNHR4XhBpMSxfRXz2o/R6H6EWvAW1NKl2?=
 =?us-ascii?Q?Z6Qw1zjux0fCAonqTvJERAMJ7ZKZIXbOOC4pvTXPmQLzLs0o319FMgZGFKUt?=
 =?us-ascii?Q?9qYGhAdVxJZwsAUp3CdBXokkfJIue3ecBzGjOB90W1WEiax9OVWsfOeX9HSc?=
 =?us-ascii?Q?0wJ7hrTtwkWfUOq9WEUgorL2YHsW/ooLZwPJaSD5kVMV6sgrPH9KDGHAynYX?=
 =?us-ascii?Q?01RiusIq6koxFgfgDA6r50wXbYjwYbkLnV1Cc0RsBI8WQ99DTAgBSxIsA78N?=
 =?us-ascii?Q?TT4GzbfviRu/GZc1SYbs6be+z/Ct8BLMFseuFFfBHZbCVulG6qMeT+KCyXyr?=
 =?us-ascii?Q?Bd0OEf5rpKVXtbMwi/zTBCvKQnE+Iq3VgUsmNn/QwO+SkaFFIfoMpS9/1anh?=
 =?us-ascii?Q?3YYlDOVScE5mPLIjRDtoYVURfJ0zOnrrxgfbPcrOumDxfYiW0q1ACshjJDYi?=
 =?us-ascii?Q?PL9aA5Xr4ZvSuy+flOH8WyjNAiRh9H9vbnKzzXogADPnCajDyvsTbfjovUo7?=
 =?us-ascii?Q?Cl9WsHClUxVkmRx8Nl4tdaObPYgKZrS5zdKZcU2I2yYJF0Bq29i+GoUx1qMK?=
 =?us-ascii?Q?7s97mj/gp4ef4APePZomw0R/qv/fizcz6e05DiIgoiq4QbPZJp/suLPIqFrZ?=
 =?us-ascii?Q?N+a21KmSNwxhKEzo7VU2+GLI9sX/aQbpIkBIq9aAWa9bRmhU8ldWbMSpuYxi?=
 =?us-ascii?Q?9jRPPU4k+VjMVNCshe4A/9addMlgcdq7MtJDv/Onvb6hx1CwJPs5wcHXxZx2?=
 =?us-ascii?Q?OMunf5BzvI2532WpP5yv994QpoFs7A4K5XVsqagkJi6Bo+JzkmeJsLLfdl+I?=
 =?us-ascii?Q?6R0qLuDVFXMfBLb79tMV9ZojsHxUqmLSq/YzekUTDKSS8TC7TzkXu2morRGB?=
 =?us-ascii?Q?zWhk8RW6VI3Yq0K+2nRlzPWpyVJ8IJBrSmSKxQgGqH3D7Px2VHvzI+aPbxY8?=
 =?us-ascii?Q?OuCMjItDVlQtWBXE5ZMx3Z1B6nJ8UI2jbZ+vwiICvPAEuuWQ7buRv7y+XjZJ?=
 =?us-ascii?Q?gXNHHN0tmiQS+dNak1tPQVJ1NRx88gxaHaWCnGyZURcwCU1JoqmM3sBNjMol?=
 =?us-ascii?Q?CygemJSaNpOA3/45BRF8mCvipWRgXGmpzupMZXXc/rpJMz4WEODjgdlFCH4F?=
 =?us-ascii?Q?tmmcowvZv34IzIwT3OaZQ3dBYZsa0DGLZXiKL9vgxq5NnQbFjeAQzm6131qh?=
 =?us-ascii?Q?HW4b/i+vNY2X1wDe3S/w+VxjAYhdX6mLufZh0yfk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523aba6-d84b-4d73-3b32-08dd5b30ef76
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:26:29.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLkmDTXAbjsKC17Djzg/CPRKgxiZFh4Xly1nIUzWVQ9hzmCiW03/FM1dSLRfdBwzf6xiB7VVBF21bsaH9GT3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509

On Tue, Mar 04, 2025 at 08:39:29AM +0100, Rostyslav Khudolii wrote:
> Hi Yazen,
> 
> >
> > Ros,
> > Is/was there a reason why you didn't have the MCFG/MMCONFIG options
> > enabled in your kernel?
> >
> > Was this a side effect of trying to build a minimal kernel or similar?
> >
> > Thanks,
> > Yazen
> >
> > P.S. Sorry for the late reply. My mailbox is missing Ros's reply to me.
> 
> I inherited a kernel config used here from a previous custom,
> V1000-based solution. Most likely originally
> it came from the x86_64_defconfig. Maybe MMCONFIG wasn't enabled by
> default at that time.
> We never had problems with this because our BIOS keeps the IO ECS
> enabled (that's against the spec recommendation).
> The kernel default for PCI_MMCONFIG is 'y' now, so it's unlikely that
> people will run into this issue unless
> they explicitly disable it.
> 

Thanks Rostyslav for confirming.

This seems to be the commit:
55027a7772b1 ("x86: Align x86_64 PCI_MMCONFIG with 32-bit variant")

Before this, PCI_MMCONFIG was default 'y' on 32-bit and no default on
64-bit.

It has been default 'y' on 32-bit since the beginning of history.
1da177e4c3f4 ("Linux-2.6.12-rc2")

Thanks,
Yazen

