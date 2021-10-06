Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1282B424862
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhJFVAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 17:00:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:54692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhJFVAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 17:00:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226412795"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226412795"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 13:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="713074765"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2021 13:58:22 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id B6EEC5807FC;
        Wed,  6 Oct 2021 13:58:22 -0700 (PDT)
Message-ID: <668f263e1d2606ad7485c40ce41933300ec4b8a3.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Leon Romanovsky <leon@kernel.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Wed, 06 Oct 2021 13:58:22 -0700
In-Reply-To: <YV1lTMwBSVlvadiG@unreal>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
         <20211001012815.1999501-3-david.e.box@linux.intel.com>
         <YV1lTMwBSVlvadiG@unreal>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-10-06 at 11:58 +0300, Leon Romanovsky wrote:
> On Thu, Sep 30, 2021 at 06:28:12PM -0700, David E. Box wrote:
> > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > structures may also be used by Intel to indicate support for other
> > capabilities unrelated to PMT.  The Out Of Band Management Services Module
> > (OOBMSM) is an example of a device that can have both PMT and non-PMT
> > capabilities. In order to support these capabilities it is necessary to
> > modify the intel_pmt driver to handle the creation of platform devices more
> > generically. To that end the following changes are made.
> > 
> > Convert the driver and child drivers from MFD to the Auxiliary Bus. This
> > architecture is more suitable anyway since the driver partitions a
> > multifunctional PCIe device. This also moves the driver out of the MFD
> > subsystem and into platform/x86/intel.
> > 
> > Before, devices were named by their capability (e.g. pmt_telemetry).
> > Instead, generically name them by their capability ID (e.g.
> > intel_extended_cap.2). This allows the IDs to be created automatically,
> > minimizing the code needed to support future capabilities. However, to
> > ensure that unsupported devices aren't created, use an allow list to
> > specify supported capabilities. Along these lines, rename the driver from
> > intel_pmt to intel_extended_caps to better reflect the purpose.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > 
> > V1:     New patch. However incorporates some elements of [1] which was
> >         dropped. Namely enumerating features generically and creating an
> >         allow list. Also cleans up probe by moving some code to functions
> >         and using a bool instead of an int to track whether a device was
> >         added.
> > 
> > [1] https://lore.kernel.org/all/20210922213007.2738388-3-david.e.box@linux.intel.com/
> 
> <...>
> 
> > +static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +       struct extended_caps_platform_info *info;
> > +       bool have_devices = false;
> > +       unsigned long quirks = 0;
> > +       int ret;
> > +
> > +       ret = pcim_enable_device(pdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       info = (struct extended_caps_platform_info *)id->driver_data;
> 
> pci_get_drvdata() in all places and no need to cast void *.

This is coming from the id not the pdev. The data here is type kernel_ulong_t.

> 
> > +       if (info)
> > +               quirks = info->quirks;
> > +
> > +       have_devices |= extended_caps_walk_dvsec(pdev, quirks);
> > +
> > +       if (info && (info->quirks & EXT_CAPS_QUIRK_NO_DVSEC))
> > +               have_devices |= extended_caps_walk_header(pdev, quirks, info->capabilities);
> > +
> > +       if (!have_devices)
> > +               return -ENODEV;
> > +
> > +       return 0;
> > +}
> 
> <...>
> 
> > -static struct platform_driver pmt_telem_driver = {
> > -       .driver = {
> > -               .name   = TELEM_DEV_NAME,
> > -       },
> > -       .remove = pmt_telem_remove,
> > -       .probe  = pmt_telem_probe,
> > +static const struct auxiliary_device_id pmt_telem_aux_id_table[] = {
> > +       { .name = "intel_extended_caps.2", },
> 
> Why "2" in the name?

This is being changed to a string for the next version after similar comment. Thanks.

David

> 
> Thanks
> 
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, pmt_telem_aux_id_table);
> > +
> > +static struct auxiliary_driver pmt_telem_aux_driver = {
> > +       .id_table       = pmt_telem_aux_id_table,
> > +       .remove         = pmt_telem_remove,
> > +       .probe          = pmt_telem_probe,
> >  };
> >  


