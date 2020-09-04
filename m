Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C925D89A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgIDM2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 08:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDM2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 08:28:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FFDC061244;
        Fri,  4 Sep 2020 05:28:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so8282159ejr.13;
        Fri, 04 Sep 2020 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YEBmZti9wComWL+wDuy3aHfpbNZONXVEvzZbnl6I4UU=;
        b=rF2BqXFR1zWm6YJbCmHfHApY/Z54GRInX0x2ihZJzpP4XnuFKLY6WYVcV9M8QApMFB
         /ixhEtbvE+Q1jnX+juh2ptOrvNpslBAWCgSRX+9W64XDgNwJhdm+RhV5dG4uBp2napWt
         BkgxCLfao+jbjNYvZZTMKr0n77RSEk7wkWDOWgA69MZlBipLxSb8+5swKKBO58HNuGSe
         lkQh+u5l6NkdV7xqjc2qHZLgTI4q0d6r1AD8BqGb4n8JZSzBeLnYQBoPcQ7mIib0OOql
         ltYKjaAAGIckLqgjnMLTmR+pSjCMtNxAo/Pprxe6+yv/SE+WIcntD/TLU1AB9WSXLTZQ
         /yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YEBmZti9wComWL+wDuy3aHfpbNZONXVEvzZbnl6I4UU=;
        b=eFPSqzE80HAVKjbFIdnFXMql7XLOhbsLgi8Bd/aLwasKLAwtQEowMXxC3QFEE6bJ5V
         u6NylZ6kZP81ou5ZGjdHHE0qqFPFdujE1jSlQS3lcBjtxXedqJZ6PO0amjvFNvqNQ+3d
         G52CakHuTpGZ5CAVZwQnSc1+zK9Ym9UEmVKDB3guzK1S7POBZLaR0nSPSgPpY7n17xTy
         w3ZH4P0MQOcMwnmpxLwtKnYyAkVMFXM5RMqnrTgiR5VCBw4vpMLkrbMj5aJMniIy6e0w
         diQ19wMNFM1Qi9m2KYLMOp1biVmA2sBKjQX4Ncjpwyjo3ndG/xo6qVFDQyqhLyXZb90R
         SWPQ==
X-Gm-Message-State: AOAM5309UUIY6zmR9mYB8s9VGQ5g1oETklrYK3SdkZI+002tRKY8ay7u
        jaQfDZMUzDtOAEcPiEUFlsg=
X-Google-Smtp-Source: ABdhPJwmgafzzxImnN7IR88uVlWfqNBA2i2ohtRKMJ1tJqfVRsmyqfoaT3Jfsi9RliYYQ4ZKQHI3pw==
X-Received: by 2002:a17:906:c411:: with SMTP id u17mr6886261ejz.319.1599222509912;
        Fri, 04 Sep 2020 05:28:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n20sm5936381ejg.65.2020.09.04.05.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:28:28 -0700 (PDT)
Date:   Fri, 4 Sep 2020 14:28:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Convert to MSI domains
Message-ID: <20200904122827.GA591744@ulmo>
References: <20200904105613.444945-1-thierry.reding@gmail.com>
 <20200904114501.GO1152540@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200904114501.GO1152540@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 08:45:01AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2020 at 12:56:13PM +0200, Thierry Reding wrote:
> > +static void tegra_msi_irq_mask(struct irq_data *d)
> > +{
> > +	struct tegra_msi *msi =3D irq_data_get_irq_chip_data(d);
> > +	struct tegra_pcie *pcie =3D msi_to_pcie(msi);
> > +	unsigned int index =3D d->hwirq / 32;
> > +	u32 value;
> > +
> > +	value =3D afi_readl(pcie, AFI_MSI_EN_VEC(index));
> > +	value &=3D ~BIT(d->hwirq % 32);
> > +	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
> > +}
>=20
> Do these need a flushing write? The Mask operation should be synchronous?

Did you mean a flushing read? We typically flush out writes by reading
=66rom the same register. Another write wouldn't guarantee that both
writes are actually flushed to hardware, would it?

Yes, that sounds like a good idea. It seems to work fine without, but
that may just be a coincidence.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9SMusACgkQ3SOs138+
s6H5txAAi+IqoDYQPoiLUMo8INZGVywvRSgu0o/XNCaDR+8zo1vm1MmV//1rDQU6
jsDFtmmBQkcybGm3ENkL77SjQevlgr5UfS+HCP1H83Wjcl4YvbHRNaA3VUIs40RG
NBk0gcrpTNAF5JGfs4WVtwB7pTCesQZJA4fqn4R3OUOEyBVlhydbmDY9Na+tKNQW
HHIxxX44zqGUISBX5FFeCQQ5lUDto6Bex+GfCqe7Hwjj2ypM6DXITNkAnXuLFR4h
Xi9UL2eNwH9zdQMPwS2JuOiglRDG877DR9NFzUi/TIGbadSzJEsnzFindlaL7cUp
Ygo7GDrO9LPDX/y4V/T8IL5nq1pN31PMHcyd31m9H6AHQks3E1ZayqNitwIsDP12
u12YtCSa8niJctF5G9+yeBc4PQS9/4lxUZ9f7x1hhfrSBDVDV7EqH5GaRfFi2v8u
OyHzDQDU95nYp4G8FbHLP/zJa+8sRJbAmrM6vTt9+NgJvcGSUhodZUsx2AhJxDyh
g5y7ZU96AX3DGtsF1ZjvXpLgM6Se/NMvoUF1cK5EfYo/5KMNuhB9yQDysNpWR0oz
pIW3o/XMeGMWaaosBr+qfPXKlIYADPhozdT7H4VQjoAyk71aDOlvaT5V3zDWRZ2O
wr5YIYhPO2CRlWL7xwT4RSp8uJIIyyAG1VQj9R3N2sC0yQTGJ7g=
=TO2t
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
