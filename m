Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29F7E436D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjKGP3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGP3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC9C95;
        Tue,  7 Nov 2023 07:29:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C83C433C7;
        Tue,  7 Nov 2023 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699370977;
        bh=ZlerLC4HZoG58tR/d9/VGC2fvwvlupCnuLnLcuhHslc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GKrnWUqGyjFFJUOOFqpAD/GW+5ajiQ3w8D/RgPNiDEheo3qDW16M6FaIdlL2XH3Gy
         yMMA/dVFaIbIx56GONlTzSN20Iq+jpZ78pxpH3w7rQBdb1hi7VnbsM2IywUHwd8xNz
         0JFFA+uHh1zD9fG96P8NsFBFBXMiSyko3aj24i6fpJAfemhgG/dC3At5doCuYuYZ/q
         p72xQ6Y/RlJlG/1lsUrN2MFbSUzGhcyXnjDd7lJDwpup1cMD5NMZV5JM8JIVE6OCsk
         PE91P/E1WiBBnRVlGPAL+MzhR1yIvWtFhukFj1O1qU0+P1cjJybRDtBX9hZFjr28Z2
         F5xZ/onpsH6tg==
Date:   Tue, 7 Nov 2023 09:29:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Clearing error bits in the root port post enumeration
Message-ID: <20231107152929.GA289532@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d217128-b08c-4c56-ba7c-ed7b7ddfb75a@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 07, 2023 at 08:44:53AM +0530, Vidya Sagar wrote:
> On 11/3/2023 11:50 PM, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 12:26:31PM +0000, Vidya Sagar wrote:
> > > Hi folks,
> > > 
> > > I would like to know your comments on the following scenario where
> > > we are observing the root port logging errors because of the
> > > enumeration flow being followed.
> > > 
> > > DUT information:
> > > - Has a root port and an endpoint connected to it
> > > - Uses ECAM mechanism to access the configuration space
> > > - Booted through ACPI flow
> > > - Has a Firmware-First approach for handling the errors
> > > - System is configured to treat Unsupported Requests as
> > >    AdvisoryNon-Fatal errors
> > > 
> > > As we all know, when a configuration read request comes in for a
> > > device number that is not implemented, a UR would be returned as per
> > > the PCIe spec.
> > > 
> > > As part of the enumeration flow on DUT, when the kernel reads offset
> > > 0x0 of B:D:F=0:0:0, the root port responds with its valid Vendor-ID
> > > and Device-ID values.  But, when B:D:F=0:1:0 is probed, since there
> > > is no device present there, the root port responds with an
> > > Unsupported Request and simultaneously logs the same in the Device
> > > Status register (i.e. bit-3).  Because of it, there is a UR logged
> > > in the Device Status register of the RP by the time enumeration is
> > > complete.
> > > 
> > > In the case of AER capability natively owned by the kernel, the AER
> > > driver's init call would clear all such pending bits.
> > > 
> > > Since we are going with the Firmware-First approach, and the system
> > > is configured to treat Unsupported Requests as AdvisoryNon-Fatal
> > > errors, only a correctable error interrupt can be raised to the
> > > Firmware which takes care of clearing the corresponding status
> > > registers.  The firmware can't know about the UnsupReq bit being set
> > > as the interrupt it received is for a correctable error hence it
> > > clears only bits related to correctable error.
> > > 
> > > All these events leave a freshly booted system with the following
> > > bits set.
> > > 
> > > Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-          (MAbort)
> > > DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-                                                              (UnsupReq)
> > > UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-   (UnsupReq)
> > > 
> > > Since the reason for UR is well understood at this point, I would
> > > like to weigh in on the idea of clearing the aforementioned bits in
> > > the root port once the enumeration is done particularly to cater to
> > > the configurations where Firmware-First approach is in place.
> > > Please let me know your comments on this approach.
> > 
> > I think Secondary status (PCI_SEC_STATUS) is always owned by the OS
> > and is not affected by _OSC negotiation, right?  Linux does basically
> > nothing with that today, but I think it *could* clear the "Received
> > Master Abort" bit.
>
> Yes. PCI_SEC_STATUS is always owned by the OS and _OSC negotiation doesn't
> really affect that.
> 
> > I'm not very familiar with Advisory Non-Fatal errors.  I'm curious
> > about the UESta situation: why can't firmware know about UnsupReq
> > being set?  I assume PCI_ERR_COR_ADV_NFAT is the Correctable Error
> > Status bit the firmware *does* see and clear.
>
> Yes, PCI_ERR_COR_ADV_NFAT is indeed cleared by the firmware.
> > 
> > But isn't the whole point of Advisory Non-Fatal errors that an error
> > that is logged as an Uncorrectable Error and that normally would be
> > signaled with ERR_NONFATAL is signaled with ERR_COR instead?  So
> > doesn't PCI_ERR_COR_ADV_NFAT being set imply that some
> > PCI_ERR_UNCOR_STATUS must be set as well?  If so, I would think
> > firmware *could* figure that out and clear the PCI_ERR_UNCOR_STATUS
> > bit.
>
> So, are you suggesting that let the firmware only clear the
> PCI_ERR_UNCOR_STATUS also?

In this firmware-first scenario, I'm assuming the platform retained
ownership of the AER capability, so I would think firmware certainly
should be allowed to clear PCI_ERR_UNCOR_STATUS.

> if so, then, I can even make the firmware clear the PCI_SEC_STATUS
> also thereby leaving the firmware responsible for clearing all the
> error bits. Does that sound ok?

It doesn't sound quite right to me for firmware to clear
PCI_SEC_STATUS because it doesn't own that register.  I suspect we
would probably see the "Received Master Abort" bit set after
enumeration even on Conventional PCI systems, so I doubt this is
anything specific to PCIe or AER, and maybe Linux should clear it
after enumerating devices below the bridge.

Bjorn
