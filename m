Return-Path: <linux-pci+bounces-15531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E89B4C43
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD77F28463A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF28206E79;
	Tue, 29 Oct 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdOmWQe5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197520650F;
	Tue, 29 Oct 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212779; cv=fail; b=A2kv8iTruyNiG15scGJBtR2i/gvtfgwaJye9Eu0c8l0oKk5D3hESXPUv48fPPR42wm2U7lTGord2oBIuRfiOow+fK7hOvxFGJPyzElv9Vxv6lQgFCDc0UOiiGS4JJDcIbRe1YCD7ARcwGovrqFcPpuFj58wz/8XSkxtTe+n9D3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212779; c=relaxed/simple;
	bh=01HUlmMlADdulQdTpiKwPgz1k6WG+oFYR69O0kJoiZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SpPosYvakMo2nVdNTSK6T9Kb8IYg/6KP8WoGWCVEzE+yXrxtMeaxaJ5VDFBDOokivsDPkm0hyDoIBOWrGtDmr2vbhTmDaquzkm05f8LVD8aiSixDryogIQUsSkoGAZCsGl0yXpQ9MoRl4dbSnstzbsMwyhEcc3zYG+LKOen95oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdOmWQe5; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWD8d0IqNauYdawWRpssGcVTIsh/iHkIXKfHLbRq/1MclmMKt8B6mUxxCqgszb8PMsZQ2ahTVa8ByMcnSUNUBeWku8UwWDWC7hmgPang2jTwaH6IerlMILR+A4ZNDzPXcDDsx//7xiksOf8DA5VfelgJ5nmeGaHfnnp5yY0sGMECMn0TZxw6tXxU2bLkTVtNNwKuEM9bxHl/vKILj8IeCT5Ye5MVo6zecOh/puAWaVzKgCEkvrfdizrA7R6RyUgbmKxyNhUrtBBLeF67Gd9WCyQTbL49m1/6yiiqOjOqwAxKHNwCI7HEdFI1I50ytCkZzhtq9lK2mOB5YMcM5VX7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8RZMCppUQn+3gnKkhtXgW3J1/J2vF9/DpJ+bHHdTro=;
 b=vhJHL3AViufWXhJuf1Xhw3aAlg+ge5KbH1XpaM9Yvv28wlixQdly2gW0/Rz6kbGa5a/dlCeMM5Z5Gp+rKA/cIg5Bg9o/nyjAlVRwm3B+ww0O5JQTC9b/UETrWMd4zYec2Vy/Q6rdXkrVFd1LmzU2TlAVl4RUjSPob+Q6f0n9T5AeNbFuPv/AI659IUqfNPAw/ZYunrFteNrg9/ym+6yeAY3vyG7iMjpgua5mjxxGMxVffjHQNGpJ+vP+FbelhJDxBkgbxFHW6qu7vtedqaPjsprA5PC1syKDGZCvk3zYoT7VFzWLinOZBrPTJ1e9JMOa5W8ORmOUlBGI1p4mTLOYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8RZMCppUQn+3gnKkhtXgW3J1/J2vF9/DpJ+bHHdTro=;
 b=mdOmWQe5wX6pukIGKrpTagBAJg8Df8c5P4b+bXKHRXlFafCssFYByiV5Flz7nHWOZUTAKLJ82IYgd6GTEWkYn/eCCiGUWAiQPkXVP72w7aix2kmnjbCt5oQH4xujojeNNSAQxZm3McuinBAtwGuqpLC5bEw4+zAgJ9d/youbs5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Tue, 29 Oct 2024 14:39:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 14:39:34 +0000
