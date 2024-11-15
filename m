Return-Path: <linux-pci+bounces-16925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC209CF3F2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441C8283377
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB2183CD9;
	Fri, 15 Nov 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HJt7jFjv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BA17C7CA;
	Fri, 15 Nov 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695410; cv=none; b=lgiHAO13zbUCNdN3TVV9r5lan6IWcPx1ZfLxFIyHiJxII3iMC/XTRMSpJj6IEF8u2lYFBAU1yp7AkfM6oQSDAuIJeeIE66JgH3C5FkYBwYCr3Ufy148rrcp7cNCy4Z9d4jEafYJ61ZTY9nw6GlP3aCX89rxNj3k6vLW6jDJAx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695410; c=relaxed/simple;
	bh=qQq/vi9e6m6ETqXrfSVF09C0+hl8OYr1A0nE5CcOm/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sh2gwPkY/vmAK1Ky036sUYK23lMWdBBeZ6SjN8LmSKjMrklWgbKluTF6caKu1gIXlKqJLIL2G6Egoft2VP5kWphD2EPQOcKwqN6WP2edeJDf/A5WkeZBPK7ytPwh7nZGW6HujZUBMOF7CgzN5ToEsZaJycwjp/7gsLVZnwY+jI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HJt7jFjv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731695375; x=1732300175; i=wahrenst@gmx.net;
	bh=vvYnkM/MjUNPD+tFi1nKdoNje94Yno5pUUbs2o5pcls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HJt7jFjv4FAGS/B0DvOzK4BzXII+HQHUpKbLrnd9N53IgdAt6cG6PE3MqFVGAa16
	 47F6uRn/YPLE9m2WZtroVqFTE/+rgiwDbKaA+anIeML+/Ao14l6A3fUpx4/Z8Uy4Y
	 t8ZtqCwnTOjmIlEsOJi60caJixxP1lZlPI1KshHTCj0kz9ErTgyPTVtG3iFYvZ2Z/
	 2bGEqztgGqbnT1ZoBZpRDr5B9dcc23whPr4nd43PEpX1DZLAloeCnSGkpCRFhvkfA
	 5/EPKGVgKWmUaIsBuoDCpOKtiXsaMDjZtCDa4mE+ayVTtr9y5egozJwrh/c88QbN4
	 BjiHgIZAS0c+5Jn4Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1twP841BiB-00zHUJ; Fri, 15
 Nov 2024 19:29:35 +0100
Message-ID: <eb1da92d-b7b7-43ae-959e-3f02c6e2c91d@gmx.net>
Date: Fri, 15 Nov 2024 19:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove IRQF_ONESHOT and handle hardirqs
 instead
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115165717.15233-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241115165717.15233-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y8BOJwtYO3G/ANwm5CtFwOlPqscFlQ7Olc0lsAOfwe1+65GAPUA
 fpesKh7PrSU8eDdbRI5XEOpT+zIzgowbJeWNbF0AOBFst1ApmF6jouPcU0DwatmDUiQ1Yv2
 3nzgTQ8Wi2lULemRbpXDWwlJ/r2VXFALczzILsWMi8sPKQqI8CHa1W+HVLTl7vYvuGhlmW0
 IbrQpuGkPz7bHCyluXm8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvVA6SMA3xg=;gAgsQ+bjUu1ieqEqIdbmBx5+GJ2
 n2mv3yvAaJJ+hmZn/36ldRNl4Yt8ZAT6Wzm1DeQe5nev5z8wGugcongNClTpDV7e7RHdsDktk
 umOYQSFTx2QhmSQkDaU9xZJ9U9fcvQ6bgi8TqClujMdxMrdFxGJSanjx2HV6zsVoKOsx9X1VD
 5lbgKqHvTetoNRN78jVRqF+PWAaIuB0dyfXsVhiVBUPDyazyeTfLbFCqUuIETnpTGrodk8jX9
 L8zRi5D4okVtI8XuvgVcgyg7fhQBqBpVKDdha4A+vbQtIJZUx3zEFKKH3MmsO2+uoCclgGt9T
 EmIz1lYN7rDe4Vdsx0ijBf2zcFc2QE2Ze1ckx8uOQ0lqBlwRS+4Gjzis4nl0FNq1T0DMlyEoM
 WGDcmG16bQSzqjZPUq1QcD32/0DFT95PDXtmV8WgI3FWs1GFrjeEAUSnsAWUDddAHywztDjFg
 bpqX0rUpOdbJ3KM3DrKr3RMuwQKbNSCW4Juehi/7S3q0tuxdQvVea0zb1BckwcEzAQDdiXPOI
 uPCYFnuL2A3xrwJrf1jLGvIAubsg5Jc8EVD6QB8LY0zfs4C0WaMvcRQIsoYUrlkrmWFMg4o7L
 qxvZrcMyefJ0eWFOXlz1xXVIKXVWF8UPfOBUpCpVI5q0yDBu7JpCcDv/Y4L3fLUXM0oOTJSAM
 tRqaTZGuzbh5jMg1y19PvggJEk6IWMIi4RX6qorDkDITHLdpXWgGS/9+8no3fg49bP+yx/hyw
 /wVM/FxQ2nli95Jn9dF5iwOO7sS/rgZY4eCbueC8LYd/KYVOj5/1FUx/27ICRQBurTMbJ5E5D
 2NVI31Gk4cU15A2rT4cd/aPUF+M7wjNR2x7mPgaGiSr3y+o+nYOjaYPeRuld8oqA8CbIY1grs
 s1XCk2k4LgIR0Ia089XtohSraVNx35cWS4/E8vmfgsnu+VTzTDboBls3w

Hi,

Am 15.11.24 um 17:57 schrieb Ilpo J=C3=A4rvinen:
> bwctrl cannot use IRQF_ONESHOT because it shares interrupt with other
> service drivers that are not using IRQF_ONESHOT nor compatible with it.
>
> Remove IRQF_ONESHOT from bwctrl and convert the irq thread to hardirq
> handler. Rename the handler to pcie_bwnotif_irq() to indicate its new
> purpose.
>
> The IRQ handler is simple enough to not require not require other
> changes.
>
> Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe=
 BW controller")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e0=
97a0@gmx.net/
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
this fixed the probing issue. Thanks

Tested-by: Stefan Wahren <wahrenst@gmx.net>

Is there anything more I can/should test?

> ---
>   drivers/pci/pcie/bwctrl.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index ff5d12e01f9c..a6c65bbe3735 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -230,7 +230,7 @@ static void pcie_bwnotif_disable(struct pci_dev *por=
t)
>   				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
>   }
>
> -static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
> +static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>   {
>   	struct pcie_device *srv =3D context;
>   	struct pcie_bwctrl_data *data =3D srv->port->link_bwctrl;
> @@ -302,10 +302,8 @@ static int pcie_bwnotif_probe(struct pcie_device *s=
rv)
>   	if (ret)
>   		return ret;
>
> -	ret =3D devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> -					pcie_bwnotif_irq_thread,
> -					IRQF_SHARED | IRQF_ONESHOT,
> -					"PCIe bwctrl", srv);
> +	ret =3D devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> +			       IRQF_SHARED, "PCIe bwctrl", srv);
>   	if (ret)
>   		return ret;
>


