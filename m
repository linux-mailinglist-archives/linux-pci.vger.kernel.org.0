Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2103774FF
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 04:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhEICg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 May 2021 22:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhEICgy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 May 2021 22:36:54 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED8C061760
        for <linux-pci@vger.kernel.org>; Sat,  8 May 2021 19:35:51 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v22so7713147oic.2
        for <linux-pci@vger.kernel.org>; Sat, 08 May 2021 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9Ua8oWrlaXnevwp1qRBCTYfaP2Kxy6kKlxQ7g9TNto=;
        b=aRah5HVhSQD2lY7Xysyz+2AAdfczQP8Cm3324TGvJUGJI/x+4x2lqCvG4Ty1CKpdwh
         TQfIf5fon4xgumYNce3vmWzt2iuX5B/Al88wm/2e4sE5u0TGjfx+Esua0zUzMPtGv+oA
         JVB0gx/ThQiaNav1FYRkqZ9Fg5XcW/Ue83SFtKJj+cvnd89PrlUfigCwR7AMo2VD3yse
         1++MuCy/qtJIPrVMxvv8oMVVbwHQETO4Uu0AtyHUaXbsFIVc70dBOYDMUsAVc/utvpKC
         QfswuKwRK0qfPXYLLLuUqJzQz+qPr5WRo9kneZsEJQKB9k1VtdnBTAz49lxzPVGmvEez
         oAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9Ua8oWrlaXnevwp1qRBCTYfaP2Kxy6kKlxQ7g9TNto=;
        b=nyTd41YYZkubF7BgCft/pmZ4zSdJ0s9HotnQavXFVsRSeuscstQ69eSgHvvuVHvm5k
         2cxQR8tNgosNKsZ0bY0IKKMkUCpvM1TY0oz+PhOYVhP8zw91DRG4ByPfpetBj6sEAQIR
         wreGQxFUxkYeltWg5lM31Bb1zdZvE231oE5fONSE9JriWR98OeVwhofqeyEdefNPgEiB
         46Ez6pdX6pVKyLo836Vm4DxjHmxDAvhppLFUFAE3CNNqGzwqiGgXVqJn7umnPgQtPPGe
         48DtjCTJTeKgYQLdO+rdkMgyz+aqGpLY3q+4k9XfkeJZbzuhnbaw5I9cZ/Xy0AjJeo0M
         es9g==
X-Gm-Message-State: AOAM530NwMP6E729o6k6zRZ3yDghXzCJtN5d+/Ht8VI87qReWt0NppYl
        4UMchKbXex7y2YuEpBznhnHOEQ==
X-Google-Smtp-Source: ABdhPJyVHEOsinNeIS1NO9xmznO1ZsHBCrMXt2BUBxRe+9jUIF88nrsAk0L02sHsbDYILGyL7tND8g==
X-Received: by 2002:aca:d493:: with SMTP id l141mr7303636oig.51.1620527750843;
        Sat, 08 May 2021 19:35:50 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x65sm848344otb.59.2021.05.08.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 19:35:50 -0700 (PDT)
Date:   Sat, 8 May 2021 21:35:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH] PCIe: qcom: Add support to control pipe clk mux
Message-ID: <20210509023547.GJ2484@yoga>
References: <1620520860-8589-1-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620520860-8589-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 08 May 19:41 CDT 2021, Prasad Malisetty wrote:

> PCIe driver needs to toggle between bi_tcxo and phy pipe
> clock as part of its LPM sequence. This is done by setting
> pipe_clk/ref_clk_src as parent of pipe_clk_src after phy init
> 
> Dependent on below change:
> 
> 	https://lore.kernel.org/patchwork/patch/1422499/

In what way is this change to the driver dependent on the addition of
the node to DT?

> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..a9f69e8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>

Can you help me see why this is needed?

>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -166,6 +167,9 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
>  	struct clk *pipe_clk;
> +	struct clk *pipe_clk_src;
> +	struct clk *pipe_ext_src;
> +	struct clk *ref_clk_src;
>  };
>  
>  union qcom_pcie_resources {
> @@ -1168,7 +1172,19 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  		return ret;
>  
>  	res->pipe_clk = devm_clk_get(dev, "pipe");
> -	return PTR_ERR_OR_ZERO(res->pipe_clk);
> +	if (IS_ERR(res->pipe_clk))
> +		return PTR_ERR(res->pipe_clk);
> +
> +	res->pipe_clk_src = devm_clk_get(dev, "pipe_src");
> +	if (IS_ERR(res->pipe_clk_src))

How does this not fail on existing targets?

> +		return PTR_ERR(res->pipe_clk_src);
> +
> +	res->pipe_ext_src = devm_clk_get(dev, "pipe_ext");
> +	if (IS_ERR(res->pipe_ext_src))
> +		return PTR_ERR(res->pipe_ext_src);
> +
> +	res->ref_clk_src = devm_clk_get(dev, "ref");
> +	return PTR_ERR_OR_ZERO(res->ref_clk_src);
>  }
>  
>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> @@ -1255,6 +1271,11 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280"))

Why is this specific to sc7280?

> +		clk_set_parent(res->pipe_clk_src, res->pipe_ext_src);

The naming here is not obvious to me, but I think you're going to use
this to set parent of gcc_pcie_0_pipe_clk_src to pcie_0_pipe_clk?

But in the commit message you're talking about switching back and forth
between the pipe clock and tcxo, can you please help me understand where
this is happening?


PS. The new clocks should be mentioned in the binding.

Regards,
Bjorn

>  
>  	return clk_prepare_enable(res->pipe_clk);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
