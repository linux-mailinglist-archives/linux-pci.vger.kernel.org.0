Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F88563C4A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiGAWW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGAWW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 18:22:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3970E5A;
        Fri,  1 Jul 2022 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656714176; x=1688250176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p6W5OTaizLANecLHTDSgLSIx9aFmspSbEYeTPhcEdfU=;
  b=VUCGPMj18BzLfOdz25tp/ctxP1tbYTLj4v+uhNUeD1QU3fx6lMINutKO
   AbRY9JxvBzJBXb+newp0WhaQQbkAfNZS+cFKVLmhAiG6vL9rOCaNzXFF0
   DlNkDN5chqHsg8X99nt9yX04rvqiocTKbkcYGpux3KRIXYHsE1/p6k8sb
   uFBhQQp9k65NY98Co+CRdJ1HjJmpuXkS+kFGl68FZBK6ymFw1WYExiB6n
   dQ6TYbp+Ql3Jl4HbyDYrplSrSALye46c8Ei8qPqnxf/Rz7RT8vb313lno
   FRbEgYndzfugSDRq0jaGPhEVWX0plafb2vZGKUojFLv1UqQ87zmN605Q7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="265787548"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="265787548"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="694669570"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 15:22:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 15:22:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 15:22:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 15:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd7fjl2TPjmNyLL2K5o3NWqYazt+WfTJ3713jmxqavgKPBE2/ZeKGM9Er45S01XQktfg+cAWLzj2VWq35EVt3S1hAduZPDjHkIu0nawwNrl3AhkZa4tx/AOIF/n+cMlFothhVtULdP1IlOs48E/rzIUX2u65m0JO+oBsV+7xPncqhJOrc+R3l8iH1+si46VwUEW6mnWCmTrZ66qlGRBXTrWM2Xw3S3OcugX5QYLLC54vFroR+kjruepUrjM7Gr4EOvXH5EXXkE3+m4//hsjEm2zN4n5w8M4vKUgIrK+EOlCg6idREXZoAktDFdZbp18SifSyHzrhftk0nugqygm/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa74oTB2AOcZgKlkmmfo9KxlHqLyP6eh9csxxBnJVdQ=;
 b=JgRPuyvVZ0R88r8s7VZ1/HG+FBIvyT6urTa/dAGQGUAaKzfbNfppqozCMTAN+PtYWBUNjnWN+lF+OeGzveNwYwrZUvMUVSc1Jm3vK8IhKgb5HjZGnDT/KGctJh2bK+S6/S39ws58gm9azTOlmnQMvAGUfPjk4Sotq6996THVKtCHeF1vJ08odmLVIhEDJJ0zWj8J6AFac+jo4NveFDTW96bRg0u+RUMPcSSFaFKo2SEij0nlUFSQGGrHiMXs3tDtnDHOlO02eejtaCrNnbypJf2lY6ZbhG3dwg2lx+6NAIyZh1U3Ebc+LOLMbPCHTEjVAj9UX5kWvFHa8/RqB23lEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL0PR11MB3107.namprd11.prod.outlook.com (2603:10b6:208:7c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 22:22:52 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 22:22:51 +0000
Date:   Fri, 1 Jul 2022 15:22:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <Yr9zroBeSLfWyp5U@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628151626.00001c0f@Huawei.com>
 <YrtGcNWcmzumj2gA@iweiny-desk3>
 <20220629150947.000012be@Huawei.com>
 <Yr0nysRl7x49me1K@iweiny-desk3>
 <20220630162540.00002910@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630162540.00002910@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad5f32d7-285c-4777-3c30-08da5bb03c82
X-MS-TrafficTypeDiagnostic: BL0PR11MB3107:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4tuZqAg+9rlQvb3hBI0l9eYArpLXX5ikb9bZ9wEk8Vm3DsONaprT6TsS8sb20V8IoQDDdvpS6k/i7tVHeysUWoZVso+3S5MS42i3IuGhV5f1jPtdQEQBFALw3J//c7o4cvlmsZzav6ueBAn9YEHP6lBQb7q3PBrokyPNQEnTzaR4oWUEu9bD74YVLGUTrPQxJNaOUBzGRLKk8VB0B0JABntiqlKP5/a4hZK+Mzsyk+iGUhfkwqu1v+H7T62OJQQg6sghbrm/Nao/rdt4RuY5PW6eXPSdKHpG5g5lex8IwedkDYt6D6gfi0TFZqDloyFQD89h4eVzMbBSnF5aHc5cg5wA/vTJYYX/GyltzoFDXgYnZ7cZDvfzvkSIYkarqZKhtbAeS2A00WCTRBEgYnhVCq12s/R24jy9pS9MK/WWRN5NTQiijClqU6IajBmKyxo6a9Mpnt3dix4HZH+zyth0VpmVvW2zvPjLIMW3X3r4C9R8c0gInxiG0eq24SdJ7BGv5tyfCyw5L1dJMJLoPlsa8a/EFDSfYTK1cXeymH0niPiYPEBFPeY6b6oEzWijIX5G68ChFmL+1lplZp9BxY45KqyIOnmc1tBeXW4Rw5nun8sIc6kuWy3t0ddE9W+rQGWj5u5zG1UWGzVF8qWbpEJmWj28LYMyd9bgQ0tHLthiUBb6ZIRJNeB7RyfQiaNt4ylNCs0Th/dVwfuSeqpz5k3CC+qKHsXxNju6CYbxPtPAWdiFtSMPi8c0Y6ehT7RG9KN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(366004)(39860400002)(396003)(376002)(2906002)(66946007)(15650500001)(6486002)(478600001)(44832011)(4326008)(33716001)(6916009)(316002)(8676002)(8936002)(66476007)(6512007)(9686003)(66556008)(86362001)(5660300002)(38100700002)(54906003)(6506007)(6666004)(186003)(41300700001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4EnkC/zDrik2PPQsXZFlGlZrk85fBXDospmRrtS7nlUlFlYXxcCMGxvFN9ZL?=
 =?us-ascii?Q?+qfPwRGf6DtwQNAKqkEC+2jBM4Ao78QVjGqvseDzrJ9sJucjJTa0cQXKDvTM?=
 =?us-ascii?Q?byaO8w02gx4tgUgOGISOSoKvX7hWfp/UIh8J4YcLBAcRHcNuLWQgUETxIPMt?=
 =?us-ascii?Q?fL1a6ZtYGhnGfPuUmNhofBd67HplTpwLNe2kTzx9D8DMJgmC976X+Nkw/2Za?=
 =?us-ascii?Q?sQSZw4mZ1E203kfMjL4FYorBQKx01Pr0gW3P3csEbotheSsnraoZulQ7EFmQ?=
 =?us-ascii?Q?8KVs5cRYh6qD1SZOWJxPwxqd0yNssOpfU8WD6oDMMAAH412zkjPZXczWWoDi?=
 =?us-ascii?Q?TZ8sTvI9KJ4pKPE0dkcMBcW2/UycYbefZkUAG7ELz8cOVkHVocw+O/Ckmr5V?=
 =?us-ascii?Q?8cMUixrIub1FiJGP+Nngd9c30h3LyoW8PmdXbrxmKjWJQypWfjKMTAmPkaOu?=
 =?us-ascii?Q?aOZJnpeLRNpGdgLWGFWhH9sRCHmNGUNWKlVuAhY8JjDI1d+wgmMG5DWJvk0n?=
 =?us-ascii?Q?3lMJBnVkZRRvG6VuTbu4EedhIsneiQb97d2VzYiGJ0WRPylGcqOBfMl8JGjh?=
 =?us-ascii?Q?GdahoSnaGm/EEFWel0UWXeliuuYdnTu0NXmS5NO19UFy0SVbCszB86GshKzK?=
 =?us-ascii?Q?KMuKodZNm0OXSN6oYWdW9qZ+J4d/FUKv74k2Iyk/GBbKGPqhsukE6yPg2dxK?=
 =?us-ascii?Q?alhgfnQDjKQnFlZNR/QT/w/FqDrFg9nsvbfUOw0iQJvy+ZH3o8F7Z+cEr/U5?=
 =?us-ascii?Q?qOww2M2MpP59U3LJuSIoT5WaVjxJY7KihzwEhbLyNFOcJk0U9wB0MVbKaFCI?=
 =?us-ascii?Q?sOrKSqs0Ng6kLXmnkZXAjukFt4rps6TH7aaMmOVuMXtTJQsEKDvIolgMDAQ3?=
 =?us-ascii?Q?LhOx5rag8kqk2UKTR3w8R5NZzKoIxWBEHrXJWHDy1xAUaHl1OoVvWoDrtE6C?=
 =?us-ascii?Q?in3DZitwz20jatAjpfyS6ciMu+mG04C74DXInuN/maZw1WcG6X7IMx9gQR2a?=
 =?us-ascii?Q?+e4jQvl4msnyp3rhqjXw9Pbh4GitHzBYkLTPgmoTIpQ7WR676VwWMYGfO09+?=
 =?us-ascii?Q?/z1oGvd3I1B49nIA+Mu7zkj7bN3J0WGOmAXnswiCmPsY7TwSbkZr8ZCv755O?=
 =?us-ascii?Q?rPigVU06LVqDj5XFeD4Z5UlkeKToh7coJx6JE0LbLDPwhvZGqknIpTg+1V8q?=
 =?us-ascii?Q?Ac2+UQtXiQHwBQ6+h1KephLOkSnpIcYHt6zXIKl79rH6eRpmssU5a03mgRQV?=
 =?us-ascii?Q?xCT2HbJ0BNCTk6TxFfRQJ9gSsRG0Dvm7FrfEme7/Xk84FW3SRhJE4xjV53G5?=
 =?us-ascii?Q?i+Xt3WpXEshqK3XUeCX+mVF2W72J6nELPN4lU8PootKzVQX2skgg8pJRKpS+?=
 =?us-ascii?Q?F5/2w9EktP7Sivs5BD/Z5O600yTbD2TvOVREYRIh532LUfZIe/5qfG0LUTV2?=
 =?us-ascii?Q?jSM+/DjU7Nujj/2EV/bfXOu4dTtQD3W+dyZ0zga60iKkt2bpF5SschNN0OMg?=
 =?us-ascii?Q?6nz0UiD6OYjGTLADr6/dJMVP/xhzhs/Td6pp7yGcFIhH8+Z7mVDLe8xnVTGQ?=
 =?us-ascii?Q?zQgkpKjn7oSdZedfudh4YAx+FC928gh+2lx4fU0n/V4RjhSm7PmN/REbBkut?=
 =?us-ascii?Q?LZ06CiT4RJlVciLm3I95pxyCN3dp6ePvCswGCJZEhHBh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5f32d7-285c-4777-3c30-08da5bb03c82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 22:22:51.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CNm9sNl8DNURSu5jazSOdxJTb3rkVSvCb7/IVgxE0QAsRBHkcGVFA4dpeCF8xCDZXYVvHsWj5518ogX/6x5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 30, 2022 at 04:25:40PM +0100, Jonathan Cameron wrote:
> On Wed, 29 Jun 2022 21:34:18 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

I've dropped the IRQ support and was polishing things up.  Without the IRQ I
don't think any 'arming' makes sense.

However, in working through the sequence again I think I found another problem.
I _think_...  :-/

> > 
> > But we are only going to see this if some other entity is using the mailbox
> > right?  And I don't think that is going to be common, is it?
> 
> BUSY on entry to doe_statemachine_work() is indeed only relevant if
> some other entity is trampling on us. It's best effort only.
> 
> BUSY during normal flow is the one I care about.
> In most cases it will go like (assuming we clear the int status in the handler as now)
> 
>              Send Object
> BUSY      ________|-----___________________
> PROC      ________|------------------______
> OBJ RDY   ___________________________-------
> Int Status______________-____________-_____

So I did not realize that BUSY could clear like this.  I thought the point of
BUSY was to indicate someone else had an exchange in flight.

What happens if another entity jumps in during the PROC time?  How does one
know that OBJ RDY is _our_ object ready and not someone else's?

For example 'entity' issues a send, we see busy clear and also start a
send.  But the device is still processing the send from 'entity':

            Send Object(entity) Send Object (Linux)
BUSY      ___|----_______________|---______________________________
PROC      ___|-----------------------------___|-----------------___
OBJ RDY   _________________________________-------______________---
Int Status________-__________________-_____-____________________-__

                                          ^^^
					  This...

... is _not_ Linux's object!?!?!?!

Can that happen?

If so this is entirely broken.  Even Polling OBJ RDY will break.  And worse yet
we will not even see BUSY being set in any 'abnormal' way.

> 
> where I've added PROC to mean the device is processing the data.
> Once it clears the input buffer on the device and hence the device can accept
> another protocol request BUSY will drop.  If device has some pipelining
> or runs multiple protocols in different threads, you can think of that busy
> period just being the time it needs to copy out the request to some protocol
> thread specific storage.

BUSY was not at all doing what I thought it did.  I'm now concerned that it is
completely broken WRT to other entities even without IRQs.  Frankly I'm
confused why pci_doe_send_req() even checks for busy because it is unlikely
that we will ever see it set.  For sure we won't from our side because the
workqueue is going to process one task at a time.

If Linux wanted to have multiple objects in flight I think we would need a much
more complex state machine than we had.  Maybe your original state machine
handled this.  If so, I apologize for missing this subtle point.

At this point I'm debating removing the check for BUSY as well because I don't
see the point.  (Other than maybe flagging some error to say that 'entity' may
be messing things up for us and bailing.)

Thoughts?
Ira

> 
> You won't see this in QEMU without extra hacks because we shorten the
> flow so that whole thing is instantaneous.
> 
> If those two interrupts per transfer occur well spread out they can result in
> your INT flag being set too often and some of the waits dropping through early.
> 
> It will 'work' I think though because you ultimately spin on Data object
> ready which won't be set until after the second interrupt.
> 
