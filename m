Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E43586C4D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiHANzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiHANzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:55:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2229C9D
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:55:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so9761305pga.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3gGmjHB8qbI2ripW12YTaHS1CCUIUDUosN8z8CaaVjc=;
        b=DV6yPWMjRzwPCGNDgFwh9/JNWX0htmAkF9pUwv7wvmY4NhX5nERIWzD35E8w2bYR9u
         nkOFNTCcqX4lnQDE+PLqtQZWyxpCaqxp96+bbliDX5f9wxI0IFdOMpLCU4tzW6k7xhYa
         MhL8zrylk+1xf7hhd+d5/oxzaSAL85geevKkH08CizV/FLiDu8tdeypp7EN2M9rhCIXx
         XiOXDmXBTZi/i7EKizqmtmQhhBOHzA5EVJZSqgEE56E0huColNcyTc0LAM1evfWzmAXX
         C5H6S55J3vVDmFeSxJ2TLicgwPhUJ0fESboaUiA1YQGsCGcUlNLnQe9V1kNNo0m6jnLU
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3gGmjHB8qbI2ripW12YTaHS1CCUIUDUosN8z8CaaVjc=;
        b=fAhV00FPgm4QmQa5G58qct7/UjeNPEtwHX5cLuLXDb8JI3Y7bcZCxm0rszJFaEvuG7
         M0hbBhnYPD+xgbM1CjrrYaJrx3GeM5ODN+KTLs9QFco+GeEKDe3c35cGJQDAE6ASLWFP
         8VpruPz1PsY6KqEPexBaH/Awf0ROiYOQQYqWa3JMqTHAiCF+sS8XB7rV/lKjl9Vy52UY
         Zqo7T0v87hHSxtDHaSLXG20zkIJgzF1EpinkdGW2H2rmh5gzasOZw48WX5jQrMsz5f2E
         zz858ce0oVF8Osoz40dQGSq6XQ4PpNJxrQJUIvEw5XycKYqY9p7ghr6WWdpVoWTgLAgR
         pkQA==
X-Gm-Message-State: ACgBeo3eSvC+PHY0GhicyJOqS9bpI/rn1uf8x6ElNGHY32dHj2QhdSgG
        TOVW+8sN1m2XWJANlvg6I+HC
X-Google-Smtp-Source: AA6agR5eYRbo6sIZHryuqtIY5TrfwJALrvXNw37SQjF5283qm1h6pn6Y9Iu7bADb9YsrrMJK9Ab8Ag==
X-Received: by 2002:a62:cec9:0:b0:52d:414b:c70f with SMTP id y192-20020a62cec9000000b0052d414bc70fmr7770111pfg.20.1659362106652;
        Mon, 01 Aug 2022 06:55:06 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b0016bcc35000asm9498654plf.302.2022.08.01.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:55:06 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:24:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 14/15] PCI: dwc: Check iATU in/outbound ranges
 setup methods status
