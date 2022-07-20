Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2231357BC65
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiGTRMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 20 Jul 2022 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTRMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:12:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F7A6E2D5;
        Wed, 20 Jul 2022 10:12:14 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McZfZ-1neKae0sFJ-00d1JB; Wed, 20 Jul 2022 19:12:13 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31e64ca5161so42426467b3.1;
        Wed, 20 Jul 2022 10:12:12 -0700 (PDT)
X-Gm-Message-State: AJIora+ZvI1Fd4Sc0Pbs+l7jkSLm4vAIZY44SNJK0F/vQPOql0Wj8mpA
        KxezD3EWirjpdegA8BzTxP3gkai8lRRplc4CVoU=
X-Google-Smtp-Source: AGRyM1s89QHkjjhGmVJwE2ZeEtqky4ITMebIfOsOznVwXc8Q/F6CUOLptsVDfN26HLMNx8v2kdgIno4N3DOnVT5ocLw=
X-Received: by 2002:a81:6742:0:b0:31e:7064:9205 with SMTP id
 b63-20020a816742000000b0031e70649205mr2806421ywc.249.1658337131795; Wed, 20
 Jul 2022 10:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220718202843.6766-1-maukka@ext.kapsi.fi> <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
 <20220719094649.pzyrqdvm3fm5fqh2@pali> <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
 <20220720161315.rr4ujakl7akm7pur@pali>
In-Reply-To: <20220720161315.rr4ujakl7akm7pur@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 19:11:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+te5joNfZ0ejv+TxkXBUaPaN2uGUfH4EEkiQH-FeV_w@mail.gmail.com>
Message-ID: <CAK8P3a3+te5joNfZ0ejv+TxkXBUaPaN2uGUfH4EEkiQH-FeV_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:uxI6+MTcjuNtvrEpYEdCpbEksGuWGrZjG4NPWo7Z5ohgH9d/DEq
 if4yGLFmNiazFs88grZvTzr1OTx0+fhYLNojYeDDqMAZrxhcT3m1QIIb0W7dP6Lt4H4Ipb/
 x2mjYEH4RJzn6OJgHGfcuSQoguCKJSRnpS2vq+yyyrjcuI8I1SxQu3N0Yefqa4ImUroIECR
 YNGbQazkBu29lz+lnd71A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SttSVUbKiLw=:IVEhvBEn0ne8ToTyEU6IAv
 PiiEX6YiDn7arTaCDwMYiQo1xS5iwGADeAq/LAdmHxb7UlJrKvFZiGlVyxlcJf/d64uSONssm
 lZcwq6DzocnF4H9bFh57jrdXKpZelk3I9X6v1gVrpsP+uclSpObmhqGN1m1nZoKl9Za6zBmRB
 8zUs93GM+gWEJzCtYAhwyagJhBSRiqfb+ML1gDzWmA3u5w7IVp++M/8SwFxSAeE+dBYwKWP9T
 vF5UmF+sxnA9+0J4NhW4hWKe6dMf4cYtZzEG3NJCoj+Rly1MZZ04l8tNaN635iv/ESZY0rAId
 7Irp45rVgBpx+dvIRc8dMUylO+rYcugXBi6FgQVkSZ0vYT9xkF216dxbVJAOX0WFijzhdNpS9
 p4OYNBUOdce4/G9ctOPAb8J2690VJ5r+vgaOsjpNFdrS3RIS6cIsUZ2KcdbVqkqYvhtGuXQ2E
 yvtVhLKokgSyQLXKy9CSmyWKEnSSBQWNLQpbshom4UkLRbUFmAJdiyM+KS757v2gUEsU29AqU
 KD7+MUkCeNaYkZfBrVYoYbCk2nOrhzFtfnAFer6lvGsVatyElHobMCyrVRIK5LQXRn5c9MSxT
 RRQcPIdtjklWmtLkk06HOQDibWNVmqT5acaeN26MryPeGhAHwFfb7z6xXN6TLN0MF3FpWB2NA
 YzA7xaakPDrBiV+dkKEzHmnml55f6wGsJqUZDGF4jcY7rdFCzrcgf0HzR9GQ/dmvsKGv8oyTu
 TQcNVg1JHsFQwmbXUQ5t5xN6EFAF6Pxts3ck6g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 6:13 PM Pali Rohár <pali@kernel.org> wrote:
>
> On Tuesday 19 July 2022 12:16:34 Arnd Bergmann wrote:
> > On Tue, Jul 19, 2022 at 11:46 AM Pali Rohár <pali@kernel.org> wrote:
> > so you'll probably have to do the same thing as
> > the armada-385, translating the mbus ranges for the config space in the
> > "ranges" property of the parent
>
> Problem is that "ranges" in PCIe are used for specifying MEM and IO
> mappings and kernel PCI code does not allow any other type.
>
> > and then referring to them by PCI
> > MMIO addresses using the assigned-addresses property to pass the
> > config-space registers as a second set of registers in addition to the
> > first set.
>
> It is more complicated. PCIe MEM and IO memory ranges are defined in
> "soc" node in "pcie-mem-aperture" and "pcie-io-aperture" properties.
> These ranges are shared across all PCIe controllers and assigning slices
> of these ranges to specific devices is done later by dynamic allocation.
> "soc" node is bind to mbus driver (which parse these properties) and
> provides API for other kernel drivers for dynamic allocation of memory
> from pcie aperture. In pcie node is just indirect reference to PCIe MEM
> and IO via MBUS_ID() macro and it is pci-mvebu.c driver who ask mbus
> driver for PCIe MEM and IO dynamic allocation.
>
> So because PCIe config space is not of type PCIe MEM nor PCIe IO
> (obviously) it cannot use "ranges" property. Because DT pcie nodes use
> "reg" property for specifying BDF address, we cannot use neither "reg"
> property for specifying memory range of PCIe config space.
>
> And here I'm lost.
>
> My guess is that proper way is to define "pcie-cfg-aperture" in "soc"
> node where would be defined physical address range without any binding
> to controller, then extend mbus driver to export API also for PCIe CFG
> and add code which dynamically assign slice of this range to some
> controller. And then use this new API by pci-mvebu.c to access config
> space. But pci-mvebu.c needs to know MBUS_ID() attributes which needs to
> be defined somewhere in pcie DT node...

I think you can define a "ranges" property in the parent node that
converts the MBUS address into a fake PCI MEM space address,
and this is what the Armada 385 example does with
<0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000>
In the child you can refer to this using the "assigned-addresses"
property and then use the "ranges" to ensure that only the actual
IO and MEM space addresses are translated.

The alternative would be to do away with the indirection and make
the orion5x variant be more like a single hostbridge, and getting
rid of the fake parent. This is closer to what orion5x does at the
moment with the old driver, but might be harder to integrate into
the new one.

> > > > There is little practical difference
> > > > here, but I see no value in taking the shortcut here either.
> > > >
> > > > For the ORION5X_PCIE_WA_VIRT_BASE, you rely on this to match the
> > > > definition in arch/arm/mach-orion5x/common.c, and this is rather fragile.
> > > >
> > > > Instead, please use ioremap() to create a mapping at runtime. The ioremap()
> > > > implementation on ARM is smart enough to reuse the address from the static
> > > > mapping in common.c, but will also keep working if that should go away.
> > >
> > > I'm planning to work with Mauri on this, but current blocker is DT.
> >
> > Ok. It should not be hard to do this first, as you just need to pass the
> > same physical address that you pass in the mbus setup, but I agree
> > it's easier to do this afterwards to avoid having to rewrite it again.
> >
> > > > This is probably good enough here, though I think you could also use
> > > > the trick from drivers/pci/ecam.c and map each bus at a time.
> > > >
> > > Yes, there are also helper functions like map bus and etc. which could
> > > simplify this code. I'm planning to do cleanups once we have fully
> > > working driver for Orion.
> >
> > Ok. This is probably not worth the effort if the old driver doesn't already
> > do provide access to the high registers.
> >
> >       Arnd
>
> If we have free 256MB in physical address space, then we can implement
> it easily. It is just changing _size_ argument. I'm not sure how much
> DDR RAM has Orion, but if only 2GB then we should be fine (remaining 2GB
> should be enough for all peripherals + 256MB for PCIe config space).

I recently checked the sizes as I was researching which boards are actually
still usable, and I can confirm what Andrew also said. The only one with
256MB is TS409, everything else has 32MB to 128MB.

As I said before, I also see no problem with leaving the smaller mapping,
as we know that nobody has ever used the extended config space on
orion5x with mainline kernels, and we are not trying to support new
hardware.

> So we can only set "size" of the physical config space mapping and if we
> choose smaller size then we cannot access upper registers. I do not see
> any option how to specify "offset" for physical config space to allow
> mapping just one PCI bus.
>
> What we have under full control is virtual address space mapping, so we
> can just map only one PCI bus to virtual address space from large 256MB
> physical config address space.

Right.

       Arnd
