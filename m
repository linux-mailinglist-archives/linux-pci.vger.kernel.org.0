Return-Path: <linux-pci+bounces-29990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D915EADE10F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C357AA7AC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21419F11F;
	Wed, 18 Jun 2025 02:24:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26236C2EF;
	Wed, 18 Jun 2025 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750213499; cv=none; b=RF+WISbsrj08NxqXAKJE516gnKjCZrnbWBikEp5+ijGprCVaxUOBKLPHYX8MIrT7dNFy+Jd+Hd+y5xkJFNr5h0pd+UiANhtkBZ3mtHdu8jIdhV/w2xDtHMg89LlvMe+WMVCtO0ROlzjUDeUSe1Km74ljsdt+tfsqm4kuB3x+X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750213499; c=relaxed/simple;
	bh=veGwjYAshz5wATG617MZKNzcaKLYPgMK/Du4Bkd6tkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8841yUItXMWxNKr7PmTkRN6rbuWO7bIOOvVcmlhQ4uO6hv+Py46KMgnDnunPZE/PXymA51wAN0RntLsWzoj2RYm/h/Lz++lqg1pziJ6ttRdIfwb5CKdSf1rzwjYADrZEWRW4I0xlZl7m04yUOyUXSFfH2fr/AgpRIlKB+TOuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from mail-wr1-f46.google.com (unknown [209.85.221.46])
	by APP-03 (Coremail) with SMTP id rQCowABHXFRxI1JohnlDBw--.7428S2;
	Wed, 18 Jun 2025 10:24:50 +0800 (CST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5123c1533so3619032f8f.2;
        Tue, 17 Jun 2025 19:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnetWa153F1iwRXLT/Nk+EXqCvd5g6ZFmxOvo1MkfCWD6Bs80CPcgs4h54sZzOeV4X7HXszF2hqTED@vger.kernel.org, AJvYcCWWGNPaK6nbSDLXOSYdgNn+SmJFmh2tzTXGf3oi9ewGEYckheR5+D0cg8TF05QjiHSQ8FqcC2qsxXnB@vger.kernel.org, AJvYcCXiOgVFIREQLyB7kWeFp+Df5V1xZOYwaX/Tguuf2Vx/9Cm4ue4bMwRAl06agkEwLqkXWlir06Ykuw/7v26G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34jyOf9jn6tGV995Pf24U1zoAlyPVnrgnjSNAjQm35qqqsJ1z
	wePsOzLAZEjd/GcnBj8qPAKs/TkYHac4ZeKJXhPT5zC0TFLGMewaHUeMeYmv9MuDb4wvbL27hb6
	b80JKXlHQq23hz2gSepZYT6udnG/Rhog=
X-Google-Smtp-Source: AGHT+IFqqgCqTx3H7A2RicTOV7G+8sPyByahjukgJbjYtZInaAbuTplcRs9VJ6pS0QLur+Gg3eUy9v735bCIVegSzI4=
X-Received: by 2002:a05:6000:2908:b0:3a3:ec58:ebf2 with SMTP id
 ffacd0b85a97d-3a572398e99mr12091890f8f.7.1750213488113; Tue, 17 Jun 2025
 19:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617023738.779081-1-qiaozhe@iscas.ac.cn> <20250617144038.GA1134072@bhelgaas>
In-Reply-To: <20250617144038.GA1134072@bhelgaas>
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
Date: Wed, 18 Jun 2025 10:24:36 +0800
X-Gmail-Original-Message-ID: <CALhs5=1t37kXaVNiidfK16EqP-7HT_bq_s5d=JKAuBtwhONd4w@mail.gmail.com>
X-Gm-Features: Ac12FXwoXGIkpszpHeIr8iU0A0DVQ-_8wB0lyTMDmYvmh6yGW21L2y23GrtdZ3U
Message-ID: <CALhs5=1t37kXaVNiidfK16EqP-7HT_bq_s5d=JKAuBtwhONd4w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ACPI: Fix double free bug in pci_acpi_scan_root() function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, lenb@kernel.org, 
	kwilczynski@kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:rQCowABHXFRxI1JohnlDBw--.7428S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xWFyfAF1kWFyrCF1rJFb_yoWrGw1Dpa
	1Svw4UAr4ktr4kGr1kZ3WrZF1rZrs0krW7KrZ7t3yfAF4DWr12qFZFkrna9F98Zrs5Cw4I
	vF4qvFyUGF4qyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
	I_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxG
	rwCY02Avz4vEIxC_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x07bVQ6JUUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Hi Bjorn

On Tue, Jun 17, 2025 at 10:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Dan]
>
> On Tue, Jun 17, 2025 at 10:37:38AM +0800, Zhe Qiao wrote:
> > The patch "PCI/ACPI: Fix allocated memory release on error in
> > pci_acpi_scan_root()" introduces a dual release issue. When
> > acpi_pci_root_creat() fails, the pci_cpi_can_root() function
> > will release 'ri ->cfg' and 'root_ops' in the error handling
> > path.However, acpi_pci_root_creat() will also call
> > __acpi_pci_root_release_info(), which in turn will call the
> > release_info hook, causing the same block of memory to be
> > released again.
>
> These are all nits, but would have to be fixed before applying:
>
>   - 'The patch "PCI/ACPI: Fix ..."' is not the usual way to identify a
>     commit.  Use the same style as in the Fixes: tag below.
>
>   - Typo in "acpi_pci_root_creat" (twice)
>
>   - Typo in "pci_cpi_can_root"
>
>   - Add space after the period in "path.However, ..."
>
>   - Add "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>" and
>     "Closes: https://lore.kernel.org/all/aEmdnuw715btq7Q5@stanley.mountai=
n/"
>     and cc: Dan.
>
>   - 631b2af2f357 appeared in v6.16-rc1, so we should try to get the
>     fix into v6.16.  A hint after the "---" would be helpful to make
>     sure that happens.
>
> Wait a few days before reposting in case other folks have comments.
>

