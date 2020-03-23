Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08F18F5CE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgCWNfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 09:35:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgCWNfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 09:35:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so17115960wrm.4;
        Mon, 23 Mar 2020 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhms+vqTD06TLe2mBcQbVAZEZO2QF+Dl8VMSSSzj6LQ=;
        b=PG3sDILymsEdg26+l7j8zxUHIy1Idk+Nw133dBNIPQQ/u6sqSLfR4V7COteiilQV3W
         l5VwjgJL+2piTzO2eYrgXj4dQSm97qRq5y1eUakzqAHOciIglTLn5mwyBVjg2EYhiqri
         XQlByVC8fb3uZtJ3B/V5yrBRbHqVOHw/rKt2qPt3utinKTofuOZgtUnEf7WN6utoXp2q
         E5Oy/+vFyg4pUyuidG7m36YVKqDNiSgidxfPnscFmh5CxJ6R6hstPQxhzbLcHeaOaXL0
         qUmHhu1i5J3673BwB/Twola2HK4YMJFmj1aq0zeVWr+ZOpXoannhhMUaQOR0P5zpF6dx
         Hk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhms+vqTD06TLe2mBcQbVAZEZO2QF+Dl8VMSSSzj6LQ=;
        b=pP25I7hytmWUL60A7dsKEeKCaOB4ae1AAKgwgx0wvI7gZh+UYJs63XISBsx+zGrU/g
         sIJOm/3rpSMJBUMOf+3BfoBaC+9ml8KNJt3pOGX/B2cvxDhF58FwsdLWi2d81w4d7do3
         XBprb1yox3cNFB25DFTvbnNoYMWcXeo4jX7GU676SzgsqvjmYxWhrZ/7YKjTmGOeXUja
         UpCQKB/9RJC5dig7FoDvDgDbn+G70CnOJ1B7mRzyimsGoJ8doDrOqnofgwcKVMURH8ry
         XZzZ/thDIBFwWj7F9tqMjsHp0CjaZEKNRnDSoaLehZswRt6SHVotREPzqfPdM3O8dmf5
         uRog==
X-Gm-Message-State: ANhLgQ29jvMeuxTcIrTWuOTbL2qeWD+J2N7qF8HyJIcByfGnjKH1uv9a
        fTLV1bbZDr0T2hWzXdzpv28=
X-Google-Smtp-Source: ADFU+vvAvzAUiUzNXfNA+8RW8Ac2Mux7dMBZ5HMFcL8ILUmtFVRsCPlsVBGFWFgZf4zHocYLLtRi6Q==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr21264064wrt.213.1584970498925;
        Mon, 23 Mar 2020 06:34:58 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id l64sm22396597wmf.30.2020.03.23.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:34:57 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:34:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Print -EPROBE_DEFER error message at debug
 level
Message-ID: <20200323133456.GG3883508@ulmo>
References: <20200319131230.3216305-1-thierry.reding@gmail.com>
 <20200319180529.GB7433@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
In-Reply-To: <20200319180529.GB7433@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 06:05:30PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 19, 2020 at 02:12:30PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Probe deferral is an expected error condition that will usually be
> > recovered from. Print such error messages at debug level to make them
> > available for diagnostic purposes when building with debugging enabled
> > and hide them otherwise to not spam the kernel log with them.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 42 ++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> Hi Thierry,
>=20
> what tree/branch is it based on ? I assume it may depend on some
> patches queued in one of my branches so please let me know and
> I will apply accordingly.

Hi Lorenzo,

