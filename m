Return-Path: <linux-pci+bounces-4808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E987B88E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2851F212D8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38415C61E;
	Thu, 14 Mar 2024 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyMX3NQu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FB6FB5;
	Thu, 14 Mar 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710401067; cv=fail; b=g2li0h/uwBrqwB2Ltkd9OOzRQqt1a1W6x09eMag5Zpvsm9REALRS44stDiq1e2C8nMkWttT8j+xoof3YkO2A91zKZ1D4idiCq5Q5DM1MOlCwT+wxiWaECKiSYk6AigCoAA3NID5MLqmdH5/LvxnviVHt5vsVkyRyQMrMsoAb54k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710401067; c=relaxed/simple;
	bh=AJfJ1Ip2UF1zutu9Neb8WFrdbe8Ilk4rrCCf1DDMf38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t69yuLaZk0vQE4w8K3IZFm3bfGNYYy2OPiArzBv/odyFTN9c7VD6K9P78O7TVaXcJlSza4e5qjTMXtkD8FwNwVBv4ZH7lNVxrPwhhS8av/1Xumt8jStGvXxNrD/3lxhl7HhKtFJAGawHmXJXmVJaSuI4WLu28ac5y7qWS5MX1Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyMX3NQu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710401066; x=1741937066;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AJfJ1Ip2UF1zutu9Neb8WFrdbe8Ilk4rrCCf1DDMf38=;
  b=CyMX3NQu8N3Itfhokn2xK6683WUfErES/uycByE5sGD+pMHu3rsLwnKl
   BcUbDj1hwEJ8FhgEzDuRmS01Arl+SdEl02jIDJBxHbH854iINeeed9PVr
   xsG/pNgzdwTf0R3U7LgaiOaRgM70THHdAMHjJcAYFo9+1cfNpAWeeo1w9
   rcXW9yFx/20noG55O/Hc/OqiA7QUNx5LThMKf0CZAL6lesdzhwCG2JR9i
   nltl52oI20PZ2HOkQNQM+b6bMi/I/1cACbAQfne2UYqZogcMntGOpsO0X
   CwvR0NgAcvFaHGxcXcsyKAt9vB/VhSwiRs0qdQZQp0AzbdbFXnAp+QwtN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="9023622"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="9023622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 00:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="43246269"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 00:24:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 00:24:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 00:24:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 00:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiCiKTRFDnFfOeUHSjq/ayIVvhsjkssbDTZTUI1Wq1PpjYwXCFFrYDE4BT9zUQj+y5tsbVKNHtINPD5JLypG77wnfkivMerUXinQzTkHTbK8To0oGthtVtyiprvRTh/ui6M0Akxk3atmq+CS+sd5uejUj7vIQPzudfwg/qts/skzacE4rqY2w3xOGELUEZNzsqCaC8fdhdLY0kaDof4ZabvO3lULScOa/IJvWN4ydBSclvYmlMMyC9J+9izYBxrl1d2WGQyMi60YS3tF2DYrqYxIC7MBDFdX00GobWsvPdZovkUpl6Hhmqyko3roE1llbP7z9iCo/mo23iANMPtvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxHHMupXU7VdeqpPh/aneFAMpcm/JUvanjECOJzqD/o=;
 b=DVJGv1bNBig59037pxlvLhhGyaRc51DABv5bMKj0/j7zADZRF7uisdLUIG2o7/iFd66AryEDfcRSvXxv7McJ18VnhptPPspvDnhGgtt/zhGiFE/P0NnACyAT6NsNmIw/EGjukYsbnEic6ynvSQAN8MjxPyA4hlx+dPotLurBd5D/hEuaf6iVm10oAOyG4lVlWcShZEE/SwB4us4MQX3VRhSQugJ9FOqYqT2tpGPsNGlLG6VDqMLXS1lZ8CYTKjQVHydhwHagMve7GTyxWwosj94G+bQOlh+d9yMLUp0JKGb8t60CQXx2tg/mHv8SCYIvqxRt8tk2YTBUQbDjNPH+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 14 Mar
 2024 07:24:16 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 07:24:16 +0000
