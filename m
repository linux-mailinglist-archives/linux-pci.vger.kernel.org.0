Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53C26F35AD
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjEASJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEASJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 14:09:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A151BE3;
        Mon,  1 May 2023 11:09:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso3485883e87.0;
        Mon, 01 May 2023 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682964543; x=1685556543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVsyEeQIkuoRUX8OyS/aL/Sw9eE1vVvWLKexBiA7nyw=;
        b=pN9Ws5HGhqmyGfjLYEbNTWeHzlQ+et4v1WldgWtSE0S5Yb8TdBYJ27VaCtgTqEYWxD
         PjcyNXcLLdI5VEovO11T3eknmzEfJoH52+mvaUgZ1xH50bDb8ynjLplHeAMPusNkraCN
         20kGvOAT/8LHnGeIICrKAPnTwNoXHXPzpO66/4g7a+eyG0amYk9sq7dZNIP0owHPecGa
         0f3vjTFlMGnNmwgp3vlQuhV5DrX/YcSb/CHz3rgJv7Z40gN8Iq/qSTQ8w5r7dEdclNYJ
         yZiE05k5qMVRqj2usJWJfeFH+NnOkjtp7CX317t1LVtCLIegz/KuXc2wYyNuZ29TRbkR
         BvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682964543; x=1685556543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVsyEeQIkuoRUX8OyS/aL/Sw9eE1vVvWLKexBiA7nyw=;
        b=WM2qKMoMfhmSj1g7REXOe37tC6l2Fd+r3r+jmadeOes85aZNTHwFaVm1dgB6IrZsle
         CHaa+TzTf3ph7ZwUOJSt2FNVXmI6sTMNvT4a4JYm7jwXp2MODNPmD62MXr/9ei1HLLVB
         mUy8hYsamXrHNOjw8OvQQyMpCFsfgurx79IOXYWnwa0AtmJ+ajQ0dHK1XNZDx0nJvXir
         DIytV0XP/e3R0cA9uqSKfSb2Ub5Bw3KWvpx033Nm5t5+OmRR9uQyKrG4X8LisL3QBvQn
         G5IkXOHtUOo9cBwzpRxHC2hnKJLLd8l+pNPdNCekzHUL9UGgfPbIBJFBx00sdtq53NDB
         zdlw==
X-Gm-Message-State: AC+VfDy5YoU32z3ec/9OkC0ioylNoJPnDajz22xm/I5i3xXJTrcdVvPs
        Gk5sMQLgxFPWp65EkBSpyDo=
X-Google-Smtp-Source: ACHHUZ4LwwG8MbaIZngGquwUyHGUdV6gyrrj4eLdszWPLXRnOjVlpw5d4V97Jr4bWCXVnW6rDIFtdQ==
X-Received: by 2002:a05:6512:38cc:b0:4ed:c76b:6aaf with SMTP id p12-20020a05651238cc00b004edc76b6aafmr3642335lft.56.1682964542887;
        Mon, 01 May 2023 11:09:02 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004e7fa99f2b5sm4888778lfo.186.2023.05.01.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:09:02 -0700 (PDT)
Date:   Mon, 1 May 2023 21:09:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v14 05/21] PCI: dwc: Rename "legacy_irq" to "INTx_irq" in
 DWC core
Message-ID: <20230501180900.6jmxgd2ob2ebf34d@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:41PM +0900, Yoshihiro Shimoda wrote:
> Using "INTx" instead of "legacy" is more specific. So, rename
> dw_pcie_ep_raise_legacy_irq() to dw_pcie_ep_raise_intx_irq().

[PATCH v14 05/21] PCI: dwc: Rename "legacy_irq" to "INTx_irq" in DWC core

Drop "DWC core" from the subject. It's implied by the subsystem/vendor
prefix of the title.

Other than that the patch looks good. Although it would have been nice
to fix the local namings in the LLD drivers too...

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1f39e733ce19..0831f3947220 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1063,7 +1063,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_EPC_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_EPC_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index ab3306e206d8..3d58fc1670b4 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -66,7 +66,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_EPC_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_EPC_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 205bbcc6af27..a80b9fd03638 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -480,16 +480,16 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  
> -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +	dev_err(dev, "EP cannot trigger INTx IRQs\n");
>  
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index fc3b02949218..2689ff7939e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -49,7 +49,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_EPC_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_EPC_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index adad0ea61799..9acf6c40d252 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -550,7 +550,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
> +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -583,7 +583,7 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
>  
> -static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +static inline int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 077afce48d0b..3061e5e13476 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -659,7 +659,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_EPC_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
> -- 
> 2.25.1
> 
