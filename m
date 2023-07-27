Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A01765C79
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjG0Txh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjG0Txg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 15:53:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DB2D45;
        Thu, 27 Jul 2023 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690487615; x=1722023615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZoeZeDMJlZBwg1vI7DgJG0REICFA29PeLYFNDep0PqE=;
  b=Y9e8SvWkDWFuOJwPplfPv7ke2CTbNsEW9VvQvfa07jc7TzIOz7ep8L/X
   kMFrv7HF6xuD75VUIRxY10UDXqk/oygy73FHM/pMamwsIfyMPQ9+rDj+s
   qltOvdax6608pRIzGvn2T9gqvfwB50nBH6WcN2dxnLw7tgerGZw69vKsV
   QrtQ7it+5Jl3alqS9GZmMJ1C11MjfG4yHXA3X7rm7a+Ag9b6b8GSVcKvH
   l0K+3hGXdMaF5UYepQCOCec6z3R9CnUAD9E5h3KxEdj2suoUfiG+xMUC0
   TbGLnlDqWm31QiCspEH3tC/JrF6f04LZUqATU8KBA405Sre2u1rHGV5wc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454784750"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454784750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 12:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="720970520"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="720970520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2023 12:53:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 12:53:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 12:53:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 12:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvivzTZ1xICDMb/QS/VAlict2WQ5yYT3vLncsz2BGMkvDVE4/q/RFzuzyCTJY1E5J0Gl9T7EYctGmV7cOfkZlN4c82Ii7DL/1y8tJr9En8orhJD4Z/WfxDwhsjB66kGa6A+JeLZv+CpaxVULwai5Qt6kXZ56BSm5hipURkRAvNVz3Q0cnu2TR1o2JYz5gIRRPoVAnZm/btb5u6TRr5oVjQMJ8WKKYu4FqMPidbqTM1COj8NsnpLOCSrPwDL8S2guPZNuF+OL7Tr3RV7S57PTExh2HraBmCqkrZQxc0HGt4HLKgkqVtYPcOKqxS7A4NE9vYPDdcDYpKEQRdZxWe5m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG3q5hjapCi8yzJ4RX+LMaIdZZGWIPXsgaUBdRLRf0E=;
 b=W2UwBoFuF2xi6L6IGFBeROrtNi5jouYGJbBbEQJiMgG1TzhcpCQZuUAu4Ub6UNVqhrWNMK925FYkNEJZ8sRd41EkbpGPMfnt2EGi7582aQ10WOfWsUrArZeCcqpoFK1sFe8fP/ax88EVwR77Fp3MewimOOH38K8l/xLIGk1xTbYurXBA/ZVItXhlr3TJNmov3g6vHdXZBoSTdAFybJLvVMt4a42BnmwNwFjsKqygunmSSfI2uG2pNafotBPSxRXBnajknnoO125KawYiLePt5QK3b29RostSdVcVCTAE9tinyontRR3DeUO5X+LiiBR55amih6UYC8g84OHIAC3Bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 19:53:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6609.024; Thu, 27 Jul 2023
 19:53:31 +0000
