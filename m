Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43E4A8986
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbiBCRLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352810AbiBCRLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 12:11:05 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F1C0613E3
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 09:10:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x193so5163280oix.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyTnLRq74SMNTbBGSC7BPrM96WbFmvv/b/YCqRhJKOE=;
        b=thfJm2vpV7VaNu1lzrEG23OTmJsIHNzwHkX5JsY7aQhT0djoFZQjP4WbvWmzgMX1cE
         RgB7VYmGPR90SJr5tBbfTbSqWyV3Zq1VGeheW+VcHDGI1pBPHdYoo0xncHYi5bxIm0z/
         FJttwfCXgr+iSUbkSSpGH54np+ONYksPsh3OcSz3nhPuEZvH7QMawaWaVhPcczB/qcoh
         byuE8Cu4teph0I2bnsxg88DB6rHFQavLj1aUAoJQiqbdR2R7NKAguLy1140kcERS6BLk
         apaz7j+GBcmfVF31LgOSeYGL1zbvLVee1nLE+vyhb9e7RQFwEhg8m65karUqF9STUz+E
         9uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyTnLRq74SMNTbBGSC7BPrM96WbFmvv/b/YCqRhJKOE=;
        b=G8w9TGxXpZvoYMriQ8oOBHTV9RMSFxj+unfVy1UBGYgIdgyUIxcHBMR7miqIANumQy
         HID5ALz6bR5SZ6tUFawEN52zXnbw5603I/x3y+FJIo3BZoSEqsfsXRcILUfW82Mbc23l
         AMQ5ErmC+BKWAZZGHeeR5vHyGG8VSZ6jSSqgtt9qTZVvmYIuu6ax9/mJFE9POWfyM1/T
         Oi4mMwYJ8JcRXA7jUJFNzDTpCovOxrdOhu5t5IHS0VDpi/0T1rUqV+66KIqC70mzpc0G
         fjsJDlTk9A/4Olml0HtBk/qckPC/cw47ljbQeSC7oFTnA3RN70DA+g0uFDxH7d+eWRYB
         x6pA==
X-Gm-Message-State: AOAM530L+YdYqXEuIPMv/sjC1bSxqnc7uAkpu0SSGuwwkMa3eOACIzDZ
        BdLLiMee/WKCWtpw0xtw/Fv9yQ==
X-Google-Smtp-Source: ABdhPJwK5V2IWgDRWmJUgoelR05uxNUjVGwc6M3avl68/CttOm1hmc7QnHQECMSMDwdigQmIe1SNdA==
X-Received: by 2002:a05:6808:1590:: with SMTP id t16mr8091182oiw.215.1643908250910;
        Thu, 03 Feb 2022 09:10:50 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id g4sm19145118otl.1.2022.02.03.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:10:50 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:11:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YfwMq/kjmjr4d4t4@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:

> Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
> to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
> different set of clocks, so two compatible entries are required.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

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
