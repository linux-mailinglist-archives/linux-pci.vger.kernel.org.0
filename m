Return-Path: <linux-pci+bounces-1679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE08824442
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C31F286C74
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F242375F;
	Thu,  4 Jan 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1U7QDAes"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070523759;
	Thu,  4 Jan 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704380342;
	bh=KDp1KlxW4ztxSeOSFhN1rEoylXsyLJ5JvkhJpgJgJnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1U7QDAesD642Grt4u1zAfoqQt6hKMbSTMEJ88MrJmPD9TQmpuQLQgsmdPiKZ2WRLl
	 ISAUdMUyuuarEOF0rXNiYySX4DaXGudcUkVSnKsS0vKtv/Y1q89i0WNrGjfRymA+4I
	 OFvzMPYBhBLIKlXlMc00snMWVlF3h/FzUQi6O0kc4Odcm4W/ALnLDK89d2Ln523yN7
	 JLLr0+3yO6rnvF0G9p9lcOJjH6dyjYL0xqV8yXdSmkTxrdzSVCENaMqL0V8niycSOM
	 i1MUcBnVBUINqa5vsU/Ozp9P15YD2XngxAYpfvYQyhqubeEno1GgfOQQjaCwN06osR
	 1rmCzbcfMMz3w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79B0A378200D;
	Thu,  4 Jan 2024 14:59:02 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 69A7D106062F; Thu,  4 Jan 2024 15:49:21 +0100 (CET)
Date: Thu, 4 Jan 2024 15:49:21 +0100
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
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
Message-ID: <rhs5bzjx3cljxa6xhlzlozmgi44tbohsqnznjhr3piz7ekv3ra@mi6yiljza5oe>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-7-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsminobfkp6hba2d"
Content-Disposition: inline
In-Reply-To: <20240104130123.37115-7-brgl@bgdev.pl>


--jsminobfkp6hba2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Document the PCI vendor prefix for Qualcomm Atheros so that we can
> define the QCA PCI devices on device tree.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 2dc098b39234..297d6037cd12 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1128,6 +1128,7 @@ patternProperties:
>    "^purism,.*":
>      description: Purism, SPC
>    "^qca,.*":
> +  "^pci17cb,.*":

I don't think it's a good idea to list all the PCI vendor IDs
in vendor-prefixes.yaml. To please the tooling, I suggest to
have a generic entry instead. Something like this (untested):

"^pci[0-9a-f][0-9a-f][0-9a-f][0-9a-f],.*":
  description: PCI SIG Vendor ID

Note, that we we already have a bunch of them:

grep -ho 'pci[0-9a-f][0-9a-f][0-9a-f][0-9a-f],' **/*.dts* | sort | uniq -c
     70 pci0014,
      3 pci10b5,
      1 pci10ee,
      6 pci14e4,
      1 pci16c3,
      2 pci17a0,
      1 pci17cb,
      1 pci1b4b,
     63 pci8086,

Greetings,

-- Sebastian

>      description: Qualcomm Atheros, Inc.
>    "^qcom,.*":
>      description: Qualcomm Technologies, Inc
> --=20
> 2.40.1
>=20
>=20

--jsminobfkp6hba2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWWxWEACgkQ2O7X88g7
+pq9NBAAoxlfauETIkIrDgJNle3ZizR1pfBMZu2EGdroqNk8sONiP9ITABAB3GtY
TeGTr1dYr+gq+Vj8n+BqThMbvUCJdrO8KXgUt/bFQm2IJvHkTUzskAv1gHybmS0Z
/1qQWzRz2KDoy6I6Is3GDnhlrgSoUlHqfkSj9OP4fAyZ4rCg/RIS+l1BE3qrft6X
DdkWV5BsmvG+tEAJ0e8FILIv1igb2DU2zdakioYpsftC4eDsOHYI90q1zuMjDWLY
3HhOX3MvAZnyMYgzKn+i2EJMdUtIOdg1oAr2ZGRghiCQ5WZjzZjXPWPi+WOkY8t3
g7/0jD8/4IxncHHxai+zhfOxwXhPPSRtiLMOEg6oDM5CQsfdeC14k3iznXZygr+X
8wZ1GTuz0srs87MZ/n9wolg0ZdBvuwymoO5BU3jptSJ+wR2Xte4uERJgoxbZAlmB
m9J7qI++us6b8zH2Az2wAce1Lb0j5FtPZ1oXW22+QNbMzyneQJGuB/5gFR6/iJBC
th648oqH0zRgsWEIPgexNXCxBRZt3HDb2xD7//3c9TEwvJg2C0n3qr+KqQKuuC31
NjcIt698FfE7izgbv9goadO9cmCMnxxam0YvQaPO2LRlB376Tv9gdbwybCL4pWvl
G3MWmmmGzLDU55WxS9x3FD4yO69M0LHnXHfjLal9y+7oCMZC24w=
=qTtZ
-----END PGP SIGNATURE-----

--jsminobfkp6hba2d--

