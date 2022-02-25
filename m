Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455924C4BF5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiBYRXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 12:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbiBYRW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 12:22:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDBDF5A;
        Fri, 25 Feb 2022 09:22:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FF661935;
        Fri, 25 Feb 2022 17:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3FAC340F2;
        Fri, 25 Feb 2022 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645809741;
        bh=zcn7N2F1dnEdumd5LpYs9Ka1QOBnAbXy0YD0PxiiAd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QneYLEGIUqbVUmMs5dZF9b2NxGoFQQuDCrTf8gx39yIIw74pYOVlmGAA+fGvfH8Sf
         yOByX4/aTwqtROJKniZLlVdXAtDFB29cF3T43G7l4Agu3cZNsQe8JKiQMO5CgLTLAy
         0ceGjMbAzU/5wVjfnHJMCSxZ/Hrd4BLeI9Yws+/aQkHqnIwRHgZEKKp7ohsqDDRUZh
         9t+q2y1cPdj4XOosxgBS9+OFN3XpcedMeUKqIWGayp/dQwidHgl0NkhR7mKEcPvx6K
         8h0dstzjYwhBFo14f1LWv/oSMpUPiWKimXTuCZ4oc+1GdNtW68qGO6ajm6u0zp6Eat
         VGRTZD+TIxr6A==
Date:   Fri, 25 Feb 2022 18:22:16 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5?= =?UTF-8?B?xYRza2k=?= 
        <kw@linux.com>, Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220225182216.2fcf5455@thinkpad>
In-Reply-To: <20220225153756.GA358517@bhelgaas>
References: <20220225122451.fa2fiyzohwme2d66@pali>
        <20220225153756.GA358517@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Feb 2022 09:37:56 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Feb 25, 2022 at 01:24:51PM +0100, Pali Roh=C3=A1r wrote:
> > On Thursday 24 February 2022 14:28:43 Bjorn Helgaas wrote: =20
> > > On Tue, Feb 22, 2022 at 05:31:54PM +0100, Pali Roh=C3=A1r wrote: =20
> > > > These macros allows to easily compose and extract Slot Power Limit =
and
> > > > Physical Slot Number values from Slot Capability Register.
> > > >
> > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > ---
> > > >  include/uapi/linux/pci_regs.h | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci=
_regs.h
> > > > index 108f8523fa04..3fc9a4cac630 100644
> > > > --- a/include/uapi/linux/pci_regs.h
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -591,10 +591,13 @@
> > > >  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
> > > >  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
> > > >  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value =
*/
> > > > +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value sh=
ift */ =20
> > >=20
> > > Is there a way to use FIELD_PREP() and FIELD_GET() instead?  It seems
> > > like that's what the cool kids are doing now. =20
> >=20
> > This is possible too.
> >=20
> > I have proposed a patch with _SHIFT macros as this is the way how are
> > other macros in this file defined and used. =20
>=20
> Yes, it's a mix.  For some recent additions, I've resisted adding the
> _SHIFT macros on the theory that they clutter the file, they never
> change, and the main point of the #defines is readability and so
> grep/tags/etc can find things.
>=20
> There are a *few* users of FIELD_PREP() and FIELD_GET():
>=20
>   git grep -E "FIELD_(GET|PREP)\(PCI_EXP"
>=20
> and I'm inclined to go that direction in the future.  What do you
> think?

I am also pro that direction.

Would you also like to convert current usages in the .c driver files?

We can't remove the existing macros since they are in UAPI, but we can
convert drivers so that they don't use _SHIFT macros.

Marek
