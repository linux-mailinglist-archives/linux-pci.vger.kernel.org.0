Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54B5FD5D8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJMIB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJMIBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 04:01:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057CC7F262;
        Thu, 13 Oct 2022 01:01:22 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A1CCFF816;
        Thu, 13 Oct 2022 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665648078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6aR3+3rfdAF7vB9eEvTfewDxBVIcWtX5nWe2mtu88A=;
        b=J0cPL5LbOImtVP/oYDZgcufrAlVac8Bs1mjmDnKZeJjnf7SbXSwsGiefrNC49jgvPUnW0I
        QkQNlAvFvAXiQWJs9VZZ3v2OwTySwMOKU4P3DUAoUEwAIE0l1nXuVoQjE5WrqhPYRz2ywN
        uiLkxLR6SBWPWC6PCarWJ1pSplnMFZlxycFBrvXumOhH16xQ2TapWUrf0dQ4w8UmGoq9G/
        OrfIJRoUhT26PWi1mlxJKwgASyFkcY5abhoZmDq2UF34wUVJRfQT+AXKxbXBO+SJmhAeLQ
        jdFcCTGse7Ww7J9rBMqR4hBc2M/HTE5WYJpbQ493SXywr74MUHey0Z0+yadisA==
Date:   Thu, 13 Oct 2022 10:02:45 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Message-ID: <20221013100245.14c509ec@fixe.home>
In-Reply-To: <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
        <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
        <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
        <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
        <20221010104210.68edf825@fixe.home>
        <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Thu, 13 Oct 2022 01:05:26 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> > This would also require two different descriptions of the same card
> > (for ACPI and device-tree) and would require the final user to create a
> > specific overlay for its device based on the PCI slots the card is
> > plugged in. =20
>=20
> One of the many missing pieces of overlay support.  There have been sever=
al
> discussion of how to describe a "socket" in a device tree that a device
> could be plugged into, where a single device tree subtree .dtb could be
> relocated to one or more different socket locations.  Thus in this
> case a single overlay could be relocated to various PCI slots.
>=20
> I don't expect be getting involved in any future efforts around sockets
> (see my following comment for why).
>=20
> >=20
> > The solution we proposed (Lizhi and I) allows to overcome these
> > problems and is way easier to use. Fixing the potential bugs that might
> > exists in the overlay layer seems a way better idea that just pushing =
=20
>=20
> It is not potential bugs.  The current run time overlay implementation is
> proof of concept quality and completeness.  It is not production ready.
>=20
> I got an opportunity for early retirement a couple of weeks ago.  My first
> inclination was to continue the same level of device tree maintainership,
> but I am quickly realizing that there are other activities that I would
> like to devote my time and energy to.  I will continue to support Rob with
> minor patch reviews and testing, and potentially finishing up some
> improvements to unittest.  On the other hand, bringing run time overlay
> support to product quality would be a major investment of my time that I
> am not willing to continue.

Hi Frank,

This explains your position on the overlay support and I can
certainly understand it ! Regarding the fact that it would enter
"production", the devices we are talking about are not really
widespread yet? This would be a good opportunity to gather feedback
early and improve the support gradually. We could probably even be able
to support improvements in the overlay code if needed I guess.

Thanks for your honest answer,

Cl=C3=A9ment

>=20
> So I am leaving major overlay issues in the capable hands of Rob.  I may
> chime in from time to time when I can do so without requiring too much of
> my time.
>=20
> -Frank
>=20
> > that away to the bootloader level. Moreover, this kind of devices is
> > likely to be more common with the increasing popularity of FPGA and a
> > proper solution must be found.
> >  =20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
