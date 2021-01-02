Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C82E8780
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jan 2021 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhABNof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jan 2021 08:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhABNoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jan 2021 08:44:32 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6ADC061573
        for <linux-pci@vger.kernel.org>; Sat,  2 Jan 2021 05:43:51 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id v3so5177252vkb.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Jan 2021 05:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvoKi/UdTaiI0OLkGRfi2t7gorBCZNrDhcQKoTT864c=;
        b=NmfsYvfoo7D/VEdPe1IFrkTnSfar5I0KkeA1fUrOiW6OpPzrd//lq4LtHTvfDKEt46
         b3X+ST1Tz0OnNYwv453IFZgWgZEfOKJkB58N9gwQQMNtR9LnnvqAK/zhVJ28J2sBtmPg
         M9j25jOvaBejwraB9u+k+LAewa0cV1Mw9o0w2zhhzNxgkFrzKPaRVFDShncAz6hkz9dC
         84fpiQs89bnT+ZGxrR+wEcb/ETPykNofTSLqqAxWgVVEI75b/MGRwnXTeMCSbDSD8/ol
         xr8JnCL0upwedfhRWqSNtl7k4+PKTsSFOy4AGM4Yw0cTFuJHB+jvURAfWTWT2xc5a6h8
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvoKi/UdTaiI0OLkGRfi2t7gorBCZNrDhcQKoTT864c=;
        b=Qhwo9O/rbmDYXKgnJx7HWk4HhhI5W91fMaCpG4izrCAK2Cx6n7STL9RgSHRiajrFQT
         9RvCxiObMR8coD9DY0NMpqIOftlTI3/OagrZCugsLJF3TyHZiovHygEct0YrCvwm7PtP
         2/6meUpIintXgPzUGk8ekMRGpWkzQvBVUVosorXDBgj9coLKCgdj+iRgKNOmeE0IHfWL
         ti2XhNZLxZb3ry+EYuYHzhDToPtTcpJuoCmjqTmHpmoCI2/NWeKzet81eUdIg9g2R2vf
         /CLiwCUJvLKOaLktmz1786gOYJi+pAF4nVvRZ8LMAczs2VMaynfuRnAdWG8tXOLw5LXs
         zm8Q==
X-Gm-Message-State: AOAM532jaZH5Kp9PhbU4xHxy/Zh3Ah+fM5fUoOWfbB+iisZLCfACYMur
        EktpgtIwTI0IFUZEak2mnl6TcXt1Gh8HmqUVeBQ=
X-Google-Smtp-Source: ABdhPJx4G8iD3SygzVqqF59+DKBXBlI7vaCnbgu5KqPS3RkrY6tID1fBqcuyKwdAZkoRa+ird6b866tH0jIiUbMgUuk=
X-Received: by 2002:a1f:3889:: with SMTP id f131mr22844732vka.22.1609595029317;
 Sat, 02 Jan 2021 05:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20201231125214.25733-2-nuumiofi@gmail.com> <20210101173744.GA921848@bjorn-Precision-5520>
In-Reply-To: <20210101173744.GA921848@bjorn-Precision-5520>
From:   =?UTF-8?B?SmFyaSBIw6Rtw6Rsw6RpbmVu?= <nuumiofi@gmail.com>
Date:   Sat, 2 Jan 2021 15:43:37 +0200
Message-ID: <CA+_S-OqAE5xoV=DFGJ=oOLrdfHEUVQ2d0tSyJ2Cksp5DGmAc7g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PCI: rockchip: provide workaround for bus scan
 crash with optional delay
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 1, 2021 at 7:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Dec 31, 2020 at 02:52:12PM +0200, Jari H=C3=A4m=C3=A4l=C3=A4inen =
wrote:
> > Some PCIe devices cause Rockchip PCIe controller to crash in bus scan.
> > Crash may be avoided by delaying bus scan by time given from command li=
ne
> > or from device tree. Needed amount of delay varies from device to devic=
e.
> > Delay doesn't have to be exact. It just has to be long enough.
>
> Is this a standard post-reset delay that the rockchip driver is
> missing?  Maybe compare with other drivers to see if rockchip is
> missing something.
>
> Is this an erratum in the Rockchip IP?  If so, we should have a
> specific description and a citation for it, and a workaround could be
> done automatically without DT or command-line switches.

Thanks for your reply!

This patch was not based on Rockchip erratum or other documentation. It was
found by a lucky shot when trying to get Rockchip PCIe working with
these devices. I'm sorry for not mentioning that in the first place. In
that sense "a hack" would be a better description than "workaround".

I'll look at other drivers and see if I can spot anything missing from
Rockchip. Designware driver seems like a good place to start. I'm newbie in
kernel hacking and even more so with PCIe so pointers are welcome.

