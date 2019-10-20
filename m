Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88A5DDD73
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2019 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJTJRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 05:17:21 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:41790 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTJRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2019 05:17:21 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Oct 2019 05:17:20 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 343082006DB;
        Sun, 20 Oct 2019 09:08:35 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4B01C20552; Sun, 20 Oct 2019 11:08:00 +0200 (CEST)
Date:   Sun, 20 Oct 2019 11:08:00 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     "Michael ." <keltoiboy@gmail.com>, linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Subject: PCI device function not being enumerated [Was: PCMCIA not working on
 Panasonic Toughbook CF-29]
Message-ID: <20191020090800.GA2778@light.dominikbrodowski.net>
References: <CAFjuqNh1=B7Ft6v7nzo3BW70EbAvK=Eko_4yqrJ4Z4N3w_Y+Xw@mail.gmail.com>
 <CAFjuqNjLJw8J0nU2oo8rDfDUBavHLC7D0=AAwM62tp6=kHHk-A@mail.gmail.com>
 <20191015064801.GA104469@owl.dominikbrodowski.net>
 <CAFjuqNgxAuf+JTkWqhimDspzPd0+s5yGJro=Zi164uoxu4CmOA@mail.gmail.com>
 <CANfzparZ17SMzE1qzzF=Rixu=aYpf1RiKqR4KXXS0S+u7Q3TwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANfzparZ17SMzE1qzzF=Rixu=aYpf1RiKqR4KXXS0S+u7Q3TwQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the basis of the additional information (thanks), there might be a
more specific path to investigate: It is that the PCI code does not
enumerate the second cardbus bridge PCI function in the more recent 4.19
kernel compared to the anvient (and working) 2.6 kernel.

Namely, only one CardBus bridge is recognized

...
06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
06:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 11)
06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG [Calexico2] Network Connection (rev 05)
...

instead of the two which really should be present:

...
06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
06:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
06:01.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 11)
06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG [Calexico2] Network Connection (rev 05)
...

To the PCI folks: any idea on what may cause the second cardbus bridge PCI
device function to be missed? Are there any command line options the users
who reported this issue[*] may try?

As this isn't really a PCMCIA (16bit) issue, but a PCI enumeration issue,
this issue is outside my area of expertise.

Thanks,
	Dominik

[*] For more information, see this thread:
	https://lore.kernel.org/lkml/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
