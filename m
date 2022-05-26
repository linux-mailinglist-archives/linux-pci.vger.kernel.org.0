Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A5535338
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiEZSSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiEZSSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:18:07 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747D4E3A2;
        Thu, 26 May 2022 11:18:06 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y66so3087071oia.1;
        Thu, 26 May 2022 11:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWIDSO4xYL37ZSf90h/Q2luSOODhqLF6KrE5sl8RQZU=;
        b=mZF8dGj7JHEwEiW3tv6J/ExDRP8GPuhmed3RL/9n5tZukX/8VtbhX84IP52PVYl8rB
         hI1RHr0KSZxGka+qoPVgsIv+SfGYWjRNK5t81Gs7jFC4fyLnXAWqEhLXu0QjzuvStDQT
         uLXeZbAf3CLB0njYMSfYqEZuSCEvADKNoXmyqpDJ4B/zInWHTAZzdF/De/cl1ODzbK4+
         FYPYf4p6efuPcN+Jb0sxdya4qWSDZie+2B25doS36QC6VuLpVJn973P7B2SOu+K1xRED
         NR4JgUZhyqVFTOshXEqi8OI8caWpqf9k32xfH7HKRUT5vsTtHsvwigWfB3zhusyGhG41
         QyZw==
X-Gm-Message-State: AOAM531Mt71FHLke26kybT1S0SnDvxdFAI7aKmw/1bjTovbnSji8kpNa
        844yrBaUQtNYO1zN1+Hwrg==
X-Google-Smtp-Source: ABdhPJzc5U2KbgmOL+UjdLNlxyy021MFl6y419koEKxbXXrM588RA7MeRsqm7piQPjZ6PtJ68eRM0g==
X-Received: by 2002:a05:6808:1817:b0:32b:6b00:e9a8 with SMTP id bh23-20020a056808181700b0032b6b00e9a8mr1884238oib.278.1653589086095;
        Thu, 26 May 2022 11:18:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u8-20020a056808114800b0032af475f733sm968029oiu.28.2022.05.26.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:18:05 -0700 (PDT)
Received: (nullmailer pid 90016 invoked by uid 1000);
        Thu, 26 May 2022 18:17:58 -0000
Date:   Thu, 26 May 2022 13:17:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 5/8] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <20220526181758.GD54904-robh@kernel.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:33PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++++++++++++--
>  1 file changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a076abe6611c..98a57249ecaf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,47 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static const char * const split_msi_names[] = {
> +	"msi0", "msi1", "msi2", "msi3",
> +	"msi4", "msi5", "msi6", "msi7",
> +};
> +
> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +	u32 ctrl, max_vectors;
> +
> +	/* Parse as many IRQs as described in the devicetree. */
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);

I'd do this instead:

char *msi_name = "msiX";
msi_name[3] = '0' + ctrl;

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
