Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69783AA322
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhFPSZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhFPSZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 14:25:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D736C061574
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 11:23:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g4so2253255pjk.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qu5SD0l3J+MDZZbvAdUGnh9/5F/6cc6Lr04cR7Nq4MY=;
        b=qqkpl6U0YvA+hUg7B593WU8MAe3Mdmoo4lgakJQH9B+Elgp1QTp5DQMnmQ0Jiangyy
         iJ4m0CF7RecpNQXLkp24mXhEnH8FdkEbopyiHpoRJSGgOUuLKRw3IdNR6YW9A8Eh+c9e
         O2N7tvzRD9CjQEp3Bn8m4FyW6HBlbAo5kA8R6kXmR0Ehtc+k8ejD27jTYigLkx6VR9Ia
         LUpqt4N340nG8IiGSQDXAY1RkuNg/V1vD4+gFPdV/cReQxol/8v5FZns5uNjMiEEOCJS
         LH7b0QG+XTzXg6ENVGReIzC7b9jkEN435ZILI0nzZ5Y7vyWjDsPORw9dnzRS/5XNXdKy
         IOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qu5SD0l3J+MDZZbvAdUGnh9/5F/6cc6Lr04cR7Nq4MY=;
        b=KfwsgsPH7ESzerbokPAlCutRpkOJBIadQthKkF00mh0U97bg5JR0y4M0zCafo6RJu/
         LTAB00ALoqOq1KHmpMxinaSeZrdRerJ3SWSnIm9x9zbnSsnoQPMO1ceIJRQS5DKWH4At
         QpGjmuZ0cuapGJUitlWhnO5xE0YAe+9lzK4Z4fz8AyfYhI6UYlDSmfLPyJe6da+wuJpR
         bCpqWYl1W8Wct8fJHjMwHDhVteO7YSF7EEwW4Ct/q1ArLcUwzQs9rQeRE8ATGHEorZu0
         igItzR4AYqyo2d4g0ULEqRWJCr6KDvew+Hv+rMyuMCJd9pV/vVSqQMD65NTWFU6jwfat
         BJkg==
X-Gm-Message-State: AOAM533z+uDHRk+rhakN/pZggsQFJraz5/pWUwNtg8i4UgzRrTSEQLIR
        9gFCJQHEKpwkisVfyKhE1Q1A
X-Google-Smtp-Source: ABdhPJzetd5O+MxiPg0+9m/TPgj/TWEUgQZPR/EkqFlN+HQBg2H7glLKdwH5AO+iAWSDdiICyY3IEA==
X-Received: by 2002:a17:902:a60f:b029:11e:62b3:e454 with SMTP id u15-20020a170902a60fb029011e62b3e454mr770493plq.51.1623867799751;
        Wed, 16 Jun 2021 11:23:19 -0700 (PDT)
Received: from thinkpad ([2409:4072:17:2c05:a14f:78ce:1082:5556])
        by smtp.gmail.com with ESMTPSA id t1sm2761822pjs.20.2021.06.16.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:23:19 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:53:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller
 driver
Message-ID: <20210616182313.GA152639@thinkpad>
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-3-manivannan.sadhasivam@linaro.org>
 <YLw744UeM6fj/xoS@builder.lan>
 <20210609085152.GB15118@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609085152.GB15118@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 09, 2021 at 02:22:00PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Jun 05, 2021 at 10:07:15PM -0500, Bjorn Andersson wrote:
> > On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
> > 
> > > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > > the Designware core with added Qualcomm specific wrapper around the
> > > core. The driver support is very basic such that it supports only
> > > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > > for now but these will be added later.
> > > 
> > > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > > operation and written on top of the DWC PCI framework.
> > > 
> > > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > [mani: restructured the driver and fixed several bugs for upstream]
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Really nice to see this working!
> > 
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig        |  10 +
> > >  drivers/pci/controller/dwc/Makefile       |   1 +
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 780 ++++++++++++++++++++++
> > >  3 files changed, 791 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 423d35872ce4..32e735b1fd85 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -180,6 +180,16 @@ config PCIE_QCOM
> > >  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> > >  	  hardware wrappers.
> > >  
> > > +config PCIE_QCOM_EP
> > > +	bool "Qualcomm PCIe controller - Endpoint mode"
> > > +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> > > +	depends on PCI_ENDPOINT
> > > +	select PCIE_DW_EP
> > > +	help
> > > +	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
> > > +	  to work in endpoint mode. The PCIe controller uses the DesignWare core
> > > +	  plus Qualcomm-specific hardware wrappers.
> > > +
> > >  config PCIE_ARMADA_8K
> > >  	bool "Marvell Armada-8K PCIe controller"
> > >  	depends on ARCH_MVEBU || COMPILE_TEST
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index eca805c1a023..abb27642d46b 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> > >  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > >  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> > >  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> > > +obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> > >  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> > >  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> > >  obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > new file mode 100644
> > > index 000000000000..b68511bacc2a
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > @@ -0,0 +1,780 @@

[...]

> > > +static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
> > > +					     struct qcom_pcie_ep *pcie_ep)
> > > +{
> > > +	int irq, ret;
> > > +
> > > +	irq = platform_get_irq_byname(pdev, "global");
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "Failed to get Global IRQ\n");
> > > +		return irq;
> > > +	}
> > > +
> > > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > > +					qcom_pcie_ep_global_threaded_irq,
> > > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > 
> > Leave out the trigger and rely on DT.
> > 
> 
> Okay
> 
> > > +					"global_irq", pcie_ep);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to request Global IRQ\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
> > > +	irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
> > 
> > Is the global interrupt needed for dw_pcie_ep_init()? Or could this
> > simply be done when things are ready to handle the interrupts?
> > 
> 
> No it is not needed. I can move this after dw_pcie_ep_init().
> 

I don't know why but I'm seeing issues when this gets called after
dw_pcie_ep_init(). So I'm keeping this function as it is for now.

Thanks,
Mani
