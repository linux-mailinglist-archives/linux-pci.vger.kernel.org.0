Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8DA64F327
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiLPV2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 16:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPV2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 16:28:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992B61D68;
        Fri, 16 Dec 2022 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671226125; x=1702762125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mhn6z1ib+rFD4AiOR0u6EFjuejS1/S2njsMFGu8C/RQ=;
  b=AeZyMQuBL8gbAw6Il7lvG0E8PFNhn3qkiSMfxgiujWehNq0bAX5xvawo
   7a03XTgLVFixxMvxafJ8fdVS8swWKAZk8XLa4mNRS1pL7k4r9kVUpVr1n
   bBe/yn0AiYtLpnald1FIgURMgh0UH6VmiCpag/z4OoLMFFe269xrUVOXP
   Fye/yyKCnV4rB0t1N+a/oezsOcZdHcCx1WODXtSzuPGNT6xcOle4Af0i8
   /0z2vguqZmkHChyGPcuM8HYZBDcrnIgyLmUFFJE6sPOKTQ8SokZU04R+u
   EPtzJAPuYDPADB6/CjNynSQFDW89K7QrgnPqZAv5ZR8jevVfih7KblMf/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320233301"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="320233301"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 13:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="718505694"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="718505694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2022 13:28:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:28:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 13:28:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 13:28:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVw0Up7W8f81eEpbMgoZu+9+8H/IgcXVM7Z0XqwAx2RLMNqjNEvU+3QXr4c74gQm2EhIVMw5CBymQ1vQCiTHUT7xmpK+qbLuKX8CFN/i3BeGaE6a/SK7RBPUfxjc0X9dETJe+SVJu6lRx+NOCoJvygQG1OO+O52FDLoYtM/c0cSHwAIQewFhWSxgGj+LtDiR/eVIv/neBm7n3JNYHhEDbUMjGgRi2sm5C47kxh9/lk3Oo3zBGFpWS3yOC6TdppCdwVvqJiUWgDAsJnjuN3cRX7XwRa/ydr6+FqWFV9jGBb5vCyJVYSXbzvzTG3eajkQSdbLA4RE84IqXPfYAKHmJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwB+XAnxGcl/cKz068aJ3XqobZcZdNZq1TAqguBsG6U=;
 b=jynbJ4rHaA0rjhBTDPXsiV6sGZaTMFZo1xu2NIvfRn0IXs8+YF7ypnGgY91qjlFugdkFzyzGx5ZQ+ztrLsdWZSDVQcB/poTlMsLcrhryBYWyMJE5PG+daA4Pda/eTs5fDf7wsc22pcAx9nxnyGEZte/GTNn3rNxqu6Y2Z0gJvnHGa4eoPLSjHrYkW7vwTz0H2k/sqD5+SS5MO18iYZLzk2cOvcBi2r6ajMsxSUFEB6VBD8oAVuVHyLonEHGFrmsNW9cZR6HE2M8LVMHmhhw4702mmFcimDOBNHriAl8SGh1OIBmmzLl4efB1Cgvdh/xaue3Vi/OF1DUW54KebnJ/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 21:28:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 21:28:40 +0000
