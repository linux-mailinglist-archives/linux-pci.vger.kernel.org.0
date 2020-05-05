Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F41C5ACC
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgEEPPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:15:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:20960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbgEEPPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:15:37 -0400
IronPort-SDR: qYfgMSE1ZOVyoy0vb9MX3/8oxUuDmt9+Lqe4dvN4oo1bwS3hFQ3EWWnEQ/LKhSA/ia+DRzbhAL
 b3+xeIVOXRJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:15:36 -0700
IronPort-SDR: 3cdTnJXA/w29RQMHFcA9W1TjXC+gEg+UH2QP0tqMbsAzyThNWuyYvhdFx9gf9U2iUU4btjFfQa
 tZdKZDsRcLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="461425889"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 05 May 2020 08:15:36 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0FE8058048A;
        Tue,  5 May 2020 08:15:36 -0700 (PDT)
Message-ID: <fb99d5d1fc400134ed152ebd6ecd068fe6343437.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] mfd: Intel Platform Monitoring Technology support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date:   Tue, 05 May 2020 08:15:35 -0700
In-Reply-To: <CAHp75VcX=W3RGZpDVMDot+yfXH-N=gE=Ny7wSTdk33u8MUPjsg@mail.gmail.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
         <20200505023149.11630-1-david.e.box@linux.intel.com>
         <CAHp75VcX=W3RGZpDVMDot+yfXH-N=gE=Ny7wSTdk33u8MUPjsg@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-05-05 at 12:02 +0300, Andy Shevchenko wrote:
> On Tue, May 5, 2020 at 5:32 AM David E. Box <
> david.e.box@linux.intel.com> wrote:
> > Intel Platform Monitoring Technology (PMT) is an architecture for
> > enumerating and accessing hardware monitoring facilities. PMT
> > supports
> > multiple types of monitoring capabilities. Capabilities are
> > discovered
> > using PCIe DVSEC with the Intel VID. Each capability is discovered
> > as a
> > separate DVSEC instance in a device's config space. This driver
> > uses MFD to
> > manage the creation of platform devices for each type so that they
> > may be
> > controlled by their own drivers (to be introduced).  Support is
> > included
> > for the 3 current capability types, Telemetry, Watcher, and
> > Crashlog. The
> > features are available on new Intel platforms starting from Tiger
> > Lake for
> > which support is added. Tiger Lake however will not support Watcher
> > and
> > Crashlog even though the capabilities appear on the device. So add
> > a quirk
> > facility and use it to disable them.
> 
> ...
> 
> >  include/linux/intel-dvsec.h |  44 +++++++++
> 
> I guess it's no go for a such header, since we may end up with tons
> of
> a such. Perhaps simple pcie-dvsec.h ?

Too general. Nothing in here applies to all PCIE DVSEC capabilities.
The file describes only the vendor defined space in a DVSEC region.

> 
> ...
> 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8783,6 +8783,11 @@ S:       Maintained
> >  F:     arch/x86/include/asm/intel_telemetry.h
> >  F:     drivers/platform/x86/intel_telemetry*
> > 
> > +INTEL PMT DRIVER
> > +M:     "David E. Box" <david.e.box@linux.intel.com>
> > +S:     Maintained
> > +F:     drivers/mfd/intel_pmt.c
> 
> I believe you forgot to run parse-maintainers.pl --order
> --input=MAINTAINERS --output=MAINTAINERS
> 
> ...
> 
> > +       info = devm_kmemdup(&pdev->dev, (void *)id->driver_data,
> > sizeof(*info),
> > +                           GFP_KERNEL);
> > +
> 
> Extra blank line.
> 
> > +       if (!info)
> > +               return -ENOMEM;
> > +
> > +       while ((pos = pci_find_next_ext_capability(pdev, pos,
> > PCI_EXT_CAP_ID_DVSEC))) {
> > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1,
> > &vid);
> > +               if (vid != PCI_VENDOR_ID_INTEL)
> > +                       continue;
> 
> Perhaps a candidate for for_each_vendor_cap() macro in pcie-dvsec.h.
> Or how is it done for the rest of capabilities?
> 
> > +       }
> 
> ...
> 
> > +static const struct pci_device_id pmt_pci_ids[] = {
> > +       /* TGL */
> > +       { PCI_VDEVICE(INTEL, 0x9a0d), (kernel_ulong_t)&tgl_info },
> 
> PCI_DEVICE_DATA()?

Ack on the rest of the changes.

