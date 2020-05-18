Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1EA1D7A49
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERNq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 09:46:28 -0400
Received: from foss.arm.com ([217.140.110.172]:41026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERNq2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 09:46:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A160D101E;
        Mon, 18 May 2020 06:46:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48E43F52E;
        Mon, 18 May 2020 06:46:25 -0700 (PDT)
Date:   Mon, 18 May 2020 14:46:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200518134614.GA31554@e121166-lin.cambridge.arm.com>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200513135643.478ffbda@windsurf.home>
 <87pnb2h7w1.fsf@FE-laptop>
 <20200518103004.6tydnad3apkfn77y@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518103004.6tydnad3apkfn77y@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 12:30:04PM +0200, Pali Rohár wrote:
> On Sunday 17 May 2020 17:57:02 Gregory CLEMENT wrote:
> > Hello,
> > 
> > > Hello,
> > >
> > > On Thu, 30 Apr 2020 10:06:13 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > >
> > >> Marek Behún (5):
> > >>   PCI: aardvark: Improve link training
> > >>   PCI: aardvark: Add PHY support
> > >>   dt-bindings: PCI: aardvark: Describe new properties
> > >>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
> > >>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
> > >> 
> > >> Pali Rohár (7):
> > >>   PCI: aardvark: Train link immediately after enabling training
> > >>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
> > >>     read-only register
> > >>   PCI: of: Zero max-link-speed value is invalid
> > >>   PCI: aardvark: Issue PERST via GPIO
> > >>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
> > >>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
> > >>     macros
> > >>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property
> > >
> > > Thanks a lot for this work. For a number of reasons, I'm less involved
> > > in Marvell platform support in Linux, but I reviewed your series and
> > > followed the discussions around it, and I'm happy to give my:
> > >
> > > Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > 
> > With this acked-by for the series, the reviewed-by from Rob on the
> > binding and the tested-by, I am pretty confident so I applied the
> > patches 10, 11 and 12 on mvebu/dt64.
> > 
> > Thanks,
> > 
> > Gregory
> 
> Thank you!
> 
> Lorenzo, would you now take remaining patches?

Yes - even though I have reservations about patch (5) and the
problem is related to a complete lack of programming model for
these host controllers and a clear separation between what's
done in the OS vs bootloader, PERST handling in this host
bridge is *really* a mess.

I applied 1-9 to pci/aardvark.

Lorenzo
