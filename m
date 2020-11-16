Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74A02B4AE3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgKPQYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:24:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:40548 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgKPQYM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 11:24:12 -0500
IronPort-SDR: Xf1BhS9lx3wrJr92vxlhBM4MvvAC01etbe0BUhM4GQPYl+zuFyrSra5bjCCE0eUq+QS+WMwM/p
 5l9DumnoWcBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="150041643"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="150041643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 08:23:57 -0800
IronPort-SDR: GtuH+I6HYItS7UqaRCt245pQcfvTU/6rrqcQ1uzd+CnBLE13FvRtFsHswUSMU9UgSvsTwGlOYI
 YncQTj1vMkdA==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="475578324"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 08:23:54 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kehJI-0076bT-93; Mon, 16 Nov 2020 18:24:56 +0200
Date:   Mon, 16 Nov 2020 18:24:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        USB <linux-usb@vger.kernel.org>, alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201116162456.GD4077@smile.fi.intel.com>
References: <20201116094644.GP4077@smile.fi.intel.com>
 <20201116123735.GA1273179@bjorn-Precision-5520>
 <CAHp75VdYg+u5jhb9aA4w=f4WbqQLD8aUaf1MRCWp2c+CHOr67A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdYg+u5jhb9aA4w=f4WbqQLD8aUaf1MRCWp2c+CHOr67A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 03:46:44PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 16, 2020 at 2:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 16, 2020 at 11:46:44AM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 13, 2020 at 05:21:38PM -0600, Bjorn Helgaas wrote:
> > > > On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:
> > > > > Pericom PCIe-USB adapter advertises MSI, but documentation says
> > > > > "The MSI Function is not implemented on this device." in the chapters
> > > > > 7.3.27, 7.3.29-7.3.31.
> > > > >
> > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > > > Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> > > > > Reported-by: alberto.vignani@fastwebnet.it
> > > >
> > > > Is there a URL to a problem report we can include here?
> > >
> > > You mean URL to email archives or something else?
> >
> > Yes.  URL to lore email archive, bugzilla, or any other report of the
> > problem this caused, i.e., how Alberto noticed something wrong.
> 
> Okay, I'll include in v3.

I may not include that. It misses archives probably due to some footer in the message.
Closest what I have found is [1].
Do you still want me to include that link?

[1]: https://lore.kernel.org/linux-usb/20201030134826.GP4077@smile.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


