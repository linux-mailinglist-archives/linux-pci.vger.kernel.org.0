Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396F55003F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiFQW6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiFQW6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 18:58:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99B59964;
        Fri, 17 Jun 2022 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655506696; x=1687042696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A+y5LkqSH5hAxL6C43O2R/KU8iBbz+hcSgUesxpNOnQ=;
  b=c0YsWzd2I4G10GsY/SanGsl/a4eUISG56c7FxID1oLmMpkgBnO7Vy7vg
   LmG8deGyJl72YIAfr1TpiwzWJBPW+eI/Z+MASL6VZO255BfFwbPvbMh8f
   g24hxuGsOeAilEVJikyqkh8xFf+jcUkvjE/qE8FcobxnLuX53f4GBCH8t
   NmFV4EEXCa6FWhSD70xeTqbRxGC1i0fsr1CC/WyPRSKaidqJWBxtpoOZg
   sDT1993OKf286hgKYjJt36ybzWgC1c60eIwFYK6Jv2vD1HVEP807rmquG
   FTmvXh5PyMzNwe0uEsg9BfTWFm7witgydimJHyXiA4dzGjKhUjvMHHkuF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305032701"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305032701"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832223261"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 15:57:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 15:56:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 15:56:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 15:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/yUt2kQG4uhl4pdcbIIK+RWl5QO1XP+lCZvinsxC61UJImuyxcWjQkmBJD75WS1xsV0j8+N6krganiUvtABRCfVFR0ZgVlvojRj/utikVNDSrqWd8r5ofcrYyPdY+lZq8fuyT0WMkt9mUIw12gWgfMyODBi+wY+BM/c2Q06jmBIYHLQRM13xwmteffYw087OXS9pvSeO8dfdQ/yVWteEFyHJpekGH1o8GE4WbUqD8+E2fqy7eGfLsbbj0+O1Nc5easIfWiYMSQ+Ikdo4oigBKnDAM9pjGEK2I51A4UpQcQx7mU+SPOSE7gvhI+T7gDWdEGqApDct/gyI38C6qkwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehUktslwa1d8GExB4wIs/6ywdOYcDtTzPWqaY1OJ/W4=;
 b=ZftRCTbnhlvl5Tqa4kr17S/CXGFpYPZ08WgHjT5+e7pKcYgmFlOLdDqKePRpwsgRjBW6I5Sg+05fuh3LY6eWsvC1eqUS49E4BPcaeSGXWVQFleOmQ2yeodlzXCvthu3MD8zAINido4MBzN1H7dyzyON0EhLNZoopxpqVgka7S77jad4EqR+G4rPjKOdwDK66XO8KmnPrDtAaG0ZhgGN6+DjpobzP5V0LlwRsADlyNynBm7JOkBh7Z2NWq0nevCLl25eqanKMd9bVR/FGcUNKjPXDZ/RqvJsvqkG7VDSLuDff8GWRshDzx6Wi9JIov6pNxn1zLLe3BPh7qryYZW1ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1795.namprd11.prod.outlook.com
 (2603:10b6:404:101::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 22:56:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 22:56:41 +0000
Date:   Fri, 17 Jun 2022 15:56:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-4-ira.weiny@intel.com>
X-ClientProxiedBy: MWHPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:300:4b::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 519289d3-005c-4d99-ccdf-08da50b4a42e
X-MS-TrafficTypeDiagnostic: BN6PR11MB1795:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB17953FFC28362E4498BCBFDBC6AF9@BN6PR11MB1795.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvRBiIZQzT/ygRwwjbmQp9IwUvqdJQemYF1iCY+fwcwBEFecPM716sY49CCluwUNjtoJFsHCCfhDI4f3Xk3fov98dAx0pu29dmp+lbYdj39Nbkb79FqSQpDS8h0Pd5BsmQZsTZo1ux7kAQIHMaqInz/oE70Kl2yQ7vchJ2HH5VPeeYdAxFR+PAANm631SFKBuTKOuAUMf2NF8uPhmjHCvwlUzAoVOn19SpUGO6A9ZV/Rn2a3D7Y1OyIWT5y/fnKm2GWDbjb+ZJEFeyCt2TrcVUCg2fDktxfUwJ2G9MsulBfRfjszqgTbvnmHNNxgLL8fAilA9VC2q4JyrXfZI2d2ALGvQ7y/AGjakxHDDIZ+z6h6cy6zNh35R/SAC0p7KYlzljAHCh+8eR/WjjVEUFo5EBj+4xeODkqrUd1k/JzWA2HGEv8Pl6mJy9lWec/rbDKjeXD76g/X2dsLxpXkUN87uIdUbnB1C3EEesfzsLB/b57q6eTLX5oFLKsuMkZ7HAq2OjHNlCW1nvDE8lEHc6wrVs/k+z0FAqjysncsR+3lSs5TO5m5Bjecea+m9Cykvg/i04mCXhn+oEsOPNuMTuVFGnj/fUkhuLhYRYVg+2npp3LL4PXLz/HKboTDBZ0zKbIiHjkrcc0vRZDM8WRhIfe6U8i7Ox2BhI85bOVHGwT+tHIeeFGCXfVXbQ5iZ30CK0D6bmiRrddZ3BAN1pUp6sUa0B88xm5Xj0EwdlyijKpP8YVXPdHWRMOljX3Cjn0B3eWtRdQZqtXRxB0S2QSHDJU4cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(38100700002)(8676002)(66556008)(6506007)(4326008)(66946007)(6512007)(6486002)(15650500001)(6666004)(316002)(2906002)(66476007)(110136005)(54906003)(9686003)(8936002)(26005)(30864003)(498600001)(5660300002)(83380400001)(186003)(82960400001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3lbF8Fiv90145ihVRExLZiuqGnPvIwYqtY09wdXsWWJyIXG3kRX67vdc2uFX?=
 =?us-ascii?Q?H7T9cLVeX3nCuo3TS1Oib7eq+EZOxuCqI8/32AkRTogQy/f2pKW4D/4llh19?=
 =?us-ascii?Q?0Is+vuA+Vr97HAPKIAj7j40/igshytnzeaXgjcKb9pm8lnChUwJwwTGFowPB?=
 =?us-ascii?Q?g3e2+a1L3uoOOOpj6xTKCCqjVZnYheuG+GC15VGgzkuhljbDOtw3/UykCH8l?=
 =?us-ascii?Q?R8wwHGjOp4a/r1hkcqeAMGAC2KWtCiI/vKu3KhjlNSmTRSMObV67IWE1zLFY?=
 =?us-ascii?Q?lDllmiEapXjV0qSG3mENhlaZQ4pXAo+ChbXLNJTw83R5JZaMg0y+8Kux+JLr?=
 =?us-ascii?Q?BGiJtvwFTniYgEao5e3mFh1UCgbyL/xh0E5RlIkRLyufJ7W0H8XJSPwDeU14?=
 =?us-ascii?Q?LAnDY2o5FsNhbGF17krWlGsWsm/C3vXLLLFHFAEb42/xmJOBsR/kyPLGQXZg?=
 =?us-ascii?Q?ENvaEEV3qm867Zc0Wb4C4k6gdWW51nGHM6j24MITde4qv/n8KFHcuD6M5C7Z?=
 =?us-ascii?Q?SyzXaYFQA+ntUDa8ugACkpHNj8+tnSIMNKeB93simuZ2+MQw906deogHirWH?=
 =?us-ascii?Q?iR/hAHgElBOYs8WrXLAzAKncZ9zydPSeHUBX++6ZKENT33AkzYK0qwAZoQ5q?=
 =?us-ascii?Q?Wn7YonNYuy2ieuxUgUEDNBiVe1icoLuUN/9BIE9q+N88QihPJ6yiaXCeqkI3?=
 =?us-ascii?Q?zx4NBYZHEufu9S3sOCCKEw3N8EGZ8oU0c9FjRs4aJDL1N7XboG/PgUSeAeYT?=
 =?us-ascii?Q?rsJxeaybhuM+XQNjbhm4D8d/Gc6b2GFalww7hct14Kj3qQdlWWzU2dCj3jBT?=
 =?us-ascii?Q?IhJdHLLnMS6PCgX3w8WfsluXTx7D19QKhJgnmPWNYNTvBjnU6nWJhFP/zpCX?=
 =?us-ascii?Q?eM7Mmp1KN1raAW4//udwwnq8EDLNXka10jnK7QYarm4mgxcRMb6LX02o9CFT?=
 =?us-ascii?Q?hl8OzHBQIbxJel059SoJF+WrMPckO3dg80HD3CGa79TMAcBc52FbSW0TkjJv?=
 =?us-ascii?Q?ECiGxNkOAEiNLGczODYeKaJ6oGTSHoZ8vI5GOjj4YgimlaYZkLcYWZCr7OMr?=
 =?us-ascii?Q?6qZgiSuvGIym2CS4b825N1r7D91GIbiB3opeeimN3zVOkFyi48vEaVRgERbr?=
 =?us-ascii?Q?rNvp/q1K2fA/FLUs+L3kBxGyThP8Kz/C7wc6tJo7YXPk+RZRUkkAc8gCVjUk?=
 =?us-ascii?Q?qMBPyFAcRENr/RC955mTdoTT1vZF6XsMfnrx6xyV/iGatkHwNoYSykxIxChH?=
 =?us-ascii?Q?ENXiqmduSnBnFtQvONJB/7Lm4rwUuo8Y2K2zpd8S2lvvJFuci+0IlIg/u47/?=
 =?us-ascii?Q?9yu2CB6gn2ZBpQ9h+JsIAART1FD9tUZ+YEAwgpOvBZu1xfmPYoOoIP0jGNHu?=
 =?us-ascii?Q?4VGFOQ91K5wCrsd+KpMWAWp9S21FJ4SIb5AXMC2cSz341Ijo2bELuQPE6pY4?=
 =?us-ascii?Q?Sx5g/JT/78br3De6n6HqMY/NYq1YaLoXLEfsKjjves31jzNF0e5gMpZZ7ZWN?=
 =?us-ascii?Q?s/nzvUMZen0Oy4d4zPpPwVtLKgcQXex51dQfUs3IdkRvm2aRjikka3Hj2GYS?=
 =?us-ascii?Q?MXEpOUTPXrRzzXu8PuTtksG226Ch8sPOAb12n6patM6gz7Fy9gG0edl07Vk8?=
 =?us-ascii?Q?6p1JABir9IXlpik5iNUaSu4jZ9pznAw5qjuJHfwSXLsrPMIKr2iT9wvNtmQN?=
 =?us-ascii?Q?WGEF4gZQvEE+wJGY6K+LGaI3SHPzYw3Q9/qpimQzFsJBsGZb3MAtZ8O/JfUE?=
 =?us-ascii?Q?m4cyqHKNAjOTx7c8cxfd5ukQXW0YgZE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 519289d3-005c-4d99-ccdf-08da50b4a42e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 22:56:40.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMjkx5i7M5mfKWe3UGa1H6YX6vii3xtbjL9rCO468aD1zC6PcvkxHdxlC6qmK9g9N6PaoC+0592i91D8NNOhKGTEPSTE49spncEXzcrRtug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCI functionality to manage a single PCI DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, task submission, and destruction
> of the mailboxes.
> 
> If interrupts are desired, the interrupt number can be queried and
> passed to the create function.  Passing a negative value disables
> interrupts for that mailbox.  It is the callers responsibility to ensure

s/callers/caller's/

> enough interrupt vectors are allocated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V9
> 	Lukas Wunner
> 		Update comments
> 		Move private doe structures and defines from pci-doe.h to doe.c
> 		check Data Obj Ready prior to last ack
> 	Davidlohr
> 		make task_lock a spinlock
> 	Lukas/Jonathan
> 		Remove special case of error in irq handler
> 	Fix potential race with the scheduling of a task when one is ending.
> 		The current task can't be retired until the state
> 		machine is idle.  Otherwise a new task work item may run
> 		and the state machine would be out of sync.
> 
> Changes from V8
> 	Remove Bjorn's ack
> 	Expose a function to find the irq number for a mailbox based on
> 	offset.  This is the code Jonathan proposed for finding the irq
> 	number here:
> 	https://lore.kernel.org/linux-cxl/20220503153449.4088-2-Jonathan.Cameron@huawei.com/
> 		This removes funky bool parameter to create.
> 	Move pci_set_master() within the pci_doe_enable_irq()
> 	Per Bjorn
> 		Clean up commit messages
> 		move pci-doe.c to doe.c
> 		Clean up PCI spec references
> 		Ensure all messages use pci_*()
> 		Add offset to error messages to distinguish mailboxes
> 			use hex for DOE offsets
> 		Print 4 nibbles for Vendor ID and 2 for type.
> 		s/irq/IRQ in comments
> 		Fix long lines
> 		Fix typos
> 
> Changes from V7
> 	Add a Kconfig for this functionality
> 	Fix bug in pci_doe_supports_prot()
> 	Rebased on cxl-pending
> 
> Changes from V6
> 	Clean up signed off by lines
> 	Make this functionality all PCI library functions
> 	Clean up header files
> 	s/pci_doe_irq/pci_doe_irq_handler
> 	Use pci_{request,free}_irq
> 		Remove irq_name (maintained by pci_request_irq)
> 	Fix checks to use an irq
> 	Consistently use u16 for cap_offset
> 	Cleanup kdocs and comments
> 	Create a helper retire_cur_task() to handle locking of the
> 		current task pointer.
> 	Remove devm_ calls from PCI layer.
> 		The devm_ calls do not allow for the pci_doe_mb objects
> 		to be tied to an auxiliary device.  Leave it to the
> 		caller to use devm_ if desired.
> 	From Dan Williams
> 		s/cb/end_task/; Pass pci_doe_task to end_task
> 		Clarify exchange/task/request/response.
> 			Merge pci_doe_task and pci_doe_exchange into
> 			pci_doe_task which represents a single
> 			request/response task for the state machine to
> 			process.
> 		Simplify submitting work to the mailbox
> 			Replace pci_doe_exchange_sync() with
> 			pci_doe_submit_task() Consumers of the mailbox
> 			are now responsible for setting up callbacks
> 			within a task object and submitting them to the
> 			mailbox to be processed.
> 		Remove WARN_ON when task != NULL and be sure to abort that task.
> 		Convert abort/dead to atomic flags
> 		s/state_lock/task_lock to better define what the lock is
> 			protecting
> 		Remove all the auxiliary bus code from the PCI layer
> 			The PCI layer provides helpers to use the DOE
> 			Mailboxes.  Each subsystem can then use the
> 			helpers as they see fit.  The CXL layer in this
> 			series uses aux devices to manage the new
> 			pci_doe_mb objects.
> 
> 	From Bjorn
> 		Clarify the fact that DOE mailboxes are capabilities of
> 			the device.
> 		Code clean ups
> 		Cleanup Makefile
> 		Update references to PCI SIG spec v6.0
> 		Move this attribution here:
> 		This code is based on Jonathan's V4 series here:
> 		https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/
> 
> Changes from V5
> 	From Bjorn
> 		s/pci_WARN/pci_warn
> 			Add timeout period to print
> 		Trim to 80 chars
> 		Use Tabs for DOE define spacing
> 		Use %#x for clarity
> 	From Jonathan
> 		Addresses concerns about the order of unwinding stuff
> 		s/doe/doe_dev in pci_doe_exhcnage_sync
> 		Correct kernel Doc comment
> 		Move pci_doe_task_complete() down in the file.
> 		Rework pci_doe_irq()
> 			process STATUS_ERROR first
> 			Return IRQ_NONE if the irq is not processed
> 			Use PCI_DOE_STATUS_INT_STATUS explicitly to
> 				clear the irq
> 	Clean up goto label s/err_free_irqs/err_free_irq
> 	use devm_kzalloc for doe struct
> 	clean up error paths in pci_doe_probe
> 	s/pci_doe_drv/pci_doe
> 	remove include mutex.h
> 	remove device name and define, move it in the next patch which uses it
> 	use devm_kasprintf() for irq_name
> 	use devm_request_irq()
> 	remove pci_doe_unregister()
> 		[get/put]_device() were unneeded and with the use of
> 		devm_* this function can be removed completely.
> 	refactor pci_doe_register and s/pci_doe_register/pci_doe_reg_irq
> 		make this function just a registration of the irq and
> 		move pci_doe_abort() into pci_doe_probe()
> 	use devm_* to allocate the protocol array
> 
> Changes from Jonathan's V4
> 	Move the DOE MB code into the DOE auxiliary driver
> 	Remove Task List in favor of a wait queue
> 
> Changes from Ben
> 	remove CXL references
> 	propagate rc from pci functions on error
> ---
>  drivers/pci/Kconfig           |   3 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/doe.c             | 693 ++++++++++++++++++++++++++++++++++
>  include/linux/pci-doe.h       |  65 ++++
>  include/uapi/linux/pci_regs.h |  29 +-
>  5 files changed, 790 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/doe.c
>  create mode 100644 include/linux/pci-doe.h
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c73207782..b2f2e588a817 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_DOE
> +	bool
> +
>  config PCI_ECAM
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 0da6b1ebc694..2680e4c92f0a 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_ECAM)		+= ecam.o
>  obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> +obj-$(CONFIG_PCI_DOE)		+= doe.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> new file mode 100644
> index 000000000000..4619c3e547f2
> --- /dev/null
> +++ b/drivers/pci/doe.c
> @@ -0,0 +1,693 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/workqueue.h>
> +
> +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> +
> +#define PCI_DOE_BUSY_MAX_RETRIES 16
> +#define PCI_DOE_POLL_INTERVAL (HZ / 128)
> +
> +/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> +#define PCI_DOE_TIMEOUT HZ
> +
> +enum pci_doe_state {
> +	DOE_IDLE,
> +	DOE_WAIT_RESP,
> +	DOE_WAIT_ABORT,
> +	DOE_WAIT_ABORT_ON_ERR,
> +};
> +
> +#define PCI_DOE_FLAG_ABORT	0
> +#define PCI_DOE_FLAG_DEAD	1

Warning, I tend to review data structures first, so some of the
questions below might have answers in the code, but I have hard time
jumping to the implementation if the data structure is not clear.

> +
> +/**
> + * struct pci_doe_mb - State for a single DOE mailbox
> + *
> + * This state is used to manage a single DOE mailbox capability.  All fields
> + * should be considered opaque to the consumers and the structure passed into
> + * the helpers below after being created by devm_pci_doe_create()

Hmm, why devm_ and not pcim_ like pcim_enable_device()?

> + *
> + * @pdev: PCI device this mailbox belongs to
> + * @abort_c: Completion used for initial abort handling

What does initial abort handling mean? If it's just a single point in
time use couldn't that be handled with an on-stack completion?

> + * @irq: Interrupt used for signaling DOE ready or abort
> + * @prots: Array of protocols supported on this DOE
> + * @num_prots: Size of @prots array
> + * @cap_offset: Capability offset
> + * @wq: Wait queue to wait on if a query is in progress
> + * @cur_task: Current task the state machine is working on
> + * @task_lock: Protect cur_task

Protect what about cur_task? Assigning and clearing a pointer is atomic.

> + * @statemachine: Work item for the DOE state machine

Why does the pci_doe_mb have a work item? I would expect a work item per
task. Then this gets a waitqueue for free to wait for task completion.
Otherwise I suspect this introduces complexity in the DOE implementation
to simulate per-task-work that a workqueue per DOE and a work item per
task gets you for free, and for recalling hardware context from one
firing of the state machine to the next. Just run the task work all
in-line in one context.

> + * @state: Current state of this DOE
> + * @timeout_jiffies: 1 second after GO set
> + * @busy_retries: Count of retry attempts

Why is this tracked in the mailbox object itself?

> + * @flags: Bit array of PCI_DOE_FLAG_* flags
> + *
> + * Note: @prots can't be allocated with struct size because the number of
> + * protocols is not known until after this structure is in use.  However, the
> + * single discovery protocol is always required to query for the number of
> + * protocols.

Sounds like maybe this wants to be an xarray indexed by the device's
reported index.

> + */
> +struct pci_doe_mb {
> +	struct pci_dev *pdev;
> +	struct completion abort_c;
> +	int irq;
> +	struct pci_doe_protocol *prots;
> +	int num_prots;
> +	u16 cap_offset;
> +
> +	wait_queue_head_t wq;
> +	struct pci_doe_task *cur_task;
> +	spinlock_t task_lock;
> +	struct delayed_work statemachine;
> +	enum pci_doe_state state;
> +	unsigned long timeout_jiffies;
> +	unsigned int busy_retries;
> +	unsigned long flags;
> +};
> +
> +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> +{
> +	struct pci_doe_mb *doe_mb = data;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> +					PCI_DOE_STATUS_INT_STATUS);
> +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);

