Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC97E1DA4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 16:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbfJWOD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 10:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJWOD2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 10:03:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D82121906;
        Wed, 23 Oct 2019 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571839407;
        bh=e6ndqxJ5BQltdcOadIuz8he5A76pb9Kj1tOy1ThEWWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b6HJoPOia8Pgl1nvUfx6ESrPXWMlX4COz0I7+bqbsAkKS1VIpSG12vKIr+anlRrKJ
         2EFgzOU+hoWL2oSjsz/c3Tb4piCaV1W7ZTHPQV7FaseVOISC1dY+bsogFLd21T39d4
         YiEL6cNPi/VIbwfF93TkuV83+h8gvk+c1HlbhJT0=
Date:   Wed, 23 Oct 2019 09:03:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20191023140325.GA156673@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0183D447FD3ADF6F82979439806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 09:08:42AM +0000, Nicholas Johnson wrote:
> On Tue, Oct 08, 2019 at 02:38:12PM +0300, mika.westerberg@linux.intel.com wrote:
> > On Fri, Jul 26, 2019 at 12:53:19PM +0000, Nicholas Johnson wrote:

> > >  	/*
> > > -	 * Calculate the total amount of extra resource space we can
> > > -	 * pass to bridges below this one.  This is basically the
> > > -	 * extra space reduced by the minimal required space for the
> > > -	 * non-hotplug bridges.
> > > +	 * Reduce the available resource space by what the
> > > +	 * bridge and devices below it occupy.
> > 
> > This can be widen:
> I avoided changing comments because Bjorn said it creates distracting 
> noise. But I am considering changing tactics because what I have been 
> doing has not been working.

I think Mika's point was not that you should avoid changing the
comment, but that your new comment could be rewrapped so it used the
whole 80 column width, which matches the rest of the file.  That's
trivial to do and if you don't do it I can do it while applying the
patch.

> > 	/*
> > 	 * Reduce the available resource space by what the bridge and
> > 	 * devices below it occupy.
> > 	 */
> > 
> > >  	 */
> > > -	remaining_io = available_io;
> > > -	remaining_mmio = available_mmio;
> > > -	remaining_mmio_pref = available_mmio_pref;
> > > -
> > >  	for_each_pci_bridge(dev, bus) {
> > > -		const struct resource *res;
> > > +		struct resource *res;
> > > +		resource_size_t used_size;
> > 
> > Some people like "reverse christmas tree" format better:
> We had this discussion a while ago, and Bjorn piped in and said it is 
> not enforced. However, I will give it a go this time.

I usually don't request changes in the order, so it doesn't really
matter to me, but I personally put the declarations in the order of
their use in the code below.

> > 		resource_size_t used_size;
> > 		struct resource *res;

> > > -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> > > -						       mmio_pref);
> > > +		io.start = io.end + 1;
> > 
> > I think you can also write it like:
> > 
> > 		io.start += io_per_hp;
> You are possibly correct - and it is impressive that you saw that. I 
> never did. The way that I have written it fits in with the thought 
> patterns I used to create it ("set the start of the next window to be 
> just after the end of the last"). I will take this suggestion as you 
> wanting it written that way (provided testing goes fine).
> 
> > > +		mmio.start = mmio.end + 1;
> > > +		mmio_pref.start = mmio_pref.end + 1;

I assume you'll do that for mmio.start and mmio_pref.start as well?

Bjorn
