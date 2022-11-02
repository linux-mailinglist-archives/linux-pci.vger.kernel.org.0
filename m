Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868C6172FE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiKBXpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKBXpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:45:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613B2604;
        Wed,  2 Nov 2022 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667432575; x=1698968575;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1Uosu56DkR2CZ12c3SnGIsxE0B7McJu1iMcj3uHIr6w=;
  b=X63uEdSYgw9WV+qpEpgsoLvp5LCdh6DD24tr9F8INP+yhFX/XH8cH+Q8
   ixliiftCwW8L2mmMqtZFcdmq7QRBR3QCVjukWdTVd1DA3E/qHuwCi1lpU
   FZ/zkwoS7DuiCLwhVGZRs9RdvS4/jhpAwi+u2oCB59hMnFW9peZrPm99P
   5m0n4MHXE/F43MJ1dv7o7Hcr7C1/4BiO9HAbiQKUOUYro4eCtPemUWx3K
   jRi+rMKlUAMqNYc1IYKNvcqx7FCD2uPG/8wNNkIBbS6ymRZTsNEyVFAJj
   dSlyuFn7HuZaPFuy+ED6QgCVs+K9PiXEyA/See3gUxCXtHZergYbQ93EA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310656977"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310656977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 16:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759733733"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759733733"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2022 16:42:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 16:42:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 16:42:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 16:42:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 16:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCCdz5PasQtJ+VVMMs3d9Sx7sEU8lHpC90bdPia6WHLym3foB18Ep0fvyWgArz825exvWV8CI+fqaGzyrMahxS19oslPniebdA9V+sNrsi0n4sNOoqUomerGFun9/uJi433SkytlWPCf+/YDm5caSsUJJwYl5oy0/v8/dLiWVwkln6hXtDuFwTcGYGNOBsnjEt7/ENYyXwinOkFy3jFwkz4K79D8jNbPoFHEgWcA+bCfnOHtQZWI05eYMJu5pJb8gBCh9KGK058wqM9gOPpeDvAIejuINhiZhgnJHVY4JUahaJwhvFXrw9CyV/DpqUxP04upcVc1N7gq29DNvrv9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbrS/OKnOEMPt2AfJpF5oc0H1h/fdGNoC/aGAD95s6g=;
 b=gQvqbnt0Ntgpf2Dxx6UK3UQAaGeqTYrrr585Q486weOKVB6Fp1LMmLO8IQ40bX8K51PupXJf39kZiGKaHAMvTEC685fb0iPKWMloxb7TI0L6GrMo9xBnijhSNgBHVTaECoSNv1X444tC2f0MhH1aftWXI5o2WXxd+aw1cRYAUtHIwTuT2+y5dbGg5W7VGWz4/wKt9uzz5tc/J/etUZYIeyggzRzEL8CUjqvuQhLBrQ9Dbceqhm/u4SpFM65V1+8l40UrjuGJPeJxj+CyqL9dDs0G3Akba2y+SkxDiO+aVF8R7JxtAd1dotot7/Q+lJ2mmAFtbk9SjvdI1R6LbtEOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 23:42:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 23:42:51 +0000