Date:   Fri, 16 Dec 2022 13:28:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 3/9] cxl/mem: Wire up event interrupts
Message-ID: <Y5zjBD6j4b3dBreR@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-4-ira.weiny@intel.com>
 <20221216142438.00006588@Huawei.com>
 <20221216184215.000015dd@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216184215.000015dd@Huawei.com>
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: da20bbdb-e85f-43b0-0e47-08dadfac7ff6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDG/EOLWTKhHW+cCfF6VZizRIYYJT27WD18FzI7EdBwlYt7YgUs+hslXPBYhuTbMXSa186ZGeSpgxOS+nzPBAQurtj6q3RWMsG6e62I/66k+BUijDEae6eclKhi0GmKLvvhI9SWEQXez3/hNg6zh9EoLi2fCHL/z14DsMEhDM/GOZ/GE5fHQOMBrLmQWqukQKUlUv6BbTHBxk7qMQhv75j2OjQNYXhivfmqhpkkes8AQWeoBOr2zwnDRKm0fXGNraxxdXhfxJVW30bHt7XnV+1hIf1l3ub/7r1RrP8ZEsHIcgQJMpmsOAUJlrq1hBEM2o3qB6rvcO64w64/Z68yvQ5WRCViCxLQpQoy55JCFZ7orVvIlIYW69NPjfmKV0BiGuqrN1/YShHFtbpKfdnLHa/1kkxW765sjcvG8kq1tTBKcBKQS2CvlXBCmy2XohJE7zlIaZy2Q/1sh7ku6BqTV3dZJN5My7RDY58LfNDYHzKnEsfyRyWtvzSD2MIX9qW0DhyAhPiXvRFprW7tJzLfTkZXHbHPArC+gUuqhtIsJF5Rzk94gr1phNX5Fyl57on1OWl3i4UpUDoI+ExAf8k0qNaDLLHIr1GcvkFJv5u5X7GrBOdt3+XKVRgafxTocKMmSQXqZUNp13P5KWnphFlcg6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(44832011)(82960400001)(38100700002)(2906002)(478600001)(83380400001)(186003)(33716001)(6506007)(6666004)(9686003)(6512007)(26005)(8936002)(4326008)(41300700001)(6916009)(8676002)(5660300002)(54906003)(66476007)(66556008)(66946007)(6486002)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Z92UzWk5GbCXF11wMxcDTAPAfb1Wwm2i3XaI0fGS8nqubSfMCMrr7kxHE90?=
 =?us-ascii?Q?Ykjj485xAe1obhU/DBTcd2C1o0Er2bRujyzONun99YeZK2hnIOvJAco0CS+1?=
 =?us-ascii?Q?hYPGixpftKFinR3O13flrpswYINk4GsxgT6Zc0aRvN5gcQ0z3gacQ59ZF4XD?=
 =?us-ascii?Q?I+b6PDCYh4tz7Tsut9KurPtRnK0F9fX6RCgS0f7p/Q9nScBm1Dm6+xhTczHl?=
 =?us-ascii?Q?Qy3hjqFqb442vh3/MeYhGIMNNjKl8bxWbL7xv9jJ7mkMunwjCqhgAdsYsbz5?=
 =?us-ascii?Q?jrVzIgBsn+fpLvvhheVyG40x2HEALDX+YhX/Em+66jsA1+3phuEKqadmM2di?=
 =?us-ascii?Q?FfNBqlLSxr7E5Dck1z0uxFpmzO7DF93x7gGL6n9paz4RpTSAMa5G0PkraOvs?=
 =?us-ascii?Q?jIVHP8BNfGja01C0fd5xKE+NmteK33nMD15H1QctuSzFmugMOvjQPhtuFQP2?=
 =?us-ascii?Q?IH0TeYJZtS7SkepXy0fMbhxVRsYOM+z6g12hSJsFI0gc+S/4b6q9us7Zlfjq?=
 =?us-ascii?Q?cegm/n2xpC1TTpX62hUKhjHq4VChEzXGLPfzJnEEBYMDU7MdeYUhgebDv71Y?=
 =?us-ascii?Q?rf+QyXcokMKqbhXNcU2VZNmihPJxZSGEnmgaMfHhKORiW/yQB1pwdpDxKkQD?=
 =?us-ascii?Q?yc/JN74AHUCNuItZMIaCgbrBZCYkTl2ulRL/YKqau3naGCb944+9+RK8l9fe?=
 =?us-ascii?Q?i9SRKe3VIS5+HKaRSiYplIecn31bkAhQYW39Qm1ePGPlW7T3IkzEiBJncjwu?=
 =?us-ascii?Q?af1M5csMlJ62JFEKu9kuj6KJi1cY2o+VSqZY3AP9bDEYYCs9F3f4D8blKJGN?=
 =?us-ascii?Q?ZhObdblSi7bGYLcvRc5IKHZ9W5mj/eHC5qsSewVgoinXBrJUy2xbqiiOlE5l?=
 =?us-ascii?Q?V7k8lppztrpkqilr9t/ZClmFF5LouvbiALYuaPFLvq7tdp0QyNgB6Q9TMiRj?=
 =?us-ascii?Q?KM0knvzOmqgQ4fQ3p51fE7ke4HhXqz3n2ujRTMj9xNiyKX3mZODvSKAmqGxH?=
 =?us-ascii?Q?xOZP4frmiSAEWhMp/xuDKAOMQTsptEizI81VoFUB/wBe94CqXJ2Wu9cQ342I?=
 =?us-ascii?Q?xRIU6Dl35HPUsgsnM5Z4Egaj8EN1Exhl8nJEKwIxVb8rdfo+nyKGcwU+0EUm?=
 =?us-ascii?Q?DVHG0qbacPVUPbyelprMQrxLyH29VF3i46WBKO5oOM4Zdp33S2nI/re14KDr?=
 =?us-ascii?Q?MgnsJFISdEspjctv/nKSd0Yb+lOIA1G9z4fI7d+Ek6m2ZYchK+YSBD5V8/1q?=
 =?us-ascii?Q?vxwzpe9rXrgBZEO3jJnPkBNIT0HrQBp0CSk2c6i7EEVq+zzJF7RQ6I/YgIFP?=
 =?us-ascii?Q?7yni1kRjGkDbob9+iMyIW9UngFfuZr5DE0biaK89mIavMAWq0JxKKg6x+V3q?=
 =?us-ascii?Q?ynVEKGbpFpRAitF9BTmK1NFvnlE809a1zuX2VEQDZgG+x5rpCLnphdpHi629?=
 =?us-ascii?Q?IW4jWJEt0jA1bqI9AzkYXlDy1tKCjzsZMlBK6YAw1FZzOpdFXPqKSfJMQdmp?=
 =?us-ascii?Q?Y8fC+wSUmyC/1gAK26RrXbtqQdtN5braL1AKkoJ5zKP21pszrvyzz1PF0iDI?=
 =?us-ascii?Q?YUPMDxL5camgPwYHPG3C5TLQ8bd+4f7Ls3jUX1QW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da20bbdb-e85f-43b0-0e47-08dadfac7ff6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 21:28:40.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIqrMBiZ3Gq6nmZkOR0VSVa6z6AHQzWU19rhozlLkDWitYSEI2bB+d/1Rvt2uVxLd2/6q2ybsjZw74ksZBr6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
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

