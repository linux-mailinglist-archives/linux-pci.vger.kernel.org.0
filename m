Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831532D0A8B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 07:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgLGGNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 01:13:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:34823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgLGGNG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 01:13:06 -0500
IronPort-SDR: bGnUaM47eR5x1usXJ+AEXFErgaiaiIpu1TWZnvFEMwML6I1Ijdy8hhTKuItn9Uucd8VpiHZBRh
 ImB40vjNQN0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="160695450"
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="160695450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 22:12:23 -0800
IronPort-SDR: IJbJuU7sjkkWHOn7e7i+gAP84ShePSd9DUEedrnq5OJwzMsXADC4OnJhnuRToW1V33ojPEU+co
 wPlib+C5B6bA==
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="316974454"
Received: from ghgarci1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.94])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 22:12:21 -0800
Date:   Sun, 6 Dec 2020 22:12:20 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
Message-ID: <20201207061220.a5tia24yn3x7putm@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-6-ben.widawsky@intel.com>
 <CAPcyv4g-hO5yz1bod6X+ZrL_8-6CRBvf==pB3sbuBzZmsT7Kng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g-hO5yz1bod6X+ZrL_8-6CRBvf==pB3sbuBzZmsT7Kng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-03 23:41:16, Dan Williams wrote:
> On Tue, Nov 10, 2020 at 9:44 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL devices contain an array of capabilities that describe the
> > interactions software can interact with the device, or firmware running
> > on the device. A CXL compliant device must implement the device status
> > and the mailbox capability. A CXL compliant memory device must implement
> > the memory device capability.
> >
> > Each of the capabilities can [will] provide an offset within the MMIO
> > region for interacting with the CXL device.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/cxl.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/mem.c | 58 +++++++++++++++++++++++++++---
> >  2 files changed, 143 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/cxl/cxl.h
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > new file mode 100644
> > index 000000000000..02858ae63d6d
> > --- /dev/null
> > +++ b/drivers/cxl/cxl.h
> [..]
> > +static inline u32 __cxl_raw_read_reg32(struct cxl_mem *cxlm, u32 reg)
> 
> Going through my reworks and the "raw" jumped out at me. My typical
> interpretation of "raw" in respect to register access macros is the
> difference between readl() and __raw_readl()  which means "don't do
> bus endian swizzling, and don't do a memory clobber barrier". Any
> heartburn to drop the "raw"?
> 
> ...is it only me that reacts that way?

I will drop "raw". Especially given that I intend to reuse the word in v2 for
something entirely different, it makes sense.

My idea of "raw" was that it's just unfettered access to the device's MMIO
space. No offsets, no checks. I'm not sure of a better adjective to describe
that, but if you have any in mind, I'd like to add it.
