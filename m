Return-Path: <linux-pci+bounces-31031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C26AECFC9
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCDD189396D
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9E233158;
	Sun, 29 Jun 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNOhTrRs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F85BE4A;
	Sun, 29 Jun 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751223741; cv=none; b=mn8rXH9n14V0WIA9EN6xAFSjdXYKE/7e/y59+zg/BJjByITspQtEL4SbJa7tJqTq0QCqtx+CapFYsEqOPNum8K4HKYPVip0IdN74YlY25C5cRXTk+5xZpSLNVqIUmrTWP3o3rdVwvApeZzzfmQXM7FWVAC20qJbjcrlkdc0IZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751223741; c=relaxed/simple;
	bh=BKcKihhtowYCzyyiIXSJEIIzyxAqJMQrIKiBu6x3eXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TShCy8kpJyveXclnA2kXwWoszqogvX8nPj1aJr6YuN1PRhiwY5njmAyYy5tQbxBDnw5FZ3b4J3r/LkdU8lebUGb+cmoKGk/oN+bUWxh8fxUNIZCkqloxaWQb0emoIglDF2VoD0PfrwuGT/Zz9Id3e+ErYkT428tZ9aOvcZPWO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNOhTrRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B3C4CEEB;
	Sun, 29 Jun 2025 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751223741;
	bh=BKcKihhtowYCzyyiIXSJEIIzyxAqJMQrIKiBu6x3eXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fNOhTrRszSYEfCM0gNBzEz+pQ+d9+vQcr/fB16JtjXSEi2gkZGfivSpw9UcVAcj8B
	 1UwL0h3Ig7KBUdiT7BnVMId+4VstNLIBeKouIPcx2f7Jpoy9o4GH6LbL9WvrqBQueO
	 v3SXr/LIeZQQX7oGm8AggSqyQxzhMfz9z9EVugwouj06PTYdFUZs74UKkvRSstyqOF
	 Z9Y57r05LnVJ3gaA7l2CI4SkDK4fY9bTrh7B0HGXAFrc1z6xZyEeo8Z53ArwN410Yf
	 LxLpRzOoiHvrPcWHzfC2Ls5HvqdtpuunmsuElP6aWLTaK7p4Mgrb7adVX97hnVYlzv
	 +87R1YjFXD0Tg==
Date: Sun, 29 Jun 2025 14:02:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <20250629190219.GA1717534@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qy2nfwiu2g7pbzbk37wseapvsen7mx4fgqdkdwjbclsj5dltu5@7o2xtj3qhedm>

On Sat, Jun 28, 2025 at 04:57:26AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 27, 2025 at 05:45:02PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 16, 2025 at 11:02:09AM +0530, Manivannan Sadhasivam wrote:
> > > pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> > > built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> > > independently of CONFIG_PWRCTRL. This creates enumeration failure on
> > > platforms like brcmstb using out-of-tree devicetree that describes the
> > > power supplies for endpoints in the PCIe child node, but doesn't use
> > > PWRCTRL framework to manage the supplies. The controller driver itself
> > > manages the supplies.
> > > 
> > > But in any case, the API should be built only when CONFIG_PWRCTRL is
> > > enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> > > a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> > > fixes the enumeration issues on the affected platforms.
> > 
> > Finally circling back to this since I think brcmstb is broken since
> > v6.15 and we should fix it for v6.16 final.
> 
> Yes! Sorry for the delay. The fact that I switched the job and had
> to attend OSS NA prevented me from reworking this patch.
> 
> > IIUC, v3 is the current patch and needs at least a fix for the build
> > issue [1], and I guess the options are:
> > 
> >   1) Make CONFIG_PCI_PWRCTRL bool.  On my x86-64 system
> >      pci-pwrctrl-core.o is 8880 bytes, which seems like kind of a lot
> >      when only a few systems need it.
> > 
> >   2) Leave pci_pwrctrl_create_device() in probe.c.  It gets optimized
> >      away if CONFIG_OF=n because of_pci_find_child_device() returns
> >      NULL, but still a little ugly for readers.
> > 
> >   3) Put pci_pwrctrl_create_device() in a separate
> >      drivers/pci/pwrctrl/ file that is always compiled even if PWRCTRL
> >      itself is a module.  Ugly because then we sort of have two "core"
> >      files (core.c and whatever new file is always compiled).
> 
> I guess, we could go with option 3 if you prefer. We could rename
> the existing pwrctrl/core.c to pwrctrl/pwrctrl.c and move the
> definition of pci_pwrctrl_create_device() to new pwrctrl/core.c. The
> new file will depend on HAVE_PWRCTRL, which is bool.

I think I forgot to mention that option 2 still requires a patch to
wrap pci_pwrctrl_create_device() with some sort of #ifdef for
CONFIG_PCI_PWRCTRL, right?  Seems like we need that regardless of the
brcmstb situation so that we don't create pwrctrl devices when
CONFIG_OF=y and CONFIG_PCI_PWRCTRL=n.

That seems like a straightforward solution and the #ifdef would
address my readability concern even though the code stays in probe.c.

> > And I guess all of these options still depend on CONFIG_PCI_PWRCTRL
> > not being enabled in a kernel that has brcmstb enabled?  If so, that
> > seems ugly to me.  We should be able to enable both PWRCTRL and
> > brcmstb at the same time, e.g., for a single kernel image that works
> > both on a brcmstb system and a system that needs pwrctrl.
> 
> Right, that would be the end goal. As I explained in the reply to
> the bug report [1], this patch will serve as an interim workaround.
> Once my pwrctrl rework (which I didn't submit yet) is merged, I will
> move this driver to use the pwrctrl framework.

OK, so for now, Jim would still need to ensure CONFIG_PCI_PWRCTRL=n
when brcmstb is enabled, but we do have a plan to adapt brcmstb work
with pwrctrl.

> [1]
> https://lore.kernel.org/all/vazxuov2hdk5sezrk7a5qfuclv2s3wo5sxhfwuo3o4uedsdlqv@po55ny24ctne/

