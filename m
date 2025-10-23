Return-Path: <linux-pci+bounces-39187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62700C02DD9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0859F3ACAB9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58084CB5B;
	Thu, 23 Oct 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFH+7o56"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7C2AEF5;
	Thu, 23 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243366; cv=fail; b=kY5mXul8BPeib+tbHEzfmMAt5d3ZV90UQ8tdBPhDO654aWngPiDS0vFpYqb64bxeiLE2/qztGXT4o+W2L9ntLNQQEzPegzbJHxvBvqQzHFuY9kH+32e4Tf7kub5HQ++9n7/dnEUg9nW2WAEPQy8hBlxfLOr/LF1dDtbhUuGexIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243366; c=relaxed/simple;
	bh=NXl1tqAzbN62hVjNDykYMOc6GT7yob3jkNc/1Z2w0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pkmPJ4lK5qFZzORinS/Mjkt8EMNryyD6QQu++fCQnMp4tkl8oXjNbY/zzlZLtMxdkjpPzRwst7WythjWQQQuEStxdRrxEExLRyduilhM26PjXJ0VgJ9TqeoAiHuXpkbo8ZRvs/oXsRk8mjSrnF+26PAufLvEDo3AgkxZqpPrUBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFH+7o56; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsygzYVNAYog9bNnzA6Xst/2ccurLx2ZkYYIlfviwBu3wZ+cs9vUO9Ywaipz3fOH07zwRJjtUQuGJ6opHdkf60ZvP9nxn7A2degxphxW2BAuYBL2cNsxohlh+KSdu6V6g/KZKSC9y7nkTUUNanVx6XkCtwe+l03GiJgo9Nw+62Tb5DdR7ZlkKvtW+Ju8fB6hA6+lxafZ+++ajhokUDMbjggblSWN9ddH74dShJs4CvjePCQs8Pk67qB4dbGRv6lq2i7wRKZJIaba1Ii2xIzey4oc4QaHvWp86qVOPOabue9Bg/D1P0wJmMUpGEEJMcxwfstmCKCIHeuFBdKZzJXu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bClsseVMjGhmuHNWv6ECfYPSlSTuxPacMe8/fJwOfO0=;
 b=sDW9qjpjOIxiA+sMoTv91zetC86M228eLCQ1U+XawjUhc1Je9hxpSJDYBAOarHqJDYu3nAfNxOhPj74ubJ1EmPWcS9DH3XOYBiBv9miNwEIo4EiJB/6kne7VbKKGIuof4orfnZp1YWwgqNtAuxU9jsELm3bQRc+5ocIhBsAtRrE3NyXGGYPiaTojokTiwc6j50A7i/2iN9dNkvZ3CWe1SQvagnmkOmiUoAd7dG2Cb5T5g7v+Q0y0YbQxutpjaZeXUZjC7SHthi6TSSS0WPbAeQwZh+P7wTSM78hRF6AZhjR8C4yj8ayPJka/QBSLQkNcInJfBIBsenmWBAPmnDWlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bClsseVMjGhmuHNWv6ECfYPSlSTuxPacMe8/fJwOfO0=;
 b=kFH+7o56zn/z/eKeWieHMPn5HSbmCn4zUwYW1kRePjeB5TfnhiFb4ZMyVDFAKiASTAUmQpMS7XNcJ077K+VoKv3v7gw0uQTkoq8VuwriPDqKYn0rXRe1iYysUeHrHTC74tQdLKqg9ybhcJZznHxte1SV3OI2XNulEpGElLsVHzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 18:15:56 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:15:56 +0000
