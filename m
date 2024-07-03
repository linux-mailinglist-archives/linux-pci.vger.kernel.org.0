Return-Path: <linux-pci+bounces-9734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623D92654E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120362815D0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6A17FAB6;
	Wed,  3 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE6bLjhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2917B41D;
	Wed,  3 Jul 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021927; cv=none; b=GtWvtiaMsF6QMcWXpuGOeg8TwUCdERYas544qiqIp9OYChHllP8q2LvkuYrYaS0ClfDfKp+2dXVw2mkbbkqdZ2MZgLhHj7es0IuXqTT2OLH4DvsT3ljBvRA6btP1xNDr22Jk+1fOZLLyVDN7YmX0x0OFxQ3fSpmnep+4T65/fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021927; c=relaxed/simple;
	bh=/yCkUofFPT4wSnnQdmpkYkkfdsE6MzFP3xE5fPk4qIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eICoWPCRBq2wKoOmN+ET1/eh8lcN3BMF3RfszgN8DQcJO9uubDjr7nMxO1fkkaAQkGVgKkDIpQk6/SfHyBGfRagCK2542ihSkB2qf+0wu1hnTmAjtYyDN4e69rbO4LLaaXa89az1oS/K4sWzYcgZZ7TM2dUG6rXEX7mm8/yqSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE6bLjhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A14C32781;
	Wed,  3 Jul 2024 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021927;
	bh=/yCkUofFPT4wSnnQdmpkYkkfdsE6MzFP3xE5fPk4qIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE6bLjhghM7LVP3TbEAu5BGc1y25KPEeKeZeKEpa86Vbd5EnIgNNKBdVOQNj6Alfp
	 fXrscok1QXbx6lLhb096nI+ZNLKqZoYZdxwyAtbo9b2KSrq42gOXpvD0V9e0GvA7lQ
	 1VS+RCAyx+bkMbq0qmtfnfIK9YaOmWF5TgO9Gg3R0hnV+7TXijgNrUl7p/Dx9hmK/J
	 9/CsMW8Q9udc0hemKohwN3au95E8LuwYiE/1x1wv2lKTxUU63Ee8ArdDb4QXKNm126
	 XGPwBIzObfu4ZJ+iDsw+OBhN1dqCLLQvc5ex0ASH4uHUm/2H6h+qmpt5980/qTFFnj
	 NY21aeqSX5z1Q==
Date: Wed, 3 Jul 2024 16:52:01 +0100
From: Conor Dooley <conor@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240703-blitz-impotent-d1b7dd558e6c@spud>
References: <20240702162652.1349121-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Etau8ZmxP2rHtEjz"
Content-Disposition: inline
In-Reply-To: <20240702162652.1349121-1-matthew.gerlach@linux.intel.com>


--Etau8ZmxP2rHtEjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:26:52AM -0500, matthew.gerlach@linux.intel.com w=
rote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML. Update the entries in the interrupt-map field to have
> the correct number of address cells for the interrupt parent.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v8:
>  - Precisely constrain the number of items for reg and reg-names properti=
es.
>    Constrain maxItems to 2 for altr,pcie-root-port-1.0.
>    Constrain minItems to 3 for altr,pcie-root-port-2.0.

Thanks for the update,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Etau8ZmxP2rHtEjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVzoQAKCRB4tDGHoIJi
0nWLAQDFOZUw6SwwMqRix74tqNYORYUVqRS9voDoLJ+oSPPnTwD8Do7g5JyQy3ka
HoYJawRCEJnkPDHvkf8jxNFEQvQiVAQ=
=p/4t
-----END PGP SIGNATURE-----

--Etau8ZmxP2rHtEjz--

