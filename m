Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBB4CBCC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFTKZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:25:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTKZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 06:25:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2422501wrl.9;
        Thu, 20 Jun 2019 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZux+0y6W3wGncScY0sULaLkiLuQXyFaCcmHQcwF3Ek=;
        b=iHK0GxqR8KLeoNT4IpWTYjL1C7r5Jim/Gu0U0xMYHbx28syynq99M64gRdc49CC/7M
         QGPBdZu6pkGDMp1/VyvvHaOFw/+n3Y0qUf4v2gUHkK4Ip+HhM13hiGoHz9OZ2ZJw44jy
         tH+a3kEUX+7x6eS57R0BhzJjtBicbTph3QAdlucBgw7vKhllZvWv4qHw5C3UjJzzmg7k
         +14oAMO2um+xHvMmCM1hCi/fTa3Jd20lGny6f5EXPjTT2Ji2PRd+a/padOOTggiD8Twf
         8z3G9Lzg6VNkmBJ4KRa2O175K8eEr2h9DnKCMBpkwh+3rvhqezf1+OoUFCAFFWKjDYfB
         8LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZux+0y6W3wGncScY0sULaLkiLuQXyFaCcmHQcwF3Ek=;
        b=jNKxzp5bG/+s/brFTOxZ6L4APpL2lVXlGomCV1xf2r+8f4MgV9Zz0anw01axPNWBmJ
         Q5cAZm8JNFre9S67FI9DLfCZKh+C2VLTPgmGy+va/MGwci5r7a6yFHQTseXlizIgNIFs
         38W3Cz/zuFVQoVcB7Yvm+B2IMMCF4UBLsJ+AorlhZAOW1cqptXTmrSyutfJuD14G+X/Z
         Fpw+CyvPtGTX7RylR18jUUP54b8+C2+dSl3OR+s5yWBFvacgZAlbt94Vi8cmm3jBsSDs
         GmXHaQ9I6/aQ0yF15EpmJSFDuv+kRjMjeyvldbqKSfpDh6UmqF8p0bqnrIXihqQZbCNv
         rXkw==
X-Gm-Message-State: APjAAAUqDk5sozOZmojzYHZx37XCJr1TyDmSyd3P5N9wxot+jg79GUy7
        WniF3C2HXNWQFonNuLPvTUnaKAUz1fk=
X-Google-Smtp-Source: APXvYqxl64CuXACy1/N5308HxJq8t3k5eboPGmeDE9ZzreydTMgyOJxjaGjnqlcD4T9RPoOmBaOUGQ==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr38116705wrm.87.1561026354581;
        Thu, 20 Jun 2019 03:25:54 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a64sm7975774wmf.1.2019.06.20.03.25.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:25:53 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:25:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 00/27] Enable Tegra PCIe root port features
Message-ID: <20190620102552.GB28703@ulmo>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 11:31:39PM +0530, Manikanta Maddireddy wrote:
> This series of patches adds,
> - Tegra root port features like Gen2, AER, etc
> - Power and perf optimizations
> - Fixes like "power up sequence", "dev_err prints", etc
>=20
> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platforms.
>=20
> Changes from V5 to V6:
>   - Patch [V4, 20/27]: Replaced pcie_pme_disable_msi() with no_msi quirk
>=20
> Changes from V4 to V5:
>  - Patch [V4, 4/28]: Added blank line before block style comment
>  - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
> patch is dropped
>  - Patch [V4, 27/28]:
> * Updated reset gpio toggle logic to reflect active low usage
> * Replaced kasprintf() with devm_kasprintf()
> * Updated commit message with more information.
>=20
> Changes from V3 to V4:
>  - Patch [V3,27/29] is dropped
>  - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
>    pci-tegra driver instead of of_get_pci* wrapper function defined in
>    Patch [V3,27/29].
>=20
> Manikanta Maddireddy (27):
>   soc/tegra: pmc: Export tegra_powergate_power_on()
>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>   PCI: tegra: Rearrange Tegra PCIe driver functions
>   PCI: tegra: Mask AFI_INTR in runtime suspend
>   PCI: tegra: Fix PCIe host power up sequence
>   PCI: tegra: Add PCIe Gen2 link speed support
>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>   PCI: tegra: Program UPHY electrical settings for Tegra210
>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>   PCI: tegra: Disable AFI dynamic clock gating
>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>   PCI: tegra: Enable PCIe xclk clock clamping
>   PCI: tegra: Increase the deskew retry time
>   PCI: tegra: Add SW fixup for RAW violations
>   PCI: tegra: Update flow control timer frequency in Tegra210
>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
>   PCI: tegra: Disable MSI for Tegra PCIe root port
>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>   arm64: tegra: Add PEX DPD states as pinctrl properties
>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>   PCI: Add DT binding for "reset-gpios" property
>   PCI: tegra: Add support for GPIO based PERST#
>   PCI: tegra: Change link retry log level to debug

Hi Lorenzo, Bjorn,

There's a build-time dependency from the PCI patches on patch 1 of this
series. I've already Acked that, so I think you should take it through
the PCI tree along with the rest of the series.

The only patch that I picked up is the DT change in patch 23, which is
decoupled from the others via DT, though the data that it adds to DT
will be used in patch 24.

Does that sound good to you?

Thierry

>=20
>  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
>  Documentation/devicetree/bindings/pci/pci.txt |   3 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>  drivers/pci/controller/pci-tegra.c            | 578 +++++++++++++++---
>  drivers/pci/quirks.c                          |  39 ++
>  drivers/soc/tegra/pmc.c                       |   1 +
>  6 files changed, 568 insertions(+), 80 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LXy0ACgkQ3SOs138+
s6GtiRAAwFrY3sTpw//mIf0cd83jzuDuxWvqG/UEB4re3vClHiONc/rihLpZi0CY
R5V8Ghe9gsuEQb1ttKobFX/YJ5omW/cXSA3Qc2dy9uQyvMkwcUlpQmfgzaZgl+v2
G6BPqIMLz6/Zb5QeOKH3Dz9XNc1FoZz1mvD7gHdZGeLskAx3Qx9OyMmwLQA1gYSd
rwSPV1uuP2Hpjv3MILNnFKQ/18wdk/fX6Wvnm6GnQAJCw9QywFHer5RvYThFxHrX
oJpUTvCk5I/Z+0CBTOw00hIyV/7Ml4sQPrR4U1TVdBOnPn7HagiWNLkgPxU5KOsP
hG6dvN67x8JuOpazK46UulyDGKUnlndOdRlpPeZDmfN5E6PuOUUIq+O5YjvClIw6
PUg5wDd6eJJAC9U1B8QYIMBFt0EeZ8swYuXaXCE5KY6Ro4VvWW4ll3SMn0TOWjIA
UpX1O9VACuqSXyOGkjA+tuTiSsV0t1mjusvaokEEOTEv0cBOeIi9RG+iYgQDG3l3
hNJEH3I1QA41Hf3mMZuef9AEZl/FuWfpN792KN48cxM14RxuwjuwFA+z0Z1zHjqb
s6ardenJPxEzXzW27x6GA4EcTCuu1Letun+5ew+D9FaefDlSkuM4eFV8ifxVDLFp
Yf/iGDZhrkalTfoBUOs9E7AtAhSdF7n10rXRJ6mU/6EJw70OaqU=
=Pbxk
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
