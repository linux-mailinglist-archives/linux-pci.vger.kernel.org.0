Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F26DBF0F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Apr 2023 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDIHbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Apr 2023 03:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2023 03:31:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1059D7;
        Sun,  9 Apr 2023 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681025492; x=1712561492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5pHf26AUSGq09dsLzbMS/gQMMXeFBPy9bg3Oytto1Q=;
  b=TdZ6IqM6JhFCdBT5qgBUO6VxFEFCzcyfxloxQcwOGC8uFmWluGMerBgG
   9scLq+xLCCrAqJ3G+baqjLxkwxjvd4eLRCgbZdPNxRJOqXQv7HlITaL4n
   vFpjAEe4UbZxVKK3RHPbO0makcg9ail4yJfNDWhPAWrzhN9iqVVo0yGb2
   PRv5FyYURTNELXlGx8WOX1V0ic6TgNz8ytkjjhzT9LDonMS7q/cyz5vlR
   6RK95U73gdjFxI2jxtvOJrP2XzriEmFIbWEe6QNh9xx1aKxEne6g4K9So
   lvYmAUE650ldBNIoDxJqwzaPDcLeLBSUp4XPMYR4mehkphNH1NyQAySJk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="429487202"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="429487202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 00:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="777241183"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="777241183"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Apr 2023 00:31:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 00:31:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 00:31:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 9 Apr 2023 00:31:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 9 Apr 2023 00:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noJzL0NutB++aOubWuRoh8LHwbXSWlW2tZnqZscEu9T/I5B7rTjaUoKnh7O25VudPLoHwSHWWyp+YE0MXe8y+b5o6mq/MyGUOywHAcRfRcBkTD63yiPAPdWycshwQLQVdFyy7T2FFnHa2YH60oITmuA8wzkJANoE8GvSyQcg64Rtq1miQ5k63dtFSuc3smXeIdtI2zHsV0btFsWGkmPoh0X557DNz74kGPDZu5EFkMZ+8+zFJ9YORaxGei/QzO3kH/2d51CwMPytTT5+3KXV/q4d3oZqRrZtsKPTwoyVT1GlN1EnzX1N0Lo5UpqMQn5Gp8sBiRh0B7CLD/EwNI5snA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM3IXF7bQZ78wAQE3U7WfJo1MwNA8TAVYXdDfK39xM8=;
 b=LXtCEtoPVRLrbOQXEe5U5vEZL6eyUjOXWMDDqTpSxlHtpj5jAHtJi5hHMFeYsVWloljSWR09vdesHc5jdrl/T3G23huBF5r7hDimFmlZfjCNh1dT7fQR2QwICdPjilo4XQcFWkkK5NCgnak8u0128tkmCG5of43tqQapVO7Q900Vd1CNj4Etbh1ii1yxwDwO/oizZkiLBcUhf0K0UGwb5hSYl39LdMjSRuzCQZDq440gGQ1WdqlQSG8fVxgvb5AWJ8D/QQDwjmdfWfZtMeho1Hrmt/9jB1YNmyIHGvExSuf/1pAXOx/z78P8AvsamAmiU7YACJa5zbsuEJYXDIHKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 9 Apr
 2023 07:31:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Sun, 9 Apr 2023
 07:31:07 +0000
