Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AC553AB8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiFUTlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354083AbiFUTll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 15:41:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1EDF04;
        Tue, 21 Jun 2022 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655840500; x=1687376500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8rp1ehSZ3VlqJr08QgQJqkk62p3FXhb8SiOzFu1Tkm4=;
  b=XSWOjbd/4ooH8Z5S7RFvc+ljbYnL27kDnVTO4ClOgBiICcVfokwxyT2Z
   mnWT3q4jrsreNLP0HcSdBJ4KYG2OnpkVVzPmZ8DIfnuZ2pLaHneYZhQrN
   YUpzjxnJnLzdH2wcA7eUJzXPpNR7/x76YteYR43U65p1iRKc7E8VRPzGY
   F20WCowAttDRAB45hunw8qbDfX6mBDz5q8Y3RLy7sAMafjFuXmTPiqOtV
   Oi9+G2McCCw5DkuLHw3jBW2Ip5h055kgDxJ9gaCONWia2HtSeJcGFSMFx
   5FvCFwzqxlDRcIMHVAMFLQQV/dH1/9qkNWsGWfoAA5ETEeLufmhbkSHxk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="278990150"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="278990150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="620612672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2022 12:41:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 12:41:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 12:41:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 12:41:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEIayn59rWSbB/cqi324RKOd9+3I9gFPJKkaSWY0NNcQT1N9wlaVbPYjlRxSorWHStY0yonXpzau6GyNzZRKYfNK4VWM+82ubPvRe1aIC4mPeNEMCfb2Q2TkC3KK6Sh6jKgFbBnlQTh8yUvNYrFFeA1tjcy153Ax7u8Ys8ARqQaEf8HUpOUkHpnxvrC18FaUyWE2lYEoLCuRNkYd32oZ3C1/3ulIi+vu3AciIqYbGQipA9geEa2j/DL1oQkHFnYsI1b5rOscYz9e63A8ypkrH2YJReznI9MWbuNfC1J3So8wxqHj2JBvdBKcoc2sIvx2Ss3OEGPIuJbQcurY4A9OAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIwWfGChs8Go64zgtWxZEMg9EYWAz6tw/1jWTOPtfV4=;
 b=N7Hp+PyNRkXMya2Fq8pJaXDqkSSfggeKGh6ZC7kYqELzIiC8Bmu4kh3U+s8fxU7bNKjBwwA4grxyb2OnaZnWOCW9nKJN29M64GHQ39vq9Gv+Lnw4pwJ2+9u8NY4lf0Oa6szCwwZCstn7alH6FhjnX+pc3nkOjVLEiCoRtYgY0BkLoxUaY1HaeGJ+4AQmKgflvw7vZtrbwklBROkDeJs3WSe9381BuWoDe5C+hFyVkcGttjj/UdaQIMBxgKzUeKopdfZS6J52R1IwA6V1ppJpeovu5434BkieuIaG9xN++DkVlRXj5ijBn6UACtBjT7MVoZMO8l3tYCMLunWU4xt+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR11MB1264.namprd11.prod.outlook.com
 (2603:10b6:300:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 19:41:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 19:41:38 +0000
Date:   Tue, 21 Jun 2022 12:41:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <62b21eefaf9ef_89207294e4@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
 <62b2178bdcf5d_89207294ac@dwillia2-xfh.notmuch>
 <20220621193427.GA25003@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220621193427.GA25003@wunner.de>
X-ClientProxiedBy: MWHPR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:300:ee::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff2a74b-34fc-46ad-e61e-08da53be0e6d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1264:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB12649FF9BB71FCB0B377D00DC6B39@MWHPR11MB1264.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S814x5AgRfEG+u9Bi8iR8R65ceXQW3otQMRacuPCZXHAVnJAtjP/lxGm21UM/dv+zAA2+Kr68yrl6bHxg25brhS8kkC1k/q8kbPrnl+Swbsgk2CLUVUiuRZsWWwQmFSbqmXaPyrxjARI8yX/Cf6wI9MqQuDc98l9aNjBrf7xuLGTczLW9ABl+uJNNPkR7QSYD5tU+1rG9853uw5vmGbhKwgNdFkxRJzxoA80AqHfdXhH2PrAYUin2hM3tLQU/Jsd3tBmAS9VcYybc7wECNhixOO4a3uS95hpINd/h1Bh9bm4wMaEUXOkgttr1mUrXwBBtm+EIuU7QN+enN8Tzi+esH3NaS1SSWvQQFnSiEUej46DJvjpYK/UZBQfSRJ6SZ1fXsxzYTtyef/GM7PONi2vxWojxEQ3qfW8Vg5gtBCyUzIe4cD16Q/7vi35mrglNyhrAAogE0nix/Vk7GZzpnJl5pfLTNLlO5fBVvBJFfemil3KW/XdKzh1IAQECj61IxMnUuYQsGnb74pqOPRd++XwXaeODDXFcytBTNCWuqWV/vS0wmPtYRmUxzAmncrWWCFiK7uXGcJn/uxAERaGNuVyG+Hl4ohVVNnUoQM/KhHrI+StbJKv9ih+CPXIOLOkzEOkq3+UybAbMJHxJrorq8H4Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(82960400001)(83380400001)(2906002)(66476007)(86362001)(26005)(66946007)(38100700002)(4326008)(6666004)(66556008)(8676002)(9686003)(6512007)(478600001)(6486002)(8936002)(54906003)(6506007)(186003)(41300700001)(110136005)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQAcuMTq+KlEhmbF73JHNK5SPDeUWSymZl+uFEOD3b03JuEJm15MPnvnhbPs?=
 =?us-ascii?Q?RXK4aiDv4iql9UjZ19YXhPJJx50p2CRgmxhvpLUJsMARBa/uW5gyu8aTaso0?=
 =?us-ascii?Q?nqLA+C/InNHHvyAgqnrQ9r76yHxiqE3pR61YW91/jpURTcHr1keiU5vyuHhx?=
 =?us-ascii?Q?TSTx+RoTaeYXX4BF6Az8NQgav40iutkfGeCJA33cxhfM/xQ/xJTtqPHd1LTb?=
 =?us-ascii?Q?DT4+l0cfVX+OO6BZYBWJ4oaFT2WU9UbSnZ2Kgwec9R+5u4ItLN7zx7tsxIoD?=
 =?us-ascii?Q?kw8K08S8Mv+SIyDZX6mUmtZ5BqSgqGUuFJMBe2nI41TNUBJHub4S7SMfJk9j?=
 =?us-ascii?Q?0NLT37G63YJDBO/sv0ddCBwTnawoPZNEB6iBkB4ETD5DwWYL6DT9KX9GkWeM?=
 =?us-ascii?Q?c+ijQeHTFdBQyxlKgYaHfkzLpzONpRm9xKtn6ysEN2beZnjkshLNC9v+XWy6?=
 =?us-ascii?Q?FLO6jWDFN82PEP019yzPkNVkU+yIvoPPjd7w5zPVo/qLUV0aZBJYG0IhlQSe?=
 =?us-ascii?Q?eE1/Wt6G4N8oIIKWfkU35IHHKnb8RSKQpyiXkT187TGZ00AFTDXDp6EJKWzS?=
 =?us-ascii?Q?vLCGq7eFVyHnJulf8HFrlP51fQ+5VbQ1+haAQFKcDDUTG71VGEzhwIGyal5q?=
 =?us-ascii?Q?/r5z/kBpAhnlLgi7/xk5wd0B0D7HW5/3QWTl216zgOpI6ie+94U0STvWh7rm?=
 =?us-ascii?Q?XtTWJUR0pB5p/Dxc+G7quuY5wGcJj+zGAWYGkAreDgrSRT12HO9oGXttogK5?=
 =?us-ascii?Q?XFzrcRQdlsDIjzeV28ZgDEe3OpNllQQm1AhI4eSHCmst4Cu8I1L9NPvNOa6s?=
 =?us-ascii?Q?SFkkWi4C/jjxN/LnEHtQpMfQIok1vZ6+Fq0V+Vt4YYjk7AhAMWauSRvaVJpf?=
 =?us-ascii?Q?LGqnPffrHwpxbrbe1hzin2LpyDwX6PRemgYB5yDiGdrFiowqn3a5VKD7yYUp?=
 =?us-ascii?Q?AZKpZuHCyfDNOViSnk8NJSkr3XI1lQIJXyBW06IUlyu23/zE3v3CHqrwkDvr?=
 =?us-ascii?Q?C6F9fXJDnEbou8RjXevSokZvJDcvhkDQxcLrsXJjhjizsVJtLQgbCeGbBl7H?=
 =?us-ascii?Q?+DEkYX4LfjVc6sjwJ8+iU1z81CnobWamP9PAnmiVPq4UAEeR40cDibix/NZE?=
 =?us-ascii?Q?eEu12rlEiD/RYCSzv4YeoEwvESNuWDicoAwlG36WWrhZsx92KufxvluEJMCF?=
 =?us-ascii?Q?GcadXlv4uSpde9Vm+po2G2UyPHJK4H33VsPpVQrknspFCq26udULpuf6OHNN?=
 =?us-ascii?Q?1IT8WHO2ZjX7cUA6vjz/7IsMlKFzi89QbwdWqjta77QXBkq/LQ9dDI8BeewM?=
 =?us-ascii?Q?CJWpS2qeJ63wzA+U748FAhyGgbHa2Z4TZ55i6gGjuFvSqduDb282eSuHAOOA?=
 =?us-ascii?Q?XATeNYCWHUP3kL/QFntiHvTuETDKZNUQcc5qyIWUfvmI7CwkjixDdWfqO6CT?=
 =?us-ascii?Q?OG7PB7XwmbCNqT1wS2FIb59Hzv7SiN1DuPLnwOV/YZWeVi00l2S0XWhVSny5?=
 =?us-ascii?Q?3ClvkOZJ7nDvURr2QzjsIG/tV0J+AKLWYsv5W8lTfyWV4H4UbcPfEBAOz3PY?=
 =?us-ascii?Q?eViZhonFbxT5zqh9qwVOLlQjMuwWTp90HCbaui//VP/pIJChMtwTI4uTnmGS?=
 =?us-ascii?Q?WCwUepW6UA0dbptHB+NgDCzBrPFeKHHqhnnW/zPqSjE6pRjJpUCwDXMt+/VT?=
 =?us-ascii?Q?UlLG31ui5QdFFnkrzhmY5mZG8VyP9F1rjGw07QBXacnn1dSffPgX23Obecxt?=
 =?us-ascii?Q?yOBeAOWW/8QjaM8itm8xleQtpr6UREI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff2a74b-34fc-46ad-e61e-08da53be0e6d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 19:41:37.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TU/d3VEWGX81XqVXY+59DRzXKNpwwNlhMrvFPGwDp1Qxh9+oejJCcm8TWPSu8zNaWJh7z3zITKi7AWHQ155AT9Q3a8GZyp75Y+NGSSXYPt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1264
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

Lukas Wunner wrote:
> On Tue, Jun 21, 2022 at 12:10:03PM -0700, Dan Williams wrote:
> > It is really the interrupt setup that makes this an awkward fit all
> > around. The PCI core knows how to handle capabilities with interrupts,
> > but only for PCIe port services. DOE is both a PCIe port service *and*
> > and "endpoint service" like VPD (pci_vpd_init()). The more I think about
> > this the closer I get to the recommendation from Lukas which is that
> > DOE is more like pci_vpd_init() than pci_aer_init(), or a custom
> > enabling per driver.
> > 
> > If the DOE enumeration moves to a sub-function of
> > pci_init_capabilities() then the cxl_pci and/or cxl_port drivers just
> > look those up and use them. The DOE instances would remain in polled
> > mode unless and until a PCI driver added interrupt support late. In
> > other words, DOE can follow the VPD init model as long as interrupts are
> > not involved, and if interrupts are desired it requires late allocation
> > of IRQ vectors.
> 
> Thomas Gleixner has been working on dynamic allocation of MSI-X vectors.
> We should probably just build on that and let the PCI core allocate
> vectors for DOE mailboxes independently from drivers.
> 
> To conserve vectors, I'd delay allocation for a DOE mailbox until
> it is first used.  There may be mailboxes that are never used.
> 
> DOE requires MSI-X or MSI.  We could probably leave MSI unsupported
> until a device with broken MSI-X support shows up.  I envision that
> with MSI, the onus is on the driver to allocate vectors for mailboxes
> it intends to use and it would then have to "donate" those vectors
> to the PCI core via a library function.
> 
> As for portdrv, that's a driver but Bjorn has expressed a desire
> for a long time to move its functionality into the PCI core.
> It shouldn't be allowed to unbind portdrv via sysfs and thus break
> DPC etc, as is currently possible.
> 
> The question with regards to this series is, do we get *something*
> merged and perfect it over time once it's in the tree, or do we
> keep iterating on the mailing list.  I deliberately only provided
> a single, comprehensive review and then stayed mum because I feel
> bad for Ira having to keep reacting to more and more feedback
> despite being at v11 already (or v12?  I've lost count).
> Particularly because I suspect (I might be mistaken) that Ira's
> natural habitat is actually CXL not PCI, so it might be a burden for him.
> I'd be fine to implement suggestions I've made myself after Ira's
> series lands.  No need for him to keep iterating ad infinitum.

Yeah, sounds good. If the dynamic IRQ allocation support is on its way
then lets leave interrupt support out of the current DOE series and just
focus on getting polled mode going with the enumeration coming from the
PCI core.  That seems the shortest path to get something landed and
enables incremental improvement. Then the messiness of DOE interrupt
allocation and pcie_port_drv reworks can be saved for PCI core folks.
