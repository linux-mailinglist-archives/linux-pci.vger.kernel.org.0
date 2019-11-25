Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F53108940
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfKYHhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 02:37:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55177 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 02:37:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4798214wmj.4;
        Sun, 24 Nov 2019 23:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spOYPQyDQtuNEGLCHEbAJ7anyJ/giN6OPQ7cjoFVqtw=;
        b=nlDyDy1bfjSORe36KRrKoxyh1jVH/ihgGW13qb9uCsWsbbcz19LRcGrtkT9W5ZrMGC
         +tKS9Dfp38yKpBPgACnInVIxacpfJ7ZE/BeKArG7aP+efZgl4tVNCEr/vw5QIHCilJyl
         7dKaEmFVTIHK8+7GxoTp+kL2/c1aFO2UnhzCIOAifWtWdiQdeGC4X3CnVwqs53D9QZY+
         wjeaL2PUSLmyB1yGV2lXD60kolNTN/488gYgpjI+wSpZpYPrmCifNZezI5wdp+36jLwJ
         BBqQgu7uqTyZkW/TsFZRdd3V2IfGabSOnVOIyzH++cmlhDBLzGbmSZjfPkl17jbpOfyu
         NXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spOYPQyDQtuNEGLCHEbAJ7anyJ/giN6OPQ7cjoFVqtw=;
        b=VTSvXpsihvUpw6HZlvV38Sgg2CIKf3V9O0Vt5Kpy9qyEPdUiNiDSEhLiA7YghzBl4Q
         J4WwOqiTaF5ZzjUhkCWgF1VRSFDKPkmWy+Py4SzFrpvr2Bjxd/DG4TrSTQh6dSBbULTk
         L+9xsSAmZlkG/t4jAaS+J+cmcSNhYooMBupE/rOF3ARFIsnW92owk1Q81icQTUJILMcj
         cK2DgwOWwA99IxmYKnk3agBnJTJ2tADGARzssYCDK5kO8+pH4rrLYRuE71R5d0R5wu5/
         yqeWxG6LvKbBMtO/L2nJ5SRbWyxqVcwPGdqxax0B+DM/FijQfVZ6M3WffVkXZoWnQey7
         I47Q==
X-Gm-Message-State: APjAAAXXDtazwYjSeGGx0gn+12GYZ3SmgoiopEH4rkX4hOyEflU2VUHD
        L/KSAzFVIXQ+rERKH2cyMp8=
X-Google-Smtp-Source: APXvYqxZwJODIeVnoLPKFmWYnHWUGAjusnjwrz98gdEmEHkkGT+LRb5niD1I0kDACqZ48rhUBncHpQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr15652550wmb.14.1574667450845;
        Sun, 24 Nov 2019 23:37:30 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id b8sm9130086wrt.39.2019.11.24.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 23:37:29 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:37:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 6/6] arm64: tegra: Add support for PCIe endpoint mode in
 P2972-0000 platform
Message-ID: <20191125073728.GE1409040@ulmo>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-7-vidyas@nvidia.com>
 <20191122132533.GD1315704@ulmo>
 <e1e44c1c-c1ab-27dd-b3ac-a9ed878411a2@nvidia.com>
 <20191125072542.GC1409040@ulmo>
 <4f92c07a-ea0f-a632-f5c5-b87666f8ecdd@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <4f92c07a-ea0f-a632-f5c5-b87666f8ecdd@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 01:03:27PM +0530, Vidya Sagar wrote:
> On 11/25/2019 12:55 PM, Thierry Reding wrote:
> > On Mon, Nov 25, 2019 at 12:30:53PM +0530, Vidya Sagar wrote:
> > > On 11/22/2019 6:55 PM, Thierry Reding wrote:
> > > > On Fri, Nov 22, 2019 at 04:15:05PM +0530, Vidya Sagar wrote:
> > > > > Add endpoint mode support for PCIe C5 controller in P2972-0000 pl=
atform
> > > > > with information about supplies, PHY, PERST GPIO and GPIO that co=
ntrols
> > > > > PCIe reference clock coming from the host system.
> > > > >=20
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >    .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 29 +++++++++++=
++++++++
> > > > >    1 file changed, 29 insertions(+)
> > > > >=20
> > > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b=
/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > > > index 7eb64b816e08..58c3a9677bc8 100644
> > > > > --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > > > +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > > > @@ -43,6 +43,19 @@
> > > > >    		gpio@c2f0000 {
> > > > >    			status =3D "okay";
> > > > > +			/*
> > > > > +			 * Change the below node's status to 'okay' when
> > > > > +			 * PCIe C5 controller is enabled to operate in endpoint
> > > > > +			 * to allow REFCLK from the host system to flow into
> > > > > +			 * the controller.
> > > > > +			 */
> > > > > +			pex-refclk-sel-high {
> > > > > +				gpio-hog;
> > > > > +				output-high;
> > > > > +				gpios =3D <TEGRA194_AON_GPIO(AA, 5) 0>;
> > > > > +				label =3D "pex_refclk_sel_high";
> > > > > +				status =3D "disabled";
> > > > > +			};
> > > >=20
> > > > Why don't we put this into the PCIe controller's node as a referenc=
e to
> > > > that GPIO? Seems like the controller would know exactly when this p=
in
> > > > needs to go high or low, so why does it have to be a hog?
> > > >=20
> > > > Thierry
> > > Are you saying something like 'nvidia,enable-refclk-in'?
> > > I was thinking, since this is like a board level configuration specif=
ic to Jetson-Xavier,
> > > it would suffice to just hog it according to the mode of operation of=
 PCIe controller.
> > > But, I see one advantage of referencing it in the PCIe node (so that =
the driver can configure
> > > it as and when needed) is that one has to be careful just to enable e=
ither PCIe RP or EP
> > > node and not worry about other thing (like this).
> > > Let me know if I got this right.
> >=20
> > Yeah, that's exactly why I think referencing this from the controller
> > and controlling it in the driver is preferable.
> >=20
> > If this is some sort of select signal I think it makes sense to name it
> > "nvidia,refclk-select-gpios" or something. Does this appear in the
> > schematic somewhere? Or does the IP have a name for this? Those are
> > usually good places to look for inspiration on the name because it's
> > what hardware designers will be familiar with and they are technically
> > the ones who should write the DT, even if that's rarely the case.
> Schematic has "PEX_REFCLK_SEL" name.
> I would go with 'nvidia,refclk-select-gpios' and make the change.

It might be worth checking the interface definition of the IP if you
have access to that, since it may be using a different name from the
one that we have in the schematics.

Also, given that other instantiations don't have this, I'm beginning
to wonder if this is perhaps somehow specific to how this is used in
this particular board design. If it is, then I think the nvidia,
prefix would be appropriate. But if this is something that is part of
the IP interface then we can probably drop the prefix since it would
be applicable to non-NVIDIA instantiations as well.

Thierry

>=20
> - Vidya Sagar
> >=20
> > Thierry
> >=20
> > >=20
> > > - Vidya Sagar
> > >=20
> > > >=20
> > > > >    		};
> > > > >    		pwm@c340000 {
> > > > > @@ -144,6 +157,22 @@
> > > > >    			    "p2u-5", "p2u-6", "p2u-7";
> > > > >    	};
> > > > > +	pcie_ep@141a0000 {
> > > > > +		status =3D "disabled";
> > > > > +
> > > > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > > > +
> > > > > +		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1)
> > > > > +					GPIO_ACTIVE_LOW>;
> > > > > +
> > > > > +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> > > > > +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> > > > > +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> > > > > +
> > > > > +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> > > > > +			    "p2u-5", "p2u-6", "p2u-7";
> > > > > +	};
> > > > > +
> > > > >    	fan: fan {
> > > > >    		compatible =3D "pwm-fan";
> > > > >    		pwms =3D <&pwm4 0 45334>;
> > > > > --=20
> > > > > 2.17.1
> > > > >=20
> > >=20
>=20

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3bhLgACgkQ3SOs138+
s6HApQ//e75Pd2TTuRk8Ulcx+orM6hsy/Qq8oquSg3Y2HV/NLxPyy7RnpDOhpDT2
wdR6nr3z4f/90SLR4gyyqmDBqTOlms/sULvoDK79MyBT8aTDVQrvCtAKXONxc9O0
fCYYXz5IMWRSpjRT4EDrZ2Gj7LZcQGJDTRfrqVoauP2VuWQK7FKv/on6k420cA2v
mlgkoI7VwwJNuhNXjZj8EM2NLgfSjmR9HJM/fvJl6J3eO3EGiMorY2PBFAfT0j4H
YFPM0O/lKRH0MiOiOCP/dxtIG17jpr4F1/2yQterNtAEV+o58ERpNT0b8SeSHXMr
yN84gFWN4Fw3CniylVoASwp3xBJAPPBIFUjckLLMf5GJ2r3hZzMj8pGYyav5EwOI
xYOrR1WyMV57D50rLA4Fy0dolQazQETy4OXahwI7T0s0JIgH2gDkh+6fUT3o+5eG
PyFqczNXV2oVoCWrnnqpo1GrHSUwUh3RUoUFvRH0xjKGfaXDGqdRlcP40kktiP9V
tDvv70n6J4+s1uk6Bac1FwTtFz0ecLXG8Ktj2p7oVGKHhEY5kfkdrwJ3p/c7cGlf
JrmseXbCM1CZUsQphVDml+7z5tedqKk/pdTZ6hqClqnyznW9qIR4qNA6IsQOECCB
jSqZ9evt0ALz2r9ndRc/BLxBt2+gcspZ/gFV0c37L0D+HBCE5EQ=
=04cV
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
