Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572D47D9897
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjJ0Mly (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 08:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjJ0Mlx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 08:41:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C767D4D;
        Fri, 27 Oct 2023 05:41:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507975d34e8so2971643e87.1;
        Fri, 27 Oct 2023 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698410508; x=1699015308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InZZkcT9DFpYZHJFVk39HVzXa3y6PMr+2o1AXUVI2G4=;
        b=GLEKROeKNRoqwuRCMzGR+Uwa+i2AMN4CyQom6JhqTShBJDN17ea3JxYNIYvOOhw9q1
         Ib6k/s2iTQFwWVaNK4ckpyUSLT8rj7329L9wYlcHcqYutknIRfOjtlPoUZQAtMzvc1+k
         qF73TJET0RuskA3sZhmbjYvLWeoR5ZaHIpAfP/wiE2zVtOE8gNoW1aSm+5CJmRMHzccL
         EAM4e3GAuEhK4OOIMwdyPA9CPtwGCs7ip65Lcn6ffj5OTMFjIrbTAZiOVgLM2Tf097QO
         9hTwnxI/xPeVphHvSztsQJSINNnSkoGZKSeH2m0AR6F3NC0+QKqWc80scbmB4IHF8cre
         Ulug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698410508; x=1699015308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InZZkcT9DFpYZHJFVk39HVzXa3y6PMr+2o1AXUVI2G4=;
        b=ZfvE1zhtPf+FJPsJq7HMFrXdoVzaa/LVycqH6Hoy/RzFizqzTMxn+R0WfJVXSwdWyV
         Uqqds5Sv8ys//jxjbyca0LNf7FNye+mzR9dg5pDb67Devtpf0Pq1StBG3+vfiGL10Gvc
         iMSFkiGypYm1oeNyAScugljXkFPQ37BMtTJzz3voF5gxYSCAcNlJrwt8et/oSR91k2Xm
         imBzEPw/UgcqqUnbaj3lsIGIWaJ2NFIAMIPySgJjJxZlA/I4KKazkirC54PSsKGZLHRc
         c5cmEQNOlkbotIoOJ7KTVBiDlN7M9WcM3CyytdRc6JjvHza6gzWkNeXDBjXjnGZqgUv8
         yTBA==
X-Gm-Message-State: AOJu0YyLknSp5oi8SY32h0c65ldcuGUIDK5y6e0kBa6/OVMk152/KIqn
        H0WB29OoD9U5V1uiHAHAaFo=
X-Google-Smtp-Source: AGHT+IHBi6kDtubJ3jXoMNw3Pkm1BnrWhNHMamhArsLTaTFS22ELyj/rzRRSAZ6zX010TCo+aoulrg==
X-Received: by 2002:a05:6512:4850:b0:507:97ca:ec60 with SMTP id ep16-20020a056512485000b0050797caec60mr1743529lfb.3.1698410508149;
        Fri, 27 Oct 2023 05:41:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b00501ce5c2e4asm265192lfh.262.2023.10.27.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:41:47 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:41:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, u.kleine-koenig@pengutronix.de,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [RFC PATCH] PCI: keystone: Refactor ks_pcie_v3_65_add_bus()
 functionality
Message-ID: <z6x2pbyxwzbfprbmmoihqevm3sl3ytruw7cp5546g2iavoietq@eg6ajeang2a4>
References: <20231027084159.4166188-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027084159.4166188-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 02:11:59PM +0530, Siddharth Vadapalli wrote:
> The .add_bus() callback "ks_pcie_v3_65_add_bus()" exists to setup BAR0 for
> MSI configuration. This method is expected to be invoked after the
> enumeration of endpoints for the v3.65a DWC PCIe IP Controller.
> 
> Based on the discussion at [0], the contents of "ks_pcie_v3_65_add_bus()"
> can be moved to the .host_init callback "ks_pcie_host_init()" and the
> .add_bus callback within "struct pci_ops ks_pcie_ops" is no longer
> required.
> 
> Hence, for the v3.65a DWC PCIe IP Controllers (!ks_pcie->is_am6), perform
> the MSI specific configuration of BAR0 within "ks_pcie_host_init()"
> itself.
> 
> [0] https://lore.kernel.org/r/20231019220847.GA1413474@bhelgaas/
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20231027.
> This patch depends on the patch at:
> https://lore.kernel.org/r/20231019081330.2975470-1-s-vadapalli@ti.com/
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 51 ++++++++---------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index e9245b7632c5..369f5e556df3 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -447,44 +447,10 @@ static struct pci_ops ks_child_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> -/**
> - * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
> - * @bus: A pointer to the PCI bus structure.
> - *
> - * This sets BAR0 to enable inbound access for MSI_IRQ register
> - */
> -static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
> -{
> -	struct dw_pcie_rp *pp = bus->sysdata;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> -
> -	if (!pci_is_root_bus(bus))
> -		return 0;
> -
> -	/* Configure and set up BAR0 */
> -	ks_pcie_set_dbi_mode(ks_pcie);
> -
> -	/* Enable BAR0 */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> -
> -	ks_pcie_clear_dbi_mode(ks_pcie);
> -
> -	 /*
> -	  * For BAR0, just setting bus address for inbound writes (MSI) should
> -	  * be sufficient.  Use physical address to avoid any conflicts.
> -	  */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> -
> -	return 0;
> -}
> -
>  static struct pci_ops ks_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> -	.add_bus = ks_pcie_v3_65_add_bus,
>  };
>  
>  static struct pci_ops ks_pcie_am6_ops = {
> @@ -834,6 +800,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret < 0)
>  		return ret;
>  

> +	if (!ks_pcie->is_am6) {
> +		/* Configure and set up BAR0 */
> +		ks_pcie_set_dbi_mode(ks_pcie);
> +
> +		/* Enable BAR0 */
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> +
> +		ks_pcie_clear_dbi_mode(ks_pcie);
> +
> +		/*
> +		 * For BAR0, just setting bus address for inbound writes (MSI) should
> +		 * be sufficient.  Use physical address to avoid any conflicts.
> +		 */
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +	}
> +

Seeing this is required for MSI IRQs what about moving it to the
ks_pcie_config_msi_irq() together with the BARs zeroing out performed
in the ks_pcie_setup_rc_app_regs() function especially seeing the
later function is dedicated for the 'app' regs initialization only
based on the function name. Bjorn, what do you think?

-Serge(y)

>  #ifdef CONFIG_ARM
>  	/*
>  	 * PCIe access errors that result into OCP errors are caught by ARM as
> -- 
> 2.34.1
> 
