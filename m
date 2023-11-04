Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04277E10FA
	for <lists+linux-pci@lfdr.de>; Sat,  4 Nov 2023 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjKDUvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Nov 2023 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjKDUve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Nov 2023 16:51:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B1D54;
        Sat,  4 Nov 2023 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699131091; x=1730667091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZNg5mnqXtOSdb8qcm5WZzzwMdGCRU0a7p2OagOl7No8=;
  b=kvFbNHyzTitu84J7HdkdbtZj92A9F2xSvJ7ylm74AwYY+96QdjK0ALBg
   qjCJqAOCTIESF5GgR+GdtGwe1Z8lhK85c7u7ki/4DbXFXondkm9D/rjrt
   pHotM+p2dYcgiwWWgBYjAdqBZPrfKy94Z1oW8Qhpw/3ZjmZmzjFp84a6J
   WpAdEYu271Zsn+3VyfsEqkY2IbwOvU7VB5olMYvGylpBWKYxck3H0zXA3
   p4hw1wOspVs2Xf4wTYyJpJ4ueabngEtANueB2fJXNokwvqHfWB71nNi1l
   DHy/7B3X7GY0xgrxj4dS0jrRo5PQwHp6t1lk9ul56nxxU/r3XW5EP1bUu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="386284803"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="386284803"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 13:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="832350975"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="832350975"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2023 13:51:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 4 Nov 2023 13:51:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 4 Nov 2023 13:51:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 4 Nov 2023 13:51:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 4 Nov 2023 13:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxkMnMjnoL/5xPS0YGMXs9bDumm9QsxZk6C8D9WIXxoIPPsnAB1Xou/KRl5ZiYKwTmwvOU1OaGh3CKo9zt2sxpkkf2dJ8cUPmCm51PoBU19nCHCHirzp+bfD2K70RbnhTWuIo/34gB93HjQazNDkh0e75U5BTXnq1yiblGTT0LZgyIVcjDxVUIlG7if22YRiafT2nftnDUcmIfo8V7guWtU0/QiZK4w/zvXcw/8KxOpjpvsvhrEOsLWqRm/4KQXEBdNYN4SZ7BMqLGxdhq+r0Tf6Sv4G7xHS6oedgo3Pk2KRw7hzmIRYqwYl6GftsksDB0iVBuUApfuJcQ/Q08cIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRjSwwksQJppwiMoX6izC9pIMDmu8zLukokGDGvm80o=;
 b=JL0MZTguBQPzkHRzmD+lwhcnue0P59a2Z98D1uayUkZTJv9R7AZYrlZT9Kd8EuyFkBnPPxpOdXhnMpALqPi5BsoS7X4/zbYHtmQkadYOSs62ttNoNOq9u33WRR1mNGPzcHEz3DNIOh1hpHGssDAx9ZUq5NxV81Upi7JZdP9dDA0M3g87l0Ce4zMZnx9PAUWHzlMtZlgL+u89Ux5ZXa3VMq0NBDhgIiN3eMrPaSV39RVSn4Zq+3pi30HDeNYc7ebDjbQaISEhbwRhLWqaWO90s7+Vrs1IJt/sPVYnWEJYiydT79d/Ep8kfCHbZCmbufMCQzhUidYb391lZcoAxqX7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Sat, 4 Nov
 2023 20:51:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 20:51:27 +0000
