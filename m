Return-Path: <linux-pci+bounces-28992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65748ACE3A4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403A3A8485
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A76141987;
	Wed,  4 Jun 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qhc2Xxnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F911E8348
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058043; cv=none; b=iiQ9frY0rAnWX6vWp1qkEQIoZ5SnE2v6Dycr8j/PYS1USQGVoIxO3Sdpomv/umsid89Q7/U6WLyTv6rsrA8F/yu/jfNn+KNML1aXCWFCcC2oV6I2DrHlTX1Wa10X8kuoaLESiyemlbTgIFAI7dvkVHHflTNxcA+EE2G40QHX5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058043; c=relaxed/simple;
	bh=WkrEjRTp7ONtQhwntim4NbZfLp3T6Zg6YR+mnF+dMEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdnOX4BARsK2j9kuxBOWr7wbgN5Dg8wP02ybckuWRnk6TofnCGp/Kg+r/H/rllAuwoKoBQdwdiBvh6CW4+ayKwUD46L3kYw/3aJ1Gcr0gpPXKCZNq9HUK5i5nNaxAx9zH2uC2ENt1bHY2JrwO8eiitnB+6+P1SWdsoyG8zKHu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qhc2Xxnv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e1d4cba0so837475ad.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749058041; x=1749662841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7B9otxjjw86LIN97ls2HG35KDJxQJSkzx4ZMv9DYuA=;
        b=Qhc2XxnvYhc2xbBFlt4/ZtiyFaSJj9HROLP8Lk3fk9k1i31htYcyGGfpKu4jjTRyzc
         Lu9hvXd+oqAA+psnRWZP5335+oeAG4iO33bAkq7Q/ZRZSblkLPYdNabLeAKAt54G8rYj
         e9k2eeks3aBOOUurbZ8FRhcPRUHLi3PWvg0036RMbXrUuU/3kErWNg6BvTgzLdUG/Ogn
         Yjr2R6i7OkUribCXksS4PqPL5TX20SrWt5qkn0pr5Fgw/+2KPGdl5vOtpfP6PJosiV5r
         8M7f7I72PEUjiMzA5kwogebwlnegqkkPOW8GbHFedk064XZeu6auR+iaSusfm9mOX5bL
         chMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058041; x=1749662841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7B9otxjjw86LIN97ls2HG35KDJxQJSkzx4ZMv9DYuA=;
        b=SsGCDEqeT/owiq6fSty36750X7WDS8AYNeGEHVF43OyadpQUlL+O/x40Pl/oVvOyT9
         BzRO9632cgo6zWQNZh0ITsVSM9u46EbQXYRS4eHLIUi94+hWzINBFj8Kn0fx7MAcNCj1
         szCNJ6p84GtCGkM74pM7YLsy9iPkSYSRNKYmIxPXeuH0jveSA7lRgzxcVmsUAJ2P2EEN
         OWVzltd6yTnnOV0eFjexbrlXw0gcoQAar6jL53qpgtrKPlopAAWpN55NN+8zxcy1q3in
         lNdXOIaZWlq639NKhh93rimKdVcKsepoy6/d+1UX8ivTLB/K9bTj4e0uG85kRunOYR72
         u2pw==
X-Forwarded-Encrypted: i=1; AJvYcCXXHDxAu5bcB0om1TpFVgCtuAp9cEiUeSGOAl6S/HMY6bI1B0SbxfaTcGqCx3wiStgja6KdJQqRNfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIooWkPHKSjVWuyhaiSYjPSA/Xw/ANHeVhKybj9JTUxX/Qy4ne
	JYC53NvkjDuPk8HUeGycihYCNDMkA037ENJoOD9HN505GLPb70jXnaEOjoGVmwYJhg==
