Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D363B087
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiK1RxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 12:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiK1RuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 12:50:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911A2EF12;
        Mon, 28 Nov 2022 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669657411; x=1701193411;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gj0Pfp0yhDA/qQO2LXz2ZVPQ/n4FQKadkNm+Cw5hjGg=;
  b=nlY8OqAn9C9riKv+gna+ITGms1O/5xaQp17pQgUa9vJOkF+chRXs5+bs
   YefmLlIKYRYQlBTXEK/utknTyv6f5Imu9r5g9onb+W5COOtptPMdf31sn
   uTHsZvoz5yF7imUcdB9THyMRmHhJnj8XCf+CjpS75rOEkwGB6VyvHvMIx
   D0XmErcCbQEkMiY5gahOBDvLz0vn4T5sXGJg6zZ0xqKaWpbqE6EwtgxhS
   3Oy/CPk9cAk+//Pshu8v8z5F6z9RstS7D+NWuG25naMaZW/oIOh4MNpdL
   95Pg6sqq17R/S4UGlUH+N/36wruOKL8P4UpwvqoPejy00M0/uQuoWZ9F6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377045892"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="377045892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:42:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643474739"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643474739"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 09:42:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 09:42:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 09:42:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 09:42:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aftbv915YL4gE2378pyFtfmcPhrHb3DRJbIFIkQ2plppJD1ETicT2XmWspahfAQpUYCXxipoZ7wjvqZyYRDMQTRtSvaq03bIkHfZjFUCTEvMkrUPo9zdPRlickqcgGIhiVKinm+GoXDfgnuRpPf98uadcUgfL/jxPgYsD+GlFY5mqKt2Zk9+hw9lBx4ZYl9zTGIhIxiMmHRyV1nBDDLNTHJSiYp6T/eThjJ2QjGS6IjV8EYMbq4ALuWUFCVpPq2pdXBE/LK5lWWm/yetaA5f8uVgkXQR5ZP5g5H9nl5cGlk9GK/JrwEQSVgzW5yWf/1A85YRZhCt3XjcC2Ut4Gkp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGniv2kMP+ANG20dbAfZW8Xtnwtn5lFS2dgR9nZfT7A=;
 b=UMg251+5QNAWMpN65zx22oU0Gtf89lZtlAHNQr//1UpHD+IFmjD6/G6Bz+daQwZ79lf5P5FcLeec4NWTtOcGNZN7lDDK8PTH8ONVC1p8wHCAWVuq9P9Lt7/XoEHyBUwgVDij+dUjUyz3RCXMVHL5bdRfU8rclOe6DQG8YeTHkuByzxvHzGt0kwd7ST5NyNFpdwXjNl0umMDURvCGEHJFbEvYLAayfqukQZnZWoCbgj/oeSvEOHsPsh1h1ww+jZXAFJFcFCspNhPfaEW0yrNPE9bu4f0dHsd2BWOCodi+DtbBfCUIl4PL6Zx13k0es+8enky8lMrx7ilGLJGsumYzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 17:42:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 17:42:09 +0000
