Return-Path: <linux-pci+bounces-38757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C4BF1A9C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9564245AF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9631B11F;
	Mon, 20 Oct 2025 13:54:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A62F8BCB;
	Mon, 20 Oct 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968445; cv=none; b=gj86AtH/D7GJ+2RkXbyXoKteHf7wugasJFEO+wPM5xC+HQX4AljZ7wtiVpjk0R3rT0v7bIVtJ9jZjzN9s5IuKN8fG+QZOM0TUHgZuI/3prQCzKqKjQZzjAU+UejzL0oNGbwBZsUOa0+4EcREbv0WcC6frXtlEzgsEWkw6hKdukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968445; c=relaxed/simple;
	bh=J01PKdVb+PAYTLqN3ZPbTIlYwpZAt9dDt6JqgQrDOIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7X7E8/92m+HciSrxtFbQ2OLbfPyT/r2Zuu4RDmapkF6mnkwUSXbWjo5CRnkOPDWDxFqRQq+2bgVhm2BQg+4mSrotbhp0wyeaiolSJhrQTcob7OgR9UVGSUNtK8xNSE0pYJnxa/14/TAeRpZtrTUegkvREwVZVqXhWTc2+syEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 210FD20083D3;
	Mon, 20 Oct 2025 15:54:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0A1E44A12; Mon, 20 Oct 2025 15:54:00 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:54:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <aPY--DJnNam9ejpT@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
 <aPYKe1UKKkR7qrt1@wunner.de>
 <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>

On Mon, Oct 20, 2025 at 08:58:55PM +0800, Shuai Xue wrote:
> ??? 2025/10/20 18:10, Lukas Wunner ??????:
> > On Wed, Oct 15, 2025 at 10:41:57AM +0800, Shuai Xue wrote:
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -253,6 +254,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > >   			pci_warn(bridge, "subordinate device reset failed\n");
> > >   			goto failed;
> > >   		}
> > > +
> > > +		/* Link recovered, report fatal errors of RCiEP or EP */
> > > +		if (state == pci_channel_io_frozen &&
> > > +		    (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END)) {
> > > +			aer_add_error_device(&info, dev);
> > > +			info.severity = AER_FATAL;
> > > +			if (aer_get_device_error_info(&info, 0, true))
> > > +				aer_print_error(&info, 0);
> > > +			pci_dev_put(dev);
> > > +		}
> > 
> > Where is the the pci_dev_get() to balance the pci_dev_put() here?
> 
> The corresponding pci_dev_get() is called in add_error_device(). Please
> refer to commit 60271ab044a5 ("PCI/AER: Take reference on error
> devices") which introduced this reference counting mechanism.

That is non-obvious and needs a code comment.

> > It feels awkward to leak AER-specific details into pcie_do_recovery().
> > That function is supposed to implement the flow described in
> > Documentation/PCI/pci-error-recovery.rst in a platform-agnostic way
> > so that powerpc (EEH) and s390 could conceivably take advantage of it.
> > 
> > Can you find a way to avoid this, e.g. report errors after
> > pcie_do_recovery() has concluded?
> 
> I understand your concern about keeping pcie_do_recovery()
> platform-agnostic.

The code you're adding above, with the exception of the check for
pci_channel_io_frozen, should live in a helper in aer.c.
Then you also don't need to rename add_error_device().

> I explored the possibility of reporting errors after
> recovery concludes, but unfortunately, this approach isn't feasible due
> to the recovery sequence. The issue is that most drivers'
> pci_error_handlers implement .slot_reset() which internally calls
> pci_restore_state() to restore the device's configuration space and
> state. This function also clears the device's AER status registers:
> 
>   .slot_reset()
>     => pci_restore_state()
>       => pci_aer_clear_status()

This was added in 2015 by b07461a8e45b.  The commit claims that
the errors are stale and can be ignored.  It turns out they cannot.

So maybe pci_restore_state() should print information about the
errors before clearing them?

Actually pci_restore_state() is only supposed to restore state,
as the name implies, and not clear errors.  It seems questionable
that the commit amended it to do that.

> > I'm also worried that errors are reported *during* recovery.
> > I imagine this looks confusing to a user.  The logged messages
> > should make it clear that these are errors that occurred *earlier*
> > and are reported belatedly.
> 
> You raise an excellent point about potential user confusion. The current
> aer_print_error() interface doesn't indicate that these are historical
> errors being reported belatedly. Would it be acceptable to add a
> clarifying message before calling aer_print_error()? For example:
> 
>   pci_err(dev, "Reporting error that occurred before recovery:\n");

Yes, something like that.  "Errors reported prior to reset"?  Dunno.

Thanks,

Lukas

