Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B87244BC9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHNPSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:18:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:20311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgHNPSe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 11:18:34 -0400
IronPort-SDR: cKMKG9U2lW+biuo9xDZMPpjh8q4ItoyvGGdBKdfqPsNVcVPcO84DWZAyzwYXFogj+wZTktPPRl
 /oGLLUwLryUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="152070815"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="152070815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:18:33 -0700
IronPort-SDR: 9KukKRZEbBE89Aa0i5lUa9PRn36Xj+MMGtpiNX/YHfMr/1mQq8mW8wLyTwVuVA266VPoNqlOS7
 lKgl5bn2T0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325750478"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:18:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6bTS-008fum-De; Fri, 14 Aug 2020 18:18:30 +0300
Date:   Fri, 14 Aug 2020 18:18:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] PCI/ACPI: Fix description of @handle for
 acpi_is_root_bridge()
Message-ID: <20200814151830.GP1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-6-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jquT7TLLO4yJqyxgfJJ77hLQ+RtmLXVj6JATWXJxqkUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jquT7TLLO4yJqyxgfJJ77hLQ+RtmLXVj6JATWXJxqkUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 05:11:55PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Fix description of handle parameter in documentation of acpi_is_root_bridge().
> > Otherwise we get the following warning:
> >
> >   CHECK   drivers/acpi/pci_root.c
> >   drivers/acpi/pci_root.c:71: warning: Function parameter or member 'handle' not described in 'acpi_is_root_bridge'
> 
> I'm not sure why this patch doesn't go by itself.  It appears to be
> immediately applicable.

Just appears when I working on the rest of the series. Can be standalone if it
makes more sense.

> I'll apply it next week if Bjorn doesn't object.

At least fine with me, thanks!

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/acpi/pci_root.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 2a6a741896de..f723679954d7 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -62,7 +62,7 @@ static DEFINE_MUTEX(osc_lock);
> >
> >  /**
> >   * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
> > - * @handle - the ACPI CA node in question.
> > + * @handle: the ACPI CA node in question.
> >   *
> >   * Note: we could make this API take a struct acpi_device * instead, but
> >   * for now, it's more convenient to operate on an acpi_handle.
> > --
> > 2.28.0
> >

-- 
With Best Regards,
Andy Shevchenko