Date:   Mon, 28 Nov 2022 09:42:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Li, Ming" <ming4.li@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V3 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <Y4Ty688S9k7kV/d6@iweiny-desk3>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128040338.1936529-2-ira.weiny@intel.com>
 <f6e7bd7a-c901-a38c-e427-e9671dfb6d6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6e7bd7a-c901-a38c-e427-e9671dfb6d6c@intel.com>
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: a984a9ce-97f0-45f5-5388-08dad167dfa1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2xr1GuUsJB6Qq9dqELzMgprmVtqCxOjdtRW3q14TdN7QcoTslCrxQQLAUot1GWtLUJaSwipRE/0bQ9FxTkv55UumlFkBw8pBUMKL8SKqcsBfoGscNYIH7tRMfSDQItA7w544DD8LsZyPj/WGwbvPU/PcP0b6yAUfzNPUFuRFoFmI1V/zM6S2ca4CyFOtFhCqi8OWCFclhGHLsmQmbcuA7iqPSPpEuf2ytYTag3wP8Mg+GX28FITrkCUEBNKkigGCmMmjxKJcqfYQ2OmEwLFOHZtkEEhyoxQXrk8Yqiyb6SFOQhCFxSNuCN2XZ0za0H49cyZ2v1sB8vGYEfSzkSs4xXtmH1a+pCrRGfSYVSuiyqrisf5/arrkkl1D5hcSemwTuuVbKRW4ngvrCIMNrhJ3TPA7xa1qxorA+TaKGpKQEs65EesNp3U7qqz2fd5EvZ+g4b2JQ1rbYn1ZGcwliPA+2OItiJsBeS0nzQlFSzEg5nBsz6CL0vT7aMsTF0EukCTaBE8bCO5ixsIy3M4D7l46e6ciWL8WPMxtvt5gBCjES/7WF+Gy1kNExb09GNPUWTm8AEYWegucB2y54Ltv89uKnu+9adkFlfPF8+LYZUf0NK+QkoZdRTio/dtzqhNiaQUTxjJ7yi+qspH1P5wrG+NkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(5660300002)(44832011)(6486002)(6862004)(66556008)(4326008)(8676002)(66476007)(41300700001)(8936002)(6636002)(54906003)(66946007)(478600001)(316002)(2906002)(9686003)(26005)(6506007)(6512007)(53546011)(186003)(86362001)(33716001)(83380400001)(82960400001)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2m6PILfeO1A/k+/2Xk9cWJ3fYiYaaO3ZuMwcWKcpv3sdsLYknWn3gNqDN34W?=
 =?us-ascii?Q?nfi4t9sMfXp1CN0FZv99KPp9DbPxd51KE7IZkQo+66ZTMYSlQA3lkn5zyGhB?=
 =?us-ascii?Q?W14NyhDzqgfp28p+Iug4J3mADtxoAwd8mS5TkSpwOvQFUw89Uh7CSYQYFru1?=
 =?us-ascii?Q?PdoHlJ9e6q2b7ClAtw0Il6qh/xTj4qqndAbb8H7ck+oxcbsyqZGCbj2VmQ+j?=
 =?us-ascii?Q?T0YpU0/Wxt7ekwePKr3rl/f4uLkTtoVUYL26P+vw4zYxjsn/JeeNtGJBtg8m?=
 =?us-ascii?Q?tGdSeriO+n6AO40tiq2shnTH5cL/woEQDJUWgS/cjOWV8BdyeHjx2H1gT8Yg?=
 =?us-ascii?Q?yQpjkV9nRFvKiep2wkwpaZXuRnRWRwnk+Rxg2Qu13CLDX6hHVoXgcHyI6D0d?=
 =?us-ascii?Q?9GN+EbClKPFXW0RHiltEfVGFdq/YJecbCUc/w4yFW1uN/TWs3UoqLPQ5IzKt?=
 =?us-ascii?Q?owy+Q6mladNbbAmfBDMQi+IAq3BNGILBCT1m3aiiLZs61u7VvBRQ3Qv/nsVF?=
 =?us-ascii?Q?OMtm8ea0IpwyDG/0pRKysN7ZXi5hbs9Wg+4dpGMjvv/xAoAjqVk45zzqXpGo?=
 =?us-ascii?Q?36/b+nkMSmnI18q8Ly+eusFMrLvByh9K+KmlVH4Bjn4PD5W063tcel5Rb0vO?=
 =?us-ascii?Q?Q9nAo0rxaWwOqJdBsBAeP7ytHG3802U4lVS0TPOF1DF+f0qt/umt/1pvTsUP?=
 =?us-ascii?Q?Dcuo6TFMfa8/NvTzrtEqXjeMj20H55ZL0rgNW7uh3jjIcUSeF8w0VCLI4fyr?=
 =?us-ascii?Q?uBW8tZANjqI3RLL/rcFZl5Ixa/1D0uVUH8Nwv33dCYDTjR8mOJJBK/H0flvX?=
 =?us-ascii?Q?hIgDPIrLgabH4ootGRIPtM/j5OWphWzhtKzl6LvlGaoskTNsFWDeTeLIVTBt?=
 =?us-ascii?Q?ubAQaprpIG4jk+HDkVyM75GUWkx+WZaEQybC0T3IuTG6isFfHpQY8TKHGLmz?=
 =?us-ascii?Q?PDgTSM9SFva80eF0C6AnoEoLLPzbQ93Sru9I2sXhhKoTgERXmqKbWr6+AJkC?=
 =?us-ascii?Q?bH8EPboY91DsNkwBoozFf+mkvJTChvDo6QmWIq1SMB4XvcE5XKjz9DXpifln?=
 =?us-ascii?Q?aFWQhy2jlnFC8ozLMF9bLqO3QLPV2kdxX6IUmjFcTcvMUpopvNMkfq6/RNvS?=
 =?us-ascii?Q?lrqu/tAPSqZJ82GRaenunbY2rQ7rokUwuEPmcqqO7m5xwUjORL0WBAYgnaAP?=
 =?us-ascii?Q?i6i6dFQdagDoRwc9sYPl3im2QQKsT2aDBXcmwXxpQP00CxMtz8z/2gfnJIa+?=
 =?us-ascii?Q?G9TUudqLX4tNBFT3CF77WKlZ4np5TUWv5vnnUYIWVl/K5uLJYG/GHFjnTmKw?=
 =?us-ascii?Q?BDcvze8oxhZFFtKSLSI4JjH82JXL+OVz9gUdt2prrejT7Ily9cgQAUevs5NF?=
 =?us-ascii?Q?BD6wgQeInGpfcfsQqcQHA6mph++lSAWVKHpoe54jQ97TzZhKEVppa/0ZJNc/?=
 =?us-ascii?Q?bB+jnwbgzqsQaaj4FGSzQOxYwNUMSDV7qSiyHvkr+yilFxZv8uRuSHJNHP9l?=
 =?us-ascii?Q?hoekq6yDKNHAoUSS9vIjg/6bUXWzIkE4WJkQzhbXVG11C/1asB9w3A442UD5?=
 =?us-ascii?Q?crMnaSftkb1xioMAK90bR9xozkgJp94V6uSevsd9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a984a9ce-97f0-45f5-5388-08dad167dfa1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:42:09.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS22cAMiQmw+UZpr2UXkUtVJkjtFPrpp1uhBHVArr+O+hcKW9tN2hexD0vJNYswp4JXyNeiffCJxEjHuB42SzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 01:51:24PM +0800, Li, Ming wrote:
