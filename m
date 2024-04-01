Return-Path: <linux-pci+bounces-5477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7B893A4B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 12:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0234B1F22385
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C351CA8F;
	Mon,  1 Apr 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQfWYBBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CD1CD14;
	Mon,  1 Apr 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968390; cv=none; b=re+SksTrc+1MDeNEs4KVAlUBsywUklgfXCLeFDPAr923mHBC4kT6BFzERYDzq28L8L8SqHq4yYYF2ZtP9hrLVb89160aYIGuDpRBBN89GPS8AFwodEevHS783oNoIBqrSi/Q5NH7PMBE8j1I85SouohhIccaFx9sOC0Q99Ebt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968390; c=relaxed/simple;
	bh=a2WtB0xmwYiuyFKbZJQ/GO/AdCnqXgqBpGtmMe1gRPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDJMe8Hc/ZZDdcUnJyH5V/CjbI0LFVaGmqTFtx6aTOxg2CWCU2b/aAwx/zztZp3jtwv0Q3eASyFXNUx2QwrVwHHPI0V8M1DaELfMfUla4SekgtrFEp5u6xqwXa1FXCoHR6XbQAIMHAHLN16vTswBPh5tFoXNOFksYAV3B26/F+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQfWYBBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AE5C433F1;
	Mon,  1 Apr 2024 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711968389;
	bh=a2WtB0xmwYiuyFKbZJQ/GO/AdCnqXgqBpGtmMe1gRPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQfWYBBFzaLYXE7DeTkiqLBkfo6HAHbqV8fN5MJuFoZ4tnCOly8RDrQiXqJ4lFW72
	 2vH/i3MuU3ixylhRKBQGXBeEvxQfb3HzqfIfi7ypEWB5kG672tXR6S0JXIcAg4bJ+X
	 doVzlxVhgryHJFaLGN/XoypfjZ5retg+l3Rq4Yk2jY3sPvovt0qZyZdv6HGHfJRY1u
	 v4uX1xrLmvV6PQo+FW6+EqsNF5tyyal5gDaaDxkUnsjEgFqoMAgqyVoF80fY21X3p3
	 Z2p3uW1MG561hLNqZ+zwVJ5HxUWvtj8KkdptvVRNkPNEUV8KP/AkO46mnO3N2iLCIN
	 ubCI4hNhZB0Xg==
Date: Mon, 1 Apr 2024 11:46:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rockchip,rk3399-pcie: add missing
 maxItems to ep-gpios
Message-ID: <20240401-sarcastic-polka-81ca81834df9@spud>
References: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u7S0YdhFapcdCqCC"
Content-Disposition: inline
In-Reply-To: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>


--u7S0YdhFapcdCqCC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 12:00:58PM +0200, Krzysztof Kozlowski wrote:
> Properties with GPIOs should define number of actual GPIOs, so add
> missing maxItems to ep-gpios.  Otherwise multiple GPIOs could be
> provided which is not a true hardware description.
>=20
> Fixes: aa222f9311e1 ("dt-bindings: PCI: Convert Rockchip RK3399 PCIe to D=
T schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--u7S0YdhFapcdCqCC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgqQgAAKCRB4tDGHoIJi
0irkAPwOsdu8M3R5EyKevxY92LnAR66NRpxZx3MMNUD+tVGVnQD8D3TuY38mYuNa
AeXjIBpXUtGDUwlr4Ch10HFNdOcndQ4=
=HnPg
-----END PGP SIGNATURE-----

--u7S0YdhFapcdCqCC--

