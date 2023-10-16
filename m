Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955807CA88A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJPMx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJPMx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 08:53:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B118AD;
        Mon, 16 Oct 2023 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697460836; x=1728996836;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=QizaqdkpLig82mRKUnOc6l/0i6LVA1cx3IhaJACbuvk=;
  b=IDaUypHhU2lUoQjUClJ1H8u5jlfgOUMk8iTNSRFqXXZu7kOsXnUJlvYw
   lgYsd+Z9Ajihe5NfnbpUeW3iGWHvgTVdYaWM62md6pLmMzMx4r+o0eZHA
   7BV7k3DB3kBgrLoVW9O40FiSqUGINcmrPdFW1TyagpN9+hJ4Sxx6MwTP7
   sU6cQciUEVGy6ae/c8RICi4MI4S0T02COxUSdC9fV2KSt0oqtZyfo3IDA
   I6UGrvAq3q3iJFKILqT7HTvdWOE+OmmM98hsWsV6mkuZ13/UQhPJFeipy
   M41oPX5swMjKOxzBGBMcnuUVa+HSBbGSn2T67Jw9yhAgqGwzC1YuDnCuk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370592181"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="370592181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="821558186"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="821558186"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:53:13 -0700
Date:   Mon, 16 Oct 2023 15:53:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/DPC: Use defines with register fields
In-Reply-To: <20231013201934.GA1124734@bhelgaas>
Message-ID: <3883226-f376-86e0-7790-77b1642d129@linux.intel.com>
References: <20231013201934.GA1124734@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-762852509-1697460567=:1986"
Content-ID: <1cc4caad-ea5-e5f3-37b-e6ad91c62422@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-762852509-1697460567=:1986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <cd9f38f-7062-ff94-829d-ac343d403659@linux.intel.com>

On Fri, 13 Oct 2023, Bjorn Helgaas wrote:

> On Fri, Oct 13, 2023 at 02:20:04PM +0300, Ilpo Järvinen wrote:
> > Use defines instead of literals and replace custom masking and shifts
> > with FIELD_GET() where it makes sense.
> > ...
> 
> >  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> > -	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> >  
> > -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> > +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> > +	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> > +	ctl &= ~PCI_EXP_DPC_CTL_EN_NONFATAL;
> 
> This has been a little obtuse from the beginning.
> 
> The original clears bits 0, 1, 3, then sets bits 0 and 3.
> The new code sets bits 0, 3, then clears bit 1.
> 
> These are equivalent, but it's definitely some work to verify it.
>
> I think the point is to enable DPC on ERR_FATAL (but not ERR_NONFATAL)
> and to enable DPC interrupts.  What about something like this?
>   #define PCI_EXP_DPC_CTL_EN_MASK  0x0003
> 
>   ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
>   ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;

Thanks for the suggestion, it looks cleaner, yes. I realized the bit 
changes weren't as obvious as they could be but I failed to see I could 
add such a combined mask to make the intent dead obvious.

With a small change replacing the 0x0003 literal with the combined defines 
of the actual bits it seems very clear what's going on. I'll go for that. 

I'll place my non-FIELD_GET() changes on DPC top of your 
FIELD_GET/PREP()-only change so each patch can be smaller and more 
focused.

-- 
 i.


> >  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> > -	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
> >  
> > +	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
> >  	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> >  		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
> >  		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
> > -- 
> > 2.30.2
> > 
> 
--8323329-762852509-1697460567=:1986--
