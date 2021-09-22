Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F376415005
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhIVSls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 14:41:46 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5FC061574;
        Wed, 22 Sep 2021 11:40:16 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k10so3942312vsp.12;
        Wed, 22 Sep 2021 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+nKAnrreZ04py4QUnwNbEPSSq7In3Evc7HI9+eJYq8=;
        b=V+zZ45PVr3YD1appC2aWyMzl3NAmT7x/mOSuAD2HVkgymIe3v0zJYrBQ4UUQfrWqzt
         h13plD0JR8rbvjb3rq2F9xrTO7dtwWOhVsv8R5atBqEy++WMGmaug8bKOGe3RQ6UnoW2
         VMShUt2SemrXBZH/q/AFtnmP6JQB/J2u4tWVHiIZ86gLRJDEBzvPwL1N8WwEWCFFBB0Z
         oLNFH+cd5SZmgbkRFdxLhJ81ogtY4ufu9deXsPW0FMD8WEPTPb60SSvSGguepfhx2CbG
         6jYHZfIdf8K3UCOIhRFzhyO33jydtbp9tstJ/nQfBueIIdqgGqIMA8hasnpUFBVUV1rS
         qF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+nKAnrreZ04py4QUnwNbEPSSq7In3Evc7HI9+eJYq8=;
        b=qtz/hRfNzs4yYSPC/aJqV0Jn+juNP60mxhP4eCbCQ9f1TDtMDf2PgnR5mfbgWFe5xU
         zzqbrTQQ6iXd5Drh63HWSsvb64LC1SvWPbLO1+DfHSjqAne0ju2V47Ii8/7FdWF6V8en
         bfiGRlje65Xmtiod1fAPcS+7Xk8n0RNesBDyXNNZ6IqSZ9Wo/MhSnV9+dHlygPkvmfQG
         avNDOfRwF+Y3g3CmWLp7ak1W9htOAsTLV/HVDVzoG554GF6MLLwM3QsL4l71CEQhtUyw
         x08irz9dugoOfQxeem++D1Qw1pN3wLwzP5td+uZvu0gkwiUITGjhtvlagCit5Z5D+BHD
         Qvfg==
X-Gm-Message-State: AOAM532rW8+5kGgV7HAn46RDqoHnxzzXlrY2wgXPtLPJe8NRpiNd/cnw
        L96Xt52uNEhAPR+r5BC4TjnwOT/WIJ0yqEjPUQe9+9mIbyM=
X-Google-Smtp-Source: ABdhPJw3ak5dyiT0Kt+p4Ucyx+34+IXTWFtwATIZTIg5NaDBfVKY4kr5p+584xVc/dyzFFsN39otoFa6QQbf2tf9AIs=
X-Received: by 2002:a05:6102:3005:: with SMTP id s5mr919173vsa.48.1632336015500;
 Wed, 22 Sep 2021 11:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com> <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
In-Reply-To: <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 22 Sep 2021 20:40:04 +0200
Message-ID: <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Wed, Sep 22, 2021 at 8:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Wed, Sep 22, 2021 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I'm not completely sure where your platform fits in here, it sounds like you
> > > address them using a machine specific physical address as the base in
> > > inb() plus the port number as an offset, is that correct?
> >
> > I guess none of the above options? I will try to explain this as per
> > my understanding.
> >
> > [+cc Thomas Bogendoerfer as mips maintainer and with better knowledge
> > of mips platforms than me]
> >
> > On MIPS I/O ports are memory mapped, so we access them using normal
> > load/store instructions.
> > Mips 'plat_mem_setup()' function does a 'set_io_port_base(KSEG1)'.
> > There, variable 'mips_io_port_base'
> > is set then using this address which is a virtual address to which all
> > ports are being mapped.
> > KSEG1 addresses are uncached and are not translated by the MMU. This
> > KSEG1 range is directly mapped in physical space starting with address
> > 0x0.
> > Because of this reason, defining PCI_IOBASE as KSEG1 won't work since,
> > at the end 'pci_parse_request_of_pci_ranges' tries to remap to a fixed
> > virtual address (PCI_IOBASE). This can't work for KSEG1 addresses.
> > What happens if I try to do that is that I get bad addresses at pci
> > enumeration for IO resources. Mips ralink mt7621 SoC (which is the one
> > I am using and trying to mainline the driver from staging) have I/O at
> > address 0x1e160000. So instead of getting this address for pcie IO
> > BARS I get a range from 0x0000 to 0xffff since 'pci_adress_to_pio' in
> > that case got that range 0x0-0xffff which is wrong. To have this
> > working this way we would need to put PCI_IOBASE somewhere into KSEG2
> > which will result in creating TLB entries for IO addresses, which most
> > of the time isn't needed on MIPS because of access via KSEG1. Instead
> > of that, what happens when I avoid defining PCI_IOBASE and set
> > IO_SPACE_LIMIT  (See [0] and [1] commits already added to staging tree
> > which was part of this patch series for context of what works with
> > this patch together) all works properly. There have also been some
> > patches accepted in the past which avoid this
> > 'pci_parse_request_of_pci_ranges' call since it is not working for
> > most pci legacy drivers of arch/mips for ralinks platform [2].
> >
> > So I am not sure what should be the correct approach to properly make
> > this work (this one works for me and I cannot see others better) but I
> > will be happy to try whatever you propose for me to do.
>
> Ok, thank you for the detailed explanation.
>
> I suppose you can use the generic infrastructure in asm-generic/io.h
> if you "#define PCI_IOBASE mips_io_port_base". In this case, you
> should have an architecture specific implementation of
> pci_remap_iospace() that assigns mips_io_port_base.

