Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7834B17DA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 22:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiBJVvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 16:51:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiBJVvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 16:51:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314FE6B;
        Thu, 10 Feb 2022 13:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644529891; x=1676065891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RtABhcfz++1lD4BxroCHUgbb9du3AHo0vVF0UojqTVo=;
  b=lj/MKt9Bz7XjoX8SUE9donZ1vbJu+AigWl00ZudBIfOYQnCmbOx+JrzD
   DeY3dankoEV6vNzkXZEJX24R0MuMmPchzMH579PoiFWEUAGEx8scmYBEG
   tXgnukX1+i1NoyztWTWQnm9w7NrRatsYFhrUDiNGGac6RYY/TiCMHga75
   UzWzoSzLWe2ab89FxiINW4Xl6tv0IUB4utbMUmqovoNcV+csDW5ePVPK9
   MGo+8fBPhlkVFia5pxPTtTZLefdCREZPJO4ZMMsSXBlMDOG61E6E4cw5t
   69zeldo/RWm2JKS9bp7Te4Cw2KodWqf8tyO0Yf2WPnq4KMn1Z7JSReVLN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310337049"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310337049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 13:51:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="485954165"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 13:51:29 -0800
Date:   Thu, 10 Feb 2022 13:51:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20220210215128.GA998480@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-4-ira.weiny@intel.com>
 <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
 <20220209101320.00000473@Huawei.com>
 <CAPcyv4g2nNHKPuYVOEH3TbJtCiB1rkRNCVbfDWHnWkotvTAcJg@mail.gmail.com>
 <20220209165756.00002841@huawei.com>
 <CAPcyv4j9mEOn_sJSwX+rY_6wFjuU_JB7e075_n_Q5sfgiGsqew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j9mEOn_sJSwX+rY_6wFjuU_JB7e075_n_Q5sfgiGsqew@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 11:57:38AM -0800, Dan Williams wrote:
> On Wed, Feb 9, 2022 at 8:58 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]
> > > It just seems an unnecessary hunk of code for the core to carry when
> > > it's trivial for a client of the core to do:
> > >
> > > task->private = &completion;
> > > task->end_task = complete_completion;
> > > submit_task()
> > > wait_for_completion(&completion);
> >
> > OK, we can move this to the callers though function obviously will
> > also need renaming - I guess to pci_doe_exchange() and now need to take a
> > task rather than the exchange.
> >
> > I personally slightly prefer the layered approach, but don't care that
> > strongly.
> 
> Like I said, you and Ira are holding the pen, so if you decide to keep
> the layering, just document the ontology somewhere and I'll let it go.

I'm busy with the PKS series ATM but I should get back to reviewing all these
comments soon.

Ira
