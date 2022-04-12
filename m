Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994144FDE21
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiDLLZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbiDLLZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:25:25 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8729F382;
        Tue, 12 Apr 2022 03:05:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4BB8E100013;
        Tue, 12 Apr 2022 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649757939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLXv+fctRgNNYYJJTbwIOlWDeyNd2mLv72FQ+bxrQ8Y=;
        b=msmCUWmcxRHbBvMkFgaVIxOulrCXc4kL/L0NiWA6A7nCdvKmhEWDWMUYrEwbDidGOTXdaJ
        DmKQ+MDh+3oA8D96K2UQs0nJRDKxE2d8aQ2OmAba78hqz4f67hNT6tHJg2BAS8Fw3T7/o5
        CZCjdZHdMpRuR5GHd0pbaWL+q+Z4Jjg81j1LP7tTqLRCC6PTB/kTo7QnzwLHyxJxr9q4/c
        S3fCEvy9dtKpu+2V+2OuBC25oYF7mbXi7i+3aEA2lruvMoay5hSwqnnmGuzSZhvrT1yPEz
        vkLKCGqD/nyVXD/9XLw2jc6Cscm+scTEsBDSXz3WEjQE+pUMp3Gk52VNozhZtg==
Date:   Tue, 12 Apr 2022 12:05:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
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
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH 3/6] PCI: rcar-gen2: Add R9A06G032 support
Message-ID: <20220412120535.4bf77ab1@xps13>
In-Reply-To: <20220412094029.287562-4-herve.codina@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
        <20220412094029.287562-4-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Herve,

herve.codina@bootlin.com wrote on Tue, 12 Apr 2022 11:40:26 +0200:

> Add Renesas R9A06G032 SoC support to the Renesas R-Car gen2 PCI
> bridge driver.
> The Renesas RZ/N1D (R9A06G032) internal PCI bridge is compatible
> with the one available in the R-Car Gen2 family.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/control=
ler/pci-rcar-gen2.c
> index 528bc3780e01..586e4785a57f 100644
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -352,6 +352,8 @@ static const struct of_device_id rcar_pci_of_match[] =
=3D {
>  	{ .compatible =3D "renesas,pci-r8a7791", },
>  	{ .compatible =3D "renesas,pci-r8a7794", },
>  	{ .compatible =3D "renesas,pci-rcar-gen2", },
> +	{ .compatible =3D "renesas,pci-r9a06g032", },
> +	{ .compatible =3D "renesas,pci-rzn1", },

I don't think you don't yet need to match against the two, matching
against pci-rzn1 is enough for now, until we discover that something is
specific in the r9a06g032 family and we need to handle something else
of course.

Thanks,
Miqu=C3=A8l
