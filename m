Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781D56D053
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGJRKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGJRKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 13:10:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E613E87;
        Sun, 10 Jul 2022 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657472999; x=1689008999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i6IFC2IK7TM45Lut6130rRqiBwT4YSycQKeAu/yqw1o=;
  b=nR0Rh7I8Far8mrgUXAbAvQxFdhaq0t1hf/uSWlxrf3G/sz57eEUIj/fF
   z1mkUlYO7FlQDvZGn0HJ3b/RX8jwYetnElBT0DL8BkVHaTXx31ZoH09qD
   5bDQx0K9wBJKqHQMoMYrx+xK/a2ZZdyXnayV7kNuQios6jXHqjSo9ujMK
   f2cdk8+FFAyzOjkkikNjiv+JAaLOceMsTAS9MnhfMFUjIzFtWyWrV0Bfe
   ZoWT37Jh77Bo5eArlPZZZogPSdzaNNcZsfL1SwmQTAM0AvQ4f3oSAYWU7
   W69abBVrWWbs9KthLsDjw23xg1lYUy6k/irWXKlYVkbuOimGDcljmiYy6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370837017"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="370837017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 10:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="736854661"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2022 10:09:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 10:09:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 10:09:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 10:09:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 10:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGQjdCwJt6gRQ9+W3JxlTqClpmq1XUiLnZW3mOql2wzKhQ1KXFk5hMB2aWgd8zVYuGlYsSjDzrnuGCVsLtr0U0JyEmsDuc2QqDcsqGSrJ6FFWttX48KXzBNxss1bB0fLeBaDacNKs2dEcWxKv6rQPn7Pdc/shuO2IMLPdkoTuht+p71hkggCGiG+JGqrsQ4WYpfi2ia9cGQXTMV2KQcUgrlUEqhU5pic70wB7jXWaYr0eIZHqDooRI5lO16qa+FQPIdJxxjOChhVZc/MQwLp1FITqRcMYHjDub8E22sMYPqTUEooJraeK3FKvqJLyp0e7Bg2/l/vyhgefNX8BVEdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqf17WEyyNgYfC/tNvcd3WnzV7J23tytUqu7mM+/kOA=;
 b=Eowb6h9hLdziGdOKuZJ4ohQNaxJ7bOtCpCDzNErwCeuj6B10q1eULBMgzZW/3T7RkaDRHrw8i2dlU/y+HLIJk8W5ZyaYT4+EaKQmFVhJPKKXEQyH4kFv3mwWCjOV1ZpmsbV4dc4u+bysBkp5yBviEAGT5HYMa01SDwEbiZ2Gj3Fscgt09yciIOrqCEaWKuZuX+hy38AHbrF5QHm1uqUOt3QiRwgaDDziNJTeK8jGrK28drevHPeeNQvO/cq2HhRwMb2gSmu62DoQTx0OFPk0Pwdw1B7Und6V9XL7qj8nMCPg9KsvfSgnrVY58bokAgZ3Y73vkYVAON0zSiZ/mpiUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6315.namprd11.prod.outlook.com
 (2603:10b6:208:3b2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Sun, 10 Jul
 2022 17:09:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 17:09:55 +0000
Date:   Sun, 10 Jul 2022 10:09:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 20/46] cxl/mem: Add a debugfs version of 'iomem' for DPA,
 'dpamem'
Message-ID: <62cb07e0505de_3177ca294a3@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603885318.551046.8308248564880066726.stgit@dwillia2-xfh>
 <20220629170841.000078e5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629170841.000078e5@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4537cc7-12c5-4039-d474-08da6297028b
