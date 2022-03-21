Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2307D4E30BF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 20:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbiCUTXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiCUTW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 15:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334D6AA6D;
        Mon, 21 Mar 2022 12:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF91F60C91;
        Mon, 21 Mar 2022 19:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F99C340E8;
        Mon, 21 Mar 2022 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890492;
        bh=Fg07E1B+nsftghGNWGuBfeakjKWAMFNi7EYoxjsXiNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXekeJILo+aRdOvYi7DHuRymio6aNm9ywlW40dyprZX/I1aWUr64uGBZ0jqwUnocE
         pnbdGJC4RHRP5mipOzbE9+kuJ+BPbkz9x3dW6liM4W31qQGYOGtZbAZYpYbs1vBJw8
         hdVjsMIFmRlEXL/9brbtdiMfQXR1Ap1Ip+wTsrukwXw3MFLXwHlE6wHMcVey/JWEmD
         HpAZ2sQ7TntMCnWQk/BxFopBRB9N3UV+A2B03Pm4lwu7/HCB6bjx7HqiX/kruGVntR
         JJyAvNp7C/VEJ2uLzuRxSzx1v7P1VMFtpBa7/DIhx6dpTTpev3cQxX97QtLGQT70v8
         38eYfmEkGXZAA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWNar-00G2wF-RJ; Mon, 21 Mar 2022 19:21:29 +0000
Date:   Mon, 21 Mar 2022 19:21:29 +0000
Message-ID: <87fsnbxgau.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRz?= =?UTF-8?B?a2k=?= 
        <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
In-Reply-To: <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
References: <20220321104843.949645-1-maz@kernel.org>
        <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
        <87h77rxnyl.wl-maz@kernel.org>
        <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: robh@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com, stgraber@ubuntu.com, dann.frazier@canonical.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Mar 2022 18:03:27 +0000,
Rob Herring <robh@kernel.org> wrote:
>=20
> On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Mon, 21 Mar 2022 15:17:34 +0000,
> > Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > For XGene-1, I'd still like to understand what the issue is. Reverting
> > > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > > dump of how the IB registers are initialized in both cases. I'm not
> > > saying changing 'dma-ranges' in the firmware is going to be required
> > > here. There's a couple of other ways we could fix that without a
> > > firmware change, but first I need to understand why it broke.
> >
> > Reverting 6dce5aa59e0b was enough for me, without changing anything
> > else.
>=20
> Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.
>=20
> Can you tell me what 'dma-ranges' contains on your system?

Each pcie node (all 5 of them) has:

dma-ranges =3D <0x42000000 0x80 0x00 0x80 0x00 0x00 0x80000000
              0x42000000 0x00 0x00 0x00 0x00 0x80 0x00>;

>=20
> > m400 probably uses an even older firmware (AFAIR, it was stuck
> > with an ancient version of u-boot that HP never updated, while Mustang
> > had a few updates). In any case, that DT cannot be changed.
>=20
> How is Dann changing it then? I assume he's not changing the firmware,
> but overriding it. That could be a possible solution.

I don't know about you, but changing DT is not an acceptable solution
for me. If I'm bisecting something and have to pick the right DT based
on the kernel revision I'm using, that's a huge regression. And I'm
not even mentioning the poor sod who simply updates their distro, only
to find that the box doesn't boot anymore thanks to a kernel upgrade.

We're not talking about a closed embedded device here, but a fully
functional desktop/server box that still run rings around your average
RPi.

> Do the DT's in the kernel tree correspond to anything anyone is using?
> I ask because at some point someone will need to address all the
> warnings they have or we should drop the dts files if they aren't
> close to reality. The same thing applies to Seattle BTW.

I'd be perfectly happy to see both of these go. The last time I used
the kernel DT on my Seattle was some time in 2015, at which point I
got a firmware correctly describing the SMMUs. Oh, and ACPI works just
fine on Seattle.

> > > P.S. We're carrying ACPI and DT support for these platforms. It seems
> > > the few users are using DT, so can we drop the ACPI support? Or do I
> > > need to break it first and wait a year? ;)
> >
> > I'm not sure people on the list are representative of all the users,
> > and I didn't realise the plan was "let's break everything we don't
> > like and see if someone wakes up" either. That definitely puts things
> > in a different perspective.
>=20
> I wasn't really suggesting breaking things on purpose. However, there
> is a cost to keeping code and it would be nice to know what's being
> used or not. The cost isn't *that* big, but it is not zero for what's
> not many users.
>=20
> At least for St=C3=A9phane, using ACPI didn't even work. I'm assuming the=
re
> is some version of h/w and f/w out there that did work with the ACPI
> support in the kernel? That may have never been seen by anyone but APM
> and Jon Masters (his Tested-by is on the patch from APM adding ACPI
> support). It's not hard to imagine there was a version of firmware
> just to shut Jon up.

Well, you can ask Jon. ACPI doesn't work on my box as it doesn't
(properly) describe a console, but my FW is rather old, as explained
in the release notes:

    Version 3.06.25 (10/17/2016)
    Mustang Tianocore (UEFI BIOS) Firmware Features:
     - TianoCore tag linaro-edk2-2014.07 with custom changes

Yes, 2014. Good vintage. But is that the latest and greatest? I have
no idea, and the APM website is long gone.

	M.

--=20
Without deviation from the norm, progress is not possible.
