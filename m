Return-Path: <linux-pci+bounces-2134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82382C8EA
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 02:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0178B1F24B08
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3E1865A;
	Sat, 13 Jan 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuY5YidG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65701A594;
	Sat, 13 Jan 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705110753; x=1736646753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pw6rL6mZaJF/XdKL1qz9EkjSsjviil1cVfqqMXkqZ8Q=;
  b=SuY5YidG3wbcqn2yp3HONJ51+o7aA8W0T2IwuoB9nOIm4VeEmEtVemeJ
   xvKmvfqW1Gu8W5ns/aq3on0N4ZxazOuTUHsbPGhMB2V+r4EvSRrIwo88p
   NQc/OPfL20lsCa8Bbd4nxNot+tsjzrG89GNpcGIWqMfWapGc2dRWruiz8
   iijk8+OCeBQAryKe4kH9GDx0IGdLSQqTF/ot3Fgz1Kpr/GP4jWjh9moMS
   QeYiOynb6/Gd/sYTUkgWLajmyuNnzLtlff7V32ExZX6IofbrD8RdTA9gt
   s+JgLQNMGPOQ4eWHTTGmimdFer56s5VptZ+gNKeyojQhGn1O+SPDdPlM3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6420860"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="6420860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 17:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="31575066"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 17:52:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 17:52:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 17:52:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 17:52:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuX6J6g6MeIDaO+1KIAFeGb0+Ifn1Nqt2uqAQP8JvgCGWCLjFdhxZsXzzU8LWiQiUCci1nMMz1j9ekASXi72tNr2IE5Nztxwh/7D02eYUJkuD2uJcrya24EKm2Zx1NOogyS20md9u5L0k7BeHNp+11a9+RcwWrll112F61Wta+8PrDPnNnomRF9lWmLR9BHs59j408h+4Bfs6ebAAvX8bTK/gPlJap28Nz0y17+UUtQjNgt7Zz/YQUhlbLiqoyaVLyeCZRGcsFgnrusiuGtNwLA0pj0MZm/y5Lp7p5RC7qaYvVy2/2JXMo6236oybkgzffhNZ0lWISFc+t86R1i9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjnyTojfX9YAtuQVE8ITskMNKVTbXiQKE4s7SkOIyuQ=;
 b=SpXvc/l/bHIcIoDXVKz7nv6nWJlM6rcvDMKJoonXCMQE2NiB3b16AYgHIF1RV+WLgIxxElhkDaWQzqcKjPHabDoMEmla6E4bvJQr0ZskwerR8XKBaXk2Hed8sPzGBhV+vxnmpCbS4371ckErzRiNxwlYJJnDjsCFz8hgR3Q+vZnMIlWzwM8G9Vfmdjd14B8mSdytOK3ONCOPnlo8POFvrKgc0mBOElLn+boTXVX3j0ogOqh0jjMqbmEp76q9XawFn/ZLqWLcm7dICVRNqaYLUxgfm1SjbXCVLmMT6kjD2LK8gDNmktf1gfTg/0+JRIRUEl3GFVniwR8DaRQO3aoU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sat, 13 Jan
 2024 01:52:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Sat, 13 Jan 2024
 01:52:21 +0000
