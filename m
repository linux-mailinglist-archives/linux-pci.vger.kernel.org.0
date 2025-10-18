Return-Path: <linux-pci+bounces-38558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FABEC90E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03D719A7C56
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B32405EC;
	Sat, 18 Oct 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qHaDY6Mi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7A6FC5;
	Sat, 18 Oct 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760771762; cv=none; b=MWaW+zESr4A/5eu1QnN8TtkJmGysg4Ay+iDEvmb5d1Xy/1dSpP5XH+Whfd/Ny8rWAvF1O2C5J8J+niE5T//scQd+vxhfzNmPeHGiPnVCEkhho2wBV7bwA+HmGeq4bIWoiaDEr4WbfNGiAEWIdaoA0Mxaijt9/eo4b2DS6alVpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760771762; c=relaxed/simple;
	bh=3KfSNHefVw2EoencGBNwE1iwXP2ZssHmfdinTVazDVc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UeFenrs8bov1CiT75niOjO/LB2rzCk14lKml1V6Qtu6Ksb2hRHnW/A/+ZCbRPraKQYBWKpgfxqEUP7JwgILfWc60dorKHGjqaHCY9Atm9ACkXnyOozDFWJs5uWT8jYE55mqDzOAPKNtu6DwAZqqYJLajCtxOWTU/cENNWRjzfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qHaDY6Mi; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760771741; x=1761376541; i=markus.elfring@web.de;
	bh=ZGoqJjtXYnOhhTA4wNl8jTdsMQizMhgvVhIixYE8+3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qHaDY6Mi+7SBV1DNzo6m0mvKDddTZj+M98wlF2KrAoZ6fOfyslGZinCgcLk/oMOc
	 qKjR8ZHZQs/QDoYaCDZNqOrJs0D1IiWsIlGL2avHzF3hs8YDm6bQinLmwm1c8sABh
	 AmtR2xuHiI2RVjLDt9Xt4dRLv281bheEXr0JIOyfIse3fONeQIFxvGGTUcgG6wQ8U
	 uiwgP1/SIX/p7wmQlvncYkW1GrBzoCXXthIroSfXwTz7x+WVGzVo1CU0RemNxZTIU
	 ikfwYHyj9t66mvuhg3ODrg6aoPY5yDaXADFzmejKTnRGfrsiGrr3LtcR9fL/VGbhn
	 xHK9d89EzXVCAEAk4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1uN9cl0oWg-00fQIS; Sat, 18
 Oct 2025 09:15:41 +0200
Message-ID: <7a369c5a-1558-4c50-88b5-028a1c9cc359@web.de>
Date: Sat, 18 Oct 2025 09:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251018061127.7352-1-linux.amoon@gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251018061127.7352-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMrXEDerwRgHeq7eVixP+7N0TuDwuMefjSqCKI8MCKv+NM/0m62
 mvjTW+z+F2tJoIz+sk994cO/4yDUmR0e2LibPCo6+uLGZgrThRUbhtuKNipqsvC1vN11da6
 ufcSL4OoQ4+GbH/VJzK6nzML87ZQndIQtHlNUg+aycqpNAVhDMhMqHal1Py64pTIU5hvdhu
 K/S2al7JewthN/F2fsK5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9XETAo6BSr4=;7ztpvfZvrYABj68ec6bYewptx6H
 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
 ClPoLGhuEEFulg==

=E2=80=A6
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -134,7 +134,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *ro=
ckchip)
>  	err =3D reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
>  					rockchip->core_rsts);
>  	if (err) {
> -		dev_err_probe(dev, err, "Couldn't assert Core resets\n");
> +		err =3D dev_err_probe(dev, err, "Couldn't assert Core resets\n");
>  		goto err_exit_phy;
>  	}

I find such a variable reassignment not helpful here.
Do you really miss an error code propagation?

Regards,
Markus

