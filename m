Return-Path: <linux-pci+bounces-29181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875AEAD1640
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3959D1693DE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1BDDA9;
	Mon,  9 Jun 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qo5ZBf8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AEC1362
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749428464; cv=fail; b=YMPQxhz87VF3b1Arx53UsvMMznQn3CHmlYOmKQOryEnXm1ytv/1tWTK00h2HCOxyZtrj5BArgjezUOOFZL1otcIqIOAo4lnFO/r8GHe/PM6yiPVElFQO7KOS0DgXDWG2I5z8OvJlRf2Wk7fhLHcK4mDAMw7nvNhGonheTrvyKO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749428464; c=relaxed/simple;
	bh=1aqZGnBcoHJyhfQJgwYqH475CPPsqTjwuYvJ2k4Nm8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o6Nqxc/tv0SD3Wz0AxXepbA+lgTv6ZSCrgYtgWXhk/qyQ4TuxL2cl1KBJj7l11Gn7TKShpxAVQBIHns8qzG2qu7qspVoN1H2mim0qpVlFMiSUeuPlArzvn43KSPy9azCpogQ4upce1XULwg71TvRazt2+t7aiaYX2SeGn8wlfa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qo5ZBf8z; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIEEfFAbv34GR3b3Evcu2+F2dwyX3RC+WJn3klFbpWgfAq7mS5b0oQGyXwAAZhMDYHVSFImcoOzG1Zc0KBcSb9sWjcSEMvFA6bk+EMFfjhNqiwlhS7ywwqdP89ZEiKvoSFV8WkocmXAXkI0AUuC8jjuEEOjyoPr8qxckRL5GsJArnqNaGy4xAONNwpy+I2tCtUNanXUkY+SCBKkMvP1/UC2pt6p4GjX04RhlKnovuJUolXWeiiyYncyhBZMyFj9TK6ucyihtjFZkcJiooUXbCReYT1J/xfD7V27NSLUGVI/MvOIS2ccHwJc4enQhnBQU00jTTI+7lntyNEgw0o4g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBek039KHfCgTGpsMAFR4ohgtC4/haLeiCTlcn/XmiQ=;
 b=dBW18wMOkCj+X0Y1hdnFSbmtnL7EZ4Ru6w9Cgm8WHUGeDVkMkdT117PXBT3wz2/zoeODan/VOhGAlDhUbn0nGeYWJIz414NNaUi7edrS01JklTkOKQr3b86P/cow5NaWh0JR5o6IbHfrv7bi+hR8opnXvR1nS/JorxC1NZLrerqbwFwoXpFMtJrQMeq/kurRigPdfbJu0cVfBgheBsLENNClMOkQGNUbGqFaURR+6EoRPfxec+4K9vX9R/CbpY8c92p870Eb/EkEje4/N/mw2iRKB+TQ1B1448/UKhs2tEAiNuDxCBIFZ37MYKbPu79IFMIR7Ocs9s18jIc68OzvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBek039KHfCgTGpsMAFR4ohgtC4/haLeiCTlcn/XmiQ=;
 b=qo5ZBf8z0jDFArZo13ht2IpCeR4NRBe4AQsRnVZ4vEFoYYtoyfKUHaJ5ywB3L/JVAlZHWtpyoo98SnmD//EseyMoOssBiftnKeJb+v9EquYLo3h4wDS8VZ89OGbbO32IfxNjIaGEli2wynNEBeIRQ/JrIh8KG9JI0oV5LOmDpolwp9cp3/YEaPUdrA+wafVJO/l2/+QDDUzZKpqtnbOPf9O1qYug7L6WvaqeuyJDAxEuoTkBdHe3PLjB4LfaMlnp8Vh+/aiQsulYUuabf4EEdHHC5+JFntxUOniLJHuuGZ43AVTtiTgU+wzJt3XdgBJrOZhA7Jdu/Nz3R0hnPLfdYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 00:20:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 00:20:59 +0000
