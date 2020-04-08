Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59DB1A2C17
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDHXFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 19:05:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33384 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDHXFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2020 19:05:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so10951470ede.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2020 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1tDjczMrYloX4T8MREGPGdm/TdCzp9xT7G1pG4Bjg4=;
        b=HN0qKzdw/Q+LqK8LjgSiuE++9y/znYA88gdiOVsstubBYILnR1DQ1mlRuvXPgQyrpn
         HbdxVzHF4d7M5ClnrXQivkaIW6x/Hcla6syFG9M8i9zmNX+FltdRwVL3FqnFyvexOs+3
         ZRLBsvYi1VQqRzZmDwsNs9NB7hJp8FpNkAiTDZ1YwEFZfkZQPARvH/ll0fTE2ZCfjkl9
         oGO9RRWM0QDjMlzip64pncdAJEFz5iuUYABsJZlEcdrTgIXPDUO1fst/EO56YpAs6rIR
         ltZScjxZ91/32iBFw8eP5vYP0laoo9o2DCiG7cm5cbPEfyVG1VmVPc82Wy47F+GsTXGn
         W8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1tDjczMrYloX4T8MREGPGdm/TdCzp9xT7G1pG4Bjg4=;
        b=KqcJQHFC+1kS/I6wSOKMCGPpgg3RupccLG5FV/L46RCgO3WCo14r/A4lgI+8EbDJh0
         R17ou1N75GxgLcVznkddrVo0R5acBy2DkBS7RQGIneSpwL7KNllxGQ8dabBZAkhknV7U
         ZkNQJo72mF0/mATIisayvQGvtY99S3HcPGWZS3OB02BItIsTwPg4KETbjhcmGRqbUq5M
         aNFNls54Ch0B/QxdOCNh+lz2YSYtzN02HOGfqSroAddTVuS9dhEldoq4XV6WjNti88FR
         iJQuQfRF6MVgH3NeDmXdQ2waAed8JdYPtnIMMaKyJqa2VihSXaZqwC0MUk6f5sJD2BoI
         EPMw==
X-Gm-Message-State: AGi0PubUOCy8vwqgY2aiuofm72pb8zzCizy/CT6V8dVEgMLi1IIw0b1T
        Mb53+JuM9EF1i+iPEsMmvP9ZQiAwyS8UBSYdM2M=
X-Google-Smtp-Source: APiQypJzlSC70zj47pCMi72Ih1Z7PfreW3eTQfFP6BalOciFExiU1xjq2S/atnA8r+cPLpuIs8G5MTOnmh8UINzVVqg=
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr2014236ejb.342.1586387136852;
 Wed, 08 Apr 2020 16:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
 <20200404013233.GA30614@google.com> <CAEzXK1pNiy_pjDh_=2XKpKUwEfO39rFubkviZyT_7DqEaQ7z5w@mail.gmail.com>
In-Reply-To: <CAEzXK1pNiy_pjDh_=2XKpKUwEfO39rFubkviZyT_7DqEaQ7z5w@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Apr 2020 00:05:25 +0100
Message-ID: <CAEzXK1oU4KwatuXAjUwj5arZtdmDSgFsm2vn8DrAWCJu-v-r0g@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I have successfully setup a JTAG remote debug environment.
And I found this:
First call to __pci_bus_assign_resources visits 11ab:6828 -> SLOT 1,
which in turn calls __pci_bus_assign_resources which visits device
1ac1:089a on that slot and calls:
/*
 * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they are
 * skipped by pbus_assign_resources_sorted().
 */
static void pdev_assign_fixed_resources(struct pci_dev *dev)
{
        int i;

       pci_info(dev, "%s\n", __func__);
        for (i =3D 0; i <  PCI_NUM_RESOURCES; i++) {
                struct pci_bus *b;
                struct resource *r =3D &dev->resource[i];

                if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
                    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
                        continue;

                b =3D dev->bus;
                while (b && !r->parent) {
                        assign_fixed_resource_on_bus(b, r);
                        b =3D b->parent;
                }
        }
}
where dev has the following data before calling
pdev_assign_fixed_resources, for some reason BAR0 and BAR2 are skipped
or assign_fixed_resource_on_bus is not called :
dev->vendorID 6849(0x1ac1)
   ->deviceID 2202(0x089a)
   ->resource=3D{ {start =3D 0
         end=3D16383
         name=3D"0000:01:00.0"
         flags=3D1319436(0x14220C)
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D0x0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0,
         end =3D 1048575,
         name=3D"0000:01:00.0"
         flags=3D1319436(0x14220C)
         desc=3D0,
         parent=3D0x0,
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D"0000:01:00.0"
         flags=3D0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D"0000:01:00.0"
         flags=3D0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D"0000:01:00.0"
         flags=3D0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D0x0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D0x0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D0x0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0},
        {start =3D 0
         end=3D0
         name=3D0x0
         desc=3D0
         parent=3D0x0
         sibling=3D0x0
         child=3D0x0}}