Date: Thu, 23 Oct 2025 14:15:46 -0400
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
Message-ID: <20251023181546.GA771720@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <20251023183154.1e807af6.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023183154.1e807af6.michal.pecio@gmail.com>
X-ClientProxiedBy: BN8PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:d4::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c460ab-8ec3-4cc0-5ed5-08de126035e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jay06LuwVQ9kk4+4eFgsV/0l9+a5TU4t8K3zD6zzmz7THpRCvSxWvMQdiQv?=
 =?us-ascii?Q?Y8kphPYA9rTRmsrElhIB5Gu8GF+hQGIdMzS3g+Xoiuw45gRFPWpGkUcwqQQ2?=
 =?us-ascii?Q?o0XDmSXQSmgZS0EvQ59Q0vDbEThiKHuir+MarWUekEXTTLYIBBWbfw9UZL+F?=
 =?us-ascii?Q?KKjs0QzVYUu2mqpuzwaq9MDH4VQa5Ht00uJ0J6NPdaW1/kmwrD6s3GfeG+ku?=
 =?us-ascii?Q?2EBbOacGBZ5NbtvcqeItXAaADlG/WBwQYamPzYhVPzeN7LykBxihYEXkQ17G?=
 =?us-ascii?Q?26ujWlHzOfTBS4EKhb5VXsvkzS+thZ9c5w6SVreC/rKmSu4sVOwfGQZcGkeL?=
 =?us-ascii?Q?xCpEhhBTq66JgcXbhCfWHq4cJLWLkVk5H7AwvlNfkVWguzmyrpA0WP+2S9qf?=
 =?us-ascii?Q?nXTamFBPWyzIqPsc3R1zC5ARUzLVwz63rhTxQNXC6u3z1vFHBAGkG7AURz06?=
 =?us-ascii?Q?PsU1f10NB3LSwTAQ6wlA1hwMciLtGorl/zIChmfV6cGGtrEBwMI6u1r8/9ch?=
 =?us-ascii?Q?PAhrdQ71U7nwed8yc/lJbCfQCRhLR7gke+ymEFzVGfRdA4WHZ2E1PIeWVSDo?=
 =?us-ascii?Q?K1gWnE80o/XCml5j+CR/2NlVix1adr9OhSTSCgWX/ceJl2QxKAHFUZiPe8mZ?=
 =?us-ascii?Q?12PQwwT/WEOEJKE0CFmU83QqugyTPtV8tCnUwnCwl632LuabUnszqL2S/Ko1?=
 =?us-ascii?Q?egI9URkmvMey9zpkjG1XOkkxXwdwMBjMdK9i+3umSZOJSuCGUhHpPl5zhI0K?=
 =?us-ascii?Q?ru3oYfknuWSkNAq2hBbTKUcbTG1cMRHbdcpRoF+rmSHwwuD/6xdxa07Bzpeb?=
 =?us-ascii?Q?lFWWVNvVOEdfKKmxR0FePjHS1OmlL3JYfYm2KANtvq+n3GwRXeoqtr/P9Pi6?=
 =?us-ascii?Q?k09CRxATs7s5o7ufz7LFOuMcXdYx39SG22Phkla4Zf4WP9ym2MSVThGPHgfh?=
 =?us-ascii?Q?4iitvHMc/ZQracYkI7dkMe/shBIs0wCxwF7FiEjguOUZYktgWylOzYwWX/nb?=
 =?us-ascii?Q?54qQcyMS9X7z6S7mEX8aR3AP5gNJsFf6ukS/2iQUAgWyTHj02pMFBUs3J4fr?=
 =?us-ascii?Q?TPMGwg84MBG0Jn2nr2Adef9jUdjQhqzGSNpJ5VAuiPgX7Z4N2h1CtykWJaXC?=
 =?us-ascii?Q?bBpcck2MCAONtxmM/cfDPzqWW+zoX6Otd/G45sr/NrWW0YroRhsuJnC2tudv?=
 =?us-ascii?Q?1RPeM5i3uZ0GuJ2SbrKh8JEU1Aj3gWIy7KAMdxmTkxUcxxRIMKoq9uhJLH9u?=
 =?us-ascii?Q?939xNcbuYSqfYLvSrzOFbFC8HZysuq9VEpECl3wuFnhFi6yp9KO5N04HJ/29?=
 =?us-ascii?Q?7nkO468drSFJjJYFjuFdXbqcvaNUaWMTE3pJFsJJIxXXtGxDKQ02SOoG8IOT?=
 =?us-ascii?Q?t0LGyeoX3dnTrJEDxwMAa70AJ/5/YjwQ/9C3LAa/BYChSTomoJIy8TYUwRGo?=
 =?us-ascii?Q?5QwsW/jGU1QRVxo1puFq5Pdp8UswSj6q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4r7o5zca16Ai2CcRZXUUnkkKkbYKEPJeWowJkvZWYM1ivWa9/r526NyQiHPk?=
 =?us-ascii?Q?+nRpvsFSfo3neS7TjujQxO29FOxM383r6AWO5SAQhZUVkj6lbL/kagGKZhiD?=
 =?us-ascii?Q?xegO/8RR7zH6BEreJmBLLnTpKlbBDJF+nNgMhdtkn3LljDCMvHdFMqTuHGy9?=
 =?us-ascii?Q?bqnBjSnlq7H/olzJQH1+ENfrA40ims/VEoPSRg9YxZT0kcwx/+RKohF4RyYN?=
 =?us-ascii?Q?XSIRY3iDscJjEVNTNwSKOGsTuDoNw+gtdsEVApPs4BcXycLqqYFV0HsCO1/x?=
 =?us-ascii?Q?vL28uXv5VYR0aaxDELPzvEwR8Skv2G3hPVXioAJ4F5ElSBAbW7jLlcJw9MpM?=
 =?us-ascii?Q?1j5JAC30mipkeWNvXoNnCkRtcxpJjfRTE6RApenWQpVbzIcCMRBB06gLgnPy?=
 =?us-ascii?Q?dnA9LWNqVoBDrEEt4LSmDp6Y8/fWBq0qF4JTjNpTbo/uklbDGGxXtRJmENe4?=
 =?us-ascii?Q?hHSKMilShTV8EYwTcYXgAchIfc44IPRYj8lqGe6HcNiXPCGOs+J5xk3mFZji?=
 =?us-ascii?Q?tglluHKsqEf0XyMkw1yeRU7U2ygwhEHBFEJ3NmL3fr5P4rLCmFDX4LMMV5ee?=
 =?us-ascii?Q?OAsWVuckkfPpo6b/gmZTdgCGm676ClKzA4vR9dwzPb/QwwKLFN4IXRiEAiRa?=
 =?us-ascii?Q?R7B9vf8IawGDq60WHZuCRNy6/9rsBQ4D8loqEdqXg1YWcQEwOzGc5zHMKkJu?=
 =?us-ascii?Q?VmlJmR9Hj1ss4SPYFV89jIlQYjuCZ8mPLAe7rkKSHNsjN8AMEdxtlvqTkPsg?=
 =?us-ascii?Q?vQKq8j4Q++ZMwJF218PkJNqd0tBah67UKYVUsZkhfFXfvpCiCHFoMouiozpH?=
 =?us-ascii?Q?vJXkTO5XDgS0QJcLqJGr9gsbhRvxdHGb3ju9fgB1AGBZgslVsT2b51ji1ADH?=
 =?us-ascii?Q?kNGKVPSUroi6VkXffqjAm01/1TcilGGOh4VtZaEBMW2B0Ag12E15lIcVxgVM?=
 =?us-ascii?Q?3rR3XsOXpMLInAy4CcA14tbJYzZAEMJmnC5byokkKzMTK2gwYqoSImPLN4oQ?=
 =?us-ascii?Q?6bndDhLdAoUtEjS7YVLvqLRtC89vUtDEaQx09wpNzpsZmR++dR9lnfWALolX?=
 =?us-ascii?Q?Gh4ou0bqIyY7bHtq06ZcnT6hnaq8+7/3dxQY30vbIEm6y1OLjornAZjJ8T9Y?=
 =?us-ascii?Q?xlMVerAvvAHMj+xuEyX2jcJUeXBzED0jJEgPb+LkHRYfQoa/PW+XVKOFrtnR?=
 =?us-ascii?Q?exZUlUDxs+vtl17YNWbi6DnFgWqeZ8BvfAtPjQV9ld72d0ern58vmsGypE5v?=
 =?us-ascii?Q?QhLfXCdnvvwLJ8HByRVVw7eXM2cqNX9DXIJ0+349paawMNfjPzxWUGTgFZow?=
 =?us-ascii?Q?VPYbpd/eHv04NNtQj0joJBt3BDtK5yArsoNy639i5kzXBpASb0qQ0j4LpD74?=
 =?us-ascii?Q?9DZhgblTIWEmswJJ3Ql5wT2WDx1emkNNdfKpiZwVaWNmpbPf3bjGxlxStg64?=
 =?us-ascii?Q?dtb/vxmCZrdM68ZfIJ8AqHTFRNvuWkdBQZu4wjpEkdyQ+N7YaU8I6G8CeIiR?=
 =?us-ascii?Q?zylJNVz3mJ8fgybrbKY7fCKqGkFvoMCqBaDM2VEx+e88Ly55p7oDLgMINkdc?=
 =?us-ascii?Q?5Dar+gmb/YwE0Vr6j0GotbZutNdnNfUmGNP3AJ+D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c460ab-8ec3-4cc0-5ed5-08de126035e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:15:56.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNYcO/cn/LtfdZq5GBU5GtIQY51nx/yzvWIip7t9zcF4ciHWes9fLo6FZ4IQBeLuZR3ILkCPSlB2ClKBsoMU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

