Return-Path: <linux-pci+bounces-35046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2324CB3AA3A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7467BA043
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32854322A1D;
	Thu, 28 Aug 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vva89m1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1C2E1C78;
	Thu, 28 Aug 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406781; cv=fail; b=iyoKnXt+SmhCu8dqRkehTf49zLNvWnwCiQC4eQdYVp5NDSQ4I5+n/ZD2xNU5a6MJxh4gfyJ8CDzqUbNkVRMTQhXfGvTmeTCl7pQdGSXOOHEmEvKO1XYXGSlZkbLQ0Uqin4jGFe39SkFeOUyv/DPfd8l784dyEXgrLsB3+APW4ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406781; c=relaxed/simple;
	bh=SGrL/EPUA+CSICIzItkBiCCRt93NmWSRZ+Y9T6Cz58k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZ7s+ukLlLV5Pl2axdRy6uSjHemjibohJGBb12emZGwD8TWoxR/bGRUZvrsAFyFWOp8al42mkmARx6VuXi7Nfb1NSBKx+NTLVZvzTzQ1dXZcyxka09lSJACV3YU+iQrXUAyXLw7zJXt97uBeRN5soT+Ei8MsZmaqAQX0kYw34u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vva89m1m; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wud5iMPLdT1CFtBRJBnYT8/gfL0cV4HlP+2rp/iHDXebXN5bkav3uEuq2lf7nafDXqPgETPyY5o8UtXyOimSOF2PT868kc3c0mj7WFpHBEUDnVkxksgOEZfqJZ3+YltnAZVu66qma0sNh+VmTgc0HzOBmTOtRDAPoMR1gS/0sS9liq1T5gn9hoRDsr+FwTcgv9WbaFV/aRcVVFNNZdlQCKkW3g9fd8NwRZLDl9BSsZ9zZw9O0+KXyUnCPo4WkDDi6PZdFfN4JntB7S+EPCs3HQkIwI+cKXtRincgODoKjLXykg8Ljxhu5Ly0nf9xpSvPEx+TJOvtb2desnLrlGrEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFxAui69d52phC8Uj1EGIJKpSGV+z7RZTrGiYAZuo7M=;
 b=ioMEPedLuSGEGS2I78/F7OQhtksUH0SnH2F0VOF3iyId03eSEWWjs5l0cTXbozqGiUog7UcIMdYTI0b+ywO5K8ypbj0uPcudhKOMFLVQSLTh9krLFtH+AkCwNF0PosP+27YTPPwQITi7C3UQQHA130Re3fNrYy5W0MvUbi54HKjAiJJ1kZIgoHFPPZ1uV0XbSHuNvW74eAu+rjEb2uFcMnq/CWFOghR2m+HlZN3jW9dkR7RDSVNVmx8dk84lOnFz+5GuuA82G3rRbKZiGJWwwrPGkTOcDxqS26ww0cgpjejmzHxYOUw7SJe2eAmbCkXxZlSYBrKC9lSBebFNdQEtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFxAui69d52phC8Uj1EGIJKpSGV+z7RZTrGiYAZuo7M=;
 b=Vva89m1mRz78HO27zd2PeXfhZN0dBB0tt457FtvRZeWReko3CyUXFvCUWflZDe7ksIgxmPBvMvTidPCv03dGRZct5XMVU56yo8n0BKpc9s9oWOcgfZpI3q72bQKVA0gIEoOnpTw00vJ0J5oKCBlZWM7wHcEBCrSDXH688C8VIi9cSHkC92SrQTh9SyShVN+DuAC6JmOJx0I68kdf+simA2D3EkyqMtlonCmLv/RABxk/I2Twk8DLqlRPZcxVLw7e1VI3gu/QJw3mvdgKwJS2FYBt0CAwvITwlNVMHNGLRn3e5HFQHEo6GRPvHQSwV3I2LTQbgrVxJQ5HZUHxKirMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 18:46:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 18:46:10 +0000