Wait, no, not system_wq. I expected this wants a dedicated / ordered queue
per doe and this likely wants a queue that can sleep while processing a
task and just not support overlapping tasks.

In that model the irq is just waking up any tasks in execution that are
awaiting a polling timeout. The irq handler does:

wake_up(&doe_mb->wait);

...and then task that is executing in the queue continues what it was
doing.

> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +/*
> + * Only called when safe to directly access the DOE from
> + * doe_statemachine_work().  Outside access is not protected.  Users who
> + * perform such access are left with the pieces.

What pieces, where? I expect the abort implementation would be something
like:

set_bit(ABORT_PENDING) <== blocks new task submissions until clear
flush_workqueue() <== make sure all in-flight tasks see the abort
do_doe_abort(...) <== do the abort
clear_bit(ABORT_PENDING) <== optionally restart the tasks that were
cancelled, or just expect them to be resubmitted.


> + */
> +static void pci_doe_abort_start(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	val = PCI_DOE_CTRL_ABORT;
> +	if (doe_mb->irq >= 0)
> +		val |= PCI_DOE_CTRL_INT_EN;
> +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> +
> +	doe_mb->timeout_jiffies = jiffies + HZ;
> +	schedule_delayed_work(&doe_mb->statemachine, HZ);
> +}
> +
> +static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> +			    struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +	int i;
> +
> +	/*
> +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> +	 * it is expected that firmware and OS will negotiate access rights via
> +	 * an, as yet to be defined method.
> +	 */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +		return -EBUSY;
> +
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	/* Write DOE Header */
> +	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
> +		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> +	/* Length is 2 DW of header + length of payload in DW */
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> +					  2 + task->request_pl_sz /
> +						sizeof(u32)));
> +	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +				       task->request_pl[i]);
> +
> +	val = PCI_DOE_CTRL_GO;
> +	if (doe_mb->irq >= 0)
> +		val |= PCI_DOE_CTRL_INT_EN;
> +
> +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> +	/* Request is sent - now wait for poll or IRQ */
> +	return 0;
> +}
> +
> +static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
> +		return true;
> +	return false;
> +}
> +
> +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	size_t length, payload_length;
> +	u32 val;
> +	int i;
> +
> +	/* Read the first dword to get the protocol */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
> +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
> +		pci_err(pdev,
> +			"DOE [%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> +			doe_mb->cap_offset,
> +			task->prot.vid, task->prot.type,
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> +		return -EIO;
> +	}
> +
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	/* Read the second dword to get the length */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +
> +	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> +	if (length > SZ_1M || length < 2)
> +		return -EIO;
> +
> +	/* First 2 dwords have already been read */
> +	length -= 2;
> +	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> +	/* Read the rest of the response payload */
> +	for (i = 0; i < payload_length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +				      &task->response_pl[i]);
> +		/* Prior to the last ack, ensure Data Object Ready */
> +		if (i == (payload_length-1) && !pci_doe_data_obj_ready(doe_mb))
> +			return -EIO;
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Flush excess length */
> +	for (; i < length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Final error check to pick up on any since Data Object Ready */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +}
> +
> +static void signal_task_complete(struct pci_doe_task *task, int rv)
> +{
> +	task->rv = rv;
> +	task->complete(task);
> +}
> +
> +static void retire_cur_task(struct pci_doe_mb *doe_mb)
> +{
> +	spin_lock(&doe_mb->task_lock);
> +	doe_mb->cur_task = NULL;
> +	spin_unlock(&doe_mb->task_lock);

What is the lock protecting here? Assigning a pointer is atomic, I think
this question is moot with a work-item per-task model as retiring the
task is just a typical work completion.

> +	wake_up_interruptible(&doe_mb->wq);
> +}
> +
> +static void doe_statemachine_work(struct work_struct *work)
> +{
> +	struct delayed_work *w = to_delayed_work(work);
> +	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
> +						 statemachine);
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	enum pci_doe_state prev_state;
> +	struct pci_doe_task *task;
> +	u32 val;
> +	int rc;
> +
> +	spin_lock(&doe_mb->task_lock);
> +	task = doe_mb->cur_task;
> +	spin_unlock(&doe_mb->task_lock);
> +
> +	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags)) {
> +		/*
> +		 * Currently only used during init - care needed if
> +		 * pci_doe_abort() is generally exposed as it would impact
> +		 * queries in flight.
> +		 */
> +		if (task)
> +			pci_err(pdev, "DOE [%x] Aborting with active task!\n",
> +				doe_mb->cap_offset);
> +		doe_mb->state = DOE_WAIT_ABORT;
> +		pci_doe_abort_start(doe_mb);
> +		return;
> +	}
> +
> +	switch (doe_mb->state) {
> +	case DOE_IDLE:
> +		if (task == NULL)
> +			return;
> +
> +		rc = pci_doe_send_req(doe_mb, task);
> +
> +		/*
> +		 * The specification does not provide any guidance on how long
> +		 * some other entity could keep the DOE busy, so try for 1
> +		 * second then fail. Busy handling is best effort only, because
> +		 * there is no way of avoiding racing against another user of
> +		 * the DOE.
> +		 */
> +		if (rc == -EBUSY) {
> +			doe_mb->busy_retries++;
> +			if (doe_mb->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> +				/* Long enough, fail this request */
> +				pci_warn(pdev,
> +					"DOE [%x] busy for too long (> 1 sec)\n",
> +					doe_mb->cap_offset);
> +				doe_mb->busy_retries = 0;
> +				goto err_busy;
> +			}
> +			schedule_delayed_work(w, HZ / PCI_DOE_BUSY_MAX_RETRIES);
> +			return;
> +		}
> +		if (rc)
> +			goto err_abort;
> +		doe_mb->busy_retries = 0;
> +
> +		doe_mb->state = DOE_WAIT_RESP;
> +		doe_mb->timeout_jiffies = jiffies + HZ;
> +		/* Now poll or wait for IRQ with timeout */
> +		if (doe_mb->irq >= 0)
> +			schedule_delayed_work(w, PCI_DOE_TIMEOUT);
> +		else
> +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> +		return;
> +
> +	case DOE_WAIT_RESP:
> +		/* Not possible to get here with NULL task */
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +			rc = -EIO;
> +			goto err_abort;
> +		}
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> +			/* If not yet at timeout reschedule otherwise abort */
> +			if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> +				rc = -ETIMEDOUT;
> +				goto err_abort;
> +			}
> +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> +			return;
> +		}
> +
> +		rc  = pci_doe_recv_resp(doe_mb, task);
> +		if (rc < 0)
> +			goto err_abort;
> +
> +		doe_mb->state = DOE_IDLE;
> +
> +		retire_cur_task(doe_mb);
> +		/* Set the return value to the length of received payload */
> +		signal_task_complete(task, rc);
> +
> +		return;
> +
> +	case DOE_WAIT_ABORT:
> +	case DOE_WAIT_ABORT_ON_ERR:
> +		prev_state = doe_mb->state;
> +
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> +			doe_mb->state = DOE_IDLE;
> +			/* Back to normal state - carry on */
> +			retire_cur_task(doe_mb);
> +		} else if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> +			/* Task has timed out and is dead - abort */
> +			pci_err(pdev, "DOE [%x] ABORT timed out\n",
> +				doe_mb->cap_offset);
> +			set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +			retire_cur_task(doe_mb);
> +		}
> +
> +		/*
> +		 * For deliberately triggered abort, someone is
> +		 * waiting.
> +		 */
> +		if (prev_state == DOE_WAIT_ABORT) {
> +			if (task)
> +				signal_task_complete(task, -EFAULT);
> +			complete(&doe_mb->abort_c);
> +		}
> +
> +		return;
> +	}
> +
> +err_abort:
> +	doe_mb->state = DOE_WAIT_ABORT_ON_ERR;
> +	pci_doe_abort_start(doe_mb);
> +err_busy:
> +	signal_task_complete(task, rc);
> +	if (doe_mb->state == DOE_IDLE)
> +		retire_cur_task(doe_mb);
> +}
> +
> +static void pci_doe_task_complete(struct pci_doe_task *task)
> +{
> +	complete(task->private);
> +}
> +
> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +			     u8 *protocol)
> +{
> +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> +				    *index);
> +	u32 response_pl;
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> +		.request_pl = &request_pl,
> +		.request_pl_sz = sizeof(request_pl),
> +		.response_pl = &response_pl,
> +		.response_pl_sz = sizeof(response_pl),
> +		.complete = pci_doe_task_complete,
> +		.private = &c,
> +	};
> +	int ret;
> +
> +	ret = pci_doe_submit_task(doe_mb, &task);
> +	if (ret < 0)
> +		return ret;
> +
> +	wait_for_completion(&c);

