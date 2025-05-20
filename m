Return-Path: <linux-pci+bounces-28137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8670ABE3CF
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E2D7A1EB0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8B250C06;
	Tue, 20 May 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAU8LXRP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337C1D8DE1;
	Tue, 20 May 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769901; cv=none; b=CfsGPhrSBoK0/0tbr4tqrRshG30gD6+cxeW7RTjknGiP7xl3fCta1KIb+rYK+XUyweUXN00MDM5HyW5OYlxodaDviRmMTeURulOgU9DOL0+q4MjJbMXRkk8h8xVaGrGarS61QoC1x7QlInYM3XI/oEF6O5nui00XLha261N4ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769901; c=relaxed/simple;
	bh=YtynzzOjmtbSgflGVRNroS8xiOdA61c9iv0Eb1pXHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ROXIGJIrOuWD/ezB+YXqJTQNh8ejiy4YQ8MkEgu749JQQVACo72XuxxJj9z5GHbqnMwOZMynL9SWomw/fs5P7qsKKtxdgtXlN07KXCloLGUZ1ncgQGrIv7Q8wNHju5+ekHIpGjNXllEDGEbRWaxwd52rmVZAQVShDo2dPEodlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAU8LXRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB804C4CEE9;
	Tue, 20 May 2025 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747769901;
	bh=YtynzzOjmtbSgflGVRNroS8xiOdA61c9iv0Eb1pXHsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IAU8LXRPLq8n2P+sOZB+ws0nPRSX8pkj5PY+JNtGXH7t10US27FGmOh4dfDUb6kT/
	 5n2Fj9Q6y5rYwA44U/T7OSUv5XSaJsbWuR1ZpP8SJgLxw6bXj2A+Uy3zZZqNhZqXJj
	 hGfb5FGaoJwDgnS/jnKp596+PZLPm4xgctVAxPfziliuvt597Ky1axMJrQEzB6595q
	 c8XrS1Xz/W/FkdVm8UqwgGjOnTsjrgoqP1u5nYQd7YHUSJmT3RguNwHqCrJ6tMtgYf
	 Ey5hatKp0J+he1918aDcyhhNm9Csz27wwrYiVA5XkZL3YKo7j31nBe2+Seho6u/Yem
	 wSw07Zq4mIJIQ==
Date: Tue, 20 May 2025 14:38:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250520193819.GA1318016@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a983acbd-bf6e-63df-a3cc-e4d61a602537@linux.intel.com>

On Tue, May 20, 2025 at 02:55:32PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> 
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and uncorrectable
> > errors that use the kernel defaults (10 per 5s).
> > 
> > There are two AER logging entry points:
> > 
> >   - aer_print_error() is used by DPC and native AER
> > 
> >   - pci_print_aer() is used by GHES and CXL
> > 
> > The native AER aer_print_error() case includes a loop that may log details
> > from multiple devices.  This is ratelimited by the union of ratelimits for
> > these devices, set by add_error_device(), which collects the devices.  If
> > no such device is found, the Error Source message is ratelimited by the
> > Root Port or RCEC that received the ERR_* message.
> > 
> > The DPC aer_print_error() case is currently not ratelimited.
> > 
> > The GHES and CXL pci_print_aer() cases are ratelimited by the Error Source
> > device.

> >  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
> >  {
> > +	/*
> > +	 * Ratelimit AER log messages.  Generally we add the Error Source
> > +	 * device, but there are is_error_source() cases that can result in
> > +	 * multiple devices being added here, so we OR them all together.
> 
> I can see the code uses OR ;-) but I wasn't helpful because this comment 
> didn't explain why at all. As this ratelimit thing is using reverse logic 
> to begin with, this is a very tricky bit.
> 
> Perhaps something less vague like:
> 
> ... we ratelimit if all devices have reached their ratelimit.
> 
> Assuming that was the intention here? (I'm not sure.)

My intention was that if there's any downstream device that has an
unmasked error logged and it has not reached its ratelimit, we should
log messages for all devices with errors logged.  Does something like
this help?

  /*
   * Ratelimit AER log messages.  "dev" is either the source
   * identified by the root's Error Source ID or it has an unmasked
   * error logged in its own AER Capability.  If any of these devices
   * has not reached its ratelimit, log messages for all of them.
   * Messages are emitted when e_info->ratelimit is non-zero.
   *
   * Note that e_info->ratelimit was already initialized to 1 for the
   * ERR_FATAL case.
   */

The ERR_FATAL case is from this post-v6 change that I haven't posted
yet:

  aer_isr_one_error(...)
  {
    ...
    if (status & PCI_ERR_ROOT_UNCOR_RCV) {
      int fatal = status & PCI_ERR_ROOT_FATAL_RCV;
      struct aer_err_info e_info = {
        ...
 +      .ratelimit = fatal ? 1 : 0;


> > +	 */
> >  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> >  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> > +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);
> >  		e_info->error_dev_num++;
> >  		return 0;
> >  	}

> > @@ -1147,9 +1183,10 @@ static void aer_recover_work_func(struct work_struct *work)
> >  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> >  						   entry.devfn);
> >  		if (!pdev) {
> > -			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> > -			       entry.domain, entry.bus,
> > -			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> > +			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
> 
> This case was not mentioned in the changelog.

Sharp eyes!  What do you think of this commit log text?

  The CXL pci_print_aer() case is ratelimited by the Error Source device.

  The GHES pci_print_aer() case is via aer_recover_work_func(), which
  searches for the Error Source device.  If the device is not found, there's
  no per-device ratelimit, so we use a system-wide ratelimit that covers all
  error types (correctable, non-fatal, and fatal).

This isn't really ideal because in pci_print_aer(), the struct
aer_capability_regs has already been filled by firmware and the
logging doesn't read any registers from the device at all.

However, pci_print_aer() *does* want the pci_dev for statistics and
tracing (pci_dev_aer_stats_incr()) and, of course, for the aer_printks
themselves.

We could leave this pr_err() completely alone; hopefully it's a rare
case.  I think the CXL path just silently skips pci_print_aer() if
this happens.

Eventually I would really like the native AER path to start by doing
whatever firmware is doing, e.g., fill in struct aer_capability_regs,
so the core of the AER handling could be identical between native AER
and GHES/CXL.  If we could do that, maybe we could figure out a
cleaner way to handle this corner case.

