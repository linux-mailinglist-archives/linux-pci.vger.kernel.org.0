Return-Path: <linux-pci+bounces-21278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2346A31E5D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2753A732A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D921FAC57;
	Wed, 12 Feb 2025 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWmcHhUG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DF1FAC5B;
	Wed, 12 Feb 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339843; cv=none; b=P1eScOVF70zOTLpNGa3MZ7dlz+Q92cV1fxY+qusUq6X0kwkpOh3qN2Y4PCqI///EtGAPgl2698pIczV0aOaaCiH4xrEPosCEv1YTYYB9v65nGeQExBXeOxOk48DYrE3Y+Di7d19TrEU2wazPMWAYD1kmnX8v3pW8QYhIv7wEWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339843; c=relaxed/simple;
	bh=WBxhnT3k4XJ8sdI3owlB//G4F1gO4Jtahnet4CiM9x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB8t0V/AD5CgI814/SfVvt/QrtAhqvI1USfu81nmVBdDh1UpHJ7hi/oYQ5M/9EsMnx4XlbsVK/Ht3GTF3NALGrEww3L3WQme8B6TXN7/Gap+c1G+2ok1oZ7CMoaDt5mNF2FOSbxtt6yTHNoy1WnMSvw7ikCRb1B59o9x8fjeL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWmcHhUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A1C4CEDF;
	Wed, 12 Feb 2025 05:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739339842;
	bh=WBxhnT3k4XJ8sdI3owlB//G4F1gO4Jtahnet4CiM9x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZWmcHhUGjAoyDhLANodgCcaqfCnniiC6qc7pBcuwjrM1vOX2YvjtAkbfeN4YuyC3o
	 DtSBRTHMCXvSEelw7rsH39P4lVQC5DEAIYu6Aq9n1ROduAwXoct/Q86V9g6RIGUea7
	 lzGnGa3udTr5X6Asy6zBrPm1yo/jl5OlaaKXltmYM5HaGoZ3e9xLfB1hFCpiLbU1In
	 vjllqdEaZ2kI0kqczqafTTgGUbvLf0FF7bhcOw0XUrlbe3g/jkud7vrkDt/jXclBZH
	 gvB8du4pp7Jj9I5dsTVMzhSTFJzaexE4U33Pi7e6HPIivmhOQE/uzOdWDRvFwd2bEq
	 uDVSLXAOQR5xA==
Message-ID: <38816f27-f2b4-4189-811b-d1809fad35e7@kernel.org>
Date: Wed, 12 Feb 2025 06:57:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] arm64: dts: agilex: move bus@80000000 to
 socfpga_agilex.dtsi
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com, peter.colberg@altera.com
References: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
 <20250211151725.4133582-4-matthew.gerlach@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250211151725.4133582-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 16:17, Matthew Gerlach wrote:
> The bus from HPS to the FPGA is part of the SoC. Move its
> device tree node to socfpga_agilex.dtsi to allow it to be
> referenced by any board.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v6:
>  - New patch to series.
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 10 +++++++
>  .../boot/dts/intel/socfpga_agilex_n6000.dts   | 28 +++++++------------
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 42cb24cfa6da..26ccdf042281 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -678,5 +678,15 @@ qspi: spi@ff8d2000 {
>  
>  			status = "disabled";
>  		};
> +
> +		bus80000000: bus@80000000 {
> +			compatible = "simple-bus";
> +			reg = <0x80000000 0x60000000>,
> +			      <0xf9000000 0x00100000>;
> +			reg-names = "axi_h2f", "axi_h2f_lw";
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <0x00000000 0x00000000 0x00000000 0x00000000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> index d22de06e9839..350c040ce9fe 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> @@ -25,24 +25,6 @@ memory@80000000 {
>  		/* We expect the bootloader to fill in the reg */
>  		reg = <0 0x80000000 0 0>;
>  	};
> -
> -	soc@0 {
> -		bus@80000000 {
> -			compatible = "simple-bus";
> -			reg = <0x80000000 0x60000000>,
> -				<0xf9000000 0x00100000>;
> -			reg-names = "axi_h2f", "axi_h2f_lw";
> -			#address-cells = <2>;
> -			#size-cells = <1>;
> -			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
> -
> -			dma-controller@0 {
> -				compatible = "intel,hps-copy-engine";
> -				reg = <0x00000000 0x00000000 0x00001000>;
> -				#dma-cells = <1>;
> -			};
> -		};
> -	};
>  };
>  
>  &osc1 {
> @@ -64,3 +46,13 @@ &watchdog0 {
>  &fpga_mgr {
>  	status = "disabled";
>  };
> +
> +&bus80000000 {

Keep some sort of sorting.

> +	ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;

ranges is property of the SoC in such case.

> +
> +	dma-controller@0 {
> +		compatible = "intel,hps-copy-engine";
> +		reg = <0x00000000 0x00000000 0x00001000>;
> +		#dma-cells = <1>;
> +	};
> +};


Best regards,
Krzysztof

