Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49215636751
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 18:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiKWRfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiKWRft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 12:35:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507586A6B;
        Wed, 23 Nov 2022 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224947; x=1700760947;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DjollzA4f7DSCyURUAZFRSyQHskXDKRdzzEViE5S4Ag=;
  b=a2DXKWqWh7ZnxG77Mvtoh2Vhh9mLUCzKF7b6pGI5qykxkzbYZp3ydDtV
   oKs3ldGfdJ8FrTCZPqaXQZZdBIvYkQm3tgwi90foQp1lgk2bLJuKHdEN+
   jGPkaDgQ6DepSFwTBSwnotMO7liUiOVkaDvzn1L6x6m3ddNqgTSpu8iXM
   w/7wVbMW++RcoXZAgIKDKQ41r6TQMi9hBGcSn71XPjqsEmGm7Ba4T78zk
   PSJoE0xGU6zhdZFN0Xew5LmgPxLoXxaOg1H+y9EPi0eJ49IsgVHSLUnFo
   T8uLBRytzC0wisyCC0BLAhC+Slo9IvoPAotzSNN+zjLguF0r8y6tM9II8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315943017"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315943017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:35:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="816556291"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="816556291"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2022 09:35:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:35:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:35:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 09:35:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 09:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsUD5WEZq/jpt35xiJdcx8QoA5e3hOYXVj52xiU3yFL3j/KrxNv65XJ+xEXz1XDdF6xStlzYHgMT7ObkgFapls2d9Oi/X4oydw1Iv/RFdIY26ASbYGV4Vu5pzjboquwtLN9UZg0iRqANQojdAGZ0w2cExyvuku+ROqCBus//CiKz+xcje2bV58rdnECX86E+ADWIBWqF8Ghwx+M2WA5tvQMQG0UbP6r1uqGL4ekyYXN+/juo+5C+l7bcw57iYn3DeyW3Wbr13z1osDR/+CZyGd+DUy6wRXIcD9tEVOF6lzdYchaJDbtWNKeZxxbgArRChxBwYmyAeDIyFKmkia+5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBYvjdI0Mzx4wnq6YhMXiTPdx6CJi9kP5xDPAJeUBO0=;
 b=HijehJ3qcKt/5FyrKEai4U3e4cBDM6z18qLHxmkOFtCTSwDsN5EjBYu0Fe2DWWl/g0noMySL7P1I6ItDU+PUfjD2IQM0HsssfUa15R3mfBEUFrQhCT3DMRpQ8Xtj/BwNacb/ctLupJmBwjTd57l6XiIhPkO0U+8ZxRmGxAxa//0qe0msh726/YNFHyBBHxLrQSmSvqPuWjk0KSjivJF0qEdXU7b2bw0dmfWvvOenSp8khHoNHoQ9xX2MELeCb7M65J28VANaz7xl/7zBA4Pu3PlstOF6GNygUShCd9PJFZfwvsJ4vukbeQ8vXdrRIVvuejyFxiWUpMWVIWrPHlij+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:35:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 17:35:42 +0000