Date: Thu, 28 Aug 2025 15:46:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ethan Zhao <etzhao1900@gmail.com>, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, will@kernel.org,
	robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <20250828184608.GF7333@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
 <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
 <20250822140821.GE1311579@nvidia.com>
 <aKi8EqEp1DKG+h38@Asurada-Nvidia>
 <20250828125149.GD7333@nvidia.com>
 <aLBw3UTAX6F0IOCf@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBw3UTAX6F0IOCf@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 844bee32-3829-4ce7-0df8-08dde66327c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31oANS4M8B71LrhvSuJ7JsBdok+8eL+p1eM7dghiXV0jnIFTxg3jEBQcDwkb?=
 =?us-ascii?Q?0A17G6B/ypZWIsft1gRcOEblgAEQm4HHH/uIh+/SeQ5798xIJHXJR3c6WP3H?=
 =?us-ascii?Q?H9eKb1AS6/Cn1f4OMGXwpyKMCHhrSLgTFpa8rFJysgx7vvk9AZkOnun1Dd4V?=
 =?us-ascii?Q?48VdTwqye1V2CSr+38o3x4P14e25WtNYQdKP5FFHVon80X1J9XhBBVHgHQXN?=
 =?us-ascii?Q?dUn49sIceze9Qg4nlH9yyzxgS5XgluadhAQ2w1ZYEp4hX7Eb+d9hKNlelnFf?=
 =?us-ascii?Q?0y+zx5rYJnbAPlR6Q8gVOZ9kOKCmF3c0sk8mKGMU6+U1SId+CbKvTCuOnHwg?=
 =?us-ascii?Q?m+yWNY8Qq5ZPp7bU4jxgSwwlmfVhKsbjhIj+JSSY39mw9sds6xknMfg1J1TW?=
 =?us-ascii?Q?T3WjHMtpwyBE9i9x0biW/dlMlyOYXwabe8J7F6yiIzVU7TkW2zv6Tfb7zOKG?=
 =?us-ascii?Q?/OBTpvzlJfTTX4XkmgxHk9BAnXALJmJBXlWXhJEmqUw21fcKXgou4YKs6cPu?=
 =?us-ascii?Q?TsqXHABeGbSHJxpO6BidoTn3OR/lFjWvV88I7Xpu9YPKFZwTYlX1r7JIIqGM?=
 =?us-ascii?Q?s6X+/BAO3H0G1fvuPDK2R07cpwkUZcihLg106dovAeq6yYN42boOF+LtbWib?=
 =?us-ascii?Q?KpsuSVSzvkKdw7sBSQKbmVPxLB+TB+21sNL/Zoq69o1gHCunQWzUgdkcL/Gm?=
 =?us-ascii?Q?rTZYPTwIw507fGVrr+3c0+2LFqgeyGHrKaw7zuCh89JWEdb5NmF4MLf9Rk6/?=
 =?us-ascii?Q?5h/KB3u6H693lXdE60bGPXtIxrm5++hHNKU7z4G7tXHV3R21+g1C16Usb1Nt?=
 =?us-ascii?Q?sz5JrAFz0bFAXM/AINj/A3+OvrNNX8HPh74ek9wzMh/UHdWyy4aWh2J9aFxa?=
 =?us-ascii?Q?LNTy/yfx9iFfyM24rfxo79z8vVOe6nBhmgtZ7143vhX2/UHwluXSJ8+1/Cn9?=
 =?us-ascii?Q?d2dS+/x6+/YSXZpKXQBju12zb6TLHt5BGj+tcP2SliaaP76XkwItVmoHVajk?=
 =?us-ascii?Q?cGbyIFT1A0Vx1t9a0n1G0emgBt5o3ApQlJ3Tlfk20KSS3nGNAel7UDl0gcIM?=
 =?us-ascii?Q?yzbvIy+g7UAXS+PIIz6iZjZA3nEgac7kurHEyWcqP8XotwqCem9vNA++ACCr?=
 =?us-ascii?Q?VvCHTa/NBqy09RJHUw7S/6ZsdGxQvEk4ClL8A2UBiCd311Ted0olvHrsfuZN?=
 =?us-ascii?Q?t0IHnH98ZJvQ61nA/lMAVrnpsakCYZKSdrAxxZd0dT3IawPFZG94Zv0Xjfjr?=
 =?us-ascii?Q?9VqMgHZodb3Ufo5lDrJANTdFNvXeA+4CDZMxGAx6glGCa38kpSVdQUp/3QlI?=
 =?us-ascii?Q?k2uf3GGEtaNCm+YmOat1iaSz12tINrTkKmamVPGem2mLo5OuYkxow819leG8?=
 =?us-ascii?Q?C8NiCMdwfPuOxTHZ1A7OWLFyhqT2xlprUrzYhBmoL957DS8I0ET0XK5WEE7l?=
 =?us-ascii?Q?Yb1f0PWZvmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4X9LW8DFkhJXKvVQ2ht4SyF1Mv8wGNcpaQDoKT9vZw+cnliy3Qhz0OgRRlqs?=
 =?us-ascii?Q?GPzr4YbEt/bNWlIWuH0/SeVVUmTWa2zuZMoRK2Y3sMiUdoNBvzuU2wp7+l1I?=
 =?us-ascii?Q?Uiv83xjbys99FaptkogfASlVXqM7HRqdTeSVMQjpcyCO151RRVlJc1EYg2ZR?=
 =?us-ascii?Q?mSFQBaWNWfEmRkWcEMdjnnud/iFpDs75Zy6ERrfC90JcE0OUr3IVF0V2dJBc?=
 =?us-ascii?Q?xbm+g/wIw1Nzrq1ygnfwlLf85J8ruE8UwM7M08tqiYmQVTjUi7W9HOck9M09?=
 =?us-ascii?Q?sPeXHfdOYJ92BxYCOSbKamJUYDSzFRCiJu4FpjWcFLEbqUaVwqu7hFD0GYFR?=
 =?us-ascii?Q?0bElNkYzYYeG0ukSN+K+gtw5mhckxuaz6/VIRqOIe84lZj9BIIQeYktTcwQ1?=
 =?us-ascii?Q?kXdRrmTCBrxCXAd2nB9h9qYaJ8C6be39+/WNeoc9IuWgIlwdB+WbiMnGiBiU?=
 =?us-ascii?Q?hJVVYjelpdZumsx7oA8KsJnclOyp0RFHT71Wpf5I2npUN5WKm43FhtwVTRbN?=
 =?us-ascii?Q?shPTyOGVLPYEkE+mbILgawQZ9GKCPA9YmAUapPlFSS1X0COwvQqYOXOOVrrO?=
 =?us-ascii?Q?l49DEhB0e0p8VA6luNSsOBMybCKNKqqf9rCHgOQTYKMmn/eE+C5D+M044waS?=
 =?us-ascii?Q?M4MJx4YXY0XOmhUfD4PiaFuP/jf9YFq0L5sF06y5M5k1odLZdAjKNp5i0d0l?=
 =?us-ascii?Q?67F1A0hLgegc/9/n45ef+2ncnxL9pO1a3jcl/NEHPQKpjywG9jq9Dv5WVEs3?=
 =?us-ascii?Q?RdWd2xSPzy6pDyyHQa8BZWuQ6c0XSYkc6L+o0zwoA4Lgj/pFD7Uq2sf+PU0r?=
 =?us-ascii?Q?TGnDqFO6Y9MiWOlIQN3WmwPqWGF3y1zBOx/nWjRcoHqFHTtukJ2ZZVEQbQCX?=
 =?us-ascii?Q?VEmpBpnPyAs18kPYtn+ecOK+JyVZ/TeZma5wcZT6YwvefAlPkSpTdlAtjQpX?=
 =?us-ascii?Q?2UOlpo8Hjb8NkEFb9sVDDtlYQ8ryxIragnaNHi5ay4gAWI37kbI7b1Ry5WTc?=
 =?us-ascii?Q?brEAwJE0MMWw5jUfefirMOb4u8M+nE2kv1+urpzxYv1fuI+UuVRgOFnmd4Bo?=
 =?us-ascii?Q?2yQBRCulARQmlyWof/57KZY2nGXv70vjylscXcD2qP2raQUivVDJ1d9sw3H0?=
 =?us-ascii?Q?XDss6wjSu15yJyP1CdcMoBL/oAOqlsCNDheYr2g6rzKGc3lrfl/ryN4PspB6?=
 =?us-ascii?Q?4VKm04Bu5PoQtshCLdLqhYeUDa1wn5/EjRNQIlYZSYfxkCEkpVoZnWjvEVwI?=
 =?us-ascii?Q?saXB7t8JxOANpf7ONVmM759aexIznez28XbrzfosYamY7ipHK+Jwj2yTl3s9?=
 =?us-ascii?Q?MnEnQD5B77MMCmhbnZ5SA6jiLbkURsocKhLmJ/RJXVLnZjWhdzgBXqlf+6DI?=
 =?us-ascii?Q?Py45l/d16ZRvQ7wGhpNSGkMSGeLlfkFnX2G3z8w1A5/Lx/DhPJQZDoCb/LCi?=
 =?us-ascii?Q?CrPiv1c3SXn9L7THAoTcZC2aTZrAzzwGb619jhmGV5UQ15bQRuOyXGBsvElq?=
 =?us-ascii?Q?CBRFwF+mJIm5/UtVs4HJ7XzkPCUzFnTMdGjvg7qciIPrptcF5X7E3VdncqlA?=
 =?us-ascii?Q?aLFTFlLIx9wBgMls+Lg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844bee32-3829-4ce7-0df8-08dde66327c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:46:10.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF7d69NSc+bha40z7R1FUAMmZ534aeRpO+Q0748YkbY+KMAfWnivf5VQzKzmSSyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

On Thu, Aug 28, 2025 at 08:08:13AM -0700, Nicolin Chen wrote:
> On Thu, Aug 28, 2025 at 09:51:49AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 22, 2025 at 11:50:58AM -0700, Nicolin Chen wrote:
> > 
> > > It feels like we need a no-fail re-attach operation, or at least an
> > > unlikely-to-fail one. I recall years ago we tried a can_attach op
> > > to test the compatibility but it didn't get merged. Maybe we'd need
> > > it so that a concurrent attach can test compatibility, allowing the
> > > re-attach in iommu_dev_reset_done() to more likely succeed.
> > 
> > This is probably the cleanest option to split these things
> 
> Yea, that could avoid failing a concurrent attach_dev during FLR
> unless the dryrun fails, helping non-SRIOV cases too.
> 
> So, next version could have some new preparatory patches:
>  - Pass in old domain to attach_dev
>  - Add a can_attach_dev op

I wouldn't make this more complicated, just focus on the signal device
case here then we move on from there

Just adding can_attach_dev is big series on its own

Jason

