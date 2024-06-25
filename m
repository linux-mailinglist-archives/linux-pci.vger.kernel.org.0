Return-Path: <linux-pci+bounces-9247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C40916E12
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36901F27FAB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBBA175554;
	Tue, 25 Jun 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOSWshGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F731741F6;
	Tue, 25 Jun 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332777; cv=none; b=bi02jcc9tp7mn+tO/LwMIBO7hyuZ9jx37AlR0JyduhumZ27MJETstS1NOkzArq/4ZMM7kLScYMStzcl8QRU/a/uTa3lbcJsiOg0P+p4f5gXpceZcU/Qb9AoeigE6gZbUAgxgLvTKoBa/WttnZJXni6TpKuLDpR+S9AfhqcnS6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332777; c=relaxed/simple;
	bh=NzFJdhpkPkPsPzXdsQO/C4ohQJeIVQhnJ4XDaukByws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK/ZO7d+v53My+MD49ty9bxK4zEqza3S6XuyVI7DdN+K5VYhxdeoLeQIaBM9rJCfOUSDi4CowzHSkHZmNjdtGskEv+EbTnMk//bT0mx2Zhg7FxZ10uNY5HdqM/BsUBgLnFyZNTHu3b1G8pFluEM0LcfHZg350Viak4KT8oZJ9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOSWshGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88757C32781;
	Tue, 25 Jun 2024 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332777;
	bh=NzFJdhpkPkPsPzXdsQO/C4ohQJeIVQhnJ4XDaukByws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOSWshGxvpIGg5W+3uakVVD/UZviTeUUghcGHUKWVmzkIOxsHwJjFZn8ewuoxnF5t
	 CEqLq7BBUwY//+JGrGpAhiGObQyWwiQU4MxzPDYIe/f9uB+58x79Kw7gZAG5jwE6l0
	 QyVckm7pan8+smkCN2ngJK+WDw+gjE5DYT541DO+2TCKaGr8/QbdAodJxHEml8bjUz
	 gDFk69fgHBU289NPaetQcMYd4Q4646u9Sfi5WGKKV0X79XuACiWAzB4HNp9VAP78BG
	 vjTOLe0VgH12YmH8LNpUIOA8Llbj06c2Ca4rSVT4lZLaUpXuAyPYluzrwCcN0VgdF1
	 wngDuMLL/5BnA==
Date: Tue, 25 Jun 2024 17:26:12 +0100
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20240625-length-user-c6c36e36bbeb@spud>
References: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
 <20240625123845.3747764-2-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P6b8YckaqdTiq6l6"
Content-Disposition: inline
In-Reply-To: <20240625123845.3747764-2-daire.mcnamara@microchip.com>


--P6b8YckaqdTiq6l6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:38:43PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> three general-purpose Fabric Interface Controller (FIC) buses that
> encapsulate an AXI-M interface. That FIC is responsible for managing
> the translations of the upper 32-bits of the AXI-M address. On MPFS,
> the Root Port driver needs to take account of that outbound address
> translation done by the parent FIC bus before setting up its own
> outbound address translation tables.  In all cases on MPFS,
> the remaining outbound address translation tables are 32-bit only.
>=20
> Limit the outbound address translation tables to 32-bit only.
>=20
> This necessitates changing a size_t in mc_pcie_setup_window
> to a resource_size_t to avoid a compile error on 32-bit platforms.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe contro=
ller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--P6b8YckaqdTiq6l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvpAAKCRB4tDGHoIJi
0hKTAP95sopi5DgFJu1MLiGcqbgay3iUerfxQhqqMp/GXTD+LQEA0OoeZdHlxGKp
4TxEvb2EORLwww5AnCACQDT0S0Ed5go=
=5PKF
-----END PGP SIGNATURE-----

--P6b8YckaqdTiq6l6--

