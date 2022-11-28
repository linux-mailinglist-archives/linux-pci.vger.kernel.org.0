Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9A63B26C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiK1Tla (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 14:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiK1Tla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 14:41:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B2C120A7;
        Mon, 28 Nov 2022 11:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669664488; x=1701200488;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oXznrfMps2NX3NA/ZgD/XGDgMFM4KMx20BTcpsCP+Vc=;
  b=Wz67mXz03azo0jdY5UU2nO8v7ZElXtftX9X6B8C6LFHzIFzsfQYKw+Il
   1HzZd2lknlWJDtwQ9CoeQ3XMEP8c9w9d9NPpUwKAsykakcMUI8bwySWUO
   Qo2X7OCPo5YKtOeuO5PWaK/TUIoQHPzqHgQsC8Wd4wg739Fw/nJbz3yNI
   yV2BUjdc4FZW4uGY4TbzRbOM+2mNceseQ11taF0HiLBQLB/nQPv+XoPf/
   GaK6AiewDmvoTw+jk10HtLiC2mNgz/HVfyj9bwdBko00A3Dg/qNx0gYZo
   mnCpfU3uXzhRmvSo7HSeDobN7sj1jAKg8jkb7GWkSNEUnC9ppbn7PJJcD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379193614"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379193614"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643516188"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643516188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 11:41:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 11:41:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 11:41:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 11:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnsJFWBF64j9o+Kgok0wdBaViVnF7NgLIUy9AMUNzBSu+JRVvRgvwktwuq5Ic7XzMv709BtI5+G/YNFOj7UDhRAyNyl++0ufMAdFgmfYlKzDBNeWxJRB5gaz0jPtASLEpfMDoYNvgVjRDPgG28/V8KaGogwop6hgXhF6sK5eaRNGA5eMWnwb0wyWrjTMHc0wU7SqD/aY+elgJ2olopnAn9Zmp6I8+iMiHCAtdx6tTW6Z5kmKlsrZYpAD0CdGdfZJ8N33pBsDEsEtmCZ2R4tQkzGCIQkZJ+OZy6UWdvgFLZuw5IKmeUhi9k0uGKFoMHt4Q8F/LNXJZRVCnjVkJriNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy7yPznRnOsaw60+2x5xkkeF91u0N8f5H+RI3YySmaY=;
 b=BwSVUq3mk2ihuQfUEP7TYxq1LQBQcyVzQEJmQBVbuxFEZpRi4mp31Tvvpcw7+9Y5OnlQaOQKdXXDRS9Nmiazim4MtrT2wGYE1sOEtVko9t1HkM+RE6T7Qaq7HfcMeCtd2jXmN0fpnIMgJOeDYo+orbM3CemnwOuwZht4h4NH5phHKUpxfP5e8pzqgRFpe+q36mvJgGwQ2TwtvqM020CdreYPvKHrIHu3irHaw4+159xam+DRdmZsdzP/3O5E+cUgHe4NynlHkDVjZnL8VePh9cjd8+F4WvTl7AKa7gq0red7jgoLswwml+EkkjMhGOe2cnjQwHYUKD1JgF64x9EzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 19:41:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 19:41:25 +0000
Date:   Mon, 28 Nov 2022 11:41:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <Y4UO31CATnHACtSi@iweiny-desk3>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128040338.1936529-2-ira.weiny@intel.com>
 <Y4T1M7vAuHdMcNiy@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4T1M7vAuHdMcNiy@aschofie-mobl2>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 75484636-9554-4ecb-8d2e-08dad1788928
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGw8KOXFBmmzay40ldRd9Lvlwa3UIsf6NLUBjqyRPsVQAiBMmlZWIaN4jJhsygEPGSALPijav/r4W92v4Mx3aHrcZwSePBBBsBr637qH/whKwntUlsxJUYpcWCWfJUmNqCUtAVCRxWKLUWqr7APbBZkuMZBYCaC2f9cA6MG5Jie604EWlr5SO67YDgIuDn1LeZqviBDdSMOqg9eTa0XufHCxsZ9wHJQt9MGOeUCV3l+I4YnX81fl/4M2F+T5QesGnJB2Z4P9FU61vegPxXeqJUITqDPJD94tZX32FusoG1UuhIpFbn4CvHh23GqmTzIwv6wmzv8zkx/frIIFvjMvZ9CsZAFaRfTrwvYQpFtLTLTNStTVCJiY0roHDcACvquuHO6UHNoN6l84ASnpsnws32N57ATaA0SXEHIvMmcQ8W2RsFygNYMpo8ccG8ZXVHFZVpRPT5UkdC3sRy53bYL3GGkepCrPwTlhKTGwy+B6r2WzFnDpbc3OPHQrKHjBa6J2YwGTtE5JsuLlJKOAHsqbDLEMdBg8F4Pqy8WeJgShaIGwhWBdAA7STdLie4yR/5AUFKkZdMWIvrb5IMW5c4kX/zOE+V7X+7FYMkpJk8hwrkvHkuEbrYL7Sr4KnlsWr8UJsBnBzGr/7wW7CtFSeDdmRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(83380400001)(54906003)(6666004)(6506007)(6486002)(6512007)(86362001)(9686003)(38100700002)(26005)(82960400001)(186003)(33716001)(66476007)(8936002)(44832011)(5660300002)(6862004)(8676002)(6636002)(478600001)(41300700001)(66946007)(316002)(4326008)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsQuE5P2mnRjnQQsThuKEnmc8J9sHGsbukJwxMZwOoQP5M332FOtf2l19lgu?=
 =?us-ascii?Q?7iQbjJS4cjxeKE8eO03Nv7IrZuLLIeTtgnv16ZyA7qgabd6PafCVV7OiYd/J?=
 =?us-ascii?Q?yhBQZ8LBDo0qXPhnYNREwzkvlGBId5vlMrM6TkHJ+1S4qyW+tOWzZDbOugt2?=
 =?us-ascii?Q?U4iqo7Gqt9AhsK9jZd0jrYh9FPl5cKIPQ/ad67hle7yCoYRWxbBG3MTDR0gM?=
 =?us-ascii?Q?7FR0TxgbkiKE0CM0ZayuFxrvuevVDwdSc4JTpoOMM8JHyPqtlcQBKFv6hG+L?=
 =?us-ascii?Q?IBF2Rbu2jPzcTgDeiFILdcO5EFS20jB1b8Z4lITc/4dmR32NNnc8tVvkdBj6?=
 =?us-ascii?Q?HhBQAD0KO1hMr1ZKPCdjctAW3oiUFkAJHAUrYt9Riw5y9Uic8H7lS5rJTmev?=
 =?us-ascii?Q?ZcKrxHU2r+wL1Oo06o+Zk+n+g863jA5pEJ969r45mtipY6XK46aFsp7j4BOc?=
 =?us-ascii?Q?HbJJuf5DpaPVroDJHXswhZYW22iuljOTTV0v6Mnzc7inKF/1hKXrhq3rzvpR?=
 =?us-ascii?Q?MrQwOWuBdbik2yUT9Qc8Kk6TWA5Aq5Rdq7X574sY26St9T+eZESzDKBTrHJS?=
 =?us-ascii?Q?5H9WqsjMY1vdjWVByBZS0eVNj8Mgw8XNUjTwMzbjImfAuZrqS1Uc5HswAJ2W?=
 =?us-ascii?Q?bK4oKC0Mv95lxa9ms5NQk+OOTk+eg/CILznO+jVT2vMOBsIQImIhSvq4ZfZ7?=
 =?us-ascii?Q?1wY4SX/mOXY9YSAMWUGEmss8As8/IdJTPU1IVC7uRp1WmWfr8tFovVlR62jt?=
 =?us-ascii?Q?JVeJmzIfJnZkxPe5+/Qdcig1BY+n0f5apVuaMtQrGrMoCiqBiiDteYHAkWlL?=
 =?us-ascii?Q?/mHD4aY1hqMS+D1nLUPAJdIwAZtohQgJvArpgnvzvb+zp/EqRyXG8axecrJt?=
 =?us-ascii?Q?e2ZFE/+WuvOBpwui5LKY2Igpa4sy0yfEUwRC2qZXXyNMUdg84zT5Bghoa/m9?=
 =?us-ascii?Q?3mkoJawYsc9a1jl4MSwrWFrWcWV+dlQFY+cb92U3Vy7b2T3mQltC+PCUiBrp?=
 =?us-ascii?Q?5D9AE6UW18aziTvbkDy462HeIbNIkyXpUvXvOZtxLbuG5EziVgEQkE7mL9lI?=
 =?us-ascii?Q?r1rf+XbAN+NnMpi+RgvgE/OoGwaEsN4pmuxmD8RXaU3G6lDJnlpLqzhxjYDe?=
 =?us-ascii?Q?YP4334TJyV3EgAbj51lJ0Br3wpRVlmllIW7m3gfRn171s3DISL//pEupiYyK?=
 =?us-ascii?Q?IERSNCw66RHnbjkefH8h0KR2GqXU5mjWKMiqS+YvFEOR1U5yF0GLzjN/tagM?=
 =?us-ascii?Q?MF4LZTXr55ZmqifaaGnBSOFx/RF3YJ0Eo6AJrg3kL5XjJzqTFilqipITqN6V?=
 =?us-ascii?Q?M+P+/7ssiFOS/UAvgdmr1rdm3UqJpveP013y6NRw2gW4zPd1dHPRkVEhQL/6?=
 =?us-ascii?Q?iD3Q76P4H8GcONuFSQdxy7ajgmiMaRqdpGmNsQ4MXGqRgbkeePGaevNX8aNh?=
 =?us-ascii?Q?brJ4tXYwXsHCrk1ivSqMAAMhUBAI1/clSGboTUl9n7HMR0iavrTzHoZUAdBJ?=
 =?us-ascii?Q?h5qJfDvN+DL5zKXgLAmTVpQRQoLUcNGdlddz+R1T4npmIapqWBLspzJd78n6?=
 =?us-ascii?Q?Mvz0zzu2eoSrNsd6AcbG399yRdpmuFt39IUjw9Zs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75484636-9554-4ecb-8d2e-08dad1788928
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 19:41:25.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSHZGXkZUHKG6z8DptFaWLFXVVq5J6yQitWql02vyJkWko4KdkQMJxBu8eeWO9O2hVvBQ5VBS2XHJA2oukB5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 09:51:47AM -0800, Alison Schofield wrote:
> On Sun, Nov 27, 2022 at 08:03:37PM -0800, Ira Weiny wrote:
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
> 
> The commit message says "Remove ...." and the commit log only
> talks about removing code, yet an msleep() is added.
> Can those be clearer?

:-/

I'm struggling a bit with this comment.  The patch focus is on removing an
unneeded and effectively unused function.  (It is called but not in a way that
would cause any running task to be aborted.)  The replacement of pci_doe_wait()
with msleep_interruptible() is a side effect and I don't think belongs in the
one liner.

I suppose something like this might work?

PCI/DOE: Replace broken task cancellation with msleep

I guess that makes some sense.  Combined with Ming's suggestion we are still
allowing task cancellation but from a signal rather than PCI device removal.

Ira

> 
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V2:
> > 	Lukas
> > 		Clarify commit message.
> > 	Jonathan
> > 		Add comment for changed poll interval.
> > ---
> >  drivers/pci/doe.c | 49 +++++------------------------------------------
> >  1 file changed, 5 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index e402f05068a5..685e7d26c7eb 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -24,10 +24,10 @@
> >  
> >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> >  #define PCI_DOE_TIMEOUT HZ
> > -#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> > +/* Interval to poll mailbox status */
> > +#define PCI_DOE_POLL_INTERVAL_MSECS	8
> >  
> > -#define PCI_DOE_FLAG_CANCEL	0
> > -#define PCI_DOE_FLAG_DEAD	1
> > +#define PCI_DOE_FLAG_DEAD	0
> >  
> >  /**
> >   * struct pci_doe_mb - State for a single DOE mailbox
> > @@ -53,15 +53,6 @@ struct pci_doe_mb {
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
> > -- 
> > 2.37.2
> > 
