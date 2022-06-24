Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBE559D68
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiFXPdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFXPdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 11:33:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53FF4E;
        Fri, 24 Jun 2022 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656084779; x=1687620779;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kczNqG4boRCScXQ0SN5DTAQQeT8/6w6ptgyvzUNq9wM=;
  b=bmJyZYtOUjJcI20X2vrCLtT5fzyHQy9F5te7RIH5IVCRKQNedw9cBy4C
   WqBsngqOjehjtZrd183wdFSUuKOSie2BDM8NS2elCmibDjlkSyejBaucJ
   g3syXugN8eqgB1h8lVH3aFZeArcxzalY+FBNHjc1/dgb8m8Bko/0t8MgJ
   eyUyYWoL3qef3kcGmqW92+4ch8suelHFJKuEmK0v2YXAV0noN4DTSmDyZ
   YStax/8HP2VC2raJtzsDPK6wzz9gaAfJdpEntgELkJdKPbE9pKU9C2xJ9
   JO7YeISS0tMwiiR9Mjht6Dj/J5exAZAurYJ4qLNsHUXhiwdWQS6/wCm4U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="345018993"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="345018993"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 08:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="915721444"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2022 08:32:57 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 08:32:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 08:32:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 08:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr0eC81iOMdd7PYVJ+NoOWF9tt0I4OF9OT0cbw/ylzawIXiN/4T6xHfmAFQoCW2FuNmkAQGA2TUE6JFBOwfmRlL6fJVSfZbM49zdZpZXVffJ3vOrum9PqKcJQdfglUku8i7YWPdUoyUp1S1hABs8udbs9VlpceQsILZRrZgPW30nBYxj6qglVT7bM5jbw27hLfeWPJHed5wfvTEGPrQfIp72uZxXYthWY+ov6ITlby2UB3B1k5f+6xbsTlI8yqoKlqC4lIr3BxXGUdPMyYhkGRuMAUw0EV+29LulJUgKvXKJCELO1KhV8GhIdAv2Xs+2LG6/v0qh2p/UFEYnjC+VAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew/gAMR5VNY7w5VlAAp6Vc2eTn0hgxU5O8bnsMynPHI=;
 b=dT68v4hGC95uxyw0D/RVshUlQ3wLcXsvqjomU1m7EzT5H/iBTyhjqqV9t0IP/AXjDwFyEHkRMhOmtPvQm9VGwAH9RhJwoqkMprBVMZCTtuLGrzZFJC5e6DYcPolRpJFNexGEs4TI8FNbBljCFRQMUi0rAaPVOk8o1uP9dp3Wo/aXEHY7dxu1gVZDI88srbIrwjMcmhUBMn6EPl/v72Fv3EOf8P6FDstGyw9jf/JLwVTSslYSsIChct8gM72WCI9dM/paW3nTD4/hqLbTb7GAXjMnMAwBwJksiSn4cT2TIesCnzoWrF18kziktHZluLp7Epba3t7A2s9n+Uw7Vt/YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR1101MB2114.namprd11.prod.outlook.com
 (2603:10b6:405:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 15:32:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.024; Fri, 24 Jun 2022
 15:32:54 +0000
Date:   Fri, 24 Jun 2022 08:32:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 00/46] CXL PMEM Region Provisioning
Message-ID: <62b5d9249edf2_8070294d2@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624161310.00006689@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624161310.00006689@huawei.com>
X-ClientProxiedBy: MWHPR01CA0036.prod.exchangelabs.com (2603:10b6:300:101::22)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8485d136-89e0-4d2b-84ab-08da55f6ce80
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2114:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XylJ5ityUqOm14ZW4OZ+EAaVBVX4fngpy7xzBlJUmo+jkbqYih9EUh2mWX/1VkhLhjSnszL6C6Bxv76BQok/mTISOf83L8TwoKX0cFsx24mx888iRHYR1axPVzZH5kV0X107y7SIsalUkhAL7XfIsZYES33R6ORDCq/3Mld7CGFJSRYSWAKI7kqeWgBoDIO9nukJlm/pX3nC26iaxxPgR+wBlYGfhPdFdtGB5JxcSWLvgQW/jSf/tR0Tx3iWsmRdX52z/zj7Cjdm6HgT42v0UuFfNEiJ1wnXV9RVSwK7gpwDvjqyHLVSXxSIzKbsJ2NP6IVOqNwdS6AckkwVLMLrrIcwgaTCV4z0t0hylJuPfNy16s1BZLV9sZjKUPlyT0aFaLabm0CJaXei9qQdzxwIDmQOxGo2gU4DGSw9LLMU9eCSQv4t/raM2OWufh5SoZuxL7cDO0/WsS3ft+YCufg+/jSOXqQrJkduJ1hX0Aoy3xPEz9q212pFR4oCPinGhrTLojaE86Gt1dTu+0F5umAeGzKvw2CP3vUSEhD+VlOJkPA63gVXY7PyOSDcqwFrH2RP7aZdWxVmoUTndOf8m3/8Dy+bJwvBal7VDcN+5XCFppqZ11iVW0r6A8ON9bBDN36+wkkj3ZsQER3Tn7ZP0sI0lzrdptRKADs4lDHT7pawqDRQHnPnzsL2htrjGIZ/EUMJLFY05xfByrrBKjabVWJFEY5+HtRi61WuPTRfJdUxtC3N7hgPOAFAUi/YEOfBVDKj9IOQs5gD6plccd7kwQFtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(396003)(346002)(376002)(966005)(9686003)(6512007)(66556008)(5660300002)(6486002)(86362001)(83380400001)(66946007)(6506007)(26005)(186003)(41300700001)(2906002)(4326008)(478600001)(8676002)(66476007)(316002)(8936002)(38100700002)(54906003)(82960400001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ry8oMlfkZxQhnIeZObGK6kAQwG5KX9mNNqGfIICWPv1u6o41FYkZL/jMT15i?=
 =?us-ascii?Q?U4RBVONyb/Frvi+I9TdgdTu42ZNAUBTXPRPv5QKVOPiw/Yj0ZF6BLbvzTIB7?=
 =?us-ascii?Q?PdbwJU6lCmlcBUUSpimuEc1jOLu+prOE9VVoicpAA0edWr9F3tHTe1gysAi8?=
 =?us-ascii?Q?838T1mXIoOHCuTV9gAZHilrwwCbthX9kUqbRVzUYMgWGlAXQlKjKMHQixsT5?=
 =?us-ascii?Q?xQ6i6+svd5U3AalJnh+wG/dZj5S3FJbTl/QzKFZX0YIyPQfbVvkEOZllLUli?=
 =?us-ascii?Q?4AfxxGHaqvtMUWZIPt1yH21mc08PCcRxfEx97GIVmrZ6H+Ib0dZ2jUPjjPHw?=
 =?us-ascii?Q?ncM0KwpJJh6VKyMmC9Uz2wUjDnQVmSJqnYaHpp0f7RbECeajY/SYt0jjeG5U?=
 =?us-ascii?Q?NASUK8L7jMITSsTQBC6MGm5J/YEsMSwolpwP/bPojqSgMJnk8rTSvAeNWAUE?=
 =?us-ascii?Q?7FoJyT1ezgcCiUoFfLYl9dNkRBqeD2+7JKsREzKzepQe8dcrGyZJdGbY+smT?=
 =?us-ascii?Q?2djn1/ha3hKevf+RUFZTXTNO0O6IGfHjtIFfGz4gXaZNJixMfXXYtq7FkPHN?=
 =?us-ascii?Q?ozxhMGQc5kFgyrERkYghqZEKn9oV/az61483r8tktf39H/c0j10k4ee48zSZ?=
 =?us-ascii?Q?SMxVKboyYGAJtmYEf8UxG7zl0PpQ6cM3EPi4WBr9Mc/MpxCybh9fTTymX4Qo?=
 =?us-ascii?Q?c3Cjy+FuNGrh+oodtcY3cbjJ1ohwwhKc8IEnGQAiQhcHx2gVStxo5xfml0st?=
 =?us-ascii?Q?n17cU6OB2WznSuA2EquogJOE/o/vJtzxaADxCpcEDZ5HF/kGOp1XlTXayjbE?=
 =?us-ascii?Q?FLhqVsonXa48UmuUcDMcbXMKk39My20Uxcw8+s1szrmSYAyNhdPUmy/sU8fN?=
 =?us-ascii?Q?ifoSXI2zxfIm7GfGsAUvVBVU43AkCPV85+Mi32Csd0/c5BTDalPBKrWHvPvJ?=
 =?us-ascii?Q?ZZirkr9DNAMLk8+KCsxQETis8wOpwq+w76RcaMTv3LSfkf+5fj5yTuSW6+5F?=
 =?us-ascii?Q?bD5uhJrDV5XPJM6UFGm40GKlb+Xdye8AjH0d2girB/3zEUisfwlJIF5SbUkF?=
 =?us-ascii?Q?+g4vw/Ns1r79bXYfRsjuQKPp5b8m3luNXMhvAMLtkQXnAPR0sb/P1Dn1ugKG?=
 =?us-ascii?Q?rUl7MbPky0kYL4q37FTY+wHEaVHPfdahlEU45fRSanEPPlNglplfXLCKE4UI?=
 =?us-ascii?Q?hmhpCffOQllWkta29ssaQjD6EYMOOC75bFpkj2YI776FrYrkEVMy8+1k1qtH?=
 =?us-ascii?Q?xj+rwc8YHIeVNXcnujr2hLpzl9c1KfdygFWl+VpdCpjFRhS9QFoJIou/+FrU?=
 =?us-ascii?Q?eG4X/BxwSO095Z5RlJIx+A4msarhElvZt0b3gFKGPiVW1Rt7p1r3T2AmEObc?=
 =?us-ascii?Q?TGoJHvauSJIptY4d0orx3x3ewngxauQFKwcu5wP38li3VFrMLGHjqEa6+z29?=
 =?us-ascii?Q?08aMOOJyiPH0H2U++hFoR27hP7uDTnywF20nTje9csB/NiGjcYUXAMlQuvQ6?=
 =?us-ascii?Q?0OfQSdA3LPMXZi2hoJMZokq4mIwGBV+jqekQpF0fgWjmH7Wn8CIiecmMzTLL?=
 =?us-ascii?Q?fBOD5SJ1gsaWPPuFr9faASxaX0abk8SO5H7MeS94yaGxR5gHgvJQuI+BqajN?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8485d136-89e0-4d2b-84ab-08da55f6ce80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 15:32:54.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ox7WpuWRjWz8qCM9rPzA1+sh5ruD6ZiYOkNvQLlnPJd5Ggf4bKjBY5teTW0+QgvxfnaxmuqhoSSqGi7icTRuSpNtaLgGZeQsXenu53waHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:45:00 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > tl;dr: 46 patches is way too many patches to review in one sitting. Jump
> > to the PATCH SUMMARY below to find a subset of interest to jump into.
> > 
> > The series is also posted on the 'preview' branch [1]. Note that branch
> > rebases, the tip of that branch at time of posting is:
> > 
> > 7e5ad5cb1580 cxl/region: Introduce cxl_pmem_region objects
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=preview
> 
> Via a W=1 build some docs are out of sync with parameter names.
> I'm lazy so I'll leave finding the right patch to you ;)
> drivers/cxl/core/region.c:1490: warning: Function parameter or member 'type' not described in 'devm_cxl_add_region'

Added:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f2a0ead20ca7..f5ca4f811463 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -84,6 +84,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
  * @cxlrd: root decoder
  * @id: memregion id to create
  * @mode: mode for the endpoint decoders of this region
+ * @type: select whether this is an expander or accelerator (type-2 or type-3)
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.

...to patch 34.

> drivers/cxl/core/region.c:1719: warning: Function parameter or member 'cxlr' not described in 'devm_cxl_add_pmem_region'
> drivers/cxl/core/region.c:1719: warning: Excess function parameter 'host' description in 'devm_cxl_add_pmem_region'

Added:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 808148eef557..fa209fb649f7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1711,8 +1711,8 @@ static void cxlr_pmem_unregister(void *dev)
 }
 
 /**
- * devm_cxl_add_pmem_region() - add a cxl_region to nd_region bridge
- * @host: same host as @cxlmd
+ * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
+ * @cxlr: parent CXL region for this pmem region bridge device
  *
  * Return: 0 on success negative error code on failure.
  */

...to patch 46.

> whilst here, docs for generic_nvdimm_flush() need updating to reflect
> generic getting added to the name in 2019...

Sure, but not in this series.
