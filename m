Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DCF4E011
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 07:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFUFdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 01:33:32 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54597 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfFUFdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 01:33:32 -0400
X-Originating-IP: 85.23.31.57
Received: from windsurf (85-23-31-57.bb.dnainternet.fi [85.23.31.57])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0C874FF805;
        Fri, 21 Jun 2019 05:33:23 +0000 (UTC)
Date:   Fri, 21 Jun 2019 07:33:18 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kirkwood PCI Express and bridges
Message-ID: <20190621073318.3bcd940e@windsurf>
In-Reply-To: <403548ec3a7543b08ca32e47a1465e70@svr-chch-ex1.atlnz.lc>
References: <403548ec3a7543b08ca32e47a1465e70@svr-chch-ex1.atlnz.lc>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Chris,

On Fri, 21 Jun 2019 04:03:27 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> I'm in the process of updating the kernel version used on our products 
> from 4.4 -> 5.1.
> 
> We have one product that uses a Kirkwood CPU, IDT PCI bridge and Marvell 
> Switch ASIC. The Switch ASIC presents as multiple PCI devices.
> 
> The hardware setup looks like this
>                                         __________
> [ Kirkwood ] --- [ IDT 5T5 ] ---+---  |          |
>                                  +---  |  Switch  |
>                                  +---  |          |
>                                  +---  |__________|
> 
> On the 4.4 based kernel things are fine
> 
> [root@awplus flash]# lspci -t
> -[0000:00]---01.0-[01-06]----00.0-[02-06]--+-02.0-[03]----00.0
>                                             +-03.0-[04]----00.0
>                                             +-04.0-[05]----00.0
>                                             \-05.0-[06]----00.0
> 
> But on the 5.1 based kernel things get a little weird
> 
> [root@awplus flash]# lspci -t
> -[0000:00]---01.0-[01-06]--+-00.0-[02-06]--
>                             +-01.0
>                             +-02.0-[02-06]--
>                             +-03.0-[02-06]--
>                             +-04.0-[02-06]--
>                             +-05.0-[02-06]--
>                             +-06.0-[02-06]--
>                             +-07.0-[02-06]--
>                             +-08.0-[02-06]--
>                             +-09.0-[02-06]--
>                             +-0a.0-[02-06]--
>                             +-0b.0-[02-06]--
>                             +-0c.0-[02-06]--
>                             +-0d.0-[02-06]--
>                             +-0e.0-[02-06]--
>                             +-0f.0-[02-06]--
>                             +-10.0-[02-06]--
>                             +-11.0-[02-06]--
>                             +-12.0-[02-06]--
>                             +-13.0-[02-06]--
>                             +-14.0-[02-06]--
>                             +-15.0-[02-06]--
>                             +-16.0-[02-06]--
>                             +-17.0-[02-06]--
>                             +-18.0-[02-06]--
>                             +-19.0-[02-06]--
>                             +-1a.0-[02-06]--
>                             +-1b.0-[02-06]--
>                             +-1c.0-[02-06]--
>                             +-1d.0-[02-06]--
>                             +-1e.0-[02-06]--
>                             \-1f.0-[02-06]--+-02.0-[03]----00.0
>                                             +-03.0-[04]----00.0
>                                             +-04.0-[05]----00.0
>                                             \-05.0-[06]----00.0
> 
> 
> I'll start bisecting to see where things started going wrong. I just 
> wondered if this rings any bells for anyone.

I am almost sure that the culprit is
1f08673eef1236f7d02d93fcf596bb8531ef0d12 ("PCI: mvebu: Convert to PCI
emulated bridge config space").

I still think it makes sense to share the bridge emulation code between
the mvebu and aardvark drivers, but this sharing has required making
the code very different, with lots of subtle differences in behavior in
how registers are emulated.

Unfortunately, I don't have access to one of these complicated PCI
setup with a HW switch on the way, so I couldn't test this kind of
setups.

Do you mind helping with figuring out what the issues are ? That would
be really nice.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
