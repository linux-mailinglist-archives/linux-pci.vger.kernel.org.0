Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1AA6FD340
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEJALr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 20:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJALr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 20:11:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA32D61;
        Tue,  9 May 2023 17:11:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so64031966a12.0;
        Tue, 09 May 2023 17:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683677503; x=1686269503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnZfBH4+e2aG6WyD+epIRlRbCTM2ae5x3KP3NU/zsH8=;
        b=qa1QAZpuJRX22Wmqd7/SOrbuP3EC0T33Rx282qiN3yDfvAawQN0HU5mjnMKzBsRPzR
         IsAE5C8YgbOxIzYleO6Zo09SeM4LYmKpASKa6AxqVfF9i+hxQZzUthlMZqLCV9ghjMLl
         wP+PG951ln1pfKY+JlzCDnfQCEm8RlAvBaopqd3Ue9ye01GVRoTA1BVahRw3ea9ni6yM
         xOx3NXRXPHDCtzoLrmSWj8WfhhP4Vk9/syO+AjYpUD36E1M+yy11014L0TkiVBmA59Jb
         vxN/YH1t6AhEIegeI1jVZiNSee6MuqReh4BFmH72XBRSbJkS/bIAQp1A4iM6hOfOz769
         pAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683677503; x=1686269503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnZfBH4+e2aG6WyD+epIRlRbCTM2ae5x3KP3NU/zsH8=;
        b=Gjh7jRmWQ6vudl5hOW/VdaAAE9YGaZRxSuCd7HMYu7h9SMTBi0x+NjzsTy7kG7gzBA
         1YFsqmbv//Q3E/99bVDzvyv3RJ6nXLzk0iFV1JIXjdzuttRW/RJ5w0+ZBjxvDAePTzL8
         jYmyvK1nZGtHcNdQd95bCGBrgHu/s6G/wMGl911ZPgrdeRn4n3PoC4aEi3okzWektTl5
         LLfUfyxdUNqzAdhCzo70EgOXCczDnxxG45LPnCl0AaJ6hCWtptdqaPkHwa7APBbd2W1u
         /KTmUaYjdqj9LDaF/Q4c/NZQbw2lKsKOgRpzGXek0QfL9sCtKE5TOeOzlxN34TR0jgSf
         ZMpQ==
X-Gm-Message-State: AC+VfDx5Jjg/legQ7DrJ5O9deIZbXgsOhTVIb0MaFStU9N5M4b3uPnef
        F6KMNimXKcaNfPf+b6IhrzQIo3GZq7L7bcT/MIc=
X-Google-Smtp-Source: ACHHUZ4LKCnpwtXIUWdZdv/WBqxjTJX73A2u7762COFMTWyJZARzrpjkFg+kJbVMwx6laMiUTbuQMztjzLvKXONXriI=
X-Received: by 2002:a17:907:3f9c:b0:966:1bf2:2af5 with SMTP id
 hr28-20020a1709073f9c00b009661bf22af5mr10982902ejc.22.1683677502942; Tue, 09
 May 2023 17:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com> <20230509211902.GA1270901@bhelgaas>
In-Reply-To: <20230509211902.GA1270901@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 9 May 2023 20:11:29 -0400
Message-ID: <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-pci@vger.kernel.org, robh@kernel.org, heiko@sntech.de,
        kw@linux.com, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 9, 2023 at 5:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> Hi Vincenzo,
>
> Thanks for raising this issue.  Let's see what we can do to address
> it.
>
> On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > Add a configurable delay to the Rockchip PCIe driver to address
> > crashes that occur on some old devices, such as the Pine64 RockPro64.
> >
> > This issue is affecting the ARM community, but there is no
> > upstream solution for it yet.
>
> It sounds like this happens with several endpoints, right?  And I
> assume the endpoints work fine in other non-Rockchip systems?  If
> that's the case, my guess is the problem is with the Rockchip host
> controller and how it's initialized, not with the endpoints.
>
> The only delays and timeouts I see in the driver now are in
> rockchip_pcie_host_init_port(), where it waits for link training to
> complete.  I assume the link training did completely successfully
> since you don't mention either a gen1 or gen2 timeout (although the
> gen2 message is a dev_dbg() that normally wouldn't go to the console).
>
> I don't know that the spec contains a retrain timeout value.  Several
> other drivers use 1 second, while rockchip uses 500ms (for example,
> see LINK_RETRAIN_TIMEOUT and LINK_UP_TIMEOUT).
>
> I think we need to understand the issue better before adding a DT
> property and a module parameter.  Those are hard for users to deal
> with.  If we can figure out a value that works for everybody, it would
> be better to just hard-code it in the driver and use that all the
> time.

Good Evening,

