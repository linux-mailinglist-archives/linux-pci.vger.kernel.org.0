Return-Path: <linux-pci+bounces-39151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756FC01A2E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78DAA4E532A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0632FD69D;
	Thu, 23 Oct 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V6qssH8P"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7828E00;
	Thu, 23 Oct 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227985; cv=fail; b=iaFBv8NToLHs1UmyWsXIUlZ+PGIrG49SedPsMY9cBbMrGh6cFg71rOpgjhBxClyAVas0Oqh+QpwRKol68g47YnUWcw6oG+02xjwpKg1xl0a/65ojkyXhQACRzmX6x5Q8eG2tIVN3WLXUPPGxk3ZwvRVeSdx9m9SmU2ZuIdyjx3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227985; c=relaxed/simple;
	bh=vdeI2j2aL4sOlZYMXD8cWIo4esfdj+jEP2LIwDcPU7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFeOY0szvhXvFP7k51QZwfO0oKQOkTkCjUezFz5CbGZoViZi92hdSUUrQecvkiGnnMQLkpTF2VRUpRGLSb1n4hiOrKe3uSqWSWUNF2/q7hNIVGWOkFQ3j3TD4f8CCcVccpJW/D8NML4ZDNOi4fJwF/5zcIHquCPLtHptZXz/Y6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V6qssH8P; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SakdzM5Jg5ELLemdK3zqJTi6rvQsdNaaAQeVNevU67dc58zG7HHz9CVw8pu5HOy4uIXKggzYHFJH75V0wT98q5iyI1QQ87NjcpcqzzwGS8bYgvnIGqM9Q5/0wE33zJSa8dY3aLWpu3z3+t4eRVAWUxKO/kAz4gBxosFDpSQ63m5rG5MeAaUwuNCcfLVzSprW3/h3EBwmhCHi2g/Kg5Mvk2TrXVhmwDJsFB1/N3apUtcTbQGX7FlvPbAes0/fM9b6BPADBEeE30BO8GWRX3TsJ6B5xm3jZy0gSoaEHbKXQKYgoQDWu2mbqNGD3a7YumfvsSLWRBT50h8Bs6IUzyYVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/E1k9lUTnvsMxCa/kjJ3lCG15IbZz2ZmYbE7HE1yyg=;
 b=JlfjtHhjQFsbGhI+hXqBByyDQUWK8/FU/eMHVcogIn1cJYaGts/2i248R4t7gE9xjS89GGjxR6t2j6PA4SBPbgjCpPGZXEGo7+p4CT5HEj2Y5gxLQk/CsSB74NTQthQyLu70YrolTcj8eAmlKZWNvAqTt17gw/uGAYDdzFtoVceiPcPvjo9GEBt5pPiFdmGpwcLB4OTA9T53ULxdt3vIduVo5czJ1Jm7KjoFvdc1CqJSV7kP0FnSO4OG0WSY5/JORxYwZ3NCyQx54hq4pLwUXFlBV+amdy07Av4P+iswu3BWW6O0A0dswHJBfQOwlYcVsO50sFGLbtto9L+KZWMxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/E1k9lUTnvsMxCa/kjJ3lCG15IbZz2ZmYbE7HE1yyg=;
 b=V6qssH8Pxubg1ViQrLGLSVNq1Fg4nyIcDBJpRnMNZDUMoU7Bzty24t1kDWt6NtVk3ZV32KSX0IICgzizy+yfiR8o/okz3tdNHQyr32fzLX+YKhKqWZGWzNxScNuHJbt9YBWMMW3OxZRonHoxHrcQOQjV1KDdyKpxlh9FTrd+gHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Thu, 23 Oct 2025 13:59:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:59:40 +0000
