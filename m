Return-Path: <linux-pci+bounces-4388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039D86FA03
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BE81C20A32
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453CBA5E;
	Mon,  4 Mar 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGxqXO6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D66BE4C
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533380; cv=fail; b=GDRGtQWEXACj4vEstKyPInq8Rl6Bn3n7MFuXzTzV03b7wfM7Wn+nkq27zV5lmGTNn6YJlHHFRWxX0ZylnGlItpK35ut/8Ow4Ikn7I/eSWIEKH4c6NVuOjUHzK8Wl31iG8QpnKpT9eHa1Br91diP86QAowZWFcoZI3J+sfBEuX04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533380; c=relaxed/simple;
	bh=L9CNNvD3FhBoXW22gySaOI/VFlL02cG5bQ+hfk2mjRw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dWsoPUV1XsSy5835ZEALvIh6blabx8To3xJxvS3/I92Z3opcvwEjQCo7H2zvSxiRfik5ju4jT7iU+65Jh55TKzGi52sJrOW3eBv1d6kF6GXO3YjFN+2+CBf+bSXPbBw8DRdyupOmjNoNmsuAilCytP3NENCHAIq7QyW/F5eRAu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGxqXO6h; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709533377; x=1741069377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L9CNNvD3FhBoXW22gySaOI/VFlL02cG5bQ+hfk2mjRw=;
  b=RGxqXO6hK/sdeXAP+b225w+wuIojHmOP/lDObmo6jCWAYgGAC7ReJLz5
   JF8hBrUkI0a04ovMi0O9LR7OtxzquD5dixsYPOsbpg1yeiRbDZqTstyzg
   53dH/s+jLgNqYURT9M/9SFmjsZvi1UW98O6cJmC9+IK6qCfkqqUOPtrnp
   QP4A7ZTxXD+HIknldOL1FNIyU94ZgrBYFHBCmdzAaSAxAmPWyS87aR4oh
   0NZmhXLwLNLIeLKY8s2JUg9YrwG2k7FiN92KdRmEcYFmiH6A4XvzEzpMH
   9J6oNugpZlr/A1yVrvOHA5dU756DbvryPjkqE0JZOgsqRWZ/fQj0U/1VC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15415714"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15415714"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 22:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8816995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 22:22:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 22:22:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 22:22:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 22:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTlU6rJwEUOqC4LiFpteKgoyUEYRNac+pvKJVJWHPqEAI9xfoqNoNi2LCUhl/HUOX4gGYODqOi/+Za05xXvPeRO1MJAeyAaL7eVSvixwoR5kNnD0FVFjAGzZeFkiONyhCP1OAHVOzd7NJpdzh6Uqkxyk/XFtmzIYEQ4q85O2eLDpUeRAmMWJPwmgTSz7857Y6HyzIedDCse9E2/TeUo8K2xImUv0etxSHI0iTIUgzF6FAp6Pbxpr9wODif2wBZQ6WLaxBlTNOOY8wE1Xn+XvBQ04ASc5Dfkdob9UzJeZGLNc6VUvP5DVgK7D9ElNwX9dToXZwXriyq8rZOLHB9E/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2LAeEGWOjKEt/UivOIJmsjyTdgS5ZjxpD+//iyx0Pg=;
 b=DJrBlwBtOqXbpA+8d5FxIQ4gA5vYME0cd8p73qd5U992sv2G2bQuE+RGcyTYQAVU9Au2bLr79Tc75v0BokAO3Ai3JuNIA7RvregSPsAuemVaIC5vMg6RC5Ndreb4ay4c/vvlHciXnj6/7cgivV+IBMyzaM4lJjTBbWyvu6v5fuI1U4QAsrGAqNiunWZISbTxdulvUJTU//rnriDcueaBsn3+fGLER3QjDtiAx6DaMznAw4t0MhWMGcRWHUhkZxxySahbNN4qHHLBkGP+8ZOvYwCpgp0WXcwbz88GUwdzGFudusXXjA784Ym/WmIMa6nn2QfCHjFB0D/tGnesYJXjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 4 Mar
 2024 06:22:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 06:22:51 +0000
Date: Mon, 4 Mar 2024 14:22:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Anup Patel
	<anup@brainfault.org>, <linux-pci@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [avpatel:riscv_acpi_b2_v4] [PCI]  ae961adb50: RIP:acpi_safe_halt
