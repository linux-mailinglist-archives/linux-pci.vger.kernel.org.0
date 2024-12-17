Return-Path: <linux-pci+bounces-18672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D521D9F594A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170781883564
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4F1DD54C;
	Tue, 17 Dec 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nspWSNxq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF6155CB3;
	Tue, 17 Dec 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472562; cv=fail; b=T5EakFxMXXtAm70AtWGvyV3pUorimd5VAplhUXtaBqYcc8Rmr5WLyfRDMj6FRDRzFiLse+opMX6KmNskQU6bcLDoUQEpnzTboea1tO1I+Up57JrtVsKarWJoZbbc7V6Z7PgK2IWUsteC8ZNLkABvPk+2H46N53OSevMbaMZyLfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472562; c=relaxed/simple;
	bh=tXdhgnYROlqS20GBSzCvPUF/aBO1pkT8BYkFUeGRi9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oVa5nexub9TIUfLR4MKpHozK9AseYwfOXsnwwflIzpPu+UkJFwKdFl6XWIZU5sy3txFreMzmfoRn8r8PkzzjqxNfpKZsvbWg3rmHWT4wBodhPry8jhsRoBwt1r435R8smNtsYKcW6lIdm4j36Pn2tySx8hOFH9qVsW4lbTWOQdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nspWSNxq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIJSfi9xmaGewhr1QBELSsnAIGWNIqRcn1qrZLlBaXgjQkR3+nTs58FL8007n2XRl0UpoBVaolf5vFdK3njd/Zqr7IFcSs6uuneUfluniM2gpDDm3VpfLQKCoDhSJIHCRTYZH6Tz5xYk6Sq7E7bSqN8NdgZdRyVOGUKHExVpcy/rvENCb+dpwhhjg1S/P/J1tITMQ/xfYgbAGmbYoaR2OqD/d6ILSy9ZBLPB8gleNeyX2YtqBru33wRs/V2JLer3VVz+IMD/LMv3uhxn12PRAAHemI4cbnucu9j3D7JpHQVXWYcuugZJ24M3QdRurVuhShsrNYnOGsxJs3M+MS2KVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+zsjqvRlZ7iyeb7DHhPqi9LKtIQBmr+vwJI2/Edufc=;
 b=CcwTCJROLQrou86qDDWEzuFLKTKcM/4gI6GaOQYGr9UonA2p/zSievzWanziXt6AdFrQ2T97LIPl9wdO8w65HXSWbwiPZyFcpG9tE4RkCtUTF0Zdz2LPeJX/IDNmKYEaYEpTCfe/NUaYu8U96zLIt5pltet8TT30IPRMT0yDyGKwvAF29W6dQokzW2ZuVThmk4MVNkBHCh9X618TrF5Kd40U2SqzKPkZmKEu9W23UsVEjnk9t28ab/FktDcNGKRWYchLUPHlfexZK3s8kNBSvyipxhvEC97QptZHizTOUvRR6kiCXJ1kO80GIVM4V5YuhOU9Rpj1YmTjgrddhU3dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+zsjqvRlZ7iyeb7DHhPqi9LKtIQBmr+vwJI2/Edufc=;
 b=nspWSNxqtzXt/UOA5tfbJgV5nL1cGe+SmtXqkHksb8QNXtI4vGJeTVEe/ArxOOscKL7iEgwKQxjgw08HXHyhsea8iLIRTCkNe5YPoCk0T26XzBhR1wGTTtte3kIzfoUuSTZj1U9My+Uv6PIwno0fq2A20wYjmsgphyIivJ1eklI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 21:55:57 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:55:57 +0000
