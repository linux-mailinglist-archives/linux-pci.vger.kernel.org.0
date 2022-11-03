Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A7617C2F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 13:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKCMJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiKCMJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 08:09:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D801E10D9
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667477351; x=1699013351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nm4F08MkfRTrfI/491WPBqzJFGAvQJM/kfn60IhKD4E=;
  b=MKrsFvgpQqEPlTArlddalY2z1KV3ii/h/WF7N13F4lZyhJivan7ffajk
   5tq/hH56CAcrq6z6CkppJXCf9lkVaozjCzpxduo+HAvBwcwpzN5BlJInm
   E4KGRpJXSSTmRcwXlef3q2f6HgMPhlAx+vHawkjeZf+uufyk3iLBd7F9F
   uvIvaXIVNKDb1eOYMHrFLeZIIrQJw7Z+uGDIU015FDmJHsZU2qDrF5aFe
   CbbIP7zpvgQ1tjENQ9hdGHYM/A+ihSBcd98qaPK8rJ7ZwunQy+VeRg4Sj
   u1DnwNmnFH4vF+SS07jSUjdoXz4TtZXlM+1ogS9SICpI1bcPCmEQRS9if
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="290052600"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="290052600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 05:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634650267"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="634650267"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2022 05:09:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0209D15C; Thu,  3 Nov 2022 14:09:31 +0200 (EET)
Date:   Thu, 3 Nov 2022 14:09:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <Y2Ove2wE/OUNT0cq@black.fi.intel.com>
References: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
 <Y2OsGJ5y8llo7L9R@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2OsGJ5y8llo7L9R@smile.fi.intel.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 01:55:04PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 03, 2022 at 01:06:20PM +0200, Mika Westerberg wrote:
> > Instead of open-coding it everywhere introduce a tiny helper that can be
> > used to iterate over each resource of a PCI device, and convert the most
> > obvious users into it.
> > 
> > While at it drop doubled empty line before pdev_sort_resources().
> > 
> > No functional changes intended.
> 
> Thanks! But this has one subtle difference to what I suggested, see below.
> 
> ...
> 
> > +/**
> > + * pci_dev_for_each_resource() - Iterate over each PCI device resource
> > + * @dev: PCI device
> > + * @res: Variable that holds the current resource
> > + * @i: Iterator
> > + */
> > +#define pci_dev_for_each_resource(dev, res, i)			\
> > +	for (i = 0;						\
> 
> unsigned int i = 0;

> 
> > +	     res = &(dev)->resource[i], i < PCI_NUM_RESOURCES;	\
> > +	     i++)
> 
> That's the idea to hide the iterator variable inside the loop. It might be
> though needed in some cases, so for them this conversion can't be done right
> now.

Yes, some of the cases need the iterator so that's why I left it (and
therefore it cannot be 'unsigned int' either).

I'm fine if this patch gets ignored ;-) Sorry about the noise then.