Date: Sun, 8 Jun 2025 21:20:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Mastro <amastro@fb.com>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	peterx@redhat.com, kbusch@kernel.org, linux-mm@kvack.org,
	leon@kernel.org, vivek.kasireddy@intel.com, wguay@meta.com,
	yilun.xu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA
 which target MMIO
Message-ID: <20250609002057.GK19710@nvidia.com>
References: <20250530131050.GA233377@nvidia.com>
 <20250606184946.4175252-1-amastro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606184946.4175252-1-amastro@fb.com>
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: e72d6d11-7304-47e6-4496-08dda6eb822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkFW89rs+44JahN7EWwBeIr15lD1GNz5WJmzjeochIxHJ9dbkUL0c7DX27ak?=
 =?us-ascii?Q?rSnXweKxKP6YYvtl742pYfFq96+DAniYlnTwJJ/LrYnJlvvlC44sR/WSM48G?=
 =?us-ascii?Q?ltB4HjbuJTPgofK6z+oAYdRPmXQlsTUIrkIis2bOBbihT9uOs09se+3sO2q2?=
 =?us-ascii?Q?WTjQ3Gr61Ucg9MSCyb3RQtLwa3JwYk8VVPWF/pTitSc/SqtPCePBIzBVpdPC?=
 =?us-ascii?Q?4Y+fiw8f9WEdS/Ct+7nfCMrsIy20AQMcLOYlALwZ9DX8wwAkyPJy9PF8JYue?=
 =?us-ascii?Q?w1FV8Twk088ingxueQJ79P5aEzAG4T1M9zrXst1UepA8daLvs9h5Dbyl0XVE?=
 =?us-ascii?Q?epAGMdlCTmDQVBvNCBxANzKB349/D9EupgfSBSshZNVxK8s91pH4OYUhTxTB?=
 =?us-ascii?Q?cPL/y88YvvKNmC7iRG5ZuuSdp0Clkzobc54k/1hBa3Ar/nKIAyaU0KD7/vtV?=
 =?us-ascii?Q?GnJDXoukk5crHN8ELXmgQDsvr0ZfbECGYVh17A6LGpkSGVUiBnlbOD21Doi6?=
 =?us-ascii?Q?A1D57lkj6f7x03Ad1tBeIMmceJ1QcaMSzQGyTALvrsRkaJ7sXYS6La1rr4ju?=
 =?us-ascii?Q?sAXuwqIniD2AuPw9JQjuMh66yE3swZAx1nyVWlhb6xKE8IUzQmsq0hvRHAat?=
 =?us-ascii?Q?9/XjlaFPFAUp2EPuIPdE71X8/6s/Z94Zf8OT7dmJ3K0blYqZIMqtVREAysnt?=
 =?us-ascii?Q?bLSobMOsB1+0Q69amPYd23DJCXXCGvZp0TIr6f/dgR2rdIV6UeG4jtON96j6?=
 =?us-ascii?Q?C6xv2yTjf0IQqaLZEL/nIjsTJiLdQI3yBK2VSOvVu/b8NFtHpzTLYAFbVF50?=
 =?us-ascii?Q?Zzx/lh7xAbQQyC96gVS2v9YP3frtV4BQrOnOfHTvgUMorZTFWp9g5GdCYGyx?=
 =?us-ascii?Q?EGOcCddg+kZjhEA/yjU0LBIjHG2CJzXAH0Iu9+nbGf2rkv2M3IDVDpvDv0Hb?=
 =?us-ascii?Q?DVjqKTuDxRzHKnBrry2iRyRfjYNruIdafXkaz5cjSwvwR0odPiNGTJEUE+sg?=
 =?us-ascii?Q?varP5J0t2PiI7kRlvuYQnluv5Ir9XsBPKDkL5WEkPCwB1y6SOMny3EuMdKUC?=
 =?us-ascii?Q?gRjWaeN+r96BxfFWYvIr5uGG6MSSVA9fv8+fWYOEzPsO9nJAIPD7qod8ZmA+?=
 =?us-ascii?Q?LtI0DCBWnR8889e1bDXW/lny1JIshsOIZljhjsKwY0L+51aWgwUT7gIqD5KF?=
 =?us-ascii?Q?EiUBjI5SsonK8ZQ61mhVX/y0BCQ041G27JNcLqeq1c7XNym2jjcAhPZS8Gwh?=
 =?us-ascii?Q?4Y6rKZt5+tZjwyQdA7O23x5JOX3HGPde2Cgtqu1J2Qfoyxo3ah5BjyhLLjFp?=
 =?us-ascii?Q?xMQAFrxV7eFDGzvnMQJr/elYeNAVSzm/pAQegrrDlrAGDXIAXL1eLAhUHKpo?=
 =?us-ascii?Q?8HHm3B3rmD+TYL1/KoAm2BGiXSM6i99XpE60aZ2GJhZFAuqy1bAW//6cnKdJ?=
 =?us-ascii?Q?CB1hBY5eR/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdM6p0BOQ3EtvqsxCrApBOaH12a+yncuGIaK1g+CEHPXdTYan1Z2Tu8Al9hn?=
 =?us-ascii?Q?jJVooMEDtdvQHvVR7vnP54Tvgwli+dTUK74MrxYpT+01psOnlRKquFXiHqVN?=
 =?us-ascii?Q?co2MDLdxMhwuEz8XNsHGsqwcB2u54Cp0cyHOhgtLUW8UXpxZmu0zSFCWqKik?=
 =?us-ascii?Q?zbQF06pkBJPSWhXHTMUp3ObM3cEl7W4SpZz0o2hwpYHRciqJrJu8LB3ZgYvx?=
 =?us-ascii?Q?28PH+nLlz+jNSfpO/8ltsL1FdwDeK4Y1NwyuUsFjjehoAgpTvN4e3F8QKdzQ?=
 =?us-ascii?Q?1Ix6kPY3daF75jLHTw7FjMZxb+y42Y80DETvpO0+fwZi9cBCnhd3m9kt5wEH?=
 =?us-ascii?Q?+O4sDJfLk+MqON7BWXY6sK73IQFLyVJmZ/So2QhCaY2J3hRhMVzNejPhRPGx?=
 =?us-ascii?Q?MHU2Jl2DMmt9UEzHBV8JkFN0GJv331B4DAqZxtq1Kklmtn8uNHs2aHMsG8eZ?=
 =?us-ascii?Q?6ZKhAudh4iSB0W+Nj6eJAJHCUwIIrdur+0g+66rcKSvbUUOQL/jOk6Y85SW3?=
 =?us-ascii?Q?ZJMJP1EEsa3mu0SeoDjyIUK6hMZy0OAP2w/+1dPJcfp/CZcDTERCOOtgWUyd?=
 =?us-ascii?Q?ztBUf/lVI27gwG7hU23/cF4032fMMsYDOVDtEwshRuf+/ESXunoksauSl3/7?=
 =?us-ascii?Q?ClWnTiMV8/WtRL6M0DxGQAp+SmU+ZWKtByaQe13b0SUG9/AoHJviJLBwOxFT?=
 =?us-ascii?Q?5WaZKblNSym+9YtJSJ4zKI3vOwoZIGjjn2ocull/Po0V5V4VBbYKJUPev6QO?=
 =?us-ascii?Q?QN8QNnXCxGOiY6dFzQfbcVudUfx112GxHgiBYq0xJLMTeN0hh7asEqS13cxt?=
 =?us-ascii?Q?+J2you88jb1OTsD5eFD6wdBPgP1YHO23h2ZvG7eNh6JBZ68ZMNC2CWFCzrYW?=
 =?us-ascii?Q?XCfuZpwdpgbrGy9f2m2/LT+V08UlEW9SE74as2mOaVazjOzccjqYT/4z8St0?=
 =?us-ascii?Q?xDE0tiqQSCv2arHBdYew+gRkjt5mk7ob6+dEv6tU7Zk6QLL2kvvehlIReG68?=
 =?us-ascii?Q?tZY9y9WilfU7iBbGHJCxu+Aembs0OxcfP9ubxR0vdUXhWTCIjMVjiME7K6CR?=
 =?us-ascii?Q?njf+ixwfvo1WxgPFIggYOwQJ9gznxor2rYml+MurQ073urc2Ac95qbv+F85P?=
 =?us-ascii?Q?hEVDLQMnNIMelfKLPnDL9jAxyqR1JW06FwlRNIQuDWSv1SOxaB9nmptIWs9X?=
 =?us-ascii?Q?4RtkZgZ7+YnHZljOYROrd90Dx3IveWrs0RLAfsCBpOwGYDU0wWkAZPIb1RTZ?=
 =?us-ascii?Q?3U0nP3nYrGk/SRml/r698z60O2FaHfVuLx7gVCVYkM6MXKaQ7WjDl8vDnbRz?=
 =?us-ascii?Q?rorlll+D7v0VKZ7JNLMcx543ESjP+DjRRsrAu/BsS2GGs8wtNKKEonzYeqy0?=
 =?us-ascii?Q?V9Xt12DvPcTF0v4cMYCF7noH29pGc/3Iy2UFHfeOFvjxy2b7cB442BDcJnsV?=
 =?us-ascii?Q?JyGGU5lhNMmjmqDovCeUHdSQ+XwxpvGc8vy/tpHDnLLunDhxSqQMn9orvo5p?=
 =?us-ascii?Q?8btqJBq07fyEfrIkXuyGdZMI14q/I/cchWNbjLUrnrynjnq9I7hpToeIDNL6?=
 =?us-ascii?Q?svDEpHsYob+OVj4ht3I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72d6d11-7304-47e6-4496-08dda6eb822e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 00:20:59.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnFEJ5+xUpooa9GFmnWY0FbgcKQ+p+ZUY1zGZACq4CrrDNVh95eAO6ZxAxDZp5WV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