Date: Tue, 17 Dec 2024 16:55:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] PCI/AER: Add prefixes to printouts
Message-ID: <20241217215545.GB1121691@yaz-khff2.amd.com>
References: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
 <20241217135358.9345-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217135358.9345-9-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e87cf06-dec8-45dd-2b5b-08dd1ee59616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?KtpOH48EICNIn4mbpZTDdRf+IPfl13vrFQvoQTCC+VTZDF2CMYm6QzqVRQ?=
 =?iso-8859-1?Q?Kn3c26zoPBLSHCwx1e1h/qD2YhDi7Blrxr7fUrgrhLb43q/SfQdSovwaHd?=
 =?iso-8859-1?Q?2c78NmDltN+Om9WDz32aNxTpa0dGdrbYzKZjDHIgJQjNPOP+xjZymSVJTS?=
 =?iso-8859-1?Q?RswJo9Zc3ZQETp+jCHpAZjn+LU3Dxe65ALdbTXmDvDAnDi7oAzyEaYqXHT?=
 =?iso-8859-1?Q?NTluRtm1kS+bPNXg11CF0xHRVJh1HLg9Pbx65hQFPRSJr2uYrY/fvwR8wQ?=
 =?iso-8859-1?Q?JWwvj9gLFOjQHzWE59+O733pTMOJXpmgJFV7UmvvtF21MAN3MVxXmRP/L3?=
 =?iso-8859-1?Q?xY/tTYq9hBCF8vnMcH4llGNvMQhsS2R1XJoURyNplcyxZiXh3319kJgRX9?=
 =?iso-8859-1?Q?pkYzO7Qi/3GY/WNEcbW6oe8z4G9HhvMcU3xw327xdxErds3vIG/dof4maX?=
 =?iso-8859-1?Q?+sKXyClQpW2N2cnTGowjjypeR5PoCl4TJ4kU8RYiHa4YT40S6r0wuNFGiI?=
 =?iso-8859-1?Q?LzpbyCJD9+eF9zfvMqi816RZWvc15jg2PQOvuDiSbu/H4WYT9ct2hlC5ma?=
 =?iso-8859-1?Q?ojP0iECnKGuAetWk0QffuB7s2RGmAojzRyvZoxFieTTvHbE6ZySdAOM1q8?=
 =?iso-8859-1?Q?XZG0XpqB2HI33n052CRHN0exvXPplVPFsd/5UuVG1FhKsRIvW0jVfn1yzR?=
 =?iso-8859-1?Q?87ZmoGayQHY+d0CnKYWuVrx7sRrBZCUJCoTLNuxKog3qpmupGdOkaOr9ox?=
 =?iso-8859-1?Q?nn8u54rz1Ip3Q3ChLDnYTDLTX+GSp2qifZZEV5ozWIgRkZ0PQyMAzscJB0?=
 =?iso-8859-1?Q?XYk6mGyMrDoLrZF3dW0Xa8e0EbxZ1LaVc07NMEVy9uVGdNeW4qYN+4hOoz?=
 =?iso-8859-1?Q?NkU+mE503K4pFoLWN/CrRta6vN4guaQ3LmPmWGqj6rBYzpPokCQkBzo6J4?=
 =?iso-8859-1?Q?D8PANoJbTgptNdFhTZejRCZuY/peRtAM1YJlGB3lVmwWyEby6+yB4JdtV0?=
 =?iso-8859-1?Q?eAtO9xob28vcGCrq3YfhUUV6NHNYmWJRRRvS7Wsl2xFKQ/FefvJ5Qf08EJ?=
 =?iso-8859-1?Q?lbFphQrNAQQQduzo18hjq6y17mUT7eAZWP77ysWAf3RBv5qynYWaq1fgub?=
 =?iso-8859-1?Q?VWcZkAdtDJRC2rEtSiSLKMoYU+WOYJYEVjKkIwKV0+1YleKWvFBAYHanDb?=
 =?iso-8859-1?Q?B4mnORdWTm3QM3zNt3jvFW63h0t0+442znjhrplePjRAfaCOe31t8FMpIU?=
 =?iso-8859-1?Q?fxsYURPUyYFMomgfzYCCmnWMcKOYNP7H5/Br/oJb51oPr8BZfvEboJl8Gs?=
 =?iso-8859-1?Q?uA9kSw5jDglhwAyT2uYF3bBGwkpLP1PpTSwZOFDYvFzLijRcdGZZXw6fJ1?=
 =?iso-8859-1?Q?GxgJUcAPpuV2VGv4GuQlS/dFxBviB6Nh9ClcCmQVN0JM42lbzmJYYTf/Vd?=
 =?iso-8859-1?Q?0/od8tCdSbkQDu/w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fntDj+3qtj7/0tMGWcwvEW9ZL+1wf+CydDViKYGUzu6N1fQWGlM7ipho3c?=
 =?iso-8859-1?Q?1BIqsP0QHS8pfiB4IBiaL1C+Ic6VJFWtDtDJPIKamKLtAJZuqs68w2Q+0Z?=
 =?iso-8859-1?Q?VCD72RLLJ+mBjKHDjbhCz3Vf3IG19v8x3SZRSGgO2K+otNECP3kX3PM+nb?=
 =?iso-8859-1?Q?JXwVUwoCHB4RcWw2Wf+K3xcJSNxUCnUFGuHkrsRwNQ5eywrGyv0cFTw9FW?=
 =?iso-8859-1?Q?nb7W6yLhf6Wj1EONOnWnZyd7nEj7hDkk2ALEZH/fxWV6Y2cYke4o4FqU9A?=
 =?iso-8859-1?Q?wwSFfv8bF6DeRQ6Gtn/mgsfWI3k3oQSGSWr+nXhIZzBAL7tSnHM72/uoI4?=
 =?iso-8859-1?Q?5SBDlAbc9ts0F7Ss/W4sapBib8kpag6MbDM1AnmP0n3pLPapCSWVW+XvrR?=
 =?iso-8859-1?Q?/KMQIs0zX73R70cYaVgWsshoCsX5KzS3DHTETbYSssSfG3ScSHEfWQIt2R?=
 =?iso-8859-1?Q?kfHcT08fQzRo3sVewtcJLIcHzybiHXEOb7u+JjbO8VdUEajtXGa4htK+EC?=
 =?iso-8859-1?Q?wilgEVQwRAbe04Ehx876ZvhcTjkRkkAI8XE6G1oR9geFRUEgYj6fBV2/qW?=
 =?iso-8859-1?Q?F+YhPamatNJxzBKWiUNEZbR4R+z+d1uYmjm0r/tOnek1m1k7m6A3QGwS5R?=
 =?iso-8859-1?Q?ff1U8dHmz90x0TQpfeRx+bsEcBcgXKTbo25xJVZjNYmkkOYWD3rruqkeBH?=
 =?iso-8859-1?Q?O6AWZ85+1C4EUCrEEKGOTCF0LCRK1s1Ztg4FWfXfXl+7nAuO06oTKhdSAk?=
 =?iso-8859-1?Q?UcgH2zP1Pc87yyCrVwGy2xGskRBlItvHVHHKwUsaDGsLmRqZGPwMEkR4CQ?=
 =?iso-8859-1?Q?RBxA3jvdx1vOBHkMXtHW7EqbLOVXZIq1U7J8vrWfajDkxZDfDIlyi8hDBq?=
 =?iso-8859-1?Q?FUwT+t3tCPBLwgEaNcKyhdgOyMRlFrYa6lLdlhVAtn9apOjhawaC8TiN9i?=
 =?iso-8859-1?Q?6ZmIzSLb2rD6S64RpfJipmu74jn1hvR5p3+QrWNqXphzW2z4wgAYXXpnXN?=
 =?iso-8859-1?Q?v+pgpusekzJrIR3z7RO59xAN/bJCsGlyryVJnO10MjOBgnjhdVoMtR/dMf?=
 =?iso-8859-1?Q?Jm/+GY2Zhh85tLGlAe/QwQQAn5YbzL17hnslIZBOfVYGvQOfYLhT9N20un?=
 =?iso-8859-1?Q?zJhzBXtSIEoTsygnHU66uVdunB9bhvyRuCLVVkXZ1JWyUspyaHje5uA7yB?=
 =?iso-8859-1?Q?AXQ+d6wC2sEYpXLi7m4rlg4wyH8qPWVUhoO+idA5VaA2iHP1tiVYtpcgfC?=
 =?iso-8859-1?Q?QkriSFiGl0A7Uiro15oc68WhbH1qS8DZGZ4KarSy3DJJ+JrTbsoLKJRRnn?=
 =?iso-8859-1?Q?s/C/xpDHFVwqyrzmgj30hjA4l2KDo9a9vnqKX/OlpYgo+R2c0vhoHKxfkM?=
 =?iso-8859-1?Q?LRIb5L7AAIrg1/GzhXEBm+EVEkBfUpYZ1ln2zV6czMt4j7GSrcG7nT+VRS?=
 =?iso-8859-1?Q?tuAnnWN3oF6jx7kY21l+jT9enrL3arP8qvxOPaFXgqq05q+KhgN0iXXtbb?=
 =?iso-8859-1?Q?sV+F5qXtYHP51BCAfr+UvPq2cskdNbD50GIqpg0B7ArADPJ5QU2rk0IcVv?=
 =?iso-8859-1?Q?43W/MgfXCTpTPzsXsqCkq2SSIBHr15slL9Pz2EXWLjoq9mDV1AmAKxqr2y?=
 =?iso-8859-1?Q?Lgf/cU2YzqPcFex4h+KiX650kYpVq8HSee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e87cf06-dec8-45dd-2b5b-08dd1ee59616
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:55:57.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzH7FYYQNBcuuhIDzntGZ5IcmwhA1a0AJleIZhTIKFOB+BzYZM9EADERgZxKTVK6+LG8CC0JOlRnXeZVlkRV4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

On Tue, Dec 17, 2024 at 03:53:58PM +0200, Ilpo Järvinen wrote:
> Only part of the AER diagnostic printouts use "AER:" prefix because
> they use low-level pci_printk() directly to allow selecting level.
> 
> Add "AER:" prefix to lines that are printed with pci_printk().
> 

Can we please include the "HW_ERR" prefix also? IMO, it would make the
kernel messages more consistent if all hardware error info had it.

Thanks,
Yazen

