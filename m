Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61714E6052
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 09:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiCXI3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348906AbiCXI3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 04:29:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1DE6466
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 01:28:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s8so3397282pfk.12
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKGHJ9VxUdter6B/O/wVjkQhA8O5yDUrS1eXiqm5kA0=;
        b=Ee9jS3nTP3OoOk3l3IzMsSFpZh/6PHHVUgndP6FOC88RB3F6/gqE+qlwSRcwstB19t
         r7M3g4q46HaDkptGXzlS6VTextapnrEzebdo+nUpnIT/+y+hwHyfRmNcsqeVaF6O+uxv
         m8q85SPZ4e8Wbs3HVHaiGlyaqS0UIEaZ50glNaHVqiu7LGpxlfh3ATYo7+foYg42MgxT
         PFaaDB53p0LmFnyWe4RPeo2URCwf1jXJBncjSo4XYvMvzuEiq9/SAoYuXr9g30PtR8tD
         cpzm+6ol6n8FGr8sQE2NtzSmz48c+gK6eSmMxKDGvVkAAG79DdP6MtAeDoAWiBQvXpLJ
         nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKGHJ9VxUdter6B/O/wVjkQhA8O5yDUrS1eXiqm5kA0=;
        b=cdV1W8EYcfafuZ4a+P81bApwWYcEsNRhY0XkiXRI0vyAKqKpjxu4XY7TjacZs1bs7n
         pwS54nVLWSwfX2YJY333TNRaoVem+QdrpPqE3s7IQLhkLrNRGt++SsAZPQuREyDxNyFg
         KrL9o6dSSqUfe1yEWQBTawvvYbgH7g4u0sT16jEUOUaXGCFjfbVBP7szqlwhqMjF5l3J
         4vPgF0UyuSpq/Jf3bxpNg0ut/vyJLgQpxUMWZnMlZ6yFRWB7J6Jr1ZtN/3ylBwZd6w0V
         b9e44ewANrpvhl7+7fzl3wPujgzkC/ziX9fitPKrsOR9BLTJFvziQ3nk4jMltqB0kFrM
         NV5g==
X-Gm-Message-State: AOAM533SlLrYIDDHz0HKrEM2RY7ysSFLDLS6CfYK11c67n653Wkvog8O
        D5R1FtZ7H2znv+ri4tIRv8fw84lznW0e
X-Google-Smtp-Source: ABdhPJzaIOFNpluOEK7hvmKjU7cSFLgzEITV2Ec6TcXzOrPylxV3EWCHQINiwjG8Oo3E4SPef3wPLw==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr3730444pfu.65.1648110485559;
        Thu, 24 Mar 2022 01:28:05 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a056a000a0f00b004f7c63cba5asm2617293pfh.21.2022.03.24.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:28:05 -0700 (PDT)
Date:   Thu, 24 Mar 2022 13:57:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] PCI: dwc: Don't use generic IO-ops for DBI-space
 access
Message-ID: <20220324082746.GB2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:13AM +0300, Serge Semin wrote:
> Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> the locally defined DW PCIe host controller config-space accessors with
> the generic methods pci_generic_config_read() and
> pci_generic_config_write(). It was intended that the corresponding
> bus-mapping callback returned a correct virtual address of the passed PCI
> config-space register. The problem of the proposed solution was that it
> didn't take into account the way the host config-space is accessed on the
> DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> interfaces can be used to access the host and peripheral config/memory
> spaces. The former one can be accessed via the DBI interface, while the
> later ones is reached via the AHB/AXI application bus. In case if the DW
> PCIe controller is configured to have a dedicated DBI interface, the way
> it is mapped into the IO-memory turns to be platform-specific. For such
> setups the DWC PCIe driver provides a set of the callbacks
> dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> able to take into account the DBI bus IO peculiarities. Since
> commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> methods haven't been utilized during the generic host initialization
> performed by the PCIe subsystem code.
> 
> I don't really know how come there have been no problems spotted for the
> Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
> aligned IO requirement the generic config-space accessors can't be
> utilized for the host config-space. Thus in order to make sure the host
> config-space is properly accessed via the DBI bus let's get back the
> dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> be just wrappers around the already defined
> dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> conversion. These methods perform the platform-specific config-space IO if
> the DBI accessors are specified, otherwise they call normal MMIO
> operations.
> 

Why can't you override the "pci_ops" in your host driver's "host_init"?

Thanks,
Mani

> Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a03619a30c20..f89e6552139b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -528,10 +528,40 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static int dw_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 *val)
> +{
> +	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (PCI_SLOT(devfn) > 0) {
> +		*val = ~0U;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	*val = dw_pcie_read_dbi(pci, where, size);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int dw_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 val)
> +{
> +	struct pcie_port *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	dw_pcie_write_dbi(pci, where, size, val);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
>  static struct pci_ops dw_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
> -	.read = pci_generic_config_read,
> -	.write = pci_generic_config_write,
> +	.read = dw_pcie_rd_own_conf,
> +	.write = dw_pcie_wr_own_conf,
>  };
>  
>  void dw_pcie_setup_rc(struct pcie_port *pp)
> -- 
> 2.35.1
> 