On Fri, Dec 16, 2022 at 06:42:15PM +0000, Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 14:24:38 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Sun, 11 Dec 2022 23:06:21 -0800
> > ira.weiny@intel.com wrote:
> > 
> > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > Currently the only CXL features targeted for irq support require their
> > > message numbers to be within the first 16 entries.  The device may
> > > however support less than 16 entries depending on the support it
> > > provides.
> > > 
> > > Attempt to allocate these 16 irq vectors.  If the device supports less
> > > then the PCI infrastructure will allocate that number.  Upon successful
> > > allocation, users can plug in their respective isr at any point
> > > thereafter.
> > > 
> > > CXL device events are signaled via interrupts.  Each event log may have
> > > a different interrupt message number.  These message numbers are
> > > reported in the Get Event Interrupt Policy mailbox command.
> > > 
> > > Add interrupt support for event logs.  Interrupts are allocated as
> > > shared interrupts.  Therefore, all or some event logs can share the same
> > > message number.
> > > 
> > > In addition all logs are queried on any interrupt in order of the most
> > > to least severe based on the status register.
> > > 
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > >   
> > 
> > > +/**
> > > + * Event Interrupt Policy
> > > + *
> > > + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> > > + */
> > > +enum cxl_event_int_mode {
> > > +	CXL_INT_NONE		= 0x00,
> > > +	CXL_INT_MSI_MSIX	= 0x01,
> > > +	CXL_INT_FW		= 0x02
> > > +};
> > > +struct cxl_event_interrupt_policy {
> > > +	u8 info_settings;
> > > +	u8 warn_settings;
> > > +	u8 failure_settings;
> > > +	u8 fatal_settings;  
> > 
> > This is an issue for your QEMU code which has this set at 5 bytes.
> > Guess our handling of record lengths needs updating now we have two different
> > spec versions to support and hence these can have multiple lengths.
> > 
> > Btw, do you have an updated version of the QEMU patches you can share?
> 
> Note that I'm happy to take your QEMU series forwards, just don't want to duplicate
> stuff you have already done!

I do have updates to handle more than 3 records at a time which I was polishing
until I saw your review.

I was getting all geared up to respin the patches but I'm not sure there is an
issue now that I look at it.

I'm still investigating.

Ira

> 
> Jonathan
> 
> > I was planning on just doing the AER type RAS stuff for the first pull this cycle
> > but given this set means we never reach that code I probably need to do QEMU
> > support for this and the stuff to support those all in one go - otherwise
> > no one will be able to test it :)  We rather optimistically have the OSC set
> > to say the OS can have control of these, but upstream code doesn't emulate
> > anything yet. Oops. Should have pretended the hardware was handling them
> > until we had this support in place in QEMU.
> > 
> > Jonathan
> > 
> > > +} __packed;
> > > +
> > >  /**
> > >   * struct cxl_event_state - Event log driver state
> > >   *
> > > @@ -288,6 +305,8 @@ enum cxl_opcode {
> > >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > >  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> > > +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> > > +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
> > >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> > >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> > >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,  
> 
