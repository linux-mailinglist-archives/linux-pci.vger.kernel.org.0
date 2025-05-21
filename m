Return-Path: <linux-pci+bounces-28241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83698AC0037
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022797B8D54
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BD23D2BD;
	Wed, 21 May 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFomEtSR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCF23BCFF;
	Wed, 21 May 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868072; cv=none; b=WCXhwJMaNHIfU+hCIp+iuoMbWLb5718XgGpvG+F1US0Yu1QNdKzBnA/mUNZs2Rjw1hrq8sE8HjkQeoe5KoznvWS0EwrGuGJ2jztb7ClSSBlqmgu1t+0rsdx9urCP4umcoT1GdedlBUeSRx6k4ERQCEos1HPq4CiPs7jFzOLBtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868072; c=relaxed/simple;
	bh=I6Z5U5lSAJhlhHvi273xITXuZaKvKIuYyjYt6JGuJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qwMyj8WptIpmsgYD7cJoxjmh51W/KgRIIPSN4CDqaMFNQwnLF/4tCLFq+gEIj4XQ94reg5N8M6h5l1AIENRe57mmZkDrIE6TbYMOjEt3LoPiGG7H679ZVeWF1Lw7Jq1YomBilJGLzxk2IqMxCWq+mpJwP7vFOYKBwzmKOBxOzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFomEtSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB0DC4CEE4;
	Wed, 21 May 2025 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747868071;
	bh=I6Z5U5lSAJhlhHvi273xITXuZaKvKIuYyjYt6JGuJv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JFomEtSRx29eJvJlGSNZulJOZmily2bMweU6UfOd3orZFeC8sQGMGclabfwMbISKc
	 y7CNTyYRBRFs7UFrJuLCNHJfnw7Ep/9tU5h0v3iXMAe4591zPXZmKpQ3GVmy/cDiSD
	 fXA2f2VQasXQFySdZS7/qFYTcXHse4dsrC1RJHZIB7iEsKTUByioE6VjfldkHTY3R8
	 PrqbPQpyzz4iUC96TVUR2rACv2jUkPMCRiZEk5SeJmArlWrYptAM002ycWui/lOvm2
	 FODi1NHio73ZlBez22BM0THaKlmeIoEj07HsOQNE7tmc1vIvidY30dQVHuukNM8+Ki
	 JzVa0qondhbhQ==
Date: Wed, 21 May 2025 17:54:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <20250521225430.GA1442014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521113121.000067ce@huawei.com>

On Wed, May 21, 2025 at 11:31:21AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:32 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and non-fatal
> > uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
> > fatal errors is not ratelimited.
> 
> See below. I'm not sure that logging of fatal error should affect the rate
> for non fatal errors + the rate limit infrastructure kind of assumes
> that you only call it if you are planning to respect it's decision.
> 
> Given overall aim is to restrict rates, maybe we don't care if we sometimes
> throttle earlier that we might expect with a simpler separation of what
> is being limited.
> 
> I don't mind strongly either way.

> > @@ -593,7 +593,8 @@ struct aer_err_info {
> >  	unsigned int id:16;
> >  
> >  	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> > -	unsigned int __pad1:5;
> > +	unsigned int ratelimit:1;	/* 0=skip, 1=print */
> 
> That naming is less than intuitive.  Maybe expand it to ratelimit_print or
> something like that.

True, although it does match uses like "if (aer_ratelimit(...))"

I'll try ratelimit_print and see how you like it :)

> > +	unsigned int __pad1:4;
> >  	unsigned int multi_error_valid:1;
> >  
> >  	unsigned int first_error:5;
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 4f1bff0f000f..f9e684ac7878 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> 
> > @@ -815,8 +843,19 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> >   */
> >  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
> >  {
> > +	/*
> > +	 * Ratelimit AER log messages.  "dev" is either the source
> > +	 * identified by the root's Error Source ID or it has an unmasked
> > +	 * error logged in its own AER Capability.  If any of these devices
> > +	 * has not reached its ratelimit, log messages for all of them.
> > +	 * Messages are emitted when "e_info->ratelimit" is non-zero.
> > +	 *
> > +	 * Note that "e_info->ratelimit" was already initialized to 1 for the
> > +	 * ERR_FATAL case.
> > +	 */
> >  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> >  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> > +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);
> 
> So this is a little odd.  I think it works but there is code inside
> __ratelimit that I think we should not be calling for that
> ERROR_FATAL case (whether we should call lots of times for each
> device isn't obvious either but maybe that is more valid).
> 
> In the event of it already being 1 due to ERROR_FATAL you will
> falsely trigger a potential print from inside __ratelimit() if we
> were rate limited and no longer are but only skipped FATAL prints.
> My concern is that function is kind of assuming it's only called in
> cases where a rate limit decision is being made and the
> implementation may change in future).

Hmmm.  That's pretty subtle, thanks for catching this.

In the light of day, ".ratelimit = fatal ? 1 : 0" looks a bit sketchy.
If we want to avoid ratelimiting AER_FATAL, maybe aer_ratelimit()
should just return 1 ("print") unconditionally in that case, without
calling __ratelimit():

  static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
  {
    struct ratelimit_state *ratelimit;

    if (severity == AER_FATAL)
      return 1;       /* AER_FATAL not ratelimited */

    if (severity == AER_CORRECTABLE)
      ratelimit = &dev->aer_info->cor_log_ratelimit;
    else
      ratelimit = &dev->aer_info->uncor_log_ratelimit;

    return __ratelimit(ratelimit);
  }

That still leaves this question of how to deal with info->dev[] when
there's more than one entry, which is kind of an annoying case that
only happens for the native AER path.

I think it's because for a single AER interrupt from an RP/RCEC, we
collect the root info in one struct aer_err_info and scrape all the
downstream devices for anything interesting.  We visit each downstream
device and is_error_source() reads its status register, but we only
keep the pci_dev pointer, so aer_get_device_error_info() has to read
the status registers *again*.  This all seems kind of obtuse.

The point of the OR above in add_error_device() was to try to match up
RP/RCEC logging with downstream device logging so they're ratelimited
the same.  If we ratelimit the Error Source ID based on the RP/RCEC
and the details based on the downstream devices individually, they'll
get out of sync, so sometimes we'll print an Error Source ID and elide
the details and vice versa.

I wanted to make it so that if we log downstream details, we also log
the Error Source ID.  But maybe we should ratelimit downstream devices
individually (instead of doing this weird union) and make the RP/RCEC
part more explicit, e.g.,

  add_error_device(...)
  {
    int i = e_info->error_dev_num;

    e_info->dev[i] = pci_dev_get(dev);
    e_info->error_dev_num++;

    if (aer_ratelimit(dev, e_info->severity)) {
      e_info->root_ratelimit_print = 1;
      e_info->ratelimit_print[i] = 1;
    }
  }

> https://elixir.bootlin.com/linux/v6.14.7/source/lib/ratelimit.c#L56
> 
> Maybe, 
> 		if (!info->ratelimit)
> 			e_info->ratelimit = aer_ratelimit(dev, e_info->severity);
> is an alternative option.
> That allows a multiplication factor on the rate as all device count for 1.

