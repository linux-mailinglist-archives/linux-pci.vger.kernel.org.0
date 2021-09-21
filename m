Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1774A413DCF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhIUXFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 19:05:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:1060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhIUXFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 19:05:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="284493211"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="284493211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 16:03:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="549691054"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.132.1])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 16:03:17 -0700
Date:   Tue, 21 Sep 2021 16:03:15 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 0/7] cxl_pci refactor for reusability
Message-ID: <20210921230315.z4wqfooso7zy3ay2@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
 <CAPcyv4jyTDWGAUOmkumHBAN6K9t1c9hcCt6hCTo4POSybMOMSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jyTDWGAUOmkumHBAN6K9t1c9hcCt6hCTo4POSybMOMSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-09-21 15:28:21, Dan Williams wrote:
> On Tue, Sep 21, 2021 at 3:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Provide the ability to obtain CXL register blocks as discrete functionality.
> > This functionality will become useful for other CXL drivers that need access to
> > CXL register blocks. It is also in line with other additions to core which moves
> > register mapping functionality.
> >
> > At the introduction of the CXL driver the only user of CXL MMIO was cxl_pci
> > (then known as cxl_mem). As the driver has evolved it is clear that cxl_pci will
> > not be the only entity that needs access to CXL MMIO. This series stops short of
> > moving the generalized functionality into cxl_core for the sake of getting eyes
> > on the important foundational bits sooner rather than later. The ultimate plan
> > is to move much of the code into cxl_core.
> >
> > Via review of two previous patches [1] & [2] it has been suggested that the bits
> > which are being used for DVSEC enumeration move into PCI core. As CXL core is
> > soon going to require these, let's try to get the ball rolling now on making
> > that happen.
> >
> > [1]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
> > [2]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
> >
> > Ben Widawsky (7):
> >   cxl: Convert "RBI" to enum
> >   cxl/pci: Remove dev_dbg for unknown register blocks
> >   cxl/pci: Refactor cxl_pci_setup_regs
> >   cxl/pci: Make more use of cxl_register_map
> >   PCI: Add pci_find_dvsec_capability to find designated VSEC
> >   cxl/pci: Use pci core's DVSEC functionality
> >   ocxl: Use pci core's DVSEC functionality
> 
> I also found:
> 
> siov_find_pci_dvsec()

Hadn't seen this one... Thanks.

> 
> ...and an open coded one in:
> 
> drivers/mfd/intel_pmt.c::pmt_pci_probe()

I had spotted this one previously

> 
> This one looks too weird to replace:
> 
> arch/x86/events/intel/uncore_discovery.c::intel_uncore_has_discovery_tables()
> 
> In any event I'd expect this cover to also be cc'd to those folks.

I did Cc OCXL in the relevant patch, I don't think they need most of the
background in the cover letter (I also did Cc David Box who maintains
intel_pmt). I'll add them to the cover letter here shortly...