Lu=C3=ADs

On Sat, Apr 4, 2020 at 10:39 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
>
> Hi Bjorn,
>
> Thanks again for your help.
>
> Ok... I've tested your theory on this system and still no changes. The
> BARs 0 and 1 are still not assigned. I should note that this issue
> does not occur only on this particular armhf system, but also on a
> Toradex Apalis IMX8QM, which in this case is an arm64 device and
> doesn't make use of the mvebu infrastructure.
>
> So I did issue the following commands:
> # echo 1 > /sys/bus/pci/devices/0000\:00\:01.0/0000\:01\:00.0/remove
> # echo 1 > /sys/bus/pci/devices/0000\:00\:01.0/dev_rescan"
>
> And the dmesg update after the last command is:
> [   61.124696] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
> [   61.124732] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff
> 64bit pref]
> [   61.124743] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff
> 64bit pref]
> [   61.161258] pci_bus 0000:01: __pci_bus_size_bridges
> [   61.161270] pci_bus 0000:01: pbus_size_mem: mask 0x2200 type 0x2200
> 0x2200 0x2200 min 0x0 add 0x0 b_res (null) parent (null)
> [   61.161277] pci_bus 0000:01: pbus_size_mem: mask 0x200 type 0x200
> 0x200 0x200 min 0x0 add 0x0 b_res [mem 0xd0000000-0xd01fffff] parent
> [mem 0xd0000000-0xefffffff]
> [   61.161281] pci_bus 0000:02: __pci_bus_size_bridges
> [   61.161286] pci_bus 0000:02: pbus_size_mem: mask 0x2200 type 0x2200
> 0x2200 0x2200 min 0x0 add 0x0 b_res (null) parent (null)
> [   61.161291] pci_bus 0000:02: pbus_size_mem: mask 0x200 type 0x200
> 0x200 0x200 min 0x0 add 0x0 b_res [mem 0x00000000] parent (null)
> [   61.161295] pci_bus 0000:00: __pci_bus_assign_resources
> [   61.161298] pci_bus 0000:00: pbus_assign_resources_sorted
> [   61.161302] pci 0000:00:01.0: __dev_sort_resources
> [   61.161305] pci 0000:00:02.0: __dev_sort_resources
> [   61.161308] __assign_resources_sorted
> [   61.161311] pci 0000:00:01.0: __pci_bus_assign_resources
> [   61.161314] pci 0000:00:01.0: pdev_assign_fixed_resources
> [   61.161317] pci_bus 0000:01: __pci_bus_assign_resources
> [   61.161319] pci_bus 0000:01: pbus_assign_resources_sorted
> [   61.161323] pci 0000:01:00.0: __dev_sort_resources
> [   61.161324] __assign_resources_sorted
> [   61.161327] pci 0000:01:00.0: __pci_bus_assign_resources
> [   61.161330] pci 0000:01:00.0: pdev_assign_fixed_resources
> [   61.161333] pci 0000:00:01.0: PCI bridge to [bus 01]
> [   61.161340] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd01fff=
ff]
> [   61.161344] pci 0000:00:02.0: __pci_bus_assign_resources
> [   61.161347] pci 0000:00:02.0: pdev_assign_fixed_resources
> [   61.161350] pci_bus 0000:02: __pci_bus_assign_resources
> [   61.161353] pci_bus 0000:02: pbus_assign_resources_sorted
> [   61.161354] __assign_resources_sorted
> [   61.161357] pci 0000:00:02.0: PCI bridge to [bus 02]
>
> Lu=C3=ADs
>
> On Sat, Apr 4, 2020 at 2:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> >   pci 0000:02:00.0: [10ec:525a] type 00 class 0xff0000
> >   pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> >   pci 0000:02:00.0: BAR 1: assigned [mem 0xf1100000-0xf1100fff]
> >   pci 0000:02:00.0: BAR 1: error updating (0xf1100000 !=3D 0xffffffff)
> >
> > So we correctly detected the device, read the cleared BAR, and
> > allocated space for it, and tried to update the BAR.  On my system the
> > update failed, I think because of a power management issue (all config
> > reads now return 0xffffffff).  But there have been a lot of power
> > management fixes since the v5.2 kernel I'm running, so it's possible
> > you'd have better luck.
> >
> > On your system, I think you would want something like:
> >
> >   # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/remove
> >   # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/rescan
> >
