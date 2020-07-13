Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0053821E11C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGMUDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 16:03:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:55333 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgGMUDn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 16:03:43 -0400
IronPort-SDR: buapMZNkktTt1plofib6AFdBoeSzf/XFbsPY+hrD7Fy8F127xs2QACESsvEjFvkwpdbx5S6b/9
 cLpDerfOm5/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136189776"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="136189776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 13:03:40 -0700
IronPort-SDR: d6uLjLTa6zagqz3ahed5dZ6oT6gdd1U9/ITkjlDiBVQ7mKBT/qf8V0KPQX3t87GIrv+byhOS/w
 C/qKjw02B3Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="325618018"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2020 13:03:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jv4fq-001eUs-R2; Mon, 13 Jul 2020 23:03:38 +0300
Date:   Mon, 13 Jul 2020 23:03:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] x86/PCI: Describe @reg for type1_access_ok()
Message-ID: <20200713200338.GF3703480@smile.fi.intel.com>
References: <20200713194437.11325-2-andriy.shevchenko@linux.intel.com>
 <20200713195907.GA269828@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713195907.GA269828@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 02:59:07PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 13, 2020 at 10:44:37PM +0300, Andy Shevchenko wrote:
> > Describe missed parameter in documentation of type1_access_ok().
> > Otherwise we get the following warning:
> 
> Would you mind including the "make" invocation that runs this
> checking?  I assume it's something like "make C=2
> arch/x86/pci/intel_mid_pci.o"?

No, it is not sparse, it's a kernel doc validation.
I guess `make W=1` does it, but I can repeat my command line publicly again :-)
	make W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64

> I'm not in the habit of running these checks, but maybe seeing how
> easy it is will help me and others get in the habit.
> 
> >   CHECK   arch/x86/pci/intel_mid_pci.c
> >   CC      arch/x86/pci/intel_mid_pci.o
> >   arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/pci/intel_mid_pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> > index d8af4787e616..f855e12d7bed 100644
> > --- a/arch/x86/pci/intel_mid_pci.c
> > +++ b/arch/x86/pci/intel_mid_pci.c
> > @@ -141,6 +141,7 @@ static int pci_device_update_fixed(struct pci_bus *bus, unsigned int devfn,
> >   * type1_access_ok - check whether to use type 1
> >   * @bus: bus number
> >   * @devfn: device & function in question
> > + * @reg: configuration register offset
> >   *
> >   * If the bus is on a Lincroft chip and it exists, or is not on a Lincroft at
> >   * all, the we can go ahead with any reads & writes.  If it's on a Lincroft,
> > -- 
> > 2.27.0
> > 

-- 
With Best Regards,
Andy Shevchenko


