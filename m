Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A084C7218
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 18:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiB1RD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 12:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiB1RD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 12:03:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00041CB0B;
        Mon, 28 Feb 2022 09:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4927D612F2;
        Mon, 28 Feb 2022 17:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55E0C340E7;
        Mon, 28 Feb 2022 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646067798;
        bh=W4TfgaMbzB/dbIXJ+mhv9//sCTurVx2rgNmiCaGsggY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jl+0Hznf8k7g6+rx19mhiijhFh41pTB8SWOK7Zk99uUHhtQuLfO4lmZC7yJZUZUMf
         36pIIJea3OxyWsvIgHnPEKrHy/DxJB8SNEccu7bZ0o72s+sK/Gc76Efl38ZoSRSogT
         fRMeGLdYJwQzwM/xdeDiwIb/WoWAS7xVpXvfKL63k215t8mgNciYmw+zL4ua9B1H/e
         JIiuMqwhCCP3wgXoGwrwEt+KuSXIaCAw79Bqw739EJAsAoUtbT96IjPX9fQNyXtoEp
         w42DyM9ABy/f3q8KsR5n/dJZVSrHFPhXGUOm7PEz3p47vzuGJUIKKXm7xM8HWBQQsx
         Cr2cm2XOJQD2w==
Received: by mail-ed1-f42.google.com with SMTP id s14so18583514edw.0;
        Mon, 28 Feb 2022 09:03:18 -0800 (PST)
X-Gm-Message-State: AOAM53328jSSXPqzLN9oOBka6oBHmajmcac5CQIMFMN4lZK62lQCLKfs
        dd/SWe9RE63aKlmXEzVoLbzGMMU2qYry05kHTQ==
X-Google-Smtp-Source: ABdhPJzZUYATENjJza9Xe14xwOlz85aDtvRJMe7hMmcZYSSl58Qus9RdYNE0HMiDZBUi9DSMMte/kCYmXNqip9EHHxI=
X-Received: by 2002:aa7:ce92:0:b0:40f:b89c:18fe with SMTP id
 y18-20020aa7ce92000000b0040fb89c18femr20552649edv.67.1646067796901; Mon, 28
 Feb 2022 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20220222155030.988-1-pali@kernel.org> <164554589988.5595.5091384618177225445.b4-ty@arm.com>
 <20220222161143.6ryghgtfmhnmhpmz@pali> <20220222161539.GA20114@lpieralisi>
 <20220222161854.7oot5v6xlw2wzmsc@pali> <87h78j0y5m.fsf@BL-laptop>
In-Reply-To: <87h78j0y5m.fsf@BL-laptop>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Feb 2022 11:03:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBCyrFpys9xx+TkD4GpW7MvxWr8rXzLARBJ4iOqY_u_g@mail.gmail.com>
Message-ID: <CAL_JsqJBCyrFpys9xx+TkD4GpW7MvxWr8rXzLARBJ4iOqY_u_g@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 10:11 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hello,
>
> > + Gregory
> >
> > On Tuesday 22 February 2022 16:15:39 Lorenzo Pieralisi wrote:
> >> On Tue, Feb 22, 2022 at 05:11:43PM +0100, Pali Roh=C3=A1r wrote:
> >> > On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
> >> > > On Tue, 22 Feb 2022 16:50:18 +0100, Pali Roh=C3=A1r wrote:
> >> > > > This patch series extends pci-bridge-emul.c driver to emulate PC=
I Subsystem
> >> > > > Vendor ID capability and PCIe extended capabilities. And then im=
plement
> >> > > > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe=
 AER
> >> > > > registers, support for legacy INTx interrupts, configuration for=
 X1/X4
> >> > > > mode and usage of new PCI child_ops API.
> >> > > >
> >> > > > Changes in v4:
> >> > > > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
> >> > > >
> >> > > > [...]
> >> > >
> >> > > I can't apply dts changes, patch 12 should go via the arm-soc tree=
.
> >> >
> >> > Gregory already wrote about this dts change:
> >> > https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
> >> > "So the easier is to let merge it through the PCI subsystem with the
> >> > other patches from this series."
> >> >
> >> > Are there any issues with applying this dts change via pci tree?
> >>
> >> I don't usually take dts changes through the PCI tree since they
> >> can conflict with arm-soc, that's the issue - dts changes should
> >> be managed by platform maintainers.
> >
> > Gregory, could you please take patch 12/12?
> > https://lore.kernel.org/linux-pci/20220222155030.988-13-pali@kernel.org=
/
> > You have already Acked-by (see above previous link)
>
>
> Applied on mvebu/dt
>
> let's hope the PCI branch will be merged before the ARM branch.

Why does that matter? AIUI, legacy interrupts didn't work before and
you need both dt and kernel to enable. Or am I misled by the commit
messages?

Rob
