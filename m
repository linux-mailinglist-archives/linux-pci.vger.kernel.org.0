Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7656F2727
	for <lists+linux-pci@lfdr.de>; Sun, 30 Apr 2023 01:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjD2Xg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Apr 2023 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjD2Xg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2023 19:36:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930D19A2;
        Sat, 29 Apr 2023 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682811386; x=1714347386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r1EI1Q9sRQ3DKUuUupBoOW7hwSmNiOvqxBY97vP1L3E=;
  b=YbiP608FcPEVSYNMFn3OOPSAG9fmmdogEhIHRSM4XbP+/jnaFizC3GAY
   9LZ52BLYu31E0NZzyRYbJNdkW9+DlXZ2BoTVqKZ+WNkdrIVN5X/6osPu8
   HftBWEXSP6HIdutDnbAXpQzGF57V6iQwt4tIgFljFY4nZb0P54Ge0rK+a
   La1tijg5gg0sGDEeDO50AhraCATQTpEXaR0o7yNtPVzeChFiXgMurgRQN
   /SK9qJzy8/7N1lce7kEQKrO4cp8hWy1yYS6ZNzwYzXRZ7uxjTM3T93KLL
   bz4NRzEaomTKutvGK6Q3P4gKjqUdxNxiW4Uci7NIwrCdxVSS2BwxMP2nY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="332313075"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="332313075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 16:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="764811837"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="764811837"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2023 16:36:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 29 Apr 2023 16:36:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 29 Apr 2023 16:36:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 29 Apr 2023 16:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BchzmIpc0AB4jJ6zcBgcwZUt2BBpkuLImUDI7MpFCzVhblrgUhSQkvRLuTbL0NiQPrQhlF7liE2a49WP1xnKGo1MhzRdC8OAiG2ndBTszs5dBSAzPrDYjoDniuuS3yYRXCGgdv0uxlZcYDpqvviX3WhiIbBuYDV/vfFFRxbIw1sSzVix8sTUe94DQzfTUs85oVX8s8cA0jaa6lfy0B5o1DlwDIX+An/RJ0FwNnSXzQGdPxn1AIxWqFDi/SxFQ4Gm9PGbIU+isY7Fbx91z7ybH/Q19TNyAZfSrP0vgMNiX9II1oVyC1yRAphS+eRHI0Px5C9NoKbqRXhfH83jw66F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Otvf7Ptn6ykn+l4Nsq/qgAzkUjyRXf61zVwoaBBy8=;
 b=ni802wzyk8XkQCZfslMy06pPmoHeM2OB1KBo0LdxlThKK6NR/oHkZ3QGaxe9W9v/P1R2hN5T+kKpPKN8OMOwrHVOY5jxJ/idCC2xh+xn/IE60sl+ehqtttg2r5n8gkrCqS+t7Jsh18t72CK34sQwqLjcbcsY7DyaFtq8Y/RvpTx4kREYDbgk+C6V44o+xUO5KE7qH2joYBRgKuUIxDxS7D67WcPwdjsKPxAvYCgUbYZPaDQcLuW+Gd/poSkDgRRDi+hTtZ0kGX9cy9Qsau1aFxOG49Cb8thazq/yLixVC/d6ZRwx3qyDNy+VIM82nZbsBvvTwdEncH4kHt0YCvCLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Sat, 29 Apr
 2023 23:36:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Sat, 29 Apr 2023
 23:36:12 +0000