X-MS-TrafficTypeDiagnostic: BL3PR11MB6315:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXA8HYL/fXNYNYry0el1E7iQCOyDlb6zf4tLuDKuGh0zPw2gFiS60egNLlqlj63vqD3ieKfHhQU4ETaANJNIK1BNfWkt6PBFV0f0e5DAg+6lKDmq1e2bthldXEL2VzgPv5sLe3c6nNy876NDIsRkA8y0/VXrp2rLguM4nttDC4jI4Y0oaalHRoY4AmwAY1h1oq6SvDf3UhtaP6AMiiKfGY9gnlRo+5HmU/A7tgk50/kyGS7vvSLouFoLINuPyb8hIwgEGAYLU8mdI5/PTyzxc1WvWYJMi9tYVcprKQG2iyVSSD/THwwUQAp+VTWJBnn3GyzcQ9DtYzmOJVWIcJpvtghmemQQIKcc0qHWIECKfJPYE3zXAAUEqaqGiOAH3gD0D9rXyUnRjlQqOgsL8yDG/9rA48sfJeeL18bYCdnDOUDXkt1Ztkn3OdD/ByBkngxona9pSA1apwobtPAks5iP/vHoGgVIk2IjrNxgQMrQ42YpYNVwBhs/J1XQTpqe7YdVHCDIzOAvNOP6SVcF6+ItNMgfkE0w7prn79dKaNiIjOWZA03rVF5FzAIn8zBi1GJM3DZob+KAs40yI4UfdoXTd2smujUKdGLoxG6G+lrJVLqN8bDvZ+TuO4fuzQLRv7DXAyxtEN3CJPNYOueXQAo9M/u1FU4zOJM5z/3u3wGB2mayLus4je0wDVXVNJr5uMkBCri2OT1Lrk+H6peWQc2g7UaM++ZbNol5AYb2Ox70v2L3E1NqkbqcYX4a11EVthp8mhBe0PLonvzSowyojMRkmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(346002)(136003)(8936002)(66556008)(2906002)(316002)(38100700002)(66946007)(66476007)(8676002)(4326008)(82960400001)(5660300002)(86362001)(41300700001)(83380400001)(6666004)(9686003)(110136005)(6486002)(26005)(186003)(478600001)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUBJSUifHmtyIAze2AfrKH9WXnqFnOXI7BXrU55JZQkwtJOpJRtdqk+zY7F/?=
 =?us-ascii?Q?zmokT0BfumtWc0qPPJamkjM65HiiUYGgvniYw6Rso6aXIrBI4KbUSyQXzoSY?=
 =?us-ascii?Q?AP4gM62DMe0lMzFacTg+VhqMwfQJTijJrpMN6Ps7AVZHSe+tzqBUNeiEgfqQ?=
 =?us-ascii?Q?R/BjhqewKV8pbfXbNiAONBf5T01Eap3d3w2wSy15Msuo/7eD5wNDxBMl8VpB?=
 =?us-ascii?Q?5O2Hqh34tTdopaeZOP9nEFL+Bk43h005tpk2ZFyBk/+rp/aJP6uYDQKJpQyL?=
 =?us-ascii?Q?02Sv934IWfHyQjUZ5RVdTHthokTGfoPDyuumMJF4h7532xoPSy+hihyNh827?=
 =?us-ascii?Q?FThf7U1r+4boygmOV7n4bQJ7H/NPoPTQQM9egwwl+FJQ5q+BV25icZ0MIlyY?=
 =?us-ascii?Q?OXeWVHmzSuL60lPRP1b1i8/NU53Lw9pSSTVqK06Zwmhbu931mnGQNvI0IuKi?=
 =?us-ascii?Q?rijnXYYVDikt2fCTj3z7/JuSJ+kQ0VtFYn85rc0y0ouQNYUt5Y2G/TiyptxP?=
 =?us-ascii?Q?EiJt4U/rCXDfzJZONGhDjobMQEmjshXJ5rSSHjuj8EQwadPCoJFgOxlRF60A?=
 =?us-ascii?Q?IvipBXuYkpfffw838dowUJrRvDwBva6osHBI4x+UiHNBE5qDxiY8Lq73rkJY?=
 =?us-ascii?Q?hNuzZC4YMYL7YVEKNm33V70Eu1n8E6vudRZ/9p8FlplHH/GG1yBISuGiQeAJ?=
 =?us-ascii?Q?KHBXa0cewKIVGUZbQBp9NlxLnLX9AnSkh9x7iVtkWsWuaX+dFS53mMgjXF0w?=
 =?us-ascii?Q?kiowsZDhnvx+9uJULNq00z897MBQCFzQx8NV29L327VVNmwoSd+CxUC0Lthh?=
 =?us-ascii?Q?5iFdP/B3fQcfn0ClzMa9Q13eamG7fgUGrYoiOAbF7hNlIUQIf89SOrpBWoSo?=
 =?us-ascii?Q?o4A/518XgWUAnA59rID+fTjVBYTw++R/QPJhh9Iioh/GjosZmIXihwZZnQ9H?=
 =?us-ascii?Q?ZyWSt519gBVszL2eSyuoxrEngzvfRIPU1jBervD/JTydcZzsljmOf8fNVqhg?=
 =?us-ascii?Q?5BAXM8RXlTtMlhMjtS7yS7+IlXbNdCJGmdRuP6x0hj+Qkp9+tw612JtjPU29?=
 =?us-ascii?Q?/NgGDdGGvMddH+i2yOnzqTQGegjtS+IHNKpGmqH87ax8u0t4UK/VLQY7QWK7?=
 =?us-ascii?Q?5ao0wjf44g/igACjw3133MjBkzP+Wwil+2kRa6PA1ZHqz/MOSUEei2zz//Jn?=
 =?us-ascii?Q?4sl5AM4HgOX902plS7PmJ4JTbL+Q8we9rvBrcUPtlTgc36SXFddymKrNFfz3?=
 =?us-ascii?Q?gsi+o2/X3CPgdFsG5miUwTEgl3PnYF7t3LNXdYEHnoyC9Ke54Ej9Xdy/TSoe?=
 =?us-ascii?Q?sewGw3/NCdF7uk0Svv4v3odAzQ3nl9UeP6NzfOh7qMG6gMJgOuoVJQ4UuRs1?=
 =?us-ascii?Q?byQrege7hxlgNexxK1V7DGNn+tFWrtIYRTEm1BReRdwd9SKwyXZvhgyeWQLJ?=
 =?us-ascii?Q?cZUfsOvTOf+keiv613TJXnPT+b3iKpHEULCbJOoAEXjjTcv1EL/PsROtGUG9?=
 =?us-ascii?Q?uNX+GaAtjzgNiMD27HALHTEJS9xPboLxk+5ebJwKRiz/1/OhVdCyiRkOeftL?=
 =?us-ascii?Q?7grUug/by/rWrbSYdIaJh1V168dKb54eRbw0skC6dPayK6s+WQJFuMp4E2jy?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4537cc7-12c5-4039-d474-08da6297028b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 17:09:55.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naRP9kyUnTxyv/DbEY/DFbKyebnQfBTN0Tj3ecsHFh/kjRGsg/1e0fy1z3uww2JfQF5ziTSZ8Qv/3dbCZmhR4bye9EAnbQkeSJX4ZTvpzz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
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
> On Thu, 23 Jun 2022 19:47:33 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dump the device-physial-address map for a CXL expander in /proc/iomem
> > style format. E.g.:
> > 
> >   cat /sys/kernel/debug/cxl/mem1/dpamem
> >   00000000-0fffffff : ram
> >   10000000-1fffffff : pmem
> 
> Nice in general, but...
> 
> When I just checked what this looked like on my test setup. I'm 
> seeing
> 00000000-0ffffff : pmem
>   00000000-0fffff : endpoint3
> 
> Seems odd to see an endpoint nested below a pmem.  Wrong name somewhere
> in a later patch. I'd expect that to be a decoder rather than the endpoint...
> If I spot where that comes from whilst reviewing I'll call it out, but
> didn't want to forget to raise it.

Ah, yes, agree should be the decoder name not the port name for the
allocation.

The bug was actually back in the introduction of cxl_dpa_reserve().
Folded in the following to "[PATCH 14/46] cxl/hdm: Enumerate allocated
DPA":

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1b902966db78..8a677f5f3942 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -180,7 +180,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
        if (skipped) {
                res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
-                                      dev_name(dev), 0);
+                                      dev_name(&cxled->cxld.dev), 0);
                if (!res) {
                        dev_dbg(dev,
                                "decoder%d.%d: failed to reserve skipped space\n",
@@ -188,7 +188,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
                        return -EBUSY;
                }
        }
-       res = __request_region(&cxlds->dpa_res, base, len, dev_name(dev), 0);
+       res = __request_region(&cxlds->dpa_res, base, len,
+                              dev_name(&cxled->cxld.dev), 0);
        if (!res) {
                dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
                        port->id, cxled->cxld.id);