Date: Thu, 14 Mar 2024 15:19:21 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
CC: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
Message-ID: <ZfKk+dYXkiRRkk+p@xpf.sh.intel.com>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
 <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|MN2PR11MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f78f66b-2e84-4a84-8eac-08dc43f7c178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +daGDAyvq5tiF8LjEFoGQJz1J+jRQ3e08eCjK4OFP8xgJkJtMDHNaQp8wJgonM6aD+w8od7pfJ8ZgNiWRmsz14NlPVXSknkuu8sN+qFeCYHSBR0VRIqTXTIb5PsF7+pE+JWw+pQRhtMi6Mc6YsxLJYO1/AJYB3avLYOFUFTpyi3aPnpgFB1GLhWBgSRBZGtbBUrxwzowXY8WmbwxAcVg7Pk2P1MI4p41byP6r62ActkhzfqLeuJ5abcBcblRgGex7J2i/gndNkan2LyYJiaLVRPciF+jI7gXbnFVDzbYVeHLjwNaqDNjFqoPtRReAfmf/Jg414nORen7nGOVwBqXNIK3syHExE22BVfaULRkZjoYNm5LpI2UqQCQJTVtQXJLqPsY1FklwYhiuX438P1ufjKmEf/LqAbBEbJZFsRT+Ha3Su5GQhA2M1rhjkv47ubmKyBH1uhaWGXglzT4eK5QdAS10xwxZUbfaDalbZb5s5gB++Ai8jCXDflh/4+T2wkscIA86uyx9/FcYRrGk7eynpO7BpK7oNcdR1kfUQr0a1Zbmtz7pK0q3sbjZOti0uXBcyGvejRaDkyqUdgRgc0W/1h0Rt6KUqp/FMyjwVMuBsQqrE+c77GUCgd9GoyGxctN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EPOBW/ZZtAObWO6SZep77dqOQFX/jmymwhe+p3Ot30QqVIWzM3LTMNC4vl?=
 =?iso-8859-1?Q?micZfXAsLSrW6mg2K9pC5ygJZePd/Kob3d1cQqNMAuNsEaFf0FBfdyXhIm?=
 =?iso-8859-1?Q?9VM8i5FcQQ7X8YUO22hUNktZtjHBihBTmaX+8BWhRQ3KBZDKiDVQOFVWzq?=
 =?iso-8859-1?Q?Sm5r2/LLmJXtwQ6aZMRApsiLYMLwG5eAKTKKWEJtju+12bfJJ2aJ+REKiS?=
 =?iso-8859-1?Q?BAHtTC2bp/A6DBesl9+IP1B0XOEnKlJ6jNq3vNc67WNn/zS2UUYkFj07qX?=
 =?iso-8859-1?Q?gFilFmg3BBB7vjytiXLZyfWksGOeMdhq0VPmssUTPSSLY145mvjDoI+U6g?=
 =?iso-8859-1?Q?tyMWc0gKADnZr/MpjjOnNAn/codyPDczAFR4VeJ+dlxAd9e+73sivGFCFa?=
 =?iso-8859-1?Q?BsfdRIO9EBi5Owi36TU2RNzRKcNaFZ2D8zGipDL7UXFWpfc1IjpxlGD44H?=
 =?iso-8859-1?Q?9kyPfTqWfsiiWZQOpSCF6Oyy0s2xiCAqMjht7cLuSBbAn47VthE4lTkvwI?=
 =?iso-8859-1?Q?fu497xKAKmUzEMt5DG4PeN6k1mlUaG5MMg585iuxbKca8a1vdSoQjcSQV+?=
 =?iso-8859-1?Q?4eKR7+i5QNjbwedDL/FHt5xhSaiMP4g6cVwds+Sdo7k5AoSkAvACU+tBpb?=
 =?iso-8859-1?Q?ZAh93fRawqDDWBXIkn4+AfYfIZOakex3gRjUGkVR1xK4Ue0idMaGsr08/6?=
 =?iso-8859-1?Q?M1NByPKZlKJOK9ab18kV0qLDMPVHKNySplKXRhL239jKmhxXtXMnWfzsUU?=
 =?iso-8859-1?Q?JcPiR52Bvpb/1B0dAiM8pwJ1gHiZK2eE+9QbLe1Yd33uUs9KCcDrbxuQ9g?=
 =?iso-8859-1?Q?0eRpokxvw+0opA1r4/OdzFNYcQySOAdsUulWRGWldap60KRE23WsXtkwhE?=
 =?iso-8859-1?Q?SR/EtGF7kQY887S/dypdAQn2w/b3s3g8ERq+EkroKa+A4VAlpIRFTgRvwo?=
 =?iso-8859-1?Q?uoQkZZ0yyY3rMpHAD+54IIZ+VeiaRWsmKqWcYiwpOYrYeC5ugzPbTdElBs?=
 =?iso-8859-1?Q?7pi+uNW5Ritjo68tL3+DEXCpXgca5kJCdGGMfA4HOOrsGw6n3TBd2gW5tb?=
 =?iso-8859-1?Q?1/D2O3GzUmB8cBkSKQLGk7hsClpu8p44h1vsibWv43PYcVo2lapqaWyNmW?=
 =?iso-8859-1?Q?ziImZVFOzKEqMt/DnsWykhsigTIImJkSHzAskaxSPWC6oI1RDXISfJGnYC?=
 =?iso-8859-1?Q?+R4zGNeRBBRUgG4y+5EpzPwZq1rHe1BbAUhzxlRl/wtq80h/00KY3B/Ub5?=
 =?iso-8859-1?Q?D89/z0YYOFAtj8iz4S3ATqlLZFhEqvvNwIse3b7sxz1ANIwhqMitPEtbJg?=
 =?iso-8859-1?Q?OelAc5bob2Ve5cpsL6YJZ6dMu7M35lr/usMtzvmUiC6hblKQvIL94bz0No?=
 =?iso-8859-1?Q?hREc5aAFUuQtp00i0iePp19ijObRFw76w2NgmobglHZZSa95jWrY6XgCiF?=
 =?iso-8859-1?Q?2b7MJi/WeIWV3WMBn7cnuv+NivlUcRCyh72UDg/AEVwX0IMwcl8OitV9AN?=
 =?iso-8859-1?Q?zWXiCQZ+JV/PN/UZ9u3NtvrYN6pF8QE+0pnLQBC8I/auurEeya2z5l7yKB?=
 =?iso-8859-1?Q?Rybkt5kltLK1hYej9UcJA5eAs3/RDd+GqAOuZrklWER9mS+Fo0gn5ekkQf?=
 =?iso-8859-1?Q?mftKjlnT37iD+FOjLmX3wMlEgj75znX6/n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f78f66b-2e84-4a84-8eac-08dc43f7c178
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 07:24:16.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rcgs+T51uG7DKKmtwK1rR8v+yEQKDNS5dKWD86zs+xc4Tkk3XPYM1hXx+MhKs575j12qzf710yikgKElgYF4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com