Message-ID: <20220801135457.GN93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:46PM +0300, Serge Semin wrote:
> Let's make the DWC PCIe RC/EP safer and more verbose for the invalid or
> failed inbound and outbound iATU windows setups. Needless to say that
> silently ignoring iATU regions setup errors may cause unpredictable
> errors. For instance if for some reason a cfg or IO window fails to be
> activated, then any CFG/IO requested won't reach target PCIe devices and
> the corresponding accessors will return platform-specific random values.
> 
> First of all we need to convert dw_pcie_ep_outbound_atu() method to check
> whether the specified outbound iATU range is successfully setup. That
> method is called by the pci_epc_ops.map_addr callback. Thus we'll make the
> EP-specific CPU->PCIe memory mappings saver.
> 
> Secondly since the iATU outbound range programming method now returns the
> operation status, it will be handy to take that status into account in the
> pci_ops.{map_bus,read,write} methods. Thus any failed mapping will be
> immediately noticeable by the PCIe CFG operations requesters.
> 
> Finally we need to convert the dw_pcie_setup_rc() method to returning the
> operation status, since the iATU outbound ranges setup procedure may now
> fail. It will be especially handy in case if the DW PCIe RC DT-node has
> invalid/unsupported (dma-)ranges property. Note since the suggested
> modification causes having too wide code indentation, it is reasonable
> from maintainability and readability points of view to move the outbound
> ranges setup procedure in the separate function.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |   9 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 153 ++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
>  4 files changed, 114 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2e91222f7c98..627c4b69878c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -184,8 +184,9 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  				   phys_addr_t phys_addr,
>  				   u64 pci_addr, size_t size)
>  {
> -	u32 free_win;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 free_win;
> +	int ret;
>  
>  	free_win = find_first_zero_bit(ep->ob_window_map, pci->num_ob_windows);
>  	if (free_win >= pci->num_ob_windows) {
> @@ -193,8 +194,10 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -				     phys_addr, pci_addr, size);
> +	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> +					   phys_addr, pci_addr, size);
> +	if (ret)
> +		return ret;
>  
>  	set_bit(free_win, ep->ob_window_map);
>  	ep->outbound_addr[free_win] = phys_addr;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e0a2819608c6..6993ce9e856d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -412,7 +412,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> -	dw_pcie_setup_rc(pp);
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_free_msi;
>  
>  	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
> @@ -466,10 +468,10 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  						unsigned int devfn, int where)
>  {
> -	int type;
> -	u32 busdev;
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int type, ret;
> +	u32 busdev;
>  
>  	/*
>  	 * Checking whether the link is up here is a last line of defense
> @@ -490,8 +492,10 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  	else
>  		type = PCIE_ATU_TYPE_CFG1;
>  
> -
> -	dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev, pp->cfg0_size);
> +	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
> +					pp->cfg0_size);
> +	if (ret)
> +		return NULL;
>  
>  	return pp->va_cfg0_base + where;
>  }
> @@ -499,33 +503,45 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  				 int where, int size, u32 *val)
>  {
> -	int ret;
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret;
>  
>  	ret = pci_generic_config_read(bus, devfn, where, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;
>  
> -	if (!ret && pp->cfg0_io_shared)
> -		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
> -					  pp->io_bus_addr, pp->io_size);
> +	if (pp->cfg0_io_shared) {
> +		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> +						pp->io_base, pp->io_bus_addr,
> +						pp->io_size);
> +		if (ret)
> +			return PCIBIOS_SET_FAILED;
> +	}
>  
> -	return ret;
> +	return PCIBIOS_SUCCESSFUL;
>  }
>  
>  static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  				 int where, int size, u32 val)
>  {
> -	int ret;
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret;
>  
>  	ret = pci_generic_config_write(bus, devfn, where, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;
>  
> -	if (!ret && pp->cfg0_io_shared)
> -		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
> -					  pp->io_bus_addr, pp->io_size);
> +	if (pp->cfg0_io_shared) {
> +		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> +						pp->io_base, pp->io_bus_addr,
> +						pp->io_size);
> +		if (ret)
> +			return PCIBIOS_SET_FAILED;
> +	}
>  
> -	return ret;
> +	return PCIBIOS_SUCCESSFUL;
>  }
>  
>  static struct pci_ops dw_child_pcie_ops = {
> @@ -552,10 +568,72 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> -void dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> +static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  {
> -	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct resource_entry *entry;
> +	int i, ret;
> +
> +	/* Note the very first outbound ATU is used for CFG IOs */
> +	if (!pci->num_ob_windows) {
> +		dev_err(pci->dev, "No outbound iATU found\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Ensure all outbound windows are disabled before proceeding with
> +	 * the MEM/IO ranges setups.
> +	 */
> +	for (i = 0; i < pci->num_ob_windows; i++)
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
> +
> +	i = 0;
> +	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		if (resource_type(entry->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (pci->num_ob_windows <= ++i)
> +			break;
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> +						entry->res->start,
> +						entry->res->start - entry->offset,
> +						resource_size(entry->res));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> +				entry->res);
> +			return ret;
> +		}
> +	}
> +
> +	if (pp->io_size) {
> +		if (pci->num_ob_windows > ++i) {
> +			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> +							pp->io_base,
> +							pp->io_bus_addr,
> +							pp->io_size);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to set IO range %pr\n",
> +					entry->res);
> +				return ret;
> +			}
> +		} else {
> +			pp->cfg0_io_shared = true;
> +		}
> +	}
> +
> +	if (pci->num_ob_windows <= i)
> +		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> +			 pci->num_ob_windows);
> +
> +	return 0;
> +}
> +
> +int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u32 val, ctrl, num_ctrls;
> +	int ret;
>  
>  	/*
>  	 * Enable DBI read-only registers for writing/updating configuration.
> @@ -610,42 +688,9 @@ void dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -		int i, atu_idx = 0;
> -		struct resource_entry *entry;
> -
> -		/*
> -		 * Ensure all outbound windows are disabled so there are
> -		 * multiple matches
> -		 */
> -		for (i = 0; i < pci->num_ob_windows; i++)
> -			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
> -
> -		/* Get last memory resource entry */
> -		resource_list_for_each_entry(entry, &pp->bridge->windows) {
> -			if (resource_type(entry->res) != IORESOURCE_MEM)
> -				continue;
> -
> -			if (pci->num_ob_windows <= ++atu_idx)
> -				break;
> -
> -			dw_pcie_prog_outbound_atu(pci, atu_idx,
> -						  PCIE_ATU_TYPE_MEM, entry->res->start,
> -						  entry->res->start - entry->offset,
> -						  resource_size(entry->res));
> -		}
> -
> -		if (pp->io_size) {
> -			if (pci->num_ob_windows > ++atu_idx)
> -				dw_pcie_prog_outbound_atu(pci, atu_idx,
> -							  PCIE_ATU_TYPE_IO, pp->io_base,
> -							  pp->io_bus_addr, pp->io_size);
> -			else
> -				pp->cfg0_io_shared = true;
> -		}
> -
> -		if (pci->num_ob_windows <= atu_idx)
> -			dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",
> -				 pci->num_ob_windows);
> +		ret = dw_pcie_iatu_setup(pp);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> @@ -658,5 +703,7 @@ void dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 60f1ddc54933..c3e73ed9aff5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -387,7 +387,7 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
>  
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
> -void dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> +int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
>  int dw_pcie_host_init(struct dw_pcie_rp *pp);
>  void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
>  int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
> @@ -399,8 +399,9 @@ static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  	return IRQ_NONE;
>  }
>  
> -static inline void dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> +static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  {
> +	return 0;
>  }
>  
>  static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index a44f685ec94d..c3481200e86a 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -302,7 +302,11 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  	intel_pcie_ltssm_disable(pcie);
>  	intel_pcie_link_setup(pcie);
>  	intel_pcie_init_n_fts(pci);
> -	dw_pcie_setup_rc(&pci->pp);
> +
> +	ret = dw_pcie_setup_rc(&pci->pp);
> +	if (ret)
> +		goto app_init_err;
> +
>  	dw_pcie_upconfig_setup(pci);
>  
>  	intel_pcie_device_rst_deassert(pcie);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
