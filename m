Return-Path: <linux-pci+bounces-15209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAED9AEB70
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914FE1C2275D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF11F76A6;
	Thu, 24 Oct 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycCKgyRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D551F5825;
	Thu, 24 Oct 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785997; cv=fail; b=poHcJEGYMtQMQUS8MOTr09f4bU9DI2hffvIMv+jznaKyXJ5k07PFso5RE8hsw/EfXkiU6DJBDak+8cS7EMRZTxtCgnNHza33SB3dc0WL9RuYKrWWzOfPJzu9m4W9hpTh8LkYgPBo8XC/M+9ZR4ihMZAPBZkrA/rNazVrFcAXTfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785997; c=relaxed/simple;
	bh=mD/7+P4nAx69AVCEtEB7aWv/eT0HRyz+kDd2W0M+RG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1KxYnAu4FTz6qHVzaIRZFyJttHjVWtR48k8afjxXFwYk9NdF1+txUyMjw+RgNMiCzs3Ggf8vthPNII2VkxH8ba8lpjMnPN3VdPvZu5Ub6NMbYc1QaxsEA8CPzeajkA3823sddJSd8io0Oc/0BmKXlU/ycE71ccMT3C0KJn8Bq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycCKgyRk reason="signature verification failed"; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v38qp4mh0lyfHHfYJZ+QDdmP/y3VhA4irCoFqYrE65c8u/RKT//V0vWsc7ILi7ROqzNxQf+JKXXZYEtzPGiqxayLPrYRKOS/MPti1NKgqEYdkHUrnzqMWpz3N1Fk87bS7V9DJipsrSi4SVcoLBh1ICqzYeRCDnPptjJ97TnaENs5B4VYNe5xLFto2Os1HV1VXG1lBbJG2+FzperXKQS+I4CWeRXxAZHwGsoCVmlLE422gS5Nm1he5H5bF9cGK3ZwsylBblFFBIM6k4exF+IG5nh9pIE8NEPEPZug8JtO5NAL3JgFY22wOH7c1OiY1/ibCLUV0y1wny2mOZkmoBhAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMYrrFdqTTJTSBH2L/LTLqmctCOeRJwqFS4NsKw4nCE=;
 b=gvA/LlGD7kpNZUyqqBOcrc89tFPE9k96HhY8hWQkGFK+Ia5wQp7zpDr4UmRJebDjRMYBh8aVXH/69QS3xNIx7w4Ur5MU+ayU3PIGDg98MlrF+Ne6c3hD4vu9zFFBzdQidssNSoIVZU1jxAFMWPk1y9MxmXA30suj7Z6CD9QCJU+WWkNqHr1cw5RIT7E+VBphDYnB8/c5fmrmZsYptlWz8q9B5uKVxYGzmsaumH9SUGC6Xz/bQrPVm/9UFopehIGwXVarrODz0QI9Lhz/UVxPj1UVUF7FixEQrEo6NVqSBWD4f3PUCNkN1tlrKTJnVJeO6/0w+rQovf2FS4pDpmkNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMYrrFdqTTJTSBH2L/LTLqmctCOeRJwqFS4NsKw4nCE=;
 b=ycCKgyRk42t0kQ+wX8Gc52sPJVIgjkPAMyv2mpPUVkmYcpI9CiKFA9J13PWRMYcFfR4yc22q684QcTQNRMxAwKWMo/sVUHaYzCJHBvYj9KetPxBopDHB+3Y5wuyPUsz9R4Qev7IVUZu59uKmPYTEmBFZdFJpVyplayP1XQJcBLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 16:06:30 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:06:30 +0000
Date: Thu, 24 Oct 2024 12:06:25 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de,
	Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 14/16] x86/amd_smn, platform/x86/amd/hsmp: Have HSMP use
 SMN
