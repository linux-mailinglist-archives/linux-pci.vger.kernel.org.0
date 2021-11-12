Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAE44EBF3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhKLR1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 12:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235458AbhKLR1y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 12:27:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E51F560FE3;
        Fri, 12 Nov 2021 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636737902;
        bh=SoXgrHClC00+SbuZ7huPC/6CYTPZ/iRLlOyzpg2cyIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nnh7Jaq9sGLzhdBpmd9emvUxgXc2d/crA9SGXwx5KmukEGlmtnGW+8quYpaYRv4sg
         vcnYOFdM+UTaLHcV0dMX1ZLs9atfIaGeNYEbtuKKsmDVcMi4kTSW3yEStiBWlLnXjS
         W87z/PpsfapyOUcE5HXF2h0BqRi7+HmLNVp08cKTYF3YmlJ65acUc1507XQeWjXFTu
         04u0k3+ZaHvFaFLfkdb/TL/i65+1ixqaDM5YBT3VPnm0JaMaioK7fbcxRCY6ptkUpA
         3oBwVppZOOnda4VPEu37HrN7/WcaRrh1/cDQV9V+6atnbd3Nm6fZbMAIpZ5G0kjXfx
         xWggYY83qm3Dw==
Date:   Fri, 12 Nov 2021 18:24:58 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20211112182458.51745d4d@thinkpad>
In-Reply-To: <20211112171249.46xmj5zo3svm4qn2@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
        <YY6HYM4T+A+tm85P@robh.at.kernel.org>
        <20211112153208.s4nuckz7js4fipce@pali>
        <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
        <20211112171249.46xmj5zo3svm4qn2@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 12 Nov 2021 18:12:49 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Friday 12 November 2021 10:30:01 Rob Herring wrote:
> > On Fri, Nov 12, 2021 at 9:32 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
: =20
> > >
> > > On Friday 12 November 2021 09:25:20 Rob Herring wrote: =20
> > > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote: =
=20
> > > > > +   If present, this property specifies slot power limit in milli=
watts. Host
> > > > > +   drivers can parse this property and use it for programming Ro=
ot Port or host
> > > > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limi=
t messages
> > > > > +   through the Root Port or host bridge when transitioning PCIe =
link from a
> > > > > +   non-DL_Up Status to a DL_Up Status. =20
> > > >
> > > > If your slots are behind a switch, then doesn't this apply to any b=
ridge
> > > > port? =20
> > >
> > > The main issue here is that pci.txt (and also scheme on github) is
> > > mixing host bridge and root ports into one node. This new property
> > > should be defined at the same place where is supports-clkreq or
> > > reset-gpios, as it belongs to them. =20
> >=20
> > Unfortunately that ship has already sailed. So we can split things up,
> > but we still have to allow for the existing cases. I'm happy to take
> > changes splitting up pci-bus.yaml to 2 or 3 schemas (host bridge,
> > root-port, and PCI(e)-PCI(e) bridge?). =20
>=20
> Well, no problem. I just need to know how you want to handle backward
> compatibility definitions in YAML. Because it is possible via versioning
> (like in JSONSchema-like structures in OpenAPI versioning) or via
> deprecated attributes or via defining two schemas (one strict and one
> loose)... There are lot of options and I saw all these options in
> different projects which use YAML or JSON.
>=20
> I did not know about github repository, I always looked at schemas and
> definitions only in linux kernel tree and external files which were
> mentioned in kernel tree.
>=20
> Something I wrote in my RFC email, but I wrote this email patch...
> https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/

New kernel should always work with old device-tree. But does also new
device-tree need to work with old kernels?

Marek