Date:   Wed, 2 Nov 2022 16:42:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y2MAdaCES+aUc2QH@iweiny-desk3>
References: <20221024133633.00000467@huawei.com>
 <20221025232535.GA579167@bhelgaas>
 <20221102171524.thsz2kwtirhxn7ee@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102171524.thsz2kwtirhxn7ee@offworld>
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 768026b4-c5f0-413b-41ee-08dabd2bf48d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6BDFfH87cwLh9Su0/wKYIXRbpc7HaPv4JIHqOcFAanwDFOEEtfY5oM/5GzmGS9T9hD8Of9C60w/m0/MMLeJxqWjyjStb9wnbFvnjbDwmmwNdDfodx2aJcue5B5wYvB6YtgyjxLbQIr/c4iR+gK8WcekavGuHn1QsWMMWL06MTxXHofC8ooUbuPXdWKoLA7qkC17k8d6bJgymQw6wZpXbIfVSlbKoCZRPmhh1RC/VHJkDqBOssjIYlPC7h3bI0lPzqjok66sVZI3w4oTMZzSrr7QtlC0lw4bD2ZvQpTl1lGWnFmOoUaLLLuju9E50wFIpCs7e1NEaBMersdwBBGc8pfSD2BU9F+Ot8pVarN4STxnKwNh5GANe8BhA4GZMjMJcuDQbEKIjmtkEJOpzAr6lzvnhaDj+API5Rr0j375xYnp8p32GEjUOKw3z505brRnvL1qRoyAtzvjYPsbd/CKyu7oFEOahFw7cf6QafBNCWcVJPo0IpoNlnbekJBt3KPiWkBw7Vx+sJPx5TlAWCJ9XVaJpCji1iXjK2MUeWqM2XzoJTSZr72bSgCwf4S0vjVKsen7LZDJYGhiUD6kMcHXMpkEu9Zm8HF4ijGHSQnvb0NC02Y+swR/ZqJ6w9sd/n8JOqdEPhLCi8+y9v+ZvuBmzhvx0WvzoHY1pfQ8tJ2UkEszwWbxZVigfDrOx9QkGDtjbLA0KukDAj7MzRTCo74zeKxhQwDdq5cOZw9LVsTtgOWu0Z0CqgWLQJqlIrMfoRLDzKOX4GoJi1OCZtoELMz8hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(6486002)(66476007)(7416002)(5660300002)(66899015)(478600001)(6916009)(316002)(6666004)(54906003)(2906002)(66556008)(66946007)(4326008)(6512007)(9686003)(44832011)(8676002)(6506007)(26005)(38100700002)(8936002)(82960400001)(41300700001)(186003)(86362001)(33716001)(83380400001)(41533002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWwF8HRdsnOFpGgPmdoV4Ijy+0IKS/ynNQuYhM4wxFmlEjRSHxCZBo61lN8M?=
 =?us-ascii?Q?FTJowY8W/25RCrmkJypOVsPvP52LU3IxgBNT0gCMMQDnGVYCzzS1vgg5ewUE?=
 =?us-ascii?Q?fj8NHCW5X5zhFZyccPALLEVdafqRB2u9yLSzhkk5+tVHuH1mbTTMJN2Ida9R?=
 =?us-ascii?Q?g3qW07Q1K01+6qoGEUeLg6qyrztf4wMYRO6MHSq/W40e4HKHYrmMGUen1Vgo?=
 =?us-ascii?Q?Sc7yxpM3sErhczAIQMFu8p6liyhVYPgsIkQ5JNpSqdu1HspTembk3rfaTNpZ?=
 =?us-ascii?Q?H/DxUtnyQZi+cCvVvBkS1j09DE3GKo+pQGObb4UXHIVWdEKtWxVihLYXxEfe?=
 =?us-ascii?Q?dX+/sBdaiFj1xCs0TAOoQOc53hzuMK3RCRoTqGevlJjG5wCZ0u6xqHpg5GEQ?=
 =?us-ascii?Q?VhZ8lVf0PUUzdiYaKH7CZJy7Pf+2iVNM8eNJL+fKLv0TRP4uU6Z6mr0a2R4e?=
 =?us-ascii?Q?IDiaSdEXXQQ0SyX5OJh00BC+KUCjvYTnl1XClV5RVZzSVT93E7WKOmGlvjQf?=
 =?us-ascii?Q?pI+V6uXVhHjYPIG0fiLo0ttSNJqeZJDH0XNnAHH8U7QI/Y3WcxW7w95CTYE9?=
 =?us-ascii?Q?4Yop9tm/m3tAOgGPohtBx9EJTP5SVUdO+QMUrOvF58/xdkhML8Zrltt2+Gm4?=
 =?us-ascii?Q?Tq83hySxC3FVoH3bdixjCmY36ZvCkDGTV0XQ7XxKstcJeMY+iDnook2ZvHUR?=
 =?us-ascii?Q?vcxoKxcuwUjllJ/WjB9wRilcu57A7pPsEzHwykiP13DoM4U4zIvgDjnzAAH0?=
 =?us-ascii?Q?+C4doiW8HjBiqdhsj857L0aN2LBXQ4TIFDiwJk9ylVmAtx0Ad7eNSRVAPX8D?=
 =?us-ascii?Q?0WSiDZxcQD4J3VyyHbK3JusZdulDQBfUfpCiXNovnmgURAk3xllMU+Tx67Sg?=
 =?us-ascii?Q?8/4ElDmVDqFkCIVoII1vABjsNEYV2EesdDbT3QeU+2hgmunYkUZ6NKzZE/IY?=
 =?us-ascii?Q?b5UBFcTK8USX4yPWfFEK4sZahVnmZPKXvdRopDkz2Y7y27lgAsw7JLzD/qFB?=
 =?us-ascii?Q?5zF7pDPMFLQ/riL2IRlCTINzvMQ/IUN/FqV6Tk/TSpD5SZtoQia9meC4UN/p?=
 =?us-ascii?Q?Qmb1sZVyrSAY1qu9LJ3Fbc6TT/m2jeLupXukcJSr0vnoyfAjmeNC055bzhoG?=
 =?us-ascii?Q?tgdgFWtuj41PQ5L/MuxMQbRc4FrcmE1MAeJ43Bc/1mHdTddjy5fKlnEuT+gT?=
 =?us-ascii?Q?W/CIn/L36lrSDHI48sS6RVMml7qrre1N222zWc5hH1IsApSKqe0WR+dyarE9?=
 =?us-ascii?Q?quLs8EuLujlJg+82MtYHd3qdYXo6mMi5QpL8Fbjurvl7pfb/d42iA4NipdGH?=
 =?us-ascii?Q?tuFUbvVHMu7+c+E8RL/tFqaxvv/6gaMnHcT85p/iWiUjFoG+w9+95CyCzOjm?=
 =?us-ascii?Q?Iv0u0lvez2yHNRreq7pxDMxIIvozKKN8EBer6NUeHIPWqtxvg2/rGUyGPneW?=
 =?us-ascii?Q?D6gVwk0d+b52Kjz0WXm0LSr+y0fdUPczPKUe6bvu5YZfKG8FYyiP0FSqxTsq?=
 =?us-ascii?Q?ucOL+94/k1hRmIxo4ZnjwPKYtbOZKuvFyLkUQ0A+bTDLgXLioz0GSWJYATOZ?=
 =?us-ascii?Q?1nKb+yaoMMZ8U8j8dZa0dJysGPGy1ePbbFmP82ow?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 768026b4-c5f0-413b-41ee-08dabd2bf48d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 23:42:51.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlpS3gZJmXWZTWa74T16aDPXVa+7ysCZpF11MMzwloBRF9e5wkSea2GachGd7DGLbO7RgHScGvjMilEx7nBadA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 10:15:24AM -0700, Davidlohr Bueso wrote:
> On Tue, 25 Oct 2022, Bjorn Helgaas wrote:
> 
> > > In short that calls:
> > > /* Allocate the maximum possible number of MSI/MSI-X vectors */
> > > nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
> > > 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > 
> > > /* See how many and which Interrupt Message Numbers we actually use */
> > > nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
> > > 
> > > if (nvec != nr_entries) {
> > > 	pci_free_irq_vectors(dev);
> > > 
> > > 	nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> > > 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > }
> > > 
> > > My worry here is that the implicit assumption is that the vectors
> > > won't move if we reduce the overall number of vectors we are asking
> > > for...
> 
> This would also apply to what is currently in portdrv machinery, no?
> 
> > > 
> > > However, imagine the case that we have a feature the driver doesn't
> > > know about that was previously at a higher vector.  After reducing
> > > the vectors allocated the hardware might decide that feature needs
> > > its own vector whereas some others can be combined.  Hence we'd end
> > > up with a less than ideal packing for the features we actually
> > > support.
> > > 
> > > Could do something iterative to solve this if it actually matters
> > > (increase number of vectors until the layout matches what we get
> > > with max possible vectors).
> 
> Maybe do a bounded retry loop until we get stable value?
> 
> retry = 1;
> do {
> 	pci_alloc_irq_vectors(1, 32);
> 	nvecs = get_max_msgnum(); // max(pmu, events, mbox, isolation)
> 	pci_free_irq_vectors();
> 
> 	pci_alloc_irq_vectors(nvecs, nvecs);
> 	new_nvecs = get_max_msgnum();
> 
> 	if (likely(new_nvecs == nvecs))
> 		return 0;
> 
> 	pci_free_irq_vectors();
> }  while (retry--);
> 
> return -1; // no irq support
> 
> But yeah I'm not sure how much we actually care about this. But if so,
> it  also might be worth re-visiting the generic table thing, as if
> nothing else it can standalone co-exist and avoid allocating any irqs
> altogether if we know a-priori that there is no irq support.
> 
> > 
> > Is this cxl code allocating vectors for devices that might also be
> > claimed by portdrv?  I assume not because that sounds like a problem.
> > 
> > Ugh.  I always feel like the portdrv design must be sub-optimal
> > because this seems so hard to do cleanly.
> > 
> > pci_alloc_irq_vectors() has a lot of magic inside it and is great for
> > most drivers, but the PCIe service IRQs are definitely unusual and
> > maybe it's not the best fit for this situation.
> > 
> > If I understand correctly, Interrupt Message Numbers for all these
> > PCIe services (hotplug, AER, DPC, etc) are restricted to 0-31 for both
> > MSI and MSI-X, and the reason we don't just allocate 32 vectors all
> > the time is to avoid consuming too many IRQs.
> 
> Most CXL features that can have irqs will normally use only the first 16,
> with the exception of isolation (cxl 3.0), which per the spec is up to 32.

Dan, Dave, and I were discussing this and we agree.  For now the only things
people are working on are within the first 16 so why not just request 16 as the
max for now?

Ira

> 
> > The MSI case is ugly because the Interrupt Message Number can change
> > when we set Multiple Message Enable.  Maybe we can separate it out and
> > have a less than optimal solution for this case, like allocating one
> > or two vectors and polling if that's not enough.  I expect most
> > devices will support MSI-X.
> 
> Would only supporting MSI-X be so terrible?
> 
> Thanks,
> Davidlohr
