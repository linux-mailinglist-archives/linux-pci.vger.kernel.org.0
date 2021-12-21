Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38E147C215
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhLUO7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:59:36 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44883 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhLUO7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:59:35 -0500
Received: by mail-qt1-f169.google.com with SMTP id a1so13018085qtx.11;
        Tue, 21 Dec 2021 06:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdY8eJ3b8gIHmOjY8jOpNQudFdqG5PeN9eLzoM3qKnw=;
        b=Ka4G39Yt6Dtn8rdp/9o4zCt6qlVpvjWtA3kZba9NKcAWVB9v2WwEyxOucQNmD2B7hB
         oJglnGreoxtYS0Njyl56jSxXB04UwZpa3Jmkb0BxQnKg3PMyNsGqvapzgFOo4oViTJHP
         1mi4rCToho4XsdqqNpBP485QewQIKFUsn/3zdx1bOZKxlwQc+jK0ny6h3QhYvDet7t/Y
         OYo1ksEmsbVyxj+ryVHC5Y/Yd77sVthpwvaG2mGJxlKdLZS/vJWbFV1QbuD16E+EZkRA
         qmO853ChLNjljvK+nZIMSgL3dmNYX5T0ckBYcWF4bcWZ4Y2pg4d1xhhdnQRTQ/Iygj06
         qIWQ==
X-Gm-Message-State: AOAM533xTmz2VnpY7z9+r/blkz3xabYJaIC8A+GsNePl2jPOJrCL9glG
        qZLrh4XqchCh+MXEzh9ixqbP2AWjhNMP
X-Google-Smtp-Source: ABdhPJwz8IpgYskPYVVDXd8Hm6lcmXvWy1o3h4wh8B+dYaiYsY9n+91H5bL0oPXDn0Bz3Q9J61mRvQ==
X-Received: by 2002:ac8:5881:: with SMTP id t1mr2510729qta.414.1640098774575;
        Tue, 21 Dec 2021 06:59:34 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id e14sm532762qts.15.2021.12.21.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:59:33 -0800 (PST)
Received: (nullmailer pid 1408248 invoked by uid 1000);
        Tue, 21 Dec 2021 14:59:31 -0000
Date:   Tue, 21 Dec 2021 10:59:31 -0400
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YcHr0/W0QqRlj1Ji@robh.at.kernel.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 18, 2021 at 05:10:20PM +0300, Dmitry Baryshkov wrote:
> Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
> to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
> different set of clocks, so two compatible entries are required.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index a0ae024c2d0c..0adb56d5645e 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -15,6 +15,8 @@
>  			- "qcom,pcie-sc8180x" for sc8180x
>  			- "qcom,pcie-sdm845" for sdm845
>  			- "qcom,pcie-sm8250" for sm8250
> +			- "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
> +			- "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450

What's the difference between the two?

>  			- "qcom,pcie-ipq6018" for ipq6018
>  
>  - reg:
> @@ -169,6 +171,24 @@
>  			- "ddrss_sf_tbu" PCIe SF TBU clock
>  			- "pipe"	PIPE clock
>  
> +- clock-names:
> +	Usage: required for sm8450-pcie0 and sm8450-pcie1
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"         Auxiliary clock
> +			- "cfg"         Configuration clock
> +			- "bus_master"  Master AXI clock
> +			- "bus_slave"   Slave AXI clock
> +			- "slave_q2a"   Slave Q2A clock
> +			- "tbu"         PCIe TBU clock
> +			- "ddrss_sf_tbu" PCIe SF TBU clock
> +			- "pipe"        PIPE clock
> +			- "pipe_mux"    PIPE MUX
> +			- "phy_pipe"    PIPE output clock
> +			- "ref"         REFERENCE clock
> +			- "aggre0"	Aggre NoC PCIe0 AXI clock, only for sm8450-pcie0
> +			- "aggre1"	Aggre NoC PCIe1 AXI clock
> +
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -246,7 +266,7 @@
>  			- "ahb"			AHB reset
>  
>  - reset-names:
> -	Usage: required for sc8180x, sdm845 and sm8250
> +	Usage: required for sc8180x, sdm845, sm8250 and sm8450
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries
>  			- "pci"			PCIe core reset
> -- 
> 2.34.1
> 
> 
