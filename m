Return-Path: <linux-pci+bounces-3653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924268589D2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 00:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B85288DB4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B305148FF9;
	Fri, 16 Feb 2024 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOXSXFWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93831146904
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125015; cv=none; b=KZS/3aDCcQUXkpmgDYGu5CMXIs6P3o9n0s1ZQnnnosN7yjk3rwFcxxFrU0WNHmdFoCymp+RMU7PzgQGD4piA6MvdDWFZF/Cjdb7DPyV3UUy4QF8M96YKO6E4hn6hEtHGKqKoP5l2S8/lzUVM5NMRd+4++/Ip69Fj5Prq2Bh5Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125015; c=relaxed/simple;
	bh=mfmEA6zSa+OORWqKlFgSku5kK5nwRZdQXnKi8D/SPd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvgqnRUYBvmsGPb5+Grgf2eP3YLld+5x328ln04DZYiFsl+vrFt3yjuEVdyMmA3dsMctcTJR2SfwAPQQ0EKbu6t6vrak2ZIEazpQS3YOwnsOmeRUawXoOeAH8CvKzxqS+E0inhHeazakq/FfQrUCxxhsWh5Vsa174m0O0uYc/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOXSXFWr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607fe8cc6d8so9763847b3.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 15:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708125010; x=1708729810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EpftqacOdWcIxz3VUpc3zI1U/E0RwbiBZdYsX7Kb7J4=;
        b=AOXSXFWrpecqGsj3FvbdDQIjHjP887SkBI4Bl4qgqmEyp6wk619/ClmzdoNIeOtz1j
         tDFBRTTZ4BXijtr5HVAG7cqu0BwWijfc2LxgvgRliDfPlGHPIGKzJIhHQjwHJelHjVyQ
         rp/dpDg/lvX62bGEdspeYlpgcqI7rCHt98CpiYsWMLSCTyHysVsLgsH/Mi9PXkv8IZPW
         RnrDP9WUVm04kHfQ67x4VehA87dgAMMC2vEyqSy2YCDH6nUvxKMvEaFL93I/+w8AsTPZ
         1hRoKNSn/OHxCPYYv+J9IC1EJfc+1aBHZQcbLbRU6Wlr1XeozRteflUVXWLLrhaypy2B
         //xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708125010; x=1708729810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpftqacOdWcIxz3VUpc3zI1U/E0RwbiBZdYsX7Kb7J4=;
        b=W6EWWIhA7wQenRWAjXcq8wMzmQYisyQ+td03SZ9Rtmk7T4txh70jXFmUOMcLRkT0zD
         TlfH04xppManTjQYtEe5ovL0JrQJDqbILNDW1lK7YmfobhRNLuXi/9pN9W3ErNfg1u0e
         0gTpOkgV/KydsunQ5xIlMNakM6bhSS8qKs5pJ97os/1oXKVlPbNo5SM8wrfjXxNDayH4
         F8fTsuwWt0X494hFOK7j1fl20l4LhxPEMSaFAjoukoO3dNhdIZeAD022xSClCfD9Elkf
         gUANZokSY/s20QIxnq+PgYzY7gVD+qJBI/fJkhk8+tVD2XU3TdJMaa3ZTa7LJ8kJPMbs
         NZaw==
X-Forwarded-Encrypted: i=1; AJvYcCWwW5soqalp9udji20T3mIvH2fUsQXtpXz61w6+D2T/QR+APNU1Uzo4XveOBaj+kSjcnjqi/I0jz95V09HjWU1ZTQN9Dq7gFW4e
X-Gm-Message-State: AOJu0YzjLesnhR909u0Gjipj7agSOJ0BXRfpCrAsTjBsyjabaEWByyhi
	Uieq6FAYIbt56Pt/oOGX07woQ4Pbr9akDu9+fEgmLxqkbkXVQFxF83VYlYhd8oa8Tfg+81vr/pr
	JOaA6bRh541XUfvheMGEeij4dyEhHWbPHOZSS/A==
X-Google-Smtp-Source: AGHT+IH7vS67BhaJmZ0qKWVe6no0q/4H1vlJ1cE1CsXNcFt1Pp6VcJPBg/0mptzu0uQFXbGKADhe7nfa9TyYWhC6deg=
X-Received: by 2002:a0d:ebc6:0:b0:607:ec66:36b3 with SMTP id
 u189-20020a0debc6000000b00607ec6636b3mr5019006ywe.19.1708125010589; Fri, 16
 Feb 2024 15:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-9-brgl@bgdev.pl>
In-Reply-To: <20240216203215.40870-9-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 17 Feb 2024 01:09:59 +0200
Message-ID: <CAA8EJpry2yiGXrtPqZ6RXnoTqQZr_hxA_gCPsUbmyFtEBuD4VA@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] arm64: dts: qcom: sm8650-qrd: add the Wifi node
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Neil Armstrong <neil.armstrong@linaro.org>
>
> Describe the ath12k WLAN on-board the WCN7850 module present on the
> board.

WCN7850 is the same combo WiFi + BT chip. Is there any reason for
describing its parts separately rather than using the same PMU
approach?

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [Bartosz:
>   - move the pcieport0 node into the .dtsi
>   - make regulator naming consistent with existing DT code
>   - add commit message]
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 29 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    | 10 +++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index b07cac2e5bc8..4623c358f634 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -845,6 +845,28 @@ &pcie0 {
>         status = "okay";
>  };
>
> +&pcieport0 {
> +       wifi@0 {
> +               compatible = "pci17cb,1107";
> +               reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wlan_en>;
> +
> +               enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
> +
> +               vdd-supply = <&vreg_s4i_0p85>;
> +               vddio-supply = <&vreg_l15b_1p8>;
> +               vddio1p2-supply = <&vreg_l3c_1p2>;
> +               vddaon-supply = <&vreg_s2c_0p8>;
> +               vdddig-supply = <&vreg_s3c_0p9>;
> +               vddrfa1p2-supply = <&vreg_s1c_1p2>;
> +               vddrfa1p8-supply = <&vreg_s6c_1p8>;
> +
> +               clocks = <&rpmhcc RPMH_RF_CLK1>;
> +       };
> +};
> +
>  &pcie0_phy {
>         vdda-phy-supply = <&vreg_l1i_0p88>;
>         vdda-pll-supply = <&vreg_l3i_1p2>;
> @@ -1139,6 +1161,13 @@ wcd_default: wcd-reset-n-active-state {
>                 bias-disable;
>                 output-low;
>         };
> +
> +       wlan_en: wlan-en-state {
> +               pins = "gpio16";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-pull-down;
> +       };
>  };
>
>  &uart14 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index d488b3b3265e..baf4932e460c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2293,6 +2293,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>                         dma-coherent;
>
>                         status = "disabled";
> +
> +                       pcieport0: pcie@0 {
> +                               device_type = "pci";
> +                               reg = <0x0 0x0 0x0 0x0 0x0>;
> +                               #address-cells = <3>;
> +                               #size-cells = <2>;
> +                               ranges;
> +
> +                               bus-range = <0x01 0xff>;
> +                       };
>                 };
>
>                 pcie0_phy: phy@1c06000 {
> --
> 2.40.1
>


-- 
With best wishes
Dmitry