Message-ID: <202403041047.791cb18e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cb9c33-ac8e-4320-d4f6-08dc3c13851b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/6oVhCb/FWxJ2+u0vfaaMILABONoaCpVa0jYfXCtfIDgL1KFa422IUOBtl9RoQvDEdYDFbBFKoGprITsooujbpQ+5TOtlxSY0T6QyOoF2g9t9Lx/fab3CA5FBiiPPCR6LaJO4JZ+5OcnBqfYrYPms2m/vYoozOMMoxyJ9fNr/TT5sIMIFR4disAD6QCzz1R/51VZcXIxH+28Y9gtLcaGc/6pQEjs5vryzQEgLDRUqG22TjkXvwwo2D9Oq7IEs9QV1onWNuImGoiAhdlGNIi5nKksOUfC00MTAdveze4bM1XeoAvHt7Uv2C5xont7vgd9C3/J8UUBAB+Rlab6WdIYGvwTtn/GiXNta4tU7L9vQS1MGXD4XyMNncuB5bFnmbpVXE28ZMXbzvMPFAMw2NQA237mxOsO/ECDaYEACK8Y1tVXqlbkOlZ06sFdm3vJAeFCeYzFSWlrIRTxtFX12sUOmfr641An7s/jHsJfthUKi2IfPXyx3ymiQwMocNV6415kh6GGWT+9khUYWFcNq1v3+xEWKnpI7S5+AjqE82oNNC6Sam+BtxeIN0OYHWtIfWTHU3zLf0VhBAqxFHsVi8xCVkYwl9q4eBYVyyEmI/I7F60WpVlV52onuK3XPy5CCaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP9igMNX0cM9v4ZjxLUgcyX3XT6m6rFPAvgh9gV75NwL8XKOFfgUkPXtaY65?=
 =?us-ascii?Q?FY8rSt/CyrGlevLJGHECvns8PRb40WIOQEiotZkz+K0sCwhjWG1pRzAPdxZa?=
 =?us-ascii?Q?bdxHfYidrfZEP4V4eqi5G43hHNLik0h4XLkthg6NOvxYMxyCe2VhznYu3Tjk?=
 =?us-ascii?Q?FVHulvABAgu1ymOKAm96c9nvWLNfoTZEcGVizEw/7uujocBiur2hdC+ztySP?=
 =?us-ascii?Q?J/BlEqaJK+QjR91wP4deJTOg50l7SJMCMXvTOHUbAcLyct7ZRWPONYY6y4w7?=
 =?us-ascii?Q?g0WWF3Hm1IduPWG0GL5hUNdyAtwh0bMlGrAFaKJAqj9B+ciYiV2JA4CEy7eb?=
 =?us-ascii?Q?c0cFWHoxM+RF9NMwa6mvnYm+CQT9XQ5aclp5dZ6kEp2PKV+9h1eRUadL0B2q?=
 =?us-ascii?Q?dkCQ1tV3T5rIC8r+J8jqcXCFNjkFjhpbrk9b5FsFPSh8Crgu6gGSSVPArAQY?=
 =?us-ascii?Q?NXNTf5mBVb++i+FVJmOyxappIMzENCwj9GyqIal0/JQHfpj+NTT2hF6BGFuB?=
 =?us-ascii?Q?X0VSUWsmQlZ+RupVmJ05v/8YKcX6DKDeVsxO3TNZTHL6shlIQ05LV5nPy5Pq?=
 =?us-ascii?Q?EVN3lPU5hM/GlJRhUUrk+/wPbFuwjaSDfWEpuanB6W0Re6RpdOpgrX80zU1D?=
 =?us-ascii?Q?T3ykCmmiYb7sGccb9wx5nSoHOxIBkHjoLoY6VlbN9QWMKXMV3qiKQM4X19RS?=
 =?us-ascii?Q?ykSFFkOnXkq6CTp6zYpMvHzgrKHcVCTqyZ5or1ftnkoU1GicQmSsfN4nvCQR?=
 =?us-ascii?Q?HHMHyCqqoMPb8dJLz89NgOHNri62W4kU6GYFCHmiakQD2kJ7LCSdVeVe5Ldz?=
 =?us-ascii?Q?48HlNCQCrx+DKUsY6WIM1ht+hQEv+q1Sul3RaxWXwKgrGK9aoNZSlB8jPHGV?=
 =?us-ascii?Q?I08BW8vLS39Z5CI5NXGskM9REthX42azlO+FMOJKhyekluX4nwB+gPRE2oDd?=
 =?us-ascii?Q?RhSbCpllgyYs/2CrtDRSA4tPVemguwPViiNmlPoICZg7j5Rw+TQpMddb6Haf?=
 =?us-ascii?Q?pjwmlmrnZdBC5T2Dyy27TdOmpRJlkKnPH4yLb7gmWeAPcPAheNliYguzP8FN?=
 =?us-ascii?Q?TXo/p4vcsWjDUrsz8GNcSiQ1ccv4QozLm4fx5lUo9dXUvwEod7J9ByqZtfMX?=
 =?us-ascii?Q?hCFIC4jt0rFqLr/qvTTDG0efKk8f/mBnrYI+6J+1I2buZgDLf3GDS7cKsHmF?=
 =?us-ascii?Q?XgkqHR+Qe7i4DzcuZLUDAyIpD44H6aKwoPb1xVR75/FMF9e8IqhSZVGbj0qb?=
 =?us-ascii?Q?0ZFonnQheEmwlOW1Z+XIcCCBcE4ADFgSzH572ovFw9wuytKQ8uhCGzXjvXGb?=
 =?us-ascii?Q?ftEkr0HjN0Op8qC79hjtRcdZEDM9c2oMUkM9P4bsiPPDO+uktxc5Ah/da6/A?=
 =?us-ascii?Q?8fUxrVXovce4UJ2Dj59wvb83xRYOeNuNoGECmWL5QR0n0leBVs3vVbk2NGM/?=
 =?us-ascii?Q?A+F9NjeIY3VP9wibVjf2Oqr2nGgLBpPHdMdN8uuaV77i5vsFKEGr4mDIJrPB?=
 =?us-ascii?Q?gPtDEtxFQRhvebvI0BbgTuFMFq3ESfqhYbfBFSBl8Q+Db327AlqfucJv0j23?=
 =?us-ascii?Q?26KVRP7pFmK3sEqentDGDSBC1OQxDWR8QEtaqKB3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb9c33-ac8e-4320-d4f6-08dc3c13851b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 06:22:51.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPXNrneEk3pNnw5AU94azI7J7wGMbXtLHtQbfsQ6TGajaAjkO0lypmjkqvAi1OTTvTxax272NPqRc71BskdY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:acpi_safe_halt" on:

