Return-Path: <linux-pci+bounces-41291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD8C60270
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19B94357651
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439AC24E4D4;
	Sat, 15 Nov 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rALV1oVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78F1CD15;
	Sat, 15 Nov 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199056; cv=none; b=L+U7ido+itiokffZMLNo4oXejIE48kLAdIagsPpX6v6gTOL31lOkS5u2W9aS2ct8zRll1LSh8Zo7al+fQQFKp+shEe5lNCmjml2RLGFQFOu2fSyj9NhdCoy0joTAZhSHMbYLbPoipYPYTBBeggRHnmeSUE09MwJMrLy8eNMvIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199056; c=relaxed/simple;
	bh=wCqjQkZzAhAg2IiACxiocNMjEXxQElz1lJZm73b1Vt0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Q3mruVQ73rKLd9MfqEt8fjCOyn/98rBEVgnJ3aodDIuDDmn1V2HPmGvUuDN9E9mkFU30pN1aEhTdb5nEhSKJAe38gWih/nBv5ArffvwFdPd45A2Td2Hw0fNNMrOneGXE8MQo/D7llkkGOGPEdtoXCbNXU3utFUPSKktHnctmYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rALV1oVi; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 03B7B410BC;
	Sat, 15 Nov 2025 10:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763199051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=El1dag7V1MQtuD7usBgnxi59sc6/YKeG1sIluoJStD4=;
	b=rALV1oViAYxtYolAplpe2osiF+FOHCNX5Zx4T78qVIAzpsI1P2sQMI+cBw5f0RDEU4PviC
	+moZ/vT0+43hjexj07jGbJ4ZgBKjQ9DRS4mru2wuvcL8whV6J2iihBOtFDqyRl6h/+C4HE
	x/oJMiYsjdJCJg8nasrf8r4Bl6kPFVCklPbxEGgXTMtFG34k+F5fw4JOFIgsHw6RqhIyPN
	zjNqskWy/iR02hg2Rh1akcoc5o76JFhf2BSNjnILcjPqMM8HUY4/DehS0h5Gp7MeLr4xLz
	AEW/Qtq6d2WskL0FDa5GyZqFRHaYa/VgUDM3KJSwGRwqIMqhrSatPVvYdfnQfg==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com> <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
Date: Sat, 15 Nov 2025 10:30:49 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/3] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= comment danger of =?utf-8?q?5=2E0?= GT/s 
 speed
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> According to Rockchip sources, there is grave danger in enabling 5.0
> GT/s speed for this core. Add a comment documenting that danger and
> discouraging end-users from forcing higher speed through DT changes.
>=20
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21=
b@rock-chips.com/
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pc=
i/controller/pcie-rockchip-host.c
> index ee1822ca01db..7e6ff76466b7 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -332,6 +332,11 @@ static int rockchip=5Fpcie=5Fhost=5Finit=5Fport(=
struct rockchip=5Fpcie *rockchip)
>  		/*
>  		 * Enable retrain for gen2. This should be configured only after
>  		 * gen1 finished.
> +		 *
> +		 * According to Rockchip this path is dangerous and may lead to
> +		 * catastrophic failure. Even if the odds are small, users are
> +		 * still discouraged to engage the corresponding DT option.
> +		 *
>  		 */
>  		status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FRC=5FCONFIG=5FC=
R + PCI=5FEXP=5FLNKCTL2);
>  		status &=3D ~PCI=5FEXP=5FLNKCTL2=5FTLS;

Looking good to me, thanks for this patch!  There's no need
to emit warnings here, because they'd be emitted already in
the rockchip=5Fpcie=5Fparse=5Fdt() function.

Please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>