Date:   Sat, 29 Apr 2023 16:36:08 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.4
Message-ID: <644da9e8104cd_8ca7294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MWH0EPF00056D14.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1c) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d17f35e-7d2f-4073-a78e-08db490a83fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhkIFS0KEIp4Lr3DZ6LzunisQPlclyhbDhnT/GMHdytMllKvLkecWmifmofuYvYNBYboOWSBnSkIKo2oa3j5ps+Unas24OpJ5IIzjb2+GHb/HuarSZv7VysQSlGxIqb7fCHLYSavTcPaio+FiDpogyfcLazJK60KK/2hY+jqSm+5tPUb0K6s3/GKlQ6NgUIuYdvtocrlpElwa7DubZq4RxotS+lgKce2kU6tPPgQRORqTNgZ679FCu9Dwu9G1ZkNwY3Z+YE8RJ9hGadnLrqYDO+oun5a0895kAqLnYzdFV0g3MkSVvZnfe/isKzAu7Aao4cEImTfcxrdiBioGX3ZD4Q8z/T6m3SMNYuQvTiFASYJvjdRvlBCZOQJ5S9A8H+ccRfz5LSVP3lvXs7kvGvs8S7phzwiZHURBCCvsnRBZhB7/3s2hU6Wj87Zq+urHwpf9bKCpeApA7uDmQ/F0BXyz3pulRZXTAFVFgnU5BAalq0EAfbDqmnzMwxsEzMP+DiIpklHum4pCYHvk14l7Y9Jc+zWkAJM/MQCEBjS/yLQGXmZTTgEGYFIgRSuWrjJyqfS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(6666004)(6486002)(186003)(6916009)(66476007)(4326008)(66556008)(66946007)(9686003)(6506007)(26005)(6512007)(478600001)(82960400001)(316002)(83380400001)(41300700001)(8676002)(5660300002)(8936002)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EntUXXQCbaX+XGcCHhazWfvDRI2Y9VyoMe9XikqWTB1P794O2GJnrdWjLswy?=
 =?us-ascii?Q?XMsjJDHnHFruRVlzXkFYjKyxWPHiOYB7NZnbAZX9bTMOPIeRiwDBkKEZKQzN?=
 =?us-ascii?Q?hrIkfLkvr4oyX3toluEOGaGC+maa28g2OgEJBEQoN3x8U0Y88O3urnzpHcAF?=
 =?us-ascii?Q?q6qg6RNYoM1FKq9SAlYiwwjYe4UjQ+RSRiUrtDxZFH/0yAhKGUet9sUZB/6E?=
 =?us-ascii?Q?9WL98wfj/5Sz9+idX1yPhtlRYC2qnSLBbl/vJr9bGgDtSiXhoQRuVBsr7f4o?=
 =?us-ascii?Q?taAvqUj28NQiKa1GQOS4GYH7A1eeklGDtHCEeOoslC6Wx9l1ZCVrMmkpHAKC?=
 =?us-ascii?Q?FFxJXf5SZQCz2q13TGg2gxkYV18caBmCVwiBjTlwxYR3H3ahao2amzUGgDGV?=
 =?us-ascii?Q?QtzJElxuWVjWPVk/mwBUqpVZersKyxcslLBaV4uAgnsDmpLtYyBgtvKggqfe?=
 =?us-ascii?Q?11ECvKBwJ5HBA4GZgQ1HfWEOggWi5huvriHU573voCnY1h+U0+6OyudSGSjL?=
 =?us-ascii?Q?Q6b9fvqm8VU6tpXHzyO+BQn/n9OUppsJ359oPzi0h6Kq8yAPFsC2RqDgrk9O?=
 =?us-ascii?Q?57HmgpHDg2XepwS8D0HofTfK2oRGZKWZyJnO37LB4Xd8EDKuD+DVnBn2fk8E?=
 =?us-ascii?Q?PPEYv7KsGZY742BY4YwNvmt/up6ZJA9W2k53bZZC1P+y1XBqT/L1lXqg6ODr?=
 =?us-ascii?Q?ZcLW2E+bTr9xHMlL1Ff1TEmF8aLafzDmLfmo9XJahuK6ko8PcMjyyz2WOLuK?=
 =?us-ascii?Q?bnZazI7aOQFWqbsSzep3vVAhtEMh7qjmcMtW5PTkRvNGGZJRv92mQvByglY4?=
 =?us-ascii?Q?1uaog8AGP4z/0k8diA44pHgYizoHxo3pWgmFM1SCrkiWRtHNI4vv+/q4aneF?=
 =?us-ascii?Q?rKoq68Oot7A0z7/s8BzLS35VPZuKcJkU563K/4/cMx8F0LMZioa45gXZfifx?=
 =?us-ascii?Q?6kZ+TX8aqyXSj/cNc3asVrQP0Gw0Gh027HuPaVCd8u3cOrjX8WFp/GJZZc3U?=
 =?us-ascii?Q?T3utAjVaX5CSCdYlLCLA1uxcSc3kR8HGUVi0AtaJ3MYpx+RvdzI2vv+ZWNFg?=
 =?us-ascii?Q?0osbeBG1QEFkXpYQyIV25hn7o/QnfJfCmwX4MxE9rIH4HKkP17MULhNxGFNI?=
 =?us-ascii?Q?SsmRaCYnDTd1S0XBCoRllgCpb2lRZaR8ce4FyPmkP5EgSG1sCHqkqTnqOxzZ?=
 =?us-ascii?Q?8J/tjmFh9lWqJbFYHSUnYBoh4+mZIJPr5PI5H27LdXcR8jFAqvPjZV7XkXwu?=
 =?us-ascii?Q?Cask6EaqaWrs4nadKlLpXLf2B79GKe81yljmUzjXtpEpOQXDJ4hgBFNBYxnL?=
 =?us-ascii?Q?QCK+IggPdzcd1VB110ehW6uzCU/pA9idzjIs1HcHYwbAy1fNK/WGMO2QUa4o?=
 =?us-ascii?Q?o5Woi9KLWAQ2Z/Tx9Ru2cIn4SjktdVo9CC1nGdHPaoAonOVE60jv+p3fN4/O?=
 =?us-ascii?Q?uFutqP8kvmyjcnOu6t6N8yXTxroS5f9kjBdxxI/4rmwb+7X6vua2Es1m2gvz?=
 =?us-ascii?Q?7slU7FBhvaPZiWGx6Jr7gWdNtDrPvcH+9QypyGastlmArbR2f1Kspc7+i3iJ?=
 =?us-ascii?Q?kYztkZyIvoZ3vtGb0jmSyJIk5Kjg1a7a16CqDajUZQnm3mNpVCPj72nl3HZr?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17f35e-7d2f-4073-a78e-08db490a83fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 23:36:12.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAIGjxhje7odAUkB9BBKP+JWD4X1CuF9yLgSTgf9BiGM6rUPSYTzZmPFDNdPlJrT3f4q/Lu1PHUCPwVUvYYdIAAsiwZ827PO39e7aioIQHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.4

