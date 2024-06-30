Return-Path: <linux-pci+bounces-9461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277391D1F7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21007281AB1
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB751474B4;
	Sun, 30 Jun 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEKfl5pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647A7E572;
	Sun, 30 Jun 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756635; cv=none; b=IkXy8itWn5NIVWxLpGGwXIH+Pd4NhpTo+RdOFrXzQ0wNusiMbpJf4+svAQcESS7on860SXhuCMQLTGZJgO7Mp8EkVZpkDE6Jt2o15XLlVVjCyyY4s/P7NLAChJt1DvH14danlbZbCan3HrUaYvPSx5Jv9Gn1xKEG8Z+9Bveso6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756635; c=relaxed/simple;
	bh=dtspAwYzEx4DvtvrzpeF1w+TJrhq8dDK8mk/R4JZVV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi4QewpRRGn5KTBrMPPA4GBjuf3ynzS5V0btHUAqZRWVhCyK/750m2PWHis6BuAl1YmtItw1xh/GIh47BImOXyVums+s7fiqaE9oIIUItUFFdunBUOirpJdJduy+fw+eqOjH5/HSLavCQCUHcJyEXFV0dtUvVizZfkkKLsaIjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEKfl5pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C113C2BD10;
	Sun, 30 Jun 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719756634;
	bh=dtspAwYzEx4DvtvrzpeF1w+TJrhq8dDK8mk/R4JZVV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEKfl5pvor6XMB1i9mZLzeT5v9kSWnKQv5OfaNC1vRP0g6vzFKdRf48C3O7CMYi71
	 3zg9nohBI0CBuSa2QWO9E/zjds0QtujQY7ZzQcZ9ttT+cpBuUE6cON1u1zmAmbP+VC
	 LWVYIAsOcresETeez8sItNbWKsHMtLI6D0LgNQ5OCyR0xCZZRB3ZK4PaBCLhaxJVke
	 HCWfQf3KKamdBMbd72yCM/UPHvQkKP+ADaQgFDM4lDIrIWNK66UThmnlab/M1uQ8Ph
	 m/TkYPS86mJjYLPMii1gXnYZPzMT6RR1un3ozIZQja4F+Hle6EbedgmiEX6jXAGkLp
	 oYGx216M7Y9jg==
Date: Sun, 30 Jun 2024 15:10:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Message-ID: <20240630-regally-gluten-2e4dd445ba0e@spud>
References: <cover.1719668763.git.lorenzo@kernel.org>
 <7622715d622413d1b4d8752657f87ea81001deb9.1719668763.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P6aqo8yz8abeQ6PR"
Content-Disposition: inline
In-Reply-To: <7622715d622413d1b4d8752657f87ea81001deb9.1719668763.git.lorenzo@kernel.org>


--P6aqo8yz8abeQ6PR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 03:51:51PM +0200, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--P6aqo8yz8abeQ6PR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoFnVQAKCRB4tDGHoIJi
0unLAP44wkl3iYFSy4gS4GG6SCbKDB7YlCj4qhjCd70t3mjiEQEA48VH8ZuF1r9d
6rhsNrd4APLPteFcKQ7vn0T8H/99nAQ=
=mN15
-----END PGP SIGNATURE-----

--P6aqo8yz8abeQ6PR--

