Return-Path: <linux-pci+bounces-19236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C47A00BA1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2E163994
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AB1FBC97;
	Fri,  3 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeRdBjNt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A31FA8CD;
	Fri,  3 Jan 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919113; cv=none; b=HUEirlFYa8iPBCaDB0Uebsq9Fym+RJ20+GAUQp5no3nMqiMH0+YLH+oDchQ0IVcsiYTo+52zzoN6kjaB+hMO7Ny6RK75jOCnoYLW7eq04q5IxsmixASUo6gvcVTWkVaG646veQEc5b+uKCk9b6vzKMn/x/p1ii1S+tySA5hGGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919113; c=relaxed/simple;
	bh=VQvwlx9UUTXPUEsMouncgQlEcDzlv0ade2867PWS5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0GaZxWg+fAwB2XEhnjsZAJ9fJomjKlQwc4m8ygsAIZYGFW9ekeRkXBvxR4H74dCacHxMnwRsAUqBa9wGacU3vamOgXax8W1/KckFUJzOwydjq1m/XgkXXyOuRWLWAgbpRt7NNFcTx8sNlFJDm55Dqo92x7gZuplfqLH2YpgT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeRdBjNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A3BC4CECE;
	Fri,  3 Jan 2025 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735919112;
	bh=VQvwlx9UUTXPUEsMouncgQlEcDzlv0ade2867PWS5n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeRdBjNtjVXdu/4GrC0Zpw2WMUwcXkJT9AJZwByFO1sXFrGX3hRrw9/ob1BAQXQn9
	 jJ2t0FRcHvXTCmIP6WhGsqUbA3VcW1yMCphPiIqb9S9jEAgBGrROQQSKCvPmQs/Syh
	 GSSi1vrW0K1t6x+zYEcCzrwzF0/aI7JVcDB6nD05opYnmL9ao0DD9ABe0bpBgkSfct
	 5jZspINygLCpiD6mVnBur8vkBHpOwoOXp6dHR8zj6LYCRT31djA8gy1kRCAsmlxnro
	 l/+KYcabuZGtqEyingjwYPkRluDS+Ksz5zLO4KKaBoOvcngk3JPFXBm36zo22hgGlQ
	 NvNqLXDNLUTQA==
Date: Fri, 3 Jan 2025 16:45:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <Z3gGAgYAZeU2ZPok@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen>
 <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
 <Z3f4JQZ6yYV1BJ-b@ryzen>
 <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>
 <Z3f95RXj7GhZZHEP@ryzen>
 <CANAwSgQEb7rWFaeEO3Mb8LAwK6A5mrCyQFEysmSpeVdhoRWrtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgQEb7rWFaeEO3Mb8LAwK6A5mrCyQFEysmSpeVdhoRWrtw@mail.gmail.com>

On Fri, Jan 03, 2025 at 08:59:51PM +0530, Anand Moon wrote:
> Hi Niklas
> 
> On Fri, 3 Jan 2025 at 20:40, Niklas Cassel <cassel@kernel.org> wrote:
> >
> > On Fri, Jan 03, 2025 at 08:36:18PM +0530, Anand Moon wrote:
> > > > >
> > > > > We need to enable the GMAC PHY and reset it using the proper GPIO pin
> > > > > (PCIE_PERST_L).
> > > > > Please refer to the schematic for more details.
> > > >
> > > > The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
> > > > (host) driver:
> > > > https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206
> > > >
> > > > which will cause the endpoint device (a RTL8125 NIC in this case)
> > > > to be reset during bootup.
> > > >
> > > Thanks for letting me know. It seems like a workaround.
> > > I'll try to disable this and test it again.
> > >
> > > My point is that we haven't enabled the GMAC PHY (device nodes)
> > > and must properly reset the GMAC.
> > >
> > > We're relying on the code above hack to do that job.
> >
> > I do not think it is a hack.
> >
> > If you look in most PCIe controller drivers, they toggle PERST before
> > enumerating the bus:
> > $ git grep gpiod_set_value drivers/pci/controller/
> >
> 
> Ok, understood. However, we have multiple reset lines per controller,
> so the PCIe driver will reset these lines using gpiod_set_value.
> 
> PCIE30X4_PERSTn_M1_L
> PCIE30x1_0_PERSTn_M1_L
> PCIE_PERST_L

If you look in Documentation/devicetree/bindings/pci/pci.txt

You will see:
"""
- reset-gpios:
   If present this property specifies PERST# GPIO. Host drivers can parse the
   GPIO and apply fundamental reset to endpoints.
"""

For rock5b, reset-gpios/PERST# pins are defined in:
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts

$ git grep -p reset-gpio arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts=&pcie2x1l0 {
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts:        reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts=&pcie2x1l2 {
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts:        reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts=&pcie3x4 {
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts:        reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;

So I think there is just one reset line per controller.


Kind regards,
Niklas

