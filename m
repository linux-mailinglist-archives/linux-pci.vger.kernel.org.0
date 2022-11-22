Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3256340A1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKVPzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVPzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 10:55:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18765532D5;
        Tue, 22 Nov 2022 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669132522; x=1700668522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oytMwp6ToewcdVRhc+iof3yGe9FI0ImjeNjQDTh3NnY=;
  b=JHylfcBcc6QYKQAVr7hD3xsu4eSmMWJWqcBltLa0deMIjgx63CaqwUj2
   xGCfrgxz3e+bgL6pcbLEtwG3d4gDTwx9UXEYD2o4WMz9z1lmIyJC4s+cM
   aiXvhYaaPecQDpG9djj4OMY/2O71yK4eUq/nQrM1GKwntfN231DRdq4ve
   +lHtlubVqPaVGnvUFc5T682wggQuESIDCnFa0qEsi/Ud9bJ/B+4ge+rZ/
   C9UPajRTbn7Al5VAx7Nvo1vv9QsE+Th+X5OF8tmyL1l0F0O5/Gu6eaCim
   4K4NihJ0Eh0Frdnbq4SPrjSC+erJdzE3A3LV961ODcYhwgrybe3XJZM/X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="314996035"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="314996035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674389947"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="674389947"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2022 07:55:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 07:55:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 07:55:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 07:55:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 07:55:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPum9ZMrsz95hRB4KjgDjLG0Wv7IjQobGEHf/6j0I5xneW3TNXOA5E6pMk2nRxdx60VO7DPomOnfpRq4LXoG2MmATd9PtQiE1CGuUn4a5dr+z01caJciaYRGenPH6cjhSNpPEsIEjyout/Q7ReyVmlchlYAK8n9Ll85Jo7dXtc0Ii4Jw9zkYJB8c6oeryhNytuBHbnSYpQkf7B60GL5J6ghnvKxH+QX75by2nBMGNc07W4qZnQmulxucp++sTPo4tkbuwI7MGFxzhpJwwY2f5J1rQlgtOHEicsU9zFTnuWy/Zezh78AMb6R6iu/LB93QpUhePeJIB77UrjXBUgQ8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dU7B9HpsEoS0mL+6pK2zwEV0TQRWironSSSNPDOnRc=;
 b=nQMaTKxYACcd+l4sBLVEStWtY5CqgQmXve6ZmGBSpgsc5XDXUvO8GwjmMmlkgeKWYRZsZNWmbY0YGcriTnssJRauLqwXCAOLn9BfkBK+8nhv75drbjh13HD8SWlBpJr4QQU88RAsLo+wqvRw60OqMDhVcdDydubY7vhmz7D59OIFquy/2QK2s+M0qJO8JDwHYDlqhjPO2R5FVST+KjjTwDXYpDgkxgZkLHC+Du5/FarL1rWp0l5wE9KcLf0izrUr5+MCAvorGVPM88w10AWf5lRyYq9V5jLO77iJW+oTUrOp1B8Lx8qBBEDHlxngf/6Fe9uk56HN4VtF2DYm0OjWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 15:55:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 15:55:18 +0000