Hi Maciej W. Rozycki,

Greeting!

We tested intel internal Linux next kernel by syzkaller fuzz testing and met
"CPU soft lockup in __run_timers" problem in guest.

Bisect and find that the following patch is the first bad commit.
Check the commit content is same as following patch.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240313_174939___run_timers
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/repro.c
Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/repro.prog
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/0a53950322bc80aeebf56f5a9d38c847186a082a_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240313_174939___run_timers/bzImage_v6.8_problem.tar.gz

"
[   34.599994] hrtimer: interrupt took 63789 ns
[  102.443957] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 3343956725 wd_nsec: 3343956627
[  393.043326] watchdog: BUG: soft lockup - CPU#1 stuck for 27s! [repro:2653]
[  393.043704] Modules linked in:
[  393.043856] irq event stamp: 17486443
[  393.044019] hardirqs last  enabled at (17486442): [<ffffffff855b0ebe>] irqentry_exit+0x3e/0xa0
[  393.044462] hardirqs last disabled at (17486443): [<ffffffff855aed94>] sysvec_apic_timer_interrupt+0x14/0xc0
[  393.044925] softirqs last  enabled at (14336234): [<ffffffff8126c828>] __irq_exit_rcu+0xa8/0x110
[  393.045332] softirqs last disabled at (14336237): [<ffffffff8126c828>] __irq_exit_rcu+0xa8/0x110
[  393.045740] CPU: 1 PID: 2653 Comm: repro Not tainted 6.8.0-0a53950322bc+ #1
[  393.046062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  393.046618] RIP: 0010:preempt_count_sub+0x6c/0x160
[  393.046856] Code: ed 07 85 c9 75 1b 65 8b 05 d9 7b d2 7e 89 c2 81 e2 ff ff ff 7f 39 da 7c 1b 81 fb fe 00 00 00 76 6b f7 db 65 01 1d bc 7b d2 7e <48> 8b 5d f8 c9 c3 cc cc cc cc e8 d5 36 9d 01 85 c0 74 ed 48 c7 c0
[  393.047696] RSP: 0018:ffff88806cd09da0 EFLAGS: 00000213
[  393.047950] RAX: 0000000000000102 RBX: 00000000ffffffff RCX: 0000000000000000
[  393.048281] RDX: 0000000000000102 RSI: 0000000000000102 RDI: 0000000000000001
[  393.048611] RBP: ffff88806cd09da8 R08: 0000000000000001 R09: fffffbfff11caa46
[  393.048943] R10: ffffffff88e55237 R11: 0000000000000001 R12: ffff88806cd32a00
[  393.049277] R13: ffffffff81516e90 R14: dffffc0000000000 R15: ffff88806cd32a00
[  393.049611] FS:  0000000000000000(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
[  393.049987] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  393.050261] CR2: 00007febf5bfa838 CR3: 000000000bda4006 CR4: 0000000000770ef0
[  393.050596] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  393.050928] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  393.051262] PKRU: 55555554
[  393.051396] Call Trace:
[  393.051521]  <IRQ>
[  393.051630]  ? show_regs+0xa9/0xc0
[  393.051805]  ? watchdog_timer_fn+0x531/0x6b0
[  393.052019]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  393.052255]  ? __hrtimer_run_queues+0x1a4/0xc00
[  393.052505]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  393.052770]  ? hrtimer_interrupt+0x324/0x7a0
[  393.052994]  ? __sysvec_apic_timer_interrupt+0x105/0x3c0
[  393.053254]  ? sysvec_apic_timer_interrupt+0x4b/0xc0
[  393.053495]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  393.053757]  ? __pfx_clocksource_watchdog+0x10/0x10
[  393.054002]  ? preempt_count_sub+0x6c/0x160
[  393.054213]  _raw_spin_unlock_irq+0x3c/0x60
[  393.054423]  __run_timers.part.0+0x6c9/0xa40
[  393.054647]  ? __pfx___run_timers.part.0+0x10/0x10
[  393.054883]  ? sysvec_irq_work+0x8b/0x100
[  393.055087]  ? asm_sysvec_irq_work+0x1f/0x30
[  393.055314]  run_timer_softirq+0xbc/0x1c0
[  393.055517]  __do_softirq+0x1cb/0x84a
[  393.055709]  __irq_exit_rcu+0xa8/0x110
[  393.055899]  irq_exit_rcu+0x12/0x30
[  393.056078]  sysvec_apic_timer_interrupt+0xa5/0xc0
[  393.056314]  </IRQ>
[  393.056422]  <TASK>
[  393.056532]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  393.056781] RIP: 0010:__schedule+0xbe/0x30c0
[  393.056993] Code: c0 e8 e6 a8 fd ff 48 98 48 8d 3c c5 a0 dc 75 86 48 89 fa 48 c1 ea 03 42 80 3c 2a 00 0f 85 81 28 00 00 4c 03 24 c5 a0 dc 75 86 <49> 8d 84 24 58 0a 00 00 48 89 c2 48 89 85 e0 fe ff ff 48 b8 00 00
[  393.057847] RSP: 0018:ffff888024f3f6e8 EFLAGS: 00000282
[  393.058101] RAX: 0000000000000001 RBX: 0000000000046380 RCX: 0000000000000001
[  393.058437] RDX: 1ffffffff0cebb95 RSI: 0000000000000001 RDI: ffffffff8675dca8
[  393.058771] RBP: ffff888024f3f820 R08: 0000000000000001 R09: 0000000000000002
[  393.059107] R10: 0000000000406000 R11: 0000000000000001 R12: ffff88806cd46380
[  393.059442] R13: dffffc0000000000 R14: ffffffff855da674 R15: 0000000000406000
[  393.059779]  ? __cond_resched+0x24/0x30
[  393.059982]  ? __schedule+0x9a/0x30c0
[  393.060173]  ? lockdep_hardirqs_on+0x8a/0x110
[  393.060408]  ? trace_hardirqs_on+0x26/0x120
[  393.060637]  ? __pfx___schedule+0x10/0x10
[  393.060836]  ? __this_cpu_preempt_check+0x21/0x30
[  393.061068]  ? lock_release+0x417/0x7e0
[  393.061267]  ? __this_cpu_preempt_check+0x21/0x30
[  393.061497]  ? lock_is_held_type+0xf0/0x150
[  393.061705]  ? __cond_resched+0x24/0x30
[  393.061895]  preempt_schedule_common+0x4a/0xd0
[  393.062118]  __cond_resched+0x24/0x30
[  393.062302]  unmap_page_range+0xab4/0x3690
[  393.062530]  ? __pfx_unmap_page_range+0x10/0x10
[  393.062752]  ? __this_cpu_preempt_check+0x21/0x30
[  393.062989]  ? uprobe_munmap+0xb0/0x590
[  393.063186]  unmap_single_vma+0x1ac/0x2d0
[  393.063390]  unmap_vmas+0x210/0x470
[  393.063572]  ? __pfx_unmap_vmas+0x10/0x10
[  393.063769]  ? __pfx_lock_release+0x10/0x10
[  393.063977]  ? lock_release+0x417/0x7e0
[  393.064167]  ? __pfx_folio_batch_move_lru+0x10/0x10
[  393.064410]  ? __pfx_lock_release+0x10/0x10
[  393.064624]  ? mlock_drain_local+0x281/0x4b0
[  393.064844]  exit_mmap+0x19b/0xac0
[  393.065018]  ? mark_lock.part.0+0xf3/0x17a0
[  393.065233]  ? __pfx_exit_mmap+0x10/0x10
[  393.065427]  ? __kasan_check_write+0x18/0x20
[  393.065644]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  393.065909]  ? mutex_unlock+0x16/0x20
[  393.066096]  __mmput+0xde/0x3e0
[  393.066256]  mmput+0x74/0x90
[  393.066407]  do_exit+0xa59/0x28c0
[  393.066580]  ? lock_release+0x417/0x7e0
[  393.066778]  ? __pfx_lock_release+0x10/0x10
[  393.066989]  ? __pfx_do_exit+0x10/0x10
[  393.067179]  ? __this_cpu_preempt_check+0x21/0x30
[  393.067410]  ? _raw_spin_unlock_irq+0x2c/0x60
[  393.067630]  ? lockdep_hardirqs_on+0x8a/0x110
[  393.067845]  ? _raw_spin_unlock_irq+0x2c/0x60
[  393.068064]  ? trace_hardirqs_on+0x26/0x120
[  393.068287]  do_group_exit+0xe5/0x2c0
[  393.068489]  __x64_sys_exit_group+0x4d/0x60
[  393.068707]  do_syscall_64+0x73/0x150
[  393.068894]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  393.069140] RIP: 0033:0x7febf5b18a4d
[  393.069319] Code: Unable to access opcode bytes at 0x7febf5b18a23.
"

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install
---

