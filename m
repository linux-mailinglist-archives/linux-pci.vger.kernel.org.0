Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789522055F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 08:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGOGrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 02:47:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 02:47:39 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7sQ8-1jzSp816GY-0050Q9; Wed, 15 Jul 2020 08:47:36 +0200
Received: by mail-qk1-f174.google.com with SMTP id b185so871202qkg.1;
        Tue, 14 Jul 2020 23:47:35 -0700 (PDT)
X-Gm-Message-State: AOAM532LrhM8hiVVJOK5szknGYigk+QyT6hGxaJj8ouEmzM0Tan6qN4p
        6sOhYgiDfFfclZnxoY+vKIyb0FSRZ+r/GKo5AeU=
X-Google-Smtp-Source: ABdhPJyFS0Zk4AmYJjgRoHnkDRGYzV2yqrKuev4xpaWExBMOSp+Vk7tlNoV31gVNZsw16288M3SPusHOFA0ODDFCn0I=
X-Received: by 2002:a37:a496:: with SMTP id n144mr8314087qke.286.1594795654855;
 Tue, 14 Jul 2020 23:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
 <20200714234625.GA428442@bjorn-Precision-5520>
In-Reply-To: <20200714234625.GA428442@bjorn-Precision-5520>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jul 2020 08:47:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
Message-ID: <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ov73+FkWwqGvDa0Nd9xKW4QYYDGcw0TUwF/8ivnuG1D8a0mbzvW
 LVK/98InOx7ZAWF2Ybaus8kHATrC0tfSvZSg6GJJ9RYYOLnSVyK2RzSSmyVYdKEvOpn7JtU
 xhXzOPSGrSBf06b3T2Ykg/Rtz55itFj0U9A1/pc5LbW/PXQY1V9e+H+YLfRFMdieO5Kp4RV
 abg3RR8d6mSOt/zih4tow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ysEtf4/W10=:ErYqQP9WJNbcjMCKGNPZaL
 SXuVyVI8Bxq7mRI3jEh9IJ9wZ7h1Gk0VOJe7yAFPGFii1qYzZdmww9s+Vol7k4WSNbxrfTa9P
 maWNGQbXG6WgYs3uOa7b2HfWcgM5TiXYLZ5UTF9ty4hjHNaXkPEsd1LuDAI15xjDF6FZEhbOK
 GrlC93UXHHwXaBsZNes07PPGGEwfUoAlI2q+bvlbC9NiNJO34YYcLE8o/zOZ66VHWvN5mdKh8
 TLiA9elD4OcrxVgkG6OD2URYvoob4IVTM/lWNpOOXELPT9V2LoB7eWTIALUWrz9vfLsId15KT
 ruYwqEziCy2jF8Q28G0+e5CehAY0Yn6z/xB30AOLme4Ue2vjKFkaHZv7qzDaBrm7fmXo7iHuj
 k6Snjwpf9oomxvUTYYwWuc+NqIcNwDvykgAm2XB9jYLtZUq5E9UiLpLBxdSbhJFGBlhGuP91p
 6ddT/fhpEXn3St9B9Xburqq/AoI5BwWdltiYfO87oJ4HlzN7WPnvfuY5HvbvnCHkLwHx0T0lF
 jP5Tnn91+Z7BO6I5ENKT470MUe36vIXVwtJUKFtboh50d824RUOh9G1C7X5VwsTkkCooxeSN5
 cV2XqpO83DRYqEofW8IHTHWiyDkugVqfDE8o+bJhC08etgjkpHa9J8mh3J1sVJ5jX1eU2jL5j
 Hv5OjT35eMzL8R7+Ij1iZIsFBBRwhSegzO+OfoTdvCLo/QAWiTnF8dxpuJITdPVDUpPOgothf
 MRViAVrKjnEP7+I7gEwYwwGFIk5mZFOgog1apOiWiGuvhPPxXI7ssB1PW+5CNcBbcFU2FcrBZ
 kdt0/qDvWkqAIt0nrrwAaooG0FS/5j4olvDVtvW/o2403TsGEWybMLig4sM+bICzMa3X47wwa
 h9Pn5bSTiPUVxs71Gphsj5L5hTW1T8ysjpauL1A1NtsPEdbDqbb4fxHU7PHWZ9ibT4fViOqJU
 InVriLguElFCSH67Fo/POd23hKoNMFlAmPNRjDK65NrGUGdl+trF9
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 15, 2020 at 1:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

 So something like:
>
>   void pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
>
> and where we used to return anything non-zero, we just set *val = ~0
> instead?  I think we do that already in most, maybe all, cases.

Right, this is what I had in mind. If we start by removing the handling
of the return code in all files that clearly don't need it, looking at
whatever remains will give a much better idea of what a good interface
should be.

>  git grep -E "(if|return|=).*\<pci_(read|write)_config" drivers
> finds about 400 matches.

Right, and this is some 112 files to look at.

I had a slightly different regex, which found more false-positives, but
also these:

arch/x86/kernel/amd_nb.c:      : pci_read_config_dword(root, 0x64, value));
drivers/i2c/busses/i2c-sis630.c:     pci_write_config_byte(sis630_dev,
SIS630_BIOS_CTL_REG, b | 0x80)) {
drivers/i2c/busses/i2c-viapro.c:     !pci_read_config_word(pdev,
SMBBA2, &vt596_smba) &&
drivers/ide/rz1000.c:     !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
drivers/net/ethernet/realtek/r8169_main.c:
pci_write_config_byte(pdev, 0x070f, val) == PCIBIOS_SUCCESSFUL)
include/linux/rtsx_pci.h:#define rtsx_pci_read_config_dword(pcr,
where, val) pci_read_config_dword((pcr)->pci, where, val)
include/linux/rtsx_pci.h:#define rtsx_pci_write_config_dword(pcr,
where, val) pci_write_config_dword((pcr)->pci, where, val)
drivers/misc/cardreader/rts5261.c:              retval =
rtsx_pci_read_config_dword(pcr,
drivers/misc/cardreader/rts5261.c:      retval =
rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);

That last one is interesting because I think this is a case in which we
actually want to check for errors, as the driver seems to use it
to ensure that accessing extended config space at offset 0x814
works before relying on the value. Unfortunately the implementation
seems buggy as it a) keeps using the possibly uninitialized value after
printing a warning and b) returns the PCIBIOS_* value in place of a
negative errno and then ignores it in the caller.

      Arnd
