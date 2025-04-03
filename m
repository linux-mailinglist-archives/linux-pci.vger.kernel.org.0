Return-Path: <linux-pci+bounces-25246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856BCA7A9E1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CB7A70FC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8225335B;
	Thu,  3 Apr 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3IX3tGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EE253356
	for <linux-pci@vger.kernel.org>; Thu,  3 Apr 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706947; cv=none; b=EubThoAug7a0GAl6wDJf8y0WFhexVbUQNvKI/+UelsAUCH0aA5OSkqYPXnvVD17w98kVPUGG98CrOw4lN/jxcOJGieko/fgr6Vg1Mp47BsIBKLLYzhSjIeajSKGUh29Y6vcXZ5SQlcNTHVOUvhcyyk94ML/klAXI/zlQ+ONJHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706947; c=relaxed/simple;
	bh=ZxErGwuD05sfnW7lJ1VUV4+I4T/2s5MxfSXzovV5LYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj8XOkQ3mEhbqDelYNX712CcSq4qPZ9eabaCeaacRjE7FiV6FlAd+x3f9zwlkyJWfcZpmV/t52680U7SHkFdFaoqeTjpWAFX1/FCVC7E5IxUJXAp3PjcIhgYDYiw78P/dORhp4kip48YHxgctLCFPYYTpcnScmTXel+Yd2aQI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3IX3tGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BD2C4CEEA;
	Thu,  3 Apr 2025 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706947;
	bh=ZxErGwuD05sfnW7lJ1VUV4+I4T/2s5MxfSXzovV5LYU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=M3IX3tGxkWbh3XllMwebNUhjQQkpAlRQYuyv3HbICwHD9KpJ9McWCnFh5Sdfuz8b+
	 ZQSVOte1B3XScnNnAJ4CQc+eDTpORQYJTFH2dlP+fqmJPp8IA/pCO8cdqu3uHThe0z
	 52NCewdQ9glloOyg4SHln/WnrWnhOzWwHSpzfKc7cFQMere6mnf+62/44I4Zh3QVXA
	 8WMPa5xEzU3kxtm2/kAXL1xiJF39VOogqh+3jOjgHSIBlSAB5wd7ZoC3Oki8V6dQvt
	 fgnUrIFqDCBaHDrZkQAWRvPft6m9lzLHdiKuexlO4hhlJm8fs/JgjcMNJBp0m+N7SF
	 fXINWfEjVf0ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA3A5CE0799; Thu,  3 Apr 2025 12:02:26 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:02:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <82e50706-77f3-4268-b25d-cf5b2ffbc68e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250321015806.954866-1-pandoh@google.com>
 <20250321015806.954866-7-pandoh@google.com>
 <614abb3f-fd4f-40e1-8e22-3c58bc2314b0@paulmck-laptop>
 <CAMC_AXUNNCDVqUufwWHrXZU8URz3VzZL4ifwQaHf23e0BCTB0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXUNNCDVqUufwWHrXZU8URz3VzZL4ifwQaHf23e0BCTB0Q@mail.gmail.com>

On Thu, Mar 27, 2025 at 03:49:12PM -0700, Jon Pan-Doh wrote:
> On Tue, Mar 25, 2025 at 10:17 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
> > >
> > >  struct aer_err_info {
> > >       struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> > > +     bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];
> >
> > In my stop-the-bleeding patch, I pass this as an argument to the functions
> > needing it, but this works fine too.  Yes, this approach does consume
> > a bit more storage, but I doubt that it is enough to matter.
> 
> The reason for the boolean array is that we want to eval/use the same
> ratelimit for two log functions (aer_print_rp_info() and
> aer_print_error()). In past versions[1], I removed aer_print_rp_info()
> which simplified the ratelimit eval (i.e. directly eval within
> aer_print_error()). However, others found it helpful to keep the root
> port logs as it directly showed the linkage from interrupt on root
> port -> error source device(s).
> 
> > The main concern is that either all information for a given error is
> > printed or none of it is, to avoid confusion.  (There will of course be
> > the possibility of partial drops due to buffer overruns further down
> > the console-log pipeline, but no need for additional opportunities
> > for confusion.)
> >
> > For this boolean array to provide this property, the error path for a
> > given device must be single threaded, for example, only one interrupt
> > handler at a time.  Is this the case?
> 
> I believe so. AER uses threaded irq where interrupt processing is done
> by storing/reading info from a FIFO (i.e. serializes handling).