Message-ID: <20241024160625.GC965@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-15-yazen.ghannam@amd.com>
 <2797ecc5-935d-21a2-bb43-273a7eae3a12@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2797ecc5-935d-21a2-bb43-273a7eae3a12@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df79ae5-7992-4976-404a-08dcf445d271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?t33XFhJNAP/x0tLfsV0ukVnBzA33fmEZ52PM1Lg0Eu3tekV+KylMVT1bwA?=
 =?iso-8859-1?Q?LY9Nphst4kn755yz8iJrn4dvguJ90XQWS8VWywy5mcgsrHxM6hBuu5EOy/?=
 =?iso-8859-1?Q?lg+vE0OFWGO2fxfU/N4eI5LobOTUwWEIK7uGustvk5h/lSO4fSplZaL4ML?=
 =?iso-8859-1?Q?P4Uz3Zz5MqOObvKM0Si18o5DJTxCWXuX6loLPinVMl8wa78fGsN5reMwz6?=
 =?iso-8859-1?Q?bYARAouxnHp7ogUvfQ7GvqtGF7hwzMolCprZ3SsjJ731CUsmQstM4vzYON?=
 =?iso-8859-1?Q?SXUIuhntWPD8QM4/EcO2zGxNRiUktG0ZtQKqNbdgqv0brrXvXrJYcKJjNN?=
 =?iso-8859-1?Q?rJ8scRL/9PyLo/Lc+tseGijmWVAJP0z1yQBgn2ewM2sKGppUbGoIZpMHIG?=
 =?iso-8859-1?Q?uWddv7l2VlJnuowd45Jm8NkHzjjVZSazgJ7u4j23UoDp2qDfM1Tx+ri/nN?=
 =?iso-8859-1?Q?xWJ+Wt+FIUVxOJWyWkAktSbccsXV+6FQ8bM5eXMlKERUXJPJEmi/laexms?=
 =?iso-8859-1?Q?g7w2rtyPGKilfYkSzJBzIojFDP/gFTD8JBJ6sVBHWCOrJlKpZjZVUw/VVT?=
 =?iso-8859-1?Q?iermXp0qx1iXVnwrtbYhAqGLej2HOaEiyjNJIZwLuXE2G3Bzwm/mjQCsAL?=
 =?iso-8859-1?Q?DnxPUH04uqOWtcTy7TlVDRtQ1KcGDmhL2LUL4w5MjfWamKf9y24ihbV1i7?=
 =?iso-8859-1?Q?xiA+nUpQf8cdiDUZxEBIlmw/JyB3v/LJF2Ed+OhLLUqRMdg12oSLvsZfBk?=
 =?iso-8859-1?Q?mm4oJnhec0faYFGTwtvE6GvcVp+ZeWfesYr8P01j936ajvwMRLpqGrY2rR?=
 =?iso-8859-1?Q?Q4A8C6A90NeZu8W69psX6MfCciIxLyD4ZUSaT4sxtIsZUNF/9pWrxGbzms?=
 =?iso-8859-1?Q?Y58Dd/3HuXoArtfca0GFjDYY0y/0/GUhA9syGX1BV+jtqIU1kQFiZ2gwqT?=
 =?iso-8859-1?Q?A7x0xQDDeHnupFbehh6n7KVfZ+8HxyJWTQpGftX0EGl/aJ+H2wVQfj4ihL?=
 =?iso-8859-1?Q?XdOatYUzqqVFeFwZ7M6jhEo7jZEFX+rFJdESaADaWryz0qS/3w/6edOVQB?=
 =?iso-8859-1?Q?gMfPuAvGRuw+hqxvugetk2dCKfsWcKuQew5z0r0C79IAp0MtwYgD1eHyWR?=
 =?iso-8859-1?Q?/iX7IJolRFpECoP6rSF3hMmSAyntaJ+svXDX6dVxwe1+kvRJSr7olf7znU?=
 =?iso-8859-1?Q?RquSg2wC5pYNQq2M7v+5dvh6SMn2v1ieo9YH77a/640FZZjZz01gPUPXbM?=
 =?iso-8859-1?Q?Otk1/aFOOnG/kiGgVjsI1Qam9b+/QLmcgR/+tv0AosHJL7cjalKwMWhGrv?=
 =?iso-8859-1?Q?5kmx5MC10adhnhVKzSmA4TDDFZOzaoCbXZZpAz7nbpKzhuRbKwWXA+6QQk?=
 =?iso-8859-1?Q?3F5ww9zUTV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?cgX/1Umx8hehFUIQGktSdI+B1sEja4fspx1vsDajvJLpnBXAwz+zaGYXAk?=
 =?iso-8859-1?Q?Zotxo2omyG6NhR/4TPA0lYh0FvQidvaOvwApElFS+f0icpbg5FTvmzDZhm?=
 =?iso-8859-1?Q?8yfM6Vun62rON0ZO/7KFHHI6OQpIdqhCh4QZZESa5DurPx+RcnvvetArVv?=
 =?iso-8859-1?Q?bWRDpuc2qJ94aKBkRsyds0P6J9QS7mk5MesxaLXiMvfuXqdlrJF6pzMaaT?=
 =?iso-8859-1?Q?O8TXC6RrhRr2iSTlSkUz2DD3UcE/560L81nAb1ynt3VTRiMV+a0CdL9pht?=
 =?iso-8859-1?Q?9uAJ/H7sj4Qx6U+4GEqb8MYxHOToOWn6PSRoNpXivbFSdgTChtN0MN2+xh?=
 =?iso-8859-1?Q?Ij84EPS5+lE7h+h+WlE0n7LN899K2t5HUaTnaWSMJTCuLjDhISqRhLGUPn?=
 =?iso-8859-1?Q?SC2w5WO6PyylY6ZGRxN5qr83m/kuCjoBcKEkemsbW7lxuL6ZkGs3L2MIQo?=
 =?iso-8859-1?Q?hFxmcumzAjyx88N5kMTxLkFBeEwRV6CGO70+s5I1F9pSmLWmle8qUniKLM?=
 =?iso-8859-1?Q?/jCqkwsVUcZPBWh1GOY2Z0D81wcdQWioVBmR6VmT2kKpNOvqWq1e7NlK6N?=
 =?iso-8859-1?Q?Y48kNEd1hNSSAyQqOyjZ/82yYxdfRJc9n9lLcTqCDeqxM/mMMLbkncEtpw?=
 =?iso-8859-1?Q?sa9ZJyliIvvyLp7d99k6Fr6ykddp7YSm/7V4ozJr/EadSCkuE3syTzhQuU?=
 =?iso-8859-1?Q?ZplNBJ2iYN7Ft2LQFuhLrzRfdC9uhnT3wu9vLYnmUVvkqjE+H+pECw0TZR?=
 =?iso-8859-1?Q?lFunsbW7QlW6+sLFoortwaZT3K3dnXpcB5+TIfdoW07IulgGPfXJKdIe04?=
 =?iso-8859-1?Q?C9Z+SchuzxvpWoaIcgRG/tC9yISv8omX+cfxGNR9r+hhg/11HRbpoguGi1?=
 =?iso-8859-1?Q?9b9E3BXXUeyebY0EnxL1Af0gtg2ybhrRqn44zmzOm4BSPFz5AYR6kJ3nio?=
 =?iso-8859-1?Q?Td9BTHx6gld5Pxp1WRE/8ab1ffZqBz4Le8U1OjeLale7OKTzD0Pf76/hXD?=
 =?iso-8859-1?Q?BbsvxytZx2irUKUSMMbGmcZZnrPE9GFDl0kDgfyF2kRpmMViGuCay8SkT9?=
 =?iso-8859-1?Q?5cqSGhOU+6txtpa4IKGau6wCzh4ydT3kYiU+h28VVQbuvOpgIwzXLxKfc2?=
 =?iso-8859-1?Q?ZtiKNTTj9/GUr5ngqziFL16Hou5OZ1t+prmhrbc3BXmofnCNLGvEV1qMLD?=
 =?iso-8859-1?Q?QNpDe5O50stkxLhgKT9OmcXiJSuwRTjCnAak1YnGL2m5ddOW75faWPhWZi?=
 =?iso-8859-1?Q?VmhxLgcmQgnOwcYeHQFaYc1Prdz2A2funLhgHBd81R7g04SylTUnzXrMid?=
 =?iso-8859-1?Q?wEybWbqm6xG8tnVU86Tf6kalhADGhDGPavj9fNvhy6dvjl4kUZw6VGuHDx?=
 =?iso-8859-1?Q?7HzMRbQnuDXfkLz5BgVDWzrCqMU40V/eCzl7kvW+U74XgkPs3fUer2VaNM?=
 =?iso-8859-1?Q?g/8hv1yjpaQCOqH46A8cws+0eIkMI970Mt5OHeBDwKg8QZNvhan14o0H8t?=
 =?iso-8859-1?Q?BR/6zyQF8kla0lJpG0HBkwtLa6Y3ureGBly6NB2ZCR8xXOo+M1mdJSQ0WI?=
 =?iso-8859-1?Q?JnaRxyIiUCGQorhjmmMFho6VRIU2IYdlw0PiML7wrwUw3W0+igVlbHS77J?=
 =?iso-8859-1?Q?b1z7qh2DMNJqb29TN6Yw6A6ChTAkjM6D96?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df79ae5-7992-4976-404a-08dcf445d271
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:06:30.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llP10+nyLDDnSx3aMLyvN84gs/nJDlRH+zEhEUlxs+n6BJNuMQVkm4XEtgrtjYn+yCawsTnJIVnDrOHXOlT8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

