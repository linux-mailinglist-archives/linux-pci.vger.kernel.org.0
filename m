Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648321153BD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLFO7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 09:59:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46820 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFO7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 09:59:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so7336454qtb.13;
        Fri, 06 Dec 2019 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8fmaKX3qHvgaU9HezXS0YoD8ShVlZeLnaKX27xB+76c=;
        b=Fx1yinbVPgLaovWFZKMHq/74oVe2/hpR00uJyXlQVPTn8MhxmMYt2Hfz1xQKsmQ/uu
         70La5eq7TTOT+TQKcQKtmjoGygAXhJ0SinH/mVwZcdul7Fu+mezwKXxQvgOWcY0kc8xH
         bK872+0pwLUjrFqCD32K78bYjq5qxb4GPgNEtTt8+/PU6LP3Ngx2C+CXtQPope1za84R
         G+sX42xmkg8po4myBHe8/gDiI/OK5ktrAG5iUJW9XmgVkRhjPXb+8f3aRS3PiyKehFAF
         UAPThjYfX8WBFDjPn92eU2JnIYe67nlVkJhHYGrxsXhxMt3sx5xcEGVKrcMijI4D57rE
         vAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8fmaKX3qHvgaU9HezXS0YoD8ShVlZeLnaKX27xB+76c=;
        b=GxWeYWwrC1HKZvzXiDYO7FsHp0TbHKVbuIub+RCTLkr/9KGWQB/aQGxNj8toOORPRJ
         l0voxDxX1FAyruUg92HjVh3IM6V9fOopbmbLJC9g6ng+AYIUkJTsAXNaTfVOLMAoeCf8
         9ayifhtWOXGP/hfnztmQHGvx+XEsGX3uKdeiI8zSTeSsfq64Gu00RZiT0K8aPafIGEVw
         EmsT6k7eCEcqYW5FFo5RKND4w92AHOCPHK2iICJqd5Aiy/WEXpOkF4sFZibD1/1VoMVg
         0Nx7Mh7SFQTzIYXp+26s0DETKkqndPPFRq5ftdFehUikr2CQrsCuIPZeDjP2PHjkgX/A
         8H6A==
X-Gm-Message-State: APjAAAVUCf1Nz1S2tmOaAMkwdRwWRR3kSIQNPr+IdP/Oo7JRkw+/598q
        TKvzvi54Ap3wA6l7WcGwV9KN0OV6PIVAZFUZ5vs=
X-Google-Smtp-Source: APXvYqwkOKv55v3UJNGkAWvm2nVP2q90URgqRpQ4AJ2EtSPZtmZtpb1tYZ+apo5Il29ZJnNeNG7eIHE4l0I3KkWIwHU=
X-Received: by 2002:ac8:499a:: with SMTP id f26mr3784127qtq.178.1575644380144;
 Fri, 06 Dec 2019 06:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20191028163256.8004-1-robh@kernel.org> <20191028163256.8004-11-robh@kernel.org>
 <CAFqH_51-BMWSGGBpoKxA3UK+yPHSpPgok5i=daSC0KS5oc5ueA@mail.gmail.com> <20191206140901.GB26562@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191206140901.GB26562@e121166-lin.cambridge.arm.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 6 Dec 2019 15:59:28 +0100
