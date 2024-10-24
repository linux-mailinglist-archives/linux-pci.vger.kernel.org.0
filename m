Return-Path: <linux-pci+bounces-15208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D049AEB52
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4473C2856C4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC31F5825;
	Thu, 24 Oct 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XFMntVnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066A150990;
	Thu, 24 Oct 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785732; cv=fail; b=aM5jQId0hY+s8X3Fk7MPQh1Q6/Y9SsDKLHAqudnmEbcrWHUrtJNQQTkcOd01OVmM5rsUmKuKwRRmfms9KEGt3i4KU9gYlmAd5jvyHgFOoA6erst/NFI3MZ8RjeJrF/L0+no5bVbuKh8cuDGNVOq9z/a0CzVZkNYVd4KdB3csg98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785732; c=relaxed/simple;
	bh=+Q7kfMNg3Ua66sMItcdRwd5YVgZLJWIPe7ftyLj06Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFTxm3kNQL3fx8nNFQuFILSHq95ui33Sujq6ky3jXSpOc/nb9siR/XT+UzCbvTaDjtFziEh/2utVMxqNsXNhauk0n4JrbBjB1JxuuaB4G3kuYWfcWVD/fZUbrJgcm4YNf0WGedw+3VVzfJYJpJPkgVSDGakzf5b8j6jOmT8rIT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XFMntVnW; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T++8L2pTifUK0mFBdGQS3qKaNheNN1moc8jXeogDCAzDlS5TNS9pQn1HF1f+90Wjb8bKDTBhH2BylKzpHSgZayjSYx9pfsJtE+Cu7yLDVXiAKPGBDfJ9nrl759cRklLCBXPgcSRN/bXQOxee9/DAhcCaNeDsB1UaLQReOqdxVYpT5x2ESqM6K9THA4Vz3Zeyzmw54+qRU+bnIISICjBp1PDa/QaelgPoUPVbC++haLESj0YKgCgZM29bLvL1adufJJeqZ40UUfN4tMOT1UgulhpAjibfyMYeyK/sg4/A0JWgxHVGBqOEDxCYrYGWjxIEJwv8HyAp0JLx8cCjqYPWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaOKcSQUsylbbtB82R1c1BNDjEDWimLLWzKdlYFMkak=;
 b=istzC3dv2ca1OexGr4hAOPElAXi26fHLrD8Neyop7ymmJBJMyWUYVqvFlky7AHtcuJDIEoKiW19zB8T2LAUxTKExDgYoKTRNJb52AwV9/497uNXO/jYA4CuIX6wgEdykCrIc7AJiRM6ACOW2Izumjd41PITlaL97VDpsRw5+tzgpRGzvVldnY5+cPaLfZYsCHq9j/IKlpLunhdvTraORQTNU31fyUDEZKY42xkia9XMqlfj018OuUDEMXVA3tTHOBrJ0aLOAWRHsRUsIXS+rjTy1oWaCQ496g0jDswvNiM+9AghMrofoZ67E0MVJ0dKX7CCTKrXiOyp4ae8Ph3eNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaOKcSQUsylbbtB82R1c1BNDjEDWimLLWzKdlYFMkak=;
 b=XFMntVnWxuZpCp97dTomD5NhvQsS1o0R7I+sCcWZamUPIEyaOjCRvlqJzCwed3yCvgMF5DNESnK0XG5BFlWEiPQQO2KPz2eWcFqH3icT/cVQfnPE6kzoC+4KA3jKPSnDRPhUpkUzUYLQmuuho9L5h2innmN86zVQaDWu/Lz7FsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Thu, 24 Oct 2024 16:02:06 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:02:06 +0000
