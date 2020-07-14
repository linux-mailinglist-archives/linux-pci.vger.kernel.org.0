Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7325921FD55
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGNT3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 15:29:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:53508 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgGNT3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 15:29:36 -0400
IronPort-SDR: 2Gd3eE3K7BHsDck+hbMsB8Eifj7PxHjRiquK/Z1eTg0/6fMO8anWajc5iuwHgTp2u567Vl1peb
 2CO7VZOWT0bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="167131969"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="167131969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:29:36 -0700
IronPort-SDR: 9RFhiIF72ZPXvI1ewAbdtZoPSZq+agRbKVq87YF1+T9Q01kj6kZ6WCbgPC3jLLP7b7qIX97WtJ
 YeFK+z9PKzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="325935306"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2020 12:29:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jvQcQ-001pkp-23; Tue, 14 Jul 2020 22:29:34 +0300
Date:   Tue, 14 Jul 2020 22:29:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] x86/PCI: Get rid of custom x86 model comparison
Message-ID: <20200714192934.GQ3703480@smile.fi.intel.com>
References: <20200714093801.GI3703480@smile.fi.intel.com>
 <20200714190241.GA409572@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190241.GA409572@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 02:02:41PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 14, 2020 at 12:38:01PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 13, 2020 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 13, 2020 at 10:44:36PM +0300, Andy Shevchenko wrote:
> > > > Switch the platform code to use x86_id_table and accompanying API
> > > > instead of custom comparison against x86 CPU model.

...

> > > > -	case INTEL_MID_CPU_CHIP_TANGIER:
> > > > +	id = x86_match_cpu(intel_mid_cpu_ids);
> > > > +	if (id)
> > > > +		model = id->model;
> > > > +
> > > > +	switch (model) {
> > > > +	case INTEL_FAM6_ATOM_SILVERMONT_MID:
> > > 
> > > Is there a magic decoder ring somewhere that connects
> > > INTEL_MID_CPU_CHIP_TANGIER and INTEL_FAM6_ATOM_SILVERMONT_MID?
> > 
> > Yes. And the idea is to get rid of it.
> 
> OK.  You don't want to even include a mention of it in the commit log
> to help people connect the dots and verify that this change is
> correct?

I think I missed it. I will update changelog for v2.

-- 
With Best Regards,
Andy Shevchenko


