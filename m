Return-Path: <linux-pci+bounces-7797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5518CDAC2
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2627B23944
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B6839F7;
	Thu, 23 May 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ur5wel49"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962E82D9E;
	Thu, 23 May 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491928; cv=none; b=qkHkUoLPl0Vzjn0NNxEd0Ctp9TvVIKIuSgOORGxqaHHgRJBeBZV5cCDHp2Xb+QPa7+9TPVZUtfYBQ6BjdThM07YuN3mz7XMr6uQQEcreJNk9GvqP2VVR+naKOZMivD/a3Ve2igS5SaJIclTTAfaL6BM3FqyyBUf5vpp05d7P6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491928; c=relaxed/simple;
	bh=fWjejW9xdfNmZJGNqDJuH/uLBlAoUAHTMlP8yBrQ9BI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=L5LZX1fFoNw1GL5DzmFbyC2Ke2C6MJFaS5UM8JOd0y5238Z21IW91pvFqroRSszOsR2rzN11199Eag2HIz1CRkU484yZYt1nE9FLRL7S4BxRpLQ6FXMFGt5j+DNtI2bovSH0Dpm1+6X+61MYC6LwBVwS5XB1A6/4CKDjLAnu3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ur5wel49; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716491891; x=1717096691; i=markus.elfring@web.de;
	bh=RpyON3/SfYcEJHYsAQeK/+128bvG84+TmTn7Ylhqq3g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ur5wel49Lecfw87HRpHs4NyKVR2Kypstx1Y8bCIa8PEfYtZjz+u1799K0AJDpyLV
	 h+aLTXpORjWMchHbE8CJDzYtmPBCERjdadNyhHYQNCxylGfFFRadD5sqlpKGUxAYS
	 Y3gtgLGHUjyLG+Z9jszvG4fQ5OjjgOkPGBpJCMVMLHEEGulqZ72nhAixgdxVkUCX6
	 Aojt8KTk36NbFrlqOrM+BbBOLY+5EpwzzPq3MLyyPqMjD74rlXphO/NIGrk6IHtDV
	 aU6XxQhT4k4E/1X9Lcj+bm+eB89jjEKcCoqTX7S0V5OUwFyxMw6OfyW4kbMsjUhBM
	 y1iXbLSlcZOG1QSdpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1sKQHY2Ds3-00GH3C; Thu, 23
 May 2024 21:18:11 +0200
Message-ID: <4a43cda4-dfa4-4156-b616-75e740f6fd64@web.de>
Date: Thu, 23 May 2024 21:18:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-6-sean.anderson@linux.dev>
Subject: Re: [PATCH v3 5/7] PCI: xilinx-nwl: Clean up clock on probe
 failure/removal
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240520145402.2526481-6-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nuwOBf+zdPyIUVq+GEAxoVouepil547lApNGdbhuDbe8v1rRdR4
 ED+u2uuHe8I03Z84sAuohUsNEhUsSLRFwixYaDpksaoXddI0z+nxHoH6Bz5qOIFduJME0Fe
 f+g/4fghfXCHTszN6flTIWbdy09Oqx6JjcEP57gmJ3JGXD64iqDLfTgWARxf2NnKARo/mMh
 p1hvETCSrzhPqGNTfaPGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8904RJMpJ9s=;JCdx0Wo9Q99BWW96f6JOVg6LGWm
 LfsVgGkVDiGOWkaLD+6IlQ19BwbXymHEY5wAkAxJPs4HLHTe6gc533PPj/pd9A413cpYTvVzO
 0pSZNJtInjL9SXUbWNjXZT52JplYKE3e3xvxFMcNtMwrcr+ypTdmy3PRX9iJLNlSBgiMbE980
 icgFe9m1X0Q8ibra/KXnD3oqJFN38RFCyJ67kWibhqvRCJqRjbPlOscxylyei5hG+ddJJYngh
 bVPH6kNtf8w0/CU7pqavi78vcsr8sGI7ayVjP+rSsciYK0qR9s+CHbfT/0L1WGssx4FnQPUAN
 Mu/cizYp+8FY5qWwcK06y4sGeutiPxwAUG9DR0cQS/bHUYNTAAAMX5N6kQI93ckuR6r4g9QE1
 Uyp2fkOnaSAhTpQymtfqv6M3LEQaASspMEG6rC81XBz1V7pypm2nlgE0DvccPVfURCyOwumLq
 LEveRUL/+Z2XtD4Cjf9yB+UB8/fxLkKCHWy633eaDRgWgbloTpOskTnw2Mgh/FVLvFcCuy2ti
 2jhq9jTWTCML2lTRFWPevvdmOxMwr95OUHwUGkP/VMztNdVrwZe4AVMV+JXnHtt0yMZ6LBIMG
 WO0wlk7Xv8KhLylz+G8pphyCXJGKgot769BQBEV0139ijhV7OEGsccyT4s4y22f6Kd8z6zWx6
 K+zBua0IsI1XHP0rV8MWNhdfUUjtutwb0h0klVtRXWAq+p4gURyJupfOfMxN83bnBTzNWAEyp
 SDlOjSl2x+Bo8SUOw0GIzOf1ww6HpVyafDKKf0PKExOrtyCnSGTHmcJZDjKVY1ndy23YzuwhJ
 UvzcxnF+gBzYIyEkr/R9531wUVjiOBlfqlUjxWWN0pEHE=

> Make sure we turn off the clock on probe failure and device removal.
=E2=80=A6
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
=E2=80=A6
> @@ -817,11 +818,23 @@ static int nwl_pcie_probe(struct platform_device *=
pdev)
>  		err =3D nwl_pcie_enable_msi(pcie);
>  		if (err < 0) {
>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
> -			return err;
> +			goto err_clk;
>  		}
>  	}
>
> -	return pci_host_probe(bridge);
> +	err =3D pci_host_probe(bridge);
> +
> +err_clk:
> +	if (err)
> +		clk_disable_unprepare(pcie->clk);

I suggest to use the label =E2=80=9Cdisable_unprepare_clock=E2=80=9D direc=
tly before this function call
(in the if branch) so that a duplicate check would be avoided after some e=
rror cases.

Regards,
Markus

