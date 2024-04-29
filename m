Return-Path: <linux-pci+bounces-6791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588C8B5CDE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FAA1F21873
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242912DDB0;
	Mon, 29 Apr 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5QnIuR4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FE12C486;
	Mon, 29 Apr 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403124; cv=none; b=YOuvXcj+HpkRUYuGAqIJWnLNZZxDQgz9WwyhdowYCRfQc12rSo/S1i252unyWCCNIh5KX92qXfRqirtcDZBAwpujhu2dO072lsAVD3ot6ofT9WRLX61gR79ywduHfoev6ZGgSekzKnet7hGSbMETddaKY1JeG3jJkiu1axP307g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403124; c=relaxed/simple;
	bh=Czf3Qf2QtCITmmu5rDJ793XRKMMcRoe9FeUXQg11vmg=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GvdFRXNMGT5keEagp1pO/BAFfZow5CMRCnRvrfyorrzmP3vCynpzS28wAVrTDiCrwGd3BrsEjGmHTgFmMeVyBWPaHQHMWgcDUdV2/8ajrNDU5fLudf2HHlwKVdUlCsYv/d+kM54zpRbYjNkqrZCJrR4rR7AhDS+UXHCg0oBj8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5QnIuR4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a58872c07d8so993262066b.0;
        Mon, 29 Apr 2024 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714403111; x=1715007911; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jRLnMQt74RAYZqrOQceAPqjFBeZeSYFo8RlZsGguPTo=;
        b=c5QnIuR4QKxXnvtsRuLbK1ZnEoYXLeA5u28rib1jtJB+7N9tQR457iR+eYRk/SZn65
         EwvFe+s/C5yyMKltlXbkiDZko8ujo+AGw0VDM6LKfd4dlV4Ks/zCt/SkSGjQbZEoLq75
         VHeqxmloZ8eGb1XIkQnuQ9abcmCqDRXwDyBeJKNBZih/kgCNBaduCKtnvRGqF+JesHG2
         bwTs7105vhkGci/Npf6Xtmd167FROCvMRd/Kw1X23JT6KGvJLDEYTqFQI2jcBz6NgdWc
         rN546iDuNBjVdvLQsKq3O5SR96AoJ6aS1noT7sDFPwEa9MhdjYf+vTRoAnPVbwMtm2/g
         +TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403111; x=1715007911;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRLnMQt74RAYZqrOQceAPqjFBeZeSYFo8RlZsGguPTo=;
        b=dzMcSstCA0COs7xVhEsnReTh3veQsahdpBydKyvIuwboih2Ge0czga3UzJGHWbUIFF
         rdc4NVPFI9LLoVxwvkrWupDo10URgVJ8eyVE1+cYv3km4yAgosZOHtoVSxXYIE8xf5xM
         LcYfNvp1OBvyM5qZG4816lLDsEDfaiTxMBVeXMsEZ35ihfUq/BmaZOB0YxMIzZaXJOfz
         4O0BdHHEEiPlX+zvwNmiwa95+Cj4MPCTuEcMvb0Xz7XIz9LT3yMM6wdDmv4Kh19rFxUo
         69QjCdN8B2bmh2tAFO07RAWyjlNoV2fPJfiu4Bu+E5tfEMUWtQNFH0ei+mNwtsTz4L0R
         Kd2A==
X-Forwarded-Encrypted: i=1; AJvYcCWhMDp5muKCra3WSnRl7WGlGwVNqj0XVv6vkYMJN+NGiScGVXtHjKpXZO1vDE64a5yHyr/NQ5Vu1Deo8zRdfKz3DMZ4EGgtHIE/uN3ro84ib3QyMk6a59QTJimDL4CCRJHrB3fnkWSZ5Hp5y76h/WbMtyvlV3OycotC0WxusIQG6FveaWHLu8rZn55Fwq/xXhzt4+s18Ax4153HgvvG5R0R
X-Gm-Message-State: AOJu0YzceG2hk4SVz3sU1KM6E6asmMFHFn5YZrUYcbLNVKhrcsLqyuIf
	NJtg/b6iOm8OABYr7kaBVOCIHe0BRG44yoiUcw6vm6I5c8JjuhQJ
