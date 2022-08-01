Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D21586BF5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiHAN2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiHAN2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:28:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2633C8D9
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:28:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso12413536pjq.4
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wyQqPKgBTGooqZfohpI1mfr8+wRbGXjvZx6y58chggA=;
        b=llMzU+PmXn8jowe/WZtM708qdAhg0SRPpGZUPSdzCnyXQU7Oh7acn+pWlwMF4mYMZi
         cqcceiPSVNHCGTiUhuai9CSLBod+3dTA/4z2rv0p0WyRxO3XLjHWhUv72QTXvqKv7ksD
         Pt+NEI4N+BSttGQpSAJpmC5rLjPWEEEI/8PeUXTq+WoBk2H8aMSN6QQLHZHHieGa3L7S
         RrW/QPJx4MA6L4dn/Xqz3kfUmF+I3YPg2Kur6lj0zN1h/OQAXWg9XRO4nUSnYczo0J3x
         bMjJG+3bYAGTZ7qr69219QdJrFeAMAbV1duarZX+6yT8sEYIFOBy6va6pJJfNyJ8Rwbr
         mECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wyQqPKgBTGooqZfohpI1mfr8+wRbGXjvZx6y58chggA=;
        b=KqAOejgI1IRoRQECsu9gyCGvn2NmOmejL16pr+FkcT51/+548EbEO47X9Cq3b/zq03
         7oL7Z5Z1PwvqkZxhSsHk4yiGAOQYM9odAf6FVPvxYaA+mlEew41XrTPz3keCLPqIrjJO
         DG1q5c2fIcmvgKbQFV7O+/PdLeaV6fiTZ9DihJ+epb236ZURRKAzTYLkmkxqJiFlR/e+
         Uhjux/HycLHGLRA6cTam85sKSGhdSN7QGIu3sFpKyTM60TOSbH+HoSr4nWJ3Y5IScYwx
         YAZDrjzZfoeIRxYJddx7wEKWr8fxxqVYXPkOumgmJIxICQlmvS025Mso6n8VUM5Tv7LM
         911Q==
X-Gm-Message-State: ACgBeo2Gt1QAic6pEvREcp3stBOYp5X0cCwU5mSIrOh8StnUhqQOtW8+
        9/dQyy8MycA+nCYb8iialGbM
X-Google-Smtp-Source: AA6agR5zmrc/qpk0QEVdPd0hGYr/gqqpLMP0KZT8hDjPgliTh6m/o/2HqS8lfcbo52JPraornwDhIw==
X-Received: by 2002:a17:90b:4c12:b0:1f5:958:c313 with SMTP id na18-20020a17090b4c1200b001f50958c313mr3657056pjb.6.1659360508919;
        Mon, 01 Aug 2022 06:28:28 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a1b8400b001f32f242020sm7502648pjc.43.2022.08.01.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:28:28 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:58:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, eswara.kota@linux.intel.com
Subject: Re: [PATCH RESEND v4 06/15] PCI: intel-gw: Drop manual DW PCIe
 controller version setup
Message-ID: <20220801132817.GF93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:38PM +0300, Serge Semin wrote:
> Since the DW PCIe common code now supports the IP-core version
> auto-detection there is no point manually setting the version up for the
> controllers newer than v4.70a. In particular Intel GW PCIe platform code
> can be set free from the manual version setup, which as a positive side
> effect causes the private device data removal too.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

I don't have a hardware to test. But going by the DWC spec, this looks good to
me.

CCed the author of this driver, "Dilip Kota" in case he can confirm.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Folks, I don't have Intel GW PCIe hw instance to test it out. Could you
> please make sure this patch doesn't brake anything?
> 
> Changelog v3:
> - This is a new patch create as a result of the discussion:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 371b5aa189d1..a44f685ec94d 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -58,10 +58,6 @@
>  #define BUS_IATU_OFFSET			SZ_256M
>  #define RESET_INTERVAL_MS		100
>  
> -struct intel_pcie_soc {
> -	u32	pcie_ver;
> -};
> -
>  struct intel_pcie {
>  	struct dw_pcie		pci;
>  	void __iomem		*app_base;
> @@ -394,13 +390,8 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
>  	.host_init =		intel_pcie_rc_init,
>  };
>  
> -static const struct intel_pcie_soc pcie_data = {
> -	.pcie_ver =		DW_PCIE_VER_520A,
> -};
> -
>  static int intel_pcie_probe(struct platform_device *pdev)
>  {
> -	const struct intel_pcie_soc *data;
>  	struct device *dev = &pdev->dev;
>  	struct intel_pcie *pcie;
>  	struct dw_pcie_rp *pp;
> @@ -424,12 +415,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	data = device_get_match_data(dev);
> -	if (!data)
> -		return -ENODEV;
> -
>  	pci->ops = &intel_pcie_ops;
> -	pci->version = data->pcie_ver;
>  	pp->ops = &intel_pcie_dw_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> @@ -447,7 +433,7 @@ static const struct dev_pm_ops intel_pcie_pm_ops = {
>  };
>  
>  static const struct of_device_id of_intel_pcie_match[] = {
> -	{ .compatible = "intel,lgm-pcie", .data = &pcie_data },
> +	{ .compatible = "intel,lgm-pcie" },
>  	{}
>  };
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
