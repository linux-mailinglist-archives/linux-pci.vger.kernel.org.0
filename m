Return-Path: <linux-pci+bounces-4858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EE87D680
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 23:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB3A1C21198
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDF56778;
	Fri, 15 Mar 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APyVxU0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61F5490F;
	Fri, 15 Mar 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541457; cv=fail; b=pBvxrBUZ7GTu5AauLVL82TmaPdE0Lamq97NhtizZGffOs3xoa9pJuboElnEB5jA1l+lWrIa69uN4O1i6iYqW39y6Zcvn3js23UxTwu4wHhcJHZ+4Y7x8sYOD0PQW60P4e7cve4oqasiy3F7/fj1NRGF8mpd7PtR9ASUbArmXazQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541457; c=relaxed/simple;
	bh=57hwQEyPUYRfd9Yu0bi3dLywPluyztfZAa58au98PYQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=stwHPue7tr7B9j57xGfwd/jFn3JmxBMkVDlfOM1O+X0QWBYj1FO9S9hPS/0j7tLa5ecYZTtWiOpFLwNBlI1b6xFsJFxkZF1LPjE1gN3vhXiHinuSvpypw6Xb9G3CiMBNUNCklot+TeGyjr4eHPqqPTwODFCdX30EBuZa76KQMAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APyVxU0g; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710541455; x=1742077455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=57hwQEyPUYRfd9Yu0bi3dLywPluyztfZAa58au98PYQ=;
  b=APyVxU0gk4AfEj0/00Zwx6UWmcXBBx35NZYonRteTLxnGesZ/N7MXDhQ
   I5kywNSLft/gXgpQBhcOQO3mBq52LPI1N9YayuJ9mjdNNWjyySUubFpaG
   05B/NdiaIZ9JVgfe/826FpiJ2Xl90uxTQuiXJhyjQwA5o1Cd29+qRuSB7
   wVZ77weMxmXjoqfy5S7OxcRZ2W280xWWfb1mIRnCH+9LgsE3FxcSLauSq
   bftrR61Ncft6yqflQeRlYzVAy6SBTQ+dHm+eaWkw4k/BS7TbTUqGD6NCh
   h24qD9aQW/U2aheY6blm2TGQ99Rpb44geEUnae1SY8DO0jdMdWu0fi9j+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5564050"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5564050"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 15:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="35945156"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 15:24:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 15:24:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 15:24:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 15:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU/SilX+hntRFst7AUPY6HQs2eE2hKRDTyD2mIDFYfTSyx4cpojprHqgtOj4mU+GkYLp+tgiKPfbhq5CqYvKwd8EA32urq5P9sBNdSJ2IVuO1IHYpR4GMEgC1dnuZthIYZrLl/iyw/owm62/qkdJGZe5eO21ldyGCkEJYtby8zkdIMbl0/txhuu9UfDafsJhb5GCfJdEtPAVILStVYs5IqYYpDbeOY0G7o9odooRid4L4nsFq+BsoI+7wqbm3np+MSEq3r3f1EOz61Lx1tdCfRbs5buhKMwaG2MK7y0KQtIM4QybD3KQyGbpPiskDkzaaVl5HwVgUZciJXq35dFskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRNOnxjXrwtCc4bQZfZZQWYJovK3s20I6PHbEUKm4Fk=;
 b=Ai0fx8L6sEHQnPp3O3ylkaeBFAtxQkL99XzUVgnAILe9YqwVsjiB7U3PpAO+tb04IO3fDxUDY7T6SfwueO8/498SCw8vJh5Hj1kIOtmtZGZBjn3zUzCtgG28/sk+31bQtrTglO9nKbmjJMOsA1Tcv3MIPuLs2zBeVNO33uukTa2hMNIM9OzgKeP4kXiI4DBM6gSnoolJUwVbDbR570wFjLcwwpeUlylmyqkLbtdf9B5PGTlOiNgr32Bnf7lmzflbF0w0q24py+7QfALq9B6fd18qZFfAuTTw4S6JGprxWx+bb6WB+J6ZvFuqJeWhxJMUuwCKGEWoUh4yup+UZEbVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 22:24:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 22:24:10 +0000
