Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6231A8700
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407549AbgDNRIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:08:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41857 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407530AbgDNRIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:08:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so11031591oia.8;
        Tue, 14 Apr 2020 10:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOg268FFVsO+C5484wtK+Oo+ZNK0YfLEQrbXDQF4dqw=;
        b=NhBvGeLutsHW9qtTvvj6IJu6ZuxPjm1y1PwUXJlYV5ex5pybUrSbzr6rHsAEUkUD6n
         J1FFNN4Ls0z2cixg2xnKV4PJ5vTTsLYBtsh/4otO5mkXdo4J0Avq+PtJenEy06T7CdhP
         4x3ozXbuxbpEMYen3K/cOHKKM+7Gv4jUUfxesZdnUOR2AN3kuOLkfTV/Z0XQygcgwFqI
         6Gb4j+icMmJppIM/NkBM1frxBONveLncMDwH0AWJeuKfI9IT3A6XaORGIL3izb1klzqh
         /HDLN7dyansx8wPTPKy69IiLQmnS5b82HF5DLXgrWeLL0RFOrOUF9EA6Vxpk7euFL0bP
         Vf3A==
X-Gm-Message-State: AGi0PuZlVq4NgTY9FGjJXu1/og4o1NlOn9W28fA87FSaWf0sftKCO5nl
        c0OmhfZc8adUNSwxhfhp2Q==
X-Google-Smtp-Source: APiQypLVFxxloqkrmc9Y5H2iBwAGSJq7TW6L7uB7EpGKSVsWk/xsu9Dy3phELmaedP8rPFuzSdgAIg==
X-Received: by 2002:aca:5194:: with SMTP id f142mr8346267oib.100.1586884079466;
        Tue, 14 Apr 2020 10:07:59 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l28sm1418665ota.4.2020.04.14.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:07:58 -0700 (PDT)
Received: (nullmailer pid 12945 invoked by uid 1000);
        Tue, 14 Apr 2020 17:07:57 -0000
Date:   Tue, 14 Apr 2020 12:07:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] devicetree: bindings: pci: add ipq8064 rev 2
 variant to qcom,pcie
Message-ID: <20200414170757.GA11622@bogus>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-10-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402121148.1767-10-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 02, 2020 at 02:11:46PM +0200, Ansuel Smith wrote:
> Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
> In ipq8064 phy_tx0_term_offset is 7, in rev 2, ipq8065 and other SoC it's
> set to 0 by default.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 6efcef040741..b699f126ea29 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -5,6 +5,7 @@
>  	Value type: <stringlist>
>  	Definition: Value should contain
>  			- "qcom,pcie-ipq8064" for ipq8064
> +			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
>  			- "qcom,pcie-apq8064" for apq8064
>  			- "qcom,pcie-apq8084" for apq8084
>  			- "qcom,pcie-msm8996" for msm8996 or apq8096
> @@ -295,6 +296,47 @@
>  		pinctrl-names = "default";
>  	};
>  
> +* Example for ipq8064 rev 2 or ipq8065

Just a new compatible string doesn't warrant a whole new example.

> +	pcie@1b500000 {
> +		compatible = "qcom,pcie-ipq8064-v2", "snps,dw-pcie";
> +		reg = <0x1b500000 0x1000
> +		       0x1b502000 0x80
> +		       0x1b600000 0x100
> +		       0x0ff00000 0x100000>;
> +		reg-names = "dbi", "elbi", "parf", "config";
> +		device_type = "pci";
> +		linux,pci-domain = <0>;
> +		bus-range = <0x00 0xff>;
> +		num-lanes = <1>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
> +			  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
> +		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
> +		interrupt-names = "msi";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +		clocks = <&gcc PCIE_A_CLK>,
> +			 <&gcc PCIE_H_CLK>,
> +			 <&gcc PCIE_PHY_CLK>,
> +			 <&gcc PCIE_AUX_CLK>,
> +			 <&gcc PCIE_ALT_REF_CLK>;
> +		clock-names = "core", "iface", "phy", "aux", "ref";
> +		resets = <&gcc PCIE_ACLK_RESET>,
> +			 <&gcc PCIE_HCLK_RESET>,
> +			 <&gcc PCIE_POR_RESET>,
> +			 <&gcc PCIE_PCI_RESET>,
> +			 <&gcc PCIE_PHY_RESET>,
> +			 <&gcc PCIE_EXT_RESET>;
> +		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
> +		pinctrl-0 = <&pcie_pins_default>;
> +		pinctrl-names = "default";
> +	};
> +
>  * Example for apq8084
>  	pcie0@fc520000 {
>  		compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
> -- 
> 2.25.1
> 
