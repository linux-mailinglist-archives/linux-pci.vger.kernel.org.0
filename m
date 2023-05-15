Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE3703EE2
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjEOUwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbjEOUwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 16:52:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4164A5E9;
        Mon, 15 May 2023 13:52:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965d2749e2eso2010026266b.1;
        Mon, 15 May 2023 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684183948; x=1686775948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/2uUKqg/Ab7BmGViY4uFNbKZ61QIe3EzqjsTUTm1Z8=;
        b=V/2yfYMNotTUH5sWqlZZYGANTIWGAy2JE8hvjMGxZglBgjlScTYvPicblpEntPXHPT
         wNc7Nx/p6BG7OyHikNoPvkPV52u5HbAIEvoIMOBFIJ0ea8O8rkTyexKTmBfclnpHVwyO
         Ww0MMeqR1n4GfDGQCAkctMo3xTdCid+FK+pH6y6O28FTJIBNWgPdpNtUw2vwjPxdL934
         9CjsvLQRCg+KHKd0fDR/IvsK54JPe9LCl7t/d5BkBOdUic1gIhJBahqpi6ZDydnVgMQi
         MO/AjjKC1rAUFR+sI6YdX3/R8m347DCknc20SW/4gY+SiMMhMuQQ56FMFk5pz+H5B/Uc
         esSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684183948; x=1686775948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/2uUKqg/Ab7BmGViY4uFNbKZ61QIe3EzqjsTUTm1Z8=;
        b=E/lsS+aOfYlHE+YMFha3ZPG8L2S0JR5cARujSIiJNgNEnwJv9RFKi58+xz6CCs3am5
         eI3Il4VmOXEAEByRwMua/7NLqHS3tDi31RFbJdyp0PADE77IvbpPcM9wzEjFejWl08NG
         wzLIb7uMCvvWYf2tW6+zLzPdJawtOknPsojBhYt0uGAUbhwk+/xh3S3YT6BrQSyv+fmv
         tyJrAUF0VvVPuxWkMtlWJ5roHzu1PGyt3XZCRkfJ3YEvpcPuXpw8jQ5dEu+I8EMycLjT
         73vPoqKfTR7+TplLtGLwtw5iAX7DI7+pxH2oJvSqT5a8LYXw7teed3fBwDQgo9Dh5na+
         F8tg==
X-Gm-Message-State: AC+VfDw+lzKlN4TLoWbiluAMjddB8CG1dCIpYnq3+12aPaisaaB9AZv+
        95374OoBIVW4FIHL54Gy1w2CG/hE+tfEdsR4AYFi/yBEYh8=
X-Google-Smtp-Source: ACHHUZ6RO+g+onx2wiXt9im45PpNoTTLqVha9ZLhkMKcmXatlco2sUSvPD4Ho5HdVHM8xwLpyJVbKC0fWf36YYnQkFI=
X-Received: by 2002:a17:907:8690:b0:96a:3119:ac0 with SMTP id
 qa16-20020a170907869000b0096a31190ac0mr17725693ejc.69.1684183947424; Mon, 15
 May 2023 13:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
 <ZGJjHnHNJPqvuqVC@bhelgaas>
In-Reply-To: <ZGJjHnHNJPqvuqVC@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 15 May 2023 16:52:14 -0400
Message-ID: <CAMdYzYqzHFo+223gfE4T2XGqGUPT6Zy=4AkadgpG=o_KN3MvXQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     robh@kernel.org, heiko@sntech.de, Will Deacon <will@kernel.org>,
        kw@linux.com, linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, bhelgaas@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 12:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Sat, May 13, 2023 at 07:40:12AM -0400, Peter Geis wrote:
