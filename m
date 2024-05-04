Return-Path: <linux-pci+bounces-7091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2748BBD7C
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901281C20CFC
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D95FB87;
	Sat,  4 May 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8lromsH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94E1DDF4
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714844259; cv=none; b=QyTzDqCusJ4joTYAoIZueUo8hNcFyyGk3SJFTAWkfBsLMwprwFgtFwGHynBQu4YDEU+820q74jbeJzjlpVGoCw0+oZLB9SlZStwSAizUokm8Qw1wDieeT3NMSHnExpiE2dzZg3dDUcXDzCfET+7Roq+D3ulO9iiPv0Sg70JbvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714844259; c=relaxed/simple;
	bh=spltBRDEJsd5X0IQqbLt368yovud1jM5FlQxJ4PmOXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz5Uk+iYomeFhj49OsjiyiF/W220ihlVlL4LQKY9JOtBytceZFHLH8o40dFI2UMIUJfIEAQhAmaY6TwTdbLDEFeHo1m3G4mRbldWl9SWAh5G9t9P8rtVGXdazNRsi4yER5vhZVbANyWI5oHBVt5q14BHm2SJUIFQwDgzMSiQ9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8lromsH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so6320025ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714844257; x=1715449057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UW6BSqOJ4sVDnXycv8jcF2aobgIZjBXz6vzOqoqvFfw=;
        b=i8lromsHRZANFmdPWHe4CxcBOmOMpMv7w6baTLtKT98nMDKAtbT9IrVKiFkcZ9aVQr
         zaC6Vr6jMNYka00EJ4hScFdEuGYKO8Nn17ezGFzA56qGmZK7JI0FATa1rTkbINcnIckX
         VnFPQHfLhSAxaQhdUgx0MA6vNOcbsF0HPy7WDnCuEPqaxFmTkp5OvVuVnNA8d7FLzWvq
         QhfXgOchX2ChpsDmEuDx223q2oXk9rNeYmhYE/ovMtI2z+g/0oBBRyC+15hNRA73fKYw
         cxedQBJ3fHa18iDh9hVKdschEbHJdh3FzUJC0Zy1Nbtbz80nw6pV+LhRNnCIbNBBJ9Er
         q67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714844257; x=1715449057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UW6BSqOJ4sVDnXycv8jcF2aobgIZjBXz6vzOqoqvFfw=;
        b=PJlXn4aj+8AcE/ZR6E0vAAFNrHTNMzHsXPU+5p/N1V5IrWbVrLBwIZKU6LNOcQK07d
         /e3APz850iUPCb7Q1r6H/fI6TnX3xsw+d/H9zj+fPL+RqGmvvNgAk/fO9LwnA+t4vOZm
         AwbXVuOwMQug2/ALxxzmD53rOO/Hq7uR0VVaAR/DaAmML+KUmBzdgOI5oVNYdNwuZL6o
         AjuK9x4ba1XAueUHAUV5jpKNyegVH25TlJJ4tI5ffSaBlEOjzo5xVpf1ZXLqmCB51CEt
         W727yWOcDD8cVs+KF59hIyi4UMbznm49ZpRbPfZqV0ReECKFoTolqjNpP4GFgTxXQiau
         GRoA==
X-Forwarded-Encrypted: i=1; AJvYcCWf99ONyozQ+v6o8H/der2sVU+zF2Q9KTiXadgCc2oSpUHfvAYtU9VOVXKd1tqMpTlElHmXgYAh9/m4mlj+ymZ98CGCdIo1mjRw
X-Gm-Message-State: AOJu0YyR1nrgsuUgSRFwnxEJ3WApIevvk1oE7OxJyvNIjVa3ledM3qDR
	TjNgvB7pCP5Uj8zEHNl0+zE5czbOMr3up84TF0XVKkItOz/kPGkWbOQNqvBg0A==
X-Google-Smtp-Source: AGHT+IHKtvkY079sKvFbqDADGlC4HQuwO2igps/bWVPvWdcwk5eD1ogS2YqqT0mSGNl0hb5X7VXRnQ==
X-Received: by 2002:a17:902:d2cd:b0:1e3:e1d5:c680 with SMTP id n13-20020a170902d2cd00b001e3e1d5c680mr8239892plc.63.1714844257033;
        Sat, 04 May 2024 10:37:37 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id nw10-20020a17090b254a00b002b0e8d4c426sm7120152pjb.11.2024.05.04.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:37:36 -0700 (PDT)
Date: Sat, 4 May 2024 23:07:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 14/14] arm64: dts: rockchip: Add rock5b overlays for
 PCIe endpoint mode
Message-ID: <20240504173730.GK4315@thinkpad>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-14-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-14-a0f5ee2a77b6@kernel.org>

On Tue, Apr 30, 2024 at 02:01:11PM +0200, Niklas Cassel wrote:
> Add rock5b overlays for PCIe endpoint mode support.
> 

I'm not aware of mainline using overlays. Is this a new one?

- Mani

> If using the rock5b as an endpoint against a normal PC, only the
> rk3588-rock-5b-pcie-ep.dtbo needs to be applied.
> 
> If using two rock5b:s, with one board as EP and the other board as RC,
> rk3588-rock-5b-pcie-ep.dtbo and rk3588-rock-5b-pcie-srns.dtbo has to
> be applied to the respective boards.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile              |  5 +++++
>  .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  | 25 ++++++++++++++++++++++
>  .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     | 16 ++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index f906a868b71a..d827432d5111 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -117,6 +117,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
> @@ -127,3 +129,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> +
> +# Enable support for device-tree overlays
> +DTC_FLAGS_rk3588-rock-5b += -@
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
> new file mode 100644
> index 000000000000..672d748fcc67
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * DT-overlay to run the PCIe3_4L Dual Mode controller in Endpoint mode
> + * in the SRNS (Separate Reference Clock No Spread) configuration.
> + *
> + * NOTE: If using a setup with two ROCK 5B:s, with one board running in
> + * RC mode and the other board running in EP mode, see also the device
> + * tree overlay: rk3588-rock-5b-pcie-srns.dtso.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&pcie30phy {
> +	rockchip,rx-common-refclk-mode = <0 0 0 0>;
> +};
> +
> +&pcie3x4 {
> +	status = "disabled";
> +};
> +
> +&pcie3x4_ep {
> +	vpcie3v3-supply = <&vcc3v3_pcie30>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
> new file mode 100644
> index 000000000000..1a0f1af65c43
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * DT-overlay to run the PCIe3_4L Dual Mode controller in Root Complex
> + * mode in the SRNS (Separate Reference Clock No Spread) configuration.
> + *
> + * This device tree overlay is only needed (on the RC side) when running
> + * a setup with two ROCK 5B:s, with one board running in RC mode and the
> + * other board running in EP mode.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&pcie30phy {
> +	rockchip,rx-common-refclk-mode = <0 0 0 0>;
> +};
> 
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

