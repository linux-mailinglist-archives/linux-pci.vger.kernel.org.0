Return-Path: <linux-pci+bounces-13457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3249849AB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D48285B80
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873181AB6D3;
	Tue, 24 Sep 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCLO4cBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9E13B280;
	Tue, 24 Sep 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195626; cv=none; b=g3gL5pJQ0HNUrGw4ky1ReQXkfT/xoaBtq1b2/68lgriogEkmZLXS55ICBDo6gkzlDquZ4gPaoOwktaA4Mo4NlSocPI2Y48e9O87Ai0iLdVEotMFPWF5WJKDK2a34HWop1cB2PuQZlmw4mq9g8EDS7nWR2l9kdbbw4KWAcCHUeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195626; c=relaxed/simple;
	bh=im7A7yow8LHcqhOnMnmGgEp69ACqYH2/nrnecrPaVy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMppVmQThtJ9D6emPNhLhE/zCTS7TqE8h5JCCui9YpmwaaB/7G+tAELStZELxc/rRVaihMt9jXPfbJbg11m5u3pCL5ko/SaKqqMeGVNK0XuZa0xnblVUB45qOQHNgGRWIJ0AZRToL4giRG+FExLwIIbR7/TX9PioSAe2VAh1ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCLO4cBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02724C4CEC4;
	Tue, 24 Sep 2024 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195625;
	bh=im7A7yow8LHcqhOnMnmGgEp69ACqYH2/nrnecrPaVy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCLO4cBu3o1GJFAgGa8icTxtSwVOdiFa22svmuBQIvUEv7kCT2znddpToIMQEO2Nk
	 pMwXQbOYXWLLklY0e4odH9qHOQhF7klnUxEC/7PWhZL8RqUEnOc99yzjmCBedF0X98
	 hYuKFPmVdwCkqjmz9X4o+voZvhCKtsw9D4f1EujYS8pFnuKGJ5BBreys0BbX5XQqhP
	 5rXFU9f1H/kKSgsnYx7nxKoCyj3J11ymoBYDIes1aI+TOfVoKJ+wkaRlKstgm63oTV
	 wIDYkt6kVJniaYH6cgvjeofuCKaz+rG6yQkVdLf30PpF11Y9XJMAGuN0RSb1vvA2ma
	 r0hvHyGW+OtaQ==
Date: Tue, 24 Sep 2024 17:33:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add
 compatible string fsl,imx8q-pcie-ep
Message-ID: <20240924-map-surgery-8f81b7efcea8@spud>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <20240923-pcie_ep_range-v2-2-78d2ea434d9f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3y7d2X64PbysrMwg"
Content-Disposition: inline
In-Reply-To: <20240923-pcie_ep_range-v2-2-78d2ea434d9f@nxp.com>


--3y7d2X64PbysrMwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 02:59:20PM -0400, Frank Li wrote:
> Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only nee=
ds
> 'dbi' and 'addr_space' because the others are located at default offset.
> The clock-names align Root Complex (RC)'s naming.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3y7d2X64PbysrMwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLp4gAKCRB4tDGHoIJi
0iAbAP9S/lzV5F1/8JrQWTzSn5pO1v/mBvWBN/FkXbEy0oSmzAEAo2IpAiDydqQ2
ImfPbkGvcuZr3ffxQWRTIKjW9YK/OQc=
=zPfx
-----END PGP SIGNATURE-----

--3y7d2X64PbysrMwg--