X-Gm-Gg: ASbGncuMToKFFrH8nA5LEtZen0HC6o62tRpKvOEdukfo4J3pPwld0kbKMNTcd0fVR17
	nCQApZzg3d0184BwiVabuaxCDg6gyAyLQ2YQN+4wScz5/fHqTZOhPP6zjXvqstj6paaJnojlERb
	li+Shohqz9XFBA+MrkEDQbMhFcI5nh1kIN8VPwU9PRRf3LTNyeJd12rsSOaZgxqB+ZwyEGwiwvX
	r0/5IIK6/rzt7mS0i144+s5cd0R5xwKbAjAgV/ECFxm/iHcUVPPsxslzKjg4tPexUcCwSESecmO
	yJbtojOncQ1J7u6aDw4R0heeJ7IeTVOJlCwBq7mvOAL1KR1bp8UYB7mDpPixbw==
X-Google-Smtp-Source: AGHT+IH1DWvZbMUTKY0iYBnPsO3u5V0VrOXZgYbT6v4V4ZwUlpiIxHERxxyfrv3KJRUYnHRg6IZfnA==
X-Received: by 2002:a17:902:dacb:b0:234:d10d:9f9f with SMTP id d9443c01a7336-235e11fc8bfmr52595515ad.40.1749058041460;
        Wed, 04 Jun 2025 10:27:21 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd92f8sm106368255ad.88.2025.06.04.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:27:21 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:57:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r8a779g3: Describe split
 PCIe clock on V4H Sparrow Hawk
Message-ID: <gfr63eotna6javssbrxj6lxifo3o3gypv62t5kg3tzjcyp6zbn@skh6th5vggwb>
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
 <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>

On Sat, May 31, 2025 at 12:53:21AM +0200, Marek Vasut wrote:
> The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
> bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
> Describe this split bus configuration in the board DT. The topology looks
> as follows:
> 
>  ____________                    _____________
> | R-Car PCIe |                  | PCIe device |
> |            |                  |             |
> |    PCIe RX<|==================|>PCIe TX     |
> |    PCIe TX<|==================|>PCIe RX     |
> |            |                  |             |
> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> '------------'      ||  ||      '-------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Use pciec0_rp/pciec1_rp phandles to refer to root port moved to core r8a779g0.dtsi
> ---
>  .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> index b8698e07add56..9ba23129e65ec 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> @@ -130,6 +130,13 @@ mini_dp_con_in: endpoint {
>  		};
>  	};
>  
> +	/* Page 26 / PCIe.0/1 CLK */
> +	pcie_refclk: clk-x8 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
>  	reg_1p2v: regulator-1p2v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "fixed-1.2V";
> @@ -404,6 +411,14 @@ i2c0_mux2: i2c@2 {
>  			reg = <2>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +
> +			/* Page 26 / PCIe.0/1 CLK */
> +			pcie_clk: clk@68 {
> +				compatible = "renesas,9fgv0441";
> +				reg = <0x68>;
> +				clocks = <&pcie_refclk>;
> +				#clock-cells = <1>;
> +			};
>  		};
>  
>  		i2c0_mux3: i2c@3 {
> @@ -487,26 +502,38 @@ msiof1_snd_endpoint: endpoint {
>  
>  /* Page 26 / 2230 Key M M.2 */
>  &pcie0_clkref {
> -	clock-frequency = <100000000>;
> +	status = "disabled";
>  };
>  
>  &pciec0 {
> +	clocks = <&cpg CPG_MOD 624>, <&pcie_clk 0>;
>  	reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>  
> +&pciec0_rp {
> +	clocks = <&pcie_clk 1>;
> +	vpcie3v3-supply = <&reg_3p3v>;
> +};
> +
>  /* Page 25 / PCIe to USB */
>  &pcie1_clkref {
> -	clock-frequency = <100000000>;
> +	status = "disabled";
>  };
>  
>  &pciec1 {
> +	clocks = <&cpg CPG_MOD 625>, <&pcie_clk 2>;
>  	/* uPD720201 is PCIe Gen2 x1 device */
>  	num-lanes = <1>;
>  	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>  
> +&pciec1_rp {
> +	clocks = <&pcie_clk 3>;
> +	vpcie3v3-supply = <&reg_3p3v>;
> +};
> +
>  &pfc {
>  	pinctrl-0 = <&scif_clk_pins>;
>  	pinctrl-names = "default";
> -- 
> 2.47.2
> 

-- 
மணிவண்ணன் சதாசிவம்

