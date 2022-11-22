Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8321634769
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiKVUMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 15:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiKVUMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 15:12:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D9AEA6B;
        Tue, 22 Nov 2022 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147943; x=1700683943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sgZe/sBTMLYDdOijFtvjOl3+0d9xEGumkjMlUAXgXYo=;
  b=WgWQUj/BL+I6oKFURDggu+i3bocsHCKWSD4minsJw9seewpdtT6Id7tk
   Tebsx68nuATk1Q0Dc39zZfuBy4RPwj7p3qgufvp23llfXi0pEeMW1hNSb
   2ptFC+6EiImqpxNO4Px9xq+w1KxaNZnP/55JCiH+bh9eC05OAYeNeGCLg
   0mZG5e5z5dCOUhCJNvBbbKI0AijZNpCHX23Dl2ysZxrHaLeXmtlBU3aI1
   7KS/6wgmB0rELLmvwDIl1OnPYVdckEYTiWt7u7SAlKKEa5NAM8pPZ1qSf
   k2X5gk4LV97FPEJShX2QyUHVrBhCNI1ApaQ+AlVECn2LvjuQHiHJrl6Bc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="297263231"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="297263231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:12:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="643846004"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="643846004"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2022 12:12:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 12:12:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 12:12:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 12:12:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P881C618xAgO/SFmmUe6dQt8xjZ2lG9OecLUFJWLn2coZF06pZAt+Qijd2K7x0chgrXwDUWice713+RN1YrPKVB+UCOC5kreBVFXMfA9S6X8xxZuluEs4rPQx4l+buNNEf7a+0ikWZKXzI5D5GDE/FIywOX5jm0zO5PC0Ai79ECrjLXi4ld56PZS7Crg7q3fV/ef+pwEatXyZJRrDzKzmkqtU2tR2eG23c69AWZBetAliEEnHl9c0uvkZpwH3tVMiGdBpHaoLFpA0slV/SvVzrt2iNPrCJQZcUibTpFiaSEqojM2XEOTxlmtKAgM3L9S7T2ClaqMeXoyIqKORNrXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uu0RcoSCzw3hkJzuZdcomKdQBIZ2HNJu26Kb61v+Wo=;
 b=WDnA3UQrnGY5Ew2lEVIhMvCiMdrfbmcxni2/p6bQu+p76ZG2CgYsS2z+tgrZT4IiG0cp6Rrzca/pwi1qiE3bKpmKeP79WfRRr1XU13aHm33eo8wjXk2mZ/9OCcfb9W10/9DrHnrdJn9EdmG/ici8n8GsIHeaLROVNUjo8zuONyH2R+m5vSeJQUn9Iy0S1456rsnqRQJzt1MTTciq1EdTBEJ19Q3/7yMNNTKhpohfUXNggcSndUoFzpK+NYLF/9LxMTvTq5xOXTqcxJNvfdUDJPYxEDJ+w6QHmVqJE6oZPOsZLoLUqOiNBY0zdI+dMYOscr+DQ3vV6IS0dUlTMrElpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6163.namprd11.prod.outlook.com
 (2603:10b6:930:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 20:12:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:12:18 +0000
Date:   Tue, 22 Nov 2022 12:12:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <637d2d1f52828_12cdff294c0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <20221121111925.00003eed@Huawei.com>
 <20221122192859.GA20515@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122192859.GA20515@wunner.de>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: ba603353-1852-46b0-c2ef-08daccc5dab4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2t/j8inHmqe9BVgFWT51NWs4cjKRNL2W086wP3YGKE8QXoFWmv0yai5XovLL/HFCrXIW7l/VoIB/F9inC81AOJnVA29XfIyozRGejlFrmH/76e94Uat+Bb8OK6Nqxv07jwEFmluCjIhcWvW0jQv40zQWtZmf6ovGHdtrGDZgOrp0cgufPuckBen6EafxJ40FyOmjM2GHkr6FrcZF0MW/wdMkeYZSS1BTSZKrWQI4+51dd1AJXiLAzW3zOzwFKy1pWc/xLHsi0HiyjhvKxxtfe+T0So0ijV7TzgyjfousOaBrUsGvmyyGRbcSxKhIOnPbOLDSPlwrpQ/JunNTBZrh/bNOEgMJYCBqp2OnjCTsd7O6plvSLbJGgXvR9z6nZ5SQBa+QzNMz5dGFesNHZvuig4O0z9JVjUDzCwdAACaF2jTFi6JPC9gRrqPlfvKM/JJwp5RZfjKQNAsZhAeXfSAlB30JhSRw8Lk6RiOx8GLdkiZfXqNdY0FTspRG79nWkU64NcTnzw5wWG6zxbMbflG1WZ2/1KdBUzVV5JzA5Oq0pD4kXhJ1uADWUMNG6qi0Eu44yivyqPo58pMZuu8iv34WmA0Kvy6uJVwxm2ODgKy2TNuqJcfO4ytPJThJVyk5q5Jyg1v9VsuUp9hHnMI805+kPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(186003)(83380400001)(82960400001)(2906002)(38100700002)(8936002)(5660300002)(6486002)(9686003)(4326008)(478600001)(26005)(41300700001)(6506007)(66556008)(66946007)(6512007)(8676002)(66476007)(6666004)(316002)(54906003)(110136005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrXzntmraIQaKchzSVzXhilVzMiJfx1m4TDYEQSoZx44nvsSaREHDh1TxFNR?=
 =?us-ascii?Q?QUC/zH3VucmP9mnyvPR/CyXseDrk/hH9o8DKleUELon8PYGuTdto6D6y9Qx8?=
 =?us-ascii?Q?7OnFMz+YKlOZ9yInppb8uHrDZ2TaR8rFyN01O2M3veaNOjhBRHykxIYPXWWv?=
 =?us-ascii?Q?ILZ0ZiXmy+LM6QqC//t3dsZK/h7Wh2AyKegB8tm5TlyacwH/5wvchMFZJcCf?=
 =?us-ascii?Q?CNfAlEGGdcpJb7FK6ZvD7BQzqCbZ1l2VjBQWM0CGZbuHzirUd9a5jnifcN4F?=
 =?us-ascii?Q?0Mr6Fwt3ZkbHpTzzKCujZWtQe2v60afq/g1aT3LqL+KUv2OVhFVM4lontgsA?=
 =?us-ascii?Q?A7iuElCVBw5Lbri8owkqzTUOJUxkAQS8JhrcUC6S+vEwrsv3b6CFHY4ktbYK?=
 =?us-ascii?Q?MYET5T8YpEbU7J6lAuKflRhqlLAB6GsQSCYB1NjP5jVwmJxdfA+5yRvCc/M3?=
 =?us-ascii?Q?2I+0klT84bZ7ajKSH+zPs0gEvOYNo19uEj1ko3N9tiXq+dNq9wJbDu7HEtrp?=
 =?us-ascii?Q?7c+KprkFrh8gHZzjR3V9yKGaRU9Hw99WrLgnwqfNRcnJia1FVwDPC1XQJpMT?=
 =?us-ascii?Q?SIRDsTOSr/UpEiDiBmVRjNwXCsjm3HwZ3vF/x8WlipYf/4SJq1WEgQw8Urov?=
 =?us-ascii?Q?B7U1zbk9FcS75LoMdgIUFFaEXVHazbl+D12gbOXTusHLZc+huCDJ4IRVlJ65?=
 =?us-ascii?Q?WmxJ3hwhdz5cLHdw/+v6+GyviqTiNtB0OMvpS4WjTZge4owfv3AOpLqRdB0d?=
 =?us-ascii?Q?e19F7cBN/6HELv+NIqrlFRsR+D7Pn69qKGyraxKbsdURtqoJyo7mbJJ21PI4?=
 =?us-ascii?Q?hcL79TFVVGbGjS7KUUB22G0NBItgqHHwaLyOSGhiTwUb2wEtD0AycEnLdwEB?=
 =?us-ascii?Q?LGAvNocILpU5Kz7k9zDmHg9JP1+pe+SX+5x/+W8tCtU2wLiN+0ZizJftZC7I?=
 =?us-ascii?Q?n8ZOrxP5ZZBdHOXZlBOmcAt2kI9HLUvzqxaaXNteEjlf/EPR4EXCf3Z48laJ?=
 =?us-ascii?Q?vuKRptyFptpli4uXHM9sOLCnCrNwqXT2076prdiK0pGIQEN7yZtVBBPCCQWE?=
 =?us-ascii?Q?dDwRrEhMMdsJ/n9fpG0IOhm5CvmQ06G50XcH9qN1abOgnkaotmG8bUORKB54?=
 =?us-ascii?Q?4N8rjdtcLOp1JwNX6tO8ODmKOXVOVYCMtPjcW6VZxqM6d3aB0K0Nc0w81wBD?=
 =?us-ascii?Q?iDPgDs62Yi7Wk9dapw527mfkXcjYE//lRsgyDTi1bkvn0VTEg/AMoWkQsJtG?=
 =?us-ascii?Q?YI4KR2uBvaslsyhGF22xY8oYgLjxnjXTcE1cTTIe7OH8caXrmUBTH/2LWAPL?=
 =?us-ascii?Q?pF9b4kgeov0tCAam9fCZeF8jS30xpMWHeJ9w7u8q8BWpcLtSGm6diSDp7PZ1?=
 =?us-ascii?Q?r+VMiJfgVLpBRZoccaDzJTVAxqZO3uXgIs31czy8AKe5IpAyWdY+2iXkADGH?=
 =?us-ascii?Q?ZSr1ySoaoHRNiNI0PR+WWz2nQwCvOK4KLcQMvn7Fp++QyEBLeWYK5lROYW/b?=
 =?us-ascii?Q?gNUPXtrfPm2Z8S0xUE8O7X8MX+BIubwBFQ4OKTS6LJZFoewHFD5ftIjjgMF9?=
 =?us-ascii?Q?VSggP0UxSHfuSYpexDXOufL6ULkFJ1OO3u3lmRrSgC5u8J0vSKnm5/6nEZ15?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba603353-1852-46b0-c2ef-08daccc5dab4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 20:12:18.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2czxweVLOFiwF1XQ2BOsyEqKc6qZWgMdkunUwVyX65Ip9vRuN9Oh8liEWK76nHoxeDRqthQrdRf6zZ21c9ZYaoVGj/tykbXVXGYW40t9sf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> On Mon, Nov 21, 2022 at 11:19:25AM +0000, Jonathan Cameron wrote:
> > On Sat, 19 Nov 2022 14:25:27 -0800 ira.weiny@intel.com wrote:
> > > Initially, it was anticipated that DOE tasks were going to need to be
> > > submitted asynchronously and the code was designed thusly.  Many
> > > alternatives were discussed to fix the work initialization issue.[2]
> > > 
> > > However, all current users submit tasks synchronously and this has
> > > therefore become an unneeded maintenance burden.  Remove the extra
> > > maintenance burden by replacing asynchronous task submission with
> > > a synchronous wait function.[3]
> [...]
> > @Lukas, I assume we don't care about the async support for SPDM going forwards?
> 
> We don't.  However:
> 
> While I wouldn't have put in the asynchronous support in the first place,
> now that it exists, it wouldn't delete it either.
> 
> I would just keep it internal to doe.c and only expose a synchronous
> API call, which does the pci_doe_task allocation internally on the
> stack, uses the appropriate INIT_WORK variant and waits for completion.

This was my first instinct as well, but after typing it up for a bit
came to the conclusion the design would need a bigger rework.

The problem is having the work items in the task vs having a separate
command-queue where tasks are submitted, like block / usb and other
drivers that take command submissions.

> Actually I was going to do just that... I'm working on the DOE code
> but the ongoing patch submissions make things difficult for me
> because I have to shoot at a moving target.
> 
> The simplest solution would probably just be the object_is_on_stack()
> check and the second simplest would be the synchronous API call outlined
> above.

The explicit separation of INIT_WORK() and INIT_WORK_ONSTACK() serves a
purpose. It makes it clear that the work context is scoped to submission
function. By hiding the difference it hides bugs where submitters get
the other async setup details of the submission wrong.
