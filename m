Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD8749CD7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGFM6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGFM6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 08:58:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC31BDB
        for <linux-pci@vger.kernel.org>; Thu,  6 Jul 2023 05:58:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51452556acdso486023a12.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Jul 2023 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688648299; x=1691240299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vELZbnMmNkmoaEABtrT3W1r0gqpXFf7Q4yaW/PDd3ic=;
        b=uriX3xdK4G/u9PN6mBy8tlT2/KJ0P8M7jWAuBjRLJ/Sih3nSDbV8mAztivxafEVHNJ
         8YJ5Ev71rDYVS9sAbJ4BjQPZARo+x8auRWKyfab4iBTVE92X8XvjqEj4HXMOEd3dmHV3
         spkEelpiOCMbkw46ss1wqPgSEKkaaChQthhVO5EiD0Yd/fWwaE/0elDbZImJXl0pdZeu
         3wlswkkrivh5CCwZ0/WXW+SkRAtnye0ZCgZSHBwcSbbQKjr/yfHhKnaB5ceempEX5KIP
         FfBlzoShO2K9CpwEf5NbX1i3xMioI2FI5vXnTigvPtnjTNnEychuIEnnCP2M0qxpXUOf
         b5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648299; x=1691240299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vELZbnMmNkmoaEABtrT3W1r0gqpXFf7Q4yaW/PDd3ic=;
        b=NtbECIPVhRHGLu9RZf9TmJwFP5gQJcKILTr8Od2Inz213vUCKoYMo4/P+gWaxYsZoX
         fB+SrcYoXmKkBG1/A1L82m35PBXWbPGazfIh4oN534TTXsz+E8qxaeFGrO7G0dG8RC9a
         mTr5TMx6juIwQUmxiFXy6zglNmUQcrNZ1d6+cyvs4XD4m909dMrnpf3ufifIrEW8pViZ
         EYy2EIYosXzr/y1/58CIKpIEiJ78/0/phI2tc6IVP3sO/cHqRNanh1/OE3KwCWD44pi0
         dgBE3ZiAFSovFPUWD2oBX15885yGHQzyhs/nUNxhX/4CtMBCw9nZwNlzX69gM6z1ZaXz
         D9og==
X-Gm-Message-State: ABy/qLZ9Ar7kFPgdHqSbAND40mgWG2jTBWNqfZ3DjFhpJbMSiouMC7TQ
        PdvUAtIrqqjQbXwbztBtJPCT
X-Google-Smtp-Source: APBJJlGgY2DJvQ7WORsziR5TIY14wortK+8ttKQP052qE+ZwOWaxnLN1tSdZdAigWZhWWtZHBBQ2zw==
X-Received: by 2002:a17:90b:1d81:b0:263:5eea:e820 with SMTP id pf1-20020a17090b1d8100b002635eeae820mr1179773pjb.26.1688648298965;
        Thu, 06 Jul 2023 05:58:18 -0700 (PDT)
Received: from thinkpad ([117.216.120.100])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090b018300b002635db431a0sm1275171pjs.45.2023.07.06.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:58:18 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:28:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <20230706125811.GD4808@thinkpad>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706082610.26584-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.
> 
> A recent commit broke controller probe by returning an error in case the
> link does not come up during host initialisation.
> 
> As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
> common code") and as indicated by the comment "Ignore errors, the link
> may come up later" in the code, waiting for link up and ignoring errors
> is the intended behaviour:
> 
> 	 Let's standardize this to succeed as there are usecases where
> 	 devices (and the link) appear later even without hotplug. For
> 	 example, a reconfigured FPGA device.
> 
> Reverting the offending commit specifically fixes a regression on
> Qualcomm platforms like the Lenovo ThinkPad X13s which no longer reach
> the interconnect sync state if a slot does not have a device populated
> (e.g. an optional modem).
> 
> Note that enabling asynchronous probing by default as was done for
> Qualcomm platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async
> probe by default"), should take care of any related boot time concerns.
> 
> Finally, note that the intel-gw driver is the only driver currently not
> providing a start_link callback and instead starts the link in its
> host_init callback, and which may avoid an additional one-second timeout
> during probe by making the link-up wait conditional. If anyone cares,
> that can be done in a follow-up patch with a proper motivation.
> 

The offending commit is bogus since it makes the intel-gw _special_ w.r.t
waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
probe time and they all have to wait for 1 sec if the slot is empty.

As Johan noted, intel-gw should make use of the async probe to avoid the boot
delay instead of adding a special case.

> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
> Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Cc: Sajid Dalvi <sdalvi@google.com>
> Cc: Ajay Agarwal <ajayagarwal@google.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++--------
>  drivers/pci/controller/dwc/pcie-designware.c  | 20 +++++++------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  3 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf61733bf78d..9952057c8819 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -485,20 +485,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (dw_pcie_link_up(pci)) {
> -		dw_pcie_print_link_status(pci);
> -	} else {
> +	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_remove_edma;
> -
> -		if (pci->ops && pci->ops->start_link) {
> -			ret = dw_pcie_wait_for_link(pci);
> -			if (ret)
> -				goto err_stop_link;
> -		}
>  	}
>  
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(pci);
> +
>  	bridge->sysdata = pp;
>  
>  	ret = pci_host_probe(bridge);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index df092229e97d..8e33e6e59e68 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -644,20 +644,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>  }
>  
> -void dw_pcie_print_link_status(struct dw_pcie *pci)
> -{
> -	u32 offset, val;
> -
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -
> -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> -}
> -
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  {
> +	u32 offset, val;
>  	int retries;
>  
>  	/* Check if the link is up or not */
> @@ -673,7 +662,12 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> -	dw_pcie_print_link_status(pci);
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 615660640801..79713ce075cc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -429,7 +429,6 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
> -void dw_pcie_print_link_status(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -- 
> 2.39.3
> 

-- 
மணிவண்ணன் சதாசிவம்