Message-ID: <CAFqH_52BiQJzNEzd_0pB3K+JmzVOVikYQo0xfiC0J-DwiXdtqw@mail.gmail.com>
Subject: Re: [PATCH v3 10/25] PCI: rockchip: Use pci_parse_request_of_pci_ranges()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-renesas-soc@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Missatge de Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> del dia dv.,
6 de des. 2019 a les 15:09:
>
> On Thu, Dec 05, 2019 at 06:56:01PM +0100, Enric Balletbo Serra wrote:
> > Hi Rob,
> >
> > Missatge de Rob Herring <robh@kernel.org> del dia dl., 28 d=E2=80=99oct=
. 2019
> > a les 17:38:
> > >
> > > Convert the Rockchip host bridge to use the common
> > > pci_parse_request_of_pci_ranges().
> > >
> > > There's no need to assign the resources to a temporary list first. Ju=
st
> > > use bridge->windows directly and remove all the temporary list handli=
ng.
> > >
> > > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: linux-rockchip@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> >
> > I just tested mainline on my Samsung Chromebook Plus, and since
> > yesterday I'm getting a "synchronous external abort" [1]. After a
> > bisection, I found that this patch triggers the issue (this patch was
> > merged yesterday)
>
> This patch standalone triggers a compilation error - so it does
> trigger a bisection but not the one you are enquiring about.
>

Right, I didn't run a "normal" bisection and is really annoying have
commits that break the build. I manually bisected
and fixed the build myself. Maybe I did something wrong but ...

> Can you try to bisect it again and report back please ?
>

Before those patches I don't see the error:

62240a88004b0205beb0c1faca1c875c392b53f0 PCI: rockchip: Drop storing
driver private outbound resource data
5c1306a0fde67e5a39bef79932a0cb5cec5fd629 PCI: rockchip: Use
pci_parse_request_of_pci_ranges()

After those patches I see:

[   15.362128] mwifiex_pcie 0000:01:00.0: enabling device (0000 -> 0002)
[   15.369655] mwifiex_pcie: PCI memory map Virt0: 00000000a573ad00
PCI memory map Virt2: 00000000783126c4
[   15.381466] Internal error: synchronous external abort: 96000210
[#1] PREEMPT SMP
[   15.389965] Modules linked in: mwifiex_pcie(+) mwifiex uvcvideo
cfg80211 atmel_mxt_ts videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 rockchipdrm videobuf2_common v$
deodev cdc_ether usbnet analogix_dp panfrost r8152 rfkill dw_mipi_dsi
dw_hdmi cros_ec_sensors industrialio_triggered_buffer crct10dif_ce
snd_soc_rk3399_gru_sound cec mc $
ctrl_regulator kfifo_buf snd_soc_da7219 gpu_sched snd_soc_max98357a
i2c_hid snd_soc_rt5514 snd_soc_rockchip_i2s cros_ec_sensors_core
sbs_battery pcie_rockchip_host snd_s$
c_rt5514_spi cros_usbpd_charger rockchip_saradc pwm_cros_ec
cros_ec_chardev cros_usbpd_logger phy_rockchip_pcie pwm_bl
snd_soc_rl6231 rockchip_thermal snd_soc_rockchip_p$
m ip_tables x_tables ipv6 nf_defrag_ipv6
[   15.461095] CPU: 2 PID: 269 Comm: systemd-udevd Not tainted 5.4.0+ #327
[   15.461097] Hardware name: Google Kevin (DT)
[   15.461101] pstate: 60000005 (nZCv daif -PAN -UAO)
[   15.461116] pc : mwifiex_register_dev+0x264/0x3f8 [mwifiex_pcie]
[   15.461121] lr : mwifiex_register_dev+0x150/0x3f8 [mwifiex_pcie]
[   15.461123] sp : ffff800012073860
[   15.461128] x29: ffff800012073860 x28: ffff8000100a2e28
[   15.509043] x27: ffff8000118b6210 x26: ffff800008f57458
[   15.515055] x25: ffff0000ecfda000 x24: 0000000000000001
[   15.521069] x23: ffff0000e9905080 x22: ffff800008f5d000
[   15.527082] x21: ffff0000eecea078 x20: ffff0000e9905080
[   15.533096] x19: ffff0000eecea000 x18: 0000000000000001
[   15.539108] x17: 0000000000000000 x16: 0000000000000000
[   15.545118] x15: ffffffffffffffff x14: ffff8000118998c8
[   15.551128] x13: ffff000000000000 x12: 0000000000000008
[   15.557138] x11: 0101010101010101 x10: ffff7f7fffff7fff
[   15.563148] x9 : 0000000000000000 x8 : ffff0000e3c24240
[   15.569159] x7 : 0000000000000000 x6 : ffff0000e3c24148
[   15.575169] x5 : ffff0000e3c24148 x4 : ffff0000e7975ec8
[   15.581178] x3 : 0000000000000001 x2 : 0000000000002b42
[   15.587188] x1 : ffff800012c00008 x0 : ffff0000e9905080
[   15.593200] Call trace:
[   15.595970]  mwifiex_register_dev+0x264/0x3f8 [mwifiex_pcie]
[   15.602398]  mwifiex_add_card+0x2f8/0x430 [mwifiex]
[   15.607920]  mwifiex_pcie_probe+0x98/0x148 [mwifiex_pcie]
[   15.614033]  local_pci_probe+0x3c/0xa0
[   15.618275]  pci_device_probe+0x110/0x1a8
[   15.622812]  really_probe+0xd4/0x308
[   15.626856]  driver_probe_device+0x54/0xe8
[   15.631491]  device_driver_attach+0x6c/0x78
[   15.636224]  __driver_attach+0x54/0xd0
[   15.640465]  bus_for_each_dev+0x70/0xc0
[   15.644804]  driver_attach+0x20/0x28
[   15.648847]  bus_add_driver+0x178/0x1d8
[   15.653186]  driver_register+0x60/0x110
[   15.657525]  __pci_register_driver+0x40/0x48
[   15.662359]  mwifiex_pcie_init+0x24/0x1000 [mwifiex_pcie]
[   15.668469]  do_one_initcall+0x74/0x1a8
[   15.672810]  do_init_module+0x50/0x208
[   15.677050]  load_module+0x1a78/0x1d18
[   15.681290]  __do_sys_finit_module+0xd0/0xe8
[   15.686120]  __arm64_sys_finit_module+0x1c/0x28
[   15.691247]  el0_svc_common.constprop.2+0x88/0x150
[   15.696668]  el0_svc_handler+0x20/0x80
[   15.700909]  el0_sync_handler+0x118/0x188
[   15.705444]  el0_sync+0x140/0x180
[   15.716955] Code: a8c67bfd d65f03c0 f942ac01 91002021 (b9400021)
[   15.731548] ---[ end trace 1488ca6d6b162849 ]---

Thanks,
 Enric

> Thanks,
> Lorenzo
>
> > I didn't look in detail yet, but if you have any idea of what could be
> > the problem, that would be great.
> >
> > Thanks,
> >  Enric
> >
> > [1] https://hastebin.com/adasegihiw.rb
> >
> > >  drivers/pci/controller/pcie-rockchip-host.c | 36 ++++---------------=
--
> > >  1 file changed, 7 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pc=
i/controller/pcie-rockchip-host.c
> > > index ef8e677ce9d1..8d2e6f2e141e 100644
> > > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > > @@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_=
device *pdev)
> > >         struct device *dev =3D &pdev->dev;
> > >         struct pci_bus *bus, *child;
> > >         struct pci_host_bridge *bridge;
> > > +       struct resource *bus_res;
> > >         struct resource_entry *win;
> > > -       resource_size_t io_base;
> > > -       struct resource *mem;
> > > -       struct resource *io;
> > >         int err;
> > >
> > > -       LIST_HEAD(res);
> > > -
> > >         if (!dev->of_node)
> > >                 return -ENODEV;
> > >
> > > @@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_=
device *pdev)
> > >         if (err < 0)
> > >                 goto err_deinit_port;
> > >
> > > -       err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > > -                                                   &res, &io_base);
> > > +       err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows=
, &bus_res);
> > >         if (err)
> > >                 goto err_remove_irq_domain;
> > >
> > > -       err =3D devm_request_pci_bus_resources(dev, &res);
> > > -       if (err)
> > > -               goto err_free_res;
> > > +       rockchip->root_bus_nr =3D bus_res->start;
> > >
> > >         /* Get the I/O and memory ranges from DT */
> > > -       resource_list_for_each_entry(win, &res) {
> > > +       resource_list_for_each_entry(win, &bridge->windows) {
> > >                 switch (resource_type(win->res)) {
> > >                 case IORESOURCE_IO:
> > >                         io =3D win->res;
> > >                         io->name =3D "I/O";
> > >                         rockchip->io_size =3D resource_size(io);
> > >                         rockchip->io_bus_addr =3D io->start - win->of=
fset;
> > > -                       err =3D pci_remap_iospace(io, io_base);
> > > -                       if (err) {
> > > -                               dev_warn(dev, "error %d: failed to ma=
p resource %pR\n",
> > > -                                        err, io);
> > > -                               continue;
> > > -                       }
> > >                         rockchip->io =3D io;
> > >                         break;
> > >                 case IORESOURCE_MEM:
> > > @@ -1026,9 +1013,6 @@ static int rockchip_pcie_probe(struct platform_=
device *pdev)
> > >                         rockchip->mem_size =3D resource_size(mem);
> > >                         rockchip->mem_bus_addr =3D mem->start - win->=
offset;
> > >                         break;
> > > -               case IORESOURCE_BUS:
> > > -                       rockchip->root_bus_nr =3D win->res->start;
> > > -                       break;
> > >                 default:
> > >                         continue;
> > >                 }
> > > @@ -1036,15 +1020,14 @@ static int rockchip_pcie_probe(struct platfor=
m_device *pdev)
> > >
> > >         err =3D rockchip_pcie_cfg_atu(rockchip);
> > >         if (err)
> > > -               goto err_unmap_iospace;
> > > +               goto err_remove_irq_domain;
> > >
> > >         rockchip->msg_region =3D devm_ioremap(dev, rockchip->msg_bus_=
addr, SZ_1M);
> > >         if (!rockchip->msg_region) {
> > >                 err =3D -ENOMEM;
> > > -               goto err_unmap_iospace;
> > > +               goto err_remove_irq_domain;
> > >         }
> > >
> > > -       list_splice_init(&res, &bridge->windows);
> > >         bridge->dev.parent =3D dev;
> > >         bridge->sysdata =3D rockchip;
> > >         bridge->busnr =3D 0;
> > > @@ -1054,7 +1037,7 @@ static int rockchip_pcie_probe(struct platform_=
device *pdev)
> > >
> > >         err =3D pci_scan_root_bus_bridge(bridge);
> > >         if (err < 0)
> > > -               goto err_unmap_iospace;
> > > +               goto err_remove_irq_domain;
> > >
> > >         bus =3D bridge->bus;
> > >
> > > @@ -1068,10 +1051,6 @@ static int rockchip_pcie_probe(struct platform=
_device *pdev)
> > >         pci_bus_add_devices(bus);
> > >         return 0;
> > >
> > > -err_unmap_iospace:
> > > -       pci_unmap_iospace(rockchip->io);
> > > -err_free_res:
> > > -       pci_free_resource_list(&res);
> > >  err_remove_irq_domain:
> > >         irq_domain_remove(rockchip->irq_domain);
> > >  err_deinit_port:
> > > @@ -1097,7 +1076,6 @@ static int rockchip_pcie_remove(struct platform=
_device *pdev)
> > >
> > >         pci_stop_root_bus(rockchip->root_bus);
> > >         pci_remove_root_bus(rockchip->root_bus);
> > > -       pci_unmap_iospace(rockchip->io);
> > >         irq_domain_remove(rockchip->irq_domain);
> > >
> > >         rockchip_pcie_deinit_phys(rockchip);
> > > --
> > > 2.20.1
> > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
