Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FE586C0C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiHANeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHANd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:33:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3223DF00
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:33:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d20so3196355pfq.5
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=536/nOu9oB/jOqMy9Eb+SUpTit6qwhFMo3WiMUo5s+g=;
        b=bdNSmwQB60A3QUUpSxaU9Hc0NidtfFRYWHsj44FA7em6LooJmvqbO6z8gWzMg6Kl8H
         l61ydKTuqEGZWb0gJiD/tAVXsOKNrrc0/TsazWcocwhX0BFtXixl+SwF4T0BZTA5F+NO
         Ej5hRI17Hoh1jaWuHKctcbuFZLPgzFvA5Cz+yQQ0L8rbrm9hp95oWeDRNWdVhz5Y5wRV
         tUp8WzPQWmi7fHOcArBSU+poLBZ+RB8XYqviYNdZAop/YnA1dHjYWKY1TPNlROvN75po
         eV5fJnEwxDHO6CezqK3ScdhcWxBGUWiY44Bxm+rveXTcweYPLFQs+TMd9XkZH3vooPpz
         vZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=536/nOu9oB/jOqMy9Eb+SUpTit6qwhFMo3WiMUo5s+g=;
        b=gl3i68BBVaJNSo0KsR+Lzm2B4PWy9ZkCBF2AGydidx2O6gwzyk+Fvzf9aFVga3Yqw8
         BRVo6gxeIC5kOSmppnZMYryTFnx/oEZf+ZbPU6chS5/qpS+OsezhKIrvqGSoPHHQAb1J
         PF877/1mK8MBJ9bd7bdmW7qOZwDKLCQjxD5b4LJ0Y2E+p+fPkk21SbwVxV4aDeODdGSq
         bCANpY9zT8QBwlqog/YicfbG56LFXGeZsvrQwlE9Y4I7mNCPdHy0a2ZyV/OvCY0rKkCM
         PspRPwfN2jSTORGbO98QkfDyD3PXdzu8igpdGT7H1x7yUb3xyGewW0FwRLN0F5JSJTnM
         L8xA==
X-Gm-Message-State: AJIora8n8jVrpTbOz9g7/WyByimkDb4+HFXfDsVcgnicobXPeM0WydY/
        1Yf5K/k5wlovHx4zx0T+PCue
X-Google-Smtp-Source: AA6agR7NWpjC9w5whwk8gFO05BfB8TyMAp85xpT+Ddgu9TFC1eIhvu3nan6OexFYIUMYNrGjVPKSNg==
X-Received: by 2002:a05:6a00:114f:b0:528:2c7a:634c with SMTP id b15-20020a056a00114f00b005282c7a634cmr16427775pfm.41.1659360837834;
        Mon, 01 Aug 2022 06:33:57 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b0016d72804664sm9456808pll.205.2022.08.01.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:33:57 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:03:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 08/15] PCI: dwc: Add host de-initialization
 callback
Message-ID: <20220801133348.GH93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-9-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:40PM +0300, Serge Semin wrote:
> Seeing the platform-specific DW PCIe host-initialization is performed from
> within the generic dw_pcie_host_init() method by means of the dedicated
> dw_pcie_ops.host_init() callback, there must be declared an antagonist
> which would perform the corresponding cleanups. Let's add such callback
> then. It will be called in the dw_pcie_host_deinit() method and in the
> cleanup-on-error path in the dw_pcie_host_init() function.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index b1437b37140f..4f984c845b59 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -354,13 +354,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>  		} else if (pp->num_vectors > MAX_MSI_IRQS) {
>  			dev_err(dev, "Invalid number of vectors\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_deinit_host;
>  		}
>  
>  		if (pp->ops->msi_host_init) {
>  			ret = pp->ops->msi_host_init(pp);
>  			if (ret < 0)
> -				return ret;
> +				goto err_deinit_host;
>  		} else if (pp->has_msi_ctrl) {
>  			u32 ctrl, num_ctrls;
>  
> @@ -372,8 +373,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
>  				if (pp->msi_irq < 0) {
>  					pp->msi_irq = platform_get_irq(pdev, 0);
> -					if (pp->msi_irq < 0)
> -						return pp->msi_irq;
> +					if (pp->msi_irq < 0) {
> +						ret = pp->msi_irq;
> +						goto err_deinit_host;
> +					}
>  				}
>  			}
>  
> @@ -381,7 +384,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  			ret = dw_pcie_allocate_domains(pp);
>  			if (ret)
> -				return ret;
> +				goto err_deinit_host;
>  
>  			if (pp->msi_irq > 0)
>  				irq_set_chained_handler_and_data(pp->msi_irq,
> @@ -434,6 +437,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  err_free_msi:
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
> +
> +err_deinit_host:
> +	if (pp->ops->host_deinit)
> +		pp->ops->host_deinit(pp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> @@ -449,6 +457,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
> +
> +	if (pp->ops->host_deinit)
> +		pp->ops->host_deinit(pp);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index d247f227464c..7f1c00fa084d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -200,6 +200,7 @@ enum dw_pcie_device_mode {
>  
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
> +	void (*host_deinit)(struct dw_pcie_rp *pp);
>  	int (*msi_host_init)(struct dw_pcie_rp *pp);
>  };
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