On Fri, Jun 06, 2025 at 11:49:46AM -0700, Alex Mastro wrote:
> Hi Jason,
> 
> By the way, we have been following progress on IOMMUFD, and would be interested
> in dogfooding it for our use case when ready. The main blocker is IOMMUFD's
> current lack of P2P support (IOMMU_IOAS_MAP fails when the VA range is backed
> by MMIO).

Nicolin has a OOT tree patch that makes iommufd work in the same
insecure way as VFIO. Several places are using that for now.

> dma-buf as a less ambiguous semantic for communicating this intent (rather than
> the struggles of inferring what kind of memory is behind some VA range) makes a
> lot of sense.

Yes, I hope
 
> Based on tidbits we have gleaned, IOMMUFD P2P support intends to be built on
> top of "Provide a new two step DMA mapping API" [1] and "vfio/pci: Allow MMIO
> regions to be exported through dma-buf" [2].

Yes, that would be the first basis.

We also need to enhance DMABUF to add 'revoke' semantic

And enhance it to allow the physical page list to be given the iommufd
instead of a scatterlist.

> Item [2] appears to have been picked up by "Host side (KVM/VFIO/IOMMUFD) support
> for TDISP using TSM" [3].

I hope to see #2 redone on top of #1 this next cycle, Leon is working
on the incremental changes to allow the new DMA API to work without
struct page.

> On top of this, there would need to be a new IOMMUFD uapi, or extension to
> existing, which would accept an input dma-buf to map. Are there any patches in
> progress which include this?

No, I haven't seen patches for dmabuf revoke, or iommufd. The patches
for the physical address list need redoing to try again following
Sima's directions.

There are lots of steps here for someone to contribute to :)

Jason

