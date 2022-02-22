Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1087A4C0587
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 00:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiBVXsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiBVXsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 18:48:18 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FB5130E
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:47:49 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so19965377ooi.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mNfJggOV7YP6vqkDY7Togq40JzvOACLm16iiua2Y2uw=;
        b=l2HJoH0cwLBgMyfkawLfhKR8cFTCEKZmdiN6esWuoyfxi5CbTTS9ue0w5bVdWhEVOV
         MW2W/F0yQYGIkYeKN1tKmj9WgwBYNJX4T5SK94vU8V3SxHXEdgUDqToZdv/UE9WrmFrv
         XPUA24QHlpi02giWZWhtxkCjfc4ThgxbejQSRCkj7rabK4txPFIOjWGkcuZiwb/WaVe3
         t4p4S0DJFjbboRWjUtQaWHZ0Az1AZEsBqcz0Qb8OfOOr85TN6fpajrmmycUVV38qp78L
         MHNZ4S3N/XT03ji5SDddX+/vAcYTLwc6W2KjK7eIXMJGRsz2VvjLrZ+f3JRWaCbNNbbO
         lqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mNfJggOV7YP6vqkDY7Togq40JzvOACLm16iiua2Y2uw=;
        b=uJoMb8cMFRx+6nbyiWsElgm+8luI4akQdVF4Y0gIKv/7ygJeqOovLLqb9UF2W6+Drk
         XrF21XUl60IkqB603XpAhAJyao7d0DHKWP773qngjNDfEaaoYWpsXO9/UIcUdVgeM9gF
         vs8/64rUBhkQsLs/fU4lRVxuhzEUH+dcNu+lT0Hezy08ZFcQexQmgr3V9HuF4+6j216A
         0u96jaObjslwBj3CTYP26xvqlN05Q3OPxBRDWaDowWmrwOARks6TxJm9tB+qhAk0dExa
         wnVkeoc46/Xskg/ARKSfKv2kIqUJBPQ6VO1hgLIqetYV/CFWMYCG1C7cDybcNbdyRLuP
         souQ==
X-Gm-Message-State: AOAM5304AbGHnU104mLZLzc3mHWn4asCZco+sUEPGcJGEHM+hEu6XuVX
        gDJ7EgMgjiMqdXt+MrDq3ZPzTA==
X-Google-Smtp-Source: ABdhPJzDOUvvuAGYdNLbTLaY4ZLSk9mbdrprvLOzCJJVN9oMZ575y6rrP65j/r/BKWpecEMZ8EIrMQ==
X-Received: by 2002:a05:6870:5b9e:b0:cf:f6de:3e89 with SMTP id em30-20020a0568705b9e00b000cff6de3e89mr2705326oab.94.1645573669196;
        Tue, 22 Feb 2022 15:47:49 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o15sm6764241ooi.31.2022.02.22.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:47:48 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:49:49 -0800
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
Message-ID: <YhV2nemA+t0cCdlP@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:

> Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
> bandwidth according to the values from the downstream driver.
> 
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

I think it's fair to assume that pretty much all platforms will have a
data path to reach the config registers and for the PCI to reach DDR.

So how about we place this in the common struct qcom_pcie instead?

Regards,
Bjorn

>  };
>  
>  union qcom_pcie_resources {
> @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->pci_reset))
>  		return PTR_ERR(res->pci_reset);
>  
> +	res->path = devm_of_icc_get(dev, "pci");
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