Another place where the need for a completion can be replaced with
flush_work(). The only thing flush_work() does not offer is the option
to have an interruptible wait, but for in-kernel DOE cycles
uninterruptible is ok.

> +
> +	if (task.rv != sizeof(response_pl))
> +		return -EIO;
> +
> +	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> +	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> +			      response_pl);
> +	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> +			   response_pl);
> +
> +	return 0;
> +}
> +
> +static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> +{
> +	u8 index = 0;
> +	int num_prots;
> +	int rc;
> +
> +	/* Discovery protocol must always be supported and must report itself */
> +	num_prots = 1;
> +
> +	doe_mb->prots = kcalloc(num_prots, sizeof(*doe_mb->prots), GFP_KERNEL);
> +	if (!doe_mb->prots)
> +		return -ENOMEM;
> +
> +	/*
> +	 * NOTE: doe_mb_prots is freed by pci_doe_free_mb() automatically on
> +	 * error if pci_doe_cache_protocols() fails past this point.
> +	 */
> +	do {
> +		struct pci_doe_protocol *prot;
> +
> +		prot = &doe_mb->prots[num_prots - 1];
> +		rc = pci_doe_discovery(doe_mb, &index, &prot->vid, &prot->type);
> +		if (rc)
> +			return rc;
> +
> +		if (index) {
> +			struct pci_doe_protocol *prot_new;
> +
> +			num_prots++;
> +			prot_new = krealloc(doe_mb->prots,
> +					    sizeof(*doe_mb->prots) * num_prots,
> +					    GFP_KERNEL);

An xarray saves the need for krealloc(), and probably even the need for
a separate 'struct pci_doe_protocol' allocation since that data fits
into an unsigned long that the xarray is already allocating for you
internally.

So something like:

    struct pci_doe_protocol {
    	union {
    		unsigned long val;
    		struct {
    			u16 vid;
    			u8 type;
    		};
    	};
    } prot;

    pci_doe_discovery(doe_mb, &index, &prot.vid, &prot.type);

    xa_insert(&doe_mb->prots, (unsigned long) index, (void *) prot.val, GFP_KERNEL);

...and then to retrieve:

    void *ent = xa_load(&doe_mb->prots, index);
    struct pci_doe_protocol prot = { .val = (unsigned long) ent };

...wrapped up nicely with helpers to hide all the casting.


> +			if (!prot_new)
> +				return -ENOMEM;
> +
> +			doe_mb->prots = prot_new;
> +		}
> +	} while (index);
> +
> +	doe_mb->num_prots = num_prots;
> +	return 0;
> +}
> +
> +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> +{
> +	reinit_completion(&doe_mb->abort_c);
> +	set_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags);
> +	schedule_delayed_work(&doe_mb->statemachine, 0);
> +	wait_for_completion(&doe_mb->abort_c);
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	int rc;
> +
> +	/*
> +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> +	 * this multiple times and thus is called here to ensure that mastering
> +	 * is enabled even if the driver has done so.
> +	 */

