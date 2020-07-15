Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53F2217C8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGOWaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 18:30:16 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37602 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOWaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 18:30:16 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06FMQfq2014030
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Jul 2020 17:26:45 -0500
Message-ID: <627b214e6fc0624093caa8155d7006de111aacfb.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>
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
Date:   Thu, 16 Jul 2020 08:26:40 +1000
In-Reply-To: <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
References: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
         <20200714234625.GA428442@bjorn-Precision-5520>
         <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-07-15 at 08:47 +0200, Arnd Bergmann wrote:
> drivers/misc/cardreader/rts5261.c:      retval =
> rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);
> 
> That last one is interesting because I think this is a case in which
> we
> actually want to check for errors, as the driver seems to use it
> to ensure that accessing extended config space at offset 0x814
> works before relying on the value. Unfortunately the implementation
> seems buggy as it a) keeps using the possibly uninitialized value
> after
> printing a warning and b) returns the PCIBIOS_* value in place of a
> negative errno and then ignores it in the caller.

In cases like this, usually checking against ~0 is sufficient

Cheers,
Ben.


