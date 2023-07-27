Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D8765E3E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjG0VbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjG0VbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 17:31:12 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709A3A80;
        Thu, 27 Jul 2023 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690493460; x=1722029460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CkhZtIXxv1Ech716DTrSGMW7GwhKbo3o5WNC/qwv8fw=;
  b=ZULZCbnSzBWtywjqLBZBHiLgXy18sxHcspAQ84yRMM6kwmbq3p0WisK/
   Q503vJrIyaDxdneArlcsqz+iyF6yF9QZ7KGRNMGKUbmAju8zMkwC26BFZ
   uwXzJ35KWM3mhNhaoGEX9f3+ZHJH81Kx6XcgyBg34jVcLQrexeDsIbuzC
   AMD+W44y+vp7U+DL1sc0hiOTIV4IeoEUJFfH1K3vBOM8oPKxdwtn43jBH
   8CBPgALTjK9j1MnnqT1PpUmlsFpghst9SKoTG2ubqFAG++UHzOiw2tgw6
   5h0Cbevf0j+wdfRdsQK/r7PG+RVRBqAYHBvnuu9uopzCa/95+tSd4BvEo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348047769"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348047769"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 14:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="704299547"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="704299547"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2023 14:30:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 14:30:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 14:30:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 14:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ7yaXl6UX/atzzbjKRagSWdu6xo92kwb4PJZLCsd9RVdvEzZcY4o+wwcoON/qPTKZtpqkj73tMStSKC3LkgKIRJDJ8vc1ErZj/LA3MGg9W1cNjSNMP84fi5/ApICW1totYU5FZxYz21Amk24D6mxvppvpmtUjpTvAU1Gp8+eaRe61c8qs43tYe7rgPmBqI3Qcb/+ZppyfBsWBLDlbY+3MkOK59k2WLymT0D8t9nLXo8lAEGGamH2fMeAC8GxvNccXP5nsMXKua6fu1cWp8eyxzlz63klcdOdzpi3PxEO0U4HCqblMeCzb5oIe+Q+Wm3tA2K61dwDmLOC+9P5cDtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUsI1eJx4UiRs/CLbV8GQxoyyMMDpPAkh121bCSsqIo=;
 b=ZaYkMpU2hVmEEk51uMkkVa1VfNTYdrrdFmfcZ4k4bK34y9rZvbMFxX+Kve/5lWMDk1na2D5VELEdO0RZHVSELT/9VL8YK3j7wV+DFnaBiCfg81xmfVxcY8n8y1bOSZoRCZF2XbSSW5lMtTHICwQOqePSbAD1fdtS29TYg1h6ZnwTxDXzr43wh9xj+rJtSorshMZEzKEUdc5ATgxH7kSx0t5/YyBtZa7Jo6t14u2jVkFb+YnrTHW8vdADgAGn1p8RNMJVA/5Yaovk2G6RBjwmnlae3t3yMyWBzw2c51dVFvm0yOjIfoFR7vHz7OfZbvyXDet5NC6qql1ARjyg9ncnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 27 Jul
 2023 21:30:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 21:30:57 +0000
