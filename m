Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B860077E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJQHQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 03:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQHQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 03:16:50 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E8DFE1;
        Mon, 17 Oct 2022 00:16:48 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3476AFF80C;
        Mon, 17 Oct 2022 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665991007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0nk7kpBU9Ge0Ax0EsSJwP9PLjOsDnBYJ9iK2UXCG+U=;
        b=bs1LNpWTaKNNDL9DTKUCYbVf4CngVvnJmNulOHIMEY8b5QAOhngpae06hIGw1INcP0HzpY
        pz/jgPDzseZuI9Mh/TVyTYuhvwr6iJeIaew63IfYMwtuAdj9J24WbKFlDZBJNJC49BLp9Z
        NUTdOh+4KSB0bWPe3YQL/7B+6Lszg3GDIhyZfCiQ56L3kYJnZhlrF6SCnXQo5yx5QTOxhR
        c7TzhOhpSBst1/+QGqls6knN68J5N3KtPBgf0gRseYVvHaDedvvJZRNCupY3sTqYiwo8xt
        sSNn9Gs56sPf1PrK6sIj8pC3HqvQdh1KIkJhK8SEdL6BRbXh8jvFYkNLmbj9cQ==
Date:   Mon, 17 Oct 2022 09:18:20 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Message-ID: <20221017091820.07144242@fixe.home>
In-Reply-To: <fbfb817c-6f09-32d0-fafc-7d37618e2886@gmail.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
        <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
        <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
        <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
        <20221010104210.68edf825@fixe.home>
        <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
        <20221013100245.14c509ec@fixe.home>
        <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
        <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
        <fbfb817c-6f09-32d0-fafc-7d37618e2886@gmail.com>
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

Le Fri, 14 Oct 2022 13:52:50 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 10/14/22 12:33, Rob Herring wrote:
> > On Thu, Oct 13, 2022 at 12:28 PM Frank Rowand <frowand.list@gmail.com> =
wrote: =20
> >>
> >> On 10/13/22 03:02, Cl=C3=A9ment L=C3=A9ger wrote: =20
> >>> Le Thu, 13 Oct 2022 01:05:26 -0500,
> >>> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >>> =20
> >>>>> This would also require two different descriptions of the same card
> >>>>> (for ACPI and device-tree) and would require the final user to crea=
te a
> >>>>> specific overlay for its device based on the PCI slots the card is
> >>>>> plugged in. =20
> >>>>
> >>>> One of the many missing pieces of overlay support.  There have been =
several
> >>>> discussion of how to describe a "socket" in a device tree that a dev=
ice
> >>>> could be plugged into, where a single device tree subtree .dtb could=
 be
> >>>> relocated to one or more different socket locations.  Thus in this
> >>>> case a single overlay could be relocated to various PCI slots.
> >>>>
> >>>> I don't expect be getting involved in any future efforts around sock=
ets
> >>>> (see my following comment for why).
> >>>> =20
> >>>>>
> >>>>> The solution we proposed (Lizhi and I) allows to overcome these
> >>>>> problems and is way easier to use. Fixing the potential bugs that m=
ight
> >>>>> exists in the overlay layer seems a way better idea that just pushi=
ng =20
> >>>>
> >>>> It is not potential bugs.  The current run time overlay implementati=
on is
> >>>> proof of concept quality and completeness.  It is not production rea=
dy.
> >>>>
> >>>> I got an opportunity for early retirement a couple of weeks ago.  My=
 first
> >>>> inclination was to continue the same level of device tree maintainer=
ship,
> >>>> but I am quickly realizing that there are other activities that I wo=
uld
> >>>> like to devote my time and energy to.  I will continue to support Ro=
b with
> >>>> minor patch reviews and testing, and potentially finishing up some
> >>>> improvements to unittest.  On the other hand, bringing run time over=
lay
> >>>> support to product quality would be a major investment of my time th=
at I
> >>>> am not willing to continue. =20
> >>>
> >>> Hi Frank,
> >>>
> >>> This explains your position on the overlay support and I can
> >>> certainly understand it ! Regarding the fact that it would enter =20
> >>
> >> No, my position on the technical aspects of overlay support is totally
> >> unchanged.
> >>
> >> The only thing that has changed is that my time will not be available =
to
> >> assist in future overlay related work.  The burden for this will fall
> >> more on Rob than it has in the past. =20
> >=20
> > s/Rob/someone that steps up to maintain the overlay code/
> >  =20
> >>> "production", the devices we are talking about are not really
> >>> widespread yet? This would be a good opportunity to gather feedback
> >>> early and improve the support gradually. We could probably even be ab=
le
> >>> to support improvements in the overlay code if needed I guess. =20
> >>
> >> That is avoiding my point about the current implementation being
> >> proof of concept. =20
> >  =20
>=20
>=20
> > I think it would be better to talk in terms of under what conditions
> > the overlay support is adequate (for production) rather than a blanket
> > statement that it is not-production ready.  =20
>=20
> I sort of agree.  Use of run time overlays has been narrowly supported
> for use by a limited set of very cautious developers in a very constrained
> usage.

As a first working point, could we potentially restrict drivers to only
insert an overlay but not remove it ? It would be quite limited, but
as you pointed out, the multiple load/unload (or FPGA reconfiguration)
will only happen during development. Under "normal" condition, we could
expect the FPGA to be configured once during the system runtime. The
same goes for our PCI card which uses an existing SoC, we can probably
assume that it is going to be plugged once for all during the system
runtime.

This would limit the problems that might happen due to dynamic
insertion/removal of the overlay.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