Best Regards,
Thanks!

On 2024-02-10 at 01:43:50 +0000, Maciej W. Rozycki wrote:
> Only return successful completion status from `pcie_failed_link_retrain' 
> if retraining has actually been done, preventing excessive delays from 
> being triggered at call sites in a hope that communication will finally 
> be established with the downstream device where in fact nothing has been 
> done about the link in question that would justify such a hope.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
>  drivers/pci/quirks.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> linux-pcie-failed-link-retrain-status-fix.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -74,7 +74,8 @@
>   * firmware may have already arranged and lift it with ports that already
>   * report their data link being up.
>   *
> - * Return TRUE if the link has been successfully retrained, otherwise FALSE.
> + * Return TRUE if the link has been successfully retrained, otherwise FALSE,
> + * also when retraining was not needed in the first place.
>   */
>  bool pcie_failed_link_retrain(struct pci_dev *dev)
>  {
> @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
>  		{}
>  	};
>  	u16 lnksta, lnkctl2;
> +	bool ret = false;
>  
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> -		return false;
> +		return ret;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
>  		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
>  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
>  
> -		if (pcie_retrain_link(dev, false)) {
> +		ret = pcie_retrain_link(dev, false) == 0;
> +		if (!ret) {
>  			pci_info(dev, "retraining failed\n");
> -			return false;
> +			return ret;
>  		}
>  
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
>  		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
>  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
>  
> -		if (pcie_retrain_link(dev, false)) {
> +		ret = pcie_retrain_link(dev, false) == 0;
> +		if (!ret) {
>  			pci_info(dev, "retraining failed\n");
> -			return false;
> +			return ret;
>  		}
>  	}
>  
> -	return true;
> +	return ret;
>  }
>  
>  static ktime_t fixup_debug_start(struct pci_dev *dev,