On Thu, Oct 23, 2025 at 06:31:54PM +0200, Michal Pecio wrote:
> On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:
> > On Thu, Oct 23, 2025 at 05:01:07PM +0200, Michal Pecio wrote:
> > > On Thu, 23 Oct 2025 09:59:35 -0400, Yazen Ghannam wrote:  
> > > > Thanks Michal.
> > > > 
> > > > I don't see anything obviously wrong.  
> > > 
> > > Which code is responsible for setting up those bitmaps which
> > > are counted by topology_init_possible_cpus()?
> > > 
> > > I guess I could add some printks there and reboot.
> > >   
> > 
> > The kernel seems to think there are 6 CPUs on your system:
> > 
> > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
> 
> I thought this is because I have NR_CPUS set to 6, as this config
> originally came from the X6 machine, but I am not sure.
> 

I'm thinking we should look here: acpi_parse_lapic().

If you add printks in there, I think you'll see the extra CPUs get
registered as "not present" based on the table entries below.

> > 
> > We don't seem them enabled, but they may still get APIC IDs. If so, then
> > the IDs would be beyond the core shift of 2.
> > 
> > APIC IDs b'0 00 -> CPU0 on logical package 0
> > 	 b'0 01 -> CPU1 on logical package 0
> > 	 b'0 10 -> CPU2 on logical package 0
> > 	 b'0 11 -> CPU3 on logical package 0
> > 	 b'1 00 -> CPU0 on logical package 1
> > 	 b'1 01 -> CPU1 on logical package 1
> > 
> > 
> > Please try booting with "possible_cpus=4".
> 
> OK, will try it next time I'm rebooting.
> 
> > The "number of possible CPUs" comes from the ACPI Multiple APIC
> > Description Table (MADT). This has the signature "APIC".
> > 
> > Can you please provide the disassembly of this table?
> 
> Interesting, it looks like there are indeed 6 LAPICs there.
> BIOS bug? Attaching apic.dsl.
> 
> > Can you please share the dmesg output from that system? And the ACPI
> > table too?
> 
> Will try later but I don't recall any anomalies there.
> I remember checking the topology output and it made sense:
> 1 package, 1 die, 6 cores, 6 threads.