Date: Fri, 15 Mar 2024 15:24:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <torvalds@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.9
Message-ID: <65f4ca886d04c_aa22294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c5df8b-4531-4e25-b9e9-08dc453ea303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQ7Uqkj4iqtqXYrs3GkiIeDuS+mB6QurWF7twoaXWa4ngGz4UrIZf4SV8NxhFmThNHqGHR5Q0GiDb3jAnD5AjWhdbXDGu5YXOc6CJBYJCFCaObhgwOsM8tZ/E6h3/OtVbKURSnq/a27G3dVPEVZzqpNxJttHvdWBSjaWTrvFL/dtFfpCx0cpUiCZPM7dtPB+kjU1/jA6y7wnknEgmgrO13g2cgzjyY/8draqgfwY/x4cJixTXo60ehSWOQ8TZwpIhIFBlQ0WO8D/EDR5GvLW6q8D7lAWyu9TRlDzf+RSKh+hw1p3BzLZa9N/GAKb+LoYE9JU+JnSH84EcMSmq/NB+1x7BSuonbaPzXTkdGGamQx/28+xEcQyQtwubCCFOLnu5g/fBnugiaNyfNQBuUPqSVjAF/n38mMimfTX3xKybbu7O/WfKAw18YssvsgxhJykItCJ8QJeGBjps5z9rfFD5Xnzuuio+CnbHCYnxoWnieLB6GYXZ2o1kPJCE3hAj5F4A30PyecoxqhsPa6qBb+k3wxNQbEbqQamFfXMYagrXbqx8SNy8Us4jwh8QM3qIZ9zDaaxjszFGg6ZGtDe42QhPM33FrdQNV782zFxENZsWPRd6UrH9ROnGueru77BalNs9ut2jQsiQtYyk/sUxmTyLAsUitjq2aG08E74/VWLsUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6i6AUg5u1rGVMvbMgQvr2+foFBjshlO6bxFkQBNBtp/o0tdWU7iwAZpBJzt?=
 =?us-ascii?Q?soBYIio18U1ggQHpdo6v9kHier+vzwDFqRLLgT7D0E+1Zo9DXFDipMMq7wXr?=
 =?us-ascii?Q?Y4g3tPkv4ZZr5Xenw+GpphRNhA9fENIALor+fb1Ek88Hm0TXj+zabktq+9q9?=
 =?us-ascii?Q?xWIXQ8leI+CedN3M35kPW1dWwErBI3b+FO8uD5Tc+uKRD3+JgKL1c12hYBc8?=
 =?us-ascii?Q?zTSae9/Zsq+eBaroYeZlNd7+GiHy5iQoJA2b+m+R5yLJqvxiYr+EqmO8wg24?=
 =?us-ascii?Q?ORLourZHQL2Q9J+wLRKH3CpZic4EDTTgkGDDAU/PWzPKuauKgBRdZ19Rf00l?=
 =?us-ascii?Q?rT6rYdP2Byz1tmAHANE0LxFrgeExSsGEDaYyNYw2qfCqgSqlS/NAIUluqVD4?=
 =?us-ascii?Q?Xq+PjQ6QhjFjJrQZatn+zFB2ZGA3qSzUpAF5FxXRkqAdtbzixq1bUV75w+2W?=
 =?us-ascii?Q?MQlJM43PEszjrGwmBq8Ev3cfGWYtMVzKtHHS8IuHJTa0XWNfDfKtAI4Y7eFW?=
 =?us-ascii?Q?f/pa/7QNzQKHqDyTjb4n2jHGhSNoCW4uzv0VhaBLCUzqiDW0wD/moOQL9+Lj?=
 =?us-ascii?Q?HNtHwUqUD04lfPdlk6OkKg3L2b8wr7LwdpEwEgRXlPO6F/MI1rBZ+LdYyqRm?=
 =?us-ascii?Q?w/SkWA/toxSjY3m36JisLOmQTrsRLJqcETtOpxnwxnAo9JtaCb9pr+WpVa+V?=
 =?us-ascii?Q?4F4yykhllUNAcB58WcbG9ZLRhlnp7VKjLEAPokzxkX2oeER3pzTioYo/OxyD?=
 =?us-ascii?Q?rdect0rB37KbmHR7rPgDtbhhnfS42a5Z77qA/U5Qwn3LoCyyaEZpmr0n4sBP?=
 =?us-ascii?Q?AlioX+fkscln92X1j5AjHbHeLyrj0Wr/xTgBPwg0XMj2NKfYe0KujCI+jgeO?=
 =?us-ascii?Q?C1QL5YGHFstellzh1jP8vaTCMaQfFXvoPI3fKu1LXKAkgCWP5DSsY3R9B6WP?=
 =?us-ascii?Q?vVUpAKhPpvVLxIXk4NqhbuISh4lG/b48kO/Z2Z9fa838ePGWUIy1xRCWsH2k?=
 =?us-ascii?Q?jYCvEglKwCK5j1LIQmxO5wUH2TDi/aIWkdIff7Y8VhiLyz/HgluZIUwjP40y?=
 =?us-ascii?Q?Gy+GHle1iH+tpZ8X5ffwtGzvZfiKHEdYse64gLtzLeJFJQPqYeKIOB6yNDdj?=
 =?us-ascii?Q?7hiIj3/r2X+BCga11jlMYqy6ytQWIk+B4AHoWCp2K53SH7i3jYH2+e3YZ6Q0?=
 =?us-ascii?Q?R6G1AOonJ3mn+set+HMJ1ROE8Z/JQ3TrYWweXqfc+90+nq6+ndu/JYwD0wB0?=
 =?us-ascii?Q?NbasNsrVtUL7IofxbxMokkQtwWFjw4Ci1xJr75PE4AhRTTHavZssHz6lcRMl?=
 =?us-ascii?Q?Pu31BmxPmnYxzBBy++AMavLI8qPv4+pem3nxMKC3S7oyDYxqB6DzPkfn3ByF?=
 =?us-ascii?Q?gTZeic2DiXmZvqDMEhlPZlm/QmgJxNPriN3IqJMv+iTyJ6veVzEJ3xi3i6dp?=
 =?us-ascii?Q?oPMHcClN7CHhFxSmscV7y7+ulllwp6aQlAmD6tiH4DboFn+yTTy/pRz1Y6o0?=
 =?us-ascii?Q?/p3xB1Y+54TwAes98AqJIRMVZQp90OOoaP9ayOiMRHCwCaHdwil1EmifKwhk?=
 =?us-ascii?Q?PXopUmZIJMBkXIAEIxEsB3+hXAtW08aRCoTy9uDokVDQbO389vASUhro0ZSt?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c5df8b-4531-4e25-b9e9-08dc453ea303
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 22:24:10.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3NNiGi3BoRNX3eKKtO2E8xClGCA/GJENtrEAoj7GeWBE61/BNZyNCq6O2VWdNQtbig+1h+yxO9uaAKHUQNGGbKUCKa9f+TxMDiXrGIDsCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.9

