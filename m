Return-Path: <linux-pci+bounces-11542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A79094D289
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36E8B21F45
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F5197A87;
	Fri,  9 Aug 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKGYRVSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E8197A61;
	Fri,  9 Aug 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215033; cv=none; b=tNtgPYxNrXwZx8Rc8Qw7rnO1WE3s6fFLxn0h40oiNzXFRjSeSRElt4JI3uGcs3wq5QnffuPVNUKTmkorFkVzuOyg3Qa/pecxVYv7mCOd6TOcLW82+eD5OShpQ5O54TfEIRoOWg8ydHrdxOMgWMRtCuWEHiOF6rLw+r72DyZXetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215033; c=relaxed/simple;
	bh=pusN1guf/ThWaUjlvFs35XIGTaJ+enFcX0AJpzsovP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIYYEWOibMbUGozIugqWDvq8TEVk2TGwv5bL/NRToNbXnV9kEqbZir/Cw2axK3A+QfCM/WMSIRoMhNA4ue68Rf/gC2CrGIVpMrnUwENnVyj+X2+HC3Uvej2mQEngjTS7PsZdIFidpRYEMOXL4aO/2a9Ec70uYOLQ2on9JU7r26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKGYRVSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0643C4AF0D;
	Fri,  9 Aug 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215032;
	bh=pusN1guf/ThWaUjlvFs35XIGTaJ+enFcX0AJpzsovP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKGYRVSa4MR9nKJWQDv08h4p6CcEnfyL1AR6UJd+lM/4+sFC5kiCpatWJ4IFnhr4z
	 yIh0n6//HLK4wlNhivsj8pqO3nrQMJ8JLPC2fQGdbp/ZmQfu/2bdD6jfw0BTAEkrY5
	 sl3aTO/5Ozy5zcAJftQyjVp72NaepNMgNr9IP1THA7XKDXB5qn7f3lIPNVhplkx8ST
	 h1rD/kPpkkDxO4LEj+S4wS+e0QvW4iK+Vk2rKIE7siEQXAb7IAcmitP0LqomEchQT1
	 0OYiTcO98fFhpcJi7X6I2sM5HVunq5cnpFtVWT5Ri60H+JhzW71VRzLxWCBYsXHvc6
	 /otdSh+jvoQlg==
Date: Fri, 9 Aug 2024 15:50:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, thippeswamy.havalige@amd.com,
	linux-arm-kernel@lists.infradead.org, michal.simek@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Message-ID: <20240809-reversal-succulent-d7e320a00b16@spud>
References: <20240809060955.1982335-1-thippesw@amd.com>
 <20240809060955.1982335-2-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GMxCTLc9r8Zvc3a/"
Content-Disposition: inline
In-Reply-To: <20240809060955.1982335-2-thippesw@amd.com>


--GMxCTLc9r8Zvc3a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 11:39:54AM +0530, Thippeswamy Havalige wrote:
> Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
> Bridge.
>=20
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GMxCTLc9r8Zvc3a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYsswAKCRB4tDGHoIJi
0kIFAP49YPFKdJWHltBzcf18htAAOh3hx1gyuFLfZMT4cmK0vAD/TwH08EDBjO5Q
OoERKJarFT/sxYSyWAbGxkl/wW74Mgw=
=WV3o
-----END PGP SIGNATURE-----

--GMxCTLc9r8Zvc3a/--

