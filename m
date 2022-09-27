Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6944E5EC4AE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiI0NkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiI0NkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 09:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62836B154
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 06:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5314F619A3
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 13:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8FC433D6;
        Tue, 27 Sep 2022 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664286008;
        bh=bHe7jqSdC6M9l75s9W0qT54/RGr69ijmKeccBsyU9Lk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d7KI9QJVRUTbcxl2kwBxegRL0PUDjIfPysbyPFBnPS4CkR6/6vAIQdaKcnEAPXsrM
         Wjbfq+SMhAxqAmwq1LcDO8G/wzDHDNoEpDoMLUo4p7F56F7zT8VZpBYcWUhfldUVth
         0EkJodrqlSX169VCruVQ7XYUq8O/0/lrqTSubcuomDdXetYD5eN7bOqjdRmiuakWmK
         pCPYARhnKqkE5U0n53aW+655dCupQ9OpdfxZVOQCdMaPC3NIvWYmww6N2Mp9eSVCcy
         xjbK4wlSCZQE3MeVfY6C5tt3Qo7OblLH2osDxTxNIBbbkgXxgZj6+DBuNiiuHtfauu
         Gc1kQ8Vl0TNPQ==
Date:   Tue, 27 Sep 2022 15:40:02 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <20220927153947.2df43936@dellmb>
In-Reply-To: <YzGwbWoFIpADgbXz@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
        <20220818135140.5996-4-kabel@kernel.org>
        <YxtUR0+dBZut8QZH@lpieralisi>
        <87r10al6a0.wl-maz@kernel.org>
        <YzGR40/kmQX4ZNaS@lpieralisi>
        <868rm68g9k.wl-maz@kernel.org>
        <YzGwbWoFIpADgbXz@lpieralisi>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Sep 2022 16:00:13 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On Mon, Sep 26, 2022 at 08:35:51AM -0400, Marc Zyngier wrote:
> > On Mon, 26 Sep 2022 07:49:55 -0400,
> > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote: =20
> > >=20
> > > On Sat, Sep 17, 2022 at 10:05:59AM +0100, Marc Zyngier wrote: =20
> > > > Hi Lorenzo,
> > > >=20
> > > > On Fri, 09 Sep 2022 15:57:11 +0100,
> > > > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote: =20
> > > > >=20
> > > > > [+Marc, Thomas - I can't merge this code without them reviewing i=
t,
> > > > > I am not sure at all you can mix the timer/IRQ code the way you d=
o]
> > > > >=20
> > > > > On Thu, Aug 18, 2022 at 03:51:32PM +0200, Marek Beh=C3=BAn wrote:=
 =20
> > > > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > >=20
> > > > > > Add support for Data Link Layer State Change in the emulated sl=
ot
> > > > > > registers and hotplug interrupt via the emulated root bridge.
> > > > > >=20
> > > > > > This is mainly useful for when an error causes link down event.=
 With
> > > > > > this change, drivers can try recovery.
> > > > > >=20
> > > > > > Link down state change can be implemented because Aardvark supp=
orts Link
> > > > > > Down event interrupt. Use it for signaling that Data Link Layer=
 Link is
> > > > > > not active anymore via Hot-Plug Interrupt on emulated root brid=
ge.
> > > > > >=20
> > > > > > Link up interrupt is not available on Aardvark, but we check fo=
r whether
> > > > > > link is up in the advk_pcie_link_up() function. By triggering H=
ot-Plug
> > > > > > Interrupt from this function we achieve Link up event, so long =
as the
> > > > > > function is called (which it is after probe and when rescanning=
).
> > > > > > Although it is not ideal, it is better than nothing. =20
> > > > >=20
> > > > > So before even coming to the code review: this patch does two thi=
ngs.
> > > > >=20
> > > > > 1) It adds support for handling the Link down state
> > > > > 2) It adds some code to emulate a Link-up event
> > > > >=20
> > > > > Now, for (2). IIUC you are adding code to make sure that an HP
> > > > > event is triggered if advk_pcie_link_up() is called and it
> > > > > detects a Link-down->Link-up transition, that has to be notified
> > > > > through an HP event.
> > > > >=20
> > > > > If that's correct, you have to explain to me please what this is
> > > > > actually achieving and a specific scenario where we want this to =
be
> > > > > implemented, in fine details; then we add it to the commit log.
> > > > >=20
> > > > > That aside, the interaction of the timer and the IRQ domain code
> > > > > must be reviewed by Marc and Thomas to make sure this is not
> > > > > a gross violation of the respective subsystems usage. =20
> > > >=20
> > > > I don't see anything being a "gross violation" here, at least from =
an
> > > > interrupt subsystem perspective. In a way, this is synthesising an
> > > > interrupt on the back of some other event, and as long as the conte=
xt
> > > > is somehow appropriate (something that looks like an interrupt when
> > > > pretending there is one), this should be OK. Other subsystems such =
as
> > > > i2c GPIO expanders do similar things. =20
> > >=20
> > > Right, thanks.
> > >  =20
> > > > The one thing I'm dubious about is the frequency of the timer. Aski=
ng
> > > > for a poll of the link every jiffy is bound to be expensive, and it
> > > > would be good to relax this as much as possible, specially on low-e=
nd
> > > > HW such as this, where every cycle counts. It is always going to be=
 a
> > > > "best effort" thing, and the commit message doesn't say what's the
> > > > actual grace period to handle this (the spec probably has one). =20
> > >=20
> > > AFAICS, the code does not poll the link. It sets a timer only if
> > > the link is checked (eg upon PCI bus forced rescan or config access)
> > > the link is up and it was down, to emulate a HP IRQ. =20
> >=20
> > I still find the timer frequency pretty high, but surely the authors
> > of the code have worked out that this wasn't a problem. =20
>=20
> Please correct me if I am wrong but with mod_timer() all they want to do
> is emulating/firing an (hotplug) IRQ as soon as possible - a one-off.
>=20
> It is not a periodic timer - at least that's what I understand from the
> code and that's the reason why such a short interval was chosen but
> it should not be me who comment on that :)

This is true, it is not a periodic timer. We are just using an IRQSAFE
timer to call generic_handle_domain_irq() from it's handler, because we
can't do it during the config space access.

Marek
