Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5C4F6D27
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiDFVp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiDFVpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 17:45:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC50129E83;
        Wed,  6 Apr 2022 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649280191; x=1680816191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNtPcAMRZ61HN7BifxWlXRJgQkBZ6y0RwZRCw5IiP2U=;
  b=gapeDvhQN2iNKAa55RV+0LsNgDp3wESwDJRB402FH7auxouSk4Ii4AKQ
   ECfdRXVqro/cugHDHnaHyFPNfw3kLTjHsrdM7JbqgH/DxrcTM+TUHeg0r
   8IjVfXJydohFPLQMiLtzKRLn2pZS2XqLapdeRvYHf+/DQKY/gZPWNJRUa
   /Q0bLz30HMOxiAyJoF1LvYp8rnG1rR/A0HWn/svg/XetqWZstznh63OcU
   JbfiBaTgkgdn+Z7q9u4MuwxQGlHYj3n0ziMLz/xTJSI0b9yaVSsbewVG7
   LRtnfJo7X5UVmSeIDXqReLPfrq5GuIjLRolzdMoK9S7/fR4+Z1oy2Ic3B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324323245"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="324323245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 14:23:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="652543100"
Received: from pgbarran-mobl.amr.corp.intel.com (HELO localhost) ([10.212.127.188])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 14:23:09 -0700
Date:   Wed, 6 Apr 2022 14:23:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <Yk4EvRDd/Kw5rEil@iweiny-desk3>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
 <20220330235920.2800929-4-ira.weiny@intel.com>
 <YkVBJ+nRA2g/WDxa@infradead.org>
 <YkXGnKsTEUAe29io@iweiny-desk3>
 <20220402144845.GA7822@wunner.de>
 <YkzPIzIhfzQKIMe0@iweiny-desk3>
 <20220406111110.00000e72@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406111110.00000e72@Huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 06, 2022 at 11:11:10AM +0100, Jonathan Cameron wrote:
> On Tue, 5 Apr 2022 16:22:11 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Sat, Apr 02, 2022 at 04:48:45PM +0200, Lukas Wunner wrote:
> > > On Thu, Mar 31, 2022 at 08:19:56AM -0700, Ira Weiny wrote:  
> > > > On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:  
> > > > > On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:  
> > > > > > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > > > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > > > DOE Extended Capability.  
> > > > > 
> > > > > I really don't think this should be built unconditionally and bloat
> > > > > every single kernel built with PCI support.  
> > > > 
> > > > I can add a Kconfig.  
> > > 
> > > Ideally, that config option should live in the pcie/ subdirectory,
> > > i.e. in drivers/pci/pcie/Kconfig, alongside drivers/pci/pcie/doe.c,
> > > as we try to consolidate PCIe-specific features there and reserve
> > > core code in drivers/pci/*.c for functionality that also applies
> > > to Conventional PCI.  
> > 
> > Thanks for letting me know about this direction.  I was unaware of this.
> 
> We had this in the pcie directory, but Bjorn asked us to move it to the pci
> directory as there isn't anything specific to PCIe about DOE. You could
> implement it on pci-x (maybe 2.0?) I think even though it's in the PCIe specification.
> 
> https://lore.kernel.org/linux-pci/20210413194927.GA2241331@bjorn-Precision-5520/

:-/

I'd forgotten that far back.

Bjorn?

Ira

> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > I'll move the file no problem, thanks,
> > Ira
> > 
> > > 
> > > Thanks,
> > > 
> > > Lukas  
> 