Date:   Sun, 9 Apr 2023 00:31:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.3-rc6
Message-ID: <643269b8b7cb2_93aa294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: ea794b1f-48e8-4729-9cbe-08db38cc61db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoAJpE9UlVgqPGzvjM9GAWfted3mWlTsg8eGIGN85qr9OzUfRGMLGBbmGvLEftVAyWD5c0a+9+B9ROS0p+2WvoKgR+GcxzRGKNoB0LZMka8/xS1LQe3+cVIeoH44RWhFc3NiRTecJkOGG2TAv5hWI+Fd2FUWEKl80DVf4fz71AcmNlW6vVz2FFUeOj+4B8Ghys6ivcte73CFWkfPAM33+9ba1kx8qeMpCAfGFRY8dvtcCurs9DIluEMfNM5n6urtD7fp46avhl+wyQQjbm5jJIIxcDSGdNHHAlgHhSj134H8Fk1WyGcLWEEktOzVJJ+XcXSyrOgFaUT/irxVbCCViuhpr/4QnDtxBwkpCwSgt6T6oXU1U7XK/aAlC5P32HZTtgCmR8WQNvEX4BFXbk/xg1oOBBTog8EPy3EUiSLRX6n3E4IwNStlQT7SqP2fyzuvq5Q8mO2D6JWg2IGrgWsCpXNKITdE0ZY4tQzaMdaSYeQBdYKlfaf9YERw9WrBKHoZLOsmLLaLTTGSM4SrKXaClXf4450Dt5sUXs8nug+ZFkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(86362001)(2906002)(6486002)(9686003)(6666004)(83380400001)(186003)(6512007)(6506007)(26005)(966005)(478600001)(66476007)(6916009)(4326008)(66556008)(66946007)(82960400001)(41300700001)(8936002)(8676002)(38100700002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlegKn4d+vP8NRdfYXZwyE24w6BIFfB5BRTaOHGI0/SKZPtHcwD/u4OUlvXV?=
 =?us-ascii?Q?Ahh/sGMJ/F5dEQwgrvRUWy31cgWKo2kfzwW8KYIjCRbmhcuNK7C49MR+9Mzg?=
 =?us-ascii?Q?JfptBvkX9cv3JpP9Ji7oiqxJoyup9rPUtumiq+lKwsX7qLMMEB2lL23ba5mo?=
 =?us-ascii?Q?72Zceb4Qy4ixrJyzh2o+hqktQuiVNWa5g+Njgd4aGY3ZZ8W/ldynb8yXoU5v?=
 =?us-ascii?Q?katLdc8TOIHz4aYjqX2ySHxjMsltF6Yc81HOKiOp1NiuVlUx6+Ef9vVNoiYj?=
 =?us-ascii?Q?YqD3GGTIuKGJdxuUIuMD2mzjaEhoMXUZFzON/HC4BwUe60APmwOoDZRkMHG4?=
 =?us-ascii?Q?sHr5opay9PJShDzaeS6X0iR9Mpv5f5+10V3OTbGaFD2MO5tAMe5n1vog+i9L?=
 =?us-ascii?Q?WgpKdCB0IDmw9Zn/hKP+ZWJkrmLFPmfBuNTUS/NH6YJe39LOt/BWGPNDnSRy?=
 =?us-ascii?Q?yvQXM4abDqqjMEtZG0EzspqMj2l05yWB5dJH7ShCm/G4FOKoHpeYypi4VwEH?=
 =?us-ascii?Q?RLID9dZ1smJ5Ri0G2tQhlx9c2f2Bhj/c4riJePC63/gwm3Q5B7fkqkkQiU5O?=
 =?us-ascii?Q?/01ql6GpXx0Xo5CKpgG95R1VOispsx6GVIB98gxpJeziSffTGS143uyp49sR?=
 =?us-ascii?Q?OBNwrUGx+3RlhzGCjzNt7jXLBfNSQjlNFU/0MuvpeJyxdxQChZJOQLAXhvqI?=
 =?us-ascii?Q?JFx8h1EIYYNKa1iSKPo8PiC2RLkZifRDHsj6zx7nKU9+a+NkyGqjQGwWJLe5?=
 =?us-ascii?Q?7uFK23r1WU3MlI0OWfJIjKsUEFgbcQNy8bL5EOSdcFZbeJe5rAOZHWDKYPHi?=
 =?us-ascii?Q?L62P3EHazIKKZTi7rlJZJ031j83HDfbPX1Ne3g8YzrZbxax/nkI+4pF/o1tE?=
 =?us-ascii?Q?4Sne91AfbDjIaOtPvo1lOavVQhBOsVBjAzVgvGPsZELizGTeY1Sti9UlcBey?=
 =?us-ascii?Q?tmMqDuTStX/Z/Hz75VdtMtAVHuVoRsWU1NX79wqrs107JbqW3KUK0b49dX8X?=
 =?us-ascii?Q?iKwo9ZzvaaemM/N26Z933KcOFmE7Fa9dVKP54ZtD8BdmsHNqkIHPE4kqMV+8?=
 =?us-ascii?Q?D/xBvYOqE9L5rTbD7e1KTmo7l0ker08UiGroiRLPhOARt4pxZqdwtX1SFbAW?=
 =?us-ascii?Q?tPiTSLunCARQqzRqim0mtcn4Zu1NUUZrEYzzUsAYVhDuONab0VsbNHMnIgJt?=
 =?us-ascii?Q?lwsqBh+nPl4IFcILozflOTKt0QiT2kI34AylT+zetaUBZtC600Z8qlpP6EG5?=
 =?us-ascii?Q?iDZxu3ym/CNoSwr+6Evs1v6lrRJVwHlcFh/H6mBCCq469Qen3IQ3SOHjgXt5?=
 =?us-ascii?Q?b3Km6VSWHvIM21mDI/cp5gR5OuLWMDRlcK+S44/h4vHFwqkowEyy5PpXGbii?=
 =?us-ascii?Q?nk+KkbeMrhnPWXXzKejV0qvvH3fP/jadt6diHbj1eZRE2BPq/nbp7Du0d0eL?=
 =?us-ascii?Q?kg/Wdexc0MQNUwb2d1hpmIdKGJ7JptjXGJm0ZTXU3zN4SLbuATEa6uTtEzSJ?=
 =?us-ascii?Q?ohLWdsydZ96aV/5o10RT14xQqKqFyHUB7aZPRqzL0GbPe2F/RyPL/aXpmR1h?=
 =?us-ascii?Q?+nk5pi8l/J7TQx5C+xDsY9qlISgksNCX+Qs+BGuP3BG0TUBTsGOVUv/hJ/os?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea794b1f-48e8-4729-9cbe-08db38cc61db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 07:31:07.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60KHbTN/QT7Mdp11XkYQGkcHbieEMf+IdvzaxPF4hLlsoOZER4nfdO5PF6xCXV5sxlZ7Dj4zdKeGTc7Uuwa8FPm6fNtfX1LcO/oens8AcCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.3-rc6

...to receive several fixes for driver startup regressions that landed
in v6.3-rc1 as well as some older bugs.

The regressions were due to a lack of testing with what the CXL
specification calls Restricted CXL Host (RCH) topologies compared to the
testing with Virtual Host (VH) CXL topologies. A VH topology is typical
PCIe while RCH topologies map CXL endpoints as Root Complex Integrated
endpoints. The impact is some driver crashes on startup.

v6.3-rc1 also added compatibility for range registers (the mechanism
that CXL 1.1 defined for mapping memory) to treat them like HDM decoders
(the mechanism that CXL 2.0 defined for mapping Host-managed Device
Memory). That work collided with the new region enumeration code that
was tested with CXL 2.0 setups, and fails with crashes at startup.

Lastly, the DOE (Data Object Exchange) implementation for retrieving an
ACPI-like data table from CXL devices is being reworked for v6.4.
Several fixes fell out of that work that are suitable for v6.3.

All of this has been in linux-next for a while, and all reported issues
[1] have been addressed.

[1]: http://lore.kernel.org/r/20230405075704.33de8121@canb.auug.org.au

---

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.3-rc6

for you to fetch changes up to ca712e47054678c5ce93a0e0f686353ad5561195:

  Merge branch 'for-6.3/cxl-doe-fixes' into for-6.3/cxl (2023-04-04 15:37:25 -0700)

----------------------------------------------------------------
cxl fixes for v6.3-rc6

- Fix several issues with region enumeration in RCH topologies that can
  trigger crashes on driver startup or shutdown.

- Fix CXL DVSEC range register compatibility versus region enumeration
  that leads to startup crashes

- Fix CDAT endiannes handling

- Fix multiple buffer handling boundary conditions

- Fix Data Object Exchange (DOE) workqueue usage vs CONFIG_DEBUG_OBJECTS
  warn splats

----------------------------------------------------------------
Dan Williams (8):
      cxl/hdm: Fix double allocation of @cxlhdm
      cxl/hdm: Skip emulation when driver manages mem_enable
      cxl/port: Fix find_cxl_root() for RCDs and simplify it
      cxl/region: Fix region setup/teardown for RCDs
      cxl/region: Move coherence tracking into cxl_region_attach()
      cxl/hdm: Limit emulation to the number of range registers
      cxl/hdm: Extend DVSEC range register emulation for region enumeration
      Merge branch 'for-6.3/cxl-doe-fixes' into for-6.3/cxl

Lukas Wunner (6):
      cxl/pci: Fix CDAT retrieval on big endian
      cxl/pci: Handle truncated CDAT header
      cxl/pci: Handle truncated CDAT entries
      cxl/pci: Handle excessive CDAT length
      PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
      PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y

 drivers/cxl/core/hdm.c    | 126 +++++++++++++++++++++++++---------------------
 drivers/cxl/core/pci.c    |  38 ++++++++------
 drivers/cxl/core/pmem.c   |   6 +--
 drivers/cxl/core/port.c   |  38 +++-----------
 drivers/cxl/core/region.c |  33 ++++++++++--
 drivers/cxl/cxl.h         |   8 +--
 drivers/cxl/cxlpci.h      |  14 ++++++
 drivers/cxl/port.c        |   4 +-
 drivers/pci/doe.c         |  30 ++++++-----
 include/linux/pci-doe.h   |   8 ++-
 10 files changed, 175 insertions(+), 130 deletions(-)