On Thu, Oct 24, 2024 at 04:23:55PM +0300, Ilpo Järvinen wrote:
> On Wed, 23 Oct 2024, Yazen Ghannam wrote:
> 
> > The HSMP interface is just an SMN interface with different offsets.
> > 
> > Define an HSMP wrapper in the SMN code and have the HSMP platform driver
> > use that rather than a local solution.
> > 
> > Also, remove the "root" member from AMD_NB, since there are no more
> > users of it.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/include/asm/amd_nb.h    |  1 -
> >  arch/x86/include/asm/amd_smn.h   |  3 +++
> >  arch/x86/kernel/amd_nb.c         |  1 -
> >  arch/x86/kernel/amd_smn.c        |  9 +++++++++
> >  drivers/platform/x86/amd/Kconfig |  2 +-
> >  drivers/platform/x86/amd/hsmp.c  | 32 +++++---------------------------
> >  6 files changed, 18 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> > index 55c03d3495bc..cbe31e316e39 100644
> > --- a/arch/x86/include/asm/amd_nb.h
> > +++ b/arch/x86/include/asm/amd_nb.h
> > @@ -27,7 +27,6 @@ struct amd_l3_cache {
> >  };
> >  
> >  struct amd_northbridge {
> > -	struct pci_dev *root;
> >  	struct pci_dev *misc;
> >  	struct pci_dev *link;
> >  	struct amd_l3_cache l3_cache;
> > diff --git a/arch/x86/include/asm/amd_smn.h b/arch/x86/include/asm/amd_smn.h
> > index 6850de69f863..f0eb12859c42 100644
> > --- a/arch/x86/include/asm/amd_smn.h
> > +++ b/arch/x86/include/asm/amd_smn.h
> > @@ -8,4 +8,7 @@
> >  int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> >  int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> >  
> > +/* Should only be used by the HSMP driver. */
> > +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
> > +
> >  #endif /* _ASM_X86_AMD_SMN_H */
> > diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> > index 10cdeddeda02..4c22317a6dfe 100644
> > --- a/arch/x86/kernel/amd_nb.c
> > +++ b/arch/x86/kernel/amd_nb.c
> > @@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
> >  	amd_northbridges.nb = nb;
> >  
> >  	for (i = 0; i < amd_northbridges.num; i++) {
> > -		node_to_amd_nb(i)->root = amd_node_get_root(i);
> >  		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
> >  		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
> >  	}
> > diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
> > index 997fd3edd9c0..527dda8e3a2b 100644
> > --- a/arch/x86/kernel/amd_smn.c
> > +++ b/arch/x86/kernel/amd_smn.c
> > @@ -18,6 +18,9 @@ static DEFINE_MUTEX(smn_mutex);
> >  #define SMN_INDEX_OFFSET	0x60
> >  #define SMN_DATA_OFFSET		0x64
> >  
> > +#define HSMP_INDEX_OFFSET	0xc4
> > +#define HSMP_DATA_OFFSET	0xc8
> > +
> >  /*
> >   * SMN accesses may fail in ways that are difficult to detect here in the called
> >   * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
> > @@ -100,6 +103,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
> >  }
> >  EXPORT_SYMBOL_GPL(amd_smn_write);
> >  
> > +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
> > +{
> > +	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, value, write);
> > +}
> > +EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
> > +
> >  static int amd_cache_roots(void)
> >  {
> >  	u16 node, num_nodes = amd_num_nodes();
> > diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> > index f88682d36447..e100b315c62b 100644
> > --- a/drivers/platform/x86/amd/Kconfig
> > +++ b/drivers/platform/x86/amd/Kconfig
> > @@ -8,7 +8,7 @@ source "drivers/platform/x86/amd/pmc/Kconfig"
> >  
> >  config AMD_HSMP
> >  	tristate "AMD HSMP Driver"
> > -	depends on AMD_NB && X86_64 && ACPI
> > +	depends on AMD_SMN && X86_64 && ACPI
> >  	help
> >  	  The driver provides a way for user space tools to monitor and manage
> >  	  system management functionality on EPYC server CPUs from AMD.
> > diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> > index 8fcf38eed7f0..544efb0255c0 100644
> > --- a/drivers/platform/x86/amd/hsmp.c
> > +++ b/drivers/platform/x86/amd/hsmp.c
> 
> FYI, there has been major restructuring done for this driver in 
> pdx86/for-next.
>

Yep, no problem. I can rebase these changes on top of those.

Any comments on the general approach?

Thanks,
Yazen

