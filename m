Return-Path: <linux-pci+bounces-10804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73C93C9BB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19BE1C20FE4
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60413E05C;
	Thu, 25 Jul 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TxE0DuUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9713D8AC
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939907; cv=none; b=FZg2R4RGBwpXX/KLzTRXQVeQgl0PXJ2zymru3q6sptyrsE63/R5dyGz8NihUuvEwnwX+N3HDUFlc0F8vhRbiew/pv+q963DQOvuREAmWqWrxDEzCwMYDprrznKBMBUziMs6t5oyv9KeYl1sz4Biq3YggHCn4o0DZ11PsRFzFry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939907; c=relaxed/simple;
	bh=3+D3gEZdzL3GB021vNK5gNZKukPe2hl7T7PjjbjcLOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdGkcAs3c5s8qJUQnhdKaxsF1tgb2vJfZZanGSPpA4XcIkRa72Y8iy3GoqDRNVl/szNvFhtAbQ6PWpNQCPkCiBsY0I772C1fk3u40japmrr2pLLBsF3gCLYlNqlg1O1ccXk+/xKRVlgFibik+xYWS4YlMa9J0M/LfYdEn9unDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TxE0DuUk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01993090so825660e87.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721939904; x=1722544704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4uR2hSLqcbKtinH+KqAWmjEN0lLMIcTnIWPb+awCA4=;
        b=TxE0DuUkmYy+xko1J88jCiihu0woiIzYppmQsqZHH3WYrSUaNUJgRMkuhUifja7yPv
         tmxm2kYwttrZGZvyxKqfMiFysr543Uf4K5RpAeGX5S651C8Bejb8X3j503ZQxCjrGu/3
         sviFK2Kcfu6L23LGRa2CncfBWmXLmYgD4FMRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939904; x=1722544704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4uR2hSLqcbKtinH+KqAWmjEN0lLMIcTnIWPb+awCA4=;
        b=jyc0mCegl0Kp+x8Z0SYax22FjdLF852FktmEmQjSrLQbrR6FqtW5feAnU37TINOIvW
         Oq1hV9qUtN/tZfCvcAFOwQUBdtoyQTP1bcWFrt1bwxAy4FVVCKwFqVnsa53+ULn1T8yY
         zu1TAQsDm+dMDvUNy+FpOHJ3nVknBq5ehvlhYs5tLeICdz+2iX56fbNgFExnU5s4r1fa
         6yCSwJK76qRUnPwjseRmOIf58m6FHKUmTxfd/72EqhUPNP4dn2bRhPC8T2UoV6zO+DR7
         C5g9xMG1bADAjP7WRvasnkC5L9K9peB2J6ras3fZYJ//63o0vnXDux3vQHPdmAo7Gu/T
         qiUA==
X-Gm-Message-State: AOJu0YyznBbvDV3YZP8n+mmLrQageREQg7rvRgfIW2PNGMMtK9JCk+1V
	N9wKM/JRTFAfhJepJdgadGoHyoUImM4V+AWLqyD7NbnYo+b604I3gFtN1YsY4/iMK/E3vJxH9f4
	03QKflMlUrOBKBQImE9/fliKHStvEfKGFxwBT
X-Google-Smtp-Source: AGHT+IEOv16YwJuWatrpX8ikQfxI24nOOtVGCgF/QQIOX7p2OgxHk05IR9lKpHkI0eJOsPLVRSPUmN016WSyX/UjYWg=
X-Received: by 2002:a05:6512:234a:b0:52e:a7a6:ed7f with SMTP id
 2adb3069b0e04-52fd6093268mr2166969e87.60.1721939903476; Thu, 25 Jul 2024
 13:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-12-james.quinlan@broadcom.com> <20240725045810.GK2317@thinkpad>
In-Reply-To: <20240725045810.GK2317@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 25 Jul 2024 16:38:12 -0400
Message-ID: <CA+-6iNxWz1aJr2rHJKSpXaD1raUij-P_Xo9a6MvWJLae1_m7oQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] PCI: brcmstb: Change field name from 'type' to 'model'
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004f0c84061e186010"

--0000000000004f0c84061e186010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:58=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 16, 2024 at 05:31:26PM -0400, Jim Quinlan wrote:
> > The 'type' field used in the driver to discern SoC differences is confu=
sing
> > so change it to the more apt 'model'.  We considered using 'family' but
> > this conflicts with Broadcom's conception of a family; for example, 721=
6a0
> > and 7216b0 chips are both considered separate families as each has mult=
iple
> > derivative product chips based on the original design.
> >
>
> TBH, 'model' is also confusing :) Why can't you just use 'soc' as you are
> referrring to the SoC name.

Hello,

Well, the "model" we assign is not necessarily the same as the SoC.
If a new SoC has the same characteristics as a previous "model", we
will not create a new model but rather use the existing one.   For example,
the bcm7216_cfg structure, which is for the 7216 SoC uses the model "BCM727=
8".