...to receive 2 feature updates and some cleanups for CXL.

As I mentioned in the v6.8 pull, CXL has mechanisms to enumerate the
performance characteristics of memory devices. Those mechanisms allow
Linux to build the equivalent of ACPI SRAT, SLIT, and HMAT tables
dynamically at runtime. That capability is necessary because static ACPI
can not represent dynamic CXL configurations (and reconfigurations). So,
building on the v6.8 work to add "Quality of Service" enumeration, this
update plumbs CXL "access coordinates" (read/write access latency +
bandwidth) in all the same places that ACPI HMAT feeds similar data.
Follow-on patches from the -mm side can then use that data to feed
mechanisms like mm/memory-tiers.c. Greg has acked the touch to
drivers/base/.

The other feature update this cycle is support for CXL error injection
via the ACPI EINJ module. That facility enables injection of bus
protocol errors provided the user knows the magic address values to
insert in the interface. To hide that magic, and make this easier to
use, new error injection attributes were added to CXL debugfs. That
interface injects the errors relative to a CXL object rather than
require user tooling to know how to lookup and inject RCRB (Root Complex
Register Block) addresses into the raw EINJ debugfs interface. It
received some helpful review comments from Tony, but no explicit acks
from the ACPI side.  The primary user visible change for existing EINJ
users is that they may find that einj.ko was already loaded by
cxl_core.ko. Previously, einj.ko was only loaded on demand.

The usual collection of miscellaneous cleanups are also present this
cycle.

It has appeared in linux-next with a documentation build regression
reported by Stephen and fixed up with edc1243437e7
("Documentation/ABI/testing/debugfs-cxl: Fix "Unexpected indentation"").
The 0day robot also reported a new sparse warning that just highlights
that the work to convert einj.ko to use acpi_os_map_memory() instead of
acpi_os_map_iomem() [1] is still pending.

Going forward, v6.9-rc and v6.10+, you are going to see pull requests
coming from Dave Jiang.  The CXL subsystem has several folks listed in
MAINTAINERS with review spread amongst that team. Nothing really changes
from that perspective, but I am passing the primary patch wrangling
baton to Dave. Likely all this means in practice is more Reviewed-by's
from me and less Signed-off-by's for marshaling patches upstream.
Otherwise, please give Dave some grace as he steps in here.

