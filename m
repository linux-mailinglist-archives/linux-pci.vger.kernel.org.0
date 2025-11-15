Return-Path: <linux-pci+bounces-41290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF3C6025B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82CD435B67A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851726E704;
	Sat, 15 Nov 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lYaApLAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB643220F29;
	Sat, 15 Nov 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763198697; cv=none; b=OkwlylKrRfuFVQPsv0Y9G17vgqm5M1Fkl6TeElwGiYC1HurSv/snhNOxDhDL+zYawB1XpQNdTe151C8tYoCyUjipBCim6VzWV8vUE0LHM9U35yjBq3No8wS5Ij47EVoX0NOLwXHJfhaOcYSnlH6sUptXWlSD+/iwlHp7kQ1l20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763198697; c=relaxed/simple;
	bh=fQGJBfflphRgULZR9oKwcOib9jqTcM7ri54FuQS3uGk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=XoaYizJFDmzcPWEIbUrceC4UYmOTHiPYNRzTRIvcHJuUDK5/ChvM1GNt1aqsOVTam9Po+GoV6UzNtGW6ZDt6MK53rymVYXg1cLRYY7FPn85sAvWoHD/uFXVoCtSiMDhV8XIt6wyNfqJ7oFiGzAkytb12N9bgH58jRMUJZrfzDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lYaApLAY; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 8FB35410BE;
	Sat, 15 Nov 2025 10:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763198691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5W225Xb1n1INaMEh/to5gfQKJIJdb6ZwHU6TvTI7BKU=;
	b=lYaApLAYL74+f7bKqNsVaLnxWo8PFvmZY+SBvtLQTmioHwWXfg0zC2raMUm/UBzRlMId5t
	7Asp3nVyA0MhYxD9i4+icoDEuZxioJhZWUGaGguN9+TJDtCcZY0jVpOQvVI8VMdJEFe473
	aeJySqtFB2kUDdtU6iSZ3KOAZOv4qER3QaYlGBaDFv97XGkJQd+h+XbExOwxF5dgW11wOZ
	kljG5h4IaTgdOMWRjf/NvUYEZIF0eRU/xIJxmM61v1PQ3bcn8WhiUE7gOjOK6OOkbmQxia
	qzOV1AuWVOvO4Zj3V80pksHk5tDS1OYNgjzNYAN4mrVtLI8ybwTZKLFv1GHDMw==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <d6593ae4f59468f294fdddfef83791e0db100e13.1763197368.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com> <d6593ae4f59468f294fdddfef83791e0db100e13.1763197368.git.geraldogabriel@gmail.com>
Date: Sat, 15 Nov 2025 10:24:49 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a214ac9a-36d9-6505-64a8-92af2da42cf1@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/3] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?= 
 warn of danger of =?utf-8?q?5=2E0?= GT/s speeds
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> Shawn Lin from Rockchip has reiterated that there may be danger in us=
ing
> their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT chan=
ge
> from the default and at the same time, drive at 2.5 GT/s only, in cas=
e
> the DT max-link-speed property is invalid or inexistent.
>=20
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC dri=
ver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21=
b@rock-chips.com/
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/con=
troller/pcie-rockchip.c
> index 0f88da378805..ed67886a6d43 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,12 @@ int rockchip=5Fpcie=5Fparse=5Fdt(struct rockchip=5F=
pcie *rockchip)
>  	}
> =20
>  	rockchip->link=5Fgen =3D of=5Fpci=5Fget=5Fmax=5Flink=5Fspeed(node);
> -	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen > 2)
> -		rockchip->link=5Fgen =3D 2;
> +	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen > 2) {
> +		rockchip->link=5Fgen =3D 1;
> +		dev=5Fwarn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
> +	}
> +	else if (rockchip->link=5Fgen =3D=3D 2)
> +		dev=5Fwarn(dev, "5.0 GT/s may lead to catastrophic failure\n");
> =20
>  	for (i =3D 0; i < ROCKCHIP=5FNUM=5FPM=5FRSTS; i++)
>  		rockchip->pm=5Frsts[i].id =3D rockchip=5Fpci=5Fpm=5Frsts[i];

Looking good to me, thanks for this patch!  People often declare
PCIe Gen2 on RK3399-based boards as "works for me", which actually
happens very often, but such simple evaluations cannot be taken
as a proof of Gen2 correctness.

Furthermore, RK3399's internal interconnects limit the effective
I/O speed of PCIe transfers already, so switching to PCIe Gen1
actually doesn't result in some large I/O performance penalties.

With all that in mind, please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>


