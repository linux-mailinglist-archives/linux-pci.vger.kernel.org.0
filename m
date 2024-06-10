Return-Path: <linux-pci+bounces-8529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3A901E8B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E645283C03
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2DA282EA;
	Mon, 10 Jun 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ddLht87l"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC837B;
	Mon, 10 Jun 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012720; cv=none; b=qDo4e1ycS6REDd83bkje4fcqLyEnrl7c1w1nWgPXlldIbYsRXaMJYzkuKmGekavH34OjwcaWLGjuLM+lp1e7pVJY3nv6ZUYgMMM6aj7Ee9tZ9dzlIZxN4M8jz8jI6BzehKNMwf4IVjKMIFO6BpCeJBAzlY0aoRrwfLttVhyNfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012720; c=relaxed/simple;
	bh=n/drKCmK2DXtMTUWF/2XRiruDv+7VQ2JpnwDOThF158=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfMSLvoaHg1pDBmaFh0dlFuOjYt+KGd1/gsozvus9SQdQUcd6FhsDzj0MeezGuXzAJ17xu7zmELFvF4jqqIfB7nlm4bA4yHmyP64vgAwls0WpLZti8gv/RIvLzQXPAYn8G0iabY4loSm3Y+LVhXHwpMW5wZAeN7l8kbOhdbdlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ddLht87l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718012718; x=1749548718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n/drKCmK2DXtMTUWF/2XRiruDv+7VQ2JpnwDOThF158=;
  b=ddLht87lw+lpOp7AAIa/1CMahCjDp67SjgtLlQGzXBI+5efmKwNf25Gt
   Xwi3cLOvKww9+//NNqWCnuzDeUUdLL9gtO7apaeCvnw+SYFQju4z0/8Q/
   pvUg6qjji5ksd1SYwS7ekeJflI5OOYMkWa8rinkMZX3YvDM7fatIgBnMu
   MYR6eYjqc+3JkxOrlDbBrhRWuSZx9ZnLeXYCu+pvvMnYoPFcw3gKc1ZGe
   MJBXhqLAnENQ4Cxoit4te2A/4l7rvodIk1AK9seCeHBjt8+FwQvNOB/ql
   FHRPGUJ4ZGcXv097trxfTGgswnu7zX9ap1vZk8gcQ9h4ZCZ7d6runI+S8
   A==;
X-CSE-ConnectionGUID: V/g+7YycS5WjtxbM+YcRvQ==
X-CSE-MsgGUID: YHLKRFNSSTaea7J20APjJQ==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="asc'?scan'208";a="27194186"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 02:45:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 02:45:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 10 Jun 2024 02:45:11 -0700
Date: Mon, 10 Jun 2024 10:44:54 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Daire McNamara <daire.mcnamara@microchip.com>
CC: <linux-pci@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] PCI: microchip: Fix inbound address translation
 tables
Message-ID: <20240610-pointless-hamstring-908149945428@wendy>
References: <20240531085333.2501399-1-daire.mcnamara@microchip.com>
 <20240531085333.2501399-3-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EA8Ls/LOE2pcxK1c"
Content-Disposition: inline
In-Reply-To: <20240531085333.2501399-3-daire.mcnamara@microchip.com>

--EA8Ls/LOE2pcxK1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 09:53:33AM +0100, Daire McNamara wrote:
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

Since we're talking about dma-noncoherent here, I think this series
should contain a patch that adds the property to the binding for PCIe:

-- >8 --

=46rom af066543b8f8b8b0b37e0844979f0c3e28f30513 Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Mon, 20 Mar 2023 11:02:11 +0000
Subject: [PATCH] dt-bindings: PCI: microchip,pcie-host: allow dma-noncohere=
nt

PolarFire SoC may be configured in a way that requires non-coherent DMA
handling. On RISC-V, buses are coherent by default & the dma-noncoherent
property is required to denote buses or devices that are non-coherent.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml=
 b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 45c14b6e4aa4..2f21109c3580 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -53,6 +53,8 @@ properties:
     items:
       pattern: '^fic[0-3]$'
=20
+  dma-noncoherent: true
+
   interrupts:
     minItems: 1
     items:
--=20
2.43.2



--EA8Ls/LOE2pcxK1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmbLFgAKCRB4tDGHoIJi
0q9RAQCyVWqWGhytWP+kBJ3WzC7JxIAbVulwqmeberwf5qSR8wD+LHH4hf+EDbaf
t9ZYSsB+xhb1P9hBtrQZ60reOFyN5Ac=
=cgf5
-----END PGP SIGNATURE-----

--EA8Ls/LOE2pcxK1c--