Date:   Sat, 4 Nov 2023 13:51:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.7
Message-ID: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: edad1677-e57c-4125-abdc-08dbdd77cfb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBXihz651vM0s+xSfLtYYnTjCBN3OCaK42nXedW3CEmmvR6e558zCWjzsl0T3zQrZU0vHFTAv0/5O4lRbHAm8D82fEX1/z3F7EK1NLlwazYnskY/ssmDjgANN2/Xo4lwK47AlUQwc7XY+93eFi/Hd9E/M16Y+EgjA+QcTPTtwyUV8VQXoRz26fln9D/X1yzSiZ0is3hLKlx0m3OKP9W+Q7uBs7fo6kB29mMfRhJ77Fb61MeMGbZKXyM9VGaZlKMV6BMUnT7iPsq4w42GhHqUGff9zk5IC1/jsXm0UmqHMiHu+qxpdEdZdW15NbNApc+b2rUnWBSE6/U/Z2dumSiLzGlioYF4ZXL+YckEiVpmgGaCNpxQOgwlbAtySVTrILDyFpZiNnLjKau/F93DfgZqSCDqD0DV/xdDVurNulNTSx5eGOCtY28TlaYXMlGDCIFD57KLhr4UAATWWDWgAUIu049klUx8S5c6e6x/jM87uHWK9dAX3K2ikJEjoe2FIgIuErF2k4Ny+C5VwJzN8NkRQypCtJ0mdZH6T7VjAsUnDEBaihWNjSO4HDCvu/GPES53vELs1hWI2BadLzRLNYLw5J/nuuWas9xvSs9PMRiHhql8x6P9dfGrTGvXCgd6bcsQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799009)(9686003)(6512007)(26005)(6666004)(478600001)(6506007)(2906002)(8676002)(83380400001)(316002)(5660300002)(66946007)(41300700001)(66556008)(8936002)(66476007)(4326008)(6486002)(6916009)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SejRKDt8kJyaCWx1i2a0j8PgeG8+SmPqW4WRlCexYTi+V2RtQcbiWjS6wiv?=
 =?us-ascii?Q?Cyhq1vmKw20smpTfLJWalmaihXUVJ9GMr/dDbvSfFhTCZVkTocOjWJpj8Qgv?=
 =?us-ascii?Q?mJFjbE/kY9hsy6Zz64QwrnCwmsPNkcjU/r3fktoQ6+VVOOqh3rLHTVvKbblN?=
 =?us-ascii?Q?NV+TN6aiA7RPiqN8mhxaRLe9O+FSMZ8qP7WZwbkDt8tY1Nd/PCTWNEyNylIZ?=
 =?us-ascii?Q?+mAXUL+J4hE5vE6tZqxyATuUo1DLdYOknRd7WEBVxoth37GPvKdi+ottxDFx?=
 =?us-ascii?Q?DQnI0Vja46RooHhSrJcB0Hs3eBEthR+eZrSr9ZEkIO08CUAjCbQ44WQtlk/P?=
 =?us-ascii?Q?1NEJBoIiiwlbvedQFmzQbJRfXPpJCCiml0A7gkqbmsnoJ/WlSM/ITFXWF0qA?=
 =?us-ascii?Q?TWMq9/cNypjZ8Aw4Lpr0bjQ9VOMUfvZtRCTFw+RCiGC97Zf5bmiY8yNo5kqm?=
 =?us-ascii?Q?Hbzwkro9tCkR1AIcn4EAdcoJig3AaHtrowUQr8IZ8rtnaoX0uz4aqz15PuHw?=
 =?us-ascii?Q?4cvsnQwPOW1j4nAjNuz5ewl0QHfN8V1iUKhLInvqUgZPQqwCl+qDegF/1foj?=
 =?us-ascii?Q?n/zJYKjoNZbpJNXQyFf55IFyhxyojZipuuT5L9VZAT5OYQSNZYm1CTDwxlLl?=
 =?us-ascii?Q?I9SF4fJBI4iJdxQl/mlPdt4K3LTFvLgmsHt+8Agdqc61eXiXMerENC0lG/dg?=
 =?us-ascii?Q?NuJNufabQfC9xO+8fmwPAgOYXtU6F1crzy8cjF1NSvfCF6Ybz1SJoHk0MVhv?=
 =?us-ascii?Q?Nfhdj3mdTDLbVBQjBPPhVhjeA+t0VrJlhacV7/9wS8SBZnXYaWCaGDgkJxJg?=
 =?us-ascii?Q?8kT7q0K1WNYRD66PoV9jh0DIN5Sg1oKVMCwR9lDR6rXkovg5BDBE7sjsODAf?=
 =?us-ascii?Q?gKvWHmnXOce2ARd1khwyueX+RPRczLpwKKZK4dcMF1nrEoTMfB9u+ICkoY2Y?=
 =?us-ascii?Q?ZRwzOOwnuxjWhnXBNaQReuh9Su2SLzjuY5YcdIgY5kWZYFPJP58zStqYFmc9?=
 =?us-ascii?Q?8YkeAJoVt4ENst4RJddy0s/QqVZpCXQs3oG7rOgVYVPnVQKf3+ONtoOiZidU?=
 =?us-ascii?Q?SFMgB+Hw6I9JFpurmLBXAIFZ8+O+OjFQajgXjBo8Vt2W8PGQ9D0THOGm4QeJ?=
 =?us-ascii?Q?Y586+7ixSS3XQWeGT0yjqGlXTqmCvy00vebNM3TtEEFuZm6OCrjVaxHPkqVd?=
 =?us-ascii?Q?MhhLenA8JLxiwK+9tAckw3VlF9QhcuI8cLOE971yCnJ5B1tV1CevGA7TMLHj?=
 =?us-ascii?Q?wS7meX4eGzJdCk4JSRyFkewM1BY4KJw706SYEnPuGPslUpUw9alFuoMfZiMy?=
 =?us-ascii?Q?S7cKZ+RPnkWuyx3hub9loJuSNakJV1To/IYQx/0FymoATV1xrHggCF5lmNks?=
 =?us-ascii?Q?Rno1Ms1ReGGQFjmyzA8D3qo9FI3wSzO9DUxto9B5TCS0SObvanFYssy/5Cui?=
 =?us-ascii?Q?JMn7V2rajq3G4AEn/1DP1cej0V1onuBH0mbVEcrqfRxaPzCZf6XEtNfGj78f?=
 =?us-ascii?Q?39RJbEw/I/ZYNaGCLOQfHGvUIUXHuh6o3o3gIKkuDnMA+eMD/1rplsPtU6/7?=
 =?us-ascii?Q?+vcFWmwg7yuT+isWQKTiFmgXeCOUARhbhW5HiB3TLuwr9/1G5FnE2aqvlr50?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edad1677-e57c-4125-abdc-08dbdd77cfb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 20:51:26.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4FVIZWtkxhgiAsqIx+VM3aOHKp2nWb7ksYRx+BI0QmcO3fwyYkk5MxxH67nA3lsoGmmbbnZur9736rg8axSio7Q41EA4UIQJ+yYtMaikxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7

