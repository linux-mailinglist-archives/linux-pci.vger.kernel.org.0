Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE17485427
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiAEOOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:14:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33726 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiAEOOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 09:14:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E519CB81B47;
        Wed,  5 Jan 2022 14:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978AFC36AE0;
        Wed,  5 Jan 2022 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641392088;
        bh=GA7ovUxKYBchYJOH3FkaGA5P4F4/IBalqgPAq/ToXJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dvfg4TbOa7DVq8lUiXN9af+9Bm//8I2cOinTJXF5zqSU3x6DYU/+wYMBcNrbNI48M
         eaj0mXqJl6zc4FFd7pmptFA0ncqXJoaRK8cbXmCuTMMMyN4OeMOMdedXpo58K+L4js
         bXY/jqXOjl1U/Z3fj0siswj47uCgYLTR85zy7D7ubfeBJ7imdjWvJRMOsIL2OpuQd1
         hgZNhlIsL3anrYVNv9UHizdThOh5mg+tlwg9Fu53F3yY7uw2huhwwwF60euTUkxGfO
         DGWigpeThptgHDESg3yvi6c6m8Dazu1sw7x1rhArJjLX3hfjQktajQu1eMHSG3FYkg
         tcSOflg8ywv0Q==
Date:   Wed, 5 Jan 2022 15:14:44 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20220105151444.7b0b216e@thinkpad>
In-Reply-To: <YY6HYM4T+A+tm85P@robh.at.kernel.org>
References: <20211031150706.27873-1-kabel@kernel.org>
        <YY6HYM4T+A+tm85P@robh.at.kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 12 Nov 2021 09:25:20 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > This property specifies slot power limit in mW unit. It is a form-factor
> > and board specific value and must be initialized by hardware.
> >=20
> > Some PCIe controllers delegate this work to software to allow hardware
> > flexibility and therefore this property basically specifies what should
> > host bridge program into PCIe Slot Capabilities registers.
> >=20
> > The property needs to be specified in mW unit instead of the special fo=
rmat
> > defined by Slot Capabilities (which encodes scaling factor or different
> > unit). Host drivers should convert the value from mW to needed format.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentat=
ion/devicetree/bindings/pci/pci.txt
> > index 6a8f2874a24d..7296d599c5ac 100644
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -32,6 +32,12 @@ driver implementation may support the following prop=
erties:
> >     root port to downstream device and host bridge drivers can do progr=
amming
> >     which depends on CLKREQ signal existence. For example, programming =
root port
> >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ s=
ignal.
> > +- slot-power-limit-miliwatt: =20
>=20
> Typo.
>=20
> But we shouldn't be adding to pci.txt. This needs to go in the=20
> schema[1]. Patch to devicetree-spec list or GH PR is fine.

Hello Rob,

Pali's PR draft https://github.com/devicetree-org/dt-schema/pull/64
looks like it's going to take some time to work out.

In the meantime, is it possible to somehow get the
slot-power-limit-milliwatt property merged into pci.txt so that we can start
putting it into existing device-trees?

Or would it break dt_bindings_check if it isn't put into dt-schema's
pci-bus.yaml?

Or should we simply put it into current version of pci-bus.yaml and
work out the split proposed by Pali's PR afterwards?

Marek
