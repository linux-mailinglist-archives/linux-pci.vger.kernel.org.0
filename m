Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6671314092E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgAQLmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 06:42:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52709 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgAQLmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 06:42:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so7137640wmc.2;
        Fri, 17 Jan 2020 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5bRa/TrI+T0jz4uJXsOxf1Glcjvm4Gca5ZbJGxkiUn0=;
        b=N5giie4sct7jDEwKE6wiVKfWmpXUuWNmuRT6TptwJlTEMACmNzh2FbzxDEntevIENJ
         1YZ08XMgOFoVVyrsv9dzcuWuM/aONtrhRR5W4TMzOVWYiPKm2XNVxCMz9dzYSqN8iklr
         3CHtmxsteTIjKOoOoxxOAsOjugZdAK4VxaDBm4D3/BxNVvm+bZXNjgti/Au+7JRarMiI
         mvJr+XU/b1jkGD5Nu9n/VOhf/313XpP4aawdpzfOrmADwXSKj7FMuZy322XSv4xkyBbr
         CWUSuj0IjulgA5t/+P5uQdfaKLSdTp6SabckFKBm28HcTGf63+5MkhZcPkeZbThTpYWJ
         C4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bRa/TrI+T0jz4uJXsOxf1Glcjvm4Gca5ZbJGxkiUn0=;
        b=Rw8sqM9bQQstoUE2nAyi/se7wi+mAMYC7l8mfosgzZJOQMGxoXcJGUGSH07PlUfDHl
         CRkcx4c53HVJmgqBNMWkwhRscuvqXs000C17yBnUgKF13YIrop4Akn2vn4iR8GbCpC3U
         RJXQEhmVnxEP7/WGVmx3JwqjgZSCy+iy6CXipqIPnIH6PfzZawv4Vm//VQOqvc4k25J/
         JO92C2No79VT2ltSdkPIk8o7DZS11z4Mff3igzxWwobIUZtUpa1SyzuD+ZdZhNuMy7M3
         jbiVpmiKuDbkviQ/Kq6BRucVTXPM0Y7T+jaI7inm/BckfIzEcJkdrSfs54a7S+fXj6Kg
         75rg==
X-Gm-Message-State: APjAAAWpOUckAVIZyncdtWtgiWFsvnJxiIu4etnEONq7WEnzHO0w/PiS
        LcerzN+bRDT9j6AfzEZv7Pg=
X-Google-Smtp-Source: APXvYqxeEkMur2nMs4biGR/BQ8jtFcIeBOJyt0oZHtHCXonp04P2bY6s9HFkZaLWrWZNqn2f19mWTw==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr4087624wml.134.1579261369560;
        Fri, 17 Jan 2020 03:42:49 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id c4sm9039489wml.7.2020.01.17.03.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:42:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:42:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, andrew.murray@arm.com, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200117114247.GA166525@ulmo>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
 <20200110191500.9538-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20200110191500.9538-3-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2020 at 12:45:00AM +0530, Vidya Sagar wrote:
> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> With the current hardware design limitations in place, ECAM can be enabled
> only for one controller (C5 controller to be precise) with bus numbers
> starting from 160 instead of 0. A different approach is taken to avoid th=
is
> abnormal way of enabling ECAM for just one controller but to enable
> configuration space access for all the other controllers. In this approac=
h,
> ops are added through MCFG quirk mechanism which access the configuration
> spaces by dynamically programming iATU (internal AddressTranslation Unit)
> to generate respective configuration accesses just like the way it is
> done in DesignWare core sub-system.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> V3:
> * Removed MCFG address hardcoding in pci_mcfg.c file
> * Started using 'dbi_base' for accessing root port's own config space
> * and using 'config_base' for accessing config space of downstream hierar=
chy
>=20
> V2:
> * Fixed build issues reported by kbuild test bot
>=20
>  drivers/acpi/pci_mcfg.c                    |   7 ++
>  drivers/pci/controller/dwc/Kconfig         |   3 +-
>  drivers/pci/controller/dwc/Makefile        |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>  include/linux/pci-ecam.h                   |   1 +
>  5 files changed, 113 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4hnbUACgkQ3SOs138+
s6HZOhAAnILncAsI0NO4YaCAJyr8nNz9ftnnPp7ihpi/DXe978sztIAM19zmKoJp
wA0zL7ZVnB7apyS9l5/gE2vLHPvjLOSbQUPqg1uNJj13GSQnaEtxjKVVQSnx9aZA
C8ccxXQwOAyiJpASBQsTSxNfdW34vFY7y6gX5pK0wR7gXgeSSBKkFiETgh3LfddG
yqescNSrjVOLk6Mucd1YZuN0JY5Z98+rB22KbGb6tJHh009/QLtfUGQscOcEUUMP
/cyhoOp3EAH7mQMUF2exV1C9EGIJwTtri5MiX7bRV9TttD3cFNakXkh7/+CxsjYj
wCqKYXpLZZxSlyAwpEK8qPEhmd7whtD0io682ymZbKgasvtY0Wyp2gmmuEXWEkdB
e2pWgUcTQ2+wP73Xpd0OS6/tXIPB32ekF7v9GN6gzGoNw6klTSWKE22ttf8BTvHD
JtH1xhXxYw8gpa+lU/WXWz7o4vD+93Blr4Yki1Evo5RHtEIM045+PfN9Di6VppQU
/KvmKo7Njq2rxUy9ZDOhM0nhwbsJpvvr6osTDRH/R7LHg3xv7+gGw9u9NhA2cXdG
7RsrAv7QwwU1ZImZNRdVyrsUk7wo8VhbZ8FwiIns7Dr/Z6AFt9JaxcAc8yWBqQ0z
agWtfFEGWyv9DxXpJtwInejJb0IA/Dj3H+kJ/SYPptT9N/ReMjo=
=iCqM
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