...to receive the CXL update for this cycle.

The main new functionality this time is work to allow Linux to natively
handle CXL link protocol errors signalled via PCIe AER for current
generation CXL platforms. This required some enlightenment of the PCIe
AER core to workaround the fact that current generation RCH (Restricted
CXL Host) platforms physically hide topology details and registers via a
mechanism called RCRB (Root Complex Register Block). It has a minor
conflict with the PCI updates you have already pulled this cycle, sample
resolution below.

The next major highlight is reworks to address bugs in parsing region
configurations for next generation VH (Virtual Host) topologies. The
old broken algorithm is replaced with a simpler one that significantly
increases the number of region configurations supported by Linux. This
is again relevant for error handling so that forward and reverse address
translation of memory errors can be carried out by Linux for memory
regions instantiated by platform firmware.

As for other cross-tree work, the ACPI table parsing code has been
refactored for reuse parsing the "CDAT" structure which is an ACPI-like
data structure that is reported by CXL devices. That work is in
preparation for v6.8 support for CXL QoS. Think of this as dynamic
generation of NUMA node topology information generated by Linux rather
than platform firmware.

Lastly, a number of internal object lifetime issues have been resolved
along with misc. fixes and feature updates (decoders_committed sysfs
ABI).

This has all appeared in -next with a few late breaking fixes applied
for reported issues, but otherwise no new reports since this past
Monday. The touches of PCI and ACPI have received acks from Bjorn and
Rafael respectively.

---
Proposed merge resolution:

diff --cc drivers/pci/pcie/aer.c
index dcd35993004e,41076cb2956e..42a3bd35a3e1
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@@ -997,16 -1142,7 +1143,16 @@@ static void aer_recover_work_func(struc
                               PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
                        continue;
                }
-               cper_print_aer(pdev, entry.severity, entry.regs);
+               pci_print_aer(pdev, entry.severity, entry.regs);
 +              /*
 +               * Memory for aer_capability_regs(entry.regs) is being allocated from the
 +               * ghes_estatus_pool to protect it from overwriting when multiple sections
 +               * are present in the error status. Thus free the same after processing
 +               * the data.
 +               */
 +              ghes_estatus_pool_region_free((unsigned long)entry.regs,
 +                                            sizeof(struct aer_capability_regs));
 +
                if (entry.severity == AER_NONFATAL)
                        pcie_do_recovery(pdev, pci_channel_io_normal,
                                         aer_root_reset);
---

