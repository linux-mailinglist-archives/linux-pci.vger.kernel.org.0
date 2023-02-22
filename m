Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBF69EE3A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBVFP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 00:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBVFPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 00:15:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EA311F5;
        Tue, 21 Feb 2023 21:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677042922; x=1708578922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZF3HK/IonDTmamGIuH51tTXOky50t1HCddVHRcfeRw=;
  b=UQdidb0VuBjMqrQdaeVW4ByHBhIqzBtNXofxQQHYDhcYvpNVJJufDOPe
   aCTn5S8b3Xo9dQijh2h4sOBq0BNjEjDbaZJhy46eITS3GwOVQ1aTeIhiG
   Ki2d+yWBrOUvkp2sOgq8QT+OqrdPEEbzze97dZW8kyau4+eSCZTCtCMMd
   H5ONPAGUWYqJZWdz8yXwLPOOYlMypIgbRe2kcOxEbZIkcMID50M03ME2W
   IrHGGJFWVgjU2eIlHzzeIt1vQhQKbgnmToeHgN59IdelvcZbAm9bSAId6
   W8k/ccXTx6BPKlbH3W90LPai92Ozlu37SajZ5dgOwWiPUWLIef1k2N8au
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360317781"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="360317781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 21:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="621774907"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="621774907"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2023 21:15:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 21:15:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 21:15:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 21:15:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 21:15:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILK+SNRhmYcEKptvl5rrqPm+UtWuDGCCNboii0Xq7K2TbJKZFsg/oaoX2KEi9C87yKljCsJMSGJPfsZm1Ys4CXGpOzGNHuUeSTUeg3z4mO3vUB9gL7PQdA8i5WV20MUqOqwv90vdW7RDOgaxUL2+IHS2hv1X73mjOpVGYFwMVrNZdaiBR96icstL+To+NwaoSMoFRIJ3CKCOqRwqA3ZVkMIg9Jv+vJvmLKW3Jed3p8VKnBte1GLhgaPHMhCeqRg7rVYGbrEXFoXtdNccUfRAmEhyNZs/gmvdf5qxGzQyzznNoYILj4QW1Gfp037T5lb0Z/rk5tZRi5vnd9+BE1ZEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGh59go38pgr91gulstjEiPaiXWd0b0YmYXcsvTdEdM=;
 b=OfMbhgVsnWDyxl7FFWSvZ64rlO8liLNV1xsdgTLCwyA46UFHXstnAZGC+05uSI22jkrs//kNHQa5gLXr3pcOZL+PWntvLJ9qAlteXopu1lJ2TlMQRNNnXaGAPyL1ctGcf5cSs2IImeA/JaKboCEOgJemv6Cyy74Tp6rNvFSFl8vXYeZd7GAc7nxzT8me9arrNR+fEOAeIN0H8shYbz4lQIngPnIJopJF75o8HSsevGlCqGIX0fwn9lPQ5uvHDpeHtkNR7sTO+vb3CucDz0w3S6wyND6Hzb0ASKae2aegAsmOUxFpHocVUXDQf6iz52JxhuguEfEmqc5FNynaRVTtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 05:15:18 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::2d60:e304:64cb:71a0]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::2d60:e304:64cb:71a0%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 05:15:18 +0000
