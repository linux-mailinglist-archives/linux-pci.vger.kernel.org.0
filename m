Return-Path: <linux-pci+bounces-37710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCFBC539F
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8327419E0B30
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDC284B3E;
	Wed,  8 Oct 2025 13:34:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1424E01D;
	Wed,  8 Oct 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930469; cv=none; b=YZ2oamUITFXtcomblTxQwbk06Nv2DECJXC8EAxOjkDExRnMzTXgmIQK0GsU/HM8MjO3Vo4Ko00ypKKpSZgNXqEnlb4IDTPZSgwoEyj9fwL4iveTgH0TveQsbZOuOxKn7BXPLL2qB2faxpm9fDLCGulIst/ZZZuwppQ3gGJqDD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930469; c=relaxed/simple;
	bh=L/JfgYUl9kx54NZaz4So/Tc7t9Ld6kXKMjxc+OdFfT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni7SAbaJWuGAuoQ95vzONXZNCDrr/CJv3rKukPbuKlAtns/PDSWeWinS3q3cENlBTBIRhEW5qBIGTkm1rxOr044NeYcIWrgY8eWWSfyPi3YNsJBnZspynp6DWHGITWrtUFdEzPU4Pr9WP+a3502j8vUSh8C4/7YAB2CAsH8AN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C542E2C4E592;
	Wed,  8 Oct 2025 15:34:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B363A5F7D2E; Wed,  8 Oct 2025 15:34:16 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:34:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	helgaas@kernel.org, clg@redhat.com, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com
Subject: Re: [PATCH v4 01/10] PCI: Avoid saving error values for config space
Message-ID: <aOZoWDQV0TNh-NiM@wunner.de>
References: <20250924171628.826-1-alifm@linux.ibm.com>
 <20250924171628.826-2-alifm@linux.ibm.com>
 <20251001151543.GB408411@p1gen4-pw042f0m>
 <ae5b191d-ffc6-4d40-a44b-d08e04cac6be@linux.ibm.com>
 <aOE1JMryY_Oa663e@wunner.de>
 <c0818c13-8075-4db0-b76f-3c9b10516e7a@linux.ibm.com>
 <aOQX6ZTMvekd6gWy@wunner.de>
 <8c14d648-453c-4426-af69-4e911a1128c1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c14d648-453c-4426-af69-4e911a1128c1@linux.ibm.com>

On Mon, Oct 06, 2025 at 02:35:49PM -0700, Farhan Ali wrote:
> On 10/6/2025 12:26 PM, Lukas Wunner wrote:
> > On Mon, Oct 06, 2025 at 10:54:51AM -0700, Farhan Ali wrote:
> > > On 10/4/2025 7:54 AM, Lukas Wunner wrote:
> > > > I believe this also makes patch [01/10] in your series unnecessary.
> > > I tested your patches + patches 2-10 of this series. It unfortunately didn't
> > > completely help with the s390x use case. We still need the check to in
> > > pci_save_state() from this patch to make sure we are not saving error
> > > values, which can be written back to the device in pci_restore_state().
> > What's the caller of pci_save_state() that needs this?
> > 
> > Can you move the check for PCI_POSSIBLE_ERROR() to the caller?
> > I think plenty of other callers don't need this, so it adds
> > extra overhead for them and down the road it'll be difficult
> > to untangle which caller needs it and which doesn't.
> 
> The caller would be pci_dev_save_and_disable(). Are you suggesting moving
> the PCI_POSSIBLE_ERROR() prior to calling pci_save_state()?

I'm not sure yet.  Let's back up a little:  I'm missing an
architectural description how you're intending to do error
recovery in the VM.  If I understand correctly, you're
informing the VM of the error via the ->error_detected() callback.

You're saying you need to check for accessibility of the device
prior to resetting it from the VM, does that mean you're attempting
a reset from the ->error_detected() callback?

According to Documentation/PCI/pci-error-recovery.rst, the device
isn't supposed to be considered accessible in ->error_detected().
The first callback which allows access is ->mmio_enabled().

I also don't quite understand why the VM needs to perform a reset.
Why can't you just let the VM tell the host that a reset is needed
(PCI_ERS_RESULT_NEED_RESET) and then the host resets the device on
behalf of the VM?

Furthermore, I'm thinking that you should be using pci_channel_offline()
to detect accessibility of the device, rather than reading from
Config Space and checking for PCI_POSSIBLE_ERROR().

> > The state saved on device addition is just the initial state and
> > it is fine if later on it gets updated (which is a nicer term than
> > "overwritten").  E.g. when portdrv.c instantiates port services
> > and drivers are bound to them, various registers in Config Space
> > are changed, hence pcie_portdrv_probe() calls pci_save_state()
> > again.
> > 
> > However we can discuss whether pci_save_state() is still needed
> > in pci_dev_save_and_disable().
> 
> The commit 8dd7f8036c12 ("PCI: add support for function level reset")
> introduced the logic of saving/restoring the device state after an FLR. My
> assumption is it was done to save the most recent state of the device (as
> the state could be updated by drivers). So I think it would still make sense
> to save the device state in pci_dev_save_and_disable() if the Config Space
> is still accessible?

Yes, right now we can't assume that drivers call pci_save_state()
in their probe hook if they modified Config Space.  They may rely
on the state being saved prior to reset or a D3hot/D3cold transition.
So we need to keep the pci_dev_save_and_disable() call for now.

Generally the expectation is that Config Space is accessible when
performing a reset with pci_try_reset_function().  Since that's
apparently not guaranteed for your use case, I'm wondering if you
might be using the function in a context it's not supposed to be used.

Thanks,

Lukas

