Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0396B55E237
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbiF1GpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbiF1Go4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:44:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593B24BCE
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:44:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r66so11293638pgr.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qf6qUx9i2mMoyuEym+mMwKkMP4eflkWgpvGzK5dl09M=;
        b=gtclWZyXKS4kE4MxEpynTyqmgOBp4JudcPhAbhPJUSaI1IHABSTivbKQBDJy2ekRFp
         xmsdXUlwZ7M2n2FXkEHu4kApXG7cs/2gE4COVy2l+Fuzwmx4/7+NWLUssPjgEejabF3s
         u6ao704ztMN3tCzzzAKV6AbCotL3PCpALMkzq6aY2qDLTvNSCj4zlzXWl6vezcVAK/8f
         Day5HLazkk7aaf2fU/42C/gzoQqCSAaesZhal+upRFDfJtpEGj17yH5s5JweNkmP5XBL
         WKgP5ljLnV+YSCt2ejsgJMo4Rs2nt6BlimTQjaRAQqnl3k2NVTw6meLDl0dXRJ8CIE5Q
         JETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qf6qUx9i2mMoyuEym+mMwKkMP4eflkWgpvGzK5dl09M=;
        b=GGyCp0Qrx7JBV1+mmRQhgvSMeW4IWrrlWqMimXEVjd4aM/rJAygxeZseDVWDySce5D
         1dXzAgeqE9TVrkFnP6Kso3JEmzLMjdrwObBdytmHTHvfp4B/8J//4HExEo/0oM2NMFHI
         AGzGQzDpsbAzL8bNHPh57vt/qiV9JIdz4wK0V6seDZM39y+F5y9qFC6e46C7CFgrM9OA
         xTBwDXHO7aLnshR+c/NH+HgxfLZNR0dcXC8Buh83hpBIQDOb71mdmpcETM9pd6eatFTO
         jJW9blR+8tmTB0U5O1ikwIgS2QuX4XIxfYpnqIVKs+FQN44HDTbyi/1IZBvuHx0DZwFp
         Vkfw==
X-Gm-Message-State: AJIora9NMBkHbl5S+BXWFJUjWpuu8UCAGRcmSja9+8ft6wi6VimOy18n
        rLYKLptuixYvX85LsbDQr23A
X-Google-Smtp-Source: AGRyM1s98lIR0fSjqWqr20SjFAeV5AaV941twUSQ7ZnwoYcmYnwCVpT4B5m3ZMtUVFuZL0RXjmRQsA==
X-Received: by 2002:a63:115b:0:b0:40d:e7a0:37f9 with SMTP id 27-20020a63115b000000b0040de7a037f9mr9615060pgr.78.1656398694789;
        Mon, 27 Jun 2022 23:44:54 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id d85-20020a621d58000000b0052549cc3416sm8738710pfd.175.2022.06.27.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:44:54 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:14:49 +0530
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
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 14/18] PCI: dwc: Move io_cfg_atu_shared to the
 Root Port descriptor
Message-ID: <20220628064449.GG23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:24PM +0300, Serge Semin wrote:
> That flag is set if there is an outbound iATU window used for both PCIe
> peripheral config-space accesses and IO ports transfers. Since the flag
> semantic is purely Root Port specific, it's unused in neither the DW PCIe
> common code nor in the DW PCIe Endpoint driver, we can freely move it to
> the DW PCIe Root Port descriptor. Thus the pcie_port structure will be
> more coherent.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c49a3bde7a2a..7ff2b7555b91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -492,7 +492,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  
>  	ret = pci_generic_config_read(bus, devfn, where, size, val);
>  
> -	if (!ret && pci->io_cfg_atu_shared)
> +	if (!ret && pp->cfg0_io_shared)
>  		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
>  					  pp->io_bus_addr, pp->io_size);
>  
> @@ -508,7 +508,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  
>  	ret = pci_generic_config_write(bus, devfn, where, size, val);
>  
> -	if (!ret && pci->io_cfg_atu_shared)
> +	if (!ret && pp->cfg0_io_shared)
>  		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
>  					  pp->io_bus_addr, pp->io_size);
>  
> @@ -627,7 +627,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  							  PCIE_ATU_TYPE_IO, pp->io_base,
>  							  pp->io_bus_addr, pp->io_size);
>  			else
> -				pci->io_cfg_atu_shared = true;
> +				pp->cfg0_io_shared = true;
>  		}
>  
>  		if (pci->num_ob_windows <= atu_idx)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8ba239292634..13bffa3eaed6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
>  
>  struct pcie_port {
>  	bool			has_msi_ctrl:1;
> +	bool			cfg0_io_shared:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
>  	u32			cfg0_size;
> @@ -274,7 +275,6 @@ struct dw_pcie {
>  	int			link_gen;
>  	u8			n_fts[2];
>  	bool			iatu_unroll_enabled: 1;
> -	bool			io_cfg_atu_shared: 1;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
