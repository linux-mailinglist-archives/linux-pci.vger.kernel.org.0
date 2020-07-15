Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2422024E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGOCWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 22:22:31 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36952 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGOCWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 22:22:31 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06F2JlC0001315
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Jul 2020 21:19:51 -0500
Message-ID: <2629240c07af7fec5989127ed6da405e12cf77a3.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
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
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Kjetil Oftedal <oftedal@gmail.com>
Date:   Wed, 15 Jul 2020 12:19:46 +1000
In-Reply-To: <20200714234625.GA428442@bjorn-Precision-5520>
References: <20200714234625.GA428442@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-07-14 at 18:46 -0500, Bjorn Helgaas wrote:
> Yes.  I have no problem with that.  There are a few cases where it's
> important to check for errors, e.g., we read a status register and do
> something based on a bit being set.  A failure will return all bits
> set, and we may do the wrong thing.  But most of the errors we care
> about will be on MMIO reads, not config reads, so we can probably
> ignore most config read errors.

And in both cases, we don't have the plumbing to provide accurate
and reliable error returns for all platforms anyways (esp. not for
MMIO).

I think it makes sense to stick to the good old "if all 1's, then go
out of line" including for config space.

 ../..

> Yep, except for things like device removal or other PCI errors.

A whole bunch of these are reported asynchronously, esp for writes (and
yes, including config writes, they are supposed to be non-posted but
more often than not, the path  from the CPU to the PCI bridge remains
posted for writes including config ones).

> So maybe a good place to start is by removing some of the useless
> error checking for pci_read_config_*() and pci_write_config_*().
> That's a decent-sized but not impractical project that could be done
> per subsystem or something:
> 
>   git grep -E "(if|return|=).*\<pci_(read|write)_config" drivers
> 
> finds about 400 matches.
> 
> Some of those callers probably really *do* want to check for errors,
> and I guess we'd have to identify them and do them separately as you
> mentioned.

I'd be curious about these considering how unreliable our error return
is accross the board.

Cheers,
Ben.


