Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1354260BA3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgIHHPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 03:15:42 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52365 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgIHHPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 03:15:40 -0400
Received: by mail-pj1-f67.google.com with SMTP id o16so7823423pjr.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2020 00:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=pF7LJm4igw3vSPPjUsIFM75bV/lP8f54v33iBjNAELA=;
        b=iCDx/ONtvs2boCZedsTgDgKjrUAfE8NsF3TGGVILcUajauu2wIi3tI+qOlVVnfsoN0
         ykMgyyrdVvMiP4bwT7aR8qW1NxxPdzTjHB4uicM/w40KD0KN7XRADW3rIvRitabBrjwu
         TNZBg1zLrWmt1F7GDC/TK/NSo6qwT2IxTMpTaxFz8TOe/inN2ekEbubGD653zj1IzfCD
         v0STuvr/XhuEUYXSg7l3kGLDKyJSzuupxb6AEp7ck9qGA7c6cWsqGAv68mWUkg4NeZe0
         D0EPPoYCTapYwcqmOB8cXevwrbWcW6toW9Lq0hfNgoDyfLAGTHH2KpTCZo8H6CCzXnJ1
         4UsA==
X-Gm-Message-State: AOAM531sUJsORvEb/lbnjTYleNG0jUuNz5XfpxqcnIYODfkeDuCnG6oG
        s5h/bNOGeA8KpaTBlxl0YmU=
X-Google-Smtp-Source: ABdhPJzMkavKnlRApkMuDIy3eqaHJ88gXV7yp0i9Uu/c2eBAHW3rJWYdzOMm7sC2ILUX6wbBEHSQ6g==
X-Received: by 2002:a17:90a:ead5:: with SMTP id ev21mr2548877pjb.188.1599549339300;
        Tue, 08 Sep 2020 00:15:39 -0700 (PDT)
Received: from [10.101.46.193] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 64sm10175122pgi.90.2020.09.08.00.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:15:37 -0700 (PDT)
Subject: Re: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <20200904171325.64959-1-jonathan.derrick@intel.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Autocrypt: addr=vicamo.yang@canonical.com; keydata=
 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
 suzL+d2CSm1cCUYQeOxX/7MpmAIm
Message-ID: <9602475e-3b20-b070-8f66-52ec5600d9eb@canonical.com>
Date:   Tue, 8 Sep 2020 15:15:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904171325.64959-1-jonathan.derrick@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cHDfpmd2nk7i6Okdz5mNw8rcQg9UW7DDw"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cHDfpmd2nk7i6Okdz5mNw8rcQg9UW7DDw
Content-Type: multipart/mixed; boundary="LlhYiN1DjHqcGkEjPUZAWKIGhaLvTmlK9"

--LlhYiN1DjHqcGkEjPUZAWKIGhaLvTmlK9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-09-05 01:13, Jon Derrick wrote:
> Some platforms have an AHCI controller behind VMD. These platforms are
> working correctly except for a case when the AHCI MSI is programmed wit=
h
> VMD IRQ vector 0 (0xfee00000). When programmed with any other interrupt=

> (0xfeeNN000), the MSI is routed correctly and is handled by VMD. Placin=
g
> the AHCI MSI(s) in the fast-interrupt allow list solves the issue.
>=20
> This also requires that VMD allocate more than one MSI/X vector and
> changes the minimum MSI/X vectors allocated to two.
>=20
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Verified two platforms with such configuration. Thank you.

You-Sheng Yang

> ---
>  drivers/pci/controller/vmd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> index f69ef8c89f72..d9c72613082a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -202,15 +202,13 @@ static struct vmd_irq_list *vmd_next_irq(struct v=
md_dev *vmd, struct msi_desc *d
>  	int i, best =3D 1;
>  	unsigned long flags;
> =20
> -	if (vmd->msix_count =3D=3D 1)
> -		return &vmd->irqs[0];
> -
>  	/*
> -	 * White list for fast-interrupt handlers. All others will share the
> +	 * Allow list for fast-interrupt handlers. All others will share the
>  	 * "slow" interrupt vector.
>  	 */
>  	switch (msi_desc_to_pci_dev(desc)->class) {
>  	case PCI_CLASS_STORAGE_EXPRESS:
> +	case PCI_CLASS_STORAGE_SATA_AHCI:
>  		break;
>  	default:
>  		return &vmd->irqs[0];
> @@ -657,7 +655,7 @@ static int vmd_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
> =20
> -	vmd->msix_count =3D pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> +	vmd->msix_count =3D pci_alloc_irq_vectors(dev, 2, vmd->msix_count,
>  					PCI_IRQ_MSIX);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>=20


--LlhYiN1DjHqcGkEjPUZAWKIGhaLvTmlK9--

--cHDfpmd2nk7i6Okdz5mNw8rcQg9UW7DDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEVhtdp+wXuXuqVL95S6BJ+2O0nE8FAl9XL5cACgkQS6BJ+2O0
nE9W0AgAnH4Og9QgoS4mKTvhl0kj91bGMr9TjrvgUL3LAbbjzNRVr2KpVxE9VcN2
y8OodntKVDfY4cc/9OvqUL9QPg9oZhxVXPIpMZk4H0qD+H3SUSZxA7PymIt7kgio
HauDOxhlisLM0O277qgl8tK3fyst4g4N90MGoSCjKyhdXge4NXE8VeIbTlsUeEf4
3aJUvnh950KfpWROQ9/E1T95nqiDeRBLf4ELuQ+59X92wNpHkBLZeAdjBhxoJGR8
FB5M5qPKFF0gJmghJPc+y2fDIlN27IdyiScW29XsNeY9qowLEmLcFiDn75TekERT
8HmCtWRoMp/zvz3JeZlQP9p/8M8+6A==
=vaob
-----END PGP SIGNATURE-----

--cHDfpmd2nk7i6Okdz5mNw8rcQg9UW7DDw--
