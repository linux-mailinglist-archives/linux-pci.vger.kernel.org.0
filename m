Return-Path: <linux-pci+bounces-7890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F08D1A70
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF881F24069
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69216C84C;
	Tue, 28 May 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI/XBhMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BA4C97;
	Tue, 28 May 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897479; cv=none; b=rIqu+rBugC2t9eM7hApaOetIsJNUS4wd/TNSBagLzfjagJMISB+RQcomsMkJNsujtyy83jqLv502kcD9FYJJalkyAYTXab6ln+JuvrifQvJtYvrHh4Mq2avCEz5+sqFICfgCqPet3w8lYDr6UWqi97u4kZjlRZ26NsYzqqrA5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897479; c=relaxed/simple;
	bh=1lYQK5mXOyUpa175X1Sy96vhJCVsXrfaSlYdbye/ge8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0guna3hVbZ1UKgssT7/lhvzIvE+WFJ/8nlOBSKdJxscI/Zsg6Jg6Bv4OXIY7KPNY89Vs14F/Rb45j3WXw99p+hbwi/nFoUiYuM3KhAdgjjRyKgB11HcgLu/S5t1OWFMVHsAafO28lsOgsfu0At/Xllgxe15DqdjSbV92Wj3smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI/XBhMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9DDC3277B;
	Tue, 28 May 2024 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897478;
	bh=1lYQK5mXOyUpa175X1Sy96vhJCVsXrfaSlYdbye/ge8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LI/XBhMMNJFFMWherkusHeRzK7+ig9lgB76uzLfVZp6mhu+jz6rvYccIm0xFBmnKI
	 qdIp+dgugEptH32RE3YLTOitOBMYIkW2ueYGAhLeAMPyxUOVCSOta9cjGgW1C4zOwq
	 NPG4ouUTyBKglYbxJy43bFGuKim5CphIm3SzdPGjIbeMsjvBwRhxSag7ZF37u6JI7v
	 slfoiaO2tH4JIOhF6hiISFnV6FP+EPXBqSnwoLRHUdXfAxWjd9PoxOVOTWUtwxR3zb
	 PQ7jbqxiTd1NKwpJEwNtDkY8ZihuVAt9Nv59Uwgr6NKwU4MDZdrVCRFvdWakdI1uFC
	 MK1nXmNHqjmyw==
Date: Tue, 28 May 2024 12:57:53 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add an initial devicetree
 for the BeagleV Fire
Message-ID: <20240528-movable-chlorine-cc5ebabb8abf@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-hurry-escapable-e3212bf3cdd8@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z79wW9aJnFNbzgAR"
Content-Disposition: inline
In-Reply-To: <20240327-hurry-escapable-e3212bf3cdd8@spud>


--z79wW9aJnFNbzgAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 12:24:40PM +0000, Conor Dooley wrote:

> +	fabric-pcie-bus@3000000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>,
> +			 <0x30 0x0 0x30 0x0 0x10 0x0>;
> +
> +		pcie: pcie@3000000000 {
> +			compatible = "microchip,pcie-host-1.0";
> +			#address-cells = <0x3>;
> +			#interrupt-cells = <0x1>;
> +			#size-cells = <0x2>;
> +			device_type = "pci";
> +			reg = <0x30 0x0 0x0 0x8000000>,
> +			      <0x0 0x43000000 0x0 0x10000>;

So this ain't right, I sent some patches yesterday to sort out accessing
instance 2:
https://lore.kernel.org/all/20240527-slather-backfire-db4605ae7cd7@wendy/

> +			reg-names = "cfg", "apb";
> +			bus-range = <0x0 0x7f>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <119>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +					<0 0 0 2 &pcie_intc 1>,
> +					<0 0 0 3 &pcie_intc 2>,
> +					<0 0 0 4 &pcie_intc 3>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>,
> +				 <&ccc_nw CLK_CCC_PLL0_OUT3>;
> +			clock-names = "fic1", "fic3";
> +			ranges = <0x43000000 0x0 0x9000000 0x30 0x9000000 0x0 0xf000000>,
> +				 <0x1000000 0x0 0x8000000 0x30 0x8000000 0x0 0x1000000>,
> +				 <0x3000000 0x0 0x18000000 0x30 0x18000000 0x0 0x70000000>;
> +			msi-parent = <&pcie>;
> +			msi-controller;
> +			status = "disabled";
> +
> +			pcie_intc: interrupt-controller {
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +	};

--z79wW9aJnFNbzgAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlXGwQAKCRB4tDGHoIJi
0oeuAQCripgxkKIvfMVj9OYaqpJnxghyOymmY6JCpmywHPYZ3gD+JxPnKPy7CEG/
pxHE90yC5iB1AQRd+jHpUhskYg101gg=
=Au0t
-----END PGP SIGNATURE-----

--z79wW9aJnFNbzgAR--

