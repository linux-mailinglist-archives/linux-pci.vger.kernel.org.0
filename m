Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236DB21EC4B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGNJJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 05:09:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:34301 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgGNJJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 05:09:52 -0400
IronPort-SDR: QZf+ywFOmXW+BDs0cq5xGhy0yq+kuEFugkkQ+e2PmOSTOWRrvh0Sbd18Wdd06symZJZq1Ch+TD
 7/9zsMFXe+Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128934101"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128934101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:09:52 -0700
IronPort-SDR: To/RkNSGx3fFYl13un5xQVMNYxaKvHv5pJPL5tDfdqpXLHxDCwe2Ep08UXoXT76NMIqgqOfCOh
 WqezfZokVaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="325784667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2020 02:09:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jvGwg-001kQh-Dc; Tue, 14 Jul 2020 12:09:50 +0300
Date:   Tue, 14 Jul 2020 12:09:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] x86/PCI: Describe @reg for type1_access_ok()
Message-ID: <20200714090950.GG3703480@smile.fi.intel.com>
References: <20200713200338.GF3703480@smile.fi.intel.com>
 <20200713210240.GA273404@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713210240.GA273404@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 04:02:40PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 13, 2020 at 11:03:38PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 13, 2020 at 02:59:07PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 13, 2020 at 10:44:37PM +0300, Andy Shevchenko wrote:
> > > > Describe missed parameter in documentation of type1_access_ok().
> > > > Otherwise we get the following warning:
> > > 
> > > Would you mind including the "make" invocation that runs this
> > > checking?  I assume it's something like "make C=2
> > > arch/x86/pci/intel_mid_pci.o"?
> > 
> > No, it is not sparse, it's a kernel doc validation.
> > I guess `make W=1` does it, but I can repeat my command line publicly again :-)
> > 	make W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
> 
> Thanks.  "make W=1 arch/x86/pci/" is enough.  I would just put this in
> the commit log, e.g.,
> 
>   Otherwise "make W=1 arch/x86/pci/" produces the following warning:
> 
>     CHECK   arch/x86/pci/intel_mid_pci.c
>     CC      arch/x86/pci/intel_mid_pci.o
>     arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'

Will do.

-- 
With Best Regards,
Andy Shevchenko


