Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9622023A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGOCRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 22:17:08 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36886 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGOCRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 22:17:08 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06F2E9Ju001264
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Jul 2020 21:14:14 -0500
Message-ID: <a565aef087e8c1b39c5eebd7f3f9575fe3cdee5f.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Kjetil Oftedal <oftedal@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Date:   Wed, 15 Jul 2020 12:14:09 +1000
In-Reply-To: <CALMQjD9OVTbLVPGX-9+GDekZ02Wsqdz57-k1uCBMXC7cT3K_7w@mail.gmail.com>
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
         <20200714184550.GA397277@bjorn-Precision-5520>
         <CALMQjD9OVTbLVPGX-9+GDekZ02Wsqdz57-k1uCBMXC7cT3K_7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-07-14 at 23:02 +0200, Kjetil Oftedal wrote:
> > 
> > > For b), it might be nice to also change other aspects of the
> > > interface, e.g. passing a pci_host_bridge pointer plus bus number
> > > instead of a pci_bus pointer, or having the callback in the
> > > pci_host_bridge structure.
> > 
> > I like this idea a lot, too.  I think the fact that
> > pci_bus_read_config_word() requires a pci_bus * complicates things in
> > a few places.
> > 
> > I think it's completely separate, as you say, and we should defer it
> > for now because even part a) is a lot of work.  I added it to my list
> > of possible future projects.
> > 
> 
> What about strange PCI devices such as Non-Transparent bridges?
> They will require their own PCI Config space accessors that is not
> connected to a host bridge if one wants to do some sort of
> punch-through enumeration.
> I guess the kernel doesn't care much about them?

Well, today they would require a pci_bus anyway.. . so if you want to do
that sort of funny trick you may as well create a "virtual" host bridge.

Cheers,
Ben.