...to receive the CXL update for this cycle. This has appeared in -next
for the past week or so with only a minor conflict report with the PCI
tree for changes to '.clang-format'. DOE support is promoted from
drivers/cxl/ to drivers/pci/ with Bjorn's blessing, and the CXL core
continues to mature its media management capabilities with support for
listing and injecting media errors. Some late fixes that missed
v6.3-final are also included.

---

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.4

for you to fetch changes up to fd35fdcbf75b5f31dba6c284886b676bb2145fe6:

  cxl/test: Add mock test for set_timestamp (2023-04-24 11:31:02 -0700)

----------------------------------------------------------------
cxl for v6.4

- Refactor the DOE infrastructure (Data Object Exchange PCI-config-cycle
  mailbox) to be a facility of the PCI core rather than the CXL core.
  This is foundational for upcoming support for PCI device-attestation and
  PCIe / CXL link encryption.

- Add support for retrieving and injecting poison for CXL memory
  expanders. This enabling uses trace-events to convey CXL media error
  records to user tooling. It includes translation of device-local
  addresses (DPA) to system physical addresses (SPA) and their
  corresponding CXL region.

- Fixes for decoder enumeration that missed v6.3-final

- Miscellaneous fixups

----------------------------------------------------------------
Alison Schofield (18):
      cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all
      cxl/mbox: Initialize the poison state
      cxl/mbox: Add GET_POISON_LIST mailbox command
      cxl/trace: Add TRACE support for CXL media-error records
      cxl/memdev: Add trigger_poison_list sysfs attribute
      cxl/region: Provide region info to the cxl_poison trace event
      cxl/trace: Add an HPA to cxl_poison trace events
      tools/testing/cxl: Mock support for Get Poison List
      cxl/memdev: Add support for the Inject Poison mailbox command
      cxl/memdev: Add support for the Clear Poison mailbox command
      cxl/memdev: Warn of poison inject or clear to a mapped region
      cxl/memdev: Trace inject and clear poison as cxl_poison events
      cxl/mem: Add debugfs attributes for poison inject and clear
      tools/testing/cxl: Mock the Inject Poison mailbox command
      tools/testing/cxl: Mock the Clear Poison mailbox command
      tools/testing/cxl: Use injected poison for get poison list
      tools/testing/cxl: Add a sysfs attr to test poison inject limits
      tools/testing/cxl: Require CONFIG_DEBUG_FS