Date: Fri, 12 Jan 2024 17:52:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <torvalds@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.8
Message-ID: <65a1ecd2b9b02_293042946b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 91853136-444c-4338-3f79-08dc13da47dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3RQHXt/J7dg0AOmemFAEthOb8BfOdjV9s0FW+W1UmnDZl4XJLAJJm1OfLyyGFFBXGZS8Uyw018DxxML5FBYIvTLJwMtNtoOeO+4SxVdY11gjYQRjvStWzFomJrlMUSPR9Xw3KuzNuTayKj7B3sI2Mu25/4ReYqPoWNbUkmq21r0t+oYq5krUj7Je3QKQPfwtpOv5wS4X7Kmann3NV942g0pWDMcN2KfSmgCVd+O8B+O+unb11IR2a3xlaWPbXmBCcXQAlmwA4GGddTrRTi7nzFmn10VfGDCZLCtZnWmSMj+fvNRQ9wL7/tuTN2dzc8RFXu1QQJU3RhOdxHusuZlmF/+qw8WinV934sL8gnbLbkAsWIRb+zvKO3GmcipkVDeEfnwNQKLA9cFigKUt1hLQLYSAvDVAM9aFUTkiNcx54r1uveuSu0v2BFB61Y0WlHXIM5PsnRkQwfd11z1lv/pc6bBXxen7ISc0gr1NToR1/hhEkMvSffACauQjgrDSkQ3Cta2ONZositGNBll0F1hbOcDtAulP52o2dhWOLohGsDGa9Eki/YpeYQV5cCCW3o3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(83380400001)(86362001)(6506007)(6666004)(478600001)(26005)(6486002)(9686003)(6512007)(4326008)(38100700002)(6916009)(66556008)(66476007)(66946007)(8936002)(316002)(8676002)(4001150100001)(2906002)(30864003)(5660300002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwKL1LGNgN6FFp7m44WxlEBvjAHAyAE1DQ/332UGIlWjGWTap2xznDCEa4E3?=
 =?us-ascii?Q?33oi12jGYp6mAei4vL+yFHpvswUcItGZ8Pf3G5ehJ3tm8gZUSeYx9EQr2nLz?=
 =?us-ascii?Q?dMG/IvyWAxRhFiY3O52LWdhznOxsCd3AeRunEb02h9gcObnCDSP3iwPJJBsX?=
 =?us-ascii?Q?WriEPBjOgyyhkiy8p0cgTGKqUAkfVlDiczdRdsGU+SNOQUH2jVIO6TfABeUY?=
 =?us-ascii?Q?P+WBUHK6vBrLODgdbY/lttytKEk+VQj+wG7ArpED+EfkKveCmP1f0ZQRmqp8?=
 =?us-ascii?Q?HfugNbk72WFFGZhx2x3N/M8/BgvW6miZeReKugfGY7H+Binmi5jJ9MlomMly?=
 =?us-ascii?Q?6eMQ8dN0kQTgWccB0ODeg2SrLGvWQkS74XHr7xvS3YAxznww0U1eDGqNWtqd?=
 =?us-ascii?Q?ZssIR/MCOogMiBYuIKusZReXOfITssDx/LboRxBDy1b5pLGWA/rtDI9Zcw7y?=
 =?us-ascii?Q?rr4HI98fDBe/rouMlATwbIhj5G3+4Xl6qKNGBXzGzWnsBVgxE1nK6/2BXtjv?=
 =?us-ascii?Q?CVd3TNqUd1vwNBJVCOF1cebISvCTXdf4qjsgxqeF+MWdNGCl41wlTepLekEr?=
 =?us-ascii?Q?oPOOX2qA6pL6kpJ3qLnvB/liFe83C3tIsDgjZ30q9jCTJ+ZUfLkM49rw6sLL?=
 =?us-ascii?Q?maDKApSnq4wmPSOS2k3G0BridbyYrPg8MBYcmKnIOp4UYDdMW0BrAtB6DAlC?=
 =?us-ascii?Q?CC7YI7G5qhghMuzkD2hTucNBmPpXMITNSBMmfALV4V48SJouq3dujDNLxovB?=
 =?us-ascii?Q?xOVsK8iWweE6PewVuR1FnDTWbk+rw498bYo7UYM0y+Urs2y1olEZGBKrAbcd?=
 =?us-ascii?Q?5ivJbSZ85aqwJ17RjIQl9GTieY05rw5zs4ZZzNCJ6KrzA2JNU+3ZVzIl88p1?=
 =?us-ascii?Q?jnq7LK/4wxuGrkyX7a6t5oK0d5tTCX56oyNXfEPOzr3qCPhM9XM7cCePwsQU?=
 =?us-ascii?Q?nbPSqofxUGRY4o9SuDAwY3hS624QwFnBcbUbESMTD1BxK3XwDXC2tUPXuR4n?=
 =?us-ascii?Q?OEcZaA3EL4kPNi5ljti6rhuS6MX3S109XjtqHXtBMD9EDThEa4RMu02LBL3q?=
 =?us-ascii?Q?m2978oBouQ+j7RE+NuFDZactCzhEb+Y3BaOGVGB9kCQ0aaFoqG0rGrL/9HaI?=
 =?us-ascii?Q?xwS7bb+ySQ9gr8JbdsxSKwqynSFXjs9Hq4ldNRBUikf7jIosLt9a85LrvGry?=
 =?us-ascii?Q?ZgwHxpNOwYbrq2ID+3e2aex0gShkqABQSL7uPeetTrknjC15cpuXJi/1H8k2?=
 =?us-ascii?Q?L+5kIUO7uwjjTyDOwWi+8r8E+ep8MOJS3yZF6qIR/B9t/sf84tKCOLmSHCi1?=
 =?us-ascii?Q?+MaQ+z1M5VFJ8Wag55nprt/zKq4oZTi9PS6ffHSXQTT/FqCnS4bDPrG57eX5?=
 =?us-ascii?Q?2+NUdmA7F9Pi7Xqz/YWuB5Q1YJmt8R9rkuhDH8VMD/hijn7FUtvil+wgVqre?=
 =?us-ascii?Q?jeAU7UU3nHdKknuV1Mj6ivLwmCtIUeqhHeS8a7DpLEFxRoRyHWsf9m1TXyfj?=
 =?us-ascii?Q?PBTv+MDG2c0xO/R7tGMv7ut7KOczcDXfGemQAQsXjvZTj/xtCsnK4793Gznb?=
 =?us-ascii?Q?0Mnqh6wDTOCc0G+eyiJzyLrpVYlKcDbGBgucmA2siRH9VJ24AKI+CUjgIqmU?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91853136-444c-4338-3f79-08dc13da47dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 01:52:21.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dROxd8OL1WuEekJeCnVnUrKLcLd7LKMQ6kiJ4ImuYpy/yNJlXTdvSjXig7S2/y060ZCwWEcILm3nyZgX+XMVwvuXZJsqoDbtKLWXl+wvCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.8

...to receive the CXL update for this cycle.

The bulk of this update is support for enumerating the performance
capabilities of CXL memory targets and connecting that to a platform CXL
memory QoS class. Some follow-on work remains to hook up this data into
core-mm policy, but that is saved for v6.9. The next significant update
is unifying how CXL event records (things like background scrub errors)
are processed between so called "firmware first" and native error record
retrieval. The CXL driver handler that processes the record retrieved
from the device mailbox is now the handler for that same record format
coming from an EFI/ACPI notification source. It also contains
miscellaneous feature updates, like Get Timestamp, and other fixups.

This has all appeared in -next with some conflicts identified with the
ACPI tree. My resolution against your tree as of this evening is
included below. It otherwise to my knowledge has no open reports. It has
acks from Ard, Bjorn, Greg, and Rafael where appropriate.

Now, since this pull request message is also read by others keeping tabs
on the CXL subsystem, there is some additional color to add. For someone
who might be interested in platform firmware history, i.e. the evolution
of data structures passed to an OS to enumerate memory resources and
capabilities, I think this update marks an inflection point.

ACPI has long enumerated details about the platform that have no
standard enumeration. It produces tables like SRAT, SLIT, and HMAT to
describe the NUMA topology (ACPI proximity domains) and the relative
performance of an initiator, like a CPU, in one proximity domain talking
to a target, like memory, in another. 

The algorithm for where proximity domain boundaries are drawn and the
veracity of the "NUMA distance" values have long been in the category
of, "just trust the ACPI tables". However, with this update Linux is
empowered, at least for CXL, to enumerate those details itself. This is
important because ACPI is a boot time static enumeration with limited
update capabilities. That limitation is a liability in a CXL world that
supports hotplug, dynamic reconfiguration, pooling, and accelerators
with their own memory subsystems.

So now when core-mm developers notice broken memory NUMA information
they can send a patch to the CXL subsystem rather than a bug report to
the platform vendor.

---

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.8

for you to fetch changes up to 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5:

  cxl/core: use sysfs_emit() for attr's _show() (2024-01-12 14:47:04 -0800)

----------------------------------------------------------------
cxl for v6.8

- Add support for parsing the Coherent Device Attribute Table (CDAT)

- Add support for calculating a platform CXL QoS class from CDAT data

- Unify the tracing of EFI CXL Events with native CXL Events.

- Add Get Timestamp support

- Miscellaneous cleanups and fixups

----------------------------------------------------------------
Alison Schofield (1):
      cxl/region: Add dev_dbg() detail on failure to allocate HPA space

Dan Williams (6):
      Merge branch 'for-6.8/cxl-cdat' into for-6.8/cxl
      cxl/port: Fix missing target list lock
      Merge branch 'for-6.8/cxl-cdat' into for-6.8/cxl
      Merge branch 'for-6.8/cxl-misc' into for-6.8/cxl
      Merge branch 'for-6.7/cxl' into for-6.8/cxl
      Merge branch 'for-6.8/cxl-cper' into for-6.8/cxl

Dave Jiang (25):
      cxl: Fix unregister_region() callback parameter assignment
      lib/firmware_table: tables: Add CDAT table parsing support
      base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
      acpi: numa: Create enum for memory_target access coordinates indexing
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: Break out nesting for hmat_parse_locality()
      acpi: numa: Add setting of generic port system locality attributes
      acpi: numa: Add helper function to retrieve the performance attributes
      cxl: Add callback to parse the DSMAS subtables from CDAT
      cxl: Add callback to parse the DSLBIS subtable from CDAT
      cxl: Add callback to parse the SSLBIS subtable from CDAT
      cxl: Add support for _DSM Function for retrieving QTG ID
      cxl: Calculate and store PCI link latency for the downstream ports
      tools/testing/cxl: Add hostbridge UID string for cxl_test mock hb devices
      cxl: Store the access coordinates for the generic ports
      cxl: Add helper function that calculate performance data for downstream ports
      cxl: Compute the entire CXL path latency and bandwidth data
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QoS class
      cxl: Check qos_class validity on memdev probe
      cxl: Introduce put_cxl_root() helper
      cxl: Convert find_cxl_root() to return a 'struct cxl_root *'
      cxl: Fix device reference leak in cxl_port_perf_data_calculate()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_find_nvdimm_bridge()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_endpoint_port_probe()

Davidlohr Bueso (1):
      cxl: Add Support for Get Timestamp

Huang Ying (1):
      cxl/port: Fix decoder initialization when nr_targets > interleave_ways

Ira Weiny (9):
      cxl/trace: Pass UUID explicitly to event traces
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Create common event UUID defines
      cxl/events: Remove passing a UUID to known event traces
      cxl/events: Separate UUID from event structures
      cxl/events: Create a CXL event union
      acpi/ghes: Process CXL Component Events
      PCI: Introduce cleanup helpers for device reference counts and locks
      cxl/pci: Register for and process CPER events

Jim Harris (1):
      cxl/region: fix x9 interleave typo

Randy Dunlap (1):
      cxl/region: use %pap format to print resource_size_t

Shiyang Ruan (1):
      cxl/core: use sysfs_emit() for attr's _show()

 Documentation/ABI/testing/sysfs-bus-cxl |  34 +++
 MAINTAINERS                             |   1 +
 drivers/acpi/apei/ghes.c                |  89 ++++++
 drivers/acpi/numa/hmat.c                | 193 ++++++++++--
 drivers/acpi/tables.c                   |   5 +-
 drivers/base/node.c                     |  12 +-
 drivers/cxl/Kconfig                     |   3 +
 drivers/cxl/acpi.c                      | 155 +++++++++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cdat.c                 | 521 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/core.h                 |   2 +
 drivers/cxl/core/mbox.c                 |  83 +++--
 drivers/cxl/core/memdev.c               |   2 +-
 drivers/cxl/core/pci.c                  |  36 +++
 drivers/cxl/core/pmem.c                 |   8 +-
 drivers/cxl/core/port.c                 | 167 ++++++++--
 drivers/cxl/core/region.c               |  15 +-
 drivers/cxl/core/trace.h                |  14 +-
 drivers/cxl/cxl.h                       |  47 ++-
 drivers/cxl/cxlmem.h                    | 132 +++-----
 drivers/cxl/cxlpci.h                    |  13 +
 drivers/cxl/mem.c                       |  67 +++-
 drivers/cxl/pci.c                       |  58 +++-
 drivers/cxl/port.c                      |   8 +-
 drivers/pci/pci.c                       |  38 ++-
 include/linux/acpi.h                    |  11 +
 include/linux/cxl-event.h               | 161 ++++++++++
 include/linux/fw_table.h                |  21 +-
 include/linux/memory-tiers.h            |  10 +-
 include/linux/node.h                    |   8 +-
 include/linux/pci.h                     |   3 +
 include/uapi/linux/cxl_mem.h            |   1 +
 lib/fw_table.c                          |  75 ++++-
 mm/memory-tiers.c                       |  12 +-
 tools/testing/cxl/Kbuild                |   1 +
 tools/testing/cxl/test/cxl.c            |   4 +
 tools/testing/cxl/test/mem.c            | 163 +++++-----
 37 files changed, 1845 insertions(+), 329 deletions(-)
 create mode 100644 drivers/cxl/core/cdat.c
 create mode 100644 include/linux/cxl-event.h

---
Sample conflict resolution:

diff --cc drivers/acpi/apei/ghes.c
index ab2a82cb1b0b,56a5d2ef9e0a..000000000000
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@@ -706,7 -762,23 +779,23 @@@ static bool ghes_do_proc(struct ghes *g
  			ghes_handle_aer(gdata);
  		}
  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 -			queued = ghes_handle_arm_hw_error(gdata, sev);
 +			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+ 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+ 			struct cxl_cper_event_rec *rec =
+ 				acpi_hest_get_payload(gdata);
+ 
+ 			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+ 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+ 			struct cxl_cper_event_rec *rec =
+ 				acpi_hest_get_payload(gdata);
+ 
+ 			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+ 		} else if (guid_equal(sec_type,
+ 				      &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+ 			struct cxl_cper_event_rec *rec =
+ 				acpi_hest_get_payload(gdata);
+ 
+ 			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
  		} else {
  			void *err = acpi_hest_get_payload(gdata);
  
diff --cc include/linux/acpi.h
index 118a18b7ff84,8b0761c682f9..000000000000
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@@ -424,13 -425,16 +425,23 @@@ extern int acpi_blacklisted(void)
  extern void acpi_osi_setup(char *str);
  extern bool acpi_osi_is_win8(void);
  
 +#ifdef CONFIG_ACPI_THERMAL_LIB
 +int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
 +int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
 +int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
 +int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 +#endif
 +
+ #ifdef CONFIG_ACPI_HMAT
+ int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+ #else
+ static inline int acpi_get_genport_coordinates(u32 uid,
+ 					       struct access_coordinate *coord)
+ {
+ 	return -EOPNOTSUPP;
+ }
+ #endif
+ 
  #ifdef CONFIG_ACPI_NUMA
  int acpi_map_pxm_to_node(int pxm);
  int acpi_get_node(acpi_handle handle);
diff --cc lib/fw_table.c
index c49a09ee3853,1e5e0b2f7012..000000000000
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@@ -85,9 -98,27 +98,22 @@@ acpi_get_subtable_type(char *id
  	return ACPI_SUBTABLE_COMMON;
  }
  
- static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
- 					  union acpi_subtable_headers *hdr,
- 					  unsigned long end)
+ static unsigned long __init_or_fwtbl_lib
+ acpi_table_get_length(enum acpi_subtable_type type,
+ 		      union fw_table_header *header)
+ {
+ 	if (type == CDAT_SUBTABLE) {
+ 		__le32 length = (__force __le32)header->cdat.length;
+ 
+ 		return le32_to_cpu(length);
+ 	}
+ 
+ 	return header->acpi.length;
+ }
+ 
 -static __init_or_fwtbl_lib bool has_handler(struct acpi_subtable_proc *proc)
 -{
 -	return proc->handler || proc->handler_arg;
 -}
 -
+ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
+ 					    union acpi_subtable_headers *hdr,
+ 					    unsigned long end)
  {
  	if (proc->handler)
  		return proc->handler(hdr, end);
@@@ -127,10 -158,14 +153,13 @@@ acpi_parse_entries_array(char *id, unsi
  {
  	unsigned long table_end, subtable_len, entry_len;
  	struct acpi_subtable_entry entry;
+ 	enum acpi_subtable_type type;
  	int count = 0;
 -	int errs = 0;
  	int i;
  
- 	table_end = (unsigned long)table_header + table_header->length;
+ 	type = acpi_get_subtable_type(id);
+ 	table_end = (unsigned long)table_header +
+ 		    acpi_table_get_length(type, table_header);
  
  	/* Parse all entries looking for a match. */
  
@@@ -168,9 -209,31 +197,31 @@@
  	}
  
  	if (max_entries && count > max_entries) {
 -		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
 -			id, proc->id, count);
 +		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
 +			id, proc->id, count - max_entries, count);
  	}
  
 -	return errs ? -EINVAL : count;
 +	return count;
  }
+ 
+ int __init_or_fwtbl_lib
+ cdat_table_parse(enum acpi_cdat_type type,
+ 		 acpi_tbl_entry_handler_arg handler_arg,
+ 		 void *arg,
+ 		 struct acpi_table_cdat *table_header)
+ {
+ 	struct acpi_subtable_proc proc = {
+ 		.id		= type,
+ 		.handler_arg	= handler_arg,
+ 		.arg		= arg,
+ 	};
+ 
+ 	if (!table_header)
+ 		return -EINVAL;
+ 
+ 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
+ 					sizeof(struct acpi_table_cdat),
+ 					(union fw_table_header *)table_header,
+ 					&proc, 1, 0);
+ }
+ EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);

