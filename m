Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA571244C33
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHNPhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:37:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:25021 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHNPhf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 11:37:35 -0400
IronPort-SDR: 1ZCUExPmd3QKLcT4uKJKSchrFJTQ5tYpDeAPTQqR87gv6Dq/KT2PX5EHUTi0IKk8HYLdtsdXtK
 tycfjVlsVrgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="142051726"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="142051726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:37:33 -0700
IronPort-SDR: jJL4EBPBgKzNCkwjurd6K9YhImSOXSySrYGL5CdSq9o7wIiKhnekRhRWqt/EFGd11bbHFbIOOw
 ZdHbQPiI3jZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325754398"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:37:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6blq-008g70-FE; Fri, 14 Aug 2020 18:37:30 +0300
Date:   Fri, 14 Aug 2020 18:37:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] resource: Introduce resource_union() for
 overlapping resources
Message-ID: <20200814153730.GQ1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 05:23:07PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Some already present users may utilize resource_union() helper.
> > Provide it for them and for wider use in the future.
> >
> > Deliberately avoid min()/max() macro as they are still parts of
> > kernel.h which is quite a burden to be included here in order
> > to avoid circular dependencies.

...

> > +       if (!resource_overlaps(r1, r2))
> > +               return false;
> 
> I tend to add empty lines after return statements like this to make
> them more clearly visible.

Okay!

> > +       r->start = r2->start < r1->start ? r2->start : r1->start;
> > +       r->end = r2->end > r1->end ? r2->end : r1->end;
> 
> Well, what about using min() and max() here?

I devoted one paragraph in the commit message to answer this. The kernel.h
(which I'm planning to split at some point) is a monster which brings more pain
than solves here. Note, this is a header file and it's quite clean from
dependencies perspective.

-- 
With Best Regards,
Andy Shevchenko