Dan Williams (9):
      cxl/hdm: Fail upon detecting 0-sized decoders
      cxl/hdm: Use 4-byte reads to retrieve HDM decoder base+limit
      cxl/core: Drop unused io-64-nonatomic-lo-hi.h
      cxl/port: Scan single-target ports for decoders
      cxl/hdm: Add more HDM decoder debug messages at startup
      cxl/port: Fix port to pci device assumptions in read_cdat_data()
      cxl/mbox: Deprecate poison commands
      Merge branch 'for-6.4/cxl-poison' into for-6.4/cxl
      Merge branch 'for-6.3/cxl-autodetect-fixes' into for-6.4/cxl

Dave Jiang (1):
      cxl/pci: Simplify CDAT retrieval error path

Davidlohr Bueso (2):
      cxl/mbox: Update CMD_RC_TABLE
      cxl/test: Add mock test for set_timestamp

Lukas Wunner (10):
      PCI/DOE: Provide synchronous API and use it internally
      cxl/pci: Use synchronous API for DOE
      PCI/DOE: Make asynchronous API private
      PCI/DOE: Deduplicate mailbox flushing
      PCI/DOE: Allow mailbox creation without devres management
      PCI/DOE: Create mailboxes on device enumeration
      cxl/pci: Use CDAT DOE mailbox created by PCI core
      PCI/DOE: Make mailbox creation API private
      PCI/DOE: Relax restrictions on request and response size
      cxl/pci: Rightsize CDAT response allocation

 .clang-format                           |   1 -
 Documentation/ABI/testing/debugfs-cxl   |  35 ++++
 Documentation/ABI/testing/sysfs-bus-cxl |  14 ++
 drivers/cxl/core/core.h                 |  11 ++
 drivers/cxl/core/hdm.c                  |  52 +++--
 drivers/cxl/core/mbox.c                 | 151 ++++++++++++++-
 drivers/cxl/core/memdev.c               | 227 ++++++++++++++++++++++
 drivers/cxl/core/pci.c                  | 137 +++++--------
 drivers/cxl/core/port.c                 |   1 -
 drivers/cxl/core/region.c               | 124 ++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++
 drivers/cxl/core/trace.h                | 103 ++++++++++
 drivers/cxl/cxlmem.h                    | 111 ++++++++++-
 drivers/cxl/mem.c                       |  71 +++++++
 drivers/cxl/pci.c                       |  53 +-----
 drivers/cxl/port.c                      |  18 +-
 drivers/pci/doe.c                       | 328 ++++++++++++++++++++++++--------
 drivers/pci/pci.h                       |  11 ++
 drivers/pci/probe.c                     |   1 +
 drivers/pci/remove.c                    |   1 +
 include/linux/pci-doe.h                 |  66 +------
 include/linux/pci.h                     |   3 +
 include/uapi/linux/cxl_mem.h            |  35 +++-
 tools/testing/cxl/config_check.c        |   1 +
 tools/testing/cxl/test/mem.c            | 247 ++++++++++++++++++++++++
 25 files changed, 1583 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