This should apply on top of commit 5b645b7fade9 ("PCI: tegra: Add
support for PCIe endpoint mode in Tegra194") which is currently in
linux-next.

Looking at your "pci" tree, that commit seems to be in a branch
called pci/endpoint, though the equivalent commit there has a slightly
different SHA:

    f4746b0ccef9 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra1=
94")

git range-diff shows that the only difference is that in the patch in
linux-next there are a couple of additional exported symbols that are
not in your pci/endpoint branch. That shouldn't be relevant, though,
since this patch touches another area of the code, so applying this to
your pci/endpoint branch should work.

Thierry

> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/c=
ontroller/dwc/pcie-tegra194.c
> > index 97d3f3db1020..e4870fa6ce9c 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1159,17 +1159,31 @@ static int tegra_pcie_dw_parse_dt(struct tegra_=
pcie_dw *pcie)
> >  	/* Endpoint mode specific DT entries */
> >  	pcie->pex_rst_gpiod =3D devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
> >  	if (IS_ERR(pcie->pex_rst_gpiod)) {
> > -		dev_err(pcie->dev, "Failed to get PERST GPIO: %ld\n",
> > -			PTR_ERR(pcie->pex_rst_gpiod));
> > -		return PTR_ERR(pcie->pex_rst_gpiod);
> > +		int err =3D PTR_ERR(pcie->pex_rst_gpiod);
> > +		const char *level =3D KERN_ERR;
> > +
> > +		if (err =3D=3D -EPROBE_DEFER)
> > +			level =3D KERN_DEBUG;
> > +
> > +		dev_printk(level, pcie->dev,
> > +			   dev_fmt("Failed to get PERST GPIO: %d\n"),
> > +			   err);
> > +		return err;
> >  	}
> > =20
> >  	pcie->pex_refclk_sel_gpiod =3D devm_gpiod_get(pcie->dev,
> >  						    "nvidia,refclk-select",
> >  						    GPIOD_OUT_HIGH);
> >  	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
> > -		dev_info(pcie->dev, "Failed to get REFCLK select GPIOs: %ld\n",
> > -			 PTR_ERR(pcie->pex_refclk_sel_gpiod));
> > +		int err =3D PTR_ERR(pcie->pex_refclk_sel_gpiod);
> > +		const char *level =3D KERN_ERR;
> > +
> > +		if (err =3D=3D -EPROBE_DEFER)
> > +			level =3D KERN_DEBUG;
> > +
> > +		dev_printk(level, pcie->dev,
> > +			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
> > +			   err);
> >  		pcie->pex_refclk_sel_gpiod =3D NULL;
> >  	}
> > =20
> > @@ -2058,13 +2072,27 @@ static int tegra_pcie_dw_probe(struct platform_=
device *pdev)
> > =20
> >  	ret =3D tegra_pcie_dw_parse_dt(pcie);
> >  	if (ret < 0) {
> > -		dev_err(dev, "Failed to parse device tree: %d\n", ret);
> > +		const char *level =3D KERN_ERR;
> > +
> > +		if (ret =3D=3D -EPROBE_DEFER)
> > +			level =3D KERN_DEBUG;
> > +
> > +		dev_printk(level, dev,
> > +			   dev_fmt("Failed to parse device tree: %d\n"),
> > +			   ret);
> >  		return ret;
> >  	}
> > =20
> >  	ret =3D tegra_pcie_get_slot_regulators(pcie);
> >  	if (ret < 0) {
> > -		dev_err(dev, "Failed to get slot regulators: %d\n", ret);
> > +		const char *level =3D KERN_ERR;
> > +
> > +		if (ret =3D=3D -EPROBE_DEFER)
> > +			level =3D KERN_DEBUG;
> > +
> > +		dev_printk(level, dev,
> > +			   dev_fmt("Failed to get slot regulators: %d\n"),
> > +			   ret);
> >  		return ret;
> >  	}
> > =20
> > --=20
> > 2.24.1
> >=20

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl54uvwACgkQ3SOs138+
s6FfuBAAlW4UiwzsUPmv3tieVAqkE491ZYfPFMfSyCGf9YiLGnPegKAJE+cCmCqF
uKxCzLE7DfvWMCrelvaGJu4h5nxwg8IpKWNLvTQd23QHrn1iNmBgbEsbkg70IhiA
B+loO7Msrcyx11BUhfPQQq6g1Ggxa3y61WHM81tYkTBdV2eZn3qtaHJer21fRv95
C/v04JJg3MWIy+8mooPIbDC3P3OQLmmmy8CT/TD5q0/bRJ5Nw+SxqV35vZODjB5v
TUTjlywZqeNzjVxwQz1CURU7Fi56G/N/hNry9SeynH0gTkBjxfuBHSUESORabavu
7wwMpnfccpdR6fcUlF3eEg6NVBHmrathxGVRXH1XROjhY9SO4S2WQVR5b47ydCIY
0pRY51UDIHs0necw+8SCPPxBcWlscxRM4BnIltQ5OkBSyngO+c0Bua4QTbp+aB6o
JGYK0lkiJwtzGef+7hdF6dLDUTZ8CUinJNfaexxeshDdS9AQDpmAvNoEBWYeR1l0
NHR5IBa5ucCKT05iA5w1ZecjzdqlD4NfzrFjeu5O7LnjrRBIEogeDAAbaVFPoS6A
N6VKg5+UJ/warGxZ9SOFp/2zz9dVPpzPXsRDzNBlMcXuvujXkfWAIiHFJB5MpGmS
PV/TbqaZAcPdU0N8E4RlwL+EIKOVxARtDGjmsxdv4UMNlA0/AOY=
=ite/
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