Thanks, yeah it's likely just fine since the topology matches.

[...]
> 
> [04Ch 0076   1]                Subtable Type : 00 [Processor Local APIC]
> [04Dh 0077   1]                       Length : 08
> [04Eh 0078   1]                 Processor ID : 05
> [04Fh 0079   1]                Local Apic ID : 84
> [050h 0080   4]        Flags (decoded below) : 00000000
>                            Processor Enabled : 0
>                       Runtime Online Capable : 0
> 
> [054h 0084   1]                Subtable Type : 00 [Processor Local APIC]
> [055h 0085   1]                       Length : 08
> [056h 0086   1]                 Processor ID : 06
> [057h 0087   1]                Local Apic ID : 85
> [058h 0088   4]        Flags (decoded below) : 00000000
>                            Processor Enabled : 0
>                       Runtime Online Capable : 0
> 

These APIC IDs seem bogus too. I'd expect them to be sequential, but
they jump to 84 and 85. It probably doesn't matter, though we could try
to use these as some secondary indicator that the entries should be
totally ignored.

I expect the 6-core will be sequential though.

I don't know if this is really a BIOS bug, because those entries are
indeed not enabled. This may have just been an optimization they used,
and it seemed to fit within the ambiguity of the ACPI spec at the time.

A quick solution would be to do a quirk for this. Though maybe we can
come up with a generic solution based on what we see so far.

Thanks,
Yazen

