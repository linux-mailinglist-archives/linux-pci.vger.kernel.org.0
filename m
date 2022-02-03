Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1760F4A8824
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiBCP5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 10:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352049AbiBCP5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 10:57:39 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF13C06173D
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 07:57:39 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso1845054oon.5
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8SvSzbd59UmkycNsXmpgzI9yGmgfD5pZgAqD9SL4Iw=;
        b=vHPVc7chXEK8xfd2k1jjj63JAbn72kRdFJAAgZDPEdRgClwYz2gFK3MVI/kcx/lNlZ
         0x+2yDywbAfAoSJl5cmnHcOnsYdWOfGcoyMptTMYPLcUFTWT+7Qv6FO5+JN/5mlHc0ja
         t4YU25OS6mwYqzBpxUTf/oD2czM7k+9/hD4ZNILagelBCJntBvvFR6UZwNi81mJ2H9zU
         qrzTjWes2UpWY+zKcuuTj2UOKD/jMaqURTsKCI3+dL+qFjFu95trOZF8FBMVEWLHAvJV
         q0+Sk720Ka6zNsRCjXiXUL8IXsguNbHobXXlmmabSK6WiaCo/T7A5wstEv1u8+5GxGdA
         g3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8SvSzbd59UmkycNsXmpgzI9yGmgfD5pZgAqD9SL4Iw=;
        b=hNWgJ++mLPx2/rPNRVU14dTU3g7MFetfaHElK47uNYvuLU6nwzEy3DMwykXHLXxgN1
         3fXs14ftIBfX3MrjrwIZT0ZEePpuTHLjPhYPilQmRqECa5TcnnYMxbnwwZV1EF6RZ26F
         HVaLWv7W2jTVKgIX5KdE2WCJY+kRegfRzcOTTtkzeSFSqWdv2nQaIJrUUJTjqbXy2JIi
         En64ca4kVi/9duC9FyN0fSqjCNwhYau9eMTGOon9rKV5afufPbw4BQV6XtB7nfhKVCe0
         T0+c2sFOkxYsZzlvjtg1l6Hnj6tWj6lUdIgtpxrZ/eGKUxpsEeUk5U2WJ+EQxWAEub+X
         krTA==
X-Gm-Message-State: AOAM533VJx/dBHKS+q7OwVVzpxJnVmOSkjM601wVf20Iol5Qs3KWxTEJ
        eSw/U9PEl/UtWnnEa7v3dJJTAqJIflScdg==
X-Google-Smtp-Source: ABdhPJyODJF45Cjmx4GtfDCTKc1xrrSopNuENSJ88j7tav9mvUwxZNuYbBU+4agG/vPbg4gbPy77lw==
X-Received: by 2002:a4a:94b0:: with SMTP id k45mr17349233ooi.64.1643903858451;
        Thu, 03 Feb 2022 07:57:38 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a26sm20524555oiy.26.2022.02.03.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:57:37 -0800 (PST)
Date:   Thu, 3 Feb 2022 07:57:54 -0800
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
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add interconnect support to
 2.7.0/1.9.0 ops
Message-ID: <Yfv7gh8YycxH2Wtm@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:

> Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
> bandwidth according to the values from the downstream driver.
> 

What memory transactions will travel this path? I would expect there to
be two different paths involved, given the rather low bw numbers I
presume this is the config path?

Is there no vote for the data path?

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d8d400423a0a..55ac3caa6d7d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
>  	struct clk *pipe_clk_src;
>  	struct clk *phy_pipe_clk;
>  	struct clk *ref_clk_src;
> +	struct icc_path *path;
>  };
>  
>  union qcom_pcie_resources {
> @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->pci_reset))
>  		return PTR_ERR(res->pci_reset);
>  
> +	res->path = devm_of_icc_get(dev, "pci");

The paths are typically identified using a string of the form
<source>-<destination>.


I don't see the related update to the DT binding for the introduction of
the interconnect.

Regards,
Bjorn

> +	if (IS_ERR(res->path))
> +		return PTR_ERR(res->path);
> +
>  	res->supplies[0].supply = "vdda";
>  	res->supplies[1].supply = "vddpe-3v3";
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> @@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>  
> +	if (res->path)
> +		icc_set_bw(res->path, 500, 800);
> +
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
> @@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>  
>  	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +	if (res->path)
> +		icc_set_bw(res->path, 0, 0);
>  
>  	/* Set TCXO as clock source for pcie_pipe_clk_src */
>  	if (pcie->cfg->pipe_clk_need_muxing)
> -- 
> 2.34.1
> 