The main issue with the rk3399 is the PCIe controller is buggy and
triggers a SoC panic when certain error conditions occur that should
be handled gracefully. One of those conditions is when an endpoint
requests an access to wait and retry later. Many years ago we ran that
issue to ground and with Robin Murphy's help we found that while it's
possible to gracefully handle that condition it required hijacking the
entire arm64 error handling routine. Not exactly scalable for just one
SoC. The configurable waits allow us to program reasonable times for
90% of the endpoints that come up in the normal amount of time, while
being able to adjust it for the other 10% that do not. Some require
multiple seconds before they return without error. Part of the reason
we don't want to hardcode the wait time is because the probe isn't
handled asynchronously, so the kernel appears to hang while waiting
for the timeout.

I'm curious if it's been tested with this series on top:
https://lore.kernel.org/linux-arm-kernel/20230418074700.1083505-8-rick.wert=
enbroek@gmail.com/T/
I'm particularly curious if
[v5,04/11] PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be l=
ocked
makes a difference in the behavior. Please test this and see if it
improves the timeouts you need for the endpoints you're testing
against.

Very Respectfully,
Peter Geis

>
> A few minor style/formatting comments below just for future reference:
>
> > Crash dump (customized Manjaro kernel before this patch):
> > [    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
> > [    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJ=
ARO-ARM #1
> > [    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
> > [    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=3D--)
> > [    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
> > [    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
> > [    1.229870] sp : ffff80001004b850
> > [    1.229872] x29: ffff80001004b850 x28: 0000000000000001
> > [    1.229877] x27: 0000000000000000 x26: ffff00007a795000
> > [    1.229882] x25: ffff00007a7910b0 x24: 0000000000000000
> > [    1.229887] x23: 0000000000000000 x22: ffff00007b3a4380
> > [    1.229891] x21: ffff80001004b8c4 x20: 0000000000000004
> > [    1.229895] x19: 0000000000100000 x18: 0000000000000020
> > [    1.229900] x17: 0000000000000001 x16: 0000000000000019
> > [    1.229904] x15: ffff00007b222fd8 x14: ffffffffffffffff
> > [    1.229908] x13: ffff00007a79ba1c x12: ffff00007a79b290
> > [    1.229912] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> > [    1.229917] x9 : ff72646268756463 x8 : 0000000000000391
> > [    1.229921] x7 : ffff80001004b880 x6 : 0000000000000001
> > [    1.229925] x5 : 0000000000000000 x4 : 0000000000000000
> > [    1.229930] x3 : 0000000000c00008 x2 : 000000000080000a
> > [    1.229934] x1 : 0000000000000000 x0 : ffff800014000000
> > [    1.229939] Kernel panic - not syncing: Asynchronous SError Interrup=
t
> > [    1.229942] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJ=
ARO-ARM #1
> > [    1.229944] Hardware name: Pine64 RockPro64 v2.1 (DT)
> > [    1.229946] Call trace:
> > [    1.229948]  dump_backtrace+0x0/0x1d0
> > [    1.229949]  show_stack+0x18/0x24
> > [    1.229951]  dump_stack+0xc0/0x118
> > [    1.229953]  panic+0x148/0x320
> > [    1.229955]  nmi_panic+0x8c/0x90
> > [    1.229956]  arm64_serror_panic+0x78/0x84
> > [    1.229958]  do_serror+0x15c/0x160
> > [    1.229960]  el1_error+0x84/0x100
> > [    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
> > [    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
> > [    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
> > [    1.229968]  pci_scan_single_device+0xa4/0x144
> > [    1.229970]  pci_scan_slot+0x40/0x12c
> > [    1.229972]  pci_scan_child_bus_extend+0x58/0x34c
> > [    1.229974]  pci_scan_bridge_extend+0x310/0x590
> > [    1.229976]  pci_scan_child_bus_extend+0x210/0x34c
> > [    1.229978]  pci_scan_root_bus_bridge+0x68/0xdc
> > [    1.229980]  pci_host_probe+0x18/0xc4
> > [    1.229981]  rockchip_pcie_probe+0x204/0x330
>
> Include only the parts of the crash dump that are needed to debug the
> problem or identify the problem enough to find this patch.  Timestamps
> probably aren't necessary.  Register contents -- probably not either.
>
> The rest of the backtrace (below here) probably isn't useful.
>
> > [    1.229984]  platform_drv_probe+0x54/0xb0
> > [    1.229985]  really_probe+0xe8/0x500
> > [    1.229987]  driver_probe_device+0xd8/0xf0
> > [    1.229989]  device_driver_attach+0xc0/0xcc
> > [    1.229991]  __driver_attach+0xa4/0x170
> > [    1.229993]  bus_for_each_dev+0x70/0xc0
> > [    1.229994]  driver_attach+0x24/0x30
> > [    1.229996]  bus_add_driver+0x140/0x234
> > [    1.229998]  driver_register+0x78/0x130
> > [    1.230000]  __platform_driver_register+0x4c/0x60
> > [    1.230002]  rockchip_pcie_driver_init+0x1c/0x28
> > [    1.230004]  do_one_initcall+0x54/0x1c0
> > [    1.230005]  do_initcalls+0xf4/0x130
> > [    1.230007]  kernel_init_freeable+0x144/0x19c
> > [    1.230009]  kernel_init+0x14/0x11c
> > [    1.230011]  ret_from_fork+0x10/0x34
> > [    1.230035] SMP: stopping secondary CPUs
> > [    1.230037] Kernel Offset: disabled
> > [    1.230039] CPU features: 0x0240022,2100200c
> > [    1.230041] Memory Limit: none
>
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4286,6 +4286,14 @@
> >                               any pair of devices, possibly at the cost=
 of
> >                               reduced performance.  This also guarantee=
s
> >                               that hot-added devices will work.
> > +             pcie_rockchip_host.bus_scan_delay=3D      [PCIE] Delay in=
 ms before
> > +                     scanning PCIe bus in Rockchip PCIe host driver. S=
ome PCIe
> > +                     cards seem to need delays that can be several hun=
dred ms.
> > +                     If set to greater than or equal to 0 this paramet=
er will
> > +                     override delay that can be set in device tree.
> > +                     Values less than 0 the module will hit an asserti=
on
> > +                     during the init.
> > +                     The default value is 0.
>
> Generally speaking module-specific stuff like this doesn't get
> documented in kernel-parameters.txt.
>
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > @@ -663,7 +663,8 @@ &pcie0 {
> >       pinctrl-0 =3D <&pcie_perst>;
> >       vpcie12v-supply =3D <&vcc12v_dcin>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie>;
> > -     status =3D "okay";
> > +    bus-scan-delay-ms =3D <0>;
> > +    status =3D "okay";
>
> Please don't add arbitrary whitespace changes (it looks like this
> uses leading spaces instead of tabs).
>
> > +/* bus_scan_delay - module parameter to override the
> > + * device tree value, which is 0 by default. */
>
> Please follow comment style in the file, i.e.,
>
>   /*
>    * bus_scan_delay - ...
>    */
>
> Wrap comments to fill 78 columns or so to match the rest of the file.
>
> > @@ -987,6 +996,23 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
> >
> >       rockchip_pcie_enable_interrupts(rockchip);
> >
> > +     prob_delay =3D rockchip->bus_scan_delay;
> > +     if (bus_scan_delay)
> > +             prob_delay =3D bus_scan_delay;
> > +
> > +     /*
> > +      * FIXME: This is a workaround for some devices that crash on cal=
ls to pci_host_probe()
> > +      * or pci_scan_root_bus_bridge(). We add a delay before bus scann=
ing to avoid the crash.
> > +      * The call trace reaches rockchip_pcie_rd_conf() while attemptin=
g to read the vendor ID
> > +      * (pci_bus_generic_read_dev_vendor_id() is in the call stack) be=
fore panicking.
> > +      *
> > +      * I'm not sure why this workaround is effective or what causes t=
he panic. It may be related
> > +      * to the cansleep value.
>
> Wrap comments to fit in 78 columns to match the rest of the file.
>
> > +      */
> > +     dev_info(dev, "wait %u ms before bus scan\n", prob_delay);
> > +     if (prob_delay > 0)
> > +             msleep(prob_delay);
>
> I don't think we want to just add a random delay here that's not
> connected to anything else.  I assume it could go in
> rockchip_pcie_host_init_port() or perhaps rockchip_pcie_init_port()
> (which deasserts resets, and there are usually timing constraints
> related to deasserting resets).  Hopefully Shawn can shed some light
> on this.
>
> >       err =3D pci_host_probe(bridge);
> >       if (err < 0)
> >               goto err_remove_irq_domain;
> > @@ -1055,6 +1081,11 @@ static struct platform_driver rockchip_pcie_driv=
er =3D {
> >  };
> >  module_platform_driver(rockchip_pcie_driver);
> >
> > +/** Allow to override the device tree default configuration with
> > + * a command line argument.
> > + **/
>
> Use multi-line comment style that matches the rest of the file.
>
> > +module_param_named(bus_scan_delay, bus_scan_delay, int, S_IRUGO);
>
> This should go right next to the bus_scan_delay definition above.
>
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -149,6 +149,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *r=
ockchip)
> >               return PTR_ERR(rockchip->clk_pcie_pm);
> >       }
> >
> > +     err =3D of_property_read_u32(node, "bus-scan-delay-ms", &rockchip=
->bus_scan_delay);
> > +     if (err) {
> > +             dev_info(dev, "no bus scan delay, default to 0 ms\n");
> > +             rockchip->bus_scan_delay =3D 0;
>
> I hope we don't need this property at all, but if we do, I assume it
> should be optional, with no message needed if it's not present.
>
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -299,6 +299,16 @@ struct rockchip_pcie {
> >       phys_addr_t msg_bus_addr;
> >       bool is_rc;
> >       struct resource *mem_res;
> > +
> > +     /* It seems that the driver crashes on some
> > +      * older devices. To work around this, we
> > +      * should add a sleep delay before probing.
> > +      *
> > +      * FIXME: need more investigated with an,
> > +      * but looks like the problem can be related with
> > +      * the cansleep value?
> > +      **/
>
> We need better understanding of what's going on here.  Then this
> comment could be made more specific, shorter, and formatted like
> others.
>
> > +     u32 bus_scan_delay;
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
