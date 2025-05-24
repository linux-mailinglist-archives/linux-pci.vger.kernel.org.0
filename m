Return-Path: <linux-pci+bounces-28361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BDAC2D23
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 04:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB046189DBE9
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 02:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D7A944;
	Sat, 24 May 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1ag/CFs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B417BBF;
	Sat, 24 May 2025 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748054530; cv=none; b=M2fVQQl3fitfnNBHnboK1wdXoQ/VQ/6PqTcaHBDOQu4LQ5eXxoX0NDgBfNnsyrhTlNqZ8/1xOOJcX5bFfKgw8RCY2RWnlh2ENrAL23djXEr8fRJ7Queg3pN7bJy7twzYcAHxm8CMcFc5IJ+iO0BeJmFuEHVovp/+YIO9I8N1+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748054530; c=relaxed/simple;
	bh=hJBGEXSDXftTSK2poU6B84MMf35kTyveWAY3zABcuxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jCCoa4mdA483PXDw9Z9tpRSRze/XSuLx9yTsQTP9Y4ZuiHEVvdxokwwGuY/uTVOGcRjOmOIHPNHs1QZQxTic8aGZi6rhSRjdikmS67UXNzDNq7vXg7IVzsYjsaCmzYw5l/EUE79sC87AD3vQOQRU+C66YMD+O6rweIkAHNZ2AJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1ag/CFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40868C4CEE9;
	Sat, 24 May 2025 02:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748054529;
	bh=hJBGEXSDXftTSK2poU6B84MMf35kTyveWAY3zABcuxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K1ag/CFsCY+Vs9dk6QJWRiIPXnR+g2TWtYfIJy7wqNMieCvRcc4lUxOVCCnHpUegV
	 PVAyi36eeoxZ1vpZovzEpki2NLYE2/VsdvrP/kCdcr4+t9+KOmBFBJjEudV9WtjsAH
	 9doEJNeBxzaeUbLjmyK0j/JumYZSjx/HZmnIEkYwmGYeRUB+mtqcAcJmtIc0L9Uphy
	 tk0gQQzwXoRjGwx6C9RbAM+6Q6RGUM5SoEyB97MveHLWSvEBxbbfdF5fuX63cgWlBS
	 cKlCJkaJ5xSrlGlPyL2m57b/xJKfA33j1H0pTVlTEu7PtE+jh8QGVKnWi5G3bQS7Wx
	 aFaXuOUMJSnkg==
Date: Fri, 23 May 2025 21:42:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Cyril Brulebois <kibi@debian.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <20250524024207.GA1598583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDDn94q9gS8SfK9_@wunner.de>

On Fri, May 23, 2025 at 11:26:15PM +0200, Lukas Wunner wrote:
> On Fri, May 23, 2025 at 03:17:59PM -0500, Bjorn Helgaas wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2510,6 +2510,7 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> >  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> >  {
> > +#if defined(CONFIG_PCI_PWRCTL) || defined(CONFIG_PCI_PWRCTL_MODULE)
> >  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> >  	struct platform_device *pdev;
> >  	struct device_node *np;
> > @@ -2536,6 +2537,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
> >  	}
> >  
> >  	return pdev;
> > +#else
> > +	return NULL;
> > +#endif
> >  }
> [...]
> > This an alternate to
> > https://lore.kernel.org/r/20250522140326.93869-1-manivannan.sadhasivam@linaro.org
> > 
> > It should accomplish the same thing but I think using #ifdef makes it a
> > little more visible and easier to see that pci_pwrctrl_create_device() is
> > only relevant when CONFIG_PCI_PWRCTL is enabled.
> 
> Just noting though that section 21 of Documentation/process/coding-style.rst
> discourages use of #ifdef and recommends IS_ENABLED() and inline stubs
> instead.

True, although I kind of object to IS_ENABLED() in cases like this
where what we really want is a no-op function, because IS_ENABLED()
forces me to mentally execute the function to see what's going on.

What I would prefer is something like the first paragraph in that
section: the #ifdef in a header file that declares the function and
defines a no-op stub, with the implementation in some pwrctrl file.

But now since we're considering this for v6.15 in a couple days, we
need a minimal fix.  Mani's original patch is probably the best for
that, and I'm fine with that, although I don't think we should throw
brcmstb under the bus.  The pci_pwrctrl_create_device() assumption
that pwrctrl is enabled is just broken, and I don't think the fix is
to improve pwrctrl and convert drivers.

Maybe we could use Mani's patch with something like my commit log
(it's quite possible I don't understand the situation completely):

  If devicetree describes power supplies related to a PCI device, we
  previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
  not enabled.

  When pci_pwrctrl_create_device() creates and returns a pwrctrl
  device, pci_scan_device() doesn't enumerate the PCI device; it
  assumes the pwrctrl core will rescan the bus after turning on the
  power.  If CONFIG_PCI_PWRCTL is not enabled, the rescan never
  happens.

  This may break PCI enumeration on any system that describes power
  supplies in devicetree but does not use pwrctrl.  Jim reported that
  some brcmstb platforms break this way.

  If CONFIG_PCI_PWRCTL is not enabled, skip creating the pwrctrl
  platform device and scan the device normally.

Looking at pci_pwrctrl_create_device() raised more questions for me:

  - If pwrctrl is enabled, devicetree describes a regulator, and the
    power is already on, do we really want to defer enumeration?

  - If pwrctrl *not* enabled, devicetree describes a regulator, and
    the power is off, is there anything in dmesg that gives us a clue
    about why we don't enumerate the device?  Could/should we emit a
    message as a hint?

  - Creating a pwrctrl device, returning a pointer to it, and then
    throwing that pointer away seems ... weird?  Makes me wonder about
    the lifetime management of that device.

Bjorn