Date: Thu, 24 Oct 2024 12:01:59 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241024160159.GB965@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023175928.GA921475@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023175928.GA921475@bhelgaas>
X-ClientProxiedBy: BN9PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:408:113::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ed2e2b-bb22-4b42-9771-08dcf44534ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVnKq+iVnvx6/jXSm6/a3M/jaXTu2W8lNPiv+EuO7fjfVPBbcBSNoXZWGE/6?=
 =?us-ascii?Q?A5sTHcrMrmJFkFeh39jTxBu8Q9mlFk/AIAySxhXOeiNyyJoJO1ADQQ/u7ryd?=
 =?us-ascii?Q?Hu55scjANWJA48EBL0jb1eZ7lppc0aFTo+lAGtwLeKjakwfN4wU0Wu/aTP5Z?=
 =?us-ascii?Q?SWI+bZzrnCUvFYoDLtZfUhWJSL3k9GFupH9Xfct5MzPj7BOnkRxT1wQMpO2c?=
 =?us-ascii?Q?Tq3hZVfJFYddYshczU8TcnCa2N6tmUK8E3QtscVS4ADtMr/4+fi5DEfGzJBq?=
 =?us-ascii?Q?Y3oPW/ys1GsW5tE0UjBJZDs6TSZDG231tuX6C6sO7/uiutVXwLWTwrlOGsnQ?=
 =?us-ascii?Q?Q/LGMsO5Q3XhTtUgipjdeY7JfCsxhTA6qyvTzT9M6WGPBFOSp6geGSv8IdBj?=
 =?us-ascii?Q?4cOhuGWM8rUkj9y7Go45pnPaP/la36Rvwj6qWdOo+va97jjSUvKrdBkrkFCC?=
 =?us-ascii?Q?f+RSNm/cbKRKaGfUmd+rSGc37yrfWdtkks+72xVfql3uctpiMHnA0bsySfVn?=
 =?us-ascii?Q?cUik4siUazhiHMZ7qbg99tfCYPNpSVCPEcIs/9dTAidvSCq+VmjDyEIcpl6E?=
 =?us-ascii?Q?9LiF1mScBG+BZp4aLbOHTRfG8hGFmZIjdmTl+lLJ5r2YHcrS8p8z0qEuK0js?=
 =?us-ascii?Q?DlfDbdG6G8uup/P5PvKGx8X2L5UrWvAY0Cv6PbbuyChH+JBr6tkiafU92gNp?=
 =?us-ascii?Q?NFHhpjtx/SmibTvQyEURWdVYIMF/qGiW3CGwg1CO8KBIeJpXr+22V3jP7VFT?=
 =?us-ascii?Q?KvUnKCzD3zHcI0t1ZLlZs497MViJqBZHKvG96LWin4gsTn2ZXiglvz8Ge6fw?=
 =?us-ascii?Q?0BuljOSe2Fv33+v6Mlj18lWHLhiZqy1wO9PwQV0QqNCJ369N9EPsRXddAv/u?=
 =?us-ascii?Q?yu6Ean1+4t4v0hMi1Mrn70XfGkcCzO4YJXRbWC59sMfsnBQpBWnVylh6CTi1?=
 =?us-ascii?Q?cq8EGp0toAkHjl1PFiNQChEV/ncPZNMpxkHpBcP4XbYnpYpiP7dkEXlhCA9d?=
 =?us-ascii?Q?NKP67IJSt7jDe/h/WwYALYQv4y9UHWSLgtD43GlNtNWVr746kXOGCfsUYYRE?=
 =?us-ascii?Q?wklI+FCipJN32NAMDK602sKt/aF2yX+WBzjjPfpcVUL9rwdoFBfQRFMcarrR?=
 =?us-ascii?Q?pozLElXQVT+g9SdZ6iDiXbHpO94Sb/fm0gacQxbnIOR8Wqnej5WBr8kaxUnc?=
 =?us-ascii?Q?Z7ep4eadjdwgyKxdbLU+GgKjqBl/TC01rn8hE2kGm0SRATOJjoZWQ9pmUJwt?=
 =?us-ascii?Q?/T5bZ5RMfNmB5J1NpzUsiU3kV152taywg5q7esP62oSj+DMCBewSmZaJO6lV?=
 =?us-ascii?Q?bkTVIlQGwFAewyt1D0u8ayiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VSwWUnTKHwnWrz0e1243uyqdlG9kyDwteY6s8tyJQqhhsZG+0O3Smrpjm03?=
 =?us-ascii?Q?9SrD1DzpsFuf8nZ1IcEJRw/4LGkxmpjC+PGLjqXRgRoWP4t5Ab/CTFJhXYNd?=
 =?us-ascii?Q?0IWRUE//JOioxFrYZVuV2LMmy2Vg4MwiEqiA9HCNESRvzNXvTIR1GxWz3hFV?=
 =?us-ascii?Q?SMBqjeeWi4VG9/edhZis9xxZvWI7Il3L4c5G/HXqqA1mWHGNVoLWbrTLe2aw?=
 =?us-ascii?Q?WSsw7pxm9Bo+IkhbC5qBkqodW+WCNHjQLCf+kOO9aPZeI9+cybG9TgUdVaoi?=
 =?us-ascii?Q?UvXiMQODZ4arxw+xqYeEOaiUmXcvY4lUTWlskGFOEVg/j6yTaHhqWQpxHJft?=
 =?us-ascii?Q?MOs8MUp301Ie1Gq9u7mu4ASTIEFrNtRGdPHIEtdR0C1UKotYGIoybbqVp0lx?=
 =?us-ascii?Q?s3CImcgoOHDVTlUfKy8nj7lhfLpatI2GIHZDs2OUQZ1+ptWpCP03QezSoYo+?=
 =?us-ascii?Q?UDIISFxarG9IBA7HxvAed83dZziAEV0wMCKvWg4U0l/b33MUtzUZxOat28R/?=
 =?us-ascii?Q?jkAuoRjx5ZkF674Cfm1U86241iPopPFSbM8rqUSE66xWNsCXl63hfPP7ugdr?=
 =?us-ascii?Q?Z+GJ4nif5dux9/MIdYiD+o/R2IRmw5t0Cj0H5z81fqKkFO40tPfWjCv1XjFv?=
 =?us-ascii?Q?y3zJtDYJ1tjOjf3XxdsvjXJ0C7ellB2whvP7NHgkj+IqkjcGbX6oy16gm6U0?=
 =?us-ascii?Q?EK79rbpgdQwBPRlKtogdX1GkK2Rl88k+FejZCyhVUeunOCzY4FPGIwVYvV3b?=
 =?us-ascii?Q?gZHmfjoMtlrktgUjFVLkXrOPM1PvtLlmz+PF+2F79WLsLBMQ1Cyk5bZW0HQn?=
 =?us-ascii?Q?293G3IQvVxeBTBAZ0xUEHF9/dYzNMnKuxlVbdUO6KiyGOAhRVE/p/xdKeE4Z?=
 =?us-ascii?Q?VsuHdyVRjXiOYAE9DTG37NCyJmfBrXBHR24Y54Raz9sMNZNP9KpUz/ENIAZK?=
 =?us-ascii?Q?tW4qVmtIT05GUikZaT0biBqBrvSFZPIAQaD8OJnyIXNKknYJu8avcNdbkjBo?=
 =?us-ascii?Q?dVWbr0yjiZ3BTpfnsjrNZLNYz7mHPZO3Lrz/95hE17zvzaYboMbHHkVCna7B?=
 =?us-ascii?Q?8kz6y7OPDbfVEFMSROqu5qif1NLRXU+I35uCD3iOARgKjchB3LICraW6TQ9Y?=
 =?us-ascii?Q?SirF9R0fHqYfD8gGsw1KDwpVAq4+H5OOMjX5MLjnvizuDGBgYIxGZX4yQmra?=
 =?us-ascii?Q?clKstO4Ul30zuEFCZ8uqOaGWRDB97RHCKQKPLkSI1zClVc3VBfASVAMiCctN?=
 =?us-ascii?Q?9ynk9HJswh6xul4NH1HobU2ugVTC8Pn71gXfZyTtBJbvFCJZzVlmefwBX79T?=
 =?us-ascii?Q?nW9tJIXppZC4NGVJDeMHPfPfcy/SPJBWk6f9KQBqbBQrqsXJC+UnDjEbA+5t?=
 =?us-ascii?Q?Z/uj1Jm6y4CVuMC14iu687TDY6Zxt7/avlW/FDwzFGz8FmSm76mg0RZo0dze?=
 =?us-ascii?Q?YzKhmeSfKbFIPZ5vTP+cpcelOV5NaWDjBsppcL1WNkMOxxAox1a9SZeIEyk1?=
 =?us-ascii?Q?wEmkrqDxgGz0uhiVnkj41LkLju+cEd1qSlNGwCLFdjwYjKcOghxfrHdHpoBu?=
 =?us-ascii?Q?8Q02x8UxPAROHE4/kp1jG18rE/SSEwHmnC7xnXlC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ed2e2b-bb22-4b42-9771-08dcf44534ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:02:06.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS/XzRTwuguyCih6SqBETr6R4MD2hqMRoSw+tWhm4NmyKSKz6W9aS0yF6AzLJQ7GuMrBlIhl5HdibZYD7mtKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> > Hi all,
> > 
> > The theme of this set is decoupling the "AMD node" concept from the
> > legacy northbridge support.
> > 
> > Additionally, AMD System Management Network (SMN) access code is
> > decoupled and expanded too.
> > 
> > Patches 1-3 begin reducing the scope of AMD_NB.
> > 
> > Patches 4-9 begin moving generic AMD node support out of AMD_NB.
> > 
> > Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
> > 
> > Patch 14 has HSMP reuse SMN functionality.
> > 
> > Patches 15-16 address userspace access to SMN.
> > 
> > I say "begin" above because there is more to do here. Ultimately, AMD_NB
> > should only be needed for code used on legacy systems with northbridges.
> > Also, any and all SMN users in the kernel need to be updated to use the
> > central SMN code. Local solutions should be avoided.
> 
> Glad to see many of the PCI device IDs going away; thanks for working
> on that!
> 
> The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
> ideal since all those pci_get_*() interfaces are kind of ugly in my
> opinion, and using them means we have to encode topology details in
> the kernel.  But this still seems like a big improvement.
> 

Thanks for the feedback. Hopefully, we'll come to some improved
solution. :)

Can you please elaborate on your concern? Is it about saying "thing X is
always at SBDF A:B:C.D" or something else?

Thanks,
Yazen

