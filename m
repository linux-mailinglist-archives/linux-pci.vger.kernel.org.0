Return-Path: <linux-pci+bounces-28991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F156ACE397
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56881178520
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46E192D83;
	Wed,  4 Jun 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZzz5DLP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393C1F150B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058014; cv=none; b=tZfv3W+zuYMlu5NdKwod1zPxx2lbbTE96tgNInkT5hhfOGbTS1ea1FWBic8fgq5Z0IhvEDjDXxkuoKym1JPFrmEfkJjmpxSRZt8bUJP+AxElDxwCPzqM41YJcRWO2iLlIPxoGaWE2xff1fj3ejRbE4Bjpl/QUgYN+zx32g3G73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058014; c=relaxed/simple;
	bh=zfBX5Hd5AHFJx+b+JeKpO3p+lc17VsrFhnNhvgeTwMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFbcN/BxvJ+PmlEqoAq0gNx2cjXJQ2T43Pv4UF0et5IQjMGRJN2D7ysKH3Uz55g6Ddp7/Kqx9hJ8+5ZmPFXlK9nXvZ2+9Sd6vc9iBA0htpAxbUj0RY0dAlC1GCHC6rHiuMAY/n7JZNjLoDoZQX4uHbNxmFohySo9hm8qChhyrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZzz5DLP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso30094a12.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749058010; x=1749662810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjOqoffUv6nOmVjkm22wWdvmrQyYX67LoFIA7eUIS4c=;
        b=uZzz5DLPyX4RtUQ3Kpa8TeH20F3wJmRz6h76ajTJW4JeebutC9ThATN1VT30JpcdW3
         mWHjgth/0oUKeVrYkcf+leNOjci0D/A30sa81Efb6QiNTy3Kk5YZ++cOIZl6XQ1h++MN
         TIngVqJELxypCZ3LO2zlojScz21FaaxCB4QI6iosD01qBlNHGKToGY6t0PQXwvFyvcOx
         PA0GynNXlNQKMmSxgkYZ15Zgk68zEwO1Rvkm70VVegKLASPdMdzr4MlOQ5qCybhW0UE2
         w4L2JteYZTWnrmyhF4NyXIDq0u3rEIadKV6NTkWgcndDnY/gZxkbC4+T9dx8CZGbM8of
         rkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058010; x=1749662810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjOqoffUv6nOmVjkm22wWdvmrQyYX67LoFIA7eUIS4c=;
        b=QD0K2dvjvL3TzMWNZ3TaURzZlZFin4bXKgY8ie4w0j+KBEwZOm4uotsIGAu5N+KmkQ
         mPVW/1WSzn3vG9K7QwUx9oEy/UgGmaaI1MEi6OszarcLbY9kAdn4xJWjZFUpUekYZpte
         o/7g1/5/rDQsIPoJQC6wJqJx09NRSxkBWVSj2y3VMH+9iwxy0rXGsJjXQQJHa+aJgefE
         Ft3xNxOLBKEiEV2x5pFVv9d6FvZSgJ6Ce6euZ2dBduSzeQgty1dwFm15Ax2so7bPVzHX
         HPRJRoPrJemJOqdgkkCSdGHBQJ+ovqESxEt9KhiI/HYSnnaVXnR3sV4LgLyQKB1tc8cS
         r2uA==
X-Forwarded-Encrypted: i=1; AJvYcCURnZ90Sqt2Gkvu72nzT/Hi7KLJWOlde0LOOSY9TZ++Xxxh+K9m4ThGcnqCNViPFtxWZBRIZY6wbmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZE/5d8cwI8PjOCyLNRnxTgjj0IDWwwF8RaAJHwE3mZFdTLyM3
	AUzPYtGWlELqvsjmXI3I1pOZantbh99q4ZKBcEmZpuV8hMpZVXMet3kvPdUD/YABmg==
X-Gm-Gg: ASbGnctAOXm2mHt7RstUtd2c/FhiJDEU3ikCl/RP32/gQz3bab60rYzKn5xRAVA2y0b
	AWsByZZ6W1fgupS3EBv/5DWd1Hcre+EB+McdTzc3jkTSND21Fd2KvPfm0Yztxh5LskUDvtWa9bc
	cpWL6PqFfGuVRSfbQaoMtn4HLshtJ3cqcwFD/OpcgG+OCblxl7ztADqrwqORUhXXlkZpPc2Mf0Q
	Qe5nnO7n4tdSarWmEUgzznJq6cvtfXcMEc9TH6IyoyzWQvRjQpjr91pdjgM1wCuNni/5gvjjNXC
	QuYYKIP3WkTwsk1ElviGC6qLUCJY5B0jVG/M2Rh/vqST5PaOowxKSnW3lq9AmA==
X-Google-Smtp-Source: AGHT+IE7pUgMHsiK6fiB03xw5h0r4hqVnNjoiuF0h4s03T9Q5QTp4kFOwhIfaUC9GczffqkQkUVkZA==
X-Received: by 2002:a17:90b:4a41:b0:311:ea13:2e62 with SMTP id 98e67ed59e1d1-3130cd5dd59mr5987202a91.24.1749058010346;
        Wed, 04 Jun 2025 10:26:50 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e322315sm9178577a91.43.2025.06.04.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:26:49 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:56:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: renesas: r8a779g0: Describe root port
 on R-Car V4H
Message-ID: <mu2zj3ph5px34iyclaeirhry4nknevwqkqhqyyecugio2gpkst@fsaxfqtnc6nn>
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
 <20250530225504.55042-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530225504.55042-2-marek.vasut+renesas@mailbox.org>

On Sat, May 31, 2025 at 12:53:20AM +0200, Marek Vasut wrote:
> Add node which describes the root port into PCIe controller DT node.
> This can be used together with pwrctrl driver to control clock and
> power supply to a PCIe slot. For example usage, refer to V4H Sparrow
> Hawk board.
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
> V2: New patch
> ---
>  arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> index 6dbf05a559357..8d9ca30c299c9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -798,6 +798,16 @@ pciec0: pcie@e65d0000 {
>  					<0 0 0 4 &gic GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,enable-cdm-check;
>  			status = "disabled";
> +
> +			/* PCIe bridge, Root Port */
> +			pciec0_rp: pci@0,0 {
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				compatible = "pciclass,0604";
> +				device_type = "pci";
> +				ranges;
> +			};
>  		};
>  
>  		pciec1: pcie@e65d8000 {
> @@ -835,6 +845,16 @@ pciec1: pcie@e65d8000 {
>  					<0 0 0 4 &gic GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,enable-cdm-check;
>  			status = "disabled";
> +
> +			/* PCIe bridge, Root Port */
> +			pciec1_rp: pci@0,0 {
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				compatible = "pciclass,0604";
> +				device_type = "pci";
> +				ranges;
> +			};
>  		};
>  
>  		pciec0_ep: pcie-ep@e65d0000 {
> -- 
> 2.47.2
> 

-- 
மணிவண்ணன் சதாசிவம்