[1] a238317ce818 ("ACPI: Clean up acpi_os_map/unmap_memory() to eliminate __iomem.")

---

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.9

for you to fetch changes up to ed1ff2fba7afa7baca7ceb93824a4699130b8377:

  Merge branch 'for-6.9/cxl-einj' into for-6.9/cxl (2024-03-14 19:05:27 -0700)

----------------------------------------------------------------
cxl for v6.9

- Supplement ACPI HMAT reported memory performance with native CXL
  memory performance enumeration

- Add support for CXL error injection via the ACPI EINJ mechanism

- Cleanup CXL DOE and CDAT integration

- Miscellaneous cleanups and fixes

----------------------------------------------------------------
Ben Cheatham (4):
      EINJ: Migrate to a platform driver
      EINJ: Add CXL error type support
      EINJ, Documentation: Update EINJ kernel doc
      cxl/core: Add CXL EINJ debugfs files

Dan Williams (5):
      Merge branch 'for-6.9/cxl-qos' into for-6.9/cxl
      Merge branch 'for-6.9/cxl-einj' into for-6.9/cxl
      Merge branch 'for-6.9/cxl-fixes' into for-6.9/cxl
      Documentation/ABI/testing/debugfs-cxl: Fix "Unexpected indentation"
      Merge branch 'for-6.9/cxl-einj' into for-6.9/cxl

Dave Jiang (13):
      ACPI: HMAT: Remove register of memory node for generic target
      base/node / ACPI: Enumerate node access class for 'struct access_coordinate'
      ACPI: HMAT: Introduce 2 levels of generic port access class
      ACPI: HMAT / cxl: Add retrieval of generic port coordinates for both access classes
      cxl: Split out combine_coordinates() for common shared usage
      cxl: Split out host bridge access coordinates
      cxl: Move QoS class to be calculated from the nearest CPU
      cxl: Set cxlmd->endpoint before adding port device
      cxl/region: Calculate performance data for a region
      cxl/region: Add sysfs attribute for locality attributes of CXL regions
      cxl/region: Add memory hotplug notifier for cxl region
      cxl/region: Deal with numa nodes not enumerated by SRAT
      cxl: Fix the incorrect assignment of SSLBIS entry pointer initial location

Robert Richter (3):
      cxl/pci: Rename DOE mailbox handle to doe_mb
      cxl/pci: Get rid of pointer arithmetic reading CDAT table
      lib/firmware_table: Provide buffer length argument to cdat_table_parse()

 Documentation/ABI/testing/debugfs-cxl           |  34 +++++
 Documentation/ABI/testing/sysfs-bus-cxl         |  34 +++++
 Documentation/firmware-guide/acpi/apei/einj.rst |  34 +++++
 MAINTAINERS                                     |   1 +
 drivers/acpi/apei/Kconfig                       |  13 ++
 drivers/acpi/apei/Makefile                      |   2 +
 drivers/acpi/apei/apei-internal.h               |  18 +++
 drivers/acpi/apei/{einj.c => einj-core.c}       | 122 ++++++++++++++---
 drivers/acpi/apei/einj-cxl.c                    | 113 ++++++++++++++++
 drivers/acpi/numa/hmat.c                        |  83 +++++++++---
 drivers/acpi/numa/srat.c                        |  11 ++
 drivers/acpi/tables.c                           |   2 +-
 drivers/base/node.c                             |   7 +-
 drivers/cxl/acpi.c                              |   8 +-
 drivers/cxl/core/cdat.c                         | 170 +++++++++++++++++++-----
 drivers/cxl/core/core.h                         |   4 +
 drivers/cxl/core/pci.c                          |  99 ++++++++------
 drivers/cxl/core/port.c                         |  86 +++++++++---
 drivers/cxl/core/region.c                       | 169 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |  15 ++-
 drivers/cxl/cxlpci.h                            |  24 ++++
 include/linux/acpi.h                            |  21 +++
 include/linux/einj-cxl.h                        |  44 ++++++
 include/linux/fw_table.h                        |   4 +-
 include/linux/memory.h                          |   1 +
 include/linux/node.h                            |  18 ++-
 lib/fw_table.c                                  |  15 ++-
 27 files changed, 1004 insertions(+), 148 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (90%)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

