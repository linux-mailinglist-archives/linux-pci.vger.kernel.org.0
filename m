Return-Path: <linux-pci+bounces-3699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C06859862
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 19:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736C0281845
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6666EB56;
	Sun, 18 Feb 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="QuM4DklR"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133129401;
	Sun, 18 Feb 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279270; cv=none; b=TrPUwndHvJs+mG0B1Oc4sE2tGMd+HQQ0v2GZIIk5kovWl13ub5oWRrKHU9GqZZ7msnB6AyhZwQvMa5K3I+qgYWuRNbvpq9rDueHSvSxhp4WYIB8eio00sU/tYlUTImv3g+ab8Iup0OTPxuqxj0ZjLi+vqgjlmUMPvPY2jiFfjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279270; c=relaxed/simple;
	bh=B+/6lKwrogpWO25ewC/hiNS4xmBE433AT/5hrUIRSAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp9wWnB4yTvGhIGYshOgtIDVsxHiW8Od3ALat6F7dJ9LHfdKQ/QGHfhW1AH3N/+4di4a0TJRii1RSG38vwOoSoqXnN0sP9V1LoqGg/PyLC9ErVpAwRtMtJqs250FOoJSBhYHjAcwoicrYj1b8CG0vB6GY5ar8vnHpnlX9OWy8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=QuM4DklR; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E86181C006B; Sun, 18 Feb 2024 19:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708279265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quMoPaWpXWCQDD7AudZDFvu9H4YW7qFIGpmJ794No4I=;
	b=QuM4DklRVP3x2VtSXyf29BTnTyqHaMVe89Zy3qbgZokmvI9v8S2GDqpbPsK81gWeVWebP0
	DaYhDiI256UtjI/JCTuwh6pSswonLhipjTCU3El+8RaESDmcy/jvqzL/gzMfuJ6Yizlywv
	4YoaqF7nHUnpXT/ZM6colI4rN8wprJ8=
Date: Sun, 18 Feb 2024 19:01:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 23/28] PCI: dwc: Clean up
 dw_pcie_ep_raise_msi_irq() alignment
Message-ID: <ZdJF4fpSn/0goBqb@duo.ucw.cz>
References: <20240213002235.671934-1-sashal@kernel.org>
 <20240213002235.671934-23-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOSR12Xp1ziJzYR1"
Content-Disposition: inline
In-Reply-To: <20240213002235.671934-23-sashal@kernel.org>


--oOSR12Xp1ziJzYR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Dan Carpenter <dan.carpenter@linaro.org>
>=20
> [ Upstream commit 67057f48df79a3d73683385f521215146861684b ]
>=20
> I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().  The
> code in dw_pcie_ep_raise_msi_irq() is similar, so update it to match, just
> for consistency.  (No effect on runtime, just a cleanup).

Just a cleanup, we don't need it in stable.

Best regards,
									Pavel
								=09
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -528,9 +528,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  		reg =3D ep_func->msi_cap + func_offset + PCI_MSI_DATA_32;
>  		msg_data =3D dw_pcie_readw_dbi(pci, reg);
>  	}
> -	aligned_offset =3D msg_addr_lower & (epc->mem->window.page_size - 1);
> -	msg_addr =3D ((u64)msg_addr_upper) << 32 |
> -			(msg_addr_lower & ~aligned_offset);
> +	msg_addr =3D ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +
> +	aligned_offset =3D msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr =3D ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret =3D dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oOSR12Xp1ziJzYR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJF4QAKCRAw5/Bqldv6
8vf4AJ4o/jGq/kmWV+QMUeG3I4szSZ4hlgCgiBDLYKaidLZEgsXTlmoz+/hUa8o=
=pFQ8
-----END PGP SIGNATURE-----

--oOSR12Xp1ziJzYR1--

