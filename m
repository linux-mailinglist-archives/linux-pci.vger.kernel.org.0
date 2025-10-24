Return-Path: <linux-pci+bounces-39286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E7C07802
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092F421097
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773E340A67;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9xRJITV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338333CE87;
	Fri, 24 Oct 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325710; cv=none; b=Ed8Au7UIKJWMA7RJTf4GZB9/ZTaMWBGxid3DlXcBYijjwUn+x62Tl2fITcoU22iot8vNOXU7CuTsvfATPYCy87u1eDAoto33q1GJ0iSmJP7jPUQIcMf/17hQSXKagTieNOwr2heFYyFUrtqr2Jg9Soye6c3tLzsitS+7+Hcy00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325710; c=relaxed/simple;
	bh=zoo4eTXcpxqPUg9jJBR2rSMNjarWn0onLpixkUMYrVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CotT32EogVCisb1PHKKtnWH12mkRiLPvGiDyCwrHTyQRXWEuO2BtjQKw6C/KKjs82j57kP+tA3PyW9CyJupW8vHStiYqc2fejOS2Phw1TEWnBgqbUjro78iUdTKxLaUP58K+uJ691nYaaC35vCzkB/kVhJvIIWOQJQ7ryCi51Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9xRJITV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B553C4CEF1;
	Fri, 24 Oct 2025 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325709;
	bh=zoo4eTXcpxqPUg9jJBR2rSMNjarWn0onLpixkUMYrVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9xRJITVLQi3CdQ8TAzDwyczSM0AbLIF8iKClAjgyDKqdiG6FVqihbnBIiaDftw9O
	 VvzygZbJOKT1Jls/UpJtZB817EW86WmHpTZtbhKNn/XjOBW/FYbgiCXquHuWYgkKO2
	 KB5a3put2F76BrxyAIbc7WkgwL6PXa8ZqnLmK/uZ4vpf87nnWyLHtDahNTNG3B2q3L
	 ogZWHJ1RO5FDkmIAFfw9unUt5KuEnOfQEH2Pzjm4Fm0cRa+lpsyjhAFueBW7cfmBuz
	 O6PiwQttOXvGNqMi1KD+CjsQflzVJxoPNEqdskjt0V6XXjIGp9aXdhTu33qCIYFvnM
	 8iwd5qBrLLcZA==
Date: Fri, 24 Oct 2025 18:08:24 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: amlogic,axg-pcie: Fix select schema
Message-ID: <20251024-sandbar-idealness-85430a32d45d@spud>
References: <20251024011122.26001-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FKfqgh3MCVX8TkwR"
Content-Disposition: inline
In-Reply-To: <20251024011122.26001-1-robh@kernel.org>


--FKfqgh3MCVX8TkwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 08:11:21PM -0500, Rob Herring (Arm) wrote:
> The amlogic,axg-pcie binding was never enabled as the 'select' schema
> expects a single compatible value, but the binding has a fallback
> compatible. Fix the 'select' by adding a 'contains'. With this, several
> errors in the clock and reset properties are exposed. Some of the names
> aren't defined in the common DWC schema and the order of clocks entries
> doesn't match .dts files.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--FKfqgh3MCVX8TkwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPuyiAAKCRB4tDGHoIJi
0qYaAP910JvL1NlJcbnwmFKCd9O/q7t/2gWDdkjKRt8V/lV5+wEAnmCPyeu4cbp2
U6PTIguv1Fd2Xtt29GmrIWlrb+0NoQ4=
=JSLD
-----END PGP SIGNATURE-----

--FKfqgh3MCVX8TkwR--

