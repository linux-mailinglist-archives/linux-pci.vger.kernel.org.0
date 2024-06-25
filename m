Return-Path: <linux-pci+bounces-9248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73874916E15
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 18:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F731C21D00
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE853172BB4;
	Tue, 25 Jun 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkB/j2V2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBA172BB5;
	Tue, 25 Jun 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332801; cv=none; b=jiWLIpAlWlR/pVXyLzrhDqsgJ3i4n4u09q0O/Jtm4GUiVzALU11pnkahLn8wxbm0W5W8CsbeTf57epuWQvCYlF3jPpDov3YkluklAGCO0RFcJaZXoDnlss1JODS4hZ/N8BCPRsfnfHo2hbTLn+JqXBc6UfHAUuBYeqMmf1wRlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332801; c=relaxed/simple;
	bh=k4FmAIrTJcBCRz+b2v73feqo0jByBWdFWEdwWR0gKjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRrBUvKYy4bTpMOr3ZDInUw5Xr0Pm9nVQIKh3PRIVjr4g9XueVxlTMqwR2zXyYsUho5i9ux8sB/MZXyo25coR7TZQX3XKo67JjiDGsJXU5J5pYmH9z4Sf3SNKhPRKAsCaWWiJA0X+UsWNwAh8DcLIsP4ypONh+nrYLHaTFNvr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkB/j2V2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FCEC32781;
	Tue, 25 Jun 2024 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332801;
	bh=k4FmAIrTJcBCRz+b2v73feqo0jByBWdFWEdwWR0gKjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkB/j2V2bOXzEZqM4yTCc1N7D7VxaouKFlBiM74XLTaFihJxLpo9efylmQ7DfyFI0
	 Elzj3g88aQm7az0dEsH/a1P6BRuezr3MEgux7NM5P5o7Pruh3JR1Ams/ayWZ5BUB4/
	 F63DBf3RvAQoJ/SABUy+nRSbGgiORlvWaBycVPsA4XrWqPVASD8IQR3TleVLTUsHgW
	 oEMvudWyi9zK1EVxgfMeATVwnMlGxKlkDf5QetU9MIGCq/VUhdzgtEeXLnlEdc/R0T
	 fLhzpL55DHfP64PXQJQCP7GZ0dyw6MwUqb4RZ6t7ZCAFwYWUyBKjSKc/DAECR3hvez
	 PXKdsLVHxUEsg==
Date: Tue, 25 Jun 2024 17:26:36 +0100
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 2/3] PCI: microchip: Fix inbound address translation
 tables
Message-ID: <20240625-charter-hardcover-36e9a2739cd8@spud>
References: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
 <20240625123845.3747764-3-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DjaEz/ZbS4TcTu5m"
Content-Disposition: inline
In-Reply-To: <20240625123845.3747764-3-daire.mcnamara@microchip.com>


--DjaEz/ZbS4TcTu5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:38:44PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> general purpose Fabric Interface Controller (FIC) buses that encapsulates
> an AXI-S bus. Depending on which FIC(s) the Root Port is connected
> through to CPU space, and what address translation is done by that FIC,
> the Root Port driver's inbound address translation may vary.
>=20
> For all current supported designs and all future expected designs,
> inbound address translation done by a FIC on PolarFire SoC varies
> depending on whether PolarFire SoC in operating in dma-coherent mode or
> dma-noncoherent mode.
>=20
> The setup of the outbound address translation tables in the root port
> driver only needs to handle these two cases.
>=20
> Setup the inbound address translation tables to one of two address
> translations, depending on whether the rootport is marked as dma-coherent=
 or
> dma-noncoherent.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe contro=
ller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--DjaEz/ZbS4TcTu5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvvAAKCRB4tDGHoIJi
0j+MAQDkxF2nwyRlgf9MjhSnnVS8WtmKLlm6bY1IaYNMFB96qgD9Ep4rd4/dRqvj
ICIMqDSrZqRmjvPAfcOsawdwwrcGSgw=
=VsVS
-----END PGP SIGNATURE-----

--DjaEz/ZbS4TcTu5m--