Thank you for your detailed review and pointing out these issues.
I will wait a few days before resending.

Thanks again!

> > Fixes: 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error i=
n pci_acpi_scan_root()")
> > Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> > ---
> > v1 -> v2:
> >  - Restore all changes from the first version.
> >  - Remove unnecessary release info hooks.
> >  - Add a NULL check before calling info->ops->release_info().
> >  - Delete the currently unused pci_api_geneic_delease_info () function.
> > ---
> >  drivers/acpi/pci_root.c |  3 ++-
> >  drivers/pci/pci-acpi.c  | 12 ------------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 74ade4160314..83628adbc56b 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -974,7 +974,8 @@ static void __acpi_pci_root_release_info(struct acp=
i_pci_root_info *info)
> >               resource_list_destroy_entry(entry);
> >       }
> >
> > -     info->ops->release_info(info);
> > +     if (info->ops && info->ops->release_info)
> > +             info->ops->release_info(info);
> >  }
> >
> >  static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index b78e0e417324..6e85816ee1c3 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1652,17 +1652,6 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root=
 *root)
> >       return cfg;
> >  }
> >
> > -/* release_info: free resources allocated by init_info */
> > -static void pci_acpi_generic_release_info(struct acpi_pci_root_info *c=
i)
> > -{
> > -     struct acpi_pci_generic_root_info *ri;
> > -
> > -     ri =3D container_of(ci, struct acpi_pci_generic_root_info, common=
);
> > -     pci_ecam_free(ri->cfg);
> > -     kfree(ci->ops);
> > -     kfree(ri);
> > -}
> > -
> >  /* Interface called from ACPI code to setup PCI host controller */
> >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  {
> > @@ -1683,7 +1672,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pc=
i_root *root)
> >       if (!ri->cfg)
> >               goto free_root_ops;
> >
> > -     root_ops->release_info =3D pci_acpi_generic_release_info;
> >       root_ops->prepare_resources =3D pci_acpi_root_prepare_resources;
> >       root_ops->pci_ops =3D (struct pci_ops *)&ri->cfg->ops->pci_ops;
> >       bus =3D acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg=
);
> > --
> > 2.43.0
> >

regards,
Zhe