Date:   Tue, 22 Nov 2022 07:55:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "Li, Ming" <ming4.li@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <Y3zw4vdR7pYPaMen@iweiny-mobl>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
 <e7db6aea-4146-33f2-9490-9b5b902e0ec1@intel.com>
 <Y3wC4kX6SCr90FGY@iweiny-desk3>
 <20221122094627.00003f2c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122094627.00003f2c@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: e62407eb-8ed8-44a6-d36d-08dacca1f40f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bUOFTWAPtjKXA38zzT54GQ6qq5OKO6WDHgoVqS928U+LVBhBe4guEfZ+fYNYNGfGFKfH2XjlkiCps8KMP6hP4zPxtScnY6cgwB6NympPLaZhvEV2+7WTo2Ra6AeLPOYdvUNMG92MkFAJkFyEA3/Es0g4cyEEf4sJTiJDTwz0jvKfivCBZg+GQ5aa3ILpOfmPuBDcfiRVO9j9s+vR+K0S7dN6f8vzXT3PBXgzacBE16kWRSyzEzutT/ocucmEjHU3Grw7wAHJJwbEA7+SPQM/FuwA8ZOgDNvHrObBPt+cQ1ItzCckd7rhQw6N9uJcBVLXPHzgR6TwBNA4A+mZfenYMknbTGOG6u7UKhhHqzH+S9LgV4gXfKznKq6aEwmRM4A+xe44z2g4aobfivoYn5IHWnLf5bkI2MC37RNwNiUb6Tve3a5HJNX9/Oy11FGfEV1Y9gDc0XJevsNrpMIu/l8sMytlwm7k5BdW+TwgWSgJKGVRDxjyoqjQRq0fHucaPtaZ/wJ60JX223C6yDg0icfGENYeI3XoaDkFlaWuE0dz0tdVja0vty4zlLz8s3XAiURcX+M53AYNXJ0/2dTa0WklasCSyzFNaiFZu9AXOPZwfqx7AkSnnDrLT3CCkaG7uio8pH6IQo9ON+crVLAQBhOEHrZGIQ3aNGaeAB+XFQsW3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(86362001)(66556008)(53546011)(41300700001)(66946007)(5660300002)(66476007)(186003)(6486002)(8936002)(8676002)(6666004)(966005)(26005)(478600001)(9686003)(6512007)(316002)(44832011)(6916009)(54906003)(6506007)(33716001)(83380400001)(82960400001)(4326008)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?46vTowarSAogap3Efmyp0Gc5VeVUPNunGecoet/97it+xfnIhqFNdnRmGwNN?=
 =?us-ascii?Q?ecH6bxhMITyreQ8yMS30nP+LHy9qLdhoPtTSoXJrW0zHkRZw/2NB4oJpDE9A?=
 =?us-ascii?Q?hks3al0V3Q53m3ye/wyAICQdzsADGP8XjxvkoSKGsmbSgm94eOWGhhKv83yc?=
 =?us-ascii?Q?gnhkxRPqL7UCv3GZx5odwlsrXq/dwaRNsuXOtEGFg3E60e1s2oiOUfNkZ2QU?=
 =?us-ascii?Q?BjbCPjIO0Pqq4Vy5RLDDiZNFI5S7NzQ3hH4DQLC/3Ivce0dy2u2jTQ0f8apH?=
 =?us-ascii?Q?+BU8iooTz9VgQAk9XghgXsLaDCzhpSGZZQwzhjrL+bkOfZuYFz6IKm8CTAMR?=
 =?us-ascii?Q?jgLF4PImcd9mygKyQC+KSvJVHGDdPnMhAFAdoLb1282tRe4LTyC+m1BXdv8F?=
 =?us-ascii?Q?xWP7AxgPE40C8aJJ3z8kNeOunFlunRW/onpoQBw7TQ0MDuE9bPjNx5VyOJsm?=
 =?us-ascii?Q?zcxPNo98CYIqhfzEgATbL0f2LuUTb6SHkhcivtDKr4pRc5IF6ks+X1q76rHv?=
 =?us-ascii?Q?V5FX9GKBn8Ayeh49G5tOZTjaD/hXr8Um5H7pvV6vuk7kQMfuF2aSVRyl7JIA?=
 =?us-ascii?Q?eroGi4wwdJvbNlJTbeJnhumTbE0l1nXSrfa4BtoxWgLwf1jPKEWBP249urFs?=
 =?us-ascii?Q?znKXSBrfzmMwF2DxpPNmli2CKewg8QZPKNhbYc4SABDhUSPZoqdwwj2ntHHC?=
 =?us-ascii?Q?r0ADRyWNwyZYNk1P6anMDOH89brjuJ6tSKat6vr6C9pq3hr22t0byJO2ISPB?=
 =?us-ascii?Q?sPdTjnTVQ9rQzhv7rkGpr+P02WMMVw1FS5oMUtj4lJvfNDmpfjjaRbyiwasM?=
 =?us-ascii?Q?vFs036jSlH3v1u9jAosT2XbrAJdJDtYjnyugNtuk1VSY+JAD9U5dx0qmiVp7?=
 =?us-ascii?Q?RSN8ZSBtmSVH7P7BH1AnAxh+meqRIBPD8RwnPD9b4HbvUTtdAKjuNkXoaCq2?=
 =?us-ascii?Q?8hLAep9/t1Zx3rZAxqlFFL5+dmjnb05q0hvQAWsNCJBWA62nUCaf/6amEp0A?=
 =?us-ascii?Q?uMQkW/cHD/gUUBatPD1Rv+XW/2ZRjWhL2iP56giTtEu9TR1p9+wrSZvgJlQn?=
 =?us-ascii?Q?hsFdEUgpTsOKzqrXa+xj4uETQZpN1D/MNB1V/rn0LnJtU6wOYOP9qcPjI3bX?=
 =?us-ascii?Q?OiNOcZONrQEYaU1J75d3gaUVHDfD1oaRS2to/csHuVxiRl2w5vXf+03Lmn1i?=
 =?us-ascii?Q?w/GqOr/fCFhdHUFD45gfofENPEx7ZKmHdYkJ5bCeI9b7Us6SI6bMi4kyxEdK?=
 =?us-ascii?Q?ozlRV+Qo/SwCZnHZrzaGLI/EBzSW6q5a8l9rl3v9quMsLiAvow3eq7jS0tYA?=
 =?us-ascii?Q?q2vkNJhTcF7HGV8oAmsKjNmE5ZN00NWo7eVF7Mpl0e0Xf7p6fE9M0Q3cyA7B?=
 =?us-ascii?Q?J4tfXB3W8RLHD/MlM0d4D198h3JqFpGtilsLJSYN5NyR/h6euFsUfCBrvuXB?=
 =?us-ascii?Q?vXRLBB/EcbBGTFVNfCmq2Qd+IW/H83feR3mNy23zNK+jWEINtgteehSWgbgR?=
 =?us-ascii?Q?AdENMGCgCGTdoBgWPsWx5a6xOHl9z+AbYYnik5q0dBwJcnaXhVCvnNItChP+?=
 =?us-ascii?Q?9oXnMis+EuVIxw2EVU7VsK3nruXQn0VROzYDoEjd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e62407eb-8ed8-44a6-d36d-08dacca1f40f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 15:55:18.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BzQthY2ZeYEmN4PfDTD4FmU7RRHBhMfcZpcZkGQCOwxEcZaebFMwGqY2qBFpA8jta8BAIBl0YK4+dRJUEZclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 09:46:27AM +0000, Jonathan Cameron wrote:
