Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC70E7D8553
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjJZO4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJZO4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 10:56:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF193;
        Thu, 26 Oct 2023 07:56:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd644a96so1449228e87.3;
        Thu, 26 Oct 2023 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698332196; x=1698936996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hkp1QT5NX+N94SwbArFtA3RQgc4/y8IylKBwUOt3EE=;
        b=S494mLuJQHK+vwWrLdP96VWq+LDg4OXvisxTCpmxMQOkVqIGnD0KkNX4XSAgogJgQt
         /yPtx58YWoRvw4tv4TYjAiIOXr/NewLEuiFLLS8KG5yuAoD0MRKfn8CqPtrxtOqQ2xIR
         ZZGXmukR9YRqg2P3sePvvPV56IXlZJKxALzzFUnWveN7VAMRwg7EsV+1jUSDKJcUGIlr
         30Yls+utOsUnL2Afcst4/jM2mFC1y0tBG2tMDCv7uletayP6nOoVauGoDmg9wP+62azK
         gshsqqPUwbXus75rJu7xcIlXmt+4wAgypqOTgfIprr94sFwKv3U6m0Ioa1LydX0yIw/T
         Jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698332196; x=1698936996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hkp1QT5NX+N94SwbArFtA3RQgc4/y8IylKBwUOt3EE=;
        b=j8MiJ5WW7kO7Alo8sEYo0vLZv9sQHW0XKeflaaln/dUFELqMY3egMbuRK6or8p+fI9
         DwJcjC4mp42/7UdCBK6RSEbNeCyjqvPnL10tZS0b/vzTWQkoWp8soIRPNYExtoX9dk4o
         wTiDDuoBR8wGV2tTqipFgPxZoCyP29wWoiAfv/Fnrc6XLmA4aq+DGqTii7Jc6A8LUneG
         RXcM2zy9x59AgYWD5XPab6gIa+mINYe87EiK+aukFzbRSWOkb0J6Ck7ZQIGQowKBB4ec
         eA2XNdYk+nhOLHp6Z4QK5HcJAcJimb77klW5e+wvRkK6ja7hwOdYRwWCscrML6viSeFB
         T8dw==
X-Gm-Message-State: AOJu0YznPWukMgL5EsxJnWhJBfLtKvxCKVtyNuxo6PK+DTesqSgsqhqM
        JdGzH+uL96eyHnFUuP1006I=
X-Google-Smtp-Source: AGHT+IG46UyIlJ1LlNzSqNyk2RbMvltgx/G6c5JzD8K0QmtHvYBTh3FvQKtRHC1YiYgn40Jsvu8gyg==
X-Received: by 2002:ac2:5def:0:b0:507:a12c:558c with SMTP id z15-20020ac25def000000b00507a12c558cmr12000314lfq.46.1698332195742;
        Thu, 26 Oct 2023 07:56:35 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c24-20020a056512075800b005079ff16d9fsm3024802lfs.138.2023.10.26.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:56:35 -0700 (PDT)
Date:   Thu, 26 Oct 2023 17:56:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_bjorande@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: qcom-ep: Implement write_dbi2() callback for
 writing DBI2 registers properly
Message-ID: <4sntfai34eg6h36dwaht65ktj53isr5nleikatjzxxxu2tb64o@rro6sef4s6bh>
References: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>
 <20231025130029.74693-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025130029.74693-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 06:30:29PM +0530, Manivannan Sadhasivam wrote:
> DWC core driver exposes the write_dbi2() callback for writing to the DBI2
> registers in a vendor specific way. On the Qcom EP plaforms, DBI_CS2 bit in
> the ELBI region needs to be asserted before writing to any DBI2 registers
> and deasserted once done. So let's implement the callback for the Qcom PCIe
> EP driver so that the DBI2 writes are handled properly in the hardware.
> 
> Without this callback, DBI2 register writes like BAR size won't go through
> and as a result, the default BAR size is set for all BARs.
> 
> Cc: stable@vger.kernel.org # 5.16+
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

+1 tiny note below

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 32c8d9e37876..7da0599f70e7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -124,6 +124,7 @@
>  
>  /* ELBI registers */
>  #define ELBI_SYS_STTS				0x08
> +#define ELBI_CS2_ENABLE				0xa4
>  
>  /* DBI registers */
>  #define DBI_CON_STATUS				0x44
> @@ -262,6 +263,21 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  

> +static void qcom_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,

Just a general observation. I am not sure whether it's a local
convention or not, but it looks like the rest of the Qcom dw_pcie_ops
callbacks have the "qcom_pcie_dw_" prefix.

-Serge(y)

> +				 u32 reg, size_t size, u32 val)
> +{
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	int ret;
> +
> +	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);
> +
> +	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
> +	if (ret)
> +		dev_err(pci->dev, "Failed to write DBI2 register (0x%x): %d\n", reg, ret);
> +
> +	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
> +}
> +
>  static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
>  {
>  	struct dw_pcie *pci = &pcie_ep->pci;
> @@ -500,6 +516,7 @@ static const struct dw_pcie_ops pci_ops = {
>  	.link_up = qcom_pcie_dw_link_up,
>  	.start_link = qcom_pcie_dw_start_link,
>  	.stop_link = qcom_pcie_dw_stop_link,
> +	.write_dbi2 = qcom_pcie_write_dbi2,
>  };
>  
>  static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
> -- 
> 2.25.1
> 
