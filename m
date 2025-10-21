Return-Path: <linux-pci+bounces-38884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DEEBF67C2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D243A5555
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4F32F74A;
	Tue, 21 Oct 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IXuFI9KG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB532E748
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050463; cv=none; b=S8SFFDbGKCpAGpLA2+ByOAV0mJ4gYtKNUq1PqxTX0wFE+4KkgEhxp/ATbGpTzptNZkN9aAbqzXtPSi4TRXJ7OLzjJ3uA3l8PA5Y8STIwwsjBx8laTjyHOPqbTdbLlI6zRbA+fWTyuFNPcNvU2HV8r/qTxV5nqB4z6spbHvOliZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050463; c=relaxed/simple;
	bh=yuVQZTDGjvvcPalMUgTg4epkdUaGdD4g6/GxObBxEI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAIgK9+17jF2pN1RqtMrTsixrCbw7DczcT4YANzpoDt+SqghEopnkfkmd2gYA6v39rvODuVVDGwBmQcsgJ+29prBbCCW+3QXNuG5q5RsF3zHDrFB/v8Cdd4N7FCxAMBCj9/JajaepGM5dSHRFL3PbPIqS5ZPUN7EJT/bAfQjaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IXuFI9KG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591eb980286so994350e87.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761050459; x=1761655259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWb3L2HC5GL7gJV88qPeFIZPSp/OKkdc2F2PK/9kqwo=;
        b=IXuFI9KG4A3E4U5Fibyo6SAZNeh861N5dZ2edgvOUXsjhDgufvCVHz/9zsQZEjK3BW
         MjdzfFJgfVaycKMJmwOmMDVjWwXkD7nlGV67Jf8zvmtPIwiJnQ2Hi16/68lWT3XbNX0q
         7UCzdCkaXSC/d6+2uyK1aPWErerdzs6Igm9Tb1vs/sYCNuAVd6bEm8yBMPW3HV7o+6lR
         oKyQWdMb9O1alofphP99ZmDTFd+Qzv6AnI2dCfLRhj8HNObmEMBPQTn+FgswF+1mdw56
         trf8UoHLlB9JpJl1xWI4L0iPsJJXVTFXUuRVtCxZ3EA8ysrGASRUvQ/StiZWJHbSyx4X
         GBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050459; x=1761655259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWb3L2HC5GL7gJV88qPeFIZPSp/OKkdc2F2PK/9kqwo=;
        b=H0eMhSYRdVSUdEEP5CijgIk1zgF/rN96W1nhrOh/gc7b56xYnT1dFb++InYdKrPo/E
         QbsBHEdeE5Ut4t8p9cXJ2TcIZpzx28VtVE5MM6gRx32aqmId7Lj+hJoxltQrjJkwqESv
         JFHLT+qgslJxccPytPkc+BTIQWgOyX3MCoPv3UG+0QwxRMnFYhY0gspZbyy0SMPCNgE+
         o+NXmVN+dwSlKZY/wDgck4/SabamHT/2SFPQE76cIb7UnixPs0ZwmoJ2fsgVAZHEjANt
         FRqu53y5WDzSx//XCwBMcBR+eAMklbhBwOgtZPYgvRIsnBI0cthdrUulGv49WItbXom2
         7eEw==
X-Forwarded-Encrypted: i=1; AJvYcCWPh5QMptAlU49O1FnSwXShwRznt9pJuEKfdiPFKo8rD/5CvHpwQEla6G6le5UwVFgD2PiY4X8J1GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYfC7nDMrJ7kQB3rp5xaMVa2j0kL8Cu+4x/6GOepPagifQxz6
	miizivBwhp8HGCuFm7GGSvSBIn1OTRMPx62NSy61PYwytzDUysBR0pSeW9q+5pLlzQFbOFaAdoN
	sP9qrRoqj8/EPJQZAp4v79MXYSMCUxn59vdgrtjPz/Q==
X-Gm-Gg: ASbGnctDKmhnpkGXlNhsy7m1dEpgJaesuoriU40dFF29o2U/LaP6SZvukPmVGz23U5a
	tcQVMrVF8Olrk7IabjITlvIZtKwTZTNBnTT0ZaKS3PzPwXcfF8zeAphqn5UIFQcgYDmnD9i1C8O
	M5xGW836v1Uk8nJrbgYqU1lt2UYis0FWUPiM2DB3gzYzCuWEqWS6nQz2vUku6Ao0rpgd4yQvOgu
	NHXzxMABSb21e+CZ1bSHpT9E17lqOWr0H7IZA0+JlRa3zfRK7ov6gx2myFyZ9ATHnKeY1D9FoVS
	qb/Ak4CUgpCI0iahWitjGquqeRI=
X-Google-Smtp-Source: AGHT+IHJJi40QO2j+AEEIXG+FSVZbH+WW1DwyjfojmvqVA8OuBIji8cOMNjvhsKfbFVOj/fVZy/UensL3Bqq96jG85U=
X-Received: by 2002:a05:6512:3b0c:b0:57a:310:66a8 with SMTP id
 2adb3069b0e04-591d85773ffmr5098755e87.55.1761050459418; Tue, 21 Oct 2025
 05:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 14:40:47 +0200
X-Gm-Features: AS18NWCQWmhq7gNfZEHIkGW0O-gEdDRZh4gksyliLmXKxwOZhptAVz-Dcd8I0sA
Message-ID: <CAMRc=Mf++cYPVrFH5_1KggTQi2Tew_MaeHMHSiczkVfM+=Y4rg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:20=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../arm/altera/socfpga-clk-manager.yaml       |  4 ++--
>  .../bindings/clock/nvidia,tegra124-car.yaml   |  8 ++++----
>  .../bindings/clock/nvidia,tegra20-car.yaml    |  6 +++---
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  9 +++++----
>  .../bindings/gpio/snps,dw-apb-gpio.yaml       |  4 ++--
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++----------
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 16 +++++++--------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  2 +-
>  .../bindings/media/fsl,imx6q-vdoa.yaml        |  2 +-
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++--
>  .../devicetree/bindings/mfd/ti,twl.yaml       |  4 ++--
>  .../bindings/net/ethernet-switch.yaml         |  2 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  2 +-
>  .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  4 ++--
>  .../pinctrl/microchip,sparx5-sgpio.yaml       | 12 +++++------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 10 +++++-----
>  .../bindings/pinctrl/qcom,pmic-mpp.yaml       |  6 +++---
>  .../bindings/pinctrl/renesas,pfc.yaml         |  4 ++--
>  .../bindings/pinctrl/renesas,rza1-ports.yaml  |  2 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../bindings/power/renesas,sysc-rmobile.yaml  |  4 ++--
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  8 ++++----
>  .../soc/tegra/nvidia,tegra20-pmc.yaml         | 12 +++++------

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