X-Google-Smtp-Source: AGHT+IEhcxyiDkn4etHYTk4Ajtaz+3EvULJi9TZG7CDYngTG1q+F7q123kJC9XMpFvy8FUWZaxjBUg==
X-Received: by 2002:a17:906:c111:b0:a58:eb9a:420d with SMTP id do17-20020a170906c11100b00a58eb9a420dmr6898891ejc.17.1714403111239;
        Mon, 29 Apr 2024 08:05:11 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906380500b00a58f36e5fecsm2350418ejc.67.2024.04.29.08.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:05:10 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=64d8f73e5566f44c66d078f5487c89221898d7d8af4e7f37e5a21c35e662;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 29 Apr 2024 17:05:10 +0200
Message-Id: <D0WP6K0OPG1U.3B8RHWV50GB9W@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bharat Kumar Gogada" <bharat.kumar.gogada@amd.com>, "Michal Simek"
 <michal.simek@amd.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Jonathan Hunter" <jonathanh@nvidia.com>
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-phy@lists.infradead.org>,
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop unnecessary quotes on keys
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240426202239.2837516-1-robh@kernel.org>
In-Reply-To: <20240426202239.2837516-1-robh@kernel.org>

--64d8f73e5566f44c66d078f5487c89221898d7d8af4e7f37e5a21c35e662
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 26, 2024 at 10:22 PM CEST, Rob Herring (Arm) wrote:
> The yamllint quoted-strings check wasn't checking keys for quotes, but
> support for checking keys was added in 1.34 release. Fix all the errors
> found when enabling the check.
>
> Clean-up the xilinx-versal-cpm formatting while we're here.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/sff,sfp.yaml   | 12 ++++++------
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml   |  7 +++++--
>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml       |  2 +-
>  .../devicetree/bindings/phy/brcm,sata-phy.yaml       |  8 ++++----
>  .../devicetree/bindings/regulator/ti,tps62864.yaml   |  2 +-
>  .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml       |  6 +++---
>  Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml  |  4 ++--
>  7 files changed, 22 insertions(+), 19 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--64d8f73e5566f44c66d078f5487c89221898d7d8af4e7f37e5a21c35e662
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYvtyYACgkQ3SOs138+
s6Fo9g//fBFtmm6Kzzagoso58OU0++dfARWpxNf/HxdA/8KmVTIBMzo0T+ZfHo26
56OwCliAQnav38XNkTce1vi3t/ZSC7ZVfH3Ox8Xd/ezD5joI0LtRmHVp73EOn65W
eTRYiezydhG+skWTEWxAzwV/FWZyePwhlnNDdYPc4GBWgYmw0cYRV/GsSLqVfly8
EoD0PlswlKZ3xaBhyhhLjBpdXYkCS+c3P1R5tG85ZaF1SFxr7Z8qyf6zIas1l/ze
QTxdOEQGrlhF0kWhxwJh3Ad0DDHGpdbNVf7UEISNId8ubvZxwQwvFAMPhvOUh9wi
ViVoIHaRv1fD+nJDPf+I27RYyjjMRpoXadGAOH/nB8Pk+/4oDv0VTLacCtKngpJS
xGsVf9l50NQNp4Qp/WvsMSEj4JKodIMoD2Gp51TsrD+7rLd9rLKynq2+Spjs0BFX
gz3Fwt74Qth8w647xL31X+MBD2Ay8N2DjxyTp93JFbDwmqF2qpqTLKbJPDXoVuGJ
PrT3kUvEsEueguFPZM6IqzqvZWjS/ziu8OIbwMrMOWhQKPtqnRkFpgkxoFSHyX7n
PZrPL4DLPDeNL6ZPClkt21EvpoHXzdzIYQDbMslhMBVrngKmoMUPopLHiJYqn+X9
+E/4DDlE5rskMoc416HYi5iIHERtrDSeVoWzqDGWaGYY4UbkpH4=
=AP3j
-----END PGP SIGNATURE-----

--64d8f73e5566f44c66d078f5487c89221898d7d8af4e7f37e5a21c35e662--

