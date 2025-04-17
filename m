Return-Path: <linux-pci+bounces-26127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892CA92385
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6644516D1E1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06A253B59;
	Thu, 17 Apr 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="xRrOkl+q"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8B17A30E
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909802; cv=none; b=aAefPcf6+Ph1fV2JC+P1pokl1sn83FvotUjR3nltnoi9Bk3+0o34/cnXgRFiCO1l3IJiqG3DKI5KQ3iIlbhIAfNN/PAacdYjkMVoPgHkyqwFcns3qNAvWKOGFklmU/Mfc2b7YRioid/mekR4X7yycJQzu/3NDKqGS4HumIJHhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909802; c=relaxed/simple;
	bh=+KCwB4S1lB26w346UYpwjYOn/QTHi7mLnh8nbljjSZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=oLCcz/NI3/lyVO6OFKb7h4+CXemPg4aNTBCdp369yAC70ukVaYWcRoBdlm5xOz95Icm7XJuhVbxJ5tr652v690hIh3QINMRdODsQXTS9bb7LjFusT7y1QFSwoDlsqhIsP+TDv7ei/UNBe5HQF38ENUWmFuV6/IfJbKNVeYVa+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=xRrOkl+q; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1744909795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U4ILFAnnROWvWpXm91/wKuzpauoiAfG10LJOtDhws0=;
	b=xRrOkl+qGnYLA+AOqsbB9LjK1LWPYQy1oz8Y+rZWCD7iABshDYz1KUdZGcAdgbdurKya1R
	CmI/fAI+abH5jKptTBlaXXuXzSzy6WA+8jcjmfT+qaoYMFx0A0F2590ib3Hghb/4DXHC1a
	x++yxn2UC73tCT1BpT6bXu0j5HzYItmFsvENg9YCryIlHXRk6Fg7QnpXXpzvYxs6IxVc7W
	c8sXsnDjKc4Bov2fkxDKx03WqPOEpfKUFS6Ak0zhV8nC0c2fEoLWUtuyP4rJPeFaeL0Hlf
	VFVppXokdY6+zL3p+ey2gDqA+uAtsN12AQMFYGmk3QCLVkMdtAfVm2vN+mo5Tg==
Content-Type: multipart/signed;
 boundary=9beec6f5477ababb2ae9d3e4220a4e06ab7f2fafa941ec7e9fa069b1c762;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 17 Apr 2025 19:09:46 +0200
Message-Id: <D992W9V9ZH2J.2Z2OLK00N0FIU@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Niklas Cassel"
 <cassel@kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in
 rockchip_pcie_phy_deinit
References: <20250417142138.1377451-1-didi.debian@cknow.org>
 <3e000468679b4371a7942a3e07d99894@manjaro.org>
In-Reply-To: <3e000468679b4371a7942a3e07d99894@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--9beec6f5477ababb2ae9d3e4220a4e06ab7f2fafa941ec7e9fa069b1c762
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Thu Apr 17, 2025 at 6:20 PM CEST, Dragan Simic wrote:
> On 2025-04-17 16:21, Diederik de Haas wrote:
>> The documentation for the phy_power_off() function explicitly says
>>=20
>>   Must be called before phy_exit().
>>=20
>> So let's follow that instruction.
>>=20
>> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host
>> controller driver")
>> Cc: stable@vger.kernel.org	# v5.15+
>> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index c624b7ebd118..4f92639650e3 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct
>> rockchip_pcie *rockchip)
>>=20
>>  static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>>  {
>> -	phy_exit(rockchip->phy);
>>  	phy_power_off(rockchip->phy);
>> +	phy_exit(rockchip->phy);
>>  }
>>=20
>>  static const struct dw_pcie_ops dw_pcie_ops =3D {
>
> Thanks for the patch, it's looking good to me.  The current state
> of the rockchip_pcie_phy_deinit() function might actually not cause
> issues because the rockchip_pcie_phy_deinit() function is used only
> in the error-handling path in the rockchip_pcie_probe() function,
> so having no runtime errors leads to no possible issues.
>
> However, it doesn't mean it shouldn't be fixed, and it would actually
> be good to dissolve the rockchip_pcie_phy_deinit() function into the
> above-mentioned error-handling path.  It's a short, two-line function
> local to the compile unit, used in a single place only, so dissolving
> it is safe and would actually improve the readability of the code.

This patch came about while looking at [1] "PCI: dw-rockchip: Add system
PM support", which would be the 2nd consumer of the
rockchip_pcie_phy_deinit() function. That patch's commit message has the
following: "tries to reuse possible exist(ing) code"

Being a fan of the DRY principle, that sounds like an excellent idea :-)

So while you're right if there would only be 1 consumer, which is the
case *right now*, given that a 2nd consumer is in the works, I think
it's better to keep it as I've done it now.
Let me know if you disagree (including why).

[1] https://lore.kernel.org/linux-rockchip/1744352048-178994-1-git-send-ema=
il-shawn.lin@rock-chips.com/

> Thus, please feel free to include
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thanks :-)

Cheers,
  Diederik

> and please consider dissolving the rockchip_pcie_phy_deinit() function
> in the possible v2 of this patch, as suggested above.


--9beec6f5477ababb2ae9d3e4220a4e06ab7f2fafa941ec7e9fa069b1c762
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaAE13QAKCRDXblvOeH7b
buluAQCEIjcEnqtZwClOAqM8s1LvfqUaaPSSbkWDSy6SYsLWAwEAofWwHxa8G5nC
MgjHBOJT/8MsTjFkhLaeM2uzEV2YXQE=
=VbT8
-----END PGP SIGNATURE-----

--9beec6f5477ababb2ae9d3e4220a4e06ab7f2fafa941ec7e9fa069b1c762--

