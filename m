Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0C56104E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 06:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiF3Efr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 00:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3Efp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 00:35:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BDF237CA;
        Wed, 29 Jun 2022 21:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656563744; x=1688099744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EAMPDfP/xAw0Apg8poEL83N9kyPeURavxQZnJ6Iqv0s=;
  b=eVMktIJ1y5pmImh2X0XtkgSxUBmbD9AauhW1/hifDvMgfEYp1yJmk8/2
   X2uMfnSb989lxtxu/5bVkiKlCRvEvyLzO3HcYQY2Qls9ix0xdBJiwPfP5
   6UBID0YX6/lBDPRvWELRNb9r28v4Po1r8J/pAdErQqUWL/IKoRvLeP4i2
   m3AoLvZYjngWlxQw0x30FVv9RLLgKBz5ym8ifTqqAq++UQF7w0MBNjGkr
   I0IuIEnXXFl8Hza1OK47n5auykzYVZ2VxthJmIu+iJyg6wNlj08C+0/az
   SdR2mdhCfveEXmD7eC8fu4YiGUJfec/eYfWU9a7wWVJxD/1noFwNsI0TI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282273558"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="282273558"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 21:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="680808804"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2022 21:34:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 21:34:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 21:34:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 21:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej9RRdMABgsYV05ieqz5DqLGKF02uplcXAw93OSqwOb3pJJNHn/exTcp/gySKEsDRn9jL8K2OOw3KDhrxf0itnH4ES+1E1eSuYTnYj2qMG5I1rENmh6hHJGblFuPoT60D2/0IMOUHN1F4Ey8LIrL719+bN5qD8ph/WiOw4ciV7qKqbGYDVJfiVny4Oh/Uovjaw2fD8XO1JiAzt/g+r0DE0aiFIKagbWdrZwT05r2AjtaU275J/B3Eh3dMq3lGbeb5VCEwKywqtlvunR1V/MJvTYg6KdwhKJfU8BT7VGcseQsXXVnbSYaS9IrKS5HRArDHbVyNJo8pue2WODWL/UozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jprRHGITfaHHWNmAKjy5aALJ5UUV7dEH7aP7uwx8mhk=;
 b=L10BFLBRAHmmNZutgL5NAmWFZlsRPf4Wz9XkAsprTSIRyqgBaWGZYJykRo+zyoBHqdCM/cKijHr/xU3CXYTetgp/W8GLgGpsobGaR3S31Fy2DHd8138IxylGQNjcGD5mqOLzzJfKFACr8QCRc/2nSaGKLfiI3vc9sv8HrOJj29n0w/rsriq/WPYuMaQBHi1NZqdDtyZgz5Xn8J9eBVB2rfRqqwfVKWH9fPr3gX8zrBHtY0dqxVFWhfcjqra4Om/Eal4ea0Xy4XXteWZBTdH04BVLzzeE2MImNPLCLYH0paz1yU6XlK4wCj1iN/bDOfEGBtQpjj07uxHfQUMa5oalGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SN6PR11MB3341.namprd11.prod.outlook.com (2603:10b6:805:bc::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 04:34:26 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 04:34:25 +0000
Date:   Wed, 29 Jun 2022 21:34:18 -0700
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
Message-ID: <Yr0nysRl7x49me1K@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628151626.00001c0f@Huawei.com>
 <YrtGcNWcmzumj2gA@iweiny-desk3>
 <20220629150947.000012be@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629150947.000012be@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc989400-ff7d-46b0-d62a-08da5a51cfc8
X-MS-TrafficTypeDiagnostic: SN6PR11MB3341:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WzmCAyfbuHICi0MPgBlXVAe0/HYpFQx6Jk8HFJetlKptsjVJx9MkCulSRoj+vJaHk7c/VtUDriolwOq4kacGtEbaQdwosdLovaHt1p5ZbKCCf4KVMJmgu82IoiQKWwBfbMTEvKTA71Ux+Wq9ue5fG3wzQ3FbWaQV8S5bVhH/sFBipXxrQUZODSeFgYm0g11iikgivJCDCtl+6CtJjCw68dYUp+g8C7gafEsFUW0R2u0/dU8i/qJoZNyj08LrO7hzZEqYLjFBMudqPTg5ErJLz2kgenZrPi5/svzjo3KbQrK/miz6oti7w432Wz79yf3HI9QdoG7N2DyWiEMJkCqx94IRr79Ja3G8o3rtYF2bJlpxd46oytTVtS+Xqoi7Wcf3hndt1sxBftkGhPtoBVeK3+lXwRM1aUQ/3v9vDj88GBaXBLU9x5ZlbkMzMxurO2qF0qpeGFD+wMGPr8g6aitTUsdrGOOIoIqQN8zZWvfFy87+t6BJaM5CetSS00dZVdEeRBVayAjI7iycWxZnAkedEClsHDD0PERjt6QlfasM6iYUHhTKoG+8ZxIDI6eY0CT9uMlfZtEVExRPbOMgnTr/USnVRiBuIns+a5IEJ1pvsPByayy8MhlqMwcFpncznt4V16W/yeKv18JMm2wK7rBXuNX6I139xpPsRle1V0mnPEU30riHbkhpuKZovTpKRRzMAGXRJdbcFv3dJ6o7oD/pD2xbJajoGizUKcquEVTSAZBbFBhG35GOQ7RGMj+00xo9kIvt75UO9twwQfOIAjDNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(6486002)(316002)(4326008)(5660300002)(41300700001)(86362001)(6916009)(54906003)(44832011)(30864003)(66556008)(8676002)(478600001)(66946007)(66476007)(8936002)(2906002)(82960400001)(6506007)(6666004)(38100700002)(9686003)(6512007)(15650500001)(33716001)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmMxYDDMLFvIOypbXahCBXbRg8tie2Nfv+UTP/L2IFzNreYgs6pFCsJGxEO/?=
 =?us-ascii?Q?bU5hsCj9y4cfZOe7gt6BMAz0XdPtsY4ko4b1ocXiE6SSHi10Lniz5aYEMjSy?=
 =?us-ascii?Q?WsEKWLZKpaHkURC6fSbJnXfAoVvY1yqHZprRbykbMKc0o8tiFHQKaa+CJMg9?=
 =?us-ascii?Q?TQU7tErqHqskpyiNX9g+9HDwVPt6nTB3DAxyfyvdUhb/PPxqW0OD1aEW+nAV?=
 =?us-ascii?Q?qkwmEZ6zQyN2lEbrd4YQfXxoE4a5fbPR3rPrxLksiHqit8r2KDjVv/+o4R9L?=
 =?us-ascii?Q?1FrQs7qMDmU5Ynir045KE/HdJy49OYYl2eyNgwfmazgqMzD38QkTzFxKicp+?=
 =?us-ascii?Q?txPFWa05pvNOc4mjlsHVOAeU1q/OzxN2NqVvvd3wFJRFWDf0zlsoqJtpV532?=
 =?us-ascii?Q?OjP1AoVL2yqsI4yImvRDQ/SsxiD+IE2P322Vi770Iuf4nGI5nv80jttCQBRl?=
 =?us-ascii?Q?bp+JV80moEt7+g/CHkC87NzMul0wm1H/dmH1tuaAsEKv4xoZbX4JrghideNu?=
 =?us-ascii?Q?t9B4V37mGsUOhs3tYtmPskVDh5xRHxr9gGq5euwPHBoZgZq5zSsZSeyGJW4T?=
 =?us-ascii?Q?HHwA94JBhhdqeG+/lGNBugyZULyxGmAjanj8Dyg8OakKfgVVNDtk1t58tH1p?=
 =?us-ascii?Q?hDlTh4hNOIgxbJYNZh6QikoNDYNCCMNKaTOOSkCZcihKZOeeYewerlHlgaHD?=
 =?us-ascii?Q?Gk+mT0jj/PHi+ije6NUVmabOJAaUmLQKXw5zL3s6Hc+RGL0N7oxSCU83PcPQ?=
 =?us-ascii?Q?1BUC3kLdRcNpn4GT5moauJJvwLTpz5rQ9z2Qhs8XboGv8EQGzbPadvJKNIe0?=
 =?us-ascii?Q?wFFgix9aaa05uEwvpeoIwyo8REfNMPrNw4sTVizcpFvzWcnpldQyLQ3nyI84?=
 =?us-ascii?Q?dcaCJ2K/Uoiv39Ym8PmaftuCZBiaD/V2HTBClyN4m0zO+TtFD20Zgv++5LmY?=
 =?us-ascii?Q?GBBCgGtbPT4wt3wOEixQB/Ae6QfmM7Sn/+qhQbto0porRGd5JdNtgSXjNlLc?=
 =?us-ascii?Q?4QliPDd5uyFw9quVk+Vxz2clPYtGX5lRcZ1E7FZbM8luL9+ZFnchUlDE7/UF?=
 =?us-ascii?Q?vH9QWE+knr98DYuAxiS6QKw9ymqlhf9xC1+fG4WQ4QiW1pvyjtPnFsvZUtuk?=
 =?us-ascii?Q?hTXbxnvHZ46PNRT3YPo+d9xboneEWG0gJANq8y3FTkg9NTAFBp5kulMZkiZa?=
 =?us-ascii?Q?eD0iRy/qjQqY8jelx4N2SltbmjYOHHWg9p7hvRADnWwstLqgy5y3nsUijO/Z?=
 =?us-ascii?Q?Iya6DeIGREj7k0Q9WkqDdodnhvmieiq6UOBGBq6pdLrw2BJwsRjx3+N+qVry?=
 =?us-ascii?Q?ejjegBgPZBFIse0wzA5HMx5h5AreoOtrUOFrqiGHkcCs1uYBSK4tQgg4zX3x?=
 =?us-ascii?Q?eKewwy+uEc6IsiG4cV156hnPIZI7fcJravNVxRUcb0UzSCPyHNltEtuPSovN?=
 =?us-ascii?Q?N7v+v4qQVmVfuV2GoYHCnyngRc8h0/LVHcTNYme4knXExSfyXNah2jlK9jgO?=
 =?us-ascii?Q?JlcwUWjcW55jdgxCLIuT/xgvP1IGd40JPknDrs2Y8AcqDCVQHQWGEeExWKYZ?=
 =?us-ascii?Q?3OXjOEg4trVjb8CaLMf4ToIF79BiNHIrVW45ju+iUN7VN+EBy7MPwvam2OlX?=
 =?us-ascii?Q?U87szsFQnk9avBA8CQVF7bl5rfGKvx5vfyCMUkEaA7+T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc989400-ff7d-46b0-d62a-08da5a51cfc8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 04:34:25.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3ze9/AQL59Kxh4cUuagoKPSnRK1Fksjm6dl7QPJirgXUiGYMOvHwbxLfEFqvV6xLNoEcD84gqFmYfVLK2G9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 03:09:47PM +0100, Jonathan Cameron wrote:
> On Tue, 28 Jun 2022 11:20:32 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > > >   
> > > Hi Ira,
> > > 
> > > Thanks for keeping at this!
> > > 
> > > I think this has reintroduced some of the races around that annoying
> > > interrupt source form BUSY transitioning to low that has
> > > no explicit 'cause' flag.  I think we'd hammered all those out in the
> > > previous version but maybe there were still some there...  
> > 
> > Well I really tried hard not to introduce races which would be a problem.  But
> > I would not be surprised.
> > 
> > > 
> > > I 'think' it will work as is, but depending on the timing a given DOE
> > > implementation has, the interrupt may be completely pointless as it
> > > will be signaling the wrong event.  
> > 
> > :-/
> > 
> > There is a chance that an IRQ comes in just after we timeout waiting for it.  I
> > think that has always been the case and the IRQ will effectively be missed I
> > _think_.
> 
> The timeout case I'm not that worried about as it means the device
> is out of spec, so whilst it might happen and we don't want to break in that
> case it should be uncommon enough that a perf disadvantage doesn't matter.

Ok I think we are agreed here.

I've removed the irq stuff for now per the call yesterday.  But I'm still
interested in how to solve the problem so see below.

> 
> 
> ...
> 
> > > > +
> > > > +static void doe_statemachine_work(struct work_struct *work)
> > > > +{
> > > > +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > > > +						 work);
> > > > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > > +	int offset = doe_mb->cap_offset;
> > > > +	unsigned int busy_retries = 0;
> > > > +	unsigned long timeout_jiffies;
> > > > +	u32 val;
> > > > +	int rc;
> > > > +
> > > > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > > > +		signal_task_complete(task, -EIO);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/* Send request */
> > > > +retry_req:
> > > > +	if (pci_doe_arm_wait(doe_mb)) {
> > > > +		signal_task_abort(task, -EIO);
> > > > +		return;
> > > > +	}  
> > > 
> > > Is there a race here?  If Busy drops at this point we queue up
> > > a message, but IRQ bit is already set.  Hence when we hit
> > > wait_event_timeout() the flag is already set and IIRC we'll
> > > drop straight through.
> > >  
> > 
> > I did not realize that the device would interrupt when Busy dropped?  I was
> > thinking that V11 did not respond to IRQ but indeed it did via setting the work
> > item to run immediately...
> > 
> > However, I only see this in the spec:
> > 
> > 1) System firmware/software checks that the DOE Busy bit is Clear to ensure
> >    that the DOE instance is ready to receive a DOE request.
> 
> I missed this particular one originally and someone else pointed it out in
> review (can't remember who though). The busy drop is mentioned in the
> bit definition. It's in the capability definition.
> 
> "DOE Interrupt Status - This bit must be Set when an interrupt is generated
> to indicate that the Data Object Ready bit or the DOE Error bit has been Set. or
>  that the DOE Busy bit has been Cleared."
> (the formatting is in the release spec.. hohum)
> 
> Anyhow, upshot is that the status can be set as a result of Busy Bit clearing.
> 6.30.3 Interrupt Geneeration:  then says that interrupt is generate on a
> transition of the logical AND of
> 
> 1. Vector unmasked
> 2. DOE interrupt Enable bit is 1
> 3. Value of the DOE interrupt Status bit is 1.
> 
> So if interrupt status bit is set to 1 due to a Busy drop and we then
> clear it before Data Object Ready, we'll get 2 interrupts.

I don't understand this.  I think the issue is we _don't_ clear it between
pci_doe_arm_wait() and pci_doe_send_req().

Then we interpret the Busy drop interrupt incorrectly as the Data Object Ready
interrupt and start polling for a response immediately rather than waiting for
the Data Object Ready IRQ.

I _think_ this will be ok because the response will not be read until Data
Object Ready is actually set.  So we check DOR wait again see the DOR IRQ there
and goto retry_resp to check Data Object Ready again.

Effectively I'm not sure I agree with you about _when_ we get the interrupts
but I do agree that we get an extra one which I'm not checking for _why_.  More
important I think that getting more IRQs is better than missing an interrupt
and incorrectly thinking we timed out.

> 
> There is another vague bit of language that sort of allows other
> uses of this interrupt for protocol specific stuff.  Hopefully
> no one falls for that, but we should safely handle that case (perf
> drop as a result is fine though!)  I can't remember where the exact
> language is, but I've had a few 'polite discussions' to persuade
> people using it that way would be a very bad idea...
> 
> 
> 
> > 
> > > 
> > > It'll probably be fine because it will end up polling below
> > > but doesn't look ideal.  
> > 
> > I agree it would not be ideal but I think if we are waiting for Busy to be
> > cleared then the pci_doe_arm_wait() should be benign.
> 
> I think in some of these paths we are waiting for Data Object Ready to be
> set, the busy drop is effectively acting as a spurious interrupt if we
> clear the status before the data object ready event which could be much later
> because of Busy can clear really quickly.

Ok yea I think this is what I am seeing.

> 
> > 
> > > 
> > > Upshot is that you sort of have to handle "spurious interrupts"
> > > cleanly and rewait on the interrupt if you get one whilst also handling
> > > race conditions around RW1C of the interrupt status flag.  
> > 
> > Sorry I'm not sure what 'RW1C' means here?
> 
> Read / Write 1 to clear.  In this case I meant reading it and then clearing it
> without looking at the other status bits.

Ah.  Perhaps the handler should be more involved in this setting different
flags and having the *_wait() functions be more specific about what exactly we
are waiting for.  I'll have to think about that.

> 
> > 
> > Anyway, spurious interrupts was something I was concerned about but I don't
> > think there is anything we can do about an interrupt coming in when we are
> > expecting one but the device did not really send one.  AFAIK that is virtually
> > impossible anyway.
> 
> In this case seeing 2 interrupts is highly likely.
> We see the Busy drop one and the interrupt handler clears the Interrupt Status
> Bit, then data object becomes ready and we go around again.

But we are only going to see this if some other entity is using the mailbox
right?  And I don't think that is going to be common, is it?

Is this the sequence you are speaking of?  If so I think this is how it would
flow given the fix I suggested below.

	Device		Other Entity	Linux CPU
			Sets Busy
					pci_doe_arm_wait() <- clears FLAG_IRQ
	Clears Busy
					pci_doe_irq_handler() <set FLAG_IRQ>
					pci_doe_send_req()  <- Sees !BUSY sends query
					pci_doe_wait_irq()  <- No waiting because of 'spurious' Busy Drop!!!

					pci_doe_arm_wait() <- clears FLAG_IRQ
					<DOR not set>
					pci_doe_wait_irq()  <- NOW waits!!!
	Set DOR
					pci_doe_irq_handler() <set FLAG_IRQ>
					<goto retry_resp>
					<DOR set>
					pci_doe_recv_resp()

What am I missing?

Ira

> 
> > 
> > If we actually 'miss' one because we timed out before the device sent it then I
> > think we are going to ignore the PCI_DOE_FLAG_IRQ flag on the next go around.
> > 
> > Actually timeout is handled by the abort call and that IRQ will, depending on
> > timing, cause a full PCI_DOE_TIMEOUT to expire.  :-(  That is indeed not
> > ideal.  However, by that time the error and busy flags should be clear and we
> > can safely continue.  Otherwise we are going to take the mailbox down.
> > 
> > It may seem better to arm wait on each iteration through the abort loop.  But
> > this is not logically correct because the abort operation should trigger an
> > IRQ.  So there is always a race if we missed an IRQ because we timed out early.
> 
> I probably stuck that comment in the wrong place.  The initial call to clear
> the flag before this should be fine (short of the 'spurious' case of people
> using the interrupt for protocol specific usage).
> 
> > 
> > > 
> > >   
> > > > +
> > > > +	rc = pci_doe_send_req(doe_mb, task);
> > > > +
> > > > +	/*
> > > > +	 * The specification does not provide any guidance on how long
> > > > +	 * some other entity could keep the DOE busy, so try for 1
> > > > +	 * second then fail. Busy handling is best effort only, because
> > > > +	 * there is no way of avoiding racing against another user of
> > > > +	 * the DOE.
> > > > +	 */
> > > > +	if (rc == -EBUSY) {
> > > > +		busy_retries++;
> > > > +		if (busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> > > > +			pci_warn(pdev,
> > > > +				"[%x] busy for too long (> 1 sec)\n",
> > > > +				offset);
> > > > +			signal_task_complete(task, rc);
> > > > +			return;
> > > > +		}
> > > > +		if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> > > > +			signal_task_abort(task, rc);
> > > > +			return;
> > > > +		}
> > > > +		goto retry_req;
> > > > +	} else if (rc) {
> > > > +		signal_task_abort(task, rc);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	timeout_jiffies = jiffies + HZ;
> > > > +	if (pci_doe_wait_irq_or_poll(doe_mb)) {  
> > > 
> > > So this may well be passed as a result of a BUSY transition to 0 very soon
> > > after the doe_send_req but well before the data is ready....  
> > 
> > I think the simple fix is to make the BUSY wait on an IRQ.  Something like:
> 
>  
> > 
> > 21:13:53 > git di
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 12f9f8045eb7..afd326320798 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -352,7 +352,7 @@ static void doe_statemachine_work(struct work_struct *work)
> >                         signal_task_complete(task, rc);
> >                         return;
> >                 }
> > -               if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> > +               if (pci_doe_wait_irq_or_poll(...)) {
> >                         signal_task_abort(task, rc);
> >                         return;
> 
> This case (which I think is the -EBUSY from pci_doe_send_req() handling)
> isn't important because it's trying to paper over a weird condition. We
> don't normally expect to get here.
> 
> I was concerned with the line just above my comment which may not act as
> a gate at all because it's tripped by the the Busy Drop, which may be
> well before the data object ready that we are actually waiting for.
> 
> 
> >                 }
> > 
> > > 
> > >   
> > > > +		signal_task_abort(task, -EIO);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/* Poll for response */
> > > > +retry_resp:
> > > > +	if (pci_doe_arm_wait(doe_mb)) {  
> > > I think we can get here between Busy drop and Object Ready which means
> > > this can get another IRQ_FLAG setting just after it.  Does it matter?
> > > Don't think so, as we don't use that bit again in this run through
> > > and it will be cleared at beginning of next one,  
> > 
> > Yea basically I agree.
> > 
> > > but if so why is
> > > this call here?  
> > 
> > Seemed like the right thing to do at the time...  ;-)  j/k
> > 
> > > I think it's only useful for detecting an abort, if
> > > so do that explicitly.  
> > 
> > Actually it is the right thing to do...  However, the wait poll below also
> > needs to be an IRQ or poll.  I'm not sure how I missed that logic.
> 
> Sounds write though without whole code laid out to follow through I'm
> not 100% sure yet!
> 
> > 
> > >   
> > > > +		signal_task_abort(task, -EIO);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > +		signal_task_abort(task, -EIO);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > > > +		if (time_after(jiffies, timeout_jiffies)) {
> > > > +			signal_task_abort(task, -ETIMEDOUT);
> > > > +			return;
> > > > +		}
> > > > +		if (pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL)) {  
> > > 
> > > Following on from above....
> > > As a result of the interrupt having fired on the BUSY off transition,
> > > I think we will almost always end up spinning here until Object Ready
> > > is set.  Fine, but seems a shame we don't let an interrupt do this
> > > for us in most cases.  (note in QEMU response is instantaneous so
> > > when the interrupt for Busy drop is set, object ready also true so
> > > by the time we get here data ready will already be sent).  
> > 
> > This needs to be pci_doe_wait_irq_or_poll() as well and the arm wait above
> > ensures we continue to look for that interrupt.
> > 
> > I'm starting to see how I got confused.  The timeout values all vary and
> > mod_delayed_work() made it very easy for you to interrupt any of those.
> 
> Yeah.  That was a nice suggestion Dan made long ago but it doesn't play well
> with the single workqueue.
> 
> > 
> > I tried to bundle the poll vs interrupt modes in pci_doe_wait_irq_or_poll() and
> > got confused.  :-(
> > 
> > >   
> > > > +			signal_task_abort(task, -EIO);
> > > > +			return;
> > > > +		}
> > > > +		goto retry_resp;
> > > > +	}
> > > > +
> > > > +	rc  = pci_doe_recv_resp(doe_mb, task);
> > > > +	if (rc < 0) {
> > > > +		signal_task_abort(task, rc);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	signal_task_complete(task, rc);
> > > > +}
> > > > +  
> > > 
> > >   
> > > > +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> > > > +{
> > > > +	if (doe_mb->work_queue)  
> > > 
> > > I'm not a great fan of free functions that check a bunch of conditions
> > > because they may be called before things are set up.  
> > 
> > I'll see what I can do.  I do kind of like this but I think it gets muddled and
> > I'm not dead set on either way.
> > 
> > > To my
> > > mind that generally means we should be calling individual cleanup
> > > in the appropriate error handlers.
> > > 
> > > Either that or just use devm handling for each item. Sure
> > > it's a few more lines of code, but I find it a lot easier to go
> > > 
> > > Oh look that thing we just set up is cleaned up by this.
> > > 
> > >   
> > > > +		destroy_workqueue(doe_mb->work_queue);
> > > > +	if (pci_doe_irq_enabled(doe_mb))
> > > > +		pci_free_irq(doe_mb->pdev, doe_mb->int_msg_num, doe_mb);
> > > > +	xa_destroy(&doe_mb->prots);
> > > > +	kfree(doe_mb);
> > > > +}
> > > > +  
> > > 
> > > ...
> > >   
> > > > +
> > > > +static void pci_doe_destroy_mb(void *mb)
> > > > +{
> > > > +	struct pci_doe_mb *doe_mb = mb;
> > > > +
> > > > +	/* Mark going down */
> > > > +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > > > +
> > > > +	/* Abort any in progress work items */
> > > > +	pci_doe_abort(doe_mb);  
> > > 
> > > Abort is getting used for two things in here. Perhaps
> > > rename this one to 
> > > pci_doe_abort_tasks() or something like that?  
> > 
> > What do you mean two things?  Oh I think I see.  You mean abort the work item
> > vs abort sent to the hardware?
> 
> yup.
> 
> > 
> > This no longer aborts all the tasks just the one which may be in progress.
> > Because the work queue is ordered only one task may be in progress.  I'll clean
> > up the comment too.
> 
> Hmm. It puts a requirement on the caller to not queue multiple requests that
> might require ordering.  One advantage of flushing the lot was ordering was
> unaffected (though any caller that queued multiple items would have to then
> requeue multiple items so would have to maintain their own retry buffer).
> 
> > 
> > This sets the abort flag and wakes it up if it is sleeping.  If not then the
> > abort flag will be detected in the next arm.
> > 
> > FWIW I think I may just remove this call and open code it here.
> 
> Sounds good, avoid naming confusion by getting rid of the name :)
> 
> 
> 
> > > > +
> > > > +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> > > > +						     doe_mb->cap_offset);
> > > > +	if (!doe_mb->work_queue) {
> > > > +		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > > > +			doe_mb->cap_offset);
> > > > +		pci_doe_free_mb(doe_mb);  
> > > 
> > > As above, I'd rather this explicitly freed what has been set up
> > > and only that rather than calling a free function that does a bunch of
> > > stuff conditionally.  
> > 
> > I think I can make that work.  This is the only conditional in free however,
> > because the other conditional is the IRQ support which may not be set up.
> 
> If you split to multiple devm_ calls you can not setup a tear down for the
> irq if we don't have one. Or, don't use pci_request_irq() but call
> devm_request_threaded_irq() directly and let that clean up for you.
> 
> 
> > 
> > Thanks again for the in depth review!
> 
> No problem. I know how nasty this seemingly simple little bit of code
> is, so you have my sympathies :)
> 
> 
> Jonathan
