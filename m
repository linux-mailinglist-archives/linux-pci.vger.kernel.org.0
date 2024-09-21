Return-Path: <linux-pci+bounces-13338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02E97DD74
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BF61C20ABA
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D781170A3E;
	Sat, 21 Sep 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP4dKu1N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F65A47;
	Sat, 21 Sep 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726929812; cv=none; b=ewtckpHPad5B38ZHFEfiuKlvwR3eqRBbAEOGiZdq0fmEkEIBgjR7jKPbpnFNWVfEyMCs1Cd33LCyIvhiIz4mFWFO1Sf+Ua826Ayuy5agAZxbe8QjYGPos4nawBNGBubD9UCtQ9pyXct6gWmZUNpGYyYSL87gRoVRogLPstSiNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726929812; c=relaxed/simple;
	bh=AYjfX6QtoC+tkfQrAv+7NvJ+mMxH4NZ1wh5FCk9yJ+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPJHSAE8rDP/oo7RMS3AtwImdwkD+5VNSJEot8HtCee0SqNATrp0z6MXCldvp9+nHly/uYCfQ0qKaYjixojkonULN0WxF/WEnQ5RLUwKsj6BTk0/79Ed9u8F6xpT87PQ1gKkU11d6gU/9D+3GtpBhoX/rQRmdIbRfqDfUr1y2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP4dKu1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A6C4CEC2;
	Sat, 21 Sep 2024 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726929812;
	bh=AYjfX6QtoC+tkfQrAv+7NvJ+mMxH4NZ1wh5FCk9yJ+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YP4dKu1NqIGv2RhiWlOJnIyfm6WBolm5cpHOY+SlypIt6jbxddiWXKpaoHISKSFCs
	 pFX7EbEpcoZ3EBcDwHxHvJpvb0zgvJVIvt2kUmbNA0WoDSrxmWDoj2FNO7oTaYXxcI
	 9dqQDSbZTocs+EQ69LG7b/rnU7maMEFMs7EI1YVYfeeRoIlalAmFaPVUr/CzvXl5Op
	 hmo/vYJX6i7dlCe173DreciGhKnwvX340crqw6GIlYx2YomcqmNShwt2okO0h97WsO
	 u/kUpKe/kcH0eBqaJamcppZfvRSO8+zK8uWrvcTZb2SlDpByKl15T+t5TVtOz9/38u
	 zjU335G/iJp+Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53654e2ed93so3504752e87.0;
        Sat, 21 Sep 2024 07:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6T2AbXyToMfImP9YKSqUSdVyRrnuQynDFtDL2MQrD6ZUurr/CoTd4+zAfIEyfFypteuv/fgMn/DR1@vger.kernel.org, AJvYcCUqzR5c9IpWAAsPik0gIi9lAK+6r+KFOi8Ls5eek11MJ2+oTk5Kd7wHT4Z1dKd7kIz4VGUdunD0ocl9@vger.kernel.org, AJvYcCVfFceSNN+9B+9XQD04VhPpqC38SSkB1Y1XYPYv7zBY1LIQOY8ewqJKEn2/r0QKxB82R4mFHW1arHfMG7Oz@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEDOglXpioquCGUxVMihjE+mF20fMffVqzIhm97Ia2BPTK6po
	cymtqRe4My2yjUesVysjPQB99nVfoAOCgiSBzUUhMj2f6job7cRf6245tRRz8I/AgcCSu4puOpM
	hnNMlcQRthywXsLlHbVTiPvXePA==
X-Google-Smtp-Source: AGHT+IGEb52VaJ0u4g5ADO/n2NfdfmYbTGCQllZh18kPm0xS082MqorrNkMgCmujvaXD4j4prw1u7QnUeiPv9ISuvBA=
X-Received: by 2002:a05:6512:3d23:b0:535:69a2:5f9e with SMTP id
 2adb3069b0e04-536ad3d48d8mr3403286e87.51.1726929810775; Sat, 21 Sep 2024
 07:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 21 Sep 2024 09:43:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
Message-ID: <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI-EP: Add 'ranges' support for PCI endpoint devices
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:03=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> The PCI bus device tree supports 'ranges' properties that indicate
> how to convert PCI addresses to CPU addresses. Many PCI controllers
> are dual-role controllers, supporting both Root Complex (RC) and
> Endpoint (EP) modes. The EP side also needs similar information for
> proper address translation.
>
> This commit introduces several changes to add 'ranges' support for
> PCI endpoint devices:
>
> 1. **Modify of_address.c**: Add support for the new `device_type`
>    "pci-ep", enabling it to parse 'ranges' using the same functions
>    as for PCI devices.
>
> 2. **Update DesignWare PCIe EP driver**: Enhance the driver to
>    support 'ranges' when 'addr_space' is missing, maintaining
>    compatibility with existing drivers.
>
> 3. **Update binding documentation**: Modify the device tree bindings
>    to include 'ranges' support and make 'addr_space' an optional
>    entry in 'reg-names'.
>
> 4. **Add i.MX8QXP EP support**: Incorporate support for the
>    i.MX8QXP PCIe EP in the driver.
>
> i.MX8QXP PCIe dts is upstreaming.  Below is pcie-ep part.
>
> pcieb_ep: pcie-ep@5f010000 {
>                 compatible =3D "fsl,imx8q-pcie-ep";
>                 reg =3D <0x5f010000 0x00010000>;
>                 reg-names =3D "dbi";
>                 #address-cells =3D <3>;
>                 #size-cells =3D <2>;
>                 device_type =3D "pci-ep";
>                 ranges =3D <0x82000000 0 0x80000000 0x70000000 0 0x100000=
00>;

How does a PCI endpoint set PCI addresses? Those get assigned by the
PCI host system. They can't be static in DT.

If you need the PCI address, just read your BAR registers.

In general, why do you need this when none of the other PCI endpoint
drivers have needed this?

Rob