> On Mon, 21 Nov 2022 14:59:46 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Mon, Nov 21, 2022 at 10:07:56AM +0800, Li, Ming wrote:
> > > On 11/21/2022 9:39 AM, Li, Ming wrote:  
> > 
> > [snip]
> > 
> > > >> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > > >>  		return -EIO;
> > > >>  
> > > >>  	task->doe_mb = doe_mb;
> > > >> -	INIT_WORK(&task->work, doe_statemachine_work);
> > > >> -	queue_work(doe_mb->work_queue, &task->work);
> > > >> +
> > > >> +again:
> > > >> +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> > > >> +		if (wait_event_timeout(task->doe_mb->wq,
> > > >> +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > > >> +				PCI_DOE_POLL_INTERVAL))
> > > >> +			return -EIO;  
> > > > 
> > > > We already implemented a pci_doe_wait(), I think we can use it to instead of this wait_event_timeout.
> > > > 
> > > > Thanks
> > > > Ming
> > > >   
> > > 
> > > This wait_event_timeout() only check PCI_DOE_FLAG_CANCEL, that means it only detects the signal which the doe_mb has being destroyed.
> > > If current doe task is done correctly, I think we should wake up next task. Current implementation just waits utill timeout happens and try it again.
> > > Besides, If two threads are waiting a same doe_mb, thread #1 waited firstly, thread #2 waited secondly, there is a chance that thread #2 is processed before thread #1.
> > >   
> > 
> > Agreed.
> > 
> > However, the real problem is that the doe_mb is probably free'ed at this point
> > and all this is going to crash and burn anyway.  The implementation of
> > PCI_DOE_FLAG_CANCEL was fundamentally flawed even for the current work queue
> > implementation.
> > 
> > This patch incorrectly tried to use that mechanism but upon looking closer I
> > see it does not work.
> > 
> > I saw in another thread Jonathan discussing some sort of get/put on the doe_mb.
> > That is not currently necessary as the creators of doe_mb objects currently
> > hold references to the PCI device any time they call submit.
> 
> The get / put would only matter if we wanted to manage the DOE resources separately
> from those of the PCI device.  It may well never make sense to do so as they
> aren't substantial anyway.

Agreed.  See the new series:

https://lore.kernel.org/all/20221122155324.1878416-1-ira.weiny@intel.com/

Thanks,
Ira

> > 
> > :-(
> > 
> > For now all PCI_DOE_FLAG_CANCEL stuff needs to go away,
> > Ira
> > 
> > > Thanks
> > > Ming
> > >   
> > > >> +		goto again;
> > > >> +	}
> > > >> +	exec_task(task);
> > > >> +	mutex_unlock(&doe_mb->exec_lock);
> > > >> +
> > > >>  	return 0;
> > > >>  }
> > > >> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > > >> +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> > > >> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > > >> index ed9b4df792b8..c94122a66221 100644
> > > >> --- a/include/linux/pci-doe.h
> > > >> +++ b/include/linux/pci-doe.h
> > > >> @@ -30,8 +30,6 @@ struct pci_doe_mb;
> > > >>   * @response_pl_sz: Size of the response payload (bytes)
> > > >>   * @rv: Return value.  Length of received response or error (bytes)
> > > >>   * @complete: Called when task is complete
> > > >> - * @private: Private data for the consumer
> > > >> - * @work: Used internally by the mailbox
> > > >>   * @doe_mb: Used internally by the mailbox
> > > >>   *
> > > >>   * The payload sizes and rv are specified in bytes with the following
> > > >> @@ -50,11 +48,6 @@ struct pci_doe_task {
> > > >>  	u32 *response_pl;
> > > >>  	size_t response_pl_sz;
> > > >>  	int rv;
> > > >> -	void (*complete)(struct pci_doe_task *task);
> > > >> -	void *private;
> > > >> -
> > > >> -	/* No need for the user to initialize these fields */
> > > >> -	struct work_struct work;
> > > >>  	struct pci_doe_mb *doe_mb;
> > > >>  };
> > > >>  
> > > >> @@ -72,6 +65,5 @@ struct pci_doe_task {
> > > >>  
> > > >>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > > >>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > > >> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > > >> -
> > > >> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > > >>  #endif
> > > >>
> > > >> base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25  
> 
