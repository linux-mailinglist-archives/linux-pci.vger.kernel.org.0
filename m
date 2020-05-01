Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C251C18E0
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgEAPCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEAPCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:02:07 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15FF2137B;
        Fri,  1 May 2020 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588345326;
        bh=sLNsgBhDFkipYaV5v04vF4v+XXtyMcWu3BrBwAnjJDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a7DGgB7PsWk9EkjO5KG38cAprEstQ8RBYXbAvnRTfmdyNfONQIrvgdKI9ArmBi3FS
         eI0cWVT8/YW6hDIle4KhEaqRithz3WtMyfrXRLno7WYwOr8yg0dHzBRBoqElNVUC6d
         146KW5wNRSspc/UkQu4xsg90sR4AZiboUMQl+eQM=
Date:   Fri, 1 May 2020 10:02:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Mario.Limonciello@dell.com,
        jonathan.derrick@intel.com, mr.nuke.me@gmail.com,
        rjw@rjwysocki.net, kbusch@kernel.org, okaya@kernel.org,
        tbaicar@codeaurora.org
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200501150204.GA109407@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42c53d43bc094889b33c1ac8c2b99d33@AUSX13MPC107.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 02:40:23PM +0000, Austin.Bolen@dell.com wrote:
> On 4/30/2020 6:02 PM, Bjorn Helgaas wrote:
> > [Austin, help us understand the FIRMWARE_FIRST bit! :)]
> >
> > On Thu, Apr 30, 2020 at 05:40:22PM -0500, Bjorn Helgaas wrote:
> >> On Sun, Apr 26, 2020 at 11:30:06AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>>
> >>> Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to
> >>> determine the PCIe AER Capability ownership between OS and
> >>> firmware. This support is added based on following spec
> >>> reference.
> >>>
> >>> Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table
> >>> flags field BIT-0 and BIT-1 can be used to expose the
> >>> ownership of error source between firmware and OSPM.
> >>>
> >>> Bit [0] - FIRMWARE_FIRST: If set, indicates that system
> >>>           firmware will handle errors from this source
> >>>           first.
> >>> Bit [1] – GLOBAL: If set, indicates that the settings
> >>>           contained in this structure apply globally to all
> >>>           PCI Express Bridges.
> >>>
> >>> Although above spec reference states that setting
> >>> FIRMWARE_FIRST bit means firmware will handle the error source
> >>> first, it does not explicitly state anything about AER
> >>> ownership. So using HEST to determine AER ownership is
> >>> incorrect.
> >>>
> >>> Also, as per following specification references, _OSC can be
> >>> used to negotiate the AER ownership between firmware and OS.
> >>> Details are,
> >>>
> >>> Per ACPI spec r6.3, sec 6.2.11.3, table titled “Interpretation
> >>> of _OSC Control Field” and as per PCI firmware specification r3.2,
> >>> sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field
> >>> to request control over PCI Express AER. If the OS successfully
> >>> receives control of this feature, it must handle error reporting
> >>> through the AER Capability as described in the PCI Express Base
> >>> Specification.
> >>>
> >>> Since above spec references clearly states _OSC can be used to
> >>> determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.
> >> I pulled out the _OSC part of this to a separate patch.  What's left
> >> is below, and is essentially equivalent to Alex's patch:
> >>
> >>   https://lore.kernel.org/r/20190326172343.28946-3-mr.nuke.me@gmail.com/
> >>
> >> I like what this does, but what I don't like is the fact that we now
> >> have this thing called pcie_aer_get_firmware_first() that is not
> >> connected with the ACPI FIRMWARE_FIRST bit at all.
> >
> > Austin, if we remove this, we'll have no PCIe-related code that looks
> > at the HEST FIRMWARE_FIRST bit at all.  Presumably it's there for some
> > reason, but I'm not sure what the reason is.
> >
> > Alex's mail [1] has a nice table of _OSC AER/HEST FFS bits that looks
> > useful, but the only actionable thing I can see is that in the (1,1)
> > case, OSPM should do some initialization with masks/enables.
> >
> > But I have no clue what that means or how to connect that with the
> > spec.  What are the masks/enables?  Is that something connected with
> > ERST?
> >
> > [1] https://lore.kernel.org/r/20190326172343.28946-1-mr.nuke.me@gmail.com/
> 
> The only values that make sense to me are (1, 0) for full native OS
> init/handling of AER and (0, 1) for the firmware first model where
> firmware does the init and handles errors first then passes control to
> the OS. For these cases the FIRMWARE_FIRST flag in HEST is redundant and
> not needed.
> 
> We did discuss the (1, 1) case in the ACPI working group and there were
> a potential use case (which Alex documented in the link you provided)
> but there is nothing specified in the standard about how that model
> would actually work AFAICT. And no x86 system has the hardware support
> needed for what was proposed that I'm aware of (not sure about other
> architectures).
> 
> So unless and until someone documents how the firmware and OS are
> supposed to behave in the (1, 1) or (0, 0) scenario and expresses a need
> for those models, I would not bother adding support for them.  Just my 2
> cents.

Perfect, I think we should ignore the FIRMWARE_FIRST bit in the HEST
PCIe entries for now.  Thanks a lot for your help with this!

Bjorn
