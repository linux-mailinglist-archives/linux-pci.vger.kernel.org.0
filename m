Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C7586C13
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiHANg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHANgy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:36:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4753247E
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:36:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u133so3968208pfc.10
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mJeVa4PBK70aWRppyHLGuCIpxqLQYXbh93oMjdhkXTc=;
        b=RkCxSo/gAU9PuX6oKcjeW2ExvtydKC4/+47raRDMMcivmMcgyw60ZSIsIsekTmLK4m
         pjDjl4+neNwwQG8w+oXSFoucXlLNIKEfsQlxyKShY2+oGi6k0mW0YiC1eta683BZqXuY
         +jNaMOfGahKTUUonPwobkp3Odiz98DUqBBzFhlus6MdFoKYw8gfLG8D2nUyYjIHD+2PX
         gXRx9Y7QsfgIsuJIRzV1kMURVyU0hWM7E5YdZJrU5gx+M8hzANsECNj3QYvMg9GdK8R2
         U1ewkdBS9jnsPaf02bKT68s7kw8aMLVGKh2V7Z2n3aKLpJ+wqmkL4G6RkBUORnqWfwEi
         FiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mJeVa4PBK70aWRppyHLGuCIpxqLQYXbh93oMjdhkXTc=;
        b=vD3p4pfYy2juUAbvY+WnlmGV8mvXrwctiQo9tOl40Oqi/8kCmjS5vDR1gO25TsyOxy
         MJ9r2AlBrc8J+TwVChyMZNYUW9QJDOMdE5PuB44WLs7FVjv/MstsITA6LVQiJT1VszTd
         TeLka97KyVNZJUJz4R0lHoupbcHGx6czghaKXy7hzeHS2S0DMhLHiVAQYaZGGuVgAN1h
         H8rocol+60Qerc5H80cmuwmVWDJP7LWWFs4DskqUhwpBfDfQRhEqxf+1ZQ8LD7uI7QNE
         MM9f5h4WhPP+zrFSUtECKQkcz6qPRHQ20kulloTIyzK1umUtEMuDD9u/2SYUEeXQjBsV
         CQSg==
X-Gm-Message-State: ACgBeo0gG3+Fj9DdMLtopkHY7yLySsofm8KKLQEfEXZZDho4ZM/3Q5rA
        /GZCMcjIkfdJoXs3BdiMKLlg
X-Google-Smtp-Source: AA6agR6qHwDnWg+PU610GtsaoLrgz6F2w9ki1uIKRjnJCQpW0pzlwjm08EXKDrKvi6po0Hd0Tt/OYw==
X-Received: by 2002:a05:6a00:e1a:b0:52d:9c84:24c1 with SMTP id bq26-20020a056a000e1a00b0052d9c8424c1mr2586853pfb.13.1659361011759;
        Mon, 01 Aug 2022 06:36:51 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016d6c939332sm9637057plh.279.2022.08.01.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:36:51 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:06:41 +0530
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
Subject: Re: [PATCH RESEND v4 09/15] PCI: dwc: Drop inbound iATU types
 enumeration - dw_pcie_as_type
Message-ID: <20220801133641.GI93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:41PM +0300, Serge Semin wrote:
> There is no point in having an enumeration declared in the driver for the
> PCIe end-point. First of all it's redundant since the driver already has a
> set of macro declared which describe the available in/out iATU types, thus
> having an addition abstraction just needlessly complicates the code.
> Secondly checking the passed iATU type for validity within a single driver
> is pointless since the driver is supposed to be consistent by its nature.
> Finally the outbound iATU type isn't encoded by the denoted enumeration,
> thus giving a false impression that the in and out iATU types are
> unrelated while they are the same. So to speak let's drop the redundant
> dw_pcie_as_type enumeration replacing it with the direct iATU type usage.
> 
> While at it, since we are touching the iATU inbound regions config methods
> anyway, let's fix the arguments order so the type would be followed by the
> address-related parameters. Thus the inbound and outbound iATU setup
> methods will look alike. That shall improve the code readability a bit.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++------
>  drivers/pci/controller/dwc/pcie-designware.c  | 35 +++----------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  9 +----
>  3 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index ffbd3af6d65a..5a158813f687 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -154,9 +154,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_barno bar, dma_addr_t cpu_addr,
> -				  enum dw_pcie_as_type as_type)
> +static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				  dma_addr_t cpu_addr, enum pci_barno bar)
>  {
>  	int ret;
>  	u32 free_win;
> @@ -168,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, bar, cpu_addr,
> -				       as_type);
> +	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
> +				       cpu_addr, bar);
>  	if (ret < 0) {
>  		dev_err(pci->dev, "Failed to program IB window\n");
>  		return ret;
> @@ -221,27 +220,25 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      struct pci_epf_bar *epf_bar)
>  {
> -	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
> -	enum dw_pcie_as_type as_type;
> -	u32 reg;
>  	unsigned int func_offset = 0;
> +	int ret, type;
> +	u32 reg;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -		as_type = DW_PCIE_AS_MEM;
> +		type = PCIE_ATU_TYPE_MEM;
>  	else
> -		as_type = DW_PCIE_AS_IO;
> +		type = PCIE_ATU_TYPE_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, bar,
> -				     epf_bar->phys_addr, as_type);
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index bd575ad32bc4..330575182712 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -421,10 +421,9 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  }
>  
>  static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> -					   int index, int bar, u64 cpu_addr,
> -					   enum dw_pcie_as_type as_type)
> +					   int index, int type,
> +					   u64 cpu_addr, u8 bar)
>  {
> -	int type;
>  	u32 retries, val;
>  
>  	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
> @@ -432,17 +431,6 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(cpu_addr));
>  
> -	switch (as_type) {
> -	case DW_PCIE_AS_MEM:
> -		type = PCIE_ATU_TYPE_MEM;
> -		break;
> -	case DW_PCIE_AS_IO:
> -		type = PCIE_ATU_TYPE_IO;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
>  	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type |
>  				 PCIE_ATU_FUNC_NUM(func_no));
>  	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> @@ -468,32 +456,19 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  }
>  
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -			     int bar, u64 cpu_addr,
> -			     enum dw_pcie_as_type as_type)
> +			     int type, u64 cpu_addr, u8 bar)
>  {
> -	int type;
>  	u32 retries, val;
>  
>  	if (pci->iatu_unroll_enabled)
> -		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, bar,
> -						       cpu_addr, as_type);
> +		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, type,
> +						       cpu_addr, bar);
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND |
>  			   index);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, lower_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET, upper_32_bits(cpu_addr));
>  
> -	switch (as_type) {
> -	case DW_PCIE_AS_MEM:
> -		type = PCIE_ATU_TYPE_MEM;
> -		break;
> -	case DW_PCIE_AS_IO:
> -		type = PCIE_ATU_TYPE_IO;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
>  			   PCIE_ATU_FUNC_NUM(func_no));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE |
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7f1c00fa084d..c63ace3c3f25 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -228,12 +228,6 @@ struct dw_pcie_rp {
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> -enum dw_pcie_as_type {
> -	DW_PCIE_AS_UNKNOWN,
> -	DW_PCIE_AS_MEM,
> -	DW_PCIE_AS_IO,
> -};
> -
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> @@ -331,8 +325,7 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
>  				  u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -			     int bar, u64 cpu_addr,
> -			     enum dw_pcie_as_type as_type);
> +			     int type, u64 cpu_addr, u8 bar);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  			 enum dw_pcie_region_type type);
>  void dw_pcie_setup(struct dw_pcie *pci);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