The following changes since commit 178e1ea6a68f12967ee0e9afc4d79a2939acd43c:

  ACPICA: Add defines for CDAT SSLBIS (2023-10-03 16:04:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7

for you to fetch changes up to 4b92894064b3df472b2cf5741c7f080e16dcd1ec:

  lib/fw_table: Remove acpi_parse_entries_array() export (2023-11-02 15:17:21 -0700)

----------------------------------------------------------------
cxl for v6.7

- Add support for RCH (Restricted CXL Host) Error recovery

- Fix several region assembly bugs

- Fix mem-device lifetime issues relative to the sanitize command and
  RCH topology.

- Refactor ACPI table parsing for CDAT parsing re-use in preparation for
  CXL QOS support.

----------------------------------------------------------------
Alison Schofield (4):
      cxl/mbox: Remove useless cast in cxl_mem_create_range_info()
      cxl/region: Prepare the decoder match range helper for reuse
      cxl/region: Calculate a target position in a region interleave
      cxl/region: Use cxl_calc_interleave_pos() for auto-discovery

Dan Carpenter (1):
      cxl/hdm: Fix && vs || bug

Dan Williams (19):
      cxl/port: Quiet warning messages from the cxl_test environment
      cxl/pci: Remove unnecessary device reference management in sanitize work
      cxl/pci: Cleanup 'sanitize' to always poll
      cxl/pci: Remove hardirq handler for cxl_request_irq()
      cxl/pci: Remove inconsistent usage of dev_err_probe()
      cxl/pci: Clarify devm host for memdev relative setup
      cxl/pci: Fix sanitize notifier setup
      cxl/memdev: Fix sanitize vs decoder setup locking
      cxl/mem: Fix shutdown order
      tools/testing/cxl: Make cxl_memdev_state available to other command emulation
      tools/testing/cxl: Add 'sanitize notifier' support
      cxl/port: Fix delete_endpoint() vs parent unregistration race
      cxl/port: Fix @host confusion in cxl_dport_setup_regs()
      Merge branch 'for-6.7/cxl-rch-eh' into cxl/next
      Merge branch 'for-6.7/cxl-qtg' into cxl/next
      Merge branch 'for-6.7/cxl' into cxl/next
      Merge branch 'for-6.7/cxl-commited' into cxl/next
      cxl/hdm: Remove broken error path
      lib/fw_table: Remove acpi_parse_entries_array() export

Dave Jiang (6):
      cxl: Add cxl_decoders_committed() helper
      cxl: Add decoders_committed sysfs attribute to cxl_port
      cxl: Export QTG ids from CFMWS to sysfs as qos_class attribute
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add support for reading CXL switch CDAT table
      acpi: Move common tables helper functions to common lib

Ira Weiny (1):
      cxl/pci: Update comment

Jim Harris (2):
      cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails
      cxl/region: Fix x1 root-decoder granularity calculations

Li Zhijian (1):
      cxl/region: Fix cxl_region_rwsem lock held when returning to user space

Robert Richter (12):
      cxl/core/regs: Rename @dev to @host in struct cxl_register_map
      cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
      cxl/port: Pre-initialize component register mappings
      cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
      cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
      cxl/pci: Remove Component Register base address from struct cxl_dev_state
      cxl/port: Remove Component Register base address from struct cxl_port
      cxl/pci: Add RCH downstream port AER register discovery
      PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
      PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
      cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
      cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for devm

Terry Bowman (6):
      PCI/AER: Refactor cper_print_aer() for use by CXL driver module
      cxl/pci: Update CXL error logging to use RAS register address
      cxl/pci: Map RCH downstream AER registers for logging protocol errors
      cxl/pci: Add RCH downstream port error logging
      cxl/pci: Disable root port interrupts in RCH mode
      cxl/pci: Change CXL AER support check to use native AER

Vishal Verma (2):
      MAINTAINERS: Add tools/testing/cxl files to CXL
      tools/testing/cxl: Slow down the mock firmware transfer

 Documentation/ABI/testing/sysfs-bus-cxl |  30 ++++
 MAINTAINERS                             |   3 +
 drivers/acpi/Kconfig                    |   1 +
 drivers/acpi/tables.c                   | 173 --------------------
 drivers/cxl/acpi.c                      |   3 +
 drivers/cxl/core/core.h                 |   2 +
 drivers/cxl/core/hdm.c                  |  93 +++++------
 drivers/cxl/core/mbox.c                 |  60 +++++--
 drivers/cxl/core/memdev.c               | 161 +++++++++----------
 drivers/cxl/core/pci.c                  | 275 +++++++++++++++++++++++++++++---
 drivers/cxl/core/port.c                 | 184 +++++++++++++++------
 drivers/cxl/core/region.c               | 266 +++++++++++++++++-------------
 drivers/cxl/core/regs.c                 |  73 ++++++---
 drivers/cxl/cxl.h                       |  38 +++--
 drivers/cxl/cxlmem.h                    |  17 +-
 drivers/cxl/mem.c                       |   7 +-
 drivers/cxl/pci.c                       | 107 ++++++-------
 drivers/cxl/port.c                      |   3 +
 drivers/pci/pcie/Kconfig                |   9 ++
 drivers/pci/pcie/aer.c                  | 159 +++++++++++++++++-
 include/linux/acpi.h                    |  42 ++---
 include/linux/aer.h                     |   2 +-
 include/linux/fw_table.h                |  43 +++++
 lib/Kconfig                             |   3 +
 lib/Makefile                            |   2 +
 lib/fw_table.c                          | 188 ++++++++++++++++++++++
 tools/testing/cxl/test/cxl.c            |   2 +-
 tools/testing/cxl/test/mem.c            |  83 ++++++++--
 28 files changed, 1375 insertions(+), 654 deletions(-)
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c
