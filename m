Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661914A8FCC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354942AbiBCVY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 16:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354917AbiBCVY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 16:24:58 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C4C06173E
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 13:24:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t199so6087419oie.10
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEizoFh5dGc7xn7ZM0x/sSSf+5firRY6kzhR6U0etz8=;
        b=zLqLrDtpuptuWwv84+9kX/SWihv+uz4HW3FclIPcLVDqM6MV+np5qvarTHxcQvS9rL
         jwh1DQnbELQSjoTucnFJUQRilAYuqHawNRWztdEekA0hgL2+/r9NtGWCKLKvLySQHeD6
         x9BuapDp0ONHxiHjHXjafwVvSMt/8EKrcDyV+qUwNiAzRK1oiq/ogPNxS9RBCf7s1qJ5
         Oy9k8Sce95HYhE5cTK0WOHHEUnlvjFm41XAi19GCdcLedYWxwGL7o8VBSyM4IHXwvh7s
         tQOp1la/lFy3USIGoP4IXbGvGJ8sz0RRHgA0irPG23pA75XCHnmJkdNMM41I/Dnu59WA
         p5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEizoFh5dGc7xn7ZM0x/sSSf+5firRY6kzhR6U0etz8=;
        b=WXkjU7hrkkdzvUybLNLkTBaNDVKqDiXNd4qxzheB/RCIc8w3DqG3arGX2FauqPnt6D
         GBX9r91WBO6hOsaFpp2sULUngdrcVyrYcgmcBD5eNjsVGv9x2lJHK4W84W1zBUKqAZJ6
         zM76Q2fL/RiR2DBLysGmwTCBl0+DXa/o2KxkBVBAa3H8dEkBqsS6dSnqH/KQHoYq97UO
         DtES/VuvBxVECdZuFo3mgGHs7pwVqFLDlkjXrLtj3RSDQd8brGmqvj9Q3ed4J4jQw5pq
         ZnS0oeGyySG/JwwasRj04Oy5JKu8A9RR4WOa+dgT/QuGw1DLxVTQ30gXG9uCNVm0ROTb
         Z+CQ==
X-Gm-Message-State: AOAM530hvd5pXHrQr91QwtgHnc2Z7WVPqRLZuOiSfiv4pbQctRO90wGk
        uTgAfTtPLYn8bFqVWmAkcCgKOA==
X-Google-Smtp-Source: ABdhPJwznJ+hNC51HjfS5K4o3FOZsiPb1GJ7p6T9dwIUEGGWZU6vree76K+goH40Ccbm5MQVUXas7Q==
X-Received: by 2002:aca:3657:: with SMTP id d84mr8941592oia.212.1643923498231;
        Thu, 03 Feb 2022 13:24:58 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id y16sm1915oac.4.2022.02.03.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:24:57 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:25:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Fix pcie gpio entries
Message-ID: <YfxIOi9ZhVoUNvQJ@ripper>
References: <1643790082-18417-1-git-send-email-quic_pmaliset@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643790082-18417-1-git-send-email-quic_pmaliset@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 02 Feb 00:21 PST 2022, Prasad Malisetty wrote:

> Current gpio's in IDP file are not mapping properly,
> seeing device timedout failures.
> 

It's not obvious from the proposed patch which part fixes this and which
part relates to moving part of the nodes between dtsi and dts.

> Corrected pcie gpio entries in dtsi files.
> 
> Fixes: 4e24d227aa77 ("arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board")
> 

There's not supposed to be a blank line here.

> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++------------------
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 10 ++++++++-
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 78da9ac..84bf9d2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -243,9 +243,6 @@
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>  
>  	vddpe-3v3-supply = <&nvme_3v3_regulator>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>  };
>  
>  &pcie1_phy {
> @@ -360,6 +357,21 @@
>  
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
>  
> +&pcie1_reset_n {
> +	pins = "gpio2";
> +
> +	drive-strength = <16>;
> +	output-low;
> +	bias-disable;
> +};
> +
> +&pcie1_wake_n {
> +	pins = "gpio3";
> +
> +	drive-strength = <2>;
> +	bias-pull-up;
> +};
> +
>  &pm7325_gpios {
>  	key_vol_up_default: key-vol-up-default {
>  		pins = "gpio6";
> @@ -436,23 +448,6 @@
>  		function = "gpio";
>  	};
>  
> -	pcie1_reset_n: pcie1-reset-n {
> -		pins = "gpio2";
> -		function = "gpio";
> -
> -		drive-strength = <16>;
> -		output-low;
> -		bias-disable;
> -	};
> -
> -	pcie1_wake_n: pcie1-wake-n {
> -		pins = "gpio3";
> -		function = "gpio";
> -
> -		drive-strength = <2>;
> -		bias-pull-up;
> -	};
> -
>  	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
>  		pins = "gpio28";
>  		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d4009cc..2e14c37 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1640,7 +1640,7 @@
>  			phy-names = "pciephy";
>  
>  			pinctrl-names = "default";
> -			pinctrl-0 = <&pcie1_clkreq_n>;
> +			pinctrl-0 = <&pcie1_clkreq_n>, <&pcie1_reset_n>, <&pcie1_wake_n>;
>  
>  			iommus = <&apps_smmu 0x1c80 0x1>;
>  
> @@ -3272,6 +3272,14 @@
>  				bias-pull-up;
>  			};
>  
> +			pcie1_reset_n: pcie1-reset-n {

I find the idea of partially describing the state in two files hard to
follow - in particular you need to read both parts of &pcie1_reset_n to
understand what the state this represents.

Keep it as it was, and fix the problem you're seeing, without the
refactoring.

Regards,
Bjorn

> +				function = "gpio";
> +			};
> +
> +			pcie1_wake_n: pcie1-wake-n {
> +				function = "gpio";
> +			};
> +
>  			dp_hot_plug_det: dp-hot-plug-det {
>  				pins = "gpio47";
>  				function = "dp_hot";
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
