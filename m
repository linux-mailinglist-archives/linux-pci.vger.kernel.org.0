Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1314A512FD1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiD1Jtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbiD1JXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:23:11 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C06D845;
        Thu, 28 Apr 2022 02:19:56 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 28371240004;
        Thu, 28 Apr 2022 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651137595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df+wN7i7GXTPAPUWzT4clFhqc7n0VuULVgdHkDDeB+8=;
        b=YFphup6tz6V2InfqjN1G/PcTMyqpiio3QC0ISmM+g6/eHuM9Q0Pg7r/SBrF1g9dbC5Yccf
        WIeKDje/t3UTfovBAVa3E6fkmolLGJoqKajAjkpTne6eWKh/LWWxZ08rA3OVPSOVaPAp/h
        twpPGuKsIJXWieaSzrW2WEet+NAw0lS7vv4R8PPhCWXOV3YABWRe9H3Mef+wVgVhZZ2EPa
        pJ69lzhRba7mlqu1JkVvtgvvsTaXQSPJT4VK3e2pHxHsFUT9kjFL05aRtLF/IzRH4hJ5W8
        ZPCYJ3mKHINUghC2TzYyF8L+dTruWNnn7v0X1b3ObHW2KNpSiW8RH+55aL1Oeg==
Date:   Thu, 28 Apr 2022 11:19:50 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 3/8] PCI: rcar-gen2: Add RZ/N1 SOCs support
Message-ID: <20220428111950.1c23c685@bootlin.com>
In-Reply-To: <20220422164744.GA1460864@bhelgaas>
References: <20220422120850.769480-4-herve.codina@bootlin.com>
        <20220422164744.GA1460864@bhelgaas>
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

Hi Bjorn,

On Fri, 22 Apr 2022 11:47:44 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Apr 22, 2022 at 02:08:45PM +0200, Herve Codina wrote:
> > Add Renesas RZ/N1 SOCs family support to the Renesas R-Car
> > gen2 PCI bridge driver.
> > The Renesas RZ/N1 SOCs internal PCI bridge is comptible with
> > the one available in the R-Car Gen2 family.
> > Tested with the RZ/N1D (R9A06G032) SOC. =20
>=20
> Nits (only address if you have some other reason to repost this
> series):
>=20
>   - Subject claims this adds "support," which suggests that this adds
>     some piece of new functionality.  But it adds no new
>     functionality, it merely adds a new compatible string.  I would
>     say "Add RZ/N1 SOC compatible string"
>=20
>   - Add blank lines between paragraphs
>=20
>   - Rewrap paragraphs to fill 75 characters
>=20
>   - s/comptible/compatible/
>=20
>   - s/R-Car gen2/R-Car Gen2/ to write this consistently instead of
>     capitalizing "Gen2" sometimes but not others

I plan a v4 and so, I will take these points into account.

Thanks for the review.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
