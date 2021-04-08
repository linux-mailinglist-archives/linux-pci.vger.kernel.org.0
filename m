Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7206B35842D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhDHNIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhDHNIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:08:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEECC061760;
        Thu,  8 Apr 2021 06:08:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g17so1578164edm.6;
        Thu, 08 Apr 2021 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WIBIWOo8apG9ddLlhlBzlg0yeSuaxKcxX7ey+nx5/6U=;
        b=DyVt/nwc7lzfneKRuoh1IWl2CpEYa4NncpokIOFpqNPqK52pYjJ2zSRMSdSp8jpSU+
         xaugh6DAp5cDXeXL5EvmvAFyROtmBiZ8s2Ckd6kSV6XtbgDMTQdHlstOKiYSwo8hYPnB
         xiVnrWEYD7s9S/U3ue6GiZsKhYv5s3Y57wcz1yGxgseg0KFiaGVyFMagPVGxFYQgqMCn
         n6PY0Qigek0gIlioMTInsZZ2/6sRTjPbIMd/LLOFnSbIRFc5IUxcTHXNCatjTvklrsPz
         qOdDaZuT1pddrcXlVLzIp7nrd2UNAKffeSFMCPOqlNC7FO987bqdJwR6E6ZbGXQC1ntb
         K5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WIBIWOo8apG9ddLlhlBzlg0yeSuaxKcxX7ey+nx5/6U=;
        b=hS9oNhlhFamb6yKC2cLXIO0RJexAs+o19UyaUgnh+GJIjHTCSb83aAdeZ0+hP+zGhQ
         NC0YO6wtZtYoZUEj1a4LIZ4WR25caxw07kx5eXmdEKXrPjFTnYCob3OgCOSb/i217yfT
         E0In8v5a2T2/xYgTRnA6YKV5iBLYDLPFPn5vjcQmHOINeqqVLo1DeARsyS2+haKL70kE
         P0f9qgOXfFzVHMx+pTuMj+/j76O2WoFu+nHvNxwPXTTvRZa+TRwfVFYnDrIBSkkrcM0L
         d++tQl5Xv/bgQPF6I+goY+qyUVvSF2WUljPjr1ist7k5Au/AZlOHESrU/4tpfFCxo1Mh
         ICAQ==
X-Gm-Message-State: AOAM532YtHzewoZxmpaxHf1xDkwv/I6LkXUZDwrqjFBiZsOLBpuHUMzi
        Xu89TbBybnT6UqqVOYDfETc=
X-Google-Smtp-Source: ABdhPJyjOGsA8X+5x7R1E2trYQdAOPY3+FcpZyf2e05VHBHgno3DZvPfwz9vvCLcZ975C91Bz5RQXA==
X-Received: by 2002:a50:a699:: with SMTP id e25mr11187259edc.276.1617887312388;
        Thu, 08 Apr 2021 06:08:32 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p2sm2270741ejo.108.2021.04.08.06.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:08:30 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:09:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix runtime PM imbalance in
 pex_ep_event_pex_rst_deassert
Message-ID: <YG8AcAJKVC1kFe0n@orome.fritz.box>
References: <20210408072700.15791-1-dinghao.liu@zju.edu.cn>
 <11feff02-c466-5296-b4c3-85754c755c9a@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uh3Y8H3LtYjscocq"
Content-Disposition: inline
In-Reply-To: <11feff02-c466-5296-b4c3-85754c755c9a@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--uh3Y8H3LtYjscocq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 01:34:37PM +0100, Jon Hunter wrote:
>=20
> On 08/04/2021 08:26, Dinghao Liu wrote:
> > pm_runtime_get_sync() will increase the runtime PM counter
> > even it returns an error. Thus a pairing decrement is needed
> > to prevent refcount leak. Fix this by replacing this API with
> > pm_runtime_resume_and_get(), which will not change the runtime
> > PM counter on error.
> >=20
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/c=
ontroller/dwc/pcie-tegra194.c
> > index 6fa216e52d14..0e94190ca4e8 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1645,7 +1645,7 @@ static void pex_ep_event_pex_rst_deassert(struct =
tegra_pcie_dw *pcie)
> >  	if (pcie->ep_state =3D=3D EP_STATE_ENABLED)
> >  		return;
> > =20
> > -	ret =3D pm_runtime_get_sync(dev);
> > +	ret =3D pm_runtime_resume_and_get(dev);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
> >  			ret);
> >=20
>=20
> There are two places in the driver where pm_runtime_get_sync() is called.

It looks like the second callsite has the proper cleanup code. Although
it might be nice to use pm_runtime_resume_and_get() there as well, and
adjust the cleanup path, to make this consistent.

In any case, this looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--uh3Y8H3LtYjscocq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBvAHAACgkQ3SOs138+
s6F+TBAAq8m3qLpGGA3hd/etkHJxjbIjZZTLTIlMHSDIGozQ2o9mcmv3gDnMODUx
uS9O24Jydq0u9RYu8mcET24XRHNP1UvypmAWD3+cfwAsIaNqRYafeaxJyQdhgjFC
8SlIFzU08hyFaCJ0YqszLbcfUvvQof8k6PDtB3CK3CnIWJi4hVKhJ19ykd9b9BNI
+JZO7dYp294qDhlRkum8JsXtiZKtf7wXJnTLtVI3g0wl8cWFXQ97LZJp/a4c+eJm
Rev4kKnGSgxfv0AduzqPN+sjO325kVluhyOcRpC5vNEvCOjuq4QwX1n1Qagr/cUt
rDskxTsKqAtxU5QAJnJzBDDCUDiBw4cq6nw7JOzvZXqrtS+33nLVk9seKRxduSNg
D8f3T0zm2qXorzvIVnNaCsU44c/ljhcsrOf+sOTVvGWx69Fsebs9nWypoHYBYHPb
EkWx+/EEqbRoJhc63az1cDN8M5wKqqOVpMFMWVtVocPe7HvyDvwYJBXoz/RVVR40
qsRBxE/FXJB6m/rQO4Mdo1/RWyLIK1A48hrY+c9EGjXuc3Fo/Z4nXNuKLBtmEb5F
bDwU777xh67kidoW2qhRj9btKRB6boWu9xrdr5KzUbrO2ryok5B3G1cxl6r00u5l
mRQcT3is+Ec5nXvUwLPgFS8H0SfjWJ0siOUmFKzoqyRXk61Ee3I=
=2wcw
-----END PGP SIGNATURE-----

--uh3Y8H3LtYjscocq--