Date:   Tue, 21 Feb 2023 21:15:14 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.3
Message-ID: <63f5a4e2277b1_c94229453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9c4929-91f1-4fae-be81-08db1493c96c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0PINZG4EsqGmbA9qs+TyDCDzf+oIHcD/AVboH2e6G8Ljtpilcl/MwCSnuXcthgAhsfsFsPhSJOA7aBSUgLx/JfIpFQZImOe9uxBD3VGKnR1l4TyE6m3PPDq4XkmEUF5Gmk4Um4SnmvnhJPGdX/ztbAUKSak8hVmCFfoRjgHjJvFo8fnNk7pjHM3OXYcPNXrxZFGIZa2iJpfPkQ1GSTVU75tIY91c9fPsg2Fw/4eugN5icN36HnZc1fOD984FWwtmkt1ELZXjKvkAdK5BmKqARFh5egERvj6gHj6jFXYOuq785/AHioeGrKDtKeG0tmG6dzecIvOLtRCpzlf2bsGt3yw6EBFp/ojYTkmh0YZ+4h4T5ce2nUupyyoYnQ03AxV5tgmVqXu5qeBamMtZP1qP+x4X8vjzIKwCNMB6iZj/T8ZcAVNEE1vNsOZK0QEehLKdANLg9brYeaJhT4D65y5cJoDYrBtv6S5Lcr5J6djW9JdDmzdkvmkYY4YtD+brFF++GlYEbr3EEuguW+sfVTENiNDkwqHLTqZZOPy4HJWsEmHqOQ+W+HSks7zcKGyAErVjTchQtL0xTE1AkBkPe3aiU5Pir5skBiGzxuo4NzzCXWVl3w6nKQOBENDhBDggWqx+G+b0yp6lUwrZc7XOdDdKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(26005)(186003)(5660300002)(6486002)(9686003)(6666004)(6512007)(6506007)(478600001)(316002)(83380400001)(8676002)(6916009)(4326008)(41300700001)(8936002)(66556008)(66476007)(66946007)(38100700002)(30864003)(86362001)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrTfJVNZIMIrvoqcLKeXr088Sh/J/ETLWhxPmiqMfrLzqe7ggaZM8rpYX4PU?=
 =?us-ascii?Q?4tTPmKq2jAN+fcrCy8HdoOfTqxwXcnkwZFYGSWGzcn40s8UxQdEebFW06O7n?=
 =?us-ascii?Q?mmH/KF/UYxF/QiMTO+bP+VSOMF/VaAHNzesB8Kj9O/owFzzI4SLNnfjJbaLZ?=
 =?us-ascii?Q?4wagiTE6z1UwPbpC+zJKTLEP+r7QFhycsrl4A4S0bzr1Gfgx3kfk/B2lFshK?=
 =?us-ascii?Q?cx3H7LIc53MDmkHRe6T/IE5DypvLkWwpWuVPofSJR7UPkoE8FMRQkpDoHTBA?=
 =?us-ascii?Q?UVv7o5cf+3ZthKQx8Vk4Tz9Df7anIGKbndx6Qj0VId4dDm9at1GuOutMOajA?=
 =?us-ascii?Q?c7/Cq1p2qJu0gYPY0VXGf74DLlEJhYLW5nKVCd0gjeSxjZ3bjtLe7cvE6zGo?=
 =?us-ascii?Q?iQKmo+FALmhytSWsX58Rw8umu9fjCg8ynGm/UaS8xusrVNUeOfjwOS/znZTy?=
 =?us-ascii?Q?oJxCqNFQQn+4jLVONd7RlM3gzdkNxitUm1Rz5KQQ6MTclq3Cs3SeNofG3sD+?=
 =?us-ascii?Q?W5AT/X2NUVE+pV3iyc0z9ukVyR6OJCj29mYu587fxhepjp951N4EgOdbWR5K?=
 =?us-ascii?Q?8zNiLNcmIKNWSp3DDuCa1axBouvik5Zi62cOtjDDzjmtabsJeuT2jXjmcDqX?=
 =?us-ascii?Q?MD08C+03PqlYlUaxoEK9ssF+DBrgrUfYyNwlQheDrBTSBt5wsJ/r2mG578wh?=
 =?us-ascii?Q?jFb2axsUlKgfckYQr/7t6Eneh1s3B2bocZqtpr+dieuCsXPGGNzhHukwvxA6?=
 =?us-ascii?Q?ZZoXT0h73lLT+9LQAXiQP2i+Xx0o5qF2+iHIFCFHRqWE+XQrVw3lciCYEQQO?=
 =?us-ascii?Q?U61fWdw9V0VpF9JDLzvUivI4arJIgUR/y0jZLF0i1J7sADEmj3stLMSKWpFS?=
 =?us-ascii?Q?T6xil0UUmco+JldJNb3Ncjhz2MYVQoJiBmACwUIZwbDmFaiP4WFTImVF++uc?=
 =?us-ascii?Q?SR4QtnW6000QVMVfZMVJedm2AvQtlYWMXRaIg++pmhLe4gkJmhcQKP5tGzO3?=
 =?us-ascii?Q?sOOuoJKFf0tJU0qwg0sbhJ6Ijwc5GdSXvK9iLJkQjV7XX2YzdqHwzeCRCneQ?=
 =?us-ascii?Q?jp7p91duy2Ti6gq5/MGOBDunBNbdI6Hpv7+XV8e0QQ8k15snJ1AIx0cDkQOh?=
 =?us-ascii?Q?XVPEZDZ7kJihKfeIdcKLzJi7KHHiQEUEt1DUqODnVa2AzRwUbZGF1Z9K6uou?=
 =?us-ascii?Q?d1u9kqz8MMbOI35X3NxmuJHYAJiW3qyrgbjTpncTSIiN/S2FOElEZU6vGdIy?=
 =?us-ascii?Q?P3CFHdnjlIyRdA9hfEpdannsIpSGogWyZN0FePMluyPTiRQJ+Vgd+9lJPjnV?=
 =?us-ascii?Q?ge0w+eqJAa09Ad4zDd/+oSvHFWk2Pb11Q/LdGtjXRQRKfC1nwr7rlztn3FXQ?=
 =?us-ascii?Q?1CM4j2Mp1HYyA+6j6Y2nHtuIgPzQSVAsvOJVVstT2Rkg5cfWJQuYLn3Y5grY?=
 =?us-ascii?Q?Awqc2qiwlm4a4QfH2ThMDsuIBEx32p2O8X3kG18OzYvygHjRgZxycvS5E58h?=
 =?us-ascii?Q?UwLlTQP4RNbu9yDSzP07D25/M8nfJR0ZZuwT37vaV7g0rIIjmRVkp5dUSqI7?=
 =?us-ascii?Q?SH7e2CNf7k8UYe1pPtRtjq4iEPVituuMk+RPI4w1+n9jgsA9RLoqmjaGrbY6?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9c4929-91f1-4fae-be81-08db1493c96c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 05:15:17.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjFKfj2KIbWZZHWgwqQmoLPGkMEbyldb7BPiAnQSVrv337tHQY0Xv8mjyCiOSvUokFUSKrp+PX090NfINj/YWNP1ZUUR3oLL10512ERrbRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
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

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.3

