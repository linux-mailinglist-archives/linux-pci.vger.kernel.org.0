Return-Path: <linux-pci+bounces-34139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA38B2933C
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5404D7A6F31
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A04AEE2;
	Sun, 17 Aug 2025 13:18:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FBE79D2
	for <linux-pci@vger.kernel.org>; Sun, 17 Aug 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436682; cv=none; b=RtSp1t8SBAwbK8n59cM8KGnh3aMrL5RRntRR2rr5d5F/RVhKiAncC/x4JBCTGyIUpAvbA6DXMN69el+sjHzA/52NS7fWCfooSVkPlrzl6yDgkpYHAN0pwEeNawywjcJqq79EjG1UErw1jxKwOg4Jl/ZpUgSoAkWkwoTlL5H6URA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436682; c=relaxed/simple;
	bh=fwx4ctvSY6vN98QKaQTd5duoTcAVmdWpf1R9swfjA38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnAsy3e8qJsaamznQ5MTBBh4sRJR2fVdipb2fBd0csiHyLlcH6MJ7AgFkU+nWGtiWWZOwj3qKuUp0mfkxWQ8HGugZ6VnrZTe012OYpcQkUtdkf20iAWIfWkmtzV7YHFHMNxirQYVhmu7bz1wTiRVBUDRPtJnme30fPNQswitxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5BD522006F47;
	Sun, 17 Aug 2025 15:17:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 51EE331EAD7; Sun, 17 Aug 2025 15:17:51 +0200 (CEST)
Date: Sun, 17 Aug 2025 15:17:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
Message-ID: <aKHWf3L0NCl_CET5@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
 <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
 <7c545fff40629b612267501c0c74bc40c3df29e2.camel@linux.ibm.com>
 <aJ2uE6v46Zib30Jh@wunner.de>
 <eec85830-e024-4801-bbc8-5cfa60048932@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec85830-e024-4801-bbc8-5cfa60048932@linux.intel.com>

On Thu, Aug 14, 2025 at 12:29:25PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 8/14/25 2:36 AM, Lukas Wunner wrote:
> > On Thu, Aug 14, 2025 at 09:56:09AM +0200, Niklas Schnelle wrote:
> > > On Wed, 2025-08-13 at 07:11 +0200, Lukas Wunner wrote:
> > > > @@ -233,6 +228,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > > >   		pci_walk_bridge(bridge, report_mmio_enabled, &status);
> > > >   	}
> > > > +	if (status == PCI_ERS_RESULT_NEED_RESET ||
> > > > +	    state == pci_channel_io_frozen) {
> > > > +		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
> > > > +			pci_warn(bridge, "subordinate device reset failed\n");
> > > > +			goto failed;
> > > > +		}
> > > > +	}
> > > > +
> > > >   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> > > >   		/*
> > > >   		 * TODO: Should call platform-specific
> > > 
> > > I wonder if it might make sense to merge the reset into the above
> > > existing if.
> > 
> > There are drivers such as drivers/bus/mhi/host/pci_generic.c which
> > return PCI_ERS_RESULT_RECOVERED from ->error_detected().  So they
> > fall through directly to the ->resume() stage.  They're doing this
> > even in the pci_channel_io_frozen case (i.e. for Fatal Errors).
> > 
> > But for DPC we must call reset_subordinates() to bring the link back up.
> > And for Fatal Errors, Documentation/PCI/pcieaer-howto.rst suggests that
> > we must likewise call it because the link may be unreliable.
> 
> For fatal errors, since we already ignore the value returned by
> ->error_detected() (by calling reset_subordinates() unconditionally), why
> not update status accordingly in report_frozen_detected() and notify the
> driver about the reset?
> 
> That way, the reset logic could be unified under a single if
> (status == PCI_ERS_RESULT_NEED_RESET) condition.
> 
> Checking the drivers/bus/mhi/host/pci_generic.c implementation, it looks
> like calling slot_reset callback looks harmless.

Unfortunately it's not harmless:

mhi_pci_slot_reset() calls pci_enable_device().  But a corresponding
call to pci_disable_device() is only performed before in
mhi_pci_error_detected() if that function returns
PCI_ERS_RESULT_NEED_RESET.

So there would be an enable_cnt imbalance if I'd change the logic to
overwrite the driver's vote with PCI_ERS_RESULT_NEED_RESET in the
pci_channel_io_frozen case and call its ->slot_reset() callback.

The approach taken by this patch is to minimize risk, avoid any changes
to drivers, make do with minimal changes to pcie_do_recovery() and
limit the behavioral change.

I think overriding status = PCI_ERS_RESULT_NEED_RESET and calling drivers'
->slot_reset() would have to be done in a separate patch on top and would
require going through all drivers again to see which ones need to be
amended.

Also, note that report_frozen_detected() is too early to set
"status = PCI_ERS_RESULT_NEED_RESET".  That needs to happen after the
->mmio_enabled() step, so that drivers get a chance to examine the
device even in the pci_channel_io_frozen case before a reset is
performed.  (The ->mmio_enabled() step is only performed if "status" is
PCI_ERS_RESULT_CAN_RECOVER.)

So then the code would look like this:

	if (state == pci_channel_io_frozen)
		status = PCI_ERS_RESULT_NEED_RESET;

	if (status == PCI_ERS_RESULT_NEED_RESET) {
		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
			pci_warn(bridge, "subordinate device reset failed\n");
			goto failed;
		}

		status = PCI_ERS_RESULT_RECOVERED;
		pci_dbg(bridge, "broadcast slot_reset message\n");
		pci_walk_bridge(bridge, report_slot_reset, &status);
	}

... which isn't very different from the present patch:

        if (status == PCI_ERS_RESULT_NEED_RESET ||
            state == pci_channel_io_frozen) {
                if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
                        pci_warn(bridge, "subordinate device reset failed\n");
                        goto failed;
                }
        }

        if (status == PCI_ERS_RESULT_NEED_RESET) {
                status = PCI_ERS_RESULT_RECOVERED;
                pci_dbg(bridge, "broadcast slot_reset message\n");
                pci_walk_bridge(bridge, report_slot_reset, &status);
        }

... except that this patch avoids touching any drivers.

Thanks,

Lukas