I agree that this is not crystal clear but using SoC could be
considered misleading.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> - Mani
>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++--------------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 2fe1f2a26697..fa5616a56383 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -211,7 +211,7 @@ enum {
> >       PCIE_INTR2_CPU_BASE,
> >  };
> >
> > -enum pcie_type {
> > +enum pcie_model {
> >       GENERIC,
> >       BCM7425,
> >       BCM7435,
> > @@ -229,7 +229,7 @@ struct rc_bar {
> >
> >  struct pcie_cfg_data {
> >       const int *offsets;
> > -     const enum pcie_type type;
> > +     const enum pcie_model model;
> >       const bool has_phy;
> >       unsigned int num_inbound;
> >       int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> > @@ -270,7 +270,7 @@ struct brcm_pcie {
> >       u64                     msi_target_addr;
> >       struct brcm_msi         *msi;
> >       const int               *reg_offsets;
> > -     enum pcie_type          type;
> > +     enum pcie_model         model;
> >       struct reset_control    *rescal;
> >       struct reset_control    *perst_reset;
> >       struct reset_control    *bridge;
> > @@ -288,7 +288,7 @@ struct brcm_pcie {
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> >  {
> > -     return pcie->type =3D=3D BCM7435 || pcie->type =3D=3D BCM7425;
> > +     return pcie->model =3D=3D BCM7435 || pcie->model =3D=3D BCM7425;
> >  }
> >
> >  /*
> > @@ -852,7 +852,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_p=
cie *pcie,
> >        * security considerations, and is not implemented in our modern
> >        * SoCs.
> >        */
> > -     if (pcie->type !=3D BCM7712)
> > +     if (pcie->model !=3D BCM7712)
> >               set_bar(b++, &n, 0, 0, 0);
> >
> >       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > @@ -869,7 +869,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_p=
cie *pcie,
> >                * That being said, each BARs size must still be a power =
of
> >                * two.
> >                */
> > -             if (pcie->type =3D=3D BCM7712)
> > +             if (pcie->model =3D=3D BCM7712)
> >                       set_bar(b++, &n, size, cpu_beg, pcie_beg);
> >
> >               if (n > pcie->num_inbound)
> > @@ -886,7 +886,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_p=
cie *pcie,
> >        * that enables multiple memory controllers.  As such, it can ret=
urn
> >        * now w/o doing special configuration.
> >        */
> > -     if (pcie->type =3D=3D BCM7712)
> > +     if (pcie->model =3D=3D BCM7712)
> >               return n;
> >
> >       ret =3D of_property_read_variable_u64_array(pcie->np, "brcm,scb-s=
izes", pcie->memc_size, 1,
> > @@ -1008,7 +1008,7 @@ static void set_inbound_win_registers(struct brcm=
_pcie *pcie, const struct rc_ba
> >                * 7712:
> >                *     All of their BARs need to be set.
> >                */
> > -             if (pcie->type =3D=3D BCM7712) {
> > +             if (pcie->model =3D=3D BCM7712) {
> >                       /* BUS remap register settings */
> >                       reg_offset =3D brcm_ubus_reg_offset(i);
> >                       tmp =3D lower_32_bits(cpu_addr) & ~0xfff;
> > @@ -1036,7 +1036,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >               return ret;
> >
> >       /* Ensure that PERST# is asserted; some bootloaders may deassert =
it. */
> > -     if (pcie->type =3D=3D BCM2711) {
> > +     if (pcie->model =3D=3D BCM2711) {
> >               ret =3D pcie->perst_set(pcie, 1);
> >               if (ret) {
> >                       pcie->bridge_sw_init_set(pcie, 0);
> > @@ -1067,9 +1067,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >        */
> >       if (is_bmips(pcie))
> >               burst =3D 0x1; /* 256 bytes */
> > -     else if (pcie->type =3D=3D BCM2711)
> > +     else if (pcie->model =3D=3D BCM2711)
> >               burst =3D 0x0; /* 128 bytes */
> > -     else if (pcie->type =3D=3D BCM7278)
> > +     else if (pcie->model =3D=3D BCM7278)
> >               burst =3D 0x3; /* 512 bytes */
> >       else
> >               burst =3D 0x2; /* 512 bytes */
> > @@ -1666,7 +1666,7 @@ static const int pcie_offsets_bmips_7425[] =3D {
> >
> >  static const struct pcie_cfg_data generic_cfg =3D {
> >       .offsets        =3D pcie_offsets,
> > -     .type           =3D GENERIC,
> > +     .model          =3D GENERIC,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound    =3D 3,
> > @@ -1674,7 +1674,7 @@ static const struct pcie_cfg_data generic_cfg =3D=
 {
> >
> >  static const struct pcie_cfg_data bcm7425_cfg =3D {
> >       .offsets        =3D pcie_offsets_bmips_7425,
> > -     .type           =3D BCM7425,
> > +     .model          =3D BCM7425,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound    =3D 3,
> > @@ -1682,7 +1682,7 @@ static const struct pcie_cfg_data bcm7425_cfg =3D=
 {
> >
> >  static const struct pcie_cfg_data bcm7435_cfg =3D {
> >       .offsets        =3D pcie_offsets,
> > -     .type           =3D BCM7435,
> > +     .model          =3D BCM7435,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound    =3D 3,
> > @@ -1690,7 +1690,7 @@ static const struct pcie_cfg_data bcm7435_cfg =3D=
 {
> >
> >  static const struct pcie_cfg_data bcm4908_cfg =3D {
> >       .offsets        =3D pcie_offsets,
> > -     .type           =3D BCM4908,
> > +     .model          =3D BCM4908,
> >       .perst_set      =3D brcm_pcie_perst_set_4908,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound    =3D 3,
> > @@ -1706,7 +1706,7 @@ static const int pcie_offset_bcm7278[] =3D {
> >
> >  static const struct pcie_cfg_data bcm7278_cfg =3D {
> >       .offsets        =3D pcie_offset_bcm7278,
> > -     .type           =3D BCM7278,
> > +     .model          =3D BCM7278,
> >       .perst_set      =3D brcm_pcie_perst_set_7278,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_7278,
> >       .num_inbound    =3D 3,
> > @@ -1714,7 +1714,7 @@ static const struct pcie_cfg_data bcm7278_cfg =3D=
 {
> >
> >  static const struct pcie_cfg_data bcm2711_cfg =3D {
> >       .offsets        =3D pcie_offsets,
> > -     .type           =3D BCM2711,
> > +     .model          =3D BCM2711,
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound    =3D 3,
> > @@ -1722,7 +1722,7 @@ static const struct pcie_cfg_data bcm2711_cfg =3D=
 {
> >
> >  static const struct pcie_cfg_data bcm7216_cfg =3D {
> >       .offsets        =3D pcie_offset_bcm7278,
> > -     .type           =3D BCM7278,
> > +     .model          =3D BCM7278,
> >       .perst_set      =3D brcm_pcie_perst_set_7278,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_7278,
> >       .has_phy        =3D true,
> > @@ -1779,7 +1779,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >       pcie->dev =3D &pdev->dev;
> >       pcie->np =3D np;
> >       pcie->reg_offsets =3D data->offsets;
> > -     pcie->type =3D data->type;
> > +     pcie->model =3D data->model;
> >       pcie->perst_set =3D data->perst_set;
> >       pcie->bridge_sw_init_set =3D data->bridge_sw_init_set;
> >       pcie->has_phy =3D data->has_phy;
> > @@ -1848,7 +1848,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >               goto fail;
> >
> >       pcie->hw_rev =3D readl(pcie->base + PCIE_MISC_REVISION);
> > -     if (pcie->type =3D=3D BCM4908 && pcie->hw_rev >=3D BRCM_PCIE_HW_R=
EV_3_20) {
> > +     if (pcie->model =3D=3D BCM4908 && pcie->hw_rev >=3D BRCM_PCIE_HW_=
REV_3_20) {
> >               dev_err(pcie->dev, "hardware revision with unsupported PE=
RST# setup\n");
> >               ret =3D -ENODEV;
> >               goto fail;
> > @@ -1863,7 +1863,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >               }
> >       }
> >
> > -     bridge->ops =3D pcie->type =3D=3D BCM7425 ? &brcm7425_pcie_ops : =
&brcm_pcie_ops;
> > +     bridge->ops =3D pcie->model =3D=3D BCM7425 ? &brcm7425_pcie_ops :=
 &brcm_pcie_ops;
> >       bridge->sysdata =3D pcie;
> >
> >       platform_set_drvdata(pdev, pcie);
> > --
> > 2.17.1
> >
>
>
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--0000000000004f0c84061e186010
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6sVy6BQ2WW5dZEfGyZaFJQApPKZjh
0thbK7ATcaW1UjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MjUyMDM4MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAHA+4fwfhuTh0rAURGoeQ0StmiQQCNnLF44A33V7FZRcUZmqz
tpW0yV5sS21VBsZKf5pXLUuVM7U4yW2uIeoqFjZRrzneVt5zHEH5Sb4t+60/XR/aKHi9vMeRdsEl
ivqHrOlZ+e1HKLFlErw1760v3VL6iJFKm5FRUndZ75tJTFbAMrQh77SGriwtw+HDQcO2FelaM/c0
BgKf4DX4NIIIUPYG2c4E4eupg5oyaTGjNLq1WM+Hex4+6Z1L6g2GHAz8x1v9d23qNIIs+jgmrS3L
9K1judb5Yhhp85w+icIfOkxB6tz5dWL+AySHGKk/xpFwz1mZGPd0HCcrF8+uld4J3g==
--0000000000004f0c84061e186010--

