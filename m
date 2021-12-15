Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6B4764A9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhLOVhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:37:24 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37795 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhLOVhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:37:24 -0500
Received: by mail-ot1-f50.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26513476otg.4;
        Wed, 15 Dec 2021 13:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiVd6i1mSOf4f84+8yVBYJ1g96mSqYbzqmAOlstb8S8=;
        b=p6YjnGkRkCCnA8/hXlocB55PGOE4Goev27CBj/93Y9C/2+usEp8DKH7XS/dCVcz1y+
         cFNUqcfQ4xnVOCpnEXzpJsMqpdg7ZFiwA/I+OZz0701AJ5S+fJZrd5LBaiK8nIH4GYlQ
         6EJ7ynVp5geVAm8M3SlnveDXmObyo0P09jrNsl3jf8RgpWuXBnY5tG3jawIqpWqa0iPA
         vlpUhuAX/zR0zApsGTK6yMzIW/ne67MpuGij4yaNgSU/j1VfuvQ0zRmH8FcT+HH/SVex
         l4Rl/oIcDEwXTOZfd3yNzzzAX6LN1EptTzHyyY4luwIUfKt5RwmAOMUro2xByiOCr8Z/
         /DkQ==
X-Gm-Message-State: AOAM531B9L/aVf5jyIiRzJpm34AtUOyfY6AduXuHIAMIHXFIdJ+kELK7
        N6tSqfJoVReALeIOgxpz3Q==
X-Google-Smtp-Source: ABdhPJwHU9bys0Ld9Zwop7bOlHmKE70OIYouBaZ09r1gBb0zvlpKTs6gyHZUnDytfQ0lyR1Ac6L0IQ==
X-Received: by 2002:a9d:6254:: with SMTP id i20mr10433919otk.343.1639604243374;
        Wed, 15 Dec 2021 13:37:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm555096oij.16.2021.12.15.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:37:22 -0800 (PST)
Received: (nullmailer pid 1883028 invoked by uid 1000);
        Wed, 15 Dec 2021 21:37:21 -0000
Date:   Wed, 15 Dec 2021 15:37:21 -0600
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
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YbpgEQkPBG8QS/0w@robh.at.kernel.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
 <20211214225846.2043361-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214225846.2043361-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 01:58:37AM +0300, Dmitry Baryshkov wrote:
> Document the PCIe DT bindings for SM8450 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SM8450.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

I hope someone decides to convert this to schema soon...

> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index a0ae024c2d0c..73bc763c5009 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -15,6 +15,7 @@
>  			- "qcom,pcie-sc8180x" for sc8180x
>  			- "qcom,pcie-sdm845" for sdm845
>  			- "qcom,pcie-sm8250" for sm8250
> +			- "qcom,pcie-sm8450" for sm8450
>  			- "qcom,pcie-ipq6018" for ipq6018
>  
>  - reg:
> @@ -169,6 +170,24 @@
>  			- "ddrss_sf_tbu" PCIe SF TBU clock
>  			- "pipe"	PIPE clock
>  
> +- clock-names:
> +	Usage: required for sm8450
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
> +			- "aggre0"	Aggre NoC PCIe0 AXI clock
> +			- "aggre1"	Aggre NoC PCIe1 AXI clock
> +
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -246,7 +265,7 @@
>  			- "ahb"			AHB reset
>  
>  - reset-names:
> -	Usage: required for sc8180x, sdm845 and sm8250
> +	Usage: required for sc8180x, sdm845, sm8250 and sm8450
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries
>  			- "pci"			PCIe core reset
> -- 
> 2.33.0
> 
> 
