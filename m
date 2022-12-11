Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86C26491B2
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 02:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLKByc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 20:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKByb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 20:54:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C211C39;
        Sat, 10 Dec 2022 17:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670723670; x=1702259670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nA6V+UeuC0kcHE0CB5Kv+A+Ut6mFlwwqjElTcOuo6H4=;
  b=bubOPc9z0BX84YFsDv4X1KTgp5c+IJoQ9twRctvc2Gxccw/+wLdxK20W
   88YrDl3P3R1kjaOR5o8usjEx/5PTIBM2EhAYzSyGduNkaoTjQM95by02f
   atkfE0gTQmxXsMW2+SycL/KmZNTpiB5OtpM9ivDIXYDVgCqIzaFuB+KYR
   VYQ2/C5eXuF81efpT9ou1BYQbHOZTDK/rseheGoVLKTC/kDXwKVOxiIUG
   uVRFlY7PDrjfdz3sco6P/fsbozAv8Acn6o2dmgC+L97tvSIHTNiFQAOd4
   JiRp3VAJ+OTccCC0TzMoK9GnQQG7SuIp0DS6uVJysc++N6LKDZXuC/cJ6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="305307755"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="305307755"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 17:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="641375941"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="641375941"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2022 17:54:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 10 Dec 2022 17:54:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 10 Dec 2022 17:54:29 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 10 Dec 2022 17:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en0MQLC4XiDj8mIGwf/YEve3fiaUn1ozf7ScmqZFUSBQfsLUlHedTztMkRzXDNQzVzzmo+2sYhPDPhn8OdzCqFtWPtbxRC4NU0yTDsoOviuwo4/4kMpzrRSbeMUwS7U8ovNVNxLLXULCfCl8lqN4KlHY3i+1lFGpCTtFqsij718fMygFZT2j//gnjAt9Y6Izjz4BoyzcO1DaIc9uoJ7P7tIxBRBPO0j7RCaNHMG8PvxL5jD3wQFzVYBamGw6zYilELxybl5rOEg7g1rAL3OYnKeP7FJrON3jPEhNjZzlrqPxUVgMOpKLJ3srBq2ziBl0KVqskJHi46m8M9fCn41pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEABLpuIGG9IryLuTFeHcTlFItD5MZyS4n3cMJJsG0I=;
 b=CiriXF/zPCApJBs3kPdB6SPFsfkeBwzB8cM5sOpUYdPm0l7CtbGssbGRMoQGpVf7BKgJjDfa9fxU+ssqb5t8oKonAJjgZ6RoIEUXnm/JzLAzKpxKCsEEHIEoYLvMTUg86PO74wE2AeMlWfVhwvUcNtvlvcINDSoqcETiyjBOJg9sTrs2sevIj4ZiCdcigWe+XweQ8yPcvBEpxFfZI7D/gAknrZjDIddFugvsCOVZoKOI8vGBPgb6LaxIfcZdgEO/5CTYHFx9bV9RmHSofzqqLwaHf5SpqY79fHAh3QEO3gVl/0uIl58kgqsR8ituS0ndgXqOg9pZ8+VJHbj1/LtRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7196.namprd11.prod.outlook.com
 (2603:10b6:930:94::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 01:54:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 01:54:14 +0000
Date:   Sat, 10 Dec 2022 17:54:02 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.2
Message-ID: <6395383a608a5_4962d294e9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: bf465913-96c9-411b-50ec-08dadb1a9b16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26XXsJ33TyLegHzsKGJnyKS8TEQpDoxATADzc0Kx0fkBo+4taOhiNpQMBwaJmmB9JGIgDcU0afwIiExyuQEHAmNdHS2TghIbZPkaI3/6kQXrPQRA1FyUOUgKBVr7AU7oLL7PezlalO9DgLUpbAvz8Zs9VT7Ywkky0BJIY0M6kDys3ZP3EWRXeiQeTQs6FVyXmiIqRLWwle8L452czs8wRxiShadkmSlUWr8qqBqpwi3OlzVXC4uiIX6/ZR/d3XLsLyVUOh5O0ZgO6Qi6p7voGlzuBssJKTfzLvUOxEJiU4nSc76oHJCHCMDyhnz8ax49H6fLfbArImjFd39p2/gO/pB4GvNIKCXVLfC7bK5wVMLAEOSWVZjJDUSQkXsQjkMbHdNU6T1O6LWfEO0FXEFgSM+ic7WHXSNKSPy/TKmyi4glX9BSmNl9NeEvlCwQRfvO0gj05x2xVpu3oF3hmYFqIxn2W0yYfmt/fFaS6AW85P5ilHK4085FkZFQlB6Ewz9A1auNmTXn3H5HDE6GvAHODHbh/qE9E/h+vmYRrBNgIDfBJvD+JZOZ042ABOwEhNjy7MSRWW46ZzD7h6LEj8KpWUixJCiXA9ZHC3e5iOK0HSOGTizfF+H/rq5L2CxkXYclTxn1RsJjhDlSLh/Igf4vyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(478600001)(6666004)(6486002)(41300700001)(5660300002)(8676002)(4326008)(316002)(2906002)(6916009)(66946007)(66476007)(66556008)(8936002)(86362001)(38100700002)(6512007)(9686003)(26005)(6506007)(83380400001)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Za8C3b5nlXfgNLXbg5ipT88jdZp3Old0vb/ZmdVXeYfLWbD5Hh/LbSsi66V5?=
 =?us-ascii?Q?nNVgn/RJ4n7/roFXXFGaV0tITA16PMmF4ZZ0iVAKQFdxRvgteAUIT1APqpcB?=
 =?us-ascii?Q?6i9HJ1Zx0E5H6Wm4/Zl0NGtYgmdc04g0uoRbhEzlPMZgeTh45yt+arH0p30G?=
 =?us-ascii?Q?5O5VJ021lp1M5m3waVQ0ztFu6WbWjDfmikAfSjhQr5d9ub3ZjAUlwvPfdpjg?=
 =?us-ascii?Q?eRWWciiTjh2ntwbjWOCpxNQyDPqwRuYoVlLjswGYgz12c4saorogMo1napNz?=
 =?us-ascii?Q?jvh2yFD3fZd/DVS2/yvu92jLvzd15VQnkvF9w4FhA0uXfglF/pIcSUuR+OO0?=
 =?us-ascii?Q?4Sw225PSgH36LX9qxDqinFB3j+V7AtwDEnKp0AvUOqHRHf57fmqSfi5uu+y9?=
 =?us-ascii?Q?iePY1e4lczCv78q3kuJjIBcbuz1fFIe7gdPsUB6+6MKFSGiHul5YB1GeSFZY?=
 =?us-ascii?Q?4ezaiXrZz0S2reNaktQ9TzVJ/2ZZLbwKvABtUK0E4D33R9EUh04I1oOae3fn?=
 =?us-ascii?Q?EjMSXcEh8eObdEUkgI873XfR1J0zRqVsalCFXWji00EkMdpyH+R89tO8l2+X?=
 =?us-ascii?Q?kC1hO047mRICkbQWmtxhWCOEK0LQXkLCu67hQa3z3vjesjYUIehEh/dx+y0N?=
 =?us-ascii?Q?MLwIYDis70S3wyCylXAoQmz76wk9FIi9UOm4ArklW4UiYgLH+Og0PCG2wssc?=
 =?us-ascii?Q?wjGvxPrWdSmDjlJrH5HjjpMWy+2U4m4I3aNur4x4KjxV/v70TnQwFD+PJb9z?=
 =?us-ascii?Q?akoTRJi60AzDz+Cr5RN1MUeTMFe4MldkQaViyCRw8UdN0IGbhr0JIp5PQaBL?=
 =?us-ascii?Q?D2pXkM8rtvej3a1d7hGiw/Z00OCPgPuqaofwunPGuRhnjntxIvOtCnpLXBmK?=
 =?us-ascii?Q?jMXMWp/RolY+jJVIszhTZmve8h+piPr/Z2ANTYq+qZAhiijC0hRAdr6enxzn?=
 =?us-ascii?Q?xBfceMGIBWMN5WzwJuz3Btgl9AENnmqMAAmqtlzjPk3lxMWYkTJ6ue6YBBh6?=
 =?us-ascii?Q?PiN8K5gAtHXeQ49gxjbaVD+ELvl6ztp40/y9X51WzmizCFUE6JXq5lov6+X1?=
 =?us-ascii?Q?ZoRl6ASoHTMVbqdOlhwwG8nGUDaRwmhwWmxtuJ3JXBMpFqWIYzuocK/dEiGu?=
 =?us-ascii?Q?YD6MxC1SxkLJ7NylX7TPcWaKYMxsCikHcFiQtpmzoI8waxdmNPnuN26QPMTO?=
 =?us-ascii?Q?4+g+p+YWO4353GQsgeaUDWai0NqINjGOMQXagsLZAOEHg+nmlxL43HsbqzG0?=
 =?us-ascii?Q?7w493eYWV0QPA+KVAjLXcYsy2lHmSb0QflajkcR8unz4SXdo5wK+KJIccg1I?=
 =?us-ascii?Q?PAU4jMYZCxSejYGAzyTe07WwmDAQqfXEIanHcUqNSgNvQG7SUoYNXc3zFqGp?=
 =?us-ascii?Q?XY+28+k7FR79u5ZKPq0orMysBwPYN0oVpTdqgMQmkaxhQbdWnR/ugRmsR6Kk?=
 =?us-ascii?Q?Lh4Y0VIPkcO0KZuD2Bwr4QcltgTplIzhtgxhVM9BPcXMPRrjTvEArciDt3QD?=
 =?us-ascii?Q?aGqSolWfIZDaVPSmYGyK8/V5Eo+N8BhR1vByVnJ1loNOFXCIAntrClBwdgNO?=
 =?us-ascii?Q?GLtkGp0l4ejvbMu5WsMSR85zUYGSmE5CR4dKk1m1eruYtTzqrWJGOM2ECwRb?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf465913-96c9-411b-50ec-08dadb1a9b16
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 01:54:14.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW+9VBWeuDBJOUJPIu/6i2fsSkAvxx0Dayz/kZe0As3ZrNIbD4K2JlKPrdyZD9ScEEm0z0UATM1W59VdwhqfQxOlUjby0QJqI80SPlZnCrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.2

...to receive the CXL update for v6.2.

While it may seem backwards, the CXL update this time around includes
some focus on CXL 1.x enabling where the work to date had been with CXL
2.0 (VH topologies) in mind.  First generation CXL can mostly be
supported via BIOS, similar to DDR, however it became clear there are
use cases for OS native CXL error handling and some CXL 3.0 endpoint
features can be deployed on CXL 1.x hosts (Restricted CXL Host (RCH)
topologies). So, this update brings RCH topologies into the Linux CXL
device model.

In support of the ongoing CXL 2.0+ enabling 2 new core kernel
facilities are added. One is the ability for the kernel to flag
collisions between userspace access to PCI configuration registers and
kernel accesses. This is brought on by the PCIe Data-Object-Exchange
(DOE) facility, a hardware mailbox over config-cycles. The other is a
cpu_cache_invalidate_memregion() API that maps to wbinvd_on_all_cpus()
on x86. To prevent abuse it is disabled in guest VMs and architectures
that do not support it yet. The CXL paths that need it, dynamic memory
region creation and security commands (erase / unlock), are disabled
when it is not present.

As for the CXL 2.0+ this cycle the subsystem gains support Persistent
Memory Security commands, error handling in response to PCIe AER
notifications, and support for the "XOR" host bridge interleave
algorithm.

That last feature, "XOR" interleave support, is built on top of the
ACPICA update for this cycle [1]. The shortlog and diffstat below are
from a test merge with the pending ACPI updates. So either pull the ACPI
tree first, or understand you will get some unrelated ACPICA updates in
this pull.

This has all appeared in -next with no known outstanding issues. The
x86, ACPI, and PCI touches have acks from their respective maintainers.

[1]: f350c68e3cd5 ("ACPICA: Add CXL 3.0 structures (CXIMS & RDPAS) to the CEDT table")

---

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.2

for you to fetch changes up to f04facfb993de47e2133b2b842d72b97b1c50162:

  cxl/region: Fix memdev reuse check (2022-12-08 13:03:47 -0800)

----------------------------------------------------------------
cxl for 6.2

- Add the cpu_cache_invalidate_memregion() API for cache flushing in
  response to physical memory reconfiguration, or memory-side data
  invalidation from operations like secure erase or memory-device unlock.

- Add a facility for the kernel to warn about collisions between kernel
  and userspace access to PCI configuration registers

- Add support for Restricted CXL Host (RCH) topologies (formerly CXL 1.1)

- Add handling and reporting of CXL errors reported via the PCIe AER
  mechanism

- Add support for CXL Persistent Memory Security commands

- Add support for the "XOR" algorithm for CXL host bridge interleave

- Rework / simplify CXL to NVDIMM interactions

- Miscellaneous cleanups and fixes

----------------------------------------------------------------

Adam Manzanares (1):
      cxl: Replace HDM decoder granularity magic numbers

Alison Schofield (3):
      cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
      tools/testing/cxl: Add XOR Math support to cxl_test
      cxl/acpi: Fail decoder add if CXIMS for HBIG is missing

Colin Ian King (1):
      cxl/region: Fix spelling mistake "memergion" -> "memregion"

Dan Williams (34):
      tools/testing/cxl: Add bridge mocking support
      cxl/acpi: Simplify cxl_nvdimm_bridge probing
      cxl/region: Drop redundant pmem region release handling
      cxl/pmem: Refactor nvdimm device registration, delete the workqueue
      cxl/pmem: Remove the cxl_pmem_wq and related infrastructure
      cxl/acpi: Move rescan to the workqueue
      tools/testing/cxl: Make mock CEDT parsing more robust
      cxl/region: Fix missing probe failure
      cxl/pmem: Enforce keyctl ABI for PMEM security
      nvdimm/region: Move cache management to the region driver
      cxl/region: Manage CPU caches relative to DPA invalidation events
      cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
      cxl/pci: Cleanup cxl_map_device_regs()
      cxl/pci: Kill cxl_map_regs()
      cxl/core/regs: Make cxl_map_{component, device}_regs() device generic
      cxl/port: Limit the port driver to just the HDM Decoder Capability
      cxl/pci: Prepare for mapping RAS Capability Structure
      cxl/pci: Find and map the RAS Capability Structure
      cxl/pci: Add (hopeful) error handling support
      Merge "ACPICA: Add CXL 3.0 structures..." into for-6.2/cxl-xor
      cxl/mem: Move devm_cxl_add_endpoint() from cxl_core to cxl_mem
      cxl/port: Add RCD endpoint port enumeration
      tools/testing/cxl: Add an RCH topology
      Merge branch 'for-6.2/cxl-security' into for-6.2/cxl
      Merge branch 'for-6.2/cxl-aer' into for-6.2/cxl
      Merge branch 'for-6.2/cxl-xor' into for-6.2/cxl
      cxl/regs: Fix sparse warning
      tools/testing/cxl: Require cache invalidation bypass
      cxl/security: Fix Get Security State output payload endian handling
      cxl/mbox: Enable cxl_mbox_send_cmd() users to validate output size
      cxl/mbox: Add variable output size validation for internal commands
      cxl/security: Drop security command ioctl uapi
      cxl/pci: Add some type-safety to the AER trace points
      cxl/pci: Remove endian confusion

Dave Jiang (23):
      cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation
      tools/testing/cxl: Add "Get Security State" opcode support
      cxl/pmem: Add "Set Passphrase" security command support
      tools/testing/cxl: Add "Set Passphrase" opcode support
      cxl/pmem: Add Disable Passphrase security command support
      tools/testing/cxl: Add "Disable" security opcode support
      cxl/pmem: Add "Freeze Security State" security command support
      tools/testing/cxl: Add "Freeze Security State" security opcode support
      cxl/pmem: Add "Unlock" security command support
      tools/testing/cxl: Add "Unlock" security opcode support
      cxl/pmem: Add "Passphrase Secure Erase" security command support
      tools/testing/cxl: Add "passphrase secure erase" opcode support
      nvdimm/cxl/pmem: Add support for master passphrase disable security command
      cxl/pmem: add id attribute to CXL based nvdimm
      tools/testing/cxl: add mechanism to lock mem device for testing
      cxl/pmem: add provider name to cxl pmem dimm attribute group
      libnvdimm: Introduce CONFIG_NVDIMM_SECURITY_TEST flag
      cxl: add dimm_id support for __nvdimm_create()
      cxl/pci: add tracepoint events for CXL RAS
      PCI/AER: Add optional logging callback for correctable error
      cxl/pci: Add callback to log AER correctable error
      cxl: update names for interleave granularity conversion macros
      cxl: update names for interleave ways conversion macros

Davidlohr Bueso (1):
      memregion: Add cpu_cache_invalidate_memregion() interface

Fan Ni (1):
      cxl/region: Fix memdev reuse check

Ira Weiny (2):
      PCI: Allow drivers to request exclusive config regions
      cxl/doe: Request exclusive DOE access

Robert Richter (8):
      cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
      cxl/core: Check physical address before mapping it in devm_cxl_iomap_block()
      cxl: Unify debug messages when calling devm_cxl_add_port()
      cxl: Unify debug messages when calling devm_cxl_add_dport()
      cxl/acpi: Improve debug messages in cxl_acpi_probe()
      cxl/ACPI: Register CXL host ports by bridge device
      cxl/acpi: Extract component registers of restricted hosts from RCRB
      cxl/acpi: Warn about an invalid CHBCR in an existing CHBS entry

Terry Bowman (1):
      cxl/acpi: Set ACPI's CXL _OSC to indicate RCD mode support

 Documentation/ABI/testing/sysfs-bus-nvdimm |  14 +
 Documentation/PCI/pci-error-recovery.rst   |   7 +
 arch/x86/Kconfig                           |   1 +
 arch/x86/mm/pat/set_memory.c               |  18 ++
 drivers/acpi/nfit/intel.c                  |  30 +-
 drivers/acpi/pci_root.c                    |   1 +
 drivers/cxl/Kconfig                        |  18 ++
 drivers/cxl/Makefile                       |   2 +-
 drivers/cxl/acpi.c                         | 275 ++++++++++++++---
 drivers/cxl/core/core.h                    |   8 -
 drivers/cxl/core/hdm.c                     |  45 +--
 drivers/cxl/core/mbox.c                    | 102 ++++---
 drivers/cxl/core/memdev.c                  |   1 +
 drivers/cxl/core/pci.c                     |   5 +-
 drivers/cxl/core/pmem.c                    | 109 ++++---
 drivers/cxl/core/port.c                    | 216 +++++++++-----
 drivers/cxl/core/region.c                  | 112 ++++++-
 drivers/cxl/core/regs.c                    | 242 ++++++++++-----
 drivers/cxl/cxl.h                          | 140 +++++----
 drivers/cxl/cxlmem.h                       |  64 +++-
 drivers/cxl/cxlpci.h                       |   9 -
 drivers/cxl/mem.c                          |  74 ++++-
 drivers/cxl/pci.c                          | 228 ++++++++++++---
 drivers/cxl/pmem.c                         | 407 ++++++--------------------
 drivers/cxl/security.c                     | 202 +++++++++++++
 drivers/nvdimm/Kconfig                     |  12 +
 drivers/nvdimm/dimm_devs.c                 |   9 +-
 drivers/nvdimm/region.c                    |  11 +
 drivers/nvdimm/region_devs.c               |  50 +++-
 drivers/nvdimm/security.c                  |  43 ++-
 drivers/pci/pci-sysfs.c                    |   7 +
 drivers/pci/pcie/aer.c                     |   8 +-
 drivers/pci/probe.c                        |   6 +
 include/linux/ioport.h                     |   2 +
 include/linux/libnvdimm.h                  |   7 +
 include/linux/memregion.h                  |  38 +++
 include/linux/pci.h                        |  20 ++
 include/trace/events/cxl.h                 | 112 +++++++
 include/uapi/linux/pci_regs.h              |   1 +
 kernel/resource.c                          |  13 +-
 lib/Kconfig                                |   3 +
 tools/testing/cxl/Kbuild                   |   2 +
 tools/testing/cxl/config_check.c           |   2 +
 tools/testing/cxl/test/cxl.c               | 303 +++++++++++++++++--
 tools/testing/cxl/test/mem.c               | 453 ++++++++++++++++++++++++++++-
 tools/testing/cxl/test/mock.c              |  19 ++
 tools/testing/cxl/test/mock.h              |   3 +
 tools/testing/nvdimm/Kbuild                |   1 -
 tools/testing/nvdimm/dimm_devs.c           |  30 --
 49 files changed, 2649 insertions(+), 836 deletions(-)
 create mode 100644 drivers/cxl/security.c
 create mode 100644 include/trace/events/cxl.h
 delete mode 100644 tools/testing/nvdimm/dimm_devs.c