No, that is what I tried originally defining PCI_IOBASE as
_AC(0xa0000000, UL) [0] which is the same as KSEG1 [1] that ends in
'mips_io_port_base'.

> pci_remap_iospace() was originally meant as an architecture
> specific helper, but it moved into generic code after all architectures
> had the same requirements. If MIPS has different requirements,
> then it should not be shared.

I see. So, if it can not be shared, would defining 'pci_remap_iospace'
as 'weak' acceptable? Doing in this way I guess I can redefine the
symbol for mips to have the same I currently have but without the
ifdef in the core APIs...

>
> I don't yet understand how you deal with having multiple PCIe
> host bridge devices if they have distinct I/O port ranges.
> Without remapping to dynamic virtual addresses, does
> that mean that every MMIO register between the first and
> last PCIe bridge also shows up in /dev/ioport? Or do you
> only support port I/O on the first PCIe host bridge?

For example, this board is using all available three pci ports [2] and I get:

root@gnubee:~# cat /proc/ioports
1e160000-1e16ffff : pcie@1e140000
  1e160000-1e160fff : PCI Bus 0000:01
    1e160000-1e16000f : 0000:01:00.0
      1e160000-1e16000f : ahci
    1e160010-1e160017 : 0000:01:00.0
      1e160010-1e160017 : ahci
    1e160018-1e16001f : 0000:01:00.0
      1e160018-1e16001f : ahci
    1e160020-1e160023 : 0000:01:00.0
      1e160020-1e160023 : ahci
    1e160024-1e160027 : 0000:01:00.0
      1e160024-1e160027 : ahci
  1e161000-1e161fff : PCI Bus 0000:02
    1e161000-1e16100f : 0000:02:00.0
      1e161000-1e16100f : ahci
    1e161010-1e161017 : 0000:02:00.0
      1e161010-1e161017 : ahci
    1e161018-1e16101f : 0000:02:00.0
      1e161018-1e16101f : ahci
    1e161020-1e161023 : 0000:02:00.0
      1e161020-1e161023 : ahci
    1e161024-1e161027 : 0000:02:00.0
      1e161024-1e161027 : ahci
  1e162000-1e162fff : PCI Bus 0000:03
    1e162000-1e16200f : 0000:03:00.0
      1e162000-1e16200f : ahci
    1e162010-1e162017 : 0000:03:00.0
      1e162010-1e162017 : ahci
    1e162018-1e16201f : 0000:03:00.0
      1e162018-1e16201f : ahci
    1e162020-1e162023 : 0000:03:00.0
      1e162020-1e162023 : ahci
    1e162024-1e162027 : 0000:03:00.0
      1e162024-1e162027 : ahci
root@gnubee:~#

>
> Note that you could also decide to completely sidestep the
> problem by just defining port I/O to be unavailable on MIPS
> when probing a generic host bridge driver. Most likely this
> is never going to be used anyway, and it will be rather hard
> to test if you don't already have the need ;-)

I don't really have any pci card with IO resources to test, but this
SoC is extensively used in openWRT and I remember people who had such
cards with I/O because they were asking me for I/O since it did not
work properly, so I guess I can decide that but if it can work I
prefer to try to make it work :). I searched a bit for the link with
that conversation but I was not able to find it :(.

Thanks for your feedback and time :).

Best regards,
    Sergio Paracuellos

>
>          Arnd

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=159697474db41732ef3b6c2e8d9395f09d1f659e
[1]: https://elixir.bootlin.com/linux/v5.15-rc2/source/arch/mips/include/asm/addrspace.h#L99
[2]: https://patchwork.kernel.org/project/linux-pci/patch/20210922050035.18162-2-sergio.paracuellos@gmail.com/