Date: Thu, 23 Oct 2025 09:59:35 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023135935.GA619807@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022181856.0e3cfc92.michal.pecio@gmail.com>
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b6e7cc-d1f2-4fc6-a980-08de123c6923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UwvuSV6bNnmPPNBTi6IYukygjR2gC+fg9j7upNsyoX5AhPpn33e9hkGzmD8w?=
 =?us-ascii?Q?3ep7cjDWmbX3IqbeRxlrORgWeVS9S/XHGAPjFGHmb2mt3Hd4U5riMiPNyNQQ?=
 =?us-ascii?Q?CIi11jHMNl9rY7/ySsc9OLZrSJz0ZZQ+6xcMlZyHe7jxgYGNCPHvqLLjZfV4?=
 =?us-ascii?Q?YDZU4QIxn0kdF5B7r2Lrw0gxWw1FwH4b+aW0pmfAUd2nomtDupkLiXQd+Ohj?=
 =?us-ascii?Q?WJHgiDNpA1TJZmABosKFoisOKzDrOjpVf1NydRaYXPsuJBSkgAn/QJFJ+ex3?=
 =?us-ascii?Q?6fG5E7HdtPwNuoKDHOCGr0ku8arJFeHE7hudjkif/NMf8gL3l7j634+1pZFZ?=
 =?us-ascii?Q?00QtUrjlOBG+QnUd/KaQL8BpHP85sxIXe2T/9W3ig1bvKLePIshVQIQlX7VH?=
 =?us-ascii?Q?MXADAn6gn6Ly7Kq3ejwTV3NZJEtsM7W6L/Fr3U0qTTG276Kr88flWIyVbBtL?=
 =?us-ascii?Q?ITys5YS84175dhfmCgmOTCcFx6rxGQsXTfOgX/4Os/cfuhfy3gPAs/6JAinu?=
 =?us-ascii?Q?RGq+8HUCLndr93goFacsGPX/mCrzfdSzvNHoHFNTFn4P+YQhvCaM23cIULCv?=
 =?us-ascii?Q?Tjc2sApQRiinpRNG/jVsL4TxGpC62kEQ5qmvxOAVK/JcTLNGfljq5LrUEMKy?=
 =?us-ascii?Q?YViWCs426Z4x0WDDe+uvj0AFKrLD3CWc7RyX06xQ6y/dHdoqn6E7gyMQYt6G?=
 =?us-ascii?Q?zINs1ktKX6s5UcFxBn+0mjTcFYQC7g3IaIhf6Gr0wC8tZwBX/pTdOMvA/S6k?=
 =?us-ascii?Q?ApGSpUHkNOwcgc3ujVC8dVTMPOtdylNrah5ltyrMp4/hA3PjMHVubNqHcgrg?=
 =?us-ascii?Q?ZCehFvLdJd2DWo8UFXJrOUPkzFpyWDI4a8Rcjv+EXt9d47DAwse443Yt+PE0?=
 =?us-ascii?Q?MFtXxXoSNBGryn4vfPlnvX6blBILiP+mFl45LdG1nTXTxbXDhy34llASf75h?=
 =?us-ascii?Q?8sOuIu/Kx1tfA+PgzDohDz/6lRe5M6szT+YRVIWQTjZJf3UIURsGtoH3D6/q?=
 =?us-ascii?Q?m9BjeHvckytxshnfmE+beXxFeEwg9tiGrZY3Rym/t0hb7yHhO0eDfztrGpwa?=
 =?us-ascii?Q?YWi8wxQPTRmjBcPLhV5+UL5pxtOJmr7gOdt+L7IMwEKLcyow2y5vlvBY2TdE?=
 =?us-ascii?Q?izUfs2+Y/WMfEu/qa/edDRQoXFvqrqewts+JmxmAe3IbJ8xEEUzie1P6PNiS?=
 =?us-ascii?Q?vOKsKQdy2wBpxAACpWfIP16ORi2BIdKhYHSVTd8XBCxtPjLqHcgtWaJ98Yw6?=
 =?us-ascii?Q?KAAwCvlyO15CwBlkxJFV343GF6cSwC1h7dLlRP8L1Zpa+DjVhqgnjLG8wW4/?=
 =?us-ascii?Q?1ohKgCOKMTDIS9+v1JqQZv1nKtkXSAMU2FkCHwEGYJAy+hGBTmPd+HvyXaU3?=
 =?us-ascii?Q?GuOUmQXTuYwRRiJZ1nbPLI6XNq0UMM8GPr5UJuD+ay/EkQBSR9foRNmaSLQa?=
 =?us-ascii?Q?nTW/IDnSXqmkfXx1U/3sDb/AKc7ZsBnf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCCwHBDOlXYvkYch2B1h88/VrqXH6g7akclSEBpYsjPvxrILY01oRFmRqKU0?=
 =?us-ascii?Q?uNqknRUU08ZfBSgz6/n+ywkq05r4H8I/Hl8xzz/ZOG9U0AY5qH6+OmpY4m5Z?=
 =?us-ascii?Q?naOHVvqt8LDhtXdD1Ib228S/Zv2jzoh188eApmdtCzCHOblmxESOfsnvwj0c?=
 =?us-ascii?Q?2GBTsLKePdyC+5IanqSP54N+awqdOyi8kSVTT5oSGDc4LgmEZv+76uieFt4F?=
 =?us-ascii?Q?TcmcEJYOxudXz98n/Dw3qXiiq69o+Guq3R/THl4MG7ARS8okkFcZuNdHsLnp?=
 =?us-ascii?Q?1wuaDiXDPpB2YNk4bBIFRFQO0b7OA27CGufJ/PFiRgLe3B3G3wiiqOf7aGKV?=
 =?us-ascii?Q?hC+a4hQ09JOpnfVeXMUOe5TgyQSuxxZEBXP3IR0+Far6Uc+z9Y0xW1jCf5Zf?=
 =?us-ascii?Q?mud262xWnUuP1yRvA4Rfc603by5nN3bMni6eXseq2oIKkMRm4BQd1Wzbl33W?=
 =?us-ascii?Q?q3Vy0Rv6S6YiN4Exvuffa7Pr8eYlQ6mjccDhdSsQF3MQBNencMfdXuOqgYSH?=
 =?us-ascii?Q?un1SucGLRYh4xxmKzGDppT9iYbuvJtL/H5ImfEzUCEMszg5L6B1zrqb2Ci/u?=
 =?us-ascii?Q?rfqxCJHL5+rRkJeVtcxciw/k5J215Xk/tlmdaxGrkpktRVNHDyyVQ8Umw/2G?=
 =?us-ascii?Q?TN4GLXgZEhkmYIK7BrfLg2aPxnLHmOjkStF6JQFmJKyYbHMQQjeJdDgSkGq6?=
 =?us-ascii?Q?TdRXo+DMBE1NYJLkg4JLvu2/k/ILzSaJBHx8BHpReIt5V18YxmXBiM8uffCe?=
 =?us-ascii?Q?n4syZIz3yLaRSULM2TGY6s3urOCKThC7NDtX6421pbO747l8mi1HKsSt0SP2?=
 =?us-ascii?Q?JlNdxucGZCY9XZdZxdSS6dlBAcsTnuGsxMIg/FtVtCNXVWqEAYEPC8kvnHkO?=
 =?us-ascii?Q?vX3YVPsv+ngxP8ZCrDLoHzQZ0gkEgsxq8htuaWO+RiP60T3/GZZMpre2zhid?=
 =?us-ascii?Q?eXE5mQOrxWeRioHt4YengEafqAxdWVktJ7vl3bpm3CGfj3cR+TRZ8a58h6WC?=
 =?us-ascii?Q?UELcRnkzsR1PRl8XZId4QrcTko0p+hIEHnVWLP13aDxzIRs1EE0LJXcb8iGC?=
 =?us-ascii?Q?FfhvdMpDQtGqWYccxf0AEz4nGR/h1JLxF5SoA5ZlcS0dgARJugNjtoXcwlsW?=
 =?us-ascii?Q?Vr8Jm2XFGZJkTmEDi3BdSzkjNUZuVzLmuhw2LrxYamES+EQgZt/fhg5WfZkP?=
 =?us-ascii?Q?tc+AXte3KBzl6QKfG4isG7mR/ifHkBDdlGJexWTcAMNwNg++lt6AgRoO0in3?=
 =?us-ascii?Q?Fh7MCZhN6G+taw1GYD0J9d9omFpVho3qzIoTvFaU9MXyJutk+QHbZcoCtpky?=
 =?us-ascii?Q?UtNsLVFhBaiTgZL1k3fliqwvzoyPrFKMKqI3l7wMQghv6oTW2zHXuTIOSc2t?=
 =?us-ascii?Q?uRFYac9y1Y38YXvjOABmIABLn7wI4+eaw7g+CLdKnTDeX/Ip24R/XoSlzx9v?=
 =?us-ascii?Q?XpPZaPIk7c8EvjGcPtyUvpGKykLNCW7DvVVrG32aCYPHtaKx/ll8WHR6Raxb?=
 =?us-ascii?Q?iRgGKdTSTIIgtAQfYhv9Cjw61d1YTToyJx50cyuMZOSXLNpqsM0z8uFmJZXf?=
 =?us-ascii?Q?MMiR7KHIi6qU0S+ZKirfZ7SeaNvSA251B8m+a2yA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6e7cc-d1f2-4fc6-a980-08de123c6923
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:59:40.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyI3po089zPNx9thK2QgaJWggkabgcKSacNaoOhGJNbS7RBUllfpFdQJmctem7c/MLQJdLoCthr8FI7eF010Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

On Wed, Oct 22, 2025 at 06:18:56PM +0200, Michal Pecio wrote:
> On Wed, 22 Oct 2025 12:09:04 -0400, Yazen Ghannam wrote:
> > On Wed, Oct 22, 2025 at 05:38:31PM +0200, Michal Pecio wrote:
> > > On Wed, 22 Oct 2025 09:39:01 -0400, Yazen Ghannam wrote:  
> > > > Can you please share the full output from dmesg and lspci?
> > > > 
> > > > Also, can you please share the raw CPUID output (cpuid -r)?  
> > > 
> > > Not sure which "cpuid" software you mean?  
> > 
> > Many distros package a "cpuid" user space app that will print and decode
> > the x86 CPUID feature bits.
> 
> OK, here's some "cpuid_tool" from libcpuid.
> 

Thanks Michal.

I don't see anything obviously wrong.

Can you please share your kernel config file for the v6.12.31 build?

Thanks,
Yazen