Date:   Thu, 27 Jul 2023 14:30:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Fix destroy_work_on_stack() race
Message-ID: <64c2e20e58ad8_34b9a029479@iweiny-mobl.notmuch>
References: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
 <20230727202149.GA793572@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727202149.GA793572@bhelgaas>
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f94cbb4-1f6f-4181-1f42-08db8ee8c3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQChVJ4Z7Q8AwuuKnDm0KytSo1EBQampT2SPZeusKg5SuwJH8oyUAk91G+BPKWrUw1UNIK6OKcJrvT0WjOAmai96wh70nbBY4NMWuimPA4iQDQdFXTTg5miOpGyY9QbgZJww7oOZQUma4N5e49Fw4JOOrY+rW5B2CJvqpbP7mw3ex1oqDGyJ8IPXeKle/dITzMbQaLgJV/e8d0rVel10bboXYo/ZsbwbzM7Zq/N/PQu855ZuyshKxB0qoI/2khQU4yli0lUF45+BTVUpOeYBoDKbh2pkHhDvDDC4tKQATi7c0tHX1fvEkK4QdOKiNpC2hTaV1NXhPpSf1gTYV1MfonXNeDysUvRAdRFXYV/K2jAvQbdIs0ZxZ4Gp1y1TA70Yu7ajIDOqN8jGTXrLVjaM3xENEgEQAflJBCf9ukOS8tIrWZ4s2PvVs7cnTTEv7WYevdcZA18Zt7oUxyQ6d8EdDoA7kAn9rkBKdvcs6ESsaJrS+lqp4JFXb5ubZukcCGT7dGKc4itWt0j+PoTHk4oj7Q/yCFRjbZCipemPhAYQGD6NmpyN4mMW1Qm9ViNwDBli
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(8676002)(478600001)(86362001)(6666004)(66476007)(66556008)(66946007)(54906003)(6512007)(4326008)(9686003)(6486002)(41300700001)(110136005)(82960400001)(8936002)(6506007)(5660300002)(26005)(38100700002)(186003)(44832011)(316002)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjKC2vJG2t93NRux63g1XwPP/gZpzqK6nvdFvnQWuYkJLVS1is9NOLrWL+WA?=
 =?us-ascii?Q?5VbRW1SJPn87V7VNpo2T+qIpVV+yNxYgN6FBEPCDtZyye8pTlxyvESfOBPe9?=
 =?us-ascii?Q?RCXA6hRaPczYD6FVNwtMuXElzLDrwMhDIGkQIr9ycoN7YYj4NrU6zWHCJNWs?=
 =?us-ascii?Q?6bVv5EO/EHLnqzLodKVlpbDHvmoX0VFG0XehbPJG6/mY64lHuWUw6HkNRVi6?=
 =?us-ascii?Q?HfUiDCKsErHWq9Br9Rd07iNj7cao2irPu4XS0Boa+Q5S0IakXwIBI+KW9HjP?=
 =?us-ascii?Q?v22tVaMOIUSXX+dWISONneySVkqvEh6JFHMFJhpGMjUAhvAAeRmjkIlrQXn/?=
 =?us-ascii?Q?GjWE0TggKm5+axISY0OqF7ZT5RQ+l7wEMAel9cXpAj2GQzn0/1ugPXQn+zkM?=
 =?us-ascii?Q?G/62/QcGuYAxHhmA0d9pqFW1SUpm0MTZ6HDrEau+rsWrgkYW3hBG7YLzSvx/?=
 =?us-ascii?Q?7L8StneZ/c1pPNo9AFq7LHa0tlCPjEsvl1WavT3NTxeEGV7gbZ+JHLumrToN?=
 =?us-ascii?Q?WX7cBhPX/X1CgmCreFJ9e2egvp+kDmUVm0fxm8609vX4nXW8Ey4Lne0LicMd?=
 =?us-ascii?Q?wdC4Z8rGVSHTBd27FU6KC84Ek4RY4hplvChIOq60pyX1/cm7rNrAEOCcY/Ts?=
 =?us-ascii?Q?6cIkx7+//LTPCXTn1G3L8Ki5JbydBVoNykP6aISsYO2Azn4PF6KQB05M07z/?=
 =?us-ascii?Q?Pm0qTzWeJ8wB7KZ+yqirmMDO+UKY+KyyxpiSmnSq1KlFCbForj+UL3xVzZGO?=
 =?us-ascii?Q?jxzS2ic5WLjHZR86CLY4qgP801W87Kal9BM6L/nKSRuQFxoiCHP7QT8/4Dcx?=
 =?us-ascii?Q?gp8OrJ51AD4g2lto0hQefM0RZi1TM78zd7i+ztjoS8RInqdt6m0Edz3kpjMV?=
 =?us-ascii?Q?DoUEwmKf5p0qqXgAsC/Jq++ZAnyv2nlmsPuycxAzkgNuniay3gAhQKXOwUbi?=
 =?us-ascii?Q?ReYWffSPlqsGXVFB+REpWyX27QdIz8jL/VbYSJK+sKN5KLl9cJvuSXUZvXrL?=
 =?us-ascii?Q?YMluKLhQZNS0r1QJa8qxPyuDv+AtyU/XheSHP3NE3hjjE84bBuQtFJgnOHZl?=
 =?us-ascii?Q?BXUbXHJ6Z5JzmWlmjHW1vYAbRp/hTZhutgl+NiSZPa4GsIwtlrYVyPJn5DRH?=
 =?us-ascii?Q?DbtytDoLIgeiJqHMchwx1aH6e9ZW85oHk9Nnc+B6EZkSYZhOx5/+w43gNeqB?=
 =?us-ascii?Q?0eL8+1M1o6EXfOAYmkwhxByMrBj3DTkRfcGhI2ImVqpZg2W4pBmrx0wr2IJB?=
 =?us-ascii?Q?bS6Qj9rDtVriZ56KMAWe36YpNbMhGoimEEo8wgWTP2OVvtDKdwvnSzggH4dZ?=
 =?us-ascii?Q?KmkvPk/qcfjGnKTf8HG3rFc5KNzfzkSh43ak+6T9gjKo+Vbl4reyJt012mJ/?=
 =?us-ascii?Q?KuWA8Ei6AXrtSX4/v3UQa1PR5Z0R/eyIVx+2X8GQvjeZYs7NZ3dRhE3gKZlc?=
 =?us-ascii?Q?IxlmMaQE69gvLixrokwQhMVRdN8K0vmTlRoereNvwverR+z00JJRM5LU3lCV?=
 =?us-ascii?Q?SNU7KQb3qH3Ul7h6LXBbMJL5y8cg0Gukxah48on6yg1SSqewr1B14vhU02wa?=
 =?us-ascii?Q?Dg1CAIrpRwRYRAv5NdKTuLgsE6FWpHkoy98FrqoO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f94cbb4-1f6f-4181-1f42-08db8ee8c3e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:30:57.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRAecyycpV8UN6Z8vG4hsMPSbvTjcEQu8whSaOiFRPt2L/QvaNX9Ozo+Pnod0o/DXJTi6TmLgDAFdPZNdkXO2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> On Wed, Jul 26, 2023 at 11:29:42AM -0700, Ira Weiny wrote:
