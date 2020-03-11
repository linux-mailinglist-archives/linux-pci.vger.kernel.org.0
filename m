Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD81824BF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 23:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgCKWXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 18:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 18:23:55 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBAC2074F;
        Wed, 11 Mar 2020 22:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583965434;
        bh=VxuBiG8OFio/B5ZtjRsG29WpYhE8YxkKdDWuBasRt2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fDGv/SDkCtTHXBh8kW0vBN8kem9XC4ovtOXnyjOBM+1pp4g2/Va+d1cnO0IiElwvA
         241pXhPDe/ac5hQcwfeX+qu+ILSg3vKYyWeFPlkxf87j3XmS6BEBSBsp/RIsd5Qxrd
         tMNCXTIXxAtHH0/IkDgKdsCVjTEtgct/q+yXsIWw=
Date:   Wed, 11 Mar 2020 17:23:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200311222352.GA200510@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5328126a-7cf0-58c9-7dff-978fe2cae0ee@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 03:11:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/11/20 2:53 PM, Austin.Bolen@dell.com wrote:
> > On 3/11/2020 4:27 PM, Kuppuswamy Sathyanarayanan wrote:
> > > On 3/11/20 1:33 PM, Bjorn Helgaas wrote:
> > > > On Wed, Mar 11, 2020 at 05:27:35PM +0000, Austin.Bolen@dell.com wrote:
> > > > > On 3/11/2020 12:12 PM, Bjorn Helgaas wrote:
> > > > > <SNIP>
> > > > > > I'm probably missing your intent, but that sounds like "the OS can
> > > > > > read/write AER bits whenever it wants, regardless of ownership."
> > > > > > 
> > > > > > That doesn't sound practical to me, and I don't think it's really
> > > > > > similar to DPC, where it's pretty clear that the OS can touch DPC bits
> > > > > > it doesn't own but only *during the EDR processing window*.
> > > > > Yes, by treating AER bits like DPC bits I meant I'd define the specific
> > > > > time windows when OS can touch the AER status bits similar to how it's
> > > > > done for DPC in the current ECN.
> > > > Makes sense, thanks.
> > > > 
> > > > > > > > > For the normative text describing when OS clears the AER bits
> > > > > > > > > following the informative flow chart, it could say that OS clears
> > > > > > > > > AER as soon as possible after OST returns and before OS processes
> > > > > > > > > _HPX and loading drivers.  Open to other suggestions as well.
> > > > > > > > I'm not sure what to do with "as soon as possible" either.  That
> > > > > > > > doesn't seem like something firmware and the OS can agree on.
> > > > > > > I can just state that it's done after OST returns but before _HPX or
> > > > > > > driver is loaded. Any time in that range is fine. I can't get super
> > > > > > > specific here because different OSes do different things.  Even for
> > > > > > > a given OS they change over time. And I need something generic
> > > > > > > enough to support a wide variety of OS implementations.
> > > > > > Yeah.  I don't know how to solve this.
> > > > > > 
> > > > > > Linux doesn't actually unload and reload drivers for the child devices
> > > > > > (Sathy, correct me if I'm wrong here) even though DPC containment
> > > > > > takes the link down and effectively unplugs and replugs the device.  I
> > > > > > would *like* to handle it like hotplug, but some higher-level software
> > > > > > doesn't deal well with things like storage devices disappearing and
> > > > > > reappearing.
> > > > > > 
> > > > > > Since Linux doesn't actually re-enumerate the child devices, it
> > > > > > wouldn't evaluate _HPX again.  It would probably be cleaner if it did,
> > > > > > but it's all tied up with the whole unplug/replug problem.
> > > > > DPC resets everything below it and so to get it back up and running it
> > > > > would mean that all buses and resources need to be assigned, _HPX
> > > > > evaluated, and drivers reloaded. If those things don't happen then the
> > > > > whole hierarchy below the port that triggered DPC will be inaccessible.
> > > > Hmm, I think I might be confusing this with another situation.  Sathy,
> > > > can you help me understand this?  I don't have a way to actually
> > > > exercise this EDR path.  Is there some way the pciehp hotplug driver
> > > > gets involved here?
> > If the port has hot-plug enabled then DPC trigger will cause the link to
> > go down (disabled state) and will generate a DLLSC hot-plug interrupt.
> > When DPC is released, the link will become active and generate another
> > DLLSC hot-plug interrupt.
> Yes, device/driver enumeration and removal will triggered by DLLSC
> state change interrupt in pciehp driver.
> > 
> > > > Here's how this seems to work as far as I can tell:
> > > > 
> > > >      - Linux does not have DPC or AER control
> > > > 
> > > >      - Linux installs EDR notify handler
> > > > 
> > > >      - Linux evaluates DPC Enable _DSM
> > > > 
> > > >      - DPC containment event occurs
> > > > 
> > > >      - Firmware fields DPC interrupt
> > > > 
> > > >      - DPC event is not a surprise remove
> > > > 
> > > >      - Firmware sends EDR notification
> > > > 
> > > >      - Linux EDR notify handler evaluates Locate _DSM
> > > > 
> > > >      - Linux reads and logs DPC and AER error information for port in
> > > >        containment mode.  [If it was an RP PIO error, Linux clears RP PIO
> > > >        error status, which is an asymmetry with the non-RP PIO path.]
> > > > 
> > > >      - Linux clears AER error status (pci_aer_raw_clear_status())
> > > > 
> > > >      - Linux calls driver .error_detected() methods for all child devices
> > > >        of the port in containment mode (pcie_do_recovery()).  These
> > > >        devices are inaccessible because the link is down.
> > > > 
> > > >      - Linux clears DPC Trigger Status (dpc_reset_link() from
> > > >        pcie_do_recovery()).
> > > > 
> > > >      - Linux calls driver .mmio_enabled() methods for all child devices.
> > > > 
> > > > This is where I get lost.  These child devices are now accessible, but
> > > > they've been reset, so I don't know how their config space got
> > > > restored.  Did pciehp enumerate them?  Did we do something like
> > > > pci_restore_state()?  I don't see where either of these happens.
> > > AFAIK, AER error status registers  are sticky (RW1CS) and hence
> > > will be preserved during reset.
> > In our testing, the device directly connected to the port that was
> > contained does get reprogrammed and the driver is reloaded.  These are
> > hot-plug slots and so might be due to DLLSC hot-plug interrupt when
> > containment is released and link goes back to active state.
> > 
> > However, if a switch is connected to the port where DPC was triggered
> > then we do not see the whole switch hierarchy being re-enumerated.
> Now that I have a hardware to verify this scenario, I will look into
> it. I suspect there is a transient state in link status which causes
> this disconnect issue. But I think this issue is not related to
> EDR support and hence should be reproducible in native handling
> as well.
> > 
> > Also, DPC could be enabled on non-hot-plug slots so can't always rely on
> > hot-plug to re-init devices in the recovery path.
> If hotplug is not supported then there is support to enumerate
> devices via polling  or ACPI events. But a point to note
> here is, enumeration path is independent of error handler path, and
> hence there is no explicit trigger or event from error handler path
> to enumeration path to kick start the enumeration.

Is any synchronization needed here between the EDR path and the
hotplug/enumeration path?