commit: ae961adb5092165da1609f938a1c7d4aff69eca4 ("PCI: Make pci_create_root_bus() declare its reliance on MSI domains")
https://github.com/avpatel/linux.git riscv_acpi_b2_v4

in testcase: stress-ng
version: stress-ng-x86_64-cc94d63ce-1_20240224
with following parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: filename
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com



[   15.317785][    C2]  <TASK>
[ 15.317785][ C2] asm_common_interrupt (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:640) 
[   15.327376][    T1]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[ 15.331785][ C2] RIP: 0010:acpi_safe_halt (kbuild/src/consumer/arch/x86/include/asm/irqflags.h:37 kbuild/src/consumer/arch/x86/include/asm/irqflags.h:72 kbuild/src/consumer/drivers/acpi/processor_idle.c:113) 
[   15.336875][    T1]  pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[ 15.343785][ C2] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 40 1f 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d f1 d3 49 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	65 48 8b 04 25 40 1f 	mov    %gs:0x31f40,%rax
  16:	03 00 
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d f1 d3 49 00 	verw   0x49d3f1(%rip)        # 0x49d419
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  37:	00 00 00 00 
  3b:	0f 1f 40 00          	nopl   0x0(%rax)
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	c3                   	ret
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 00 
  11:	0f 1f 40 00          	nopl   0x0(%rax)
  15:	90                   	nop
[   15.343785][    C2] RSP: 0000:ffa0000000337e70 EFLAGS: 00000246
[   15.350098][    T1]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.358783][    C2]
[   15.358783][    C2] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0000000000000071
[   15.358783][    C2] RDX: ff11001fffa80000 RSI: ff110020c0397000 RDI: ff110020c0397064
[   15.358783][    C2] RBP: 0000000000000001 R08: ffffffff830d1380 R09: 000000000000000d
[   15.358783][    C2] R10: 0000000000000008 R11: ff11001fffab14e4 R12: ffffffff830d1380
[   15.361594][    T1]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.363785][    C2] R13: ffffffff830d1400 R14: 0000000000000001 R15: 0000000000000000
[ 15.363785][ C2] acpi_idle_enter (kbuild/src/consumer/drivers/acpi/processor_idle.c:709 (discriminator 3)) 
[   15.369271][    T1]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240304/202403041047.791cb18e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