> > The following lists few problematic PCIe devices with delays needed for
> > stable bus scan surviving 100 sequential reboots in test loop executed =
on
> > RockPro64 (RK3399 single-board computer):
> > - LSI 9201-8i         / SAS2008 chipset [1000:0072]: 725 ms
> > - LSI 9302-8i         / SAS3008 chipset [1000:0097]: 575 ms (1)
> > - HP H220             / SAS2308 chipset [1000:0087]: 800 ms (2)
> > - IBM ServeRAID M5110 / SAS2208 chipset [1000:005b]: 1050 ms (3)
> >
> >   1) mpt3sas module has soft lockup bug on shutdown but device is usabl=
e
> >   2) has infrequent crash on mpt3sas module load (2 of 662 reboots in a=
ll
> >      test sessions with this device crashed on module load)
> >   3) megaraid_sas module crashes on load so device remains unusable
> >      (bus scan tested with module being blacklisted)
> >
> > Side effect of delay, if set, is that it slows down system startup by t=
he
> > amount of delay.
> >
> > Log excerpt showing a crash happening always on unpatched kernel with
> > problematic PCIe devices listed above rendering them unusable:
>
> It doesn't seem likely that the devices above are broken since we
> don't have problems with them on other systems.  More likely to be
> some Rockchip-specific thing, and the devices above are operating
> within spec (possibly using more of the allowed post-reset time than
> most devices).

This seems to be Rockchip-specific indeed. All devices above worked fine on
x86-based setup.

> > [    1.240649] SError Interrupt on CPU5, code 0xbf000002 -- SError
>
> We really should know more about what the specific error is.  Most
> errors on PCIe should be recoverable and they can happen at any time,
> not just at boot-time.
>
> This patch adds a boot-time delay.  At run-time, if we power-cycle or
> reset a device and re-enumerate the bus, we would likely see the same
> problem and this patch wouldn't help.

I will try to dig deeper into details of this error. Maybe megaraid_sas
driver crashing on module load is a manifestation of same problem and could
offer a hint or at least another viewpoint to what goes on.

> > [    1.240653] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable =
#1
> > [    1.240656] Hardware name: Pine64 RockPro64 v2.0 (DT)
> > [    1.240659] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=3D--)
> > [    1.240661] pc : rockchip_pcie_rd_conf+0x178/0x268
> > [    1.240664] lr : rockchip_pcie_rd_conf+0x1b8/0x268
> > [    1.240666] sp : ffff8000119db850
> > [    1.240669] x29: ffff8000119db850 x28: 0000000000000000
> > [    1.240676] x27: 0000000000000000 x26: 0000000000000000
> > [    1.240682] x25: ffff8000119db984 x24: 0000000000000000
> > [    1.240688] x23: 0000000000000000 x22: ffff000040ba0b80
> > [    1.240694] x21: ffff8000119db8d4 x20: 0000000000000004
> > [    1.240700] x19: 0000000000100000 x18: ffffffffffffffff
> > [    1.240706] x17: 0000000031cae143 x16: 000000008c75157c
> > [    1.240712] x15: ffff800011729908 x14: ffff000040c87a1c
> > [    1.240718] x13: ffff000040c87293 x12: 0000000000000038
> > [    1.240724] x11: 0000000005f5e0ff x10: 7f7f7f7f7f7f7f7f
> > [    1.240729] x9 : 0000000001001d87 x8 : 000000000000ea60
> > [    1.240735] x7 : ffff8000119db984 x6 : 0000000000000000
> > [    1.240741] x5 : 0000000000000000 x4 : 0000000000c00008
> > [    1.240747] x3 : ffff800017000000 x2 : 000000000080000a
> > [    1.240753] x1 : 0000000000000000 x0 : ffff800014000000
> > [    1.240759] Kernel panic - not syncing: Asynchronous SError Interrup=
t
> > [    1.240763] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable =
#1
> > [    1.240765] Hardware name: Pine64 RockPro64 v2.0 (DT)
> > [    1.240768] Call trace:
> > [    1.240770]  dump_backtrace+0x0/0x1e8
> > [    1.240772]  show_stack+0x18/0x60
> > [    1.240775]  dump_stack+0xd8/0x130
> > [    1.240777]  panic+0x15c/0x380
> > [    1.240779]  add_taint+0x0/0xb0
> > [    1.240782]  arm64_serror_panic+0x78/0x88
> > [    1.240784]  do_serror+0x3c/0x68
> > [    1.240787]  el1_error+0x84/0x104
> > [    1.240789]  rockchip_pcie_rd_conf+0x178/0x268
> > [    1.240791]  pci_bus_read_config_dword+0xa4/0x150
> > [    1.240794]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
> > [    1.240797]  pci_bus_read_dev_vendor_id+0x4c/0x78
> > [    1.240800]  pci_scan_single_device+0x80/0x100
> > [    1.240802]  pci_scan_slot+0x38/0x130
> > [    1.240805]  pci_scan_child_bus_extend+0x58/0x348
> > [    1.240807]  pci_scan_bridge_extend+0x304/0x5a0
> > [    1.240810]  pci_scan_child_bus_extend+0x20c/0x348
> > [    1.240812]  pci_scan_root_bus_bridge+0x64/0xf0
> > [    1.240815]  pci_host_probe+0x18/0xc8
> > [    1.240817]  rockchip_pcie_probe+0x34c/0x4b8
> > [    1.240820]  platform_drv_probe+0x54/0xa8
> > [    1.240822]  really_probe+0x29c/0x4f8
> > [    1.240824]  driver_probe_device+0xfc/0x168
> > [    1.240827]  device_driver_attach+0x74/0x80
> > [    1.240829]  __driver_attach+0xb8/0x168
> > [    1.240832]  bus_for_each_dev+0x7c/0xd8
> > [    1.240834]  driver_attach+0x24/0x30
> > [    1.240837]  bus_add_driver+0x15c/0x240
> > [    1.240839]  driver_register+0x64/0x120
> > [    1.240841]  __platform_driver_register+0x44/0x50
> > [    1.240844]  rockchip_pcie_driver_init+0x1c/0x28
> > [    1.240846]  do_one_initcall+0x60/0x1d8
> > [    1.240849]  kernel_init_freeable+0x234/0x2b4
> > [    1.240851]  kernel_init+0x14/0x118
> > [    1.240854]  ret_from_fork+0x10/0x34
> > [    1.240878] SMP: stopping secondary CPUs
> > [    1.240881] Kernel Offset: disabled
> > [    1.240883] CPU features: 0x0240022,2100200c
> > [    1.240886] Memory Limit: none
> >
> > Signed-off-by: Jari H=C3=A4m=C3=A4l=C3=A4inen <nuumiofi@gmail.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt          |  8 ++++++++
> >  drivers/pci/controller/pcie-rockchip-host.c    | 18 ++++++++++++++++++
> >  drivers/pci/controller/pcie-rockchip.c         |  5 +++++
> >  drivers/pci/controller/pcie-rockchip.h         |  2 ++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index c722ec19cd00..fda9bb9c85c3 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3823,6 +3823,14 @@
> >               nomsi   Do not use MSI for native PCIe PME signaling (thi=
s makes
> >                       all PCIe root ports use INTx for all services).
> >
> > +     pcie_rockchip_host.bus_scan_delay_ms=3D
> > +                     [PCIE] delay before PCIe bus scan in milliseconds=
.
> > +                     If set to greater than or equal to 0 this paramet=
er will
> > +                     override delay set in device tree. Values less th=
an 0
> > +                     are ignored. This parameter provides a workaround=
 for