...to receive the CXL update for v6.3.

To date Linux has been dependent on platform-firmware to map CXL RAM
regions and handle events / errors from devices. With this update Linux
can now parse / update the CXL memory layout, and report events / errors
from devices. This is a precursor for the CXL subsystem to handle the
end-to-end "RAS" flow for CXL memory. I.e. the flow that for
DDR-attached-DRAM is handled by the EDAC driver where it maps system
physical address events to a field-replaceable-unit (FRU / endpoint
device). In general, CXL has the potential to standardize what has
historically been a pile of memory-controller-specific error handling
logic.

Another change of note is the default policy for handling RAM-backed
device-dax instances. Previously the default access mode was "device",
mmap(2) a device special file to access memory. The new default is
"kmem" where the address range is assigned to the core-mm via
add_memory_driver_managed(). This saves typical users from wondering why
their platform memory is not visible via free(1) and stuck behind a
device-file. At the same time it allows expert users to deploy policy
to, for example, get dedicated access to high performance memory, or
hide low performance memory from general purpose kernel allocations.
This affects not only CXL, but also systems with high-bandwidth-memory
that platform-firmware tags with the EFI_MEMORY_SP (special purpose)
designation.

All of these topics have had exposure in linux-next. Where you see
multiple merges of the same topic branch it is for follow-on fixes and
updates discovered after the branch was cut for -next. Each merge has a
commit log. A few tags came in after the branch was cut as well:

    f57aec443c24 cxl/pmem: Fix nvdimm registration races
    Tested-by: Dave Jiang <dave.jiang@intel.com>
    Reviewed-by: Dave Jiang <dave.jiang@intel.com>
    
    e686c32590f4 dax/kmem: Fix leak of memory-hotplug resources
    Reviewed-by: Alistair Popple <apopple@nvidia.com>

After the fixups from Arnd, there have not been any other problem
reports from -next exposure.

---