Date:   Thu, 27 Jul 2023 12:53:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Fix destroy_work_on_stack() race
Message-ID: <64c2cb38e1769_a88b294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
 <20230727165910.GA786573@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727165910.GA786573@bhelgaas>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8518fdd1-673a-4e11-f9e5-08db8edb27a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Hk0xKiNCcci8yUmBo7uAvKwMunLZ72saS54Rpf6bKhB7vMmGCko0yyiFOKyo0/sKAQ3NDw+h9FaTdEeaa+kLbvLAR5xZ38kko9z3nBjKO7YTD+6hAGF9jNY5yFgpephBAudiKp3LsrX8UOIdKehA+0FEStD4DVNnCtmI5yFv7uMZEdbYmr97AC8JTe6RCHG+abPoqojGoZnM9InigmDasi6n5lQ4UMznMYrA/frDeRTqk+umbHkJRKZgaO5CsRIjtxnDgk5G7yoxojacyuJHSgTdRjg8dyzn9Y8S/1WkJ9kT6XXMwZCWhSJiBiHX69LWkSqvElQi4b7HkWFvhdWr5jKLxjEcBBtexnMzrMmf8OnH2KbUraS2vX6L3oisNUmJ4JB1VGLkoK2k6WQmazH04JwJMBvzFFp2Wt65yeqbk96lZdfXWSG+S1/kceu9/UHEARMlhPo34F3BmkbGEjAW94B156XyffQMhI2WFo2oVSayC8fK/EgDaJjhzLKU4JEbGzB5uaOIr8kYbc3rNl91k6c0EHQ/50zH0jtunw+sY7MkfjCo3hWWgU/K8z61QGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(6512007)(9686003)(6506007)(26005)(186003)(41300700001)(6486002)(4326008)(6636002)(316002)(5660300002)(66556008)(38100700002)(8676002)(8936002)(2906002)(66946007)(66476007)(83380400001)(54906003)(6666004)(110136005)(82960400001)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzP44kQgjtuewd6GWvWnFdqm+SKEwW2p3nMAOEYLuODZedPwS9K8NfBz7O+y?=
 =?us-ascii?Q?sa9ZjA4sgA1G6yBNJSUUbXcQjxiwwo5YYU/SgO03tVj14gWH9ChwrhtdL9u9?=
 =?us-ascii?Q?AGlQvp7Yr88T3zm2w9pZdCbErq43cxO6mOpmL7Vm9R69MHxpZdbidcT5OIH8?=
 =?us-ascii?Q?mj2dOZWIYq5FXXZE7qyEGEuEQrAUziGlKDygjYNHEA197kOEp6lBszwk2u8y?=
 =?us-ascii?Q?71n0w9eQhfdUXgkxQZq2StEM9svZ/phfPyKFr3dwRD78lXkfMfpNX2Rdysl3?=
 =?us-ascii?Q?Xs0yh3lixug0Ep8cFa8MWKfKY8ZMftwGaFgRpTiNfgqKWwzPt0MH1NEfZ/LF?=
 =?us-ascii?Q?Dss1vFmLTvik6qm+VoPU1XdfG6S0wz/vdbbiu71ARPOxENWDvsho+Oy50+2d?=
 =?us-ascii?Q?0fi00EfSoT5WCsQCMS6GY5KBU/iDsp1driUgESVW51Ajk/7Zm5V0V+A6Ob2t?=
 =?us-ascii?Q?8zZeowk3paFkRDypm9qQDgDH2VN2hMycnB133h9twC9/P5h+1I3zQ1PlocAB?=
 =?us-ascii?Q?mFKG3MPIAhrPhsmSS78YktZCRHS9aMtmckTuRphDNlpg0N/DqIYqYO2o3bWm?=
 =?us-ascii?Q?lpkJdDEXBFh1DZZrDj64H4IoknwCdeaF0Efck3Ck5EAUDX1tnaO+inOafra4?=
 =?us-ascii?Q?4C7uih+aPv5m5F9oV8pL6nBHoK3M/uxOg2pCdDMiCOtKWBIqo1UgQWqNBei9?=
 =?us-ascii?Q?G+DM/w20edK8eXSsIjKRD10tu5pFhp2LWeBXt6ZVLWqvvmSAq5LQxK3AbwWM?=
 =?us-ascii?Q?PwmqQcBhTtlRioMDw4bqMncG6S6nYN5EOrsJkTxyoibqGveVBw3In2YxIDWr?=
 =?us-ascii?Q?kdQcayVR0OWi2MqHswBOwj8t47+dwHP9NolfopFFR5wrWA9N3xKkG60AV2PN?=
 =?us-ascii?Q?cp+MwvRDRUtXGNMBYaF8kka+FclpzYsRXqOeEyIqpohGNR6TSadpqghQr+7r?=
 =?us-ascii?Q?yoE9fy4+NZHVNLeVeCfy8ba+aMIDx0XhB3yOkfhp6riLWnUBodtbJEc6Hppj?=
 =?us-ascii?Q?I+kBvN5LwC3wgTZyqi4NXkg6elQa95qYlcxZaHxuWq+PAQ+GnptN0yXDPNIZ?=
 =?us-ascii?Q?id/3SYiGZPVRoRGiCrKSiIfTr7+GCpGCQBFWG9emYFPVEGFssNTTzNS4r/6S?=
 =?us-ascii?Q?Od65R+GltH5Qxl3NEyxgfkRIKyP2og78B+4ZgFSQHvMFHbwjFmxduh/idKde?=
 =?us-ascii?Q?7xYXdmE+IkgFJjgrj/b4YVbeACqUDET8QKb+rxRlTiz57g+9PdQwGhrlQ18X?=
 =?us-ascii?Q?Wyxp86yflMkn8mLMZN/TeGGidpBrDKucRSfxPdPq92jvDphAURhbWhoVF/6K?=
 =?us-ascii?Q?NW/ApUdIqtvSgnGRHLCRADaQO9fLiHVnByUyR6d/ruvGQtW/zxIV1O+lmayj?=
 =?us-ascii?Q?HCTKY+cnoxSTQMRFckEunZ+4I17p6es+VQrgdyZ/pRGxMhQTvJXIwWtKYY4I?=
 =?us-ascii?Q?CjhXy2NeSpE7kUDbW47BQKZD8c8/uR6vuYJclP89IdyaZRu6dYoEuHtxp7bJ?=
 =?us-ascii?Q?K47nldL2Bm+q1+MzX2BemveRoaSx67ccw/xzGfwP4W8heJWMydvBhh0VTc/D?=
 =?us-ascii?Q?NwGMpsRNec/+585dTzvNRwbkwierxmVb5Y1h+y6TBerfEBnYRy0u9gaL9MXA?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8518fdd1-673a-4e11-f9e5-08db8edb27a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 19:53:31.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA8xaSocJVxuS4LmKLoGMHqjuVjdw3nO9Q1cA2Uoof3MrHMcRVwl8AS9zydDRb3Y4MgRwpKgGQLbWVFkTn1EBJq7W2GcYrRTMJrvWzaIxQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
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
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Dan, let me know if you'd rather have me take this.

I have nothing else in the DOE area at this time, so I would be happy if
you took it. It is self contained to drivers/pci/.

Much appreciated.

Acked-by: Dan Williams <dan.j.williams@intel.com>