I traced out the call trees in v6.14 and got the following:

------------------------------------------------------------------------

Call Tree for aer_print_port_info().  (This is the old name, with Jon’s
patch applied this is aer_print_rp_info().)

	aer_isr() is a threaded interrupt handler.
		aer_isr() invokes aer_isr_one_error().
			aer_isr_one_error() invokes aer_print_port_info().


Call Tree for aer_print_error()

	aer_isr() is a threaded interrupt handler.
		aer_isr() invokes aer_isr_one_error().
			aer_isr_one_error() invokes aer_process_err_devices().
				aer_process_err_devices() invokes aer_print_error().

	dpc_handler() is a threaded interrupt handler.
		dpc_handler() invokes dpc_process_error().
			dpc_process_error() invokes aer_print_error()

	edr_handle_event() is an ACPI notifier.
		edr_handle_event() invokes dpc_process_error().
			dpc_process_error() invokes aer_print_error().

------------------------------------------------------------------------

So ___ratelimit() could be invoked in aer_isr_one_error() and the result
could be passed down directly to aer_print_port_info() on the one hand
and to aer_print_error() via aer_process_err_devices() on the other.

And ___ratelimit() could be invoked in dpc_process_error() and the
result passed directly to aer_print_error().

This would permit the ratelimit_state structures to be placed in
the portion of the pci_dev structure under #ifdef CONFIG_PCIEAER,
avoiding the need to search the enclosing structure.

Presumably using a helper function that invokes __ratelimit() for
CONFIG_PCIEAER=y kernels and just returns true otherwise.

Or am I missing something here?  (Quite possibly your root-port points
below...)

> > > @@ -722,21 +750,31 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> > >  out:
> > >       if (info->id && info->error_dev_num > 1 && info->id == id)
> > >               pci_err(dev, "  Error of this Agent is reported first\n");
> > > -
> > > -     trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> > > -                     info->severity, info->tlp_header_valid, &info->tlp);
> > >  }
> > >
> > >  static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
> > >  {
> > >       u8 bus = info->id >> 8;
> > >       u8 devfn = info->id & 0xff;
> > > +     struct pci_dev *dev;
> > > +     bool ratelimited = false;
> > > +     int i;
> > >
> > > -     pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> > > -              info->multi_error_valid ? "Multiple " : "",
> > > -              aer_error_severity_string[info->severity],
> > > -              pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> > > -              PCI_FUNC(devfn));
> > > +     /* extract endpoint device ratelimit */
> > > +     for (i = 0; i < info->error_dev_num; i++) {
> > > +             dev = info->dev[i];
> > > +             if (info->id == pci_dev_id(dev)) {
> > > +                     ratelimited = info->ratelimited[i];
> > > +                     break;
> > > +             }
> > > +     }
> >
> > I cannot resist noting that passing a "ratelimited" argument to this
> > function would make it unnecessary to search this array.  This would
> > require doing rate-limiting checks in aer_isr_one_error(), which looks
> > like it should work.  Then again, I do not claim to be familiar with
> > this AER code.
> >
> > The "ratelimited" arguments would need to be added to
> > aer_print_port_info(), aer_process_err_devices(), and aer_print_error().
> > Maybe some that I have missed.  Or is there some handoff to
> > softirq or workqueues that I missed?
> 
> We are not ratelimiting the root port, but the source device that
> generated the interrupt on the root port. Thus, we have to search the
> array at some point. We could bake this into the topology traversal
> (link PCI ID with pci_dev) as another param to aer_error_info, but the
> array is <= 8 (i.e. small).
> 
> The root port itself can generate AER notifications. Ratelimiting by
> both its own errors as well as downstream devices will most likely
> mask its own errors.
> 
> [1] https://lore.kernel.org/linux-pci/20250214023543.992372-2-pandoh@google.com/

OK, I see that aer_isr_one_error() invokes aer_print_port_info(),
and only then invokes find_source_device(), and only after that invokes
aer_process_err_devices().  And it appears that aer_process_err_devices()
iterates over the devices and chooses one, which it passes to
aer_print_error().

Is the logging by aer_print_port_info() and by the subsequent call
to aer_print_error() to be throttled as a group, but specific to the
non-root device passed to aer_print_error()?  Or should the logging by
aer_print_port_info() be throttled specific to the root device with the
subsequent call to aer_print_error() throttled separately specific to
the non-root device?

Or have I lost the thread completely?

							Thanx, Paul

