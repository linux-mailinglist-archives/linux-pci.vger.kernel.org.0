Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D54E6007
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 09:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbiCXINR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiCXINQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 04:13:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39629AE66
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 01:11:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso78377pju.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Dbv9J4IYwH7gaq8RuZAfIktrBF1Q94+nUP2sn2iHw0=;
        b=M2i/A86y3y5pmzQ9gFGrjGf5hyTv41tWf/jjdfxWxx6zeDLEAhVObq1+iZnMGoBsJl
         EEvc/NiwpW3g6m7ne+CILQOK4PzptCWUAs16fBdL/ZT6T88ILfaFSByUnGWJ0mSzpfdI
         DMLllCrJFLYKE9OUz837QeWSjKuIk86x/Vupy1mw90asBg10O2UvRKMJRfBRAgBrdJlZ
         0otPCrV/zfAEHhh6dmJjEgjhMVGbsrB6+vFW1Ewe3k/Pg5ksKjnldD8P+0ogtV3n0EtR
         XZLiECZn1ozO5JoT4ewkGJY86CuvffrOt7HfTirWQuoEKUAnH+7OP7mo0SYtnUXysB0P
         8Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Dbv9J4IYwH7gaq8RuZAfIktrBF1Q94+nUP2sn2iHw0=;
        b=m7ljFY8FseH503v524k5yuagPvsewRcs39Vf5+2QVL/vQUwNy4CW2amhObh5k0jNyj
         8qioLpk2G3H0y7rVJPVXuYHlM5HfwlXc9Ke+kARykBQMjde6yeSsDkfa/sZ4nZfxFl0h
         oozjNlQ0QWz6y4l3XBJ/jCl+YvAfdyPi/S2Vma0JfQ0sZfPl8+CqF8BdJ1N0xxyAHbTm
         jpWo/BlG7pLhH6R3lNFuyqJuPiH4woM7zAbJS2qbHxYvOK2hCXIF408tF02BE1t8DY/J
         NDQuEyMuT1ilrNGXEW/qjXy1JuHqJPaqMfyyqmGW0F/A5/dKHXp+AkiKK6h5j3asBCUD
         lWow==
X-Gm-Message-State: AOAM532speU8a93nwW+yjpCE5kI9q9Y4+SpWDU1eIOoMeDwbsNq0xZnu
        HU79gkmh9uZon+adeb5LuSEo
X-Google-Smtp-Source: ABdhPJxt6GQZ0uEmAxDx/tWdRrltH05g1H4pW2YHsyfrkdr2GUg6Qtw7Y4xOPrx+s4CffMjocNV7KA==
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id b12-20020a17090a990c00b001bc3c9f2abemr4755847pjp.220.1648109505341;
        Thu, 24 Mar 2022 01:11:45 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a056a000a0f00b004f7c63cba5asm2538664pfh.21.2022.03.24.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:11:44 -0700 (PDT)
Date:   Thu, 24 Mar 2022 13:41:39 +0530
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
Subject: Re: [PATCH 01/12] PCI: dwc: Stop link in the host init error and
 de-initialization
Message-ID: <20220324081139.GA2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:12AM +0300, Serge Semin wrote:
> It's logically correct to undo everything what was done in case of an
> error is discovered or in the corresponding cleanup counterpart. Otherwise
> the host controller will be left in an undetermined state. Seeing the link
> is set up in the Host-initialization method it will be right to
> de-activate it there in the cleanup-on-error block and stop the link in
> the antagonistic routine - dw_pcie_host_deinit(). The link de-activation
> is a platform-specific thing and is supposed to be implemented in the
> framework of the dw_pcie_ops.stop_link() operation.
> 
> Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..a03619a30c20 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -414,8 +414,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	bridge->sysdata = pp;
>  
>  	ret = pci_host_probe(bridge);
> -	if (!ret)
> -		return 0;
> +	if (ret)
> +		goto err_stop_link;
> +
> +	return 0;
> +
> +err_stop_link:
> +	if (pci->ops && pci->ops->stop_link)
> +		pci->ops->stop_link(pci);
>  
>  err_free_msi:
>  	if (pp->has_msi_ctrl)
> @@ -426,8 +432,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_init);
>  
>  void dw_pcie_host_deinit(struct pcie_port *pp)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
>  	pci_stop_root_bus(pp->bridge->bus);
>  	pci_remove_root_bus(pp->bridge->bus);
> +
> +	if (pci->ops && pci->ops->stop_link)
> +		pci->ops->stop_link(pci);
> +
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
>  }
> -- 
> 2.35.1
> 
