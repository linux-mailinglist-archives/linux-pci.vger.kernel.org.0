Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91921E2DF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGMWO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 18:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgGMWOx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 18:14:53 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D392089D;
        Mon, 13 Jul 2020 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594678492;
        bh=P0Nh+xFRQ9a2MrN5LEFWmA1XUcPw3diBTYezfnAiJCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rDrnvcJIkFUMC9A7DI39Pwr7PxFVWNWWQqubAPuy55RfkwSnFRJiHYdN8HaPbpIX0
         T24ZCfSRmOYpI2DCyxJXPsGBsyPRJchuRH1EQE3I58jgMIoBK9NSlK+YAsGraygo1O
         NXYOscQBNZBtCaERYxiKPmbDAWprr8nQw8Ro1PdM=
Date:   Mon, 13 Jul 2020 17:14:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marcos Scriven <marcos@scriven.org>
Cc:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Kevin Buettner <kevinb@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Message-ID: <20200713221451.GA285058@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAri2DpQnrGH5bnjC==W+HmnD4XMh8gcp9u-_LQ=K-jtrdHwAg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 01:44:44PM +0100, Marcos Scriven wrote:
> On Thu, 25 Jun 2020 at 11:22, Marcos Scriven <marcos@scriven.org> wrote:
> > On Tue, 9 Jun 2020 at 12:47, Shah, Nehal-bakulchandra
> > <nehal-bakulchandra.shah@amd.com> wrote:
> > > On 6/8/2020 11:17 PM, Marcos Scriven wrote:
> > > > On Thu, 28 May 2020 at 09:12, Marcos Scriven <marcos@scriven.org>
> > wrote:
> > > >> On Wed, 27 May 2020 at 22:42, Deucher, Alexander
> > > >> <Alexander.Deucher@amd.com> wrote:
> > > >>>> -----Original Message-----
> > > >>>> From: Bjorn Helgaas <helgaas@kernel.org>
> > > >>>>
> > > >>>> [+cc Alex D, Christian -- do you guys have any contacts or insight
> > into why we
> > > >>>> suddenly have three new AMD devices that advertise FLR support but
> > it
> > > >>>> doesn't work?  Are we doing something wrong in Linux, or are these
> > devices
> > > >>>> defective?
> > > >>> +Nehal who handles our USB drivers.
> > > >>>
> > > >>> Nehal any ideas about FLR or whether it should be advertised?
> > > >>>
> > > Sorry for the delay. We are looking into this with BIOS team. I shall
> > revert soon on this.
> >
> > Sorry to keep pestering about this, but wondering if there's any
> > movement on this?
> >
> > Is it something that's likely to be fixed and actually rolled out by
> > motherboard manufacturers?
> >
> > There's been some grumblings in the community about adding workarounds
> > rather than fixing, so it would be good to pass on expectations here.
> 
> Any word on this please? Would be keen to know if the BIOS can be fixed,
> and this workaround can eventually be dropped.

Just to clarify what the possible outcomes are:

  1) If these AMD devices are defective, but future ones are fixed, we
  keep the quirk.

  2) If these AMD devices are defective *and* future ones are also
  defective, we keep the quirk and keep adding device IDs to it.

  3) If the BIOS is defective, we keep the quirk.  If anybody cares
  about FLR enough, they can make the quirk smart enough to identify
  fixed BIOS versions and enable FLR.  

  4) If Linux is defective, we can fix Linux and drop the quirk.

The ideal outcome would be 4), but we don't have any indication that
Linux is doing something wrong.

What we're really trying to avoid is 2) because that means new devices
will break Linux until somebody figures out the problem again, updates
the quirk, and gets the update into distro kernels.

In case 3), we don't drop the quirk because that forces people to
upgrade their BIOS, and most people will not.  We can't drop the
quirk, reintroduce the problem on old BIOSes, and hide behind the
excuse of "you need to upgrade the BIOS."  That wastes the user's time
and our time.

> > > >>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > >>>>> 43a0c2ce635e..b1db58d00d2b 100644
> > > >>>>> --- a/drivers/pci/quirks.c
> > > >>>>> +++ b/drivers/pci/quirks.c
> > > >>>>> @@ -5133,6 +5133,7 @@
> > > >>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> > > >>>> quirk_intel_qat_vf_cap);
> > > >>>>>   * FLR may cause the following to devices to hang:
> > > >>>>>   *
> > > >>>>>   * AMD Starship/Matisse HD Audio Controller 0x1487
> > > >>>>> + * AMD Starship USB 3.0 Host Controller 0x148c
> > > >>>>>   * AMD Matisse USB 3.0 Host Controller 0x149c
> > > >>>>>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > > >>>>>   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@ -5143,6
> > +5144,7
> > > >>>>> @@ static void quirk_no_flr(struct pci_dev *dev)
> > > >>>>>     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > > >>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> > > >>>> quirk_no_flr);
> > > >>>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> > > >>>> quirk_no_flr);
> > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> > > >>>> quirk_no_flr);
> > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> > > >>>> quirk_no_flr);
> > >
> > > Regard
> > >
> > > Nehal Shah
> > >
> >