It is required for MSI/MSIx to work, yes, but if the caller that created
the doe object has not set it yet that's its prerogative.

> +	pci_set_master(pdev);
> +	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
> +			     "DOE[%d:%s]", irq, pci_name(pdev));

If the DOE object creation is use devm_ then this wants to be
devm_request_irq(), although I now notice that devm_pci_doe_create()
only existed in the code comments, not the implementation.

Is there any need for the unmanaged version of this API?

> +	if (rc)
> +		return rc;
> +
> +	doe_mb->irq = irq;
> +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> +			       PCI_DOE_CTRL_INT_EN);
> +	return 0;
> +}
> +
> +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> +{
> +	if (doe_mb->irq >= 0)
> +		pci_free_irq(doe_mb->pdev, doe_mb->irq, doe_mb);
> +	kfree(doe_mb->prots);
> +	kfree(doe_mb);
> +}
> +
> +/**
> + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> + *
> + * @pdev: The PCI device
> + * @offset: Offset of the DOE mailbox
> + *
> + * Returns: irq number on success
> + *	    -errno if irqs are not supported on this mailbox
> + */
> +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> +		return -EOPNOTSUPP;

I think ENXIO would be more appropriate than this networking errno.

> +
> +	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);
> +
> +/**
> + * pci_doe_create_mb() - Create a DOE mailbox object
> + *
> + * @pdev: PCI device to create the DOE mailbox for
> + * @cap_offset: Offset of the DOE mailbox
> + * @irq: irq number to use; a negative value means don't use interrupts
> + *
> + * Create a single mailbox object to manage the mailbox protocol at the
> + * cap_offset specified.
> + *
> + * Caller should allocate PCI IRQ vectors before setting use_irq.
> + *
> + * RETURNS: created mailbox object on success
> + *	    ERR_PTR(-errno) on failure
> + */
> +struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> +				     int irq)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	int rc;
> +
> +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
> +	if (!doe_mb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	doe_mb->pdev = pdev;
> +	init_completion(&doe_mb->abort_c);
> +	doe_mb->irq = -1;
> +	doe_mb->cap_offset = cap_offset;
> +
> +	init_waitqueue_head(&doe_mb->wq);
> +	spin_lock_init(&doe_mb->task_lock);
> +	INIT_DELAYED_WORK(&doe_mb->statemachine, doe_statemachine_work);
> +	doe_mb->state = DOE_IDLE;
> +
> +	if (irq >= 0) {
> +		rc = pci_doe_enable_irq(doe_mb, irq);
> +		if (rc)
> +			pci_err(pdev,
> +				"DOE [%x] enable requested IRQ (%d) failed : %d\n",
> +				doe_mb->cap_offset, irq, rc);
> +	}
> +
> +	/* Reset the mailbox by issuing an abort */
> +	rc = pci_doe_abort(doe_mb);
> +	if (rc) {
> +		pci_err(pdev, "DOE [%x] failed to reset : %d\n",
> +			doe_mb->cap_offset, rc);
> +		pci_doe_free_mb(doe_mb);
> +		return ERR_PTR(rc);
> +	}
> +
> +	rc = pci_doe_cache_protocols(doe_mb);
> +	if (rc) {
> +		pci_err(pdev, "DOE [%x] failed to cache protocols : %d\n",
> +			doe_mb->cap_offset, rc);
> +		pci_doe_free_mb(doe_mb);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return doe_mb;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_create_mb);
> +
> +/**
> + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> + *			     protocol
> + * @doe_mb: DOE mailbox capability to query
> + * @vid: Protocol Vendor ID
> + * @type: Protocol type
> + *
> + * RETURNS: True if the DOE mailbox supports the protocol specified
> + */
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> +{
> +	int i;
> +
> +	/* The discovery protocol must always be supported */
> +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> +		return true;
> +
> +	for (i = 0; i < doe_mb->num_prots; i++)
> +		if ((doe_mb->prots[i].vid == vid) &&
> +		    (doe_mb->prots[i].type == type))
> +			return true;

This becomes an xa_for_each() loop and I don't think you even need
->num_prots after this conversion.

> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> +
> +/**
> + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + *
> + * @doe_mb: DOE mailbox capability to submit to
> + * @task: task to be queued
> + *
> + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> + * Returns upon queueing the task object.  If the queue is full this function
> + * will sleep until there is room in the queue.
> + *
> + * task->complete will be called when the state machine is done processing this
> + * task.
> + *
> + * Excess data will be discarded.
> + *
> + * RETURNS: 0 when task has been successful queued, -ERRNO on error
> + */
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> +		return -EINVAL;
> +
> +	/* DOE requests must be a whole number of DW */
> +	if (task->request_pl_sz % sizeof(u32))
> +		return -EINVAL;
> +
> +again:
> +	spin_lock(&doe_mb->task_lock);
> +	if (doe_mb->cur_task) {
> +		spin_unlock(&doe_mb->task_lock);
> +		wait_event_interruptible(doe_mb->wq, doe_mb->cur_task == NULL);
> +		goto again;
> +	}

This looks like it will scramble the order of competing submissions.
With a work-item per task there may be a race to who call queue_work()
first, but there will not follow-on races like the ones here for this
"goto again" case.

> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		spin_unlock(&doe_mb->task_lock);
> +		return -EIO;
> +	}
> +	doe_mb->cur_task = task;
> +	spin_unlock(&doe_mb->task_lock);
> +	schedule_delayed_work(&doe_mb->statemachine, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> +
> +/**
> + * pci_doe_destroy_mb() - Destroy a DOE mailbox object created with
> + * pci_doe_create_mb()
> + *
> + * @doe_mb: DOE mailbox capability structure to destroy
> + *
> + * The mailbox becomes invalid and should not be used after this call.
> + */
> +void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
> +{
> +	/* abort any work in progress */
> +	pci_doe_abort(doe_mb);
> +
> +	/* halt the state machine */
> +	cancel_delayed_work_sync(&doe_mb->statemachine);
> +
> +	pci_doe_free_mb(doe_mb);

Where do racing submitters get told that the DOE is closed for business?

> +}
> +EXPORT_SYMBOL_GPL(pci_doe_destroy_mb);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> new file mode 100644
> index 000000000000..4623881d0e3e
> --- /dev/null
> +++ b/include/linux/pci-doe.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#ifndef LINUX_PCI_DOE_H
> +#define LINUX_PCI_DOE_H
> +
> +#include <linux/completion.h>
> +
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload
> + * @rv: Return value.  Length of received response or error
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +};
> +
> +/**
> + * pci_doe_for_each_off - Iterate each DOE capability
> + * @pdev: struct pci_dev to iterate
> + * @off: u16 of config space offset of each mailbox capability found
> + */
> +#define pci_doe_for_each_off(pdev, off) \
> +	for (off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE); \
> +		off > 0; \
> +		off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE))

New for loop macros should also be added to .clang-format.

> +
> +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset);
> +struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> +				     int irq);
> +void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb);
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> +
> +#endif
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bee1a9ed6e66..4e96b45ee36d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -736,7 +736,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1102,4 +1103,30 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>  
> +/* Data Object Exchange */
> +#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
> +#define  PCI_DOE_CAP_INT			0x00000001  /* Interrupt Support */
> +#define  PCI_DOE_CAP_IRQ			0x00000ffe  /* Interrupt Message Number */
> +#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
> +#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
> +#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
> +#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
> +#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
> +#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
> +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
> +#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
> +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
> +#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
> +#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
> +
> +/* DOE Data Object - note not actually registers */
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> +
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> +
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.35.1
> 


