Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86E12C2D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfECLT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:19:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLT2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:19:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so1689209wrb.2;
        Fri, 03 May 2019 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kznYLKi373KSnxJXDEYDyqZTWv2DWOlCYoAQA1dKIN4=;
        b=FU+THmY/gcswXh6kfdRTql4G69DBYAoMINIRi9/isJM3rQT42NHCyGWxBOFB7XPOil
         PQQA3NgsBdaDERC8fw/2t1Q40vBV8SsxjOW47eKwhfCG4G0DyOnpmC3jDKyiHMUFTWPl
         y/RS+rURUlziaMzPVf+478gxzmAy7/Y0+tu79je1cyE5DYC2TaGJsI1HlgWf7ur01Srr
         tb4TcHZJygypX5g8GHCiUWlq2CVxcgq2grDLC6HPFlauh1pWCjoZTMlrP1UCa9qgO9l8
         yP3ZShn4FRYzvpUu3WwVThp5XbXBDiNRBUzyoH9KOnu4CQlBO3PZm0Z6vHl/0scv0Gu0
         E3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kznYLKi373KSnxJXDEYDyqZTWv2DWOlCYoAQA1dKIN4=;
        b=ecHXq0JTUU7zm45K9MqCpAlNFdBzY8EMUjb23GFLKfc1E1ZFRX5Pq+sfHPnqHox1FW
         pC+vNRHAUDQAzTKPbvn9deJUM6QsT9rpmm42YI0yG1DhzOfBwopMOHlmuJhjT2nPL7z8
         u1bt35B5ZUgyhH8mpxP1c3f2HPAos2aQ3B2erX5A02/r8Zz1x7rwtPa17QGehApSPnlR
         aRKjpUh1IhmPSEbUrMtfKS1D/ndpth3nkfhsWds9OrUIE3Zblf46qV2nI0x+lMSO948s
         oQsDi+ZuowmwMqJ4nbZ3aOXAvuGxs7BqxXm0wjhMwPy2RKq8jlLnEHC63YHK8sopCoCO
         lmsg==
X-Gm-Message-State: APjAAAX/0YkJNdKrbx+04VgGro15yHJ0dyDlLtFRiRtgd8zh1LyjLW20
        MMDnlSCUacIwECpXYVZ5zZk=
X-Google-Smtp-Source: APXvYqxFMF7YNkHtXxqIFuqEy8MLdwT3LvZrCohDAJJRUH1Z2se9pof/X+KXX22J76siKQpKpsS8QQ==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr6909008wrv.224.1556882365330;
        Fri, 03 May 2019 04:19:25 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s7sm1895613wrn.84.2019.05.03.04.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:19:24 -0700 (PDT)
Date:   Fri, 3 May 2019 13:19:23 +0200
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
Subject: Re: [PATCH V5 10/16] dt-bindings: PCI: tegra: Add device tree
 support for T194
Message-ID: <20190503111923.GE32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-11-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-11-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:49:58AM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Using only 'Cx' (x-being controller number) format to represent a contr=
oller
> * Changed to 'value: description' format where applicable
> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
> * Provided more documentation for 'nvidia,init-link-speed' property
> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>=20
> Changes since [v1]:
> * Added documentation for 'power-domains' property
> * Removed 'window1' and 'window2' properties
> * Removed '_clk' and '_rst' from clock and reset names
> * Dropped 'pcie' from phy-names
> * Added entry for BPMP-FW handle
> * Removed offsets for some of the registers and added them in code and wo=
uld be pickedup based on
>   controller ID
> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an option=
al
> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with invert=
ed operation
> * Added more documentation for 'nvidia,update-fc-fixup' property
> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
> * Added '-us' to all properties that represent time in microseconds
> * Moved P2U documentation to a separate file
>=20
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 187 ++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194=
-pcie.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.t=
xt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> new file mode 100644
> index 000000000000..208dff126108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -0,0 +1,187 @@
> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.t=
xt.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> +- device_type: Must be "pci"
> +- power-domains: A phandle to the node that controls power to the respec=
tive
> +  PCIe controller and a specifier name for the PCIe controller. Followin=
g are
> +  the specifiers for the different PCIe controllers
> +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
> +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
> +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> +  these specifiers are defined in
> +  "include/dt-bindings/power/tegra194-powergate.h" file.
> +- reg: A list of physical base address and length for each set of contro=
ller

Perhaps "list of physical base address and length pairs".

> +  registers. Must contain an entry for each entry in the reg-names prope=
rty.
> +- reg-names: Must include the following entries:
> +  "appl": Controller's application logic registers
> +  "config": As per the definition in designware-pcie.txt
> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Ad=
dress
> +             Translation Unit) registers of the PCIe core are made avail=
able
> +             fow SW access.

s/fow/for/

Thierry

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMI7sACgkQ3SOs138+
s6EIIQ/+JneyIE1QInUy25Ht9TxH6uK1NfNwHzcE3w7WQOHSFZ6cCm60usW9tX7y
5bVqKGD/Qk/van6DX4OJbVWqUXSU4kKpCvL6e9ImuJn50qtt+SZCvzn2ITB1RrMY
cx9g/qtQjrRgv9lnezcEBGFGFk0Mr828WkPfzZSIIT2xqJ7Hn+Irp5gvU+6LoDhv
7J3FiCWf08MsSP/GmoTROtgkEl72UkltbhPUNb+YtL/AZd858eXm7ao/zP3mUIO2
f67wTlzzqC1kYJYLERm4DOVlrpPehlz+fp+4QXbKsBovY4qkkRJCW4FM9F9d7Qe9
z5wGlqk7SRZQPNDAVGhZ4XWRjpyiMss72Mqv4FjHU+FQiuney9b/NVu60XtJ0JqA
LMo+JVI8w+5Pqq/n5+5mN9aM/dmmumTyaPZiQ/AASYX7iU8dXe6aKIcgZo+a10LW
X4fezVQ/BlzdHQ72ADFg66g1UkONCAYFaLemAf60OYJQQPKLTy4dAaemtleMoLsF
hbKQng3PJSkG8L33JiMlvGg4N0cIaWx+1ugkMLrjbgrx8z8qceHyc3nrGvBPUyTU
X9srLQMC7WsiahwlWUZPqMewXYPPXFKDg1+ExlLkQi/vSt88iJcu4X+ljt693WmR
GOIY4OkOtmYrcJZEdJLmxCjqTNMkxCRrKjSpv3OEHCigvugwYeo=
=pPtB
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