> > +                     some devices causing a crash in bus scan.
> > +                     Default: -1
> > +
> >       pcmv=3D           [HW,PCMCIA] BadgePAD 4
> >
> >       pd_ignore_unused
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/=
controller/pcie-rockchip-host.c
> > index f1d08a1b1591..14733c92b25c 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> > +#include <linux/moduleparam.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_pci.h>
> > @@ -39,6 +40,9 @@
> >  #include "../pci.h"
> >  #include "pcie-rockchip.h"
> >
> > +static int bus_scan_delay_ms =3D -1;
> > +module_param(bus_scan_delay_ms, int, 0444);
> > +
> >  static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip=
)
> >  {
> >       u32 status;
> > @@ -941,6 +945,7 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct pci_host_bridge *bridge;
> >       int err;
> > +     u32 delay =3D 0;
> >
> >       if (!dev->of_node)
> >               return -ENODEV;
> > @@ -992,6 +997,19 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >       bridge->sysdata =3D rockchip;
> >       bridge->ops =3D &rockchip_pcie_ops;
> >
> > +     /*
> > +      * Work around a crash caused by some devices on bus scan by appl=
ying a
> > +      * delay if one is given. Prefer command line value over device t=
ree.
> > +      */
> > +     if (bus_scan_delay_ms >=3D 0)
> > +             delay =3D bus_scan_delay_ms;
> > +     else
> > +             delay =3D rockchip->bus_scan_delay_ms;
> > +     if (delay > 0) {
> > +             dev_info(dev, "delay bus scan for %u ms\n", delay);
> > +             msleep(delay);
> > +     }
> > +
> >       err =3D pci_host_probe(bridge);
> >       if (err < 0)
> >               goto err_remove_irq_domain;
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 904dec0d3a88..2e49e9204894 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -149,6 +149,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *r=
ockchip)
> >               return PTR_ERR(rockchip->clk_pcie_pm);
> >       }
> >
> > +     err =3D of_property_read_u32(node, "rockchip,bus-scan-delay-ms",
> > +                                &rockchip->bus_scan_delay_ms);
> > +     if (err)
> > +             rockchip->bus_scan_delay_ms =3D 0;
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/contr=
oller/pcie-rockchip.h
> > index 1650a5087450..18f37820b35b 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -300,6 +300,8 @@ struct rockchip_pcie {
> >       phys_addr_t msg_bus_addr;
> >       bool is_rc;
> >       struct resource *mem_res;
> > +     /* bus scan delay for crash causing devices' workaround */
> > +     u32 bus_scan_delay_ms;
> >  };
> >
> >  static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
> > --
> > 2.29.2
> >