Date: Tue, 29 Oct 2024 10:39:28 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Message-ID: <20241029143928.GA1011322@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0519.namprd03.prod.outlook.com
 (2603:10b6:408:131::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 7185f757-a339-408c-666e-08dcf8278147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9h2iyYbQp7Ma2X09w8t3jUJAOZHMDuKYohw8Ee/BDoDmpZIBBEaBgfNLYcr?=
 =?us-ascii?Q?msuJ5HKQ4H68hatt7BdSXqGveddCpHQozD3up8SzAsxDwD6Qpp7yp4xuGxCz?=
 =?us-ascii?Q?MLygjrKryv+pDBf0M8pqMs6WJ7oyPP1Jm40Uz7N+veLONq3dwqUTBN9KnRT4?=
 =?us-ascii?Q?5Fq2LWtFEj4k9QlLUyhUG7qc4TJlA69ZOajic5x26UadkuAi03CZQQG1+mMS?=
 =?us-ascii?Q?uPLIXwWIDB6r1KI6uKJ18RCJ0AQyawoccMcHPc55mZvAF4fPCQf9P5QWATpt?=
 =?us-ascii?Q?LHYpA9Ccd7ompbRhdZD/noVrKU0eoNObqzcVgu/OtzllhhfW7qcD9aftE4D0?=
 =?us-ascii?Q?g9kG1X+UTvZEYdEkU/zvvkjWukEZrnySR+w4DOH4RQ17mg/SUeB5gEgipW09?=
 =?us-ascii?Q?bzRimKp8LuUAA7OhobTQATyK4MpMv+6ctUjBFrBXsvaH6k0wWGZMvC9uNGph?=
 =?us-ascii?Q?ttyS7A3sMW2Ejj1dgDPdC5nicp/vM6fnk6jg+X5Xl8ckAJY0+t0jNruiKx+8?=
 =?us-ascii?Q?7Y3IFCjg3djF4CLKsfpKXzQWNqbmMgHTWqO4J7xYZcd77WUYc0dgH5Gd4uvY?=
 =?us-ascii?Q?k8S3HRyp7c6CxkEHjK4c3145f95hue2o03CiwRBOToCmpDyXpSZwsOjZx+Nq?=
 =?us-ascii?Q?edLkNmbLlGAr19sRkn+jSB331PRm/8yszOnOxCrUU0MDrxMfTkuxCijPiqQk?=
 =?us-ascii?Q?Pc8T4VhFddBbx3PRV2uDRylwslT0LJ4bTWqqsfOnnQpxw3J1TXOwHoaYyQtt?=
 =?us-ascii?Q?naVYeNOy4Z2LDo2G8sDSZk216GI/RXmibZbkhTBk40ilYvoQoZ4FoPkdn0w/?=
 =?us-ascii?Q?tuaTjycLkT/t9Tkq5carhtucGRYc5fC9vCP0s2vFyFVzxtitca0nYyMKFh7f?=
 =?us-ascii?Q?exdGwE/LriX4nn4MO7NXpw8gg9Wb6OnJ9YQrFLe5HS59ZO85Kk2zUsf9cDvb?=
 =?us-ascii?Q?jTHPL5snEGFCK0cX62EhTzIMhWkwUNnAxqblF8o/3kVFNWMStX8QDDLsjYgr?=
 =?us-ascii?Q?3vGTj8SnWT01ttjdtP4hAqHZnhMrTjBsqmEBgvL05/cqwRJcIMEQZD9cjUDq?=
 =?us-ascii?Q?y54G+mXEpID1q6uciwpVbXDxug4K3Nt+VCqVfaA/RDeVf40Blo4VSn56as2u?=
 =?us-ascii?Q?juWByXb65kslkoKk3h3BNW1rhEsv2K8T0UqU9gU4zcwErbbGDcQZhlE+8qGo?=
 =?us-ascii?Q?5/kb5nJ4pu4boa6lLptKWhf8ybI3LMNAPhEieMkUu7PutvqQIB0AFphIXWll?=
 =?us-ascii?Q?Pe78dHswSPKE5v3maORSUUwrHM7GHLDBvCO8cqQXC7ff2OUi1Z0y50Ez8AGp?=
 =?us-ascii?Q?VWoGuMkwE9+o+1XyCNG85Ohq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDUUL+dS0G3n51bCWC2bPr88LajVH5BaCUVXSu2bGn3Ke7dPkA1ALlM+fBWV?=
 =?us-ascii?Q?8erdnPVaktid4qxRn8/zMlq/h4yyywImAOM1ZsCGYgL1CCY8vAJ0BLswSZIx?=
 =?us-ascii?Q?yqxs7u7wtnDR3al7pOFxWFPRsS4zVYeDrRuB6Pnz5ilsklVbYilXaynEswVR?=
 =?us-ascii?Q?lnnXLJyzOh3YH/PNgurkAe4SzE9kJs56Y+aFTNPydAfiP3r6i+HM7ztnhOWf?=
 =?us-ascii?Q?AFSLqDlNtPp8K/hM9LRpI87ebYFMVY1GlG9MD15cUVfsE/mcc+nMD9zLSqjD?=
 =?us-ascii?Q?xjdZX5v9jGlbxItfKRpqwZiSkAPYfyGmlZzr02e7pCKoSEMwvBvJgZnIfNpp?=
 =?us-ascii?Q?q622y/wuMYQ8DLfk8YrlNc7LSq9jS2bit839TDlQDQJcqUk7qcBpjzSmzGlh?=
 =?us-ascii?Q?NBplDpuca0PHwA8zh4ZsoJ8jAxS1XYgQ1gLTM10WkjzKHh9QTLIGXeH339Dv?=
 =?us-ascii?Q?Q+dfvHNIlUJSOmWOeVLNbDJFqyrz63ozetMcQ44aKncnUPMrlbxicSP3Q45k?=
 =?us-ascii?Q?WxRspgrLVzfna0zBv2AYkXffBUFClEETpahcbrOBHZO9N1aMw1BdlLQNXizf?=
 =?us-ascii?Q?mZWeeXcgjUOtex56CQRzq8bYq5tNhCQGyVy52zoCg/46WDNnJbkwDR4644Ov?=
 =?us-ascii?Q?H1woA+YMopC1tpnCuY479ld2y4NfUguq8u5XiKbHnq/+Q3wgkO4JsWXKROIs?=
 =?us-ascii?Q?3MUsxXnE4WQpeZ626cA4X1myh3hOjDTY6KDG4BF99VeNx0u8IzlWpNJkSw44?=
 =?us-ascii?Q?ocsKGHbYApXzpEvV5AXNeCV7wqRPbYyMnFRt7jJ8jR4uIfTWje4IibFvTToN?=
 =?us-ascii?Q?fwOxc3pdHp+QDQvQRiNcSp2Nn8sY8caLZjEidUay1d6CIFrQC2RW0C40ydo5?=
 =?us-ascii?Q?SCsnSEwCfpaNMzf5LzzEC9s99INW4cwhvALOAlzczdtteWeOjrY4W0gDqV0M?=
 =?us-ascii?Q?n50sn/YUQBc1azrTVSZY55PxeASAmjAXRDp/LCo0D8h1nbITJ1xGb26953on?=
 =?us-ascii?Q?GuBdkOH/cLNfsNZaVKlokGf25sdLzTw4TN6twFuKxzvX0c2qEdohXQG+EpM3?=
 =?us-ascii?Q?aZKSWHBsuGNIZnIkyGpjcIVdf8/1M7bc4kTaSTQCi6/C68XjEGRQzu2qdM3V?=
 =?us-ascii?Q?t4FtikevTDK8xm/VrEqyLQm0TKLepw6BC1+y9kjhBPfKNksLysOZnWimS8wI?=
 =?us-ascii?Q?Y+eEH/LB4GU/hxEoYQIOyAx3wLtkN3H9Qfns5RzptPvoFa/Kt8gTpHujNed8?=
 =?us-ascii?Q?LDrFRA7MzohlH0Y/Wr6i6SBanMvLkJBqewgVTLOVtV0N150zanL8BI+PDbko?=
 =?us-ascii?Q?vnOVwJW53OewVOqAy0aVdBH8c+9UTDA1WyzJrIiR7TIWs6ydcUFpGEOzlqLs?=
 =?us-ascii?Q?HrcNuCfQ4K5c+j4e4ruG+5ZOfkGIyJB4g7D4KiOD32dLSJ3Ip1Ob8SRr8jmp?=
 =?us-ascii?Q?XdYRu1R60qRojt5OXBU7NHZpx/Mc2mmidWJ6l1xdsX/leiHhYuZJtMXwLUTB?=
 =?us-ascii?Q?ORKDyoklrLN4zmX8eaQpM0GIqPvwg5SWkBZDO+lAeo3DobeXfB9pGypTaTix?=
 =?us-ascii?Q?p6iNHHqwMgL57Ewpg0LuHVMtrnh3y8hUjnujh4nX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7185f757-a339-408c-666e-08dcf8278147
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:39:33.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Br7KpIGhgVE2Dqx6oFkuLxdAvJYRWpatBKH391vTSXa9o94DSkeGOUkJV2Ct10MC3oLPJ4rIeYvWDRf1+VT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

On Fri, Oct 25, 2024 at 05:58:30PM +0200, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:37PM +0000, Yazen Ghannam wrote:
> > @@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
> >  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> >  		return false;
> >  
> > -	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > -		misc_ids = hygon_nb_misc_ids;
> > +	if (boot_cpu_has(X86_FEATURE_ZEN))
> 
> check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_nb.c:395: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

Sure thing.

How can I enable this check myself?

Thanks,
Yazen

