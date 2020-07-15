Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3E221822
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGOWw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 18:52:29 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37670 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGOWw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 18:52:29 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06FMnOHG014418
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Jul 2020 17:49:27 -0500
Message-ID: <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "'Oliver O'Halloran'" <oohall@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Russell King <linux@armlinux.org.uk>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Richard Henderson <rth@twiddle.net>,
        Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Date:   Thu, 16 Jul 2020 08:49:21 +1000
In-Reply-To: <20200715221230.GA563957@bjorn-Precision-5520>
References: <20200715221230.GA563957@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-07-15 at 17:12 -0500, Bjorn Helgaas wrote:
> > I've 'played' with PCIe error handling - without much success.
> > What might be useful is for a driver that has just read ~0u to
> > be able to ask 'has there been an error signalled for this device?'.
> 
> In many cases a driver will know that ~0 is not a valid value for the
> register it's reading.  But if ~0 *could* be valid, an interface like
> you suggest could be useful.  I don't think we have anything like that
> today, but maybe we could.  It would certainly be nice if the PCI core
> noticed, logged, and cleared errors.  We have some of that for AER,
> but that's an optional feature, and support for the error bits in the
> garden-variety PCI_STATUS register is pretty haphazard.  As you note
> below, this sort of SERR/PERR reporting is frequently hard-wired in
> ways that takes it out of our purview.

We do have pci_channel_state (via pci_channel_offline()) which covers
the cases where the underlying error handling (such as EEH or unplug)
results in the device being offlined though this tend to be
asynchronous so it might take a few ~0's before you get it.

It's typically used to break potentially infinite loops in some
drivers.

There is no interface to check whether *an* error happened though for
the most cases it will be captured in the status register, which is
harvested (and cleared ?) by some EDAC drivers iirc... 

All this lacks coordination, I agree.

Cheers,
Ben.