The following changes since commit 711442e29f16f0d39dd0e2460c9baacfccb9d5a7:

  cxl/region: Fix passthrough-decoder detection (2023-02-07 11:04:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.3

for you to fetch changes up to e686c32590f40bffc45f105c04c836ffad3e531a:

  dax/kmem: Fix leak of memory-hotplug resources (2023-02-17 14:58:01 -0800)

----------------------------------------------------------------
cxl for v6.3

- CXL RAM region enumeration: instantiate 'struct cxl_region' objects
  for platform firmware created memory regions

- CXL RAM region provisioning: complement the existing PMEM region
  creation support with RAM region support

- "Soft Reservation" policy change: Online (memory hot-add)
  soft-reserved memory (EFI_MEMORY_SP) by default, but still allow for
  setting aside such memory for dedicated access via device-dax.

- CXL Events and Interrupts: Takeover CXL event handling from
  platform-firmware (ACPI calls this CXL Memory Error Reporting) and
  export CXL Events via Linux Trace Events.

- Convey CXL _OSC results to drivers: Similar to PCI, let the CXL
  subsystem interrogate the result of CXL _OSC negotiation.

- Emulate CXL DVSEC Range Registers as "decoders": Allow for
  first-generation devices that pre-date the definition of the CXL HDM
  Decoder Capability to translate the CXL DVSEC Range Registers into
  'struct cxl_decoder' objects.

- Set timestamp: Per spec, set the device timestamp in case of hotplug,
  or if platform-firwmare failed to set it.

- General fixups: linux-next build issues, non-urgent fixes for
  pre-production hardware, unit test fixes, spelling and debug message
  improvements.

----------------------------------------------------------------
Alison Schofield (2):
      tools/testing/cxl: Remove cxl_test module math loading message
      cxl/mem: Add kdoc param for event log driver state

Arnd Bergmann (3):
      cxl: avoid returning uninitialized error code
      dax: cxl: add CXL_REGION dependency
      dax/hmem: build hmem device support as module if possible

Dan Williams (35):
      cxl/pci: Move tracepoint definitions to drivers/cxl/core/
      tools/testing/cxl: Prevent cxl_test from confusing production modules
      cxl/region: Clarify when a cxld->commit() callback is mandatory
      cxl/port: Link the 'parent_dport' in portX/ and endpointX/ sysfs
      cxl/pci: Fix irq oneshot expectations
      Merge branch 'for-6.3/cxl' into cxl/next
      Merge branch 'for-6.3/cxl-events' into cxl/next
      cxl/memdev: Fix endpoint port removal
      cxl/Documentation: Update references to attributes added in v6.0
      cxl/region: Add a mode attribute for regions
      cxl/region: Support empty uuids for non-pmem regions
      cxl/region: Validate region mode vs decoder mode
      cxl/region: Add volatile region creation support
      cxl/region: Refactor attach_target() for autodiscovery
      cxl/region: Cleanup target list on attach error
      cxl/region: Move region-position validation to a helper
      kernel/range: Uplevel the cxl subsystem's range_contains() helper
      cxl/region: Enable CONFIG_CXL_REGION to be toggled
      cxl/port: Split endpoint and switch port probe
      cxl/region: Add region autodiscovery
      tools/testing/cxl: Define a fixed volatile configuration to parse
      dax/hmem: Move HMAT and Soft reservation probe initcall level
      dax/hmem: Drop unnecessary dax_hmem_remove()
      dax/hmem: Convey the dax range via memregion_info()
      dax/hmem: Move hmem device registration to dax_hmem.ko
      dax: Assign RAM regions to memory-hotplug by default
      cxl/dax: Create dax devices for CXL RAM regions
      Merge branch 'for-6.3/cxl' into cxl/next
      Merge branch 'for-6.3/cxl-ram-region' into cxl/next
      cxl/pmem: Fix nvdimm registration races
      Merge branch 'for-6.3/cxl-ram-region' into cxl/next
      Merge branch 'for-6.3/cxl' into cxl/next
      Merge branch 'for-6.3/cxl-rr-emu' into cxl/next
      Merge branch 'for-6.3/cxl-events' into cxl/next
      dax/kmem: Fix leak of memory-hotplug resources

Dave Jiang (9):
      cxl: remove unnecessary calling of pci_enable_pcie_error_reporting()
      cxl: add RAS status unmasking for CXL
      cxl/pci: Break out range register decoding from cxl_hdm_decode_init()
      cxl/port: Export cxl_dvsec_rr_decode() to cxl_port
      cxl/pci: Refactor cxl_hdm_decode_init()
      cxl/hdm: Emulate HDM decoder from DVSEC range registers
      cxl/hdm: Create emulated cxl_hdm for devices that do not have HDM decoders
      cxl/hdm: Add emulation when HDM decoders are not committed
      cxl/pci: Remove locked check for dvsec_range_allowed()

Davidlohr Bueso (3):
      cxl/region: Only warn about cpu_cache_invalidate_memregion() once
      cxl/mem: Wire up event interrupts
      cxl/mem: Correct full ID range allocation

Ira Weiny (15):
      PCI/CXL: Export native CXL error reporting control
      cxl/mem: Read, trace, and clear events on driver load
      cxl/mem: Trace General Media Event Record
      cxl/mem: Trace DRAM Event Record
      cxl/mem: Trace Memory Module Event Record
      cxl/test: Add generic mock events
      cxl/test: Add specific events
      cxl/test: Simulate event log overflow
      cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
      cxl/uapi: Add warning on CXL command enum
      cxl/uapi: Tag commands from cxl_query_cmd()
      cxl/mem: Fix UAPI command comment
      cxl/trace: Standardize device information output
      cxl/trace: Add host output to trace points
      cxl/trace: Add serial number to trace points

Jonathan Cameron (2):
      cxl/mbox: Add missing parameter to docs.
      cxl/pci: Set the device timestamp

Luis Chamberlain (1):
      tools/testing/cxl: require 64-bit

Randy Dunlap (1):
      cxl: fix spelling mistakes

Robert Richter (3):
      cxl/pci: Show opcode in debug messages when sending a command
      cxl/mbox: Add debug messages for enabled mailbox commands
      cxl/mbox: Fix Payload Length check for Get Log command

 Documentation/ABI/testing/sysfs-bus-cxl |  79 ++-
 MAINTAINERS                             |   1 +
 drivers/Makefile                        |   2 +-
 drivers/acpi/numa/hmat.c                |   4 +-
 drivers/acpi/pci_root.c                 |   3 +
 drivers/cxl/Kconfig                     |  14 +-
 drivers/cxl/acpi.c                      |   5 +-
 drivers/cxl/core/Makefile               |   3 +
 drivers/cxl/core/core.h                 |   7 +-
 drivers/cxl/core/hdm.c                  | 144 +++++-
 drivers/cxl/core/mbox.c                 | 263 +++++++++-
 drivers/cxl/core/memdev.c               |   3 +-
 drivers/cxl/core/pci.c                  | 316 ++++++++----
 drivers/cxl/core/port.c                 | 123 +++--
 drivers/cxl/core/region.c               | 878 +++++++++++++++++++++++++++++---
 drivers/cxl/core/trace.c                |   5 +
 drivers/cxl/core/trace.h                | 606 ++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  96 +++-
 drivers/cxl/cxlmem.h                    | 186 ++++++-
 drivers/cxl/cxlpci.h                    |  12 +-
 drivers/cxl/pci.c                       | 425 +++++++++++-----
 drivers/cxl/pmem.c                      |   1 +
 drivers/cxl/port.c                      | 119 +++--
 drivers/dax/Kconfig                     |  17 +-
 drivers/dax/Makefile                    |   2 +
 drivers/dax/bus.c                       |  55 +-
 drivers/dax/bus.h                       |  12 +-
 drivers/dax/cxl.c                       |  53 ++
 drivers/dax/device.c                    |   3 +-
 drivers/dax/hmem/Makefile               |   3 +-
 drivers/dax/hmem/device.c               | 102 ++--
 drivers/dax/hmem/hmem.c                 | 148 +++++-
 drivers/dax/kmem.c                      |   5 +-
 drivers/nvdimm/bus.c                    |  19 +-
 drivers/nvdimm/dimm_devs.c              |   5 +-
 drivers/nvdimm/nd-core.h                |   1 +
 drivers/pci/probe.c                     |   1 +
 include/linux/dax.h                     |   7 +-
 include/linux/libnvdimm.h               |   3 +
 include/linux/memregion.h               |   2 +
 include/linux/pci.h                     |   1 +
 include/linux/range.h                   |   5 +
 include/trace/events/cxl.h              | 112 ----
 include/uapi/linux/cxl_mem.h            |  30 +-
 include/uapi/linux/pci_regs.h           |   1 +
 kernel/resource.c                       |  14 -
 lib/stackinit_kunit.c                   |   6 +-
 tools/testing/cxl/Kbuild                |   9 +
 tools/testing/cxl/config_check.c        |   1 +
 tools/testing/cxl/cxl_acpi_test.c       |   6 +
 tools/testing/cxl/cxl_core_test.c       |   6 +
 tools/testing/cxl/cxl_mem_test.c        |   6 +
 tools/testing/cxl/cxl_pmem_test.c       |   6 +
 tools/testing/cxl/cxl_port_test.c       |   6 +
 tools/testing/cxl/test/Kbuild           |   2 +-
 tools/testing/cxl/test/cxl.c            | 165 +++++-
 tools/testing/cxl/test/mem.c            | 352 +++++++++++++
 tools/testing/cxl/test/mock.c           |  36 +-
 tools/testing/cxl/test/mock.h           |   6 +-
 tools/testing/cxl/watermark.h           |  25 +
 60 files changed, 3788 insertions(+), 740 deletions(-)
 create mode 100644 drivers/cxl/core/trace.c
 create mode 100644 drivers/cxl/core/trace.h
 create mode 100644 drivers/dax/cxl.c
 delete mode 100644 include/trace/events/cxl.h
 create mode 100644 tools/testing/cxl/cxl_acpi_test.c
 create mode 100644 tools/testing/cxl/cxl_core_test.c
 create mode 100644 tools/testing/cxl/cxl_mem_test.c
 create mode 100644 tools/testing/cxl/cxl_pmem_test.c
 create mode 100644 tools/testing/cxl/cxl_port_test.c
 create mode 100644 tools/testing/cxl/watermark.h
