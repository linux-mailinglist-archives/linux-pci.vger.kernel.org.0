Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5C9FDE5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfH1JIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 05:08:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfH1JIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 05:08:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so2014303wmg.0;
        Wed, 28 Aug 2019 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3r/7Ysgygsmgg7XBtb3VjCGdHn7Br75x9QrAUieJRYo=;
        b=cw5wZqaya+LQItOjqCiLiKz9QQ8K/7ohMITSjglTEzO3t57z9U7l8MiilKcTpvn7h9
         tYSbBYM4R+/r8g3c4RRFmn7Ctsy9V9vlHzt+SfLlYuh+ancT/xVq8MjN6L+CEp4BHz2H
         8oC0jlqWm9e+JLQC7BxmbLhBWVKznQACVKjzXzXhSj+wctbB9yg8IVlu+ulcGd3Lljkc
         sXSVknxf7oSwErLpsCPYXxTJQ2tuI+fbv+waCu5QzUM4O/p2/kOPQP9vdbTF3psW85jr
         hUqsVq9bBcrCaokRQR8xrsO20bplKYzOLWnoEoNVnae+9yD7GBJEkujV5JPHcWUJRZjD
         q6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3r/7Ysgygsmgg7XBtb3VjCGdHn7Br75x9QrAUieJRYo=;
        b=oeOORx+nzJiqrrKiRsKyvPiyHmTfQoWXB7Q28oSdw2eXot+xqwA3xHbVnPe5WYCHal
         7qxkvR+utwKanE1FjJ8L8QZCllDjfaH/3ikyW9+bdmyPP/eZUrS0jh9Z2FDlq3uluRRD
         1rK5WYIwD4aSwIG6fgud7OMlEP9qk8v9leoSIVC8P8KftdtyrGGHDPxm1JZX263mgiiY
         RtcwXOIRtCIY55LtZ4DCSrhbS738SjW3A4/ML9yl1aMlDdIQ+O2t8xcXAVfmnkx3regy
         pAtPa1k3Hp6f3OTWAqYLGvUuEG6OSex8hvVrXu7i4f/b0ZCkkHTUkYbTboy4DKEmiD5g
         XGHA==
X-Gm-Message-State: APjAAAUruKnfLC9x/Fkp3bKJfn6F7jbj9ORlrWrEt3KAOWoBClfRBhrS
        IsSUXuExGYDbhqyXPGM1Ah8=
X-Google-Smtp-Source: APXvYqzt39rWipB7GTNadn+iRBqGwWIPL1aGYp/oL9KV3yaDTOiZxTC9i1TbB/WmUBYwshXyc9pKHg==
X-Received: by 2002:a1c:3945:: with SMTP id g66mr3376701wma.139.1566983280714;
        Wed, 28 Aug 2019 02:08:00 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id v7sm1506074wrn.41.2019.08.28.02.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:07:58 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:07:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 6/6] PCI: tegra: Add support to enable slot regulators
Message-ID: <20190828090757.GA2917@ulmo>
References: <20190826073143.4582-1-vidyas@nvidia.com>
 <20190826073143.4582-7-vidyas@nvidia.com>
 <20190827154725.GP14582@e119886-lin.cambridge.arm.com>
 <91f8914a-22a9-8b7c-bc00-c309a21d83db@nvidia.com>
 <20190827171333.GQ14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190827171333.GQ14582@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 06:13:34PM +0100, Andrew Murray wrote:
