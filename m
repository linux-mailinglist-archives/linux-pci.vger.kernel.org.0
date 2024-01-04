Return-Path: <linux-pci+bounces-1680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637B8244AC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DE62832B2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836842377A;
	Thu,  4 Jan 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4ChAmfhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D223777;
	Thu,  4 Jan 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704381071;
	bh=xGey7Z1qQaWQnT1BT1OSgP8+WbNEdnTjqtNlvMAYTEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4ChAmfhZHGzmTHDk6ZhIvFJl79kIFmstiFicB1/eDtYeGIx3/Zyku422RNxzoscnw
	 mUHMHLqiSDOZuuNdOq2ivfS2/AEjy63PRhlBp49i+/awtqVt7NnKRVR3dqsqDbLJUX
	 BaGU/dDvtrNjPkeXW1nqJhbcqHZT8tdvKXFWDBjsCf/FBm3CabECr2ROE/nizIXXJO
	 WYOz4TxONG4A3t/1r7yuwhU8dhr20SitlxiDOQ+LvgTQ281EKSqxI/U0G8AF81LkxS
	 QsGTLwnkP+UWvg7sHK1thLiI5Zn20h/9W5S3cByXFxOSkq6+h3ceT957q4IByomHCO
	 8WpwGMPLmjpRw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F9C2378200D;
	Thu,  4 Jan 2024 15:11:11 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 1ADFC106062F; Thu,  4 Jan 2024 16:11:11 +0100 (CET)
Date: Thu, 4 Jan 2024 16:11:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	=?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe
 devices
Message-ID: <tfnmgogvqd6crvsv4gal5tndgcj5ee5il5fpfpipfb3zv2vmyr@c42zfar6nvar>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cy6uey62v4nbmwrk"
Content-Disposition: inline
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>


--cy6uey62v4nbmwrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 04, 2024 at 02:01:14PM +0100, Bartosz Golaszewski wrote:
> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
>=20
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
>=20
> After some additional brain-storming with Manivannan and the realization
> that the DT maintainers won't like adding any "fake" nodes not
> representing actual devices, we decided to reuse the existing
> infrastructure provided by the PCIe port drivers.
>=20
> The general idea is to instantiate platform devices for child nodes of
> the PCIe port DT node. For those nodes for which a power-sequencing
> driver exists, we bind it and let it probe. The driver then triggers a
> rescan of the PCI bus with the aim of detecting the now powered-on
> device. The device will consume the same DT node as the platform,
> power-sequencing device. We use device links to make the latter become
> the parent of the former.
>=20
> The main advantage of this approach is not modifying the existing DT in
> any way and especially not adding any "fake" platform devices.

I recently ran into this issue on a Rockchip platform using a PCIe
based AP6275P WLAN device (broadcom based). As far as I can tell your
proposal should also work for that one (obviously using a different
pwrseq driver).

-- Sebastian

> Bartosz Golaszewski (9):
>   arm64: dts: qcom: sm8250: describe the PCIe port
>   arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
>   PCI/portdrv: create platform devices for child OF nodes
>   PCI: hold the rescan mutex when scanning for the first time
>   PCI/pwrseq: add pwrseq core code
>   dt-bindings: vendor-prefixes: add a PCI prefix for Qualcomm Atheros
>   dt-bindings: wireless: ath11k: describe QCA6390
>   PCI/pwrseq: add a pwrseq driver for QCA6390
>   arm64: defconfig: enable the PCIe power sequencing for QCA6390
>=20
>  .../net/wireless/qcom,ath11k-pci.yaml         |  14 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   1 +
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  24 +++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
>  arch/arm64/configs/defconfig                  |   2 +
>  drivers/pci/pcie/Kconfig                      |   2 +
>  drivers/pci/pcie/Makefile                     |   2 +
>  drivers/pci/pcie/portdrv.c                    |   3 +-
>  drivers/pci/pcie/pwrseq/Kconfig               |  19 ++
>  drivers/pci/pcie/pwrseq/Makefile              |   4 +
>  drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c | 197 ++++++++++++++++++
>  drivers/pci/pcie/pwrseq/pwrseq.c              |  83 ++++++++
>  drivers/pci/probe.c                           |   2 +
>  include/linux/pcie-pwrseq.h                   |  24 +++
>  14 files changed, 386 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/pwrseq/Kconfig
>  create mode 100644 drivers/pci/pcie/pwrseq/Makefile
>  create mode 100644 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c
>  create mode 100644 drivers/pci/pcie/pwrseq/pwrseq.c
>  create mode 100644 include/linux/pcie-pwrseq.h
>=20
> --=20
> 2.40.1
>=20
>=20

--cy6uey62v4nbmwrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWWyn8ACgkQ2O7X88g7
+pqYEA/7BHxRVVJzOzyU8+oTZ3jVVPdgfWWRB+8eVAxg6+O3OKc31B9UlAXlEVHU
BLYObChFlR8wfoA88johSDUjE2GGCTNeC0oDA12GVCdP0RzosAdmnW24uv8IdJvH
471Kw2n08jnMrzh32HnnehetOZIoF3vORkxkLpH26pZVayzGA8CCq8XI45S16Pfx
IbiZ3nYuJM0LB7rxj1R9aR9uL3MzH+rCBBKqcbtKJTAvkLkvHhTrFWPhIIm4+Fwh
anIwi8jhwxHeZ4cQKEuxJF0PzpnXQnUhAj1kUaoUSj6G5ffmJo6pyEgNSXqpoizU
qAtWaa5zHClBwgEdqjJqMaaXZK7yDFkSekTsKciZeqZzZW476i3ZefIendZSitNT
IcAVHwGvL+XuI2y2WpET9dtx+Ij+R1FSmk+6HIn24BFu3GV3KaG2+thgfF1J2l0y
lV76WK3vQDSshWC+9p9f72Ug+h9Wi1UIWBXyLPuA17NjD/v+RG9YV4IntjaHHBZk
5SjzHrrqyHjIn+s16JU0XH2Wt9oFl+gnPJlhLvx3HdHdNYCCVjR+37T55SERvMlH
KHWcCk+9qWRJnTdDtkE97T1TWxd803PU6a/pzK/u/m4Hf7/CBnrZmbxQnP7jq/pF
dm0V0duiFUCn/HckPL1VLuF8IUuSlGTKSj7ypDRR7O8On0KxghE=
=kqNZ
-----END PGP SIGNATURE-----

--cy6uey62v4nbmwrk--