> > On Fri, May 12, 2023 at 9:24=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > [+cc ARM64 folks, in case you have abort handling tips; thread at:
> > > https://lore.kernel.org/r/20230509153912.515218-1-vincenzopalazzodev@=
gmail.com]
> > >
> > > Pine64 RockPro64 panics while enumerating some PCIe devices.  Adding =
a
> > > delay avoids the panic.  My theory is a PCIe Request Retry Status to =
a
> > > Vendor ID config read causes an abort that we don't handle.
> > >
> > > > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > > >> ...
> > > >> [    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
> > > >> [    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0=
-MANJARO-ARM
> > > >> #1
> > > >> [    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
> > > >> [    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=3D--)
> > > >> [    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
> > > >> [    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
> > > >> ...
> > > >> [    1.229939] Kernel panic - not syncing: Asynchronous SError Int=
errupt
> > > >> ...
> > > >> [    1.229955]  nmi_panic+0x8c/0x90
> > > >> [    1.229956]  arm64_serror_panic+0x78/0x84
> > > >> [    1.229958]  do_serror+0x15c/0x160
> > > >> [    1.229960]  el1_error+0x84/0x100
> > > >> [    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
> > > >> [    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
> > > >> [    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
> > > >> [    1.229968]  pci_scan_single_device+0xa4/0x144
> > >
> > > On Fri, May 12, 2023 at 12:46:21PM +0200, Vincenzo Palazzo wrote:
> > > > ... Is there any way to tell the kernel "hey we need some more time
> > > > here"?
> > >
> > > We enumerate PCI devices by trying to read the Vendor ID of every
> > > possible device address (see pci_scan_slot()).  On PCIe, if a device
> > > doesn't exist at that address, the Vendor ID config read will be
> > > terminated with Unsupported Request (UR) status.  This is normal
> > > and happens every time we enumerate devices.
> > >
> > > The crash doesn't happen every time we enumerate, so I don't think
> > > this UR is the problem.  Also, if it *were* the problem, adding a
> > > delay would not make any difference.
> >
> > Is this behavior different if there is a switch device forwarding on
> > the UR? On rk3399 switches are completely non-functional because of
> > the panic, which is observed in the output of the dmesg in [2] with
> > the hack patch enabled. Considering what you just described it looks
> > like the forwarded UR for each non-existent device behind the switch
> > is causing an serror.
>
> I don't know exactly what the panic looks like, but I wouldn't expect
> UR handling to be different when there's a switch.
>
> pcie-rockchip-host.c does handle devices on the root bus (00)
> differently than others because rockchip_pcie_valid_device() knows
> that device 00:00 is the only device on the root bus.  That part makes
> sense because 00:00 is built into the SoC.
>
> I'm a little suspicious of the fact that rockchip_pcie_valid_device()
> also enforces that bus 01 can only have a single device on it.  No
> other *_pcie_valid_device() implementations enforce that.  It's true
> that traditional PCIe devices can only implement device 00, but ARI
> relaxes that by reusing the Device Number as extended Function Number
> bits.

Bjorn, great catch, thank you!

I suspect you're actually onto the core of the problem. Looking
through various other drivers that implement _pcie_valid_device they
all appear to file similar restrictions on scanning for devices. The
drivers are all similar enough that I am starting to suspect they are
all running some version of the same bugged IP. Then I came across
advk_pcie_pio_is_running() in pci-aardvark.c, which describes our
issue pretty spot on including the same exact SError. Interestingly
enough they made a TF-A patch [3] to catch and handle the error
without ever passing it to the kernel. Other limitations they added
are ensuring reads are not attempted while the link is down.
pci-aardvark.c also implements limitations on Completion Retry Status.
It has given me ideas for solving the problem.

Very Respectfully,
Peter Geis

[3] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=
=3D3c7dcdac5c50

>
> > > There *is* a way for a PCIe device to say "I need more time".  It doe=
s
> > > this by responding to that Vendor ID config read with Request Retry
> > > Status (RRS, aka CRS in older specs), which means "I'm not ready yet,
> > > but I will be ready in the future."  Adding a delay would definitely
> > > make a difference here, so my guess is this is what's happening.
> > >
> > > Most root complexes return ~0 data to the CPU when a config read
> > > terminates with UR or RRS.  It sounds like rockchip does this for UR
> > > but possibly not for RRS.
> > >
> > > There is a "RRS Software Visibility" feature, which is supposed to
> > > turn the RRS into a special value (Vendor ID =3D=3D 0x0001), but per =
[1],
> > > rockchip doesn't support it (lspci calls it "CRSVisible").
> > >
> > > But the CPU load instruction corresponding to the config read has to
> > > complete by reading *something* or else be aborted.  It sounds like
> > > it's aborted in this case.  I don't know the arm64 details, but if we
> > > could catch that abort and determine that it was an RRS and not a UR,
> > > maybe we could fabricate the magic RRS 0x0001 value.
> > >
> > > imx6q_pcie_abort_handler() does something like that, although I think
> > > it's for arm32, not arm64.  But obviously we already catch the abort
> > > enough to dump the register state and panic, so maybe there's a way t=
o
> > > extend that?
> >
> > Perhaps a hook mechanism that allows drivers to register with the
> > serror handler and offer to handle specific errors before the generic
> > code causes the system panic?
> >
> > Very Respectfully,
> > Peter Geis
> >
> > [2] https://lore.kernel.org/linux-pci/CAMdYzYqn3L7x-vc+_K6jG0EVTiPGbz8p=
Q-N1Q1mRbcVXE822Yg@mail.gmail.com/
> >
> > >
> > > Bjorn
> > >
> > > [1] https://lore.kernel.org/linux-pci/CAMdYzYpOFAVq30N+O2gOxXiRtpoHpa=
kFg3LKq3TEZq4S6Y0y0g@mail.gmail.com/
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
