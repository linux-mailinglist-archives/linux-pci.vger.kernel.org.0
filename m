Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1374DA4D7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiCOVuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbiCOVuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 17:50:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3749FA3;
        Tue, 15 Mar 2022 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647380936; x=1678916936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=js7Wh6ePBSStX7B0Pt3qGlgtA+r98s+uDeBnQ6DsDuM=;
  b=bEQ12fEhFlK/czQ/h/CSmogkhSy7OalsgRei8iKXlJMM4LA0zZQoSvyB
   NBddZ0poU98jad0sZIiRpKY03Yh4Z/ixbyWzTc9xMSlVFY2HtZa5BqbX4
   zbVTw1Wes4rA2uPRRo3F8XPFu9jfOks7zdh8CC37Z5aQI4Z1hQpM/DTae
   9IcbQZcFYutCiT1svWmIhyY7bI4o+ySCqUaeJKjXgH/vAtJWgJSfQXpoU
   SGJcaiuau5NTJ6agG+XLb/9tMlKvZjCsr+rkMY3j6KSyRP8U9Sxt4NytQ
   z/wLJF7/0Z/r11+rUJRtZ04hrz/tuGcVtB725JvcSOyxfr2iW22mRN3Pd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="237035536"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="237035536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="549751774"
Received: from jpgabald-mobl.amr.corp.intel.com (HELO localhost) ([10.212.75.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:56 -0700
Date:   Tue, 15 Mar 2022 14:48:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 02/10] PCI: Replace magic constant for PCI Sig Vendor
 ID
Message-ID: <YjEJx3kXSqhPDZfC@iweiny-desk3>
References: <20220201071952.900068-3-ira.weiny@intel.com>
 <20220204214902.GA220669@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204214902.GA220669@bhelgaas>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 04, 2022 at 03:49:02PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 31, 2022 at 11:19:44PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Based on Bjorn's suggestion[1], now that the PCI Sig Vendor ID is
> > defined the define should be used in pci_bus_crs_vendor_id() rather than
> > the hard coded magic value.
> > 
> > Replace the magic value in pci_bus_crs_vendor_id() with
> > PCI_VENDOR_ID_PCI_SIG.
>  
> This sentence is plenty; no attribution or link needed.  I appreciate
> the acknowledgement, but replacing a magic value isn't a better idea
> simply because *I* suggested it ;)

Done.

> 
> > [1] https://lore.kernel.org/linux-cxl/20211117215044.GA1777828@bhelgaas/
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks,
Ira

> 
> > ---
> >  drivers/pci/probe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 087d3658f75c..d92dbb136fc9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2318,7 +2318,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
> >  
> >  static bool pci_bus_crs_vendor_id(u32 l)
> >  {
> > -	return (l & 0xffff) == 0x0001;
> > +	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
> >  }
> >  
> >  static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
> > -- 
> > 2.31.1
> > 
