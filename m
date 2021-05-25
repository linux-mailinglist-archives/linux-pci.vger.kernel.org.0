Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A022390B1E
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhEYVSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 17:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhEYVSr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 17:18:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1E41611BE;
        Tue, 25 May 2021 21:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621977437;
        bh=ld3sqSrUR2XjvWjU79s09y0mJcxDMcDO4F7IxblOnls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BZU51puUxVZJkUvAJbfoy+EsVlFoP72WvHF9cB4wLjNfTRn7w96X9nmdHrB+FGz5e
         KzAWWthAOIk/tUtNrer+AtxLN+hLwM0tsUTpZZraWXam3P67QgZoUEn7KvtBp2Ly/C
         qwurBSlPxHxiZ2D6CFOxLLf3PqsLSREqXzt66PPnfJPle5NnOmQ201vPubeosIgHB+
         3+jTJNfNdVhn8WvA6Qy/2jsouRLg/SdmC7c1Uz9rHS1iLjSJ/uPu7y/tNrGRdVrm/n
         gSybKbkIuH//WWK87pJsWibK/7HVwI+lpRKoOnkTvqwOCjJSN9O0DsRVEC3BI0hVOZ
         mEs+LJs28BAEg==
Date:   Tue, 25 May 2021 16:17:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] PCI: brcmstb: Add panic/die handler to RC driver
Message-ID: <20210525211715.GA1230916@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzDCXokrHjVL=vdTT=cMV52tSSk9=L7h8QsCA=sf1pZiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 05:05:51PM -0400, Jim Quinlan wrote:
> On Tue, May 25, 2021 at 4:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Apr 27, 2021 at 01:51:38PM -0400, Jim Quinlan wrote:
> > > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > > by default Broadcom's STB PCIe controller effects an abort.  This simple
> > > handler determines if the PCIe controller was the cause of the abort and if
> > > so, prints out diagnostic info.
> > >
> > > Example output:
> > >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> > >   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> >
> > What happens to the driver that performed the illegal access?
> 
> The entire system dies from the abort.  Some customers elect to do a
> fixup in the abort handler but we admonish them to fix the root cause.
> With these patches we at least get immediate information about the
> access that caused the abort.
> >
> > Does this mean that errors that are recoverable on other hardware (by
> > noticing the 0xffffffff and checking for error) are fatal on the
> > Broadcom STB?
> 
> Yes.  For example, I have an old Rocketport RP2 card I sometimes use
> for testing.   On a Broadcom STB it dies when the rp2 probe does a
> read after calling rp2_reset_asic().  On an x86, 0xffffffff is
> returned on this read and all is well.
> 
> I don't think there is any PCIe spec that mandates an access error
> returns 0xffffffff.  Some of our SOCs have a new feature where we can
> return the 0xffffffff instead of getting an abort.  We will allow the
> customer to turn this on if they ask for it, but for the time being we
> prefer an abort as many drivers do not check for 0xffffffff.

Right, the mechanism of error reporting is an implementation choice.
Few drivers are actually prepared to deal with 0xffffffff data, but in
many systems, especially those with removable PCI devices, it is
important to be able to report errors in a way that doesn't crash the
system.

That may not be a concern in your system, so maybe just mention that
this is a fatal error for the system in the commit log.

Bjorn
