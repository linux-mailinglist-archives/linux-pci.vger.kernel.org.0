Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED08513002
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiD1Jtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345715AbiD1JS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:18:59 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31971260D;
        Thu, 28 Apr 2022 02:15:40 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6C0E160009;
        Thu, 28 Apr 2022 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651137339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=601hOmZZ+FfI38UJ5XOFnA3K1IMHPaxWsKoMipp8iH8=;
        b=jUV/lrLJBVuq9ZQB/l/IXNc1u5fLXgsjkw6We9t7h9ghH1hr1PsCYjQBV6r20yG2bjj2tq
        rnsm90AuBdguGeEa8kyjzPeATTX/s5WjE/XfmfnC6V3U3LZ9NF22tS+2t0kZO0S4oDHikc
        c53S2dnJu+pFxcjpRyvel9eIdhcsTnSBNPc8SmNVd1Oi4llQNTZe3T2dOIQ3/KKQRlyqzD
        FhdIVSsqZlSrXobw/rmBBlQiACrkNZhSaHMVVOpb3pHTbL6w5gj8a5RRdD3L201ipJ6lMV
        TD5CnoYmzt26cTgO9/1JQMtJUun2wUq85q5GL0zpISRS7PF9XoPbNM1th3LaJg==
Date:   Thu, 28 Apr 2022 11:15:35 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 4/8] soc: renesas: rzn1: Select PM and
 PM_GENERIC_DOMAINS configs
Message-ID: <20220428111535.51833857@bootlin.com>
In-Reply-To: <CAMuHMdWmcBXRxZ_SDLCnimh7GqzkR0_qz178s51EtXsMm39ddg@mail.gmail.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-5-herve.codina@bootlin.com>
        <CAMuHMdWmcBXRxZ_SDLCnimh7GqzkR0_qz178s51EtXsMm39ddg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Wed, 27 Apr 2022 16:58:07 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > PM and PM_GENERIC_DOMAINS configs are required for RZ/N1 SOCs.
> > Without these configs, the clocks used by the PCI bridge are not
> > enabled and so accessing the devices leads to a kernel crash:
> >   [    0.832958] Unhandled fault: external abort on non-linefetch (0x10=
08) at 0x90b5f848
> >
> > Select PM and PM_GENERIC_DOMAINS for ARCH_RZN1
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.19.
>=20

I plan to send a v4 of this series.

As this patch (4/8) and the following one (5/8) will be
queued for v5.19, I plan to remove them from the v4 version
of the series.

Is that ok for you or do you prefer to still have them
in v4 ?

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