Date:   Wed, 23 Nov 2022 09:35:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <Y35Z6fB8Sm4JcPdK@iweiny-desk3>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
 <20221122155324.1878416-2-ira.weiny@intel.com>
 <20221122163426.0000467c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122163426.0000467c@Huawei.com>
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb47da8-9624-4e5a-ae89-08dacd792535
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeHa1sOh6SM2E3/gLWDsByHgS9AZl2fKyJuutXP+7uPS2z65iWBSUaIPLonEpd0+7H2VjlbGgqXaX2Im+xPXp6FG/mQKjrkzcIGmyVXJlpmLlaPO73Or1fQyIXJBcjiNoeZ71y9xXTkrtChn67bi+dGBu4lQYAd9ux4Af7W2/Ku02hbZp1isLw4PoShhHvt7sYTxo322QXtrsvn+83vpsIx6RIkWEnKUMdyobTIaEvtqVoh2yfbvzopy7vNj6DcMwbxQ3jC1v1JFj7uxZ0a6ywlB5OeinbAkNSFlqch4Cyrnrv7S70nmGa6aUTW7GhTPKBdltUNUvNyr37y6LTJ0aZ5/Gil/OkaO0gGHi7sozl7FT0ggDeaCstYwusepw1sExea3DchJ2uKAatLL48fdISvhgcngQgCWFHViGJPGkPG0ewCyLbE2rWCJkigwt9EzKZFcsQ6mBd1Q1Qvm4i/Ar28nxBmup/jAPieRA5kg5ZvItLvIoiajQFTCZJp0wyC+OnG5VW1M6UhHAQinmdO4/6ot1RBFoRZR6NKd4eIsVthsWO0veuu56SZON71pfOIeY3wRfil8BMvzCCQ7emQThBAwkuZu0Ka8Mhlv1IFJWu2vnl0yQXvfGB7WX7+84rrPDyd68Vs03fjffZhf4y1gPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(2906002)(5660300002)(86362001)(8936002)(41300700001)(9686003)(6512007)(66946007)(66476007)(8676002)(316002)(4326008)(83380400001)(33716001)(54906003)(66556008)(6916009)(44832011)(26005)(82960400001)(186003)(478600001)(38100700002)(6486002)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7X5lQAFkhznxvI6GroITbNvfAZEwKgF6SGjSI59uflu3nOiBx0vxdHZm4Tq?=
 =?us-ascii?Q?odCl0txEdOevemOunzseZuD/0E3aDfK+Gviegwow1+KfUi69jXgV1W7YfvIm?=
 =?us-ascii?Q?w3EerAIp/QwOq+f92iAP3AHwqoDTsBgff+4rtKOStAky63nkSF+HM6TbjANE?=
 =?us-ascii?Q?RKdO3k+rer/+bUIV5aAZOKsMNC8gfsFxFkZmW12Z1dmy/jaUz7jThpA7rlim?=
 =?us-ascii?Q?TUin+ZuudZgu4Kh8VgBtDZEPNNqdzhv5iPaO3UtuOZRd9k3Ad5eJEurLnZEc?=
 =?us-ascii?Q?r3J6yrZCWj9kRvosK/1AkRu1hsQMpLN24eltNsX0hwYWtSH75cCag+fQuhXi?=
 =?us-ascii?Q?vY0OtvjqBgZIgS5kAmwlS0HRKDeOc4S7P0VEmQuF4h+LAQzS2LcmvdBozooC?=
 =?us-ascii?Q?82PCSotbJ9OX5qaC+4eNfjrJ7Gbqs51a+umgvDG1hd2vnJGXszilZyQoRhvX?=
 =?us-ascii?Q?2iLqgnJrdMXZxLMM55JZO44wHY/TUV1dsc3ZIDAyP47V96piCXpj411KExhH?=
 =?us-ascii?Q?KAKlxpqcIQowiiXj8GVlTmJzTPZZxOPQy1JFhfk1GrCPAUlWYoALfaglT9jc?=
 =?us-ascii?Q?bj3TPX5DiZN/SouGy3HAd+v/HMZsmCFUCn0WhkYdfoUTTTOca+n+iSuU+zKp?=
 =?us-ascii?Q?kdqhEZtGCZVXxtuEffUWgxUDK45phqpSRH3U2sbnbZ0AP/fCJtkri9v4kalZ?=
 =?us-ascii?Q?9nKN00+3Sw1dURBt3zRXaW4oHTHVM20buvWkpMKujf4byWxbWDQD7IwTUGHb?=
 =?us-ascii?Q?f1D64jnvP4hm0hoDEgno9p4ounZQszKaWO30WF7zYePyOBMqq1kaBsG/dAoW?=
 =?us-ascii?Q?7TdSUqPdlRCabnsRTgl6nZTNFOFjNqjjkbhVedZ5PPG07R0p8+rTNwHB4jsN?=
 =?us-ascii?Q?aWhRAeW2JfAmt1l/ppZPQEDrPffQnmMAmsz6h38Kot/J6N73f4VGGFguCIbm?=
 =?us-ascii?Q?mWvZpOlivK6p1bO6R/AyNWr1MB5zPtZ021CH89VLFVlhq41RQ/fcXEZfppDt?=
 =?us-ascii?Q?GZt1ucQRwrYgYxsnpQlPtFmhnWxaiy25hNr7ULPW+TdzTAdTeFme/RWLRXYy?=
 =?us-ascii?Q?KLm8YMfqpxpN1brkbos0eC8Q9CC20mCSPYTESpZhSuYjVNtBukf7srEk7xLU?=
 =?us-ascii?Q?gLiJl95cp+CW6e3IX/NqOjJKsiol1FEhGvz+ctLZ8shGsrltnWsA5+J0Xkno?=
 =?us-ascii?Q?KYIQY9ck+W7qlGtIAJGeYYpqXhvWuRqy5BnqPv4LKfeEDmH4CpNu1cFgRwFV?=
 =?us-ascii?Q?5s72GHIszSEePrmXYLBA5EQ5MQejCXgf7B+QKP8MgYVeIdN44JjyUz5E6S5E?=
 =?us-ascii?Q?N+nXk2t67Hae3VfoZcHUit7fM40zWup7a62Z9pMTWVgtfjMTLpq3ubpnpeG/?=
 =?us-ascii?Q?QeOdOD0l/JnGlVWRWZNQZZR/K9rmDZM2SixljXzNhJ9tJng/j0iuwFXtNWrI?=
 =?us-ascii?Q?+2P4KX8V5srmKUrcxM6wlc5a9tEBXL3o8q5Dfj2dI+aJaoNc7I7C+l6X88hc?=
 =?us-ascii?Q?3zSIL/Mv8SQ6MTDwyBBEcYYgW+JpEB19A2lPgCi0R8gMO1igqoqhozZFi+wP?=
 =?us-ascii?Q?MmyfQR1yJMAsXIA0EldTX1E+UX7jal15AhBoRW5c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb47da8-9624-4e5a-ae89-08dacd792535
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:35:42.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r15XHWEyRXBziik57OBdeUb3qexkPAtgjhT/60muxXrgDkQF4nUAzqrp2YDbZScjaf1gsWvWBNkslaqgTYaJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 04:34:26PM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 07:53:23 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Each struct doe_mb is managed as part of the PCI device.  They can't go
> > away as long as the PCI device exists.  pci_doe_flush_mb() was set up to
> > flush the workqueue and prevent any further submissions to the mailboxes
> > when the PCI device goes away.  Unfortunately, this was fundamentally
> > flawed.  There was no guarantee that a struct doe_mb remained after
> > pci_doe_flush_mb() returned.  Therefore, the doe_mb state could be
> > invalid when those threads waiting on the workqueue were flushed.
> > 
> > Fortunately the current code is safe because all callers make a
> > synchronous call to pci_doe_submit_task() and maintain a reference on the
> > PCI device.
> > 
> > For these reasons, pci_doe_flush_mb() will never be called while tasks
> > are being processed and there is no use for it.
> > 
> > Remove the dead code around pci_doe_flush_mb().
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Looks fine I think, though one question inline.
>  
> > ---
> >  drivers/pci/doe.c | 48 ++++-------------------------------------------
> >  1 file changed, 4 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index e402f05068a5..260313e9052e 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -24,10 +24,9 @@
> >  
> >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> >  #define PCI_DOE_TIMEOUT HZ
> > -#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> > +#define PCI_DOE_POLL_INTERVAL	8
> 
> Why this change?  