> > The following debug object splat was observed in testing.
> > 
> >   [   14.061937] ------------[ cut here ]------------
> >   [   14.063899] ODEBUG: free active (active state 0) object: 0000000097d23782 object type: work_struct hint: doe_statemachine_work+0x0/0x510
> >   [   14.067480] WARNING: CPU: 1 PID: 71 at lib/debugobjects.c:514 debug_print_object+0x7d/0xb0
> >   ...
> >   [   14.080951] Workqueue: pci 0000:36:00.0 DOE [1 doe_statemachine_work
> >   [   14.083485] RIP: 0010:debug_print_object+0x7d/0xb0
> >   ...
> >   [   14.116231] Call Trace:
> >   [   14.117652]  <TASK>
> >   [   14.118958]  ? debug_print_object+0x7d/0xb0
> >   [   14.120782]  ? __warn+0x7d/0x130
> >   [   14.122399]  ? debug_print_object+0x7d/0xb0
> >   [   14.123746]  ? report_bug+0x18d/0x1c0
> >   [   14.125025]  ? handle_bug+0x3c/0x80
> >   [   14.126506]  ? exc_invalid_op+0x13/0x60
> >   [   14.127796]  ? asm_exc_invalid_op+0x16/0x20
> >   [   14.129380]  ? debug_print_object+0x7d/0xb0
> >   [   14.130688]  ? debug_print_object+0x7d/0xb0
> >   [   14.131997]  ? __pfx_doe_statemachine_work+0x10/0x10
> >   [   14.133597]  debug_object_free.part.0+0x11b/0x150
> >   [   14.134940]  doe_statemachine_work+0x45e/0x510
> >   [   14.136348]  process_one_work+0x1d4/0x3c0
> >   ...
> >   [   14.161484]  </TASK>
> >   [   14.162434] ---[ end trace 0000000000000000 ]---
> > 
> > This occurs because destroy_work_on_stack() was called after signaling
> > the completion in the calling thread.  This creates a race between
> > destroy_work_on_stack() and the task->work struct going of scope in the
> > pci_doe().
> > 
> > Signal the work complete after destroying the work struct.  This is safe
> > because signal_task_complete() is the final thing the work item does and
> > the workqueue code is careful not to access the work struct after.
> > 
> > Fixes: abf04be0e707 ("PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y")
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Thanks, applied to pci/misc with Lukas' reviewed-by and Dan's ack for
> v6.6.  I edited out the timestamps and some of the call trace from the
> splat because they didn't seem relevant.
> 

Thanks.  I'll make sure to remove the timestamps in future.
Ira