> 
> On 11/28/2022 12:03 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > pci_doe_flush_mb() does not work and is currently unused.
> > 
> > It does not work because each struct doe_mb is managed as part of the
> > PCI device.  They can't go away as long as the PCI device exists.
> > pci_doe_flush_mb() was set up to flush the workqueue and prevent any
> > further submissions to the mailboxes when the PCI device goes away.
> > Unfortunately, this was fundamentally flawed.  There was no guarantee
> > that a struct doe_mb remained after pci_doe_flush_mb() returned.
> > Therefore, the doe_mb state could be invalid when those threads waiting
> > on the workqueue were flushed.
> > 
> > Fortunately the current code is safe because all callers make a
> > synchronous call to pci_doe_submit_task() and maintain a reference on
> > the PCI device.  Therefore pci_doe_flush_mb() is effectively unused.
> > 
> > Rather than attempt to fix pci_doe_flush_mb() just remove the dead code
> > around pci_doe_flush_mb().
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Some comments inline.
> 
> > 
> > ---
> > Changes from V2:
> > 	Lukas
> > 		Clarify commit message.
> > 	Jonathan
> > 		Add comment for changed poll interval.
> 
> ...
> 
> >  
> > -static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> > -{
> > -	if (wait_event_timeout(doe_mb->wq,
> > -			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > -			       timeout))
> > -		return -EIO;
> > -	return 0;
> > -}
> > -
> >  static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
> >  {
> >  	struct pci_dev *pdev = doe_mb->pdev;
> > @@ -82,12 +73,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> >  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> >  
> >  	do {
> > -		int rc;
> >  		u32 val;
> >  
> > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > -		if (rc)
> > -			return rc;
> > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
> >  		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> 
> Looks like we don't have to use msleep_interruptible() here, can use msleep() directly?

I don't know.  I think your suggestion below holds here too.  Unfortunately
that could mask the signal received in the case below.  But I think that is
going to be rare enough we could ignore it.

> 
> >  
> >  		/* Abort success! */
> > @@ -278,11 +266,7 @@ static void doe_statemachine_work(struct work_struct *work)
> >  			signal_task_abort(task, -EIO);
> >  			return;
> >  		}
> > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > -		if (rc) {
> > -			signal_task_abort(task, rc);
> > -			return;
> > -		}
> > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
> >  		goto retry_resp;
> >  	}
> 
> I guess that you use msleep_interruptible() here for aborting current task when signals come.
> So there should be signal_task_abort() and return when msleep_interruptible() receives a signal.

Yes this makes much more sense.  Thanks for looking!
Ira

> 
> Thanks
> Ming
> 
> >  
> > @@ -383,21 +367,6 @@ static void pci_doe_destroy_workqueue(void *mb)
> >  	destroy_workqueue(doe_mb->work_queue);
> >  }
> >  
> > -static void pci_doe_flush_mb(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	/* Stop all pending work items from starting */
> > -	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > -
> > -	/* Cancel an in progress work item, if necessary */
> > -	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > -	wake_up(&doe_mb->wq);
> > -
> > -	/* Flush all work items */
> > -	flush_workqueue(doe_mb->work_queue);
> > -}
> > -
> >  /**
> >   * pcim_doe_create_mb() - Create a DOE mailbox object
> >   *
> > @@ -450,14 +419,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  		return ERR_PTR(rc);
> >  	}
> >  
> > -	/*
> > -	 * The state machine and the mailbox should be in sync now;
> > -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> > -	 */
> > -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> >  	rc = pci_doe_cache_protocols(doe_mb);
> >  	if (rc) {
> >  		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> 
