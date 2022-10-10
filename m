Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5405F9B7C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJJI5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJJI5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 04:57:34 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D066A53;
        Mon, 10 Oct 2022 01:57:29 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 88BF6240016;
        Mon, 10 Oct 2022 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665392247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IH3Uk2GfkbPihU2hvHcjAG3NBNjHwnM0BC6JQtLzRTQ=;
        b=AzLFfeEkvWe2UL5KNHiK+DNUBQisbdzmJr4PdECK/GiU0xv+Br6X2oO5Wab+Ki/Q+x81PB
        cL+vxSc1W6KyYipGRXPJPbG+styWdreqiui35F9S9B4/DUgTUh1BgZnwqV9H4AYpxAR7LM
        0tnP7bahbBlGh8Y/4sjP7mFBxDbxFWwxpPInw74Fr18yco32tYStDXq9wjDxRaYZasgW4a
        N625sL+9O31dkBow/DNIh5yoMECdTlmpXijOAgBkcPVfxsbY1n5lkRsrvhJJfIaDqa87Dv
        HAPflFJxyMgMX6sgPbs9o2HbLkcVuXZKrZfQfZNo+GZUIZFvQgwUmbNZbgmtQA==
Date:   Mon, 10 Oct 2022 10:58:58 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Sonal Santan <sonal.santan@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, max.zhen@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Message-ID: <20221010105858.140a8e98@fixe.home>
In-Reply-To: <7f2dc633-23a2-16dc-8a55-0611e2cd6b7c@amd.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
        <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
        <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
        <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
        <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
        <7f2dc633-23a2-16dc-8a55-0611e2cd6b7c@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Fri, 7 Oct 2022 15:45:17 -0700,
Sonal Santan <sonal.santan@amd.com> a =C3=A9crit :

> >> Bringing this thread back into focus. Any thoughts on how to move forw=
ard? =20
> >=20
> > Reviewers raise concerns/issues and the submitters work to address
> > them or explain why they aren't an issue. The submitter has to push
> > things forward. That's how the process works.
> >  =20

Up to now, there does not seems to be a better solution to this
problem in term of maintainability, reusability and ease of use.

Again, patching the pre-boot description (ACPI or DT) is not an option,
the user is entitled to plug the card in whatever PCI slot he wants.
This is either probbly not possible and ACPI based system and would
require a difficult setup to even try to achieve that. This would also
result in two different description to support the same device.

> We are working on updating the patch set to address the feedback. The=20
> design is still based on device tree overlay infrastructure.

Agreed, moreover saying that "the overlay support is fragile" seems to
be a shortcut to do nothing and move all the support outside of the
kernel. If buggy, then it would be better to fix this support (if there
are real problems encountered with it) or kill it by removing it
entirely if not usable (option 1 would of course be preferred).

>=20
> > As I noted, much of this is needed on a DT system with PCI device not
> > described in DT. So you could split out any ACPI system support to
> > avoid that concern for example. Enabling others to exercise these
> > patches may help too. Perhaps use QEMU to create some imaginary
> > device. =20
> To verify this patch set, in addition to a x86_64/ACPI based system, we=20
> also have an AARCH64/DT QEMU setup where we have attached a physical=20
> Alveo device. We haven't run into any ACPI or DTO issues so far.

I've been able to use the same patch set with a X86 QEMU system by
attaching my physical PCI card to it. No issues were encountered
(although the usage was rather limited). Gaining some users of this
support would allow to gather more feedback.

>=20
> Perhaps we can introduce this feature in a phased manner where we first=20
> enable DT based platforms and then enable ACPI based platforms?
>=20
> -Sonal
> >=20
> > Rob =20


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
