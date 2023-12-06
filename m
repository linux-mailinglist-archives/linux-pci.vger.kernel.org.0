Return-Path: <linux-pci+bounces-575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D48073CC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAACB20E3D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DD405F5;
	Wed,  6 Dec 2023 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5ww8XIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99213FE58;
	Wed,  6 Dec 2023 15:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68019C433C8;
	Wed,  6 Dec 2023 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701876999;
	bh=S97fwyqurmhPwtoTkqcJFQVRifEWBxQOjTFb6lB82jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5ww8XIj7dj3TZOJxaCrFTldYB5ca7IqnJXRhLRleaWSkgIe+SY0xz2qBP4v/NKYJ
	 7pBQdCA+52VAEdNfmXilhOziH6wYC+lzMplb4RD70B9MyZj1T5bj/8327FhqbkcKjs
	 qlgCkt/U8gwmjFJ3R3vFwKnSwxLjtjmZ5usJyHE3olxbK1OFNXX9MwyWcZJnOz2sKD
	 IdtEZMQJJr+GbNQRfakj5L38f7gBhehO87P8KHGBghrUfCHrjEl4O8tSqHWZbHqitz
	 L4YVujLIp9vmo7HnBEDCEO2f4vF/GMhL/Begi9OwounWEY1el/YrWfmBEKrcn5Pgdw
	 iXes2HaDLetew==
Date: Wed, 6 Dec 2023 21:06:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
	rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
	jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
	jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
	viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
	steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
	vidyas@nvidia.com
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Message-ID: <20231206153627.GJ12802@thinkpad>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208111645.3863534-5-mmaddireddy@nvidia.com>

On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> Add PCIe port node under the PCIe controller-1 device tree node to support
> PCIe WAKE# interrupt for WiFi.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> 
> Changes in v14:
> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
> 
>  .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> index 8a9747855d6b..9c89be263141 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> @@ -2147,6 +2147,17 @@ pcie@14100000 {
>  
>  			phys = <&p2u_hsio_3>;
>  			phy-names = "p2u-0";
> +
> +			pci@0,0 {
> +				reg = <0x0000 0 0 0 0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +
> +				interrupt-parent = <&gpio>;
> +				interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> +				interrupt-names = "wakeup";

WAKE# should be part of the PCIe controller, not device. And the interrupt name
should be "wake".

- Mani

> +			};
>  		};
>  
>  		pcie@14160000 {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