msleep_interruptible() takes a millisecond value and wait_event_timeout() takes
jiffies.  1/128 of a second is ~8ms.

While for most configs (HZ == 1000) the value does not change.  I don't believe
this would be true for all configs.  Thus a more explicit define.

I'll add a comment.

Ira

> 
> >  
> > -#define PCI_DOE_FLAG_CANCEL	0
> > -#define PCI_DOE_FLAG_DEAD	1
> > +#define PCI_DOE_FLAG_DEAD	0
> >  
> >  /**
> >   * struct pci_doe_mb - State for a single DOE mailbox
> > @@ -53,15 +52,6 @@ struct pci_doe_mb {
> >  	unsigned long flags;
> >  };
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
> > @@ -82,12 +72,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> >  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> >  
> >  	do {
> > -		int rc;
> >  		u32 val;
> >  
> > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > -		if (rc)
> > -			return rc;
> > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
> >  		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> >  
> >  		/* Abort success! */
> > @@ -278,11 +265,7 @@ static void doe_statemachine_work(struct work_struct *work)
> >  			signal_task_abort(task, -EIO);
> >  			return;
> >  		}
> > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > -		if (rc) {
> > -			signal_task_abort(task, rc);
> > -			return;
> > -		}
> > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
> >  		goto retry_resp;
> >  	}
> >  
> > @@ -383,21 +366,6 @@ static void pci_doe_destroy_workqueue(void *mb)
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
> > @@ -450,14 +418,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
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
