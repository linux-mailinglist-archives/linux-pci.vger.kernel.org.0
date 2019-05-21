Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5E24CE6
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfEUKhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:37:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37608 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:37:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so2348268wmo.2;
        Tue, 21 May 2019 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pk9/EDdjZxONgrYI8kAOhGJWxmtEFhA7kOzCkkQmWqI=;
        b=qLQd9mwVZtT+4gIOwW5cnFjudOkGkzk/EjRdPXDv1cdLKRlfES7p5y5G/QZUc8PEsO
         e2837BkCoWNpD15ZBU2Vh/cePuiz7sOKHLQWaYvwK9/23RdR8NtwbzZLS2p8lMUgQ+I6
         VsM7QpxAG4kzLDIuHNaZTuSwf6euSTICBc2vYq8+avBAP9R6xt9fK66oEjOoxVksTx8C
         4m8MJFUXuzWHONm+XZYLpQ70gHpzOXK5Bmv3+MOjQPbnpm+WqCDHLlVbfSMDxb21RLlg
         BFJm3ZWiFJm1aZ14Y8drr82W7UgNWxI5ikF6apGHUuWBaJ52kYB/cOUpqWxKUZ5o/d7k
         p/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pk9/EDdjZxONgrYI8kAOhGJWxmtEFhA7kOzCkkQmWqI=;
        b=PiX+04un2vG5NRKdCU/xyqaAnqiEk8pTVfwF0FbtkshSz2D9pe0YcCfPO3H4g9YQJY
         /5kajPfLEUfe03BIM5Y7WrSC9+xfAir72TkvE4+MDhdj6vBLTGAx8h4FOnmmCyM/b3ZZ
         7otB/GQmN6GWEL5YzAh+PS7ozivH4PuWPwmlDFn7VBj9W9RmkICdJ8r7jehggLzt/5sp
         EJJHYuC/JVUhobxKpiWY718J4Zr/pNAnZOuOHk4gSzqxuV5sGxW6ThTq4wr7m8ugEZFk
         KdtIKiRwdseIxKOmR++gUBazSthfwRW8L/RaSBO+qraMbel0QxGopHJ7Y8VX+f91WUWT
         DT3w==
X-Gm-Message-State: APjAAAVyGaLusWDLAMxFmI1dYy7Kl3eSlf+kSe3sGJ5/DqeIKYSqqnZJ
        xUUI1IcXSMpx5RSCEUqKP1Q=
X-Google-Smtp-Source: APXvYqyUlgdCPheRHL9v7ZLgwsBoKSkVYrYEIyqFLP0XC4W1deVNp6iynS+CfGy17wTGpq5IPR4DAg==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr2734396wmd.98.1558435050841;
        Tue, 21 May 2019 03:37:30 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n63sm2934211wmn.38.2019.05.21.03.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:37:30 -0700 (PDT)
Date:   Tue, 21 May 2019 12:37:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 06/15] dt-bindings: PCI: designware: Add binding for
 CDM register check
Message-ID: <20190521103729.GF29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-7-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:37PM +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) registers check
> for any data corruption. CDM registers include standard PCIe configuration
> space registers, Port Logic registers and iATU and DMA registers.
> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Dat=
abook
> Version 4.90a
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * Changed "enable-cdm-check" to "snps,enable-cdm-check"
>=20
> Changes since [v5]:
> * None
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
> * Added info about Port Logic and DMA registers being part of CDM
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj1OkACgkQ3SOs138+
s6G8OA//Za/2suTnOQbvbpSyc5opGe1KwSkFsUP0RGg8aT54pvHnF+SvsLGd8Omu
Pqo0DCbxzEvfYkmdfEseSR3I60FCNYlMU7L/6OYFkAvpI5fYk8TGwyCssXEXHjwz
1BG7cy4oobxCkoNVwqCSm99hxFmTDj33HOYIDyQPt3mNKT/9pWD+V3AMaMPZ0dgx
wRWX4kvxKl355XimcWwspONm9Sk3PV3LEV4Evvr7otXgaD3nNWpLHdBjqBRQtgoe
ZZh1S7mHtc/kLBaHTXy1RBjHFf2Wkw9z3wm7iV/x8xkqroTkQoNnZV4HPOzHEyq4
xYFprccqToWaaXSVz41pzCRI0SoKELJawKakQFDEZ2wZkWAzeY53ORaJNT+EPYtK
uYo8B6ZBu/ikvmzPx9aMQMCzT3WOSWUkgt9jb02BQpcwI78rRHAhYqb1dqMO1mQJ
TD3UI+GZju6Fftt5Wmp02NKlJwJTgRTZZpJpU/+zcbPyYqJrLb4jYfM491wxR3lV
CGSUHMM9rYKBkgHJ81FFOECLV5CF1lwCQfeFGKpyiqHEUerm7qLeOC4Dq099InQd
rwhv6UwVuEU4Al8w+xK7fAqwkigZwgv13hGOsXDEIGurWptMPyfN4MIR4ya+kH52
8LBpB5J+9mNo/vaCXektWciSu/iOusTkXvnzF5K0rRVtcUnNsBc=
=HI8b
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
