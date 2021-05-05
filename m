Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45D373AE7
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhEEMRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 08:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhEEMQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 08:16:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5024361182;
        Wed,  5 May 2021 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620216904;
        bh=no1Ap7Vs0p9wsqyZTTdIzLq4VZmWSYfaPoLAubQ7gTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCkf3fhM4S4YMnd7hasOmcoXwfjZHy/MJAeRHEHwOM9y9QhQN5QS39i6YhMz3mIyW
         oNlcREuat0+j6HEn2MGHZqXJtOUYJBN9JWMPeJjWariK4sxfKxaCN9IKCFNr8Ra0j6
         zFxjXXfKbnnXkJ6AQC+uANyndxPsPGptgCO3NdNDYSX3delJLYfRnw8fahC4z1NuQM
         dUqXHSVWOnCMwkr5BGnMkwfCjXdMwD7ikgO3Fb56dPS7CqUcevhwpYtmPA0oNyXA+c
         7CNouEU8uaX3u1OOv20/gUEH/w06ONMV/vGv9hnneuRlu8zjH1OBeR0Pg8O7PaVWpT
         tDXoVw5RAjT5Q==
Received: by pali.im (Postfix)
        id 9547179D; Wed,  5 May 2021 14:15:01 +0200 (CEST)
Date:   Wed, 5 May 2021 14:15:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210505121501.54dlrussyk7kij5d@pali>
References: <20210430170151.GA660969@bjorn-Precision-5520>
 <52c89d4e-6b26-6c56-d71e-508a715394ab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c89d4e-6b26-6c56-d71e-508a715394ab@nvidia.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 30 April 2021 17:11:23 Shanker R Donthineni wrote:
> Thanks Bjorn for reviewing patch.
> 
> On 4/30/21 12:01 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, Apr 28, 2021 at 07:49:07PM -0500, Shanker Donthineni wrote:
> >> On select platforms, some Nvidia GPU devices do not work with SBR.
> >> Triggering SBR would leave the device inoperable for the current
> >> system boot. It requires a system hard-reboot to get the GPU device
> >> back to normal operating condition post-SBR. For the affected
> >> devices, enable NO_BUS_RESET quirk to fix the issue.
> > Since 1/2 adds _RST support, should I infer that _RST works on these
> > Nvidia GPUs even though SBR does not?  If so, how does _RST do the
> > reset?
> Yes, _RST method works but not SBR. The _RST method in DSDT-AML uses
> platform-specific initialization steps outside of the GPU BARs for resetting
> the GPU device.

Hello! If I understood this "reset" issue correctly, it means that
affected PCIe GPU device cannot be reset via PCI Secondary Bus Reset
(PCIe Warm Reset) and some special, platform specific reset type needs
to be issued.

And code for this platform specific reset is included in ACPI DSDT
table.

But because ACPI DSDT table is part of BIOS/firmware and not part of the
PCIe GPU device itself, it means that this kind of reset is available to
linux kernel only in the case when vendor of motherboard (or who burn
BIOS/firmware into motherboard EEPROM) includes this specific code into
HW. Am I Right?

So if this PCIe GPU device is connected to other motherboard or other
system then this special platform reset in ACPI DSDT is not available.

What is doing default APCI _RST() method on motherboards without this
special platform reset hook? It probably would not be able to reset
these PCIe GPU devices if standard SBR cannot reset them.

Would not be better to include for these PCIe devices "native" linux
code for resetting them?

Please correct me if I'm wrong in my assumption or if I understood this
issue incorrectly.

> > Do you have a root cause for why SBR doesn't work?  
> It is a hardware implementation specific issue. GPU end-point device
> is inoperative after receiving SBR from the RP/SwitchPort. This quirk is
> to prevent SBR.
> 
> > I'm not super
> > confident that we perform resets correctly in general, and if the
> > problem is an issue in Linux, it'd be nice to fix that.
> We have not seen any issue with Linux SBR implementation.
> >
> >> This issue will be fixed in the next generation of hardware.