> On Tue, Aug 27, 2019 at 09:54:17PM +0530, Vidya Sagar wrote:
> > On 8/27/2019 9:17 PM, Andrew Murray wrote:
> > > On Mon, Aug 26, 2019 at 01:01:43PM +0530, Vidya Sagar wrote:
> > > > Add support to get regulator information of 3.3V and 12V supplies o=
f a PCIe
> > > > slot from the respective controller's device-tree node and enable t=
hose
> > > > supplies. This is required in platforms like p2972-0000 where the s=
upplies
> > > > to x16 slot owned by C5 controller need to be enabled before attemp=
ting to
> > > > enumerate the devices.
> > > >=20
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-tegra194.c | 65 +++++++++++++++++=
+++++
> > > >   1 file changed, 65 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/p=
ci/controller/dwc/pcie-tegra194.c
> > > > index 8a27b25893c9..97de2151a738 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -278,6 +278,8 @@ struct tegra_pcie_dw {
> > > >   	u32 aspm_l0s_enter_lat;
> > > >   	struct regulator *pex_ctl_supply;
> > > > +	struct regulator *slot_ctl_3v3;
> > > > +	struct regulator *slot_ctl_12v;
> > > >   	unsigned int phy_count;
> > > >   	struct phy **phys;
> > > > @@ -1047,6 +1049,59 @@ static void tegra_pcie_downstream_dev_to_D0(=
struct tegra_pcie_dw *pcie)
> > > >   	}
> > > >   }
> > > > +static void tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *p=
cie)
> > > > +{
> > > > +	pcie->slot_ctl_3v3 =3D devm_regulator_get_optional(pcie->dev, "vp=
cie3v3");
> > > > +	if (IS_ERR(pcie->slot_ctl_3v3))
> > > > +		pcie->slot_ctl_3v3 =3D NULL;
> > > > +
> > > > +	pcie->slot_ctl_12v =3D devm_regulator_get_optional(pcie->dev, "vp=
cie12v");
> > > > +	if (IS_ERR(pcie->slot_ctl_12v))
> > > > +		pcie->slot_ctl_12v =3D NULL;
> > >=20
> > > Do these need to take into consideration -EPROBE_DEFER?
> > Since these are devm_* APIs, isn't it taken care of automatically?
>=20
> devm_regulator_get_optional can still return -EPROBE_DEFER - for times wh=
en
> "lookup could succeed in the future".
>=20
> It's probably helpful here for your driver to distinguish between there n=
ot
> being a regulator specified in the DT, and there being a regulator but th=
ere
> is no device for it yet. For the latter case - your driver would probe but
> nothing would enumerate.
>=20
> See pcie-rockchip-host.c for an example of where this is handled.
>=20
> Of course if, for whatever reason it is unlikely you'll ever get -EPROBE_=
DEFER
> then maybe it's OK as it is.

Let's not assume that. We've just recently encountered a case where we
did not handle -EPROBE_DEFER because we had assumed too much, and that
turned into a bit of a hassle to fix.

Vidya, I think what Andrew is saying is that you need to propagate the
-EPROBE_DEFER error to the caller (i.e. the ->probe() callback) so that
the PCI controller driver can be properly added to the defer queue in
case the regulator isn't ready yet.

I think what we want here is something like:

	pcie->slot_ctl_3v3 =3D devm_regulator_get_optional(pcie->dev, "vpcie3v3");
	if (IS_ERR(pcie->slot_ctl_3v3)) {
		if (PTR_ERR(pcie->slot_ctl_3v3) !=3D -ENODEV)
			return PTR_ERR(pcie->slot_ctl_3v3);

		pcie->slot_ctl_3v3 =3D NULL;
	}

Andrew, I'm not sure the handling in rockchip_pcie_parse_host_dt() is
correct. It singles out -EPROBE_DEFER, which I think is the wrong way
around. We should be special-casing -ENODEV, because regulator_get()
can return a wide array of error cases, not all of which we actually
want to consider successes. For example we could be getting -ENOMEM,
which, I would argue, is something that we should propagate. I think
it'd be very confusing to take that as meaning "optional regulator
wasn't specified", because in that case the DTS file would've had the
regulator hooked up (we have to assume that it is needed in that case)
but we won't be enabling it, so it's unlikely that devices will
enumerate.

Thierry

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1mRGkACgkQ3SOs138+
s6HM4RAAqdCUeQeL5xGkODnWM/OWnmsWlU4Db7jhjHd+6Z7luFKZvSBDEuSVzphV
uePElq6Abd7v4/QBptqDVysr60LtEiypDlDHs8KJ/UA0R7iUv7dH1YmZ7J5K8Gt/
QKjjD10mmuhskeuT5Yp6J0MBdXeE+LY35uI7NmkJQxB3c5jV0A2U26vVwVtFHruL
J+NCdJFay4L1/rAV0jfVs8v65Iy9w4CB2bDXOKmU//dCFTugyAsfYDRYaCls3a6N
Y4XtztH4W/Ajp9YAhaXYJU0ibECtqPRw7VBIIenDKaNzd35ccm+aH5VMQylwCmai
4tLx2EUp8naN3NpLb8l5yHR7EUDHImmbyrXjMjE2e8rShRqigpanFWP4Ig1aMzsl
pU8o4RQsQcERoOMgXuzoOyL1cL5kmBLfNcqyckoFRr0PV2WsIZEJRlfCG4yiQUsp
evwL6E1ILVkbEl7Z1qYMsbCvqURVvLdWnldgdNvrG91rKomFnW7xhN9o5aQBpHwm
09O01eqAsimgGwxsGYIRlOgKYt6ZRJNQzXgf9aK1q4TTB1ngDHuLyNDYt4LR9dq2
OpxjkoIe3ruKq37bI1PYzk9kYvRi4LR0R0DLR1YCLeC4CdmifuR7+x3GA9DHTpKU
zHpeABc4V2jjlcZWFV2psh2q/wwU2IuMfnmSIrrb+sNrsrE6lqc=
=Qhhk
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
