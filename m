Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6E3BA442
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhGBTN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 15:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhGBTN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 15:13:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1691A61183;
        Fri,  2 Jul 2021 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625253085;
        bh=klUIsIhWvZmbWebJyfac/c8U1h51t/Hvwkz6tLvqBrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jItIaqzyyOP14CaLbpTDzzmfmck0KuJNO5DtS0XpBiM89fkL6XKH168V/Ec25FPlx
         u5hxom5szi7D9RHtuWo5nLRTyphonBeM1Wzo6gR53Ysik5yDL1ZF378YwlC9zcIIVD
         cZJoWsxHZK5PECIU1TBeRgao6M08yvx72xKDxUm5C+RgUeeD6x6PM9AVRLj/Z52gLD
         F8Nq/6pW5YrsJcxgjTMG5kLI5mfuKmLerwZ+fLo3xFnHh22T8DjqVCY2MkM8FSh13+
         /d4MYzgK2SXLWtzX6h6yla7M9f/mUX3UwG6wLaGEd2rToeqAjiNxB8PmQcQcOaCwcF
         E+zG4WRO4rfVQ==
Date:   Fri, 2 Jul 2021 14:11:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210702191123.GA228462@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630144955.71c5abac.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please add "()" after function names in subject lines.

On Wed, Jun 30, 2021 at 02:49:55PM -0600, Alex Williamson wrote:
> On Thu, 1 Jul 2021 01:34:15 +0530
> Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > On 21/06/30 11:56AM, Alex Williamson wrote:
> > > On Tue, 29 Jun 2021 21:30:57 +0530
> > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > >  
> > > > Add has_flr bitfield in struct pci_dev to indicate support for pcie flr
> > > > to avoid reading PCI_EXP_DEVCAP multiple times and get rid of
> > > > PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr().
> > > >
> > > > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > > > supported by the device which does not match the calling convention
> > > > followed by reset methods which use second function argument to decide
> > > > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > > > the calling convention of reset methods.

s/pcie/PCIe/ (except for variables, function names, etc)

> > > >  static int pci_af_flr(struct pci_dev *dev, int probe)
> > > >  {
> > > >  	int pos;
> > > >  	u8 cap;
> > > >
> > > > -	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> > > > -	if (!pos)
> > > > +	if (!dev->has_flr)
> > > >  		return -ENOTTY;
> > > >
> > > > -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > > > +	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> > > > +	if (!pos)
> > > >  		return -ENOTTY;
> > > >
> > > >  	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);  
> > >
> > >
> > > How can has_flr encompass both methods of invoking FLR?  PCIe FLR is
> > > not a prerequisite to AF FLR.
> > >  
> > I see. Does this mean that there should be a separate flag for disabling
> > AF FLR?
> 
> There hasn't been a need so far.  Per the ECN, the AF capability is
> meant to make select PCIe features available on conventional PCI
> devices.  It seems like it would be against the spirit of the AF
> capability to implement both an AF capability and a PCIe capability,
> but I don't see that it's definitively addressed by the spec.
> 
> AF FLR is sufficiently rare that it's probably reasonable to make a
> has_pcie_flr bit on the device and leave AF FLR alone.

This sounds good to me.  I agree that I'd prefer not to have a single
bit that applies to both AF FLR and PCIe FLR since they are distinct
mechanisms, discovered and initiated differently.

> I can't really say that I'm in favor of assigning a has_flr bit the
> double duty of also quirking broken FLR, if nothing else it's
> inconsistent with our other means of quirking resets.

By "other means of quirking resets," do you mean
PCI_DEV_FLAGS_NO_BUS_RESET, PCI_DEV_FLAGS_NO_PM_RESET, and
PCI_DEV_FLAGS_NO_FLR_RESET?

I agree that a pdev->has_pcie_flr bit would be different from those,
and maybe it's better to stick with PCI_DEV_FLAGS_NO_FLR_RESET for
now.

In general, I don't like the dual approach of some things being in the
pci_dev_flags enum and others being "unsigned int foo:1" in the struct
pci_dev because I can't tell if there's a reason to choose one over
the other.  If there's not a reason to have both, I'd like to migrate
them all to the ":1" approach because it seems a little more readable
to me.

Bjorn
