Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3775A7CB049
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjJPQur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjJPQua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 12:50:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF446CE7
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 09:40:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d01345d73so31934106d6.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697474446; x=1698079246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMErPVjbDQWKUZJi0yx3PHwgd44uCsmqExmEKyoGenQ=;
        b=zWk9E7Ir6vxH76P5DZnzRjvYqmPfoyDwHBQv23F85KEgYCgx6VJHoVNxizddvlapxL
         zEIt5kAkN1T8FVVHtzQzxo9O0JhXm52ZMQ0lxJ+b5e97huR2kGX6dQnmnszD91RcNK6d
         x5/qVinEqtCVIhoiF4y9t1vHFnLzfagUdmL8AkIfNjSetz2OLcepJ4WINuKt8nK79Pyz
         ipDZLfVbXpRwcQ+rXk6VEQP19HZG0YRLrBv7GP3zQJDnHctxmRKLuxnT46ReaUR6wRH7
         k/BoCFfTPzYV7i9VPfd2xwzhwxsIj9h1qvZDcufx7GlPcaGuTqwk82Kw3JXA0n8omqID
         vPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474446; x=1698079246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMErPVjbDQWKUZJi0yx3PHwgd44uCsmqExmEKyoGenQ=;
        b=qGO88pXoInKxMergq/21pWRO7V1aUwNORKE8KzidgcbIob3/BTEY4Biu2E1zGe0SIf
         1u+T9cS+h8/gy81Pg2EwzeTZH+OE+ugU3AasybDLTmB3lqaV41wb+OgB2BxDtq3Ch7Ak
         grfEFVqvkpomDcdLvt5LWtPilezhwdOJT0CMrtSo/u5C65zWh4t3uNYT38cHEASEtdFE
         KVlgVjWPMASr7fh2CC6uacWpCi0RdizrK2/XuIW/xgFtxhz4uqVa5VPvT2Sksllrdj/h
         NbHlwc26bRXbZpuJhY+7bvYRmb9I6vizjdfoXnLYeLi+6Iq/ljU6ZYlzdunpZxpDdK68
         L1oQ==
X-Gm-Message-State: AOJu0YyVQ1JIRZ3d7sKFOR3jS+ckZGsdStImS0bP6If1jPrk9yHKDdYb
        7ryh2A/SXi4AgR0JoUP6uQe5
X-Google-Smtp-Source: AGHT+IEJrtLsab3W/titRBbEr+F6cON9aYDks19MkUWPWxcQNbAkkCh7gLRrSjOouWXUxCmZiVJgZQ==
X-Received: by 2002:a05:6214:cae:b0:66d:28a5:d153 with SMTP id s14-20020a0562140cae00b0066d28a5d153mr11497866qvs.47.1697474445956;
        Mon, 16 Oct 2023 09:40:45 -0700 (PDT)
Received: from thinkpad ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id dn8-20020a056214094800b0065b0e724f83sm3548177qvb.6.2023.10.16.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:40:45 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:10:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/3] PCI: layerscape: add function pointer for
 exit_from_l2()
Message-ID: <20231016164036.GE39962@thinkpad>
References: <20230915184306.2374670-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915184306.2374670-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 02:43:04PM -0400, Frank Li wrote:
> Difference layerscape chip have not difference exit_from_l2() method.
> Using function pointer for ls1028. It prepare for other layerscape
> suspend/resume support.
> 

How about:

Since difference SoCs require different sequence for exiting L2, let's add a
separate "exit_from_l2()" callback. This callback can be used to execute SoC
specific sequence.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index b931d597656f6..20c48c06e2248 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -39,6 +39,8 @@
>  
>  struct ls_pcie_drvdata {
>  	const u32 pf_off;
> +	const struct dw_pcie_host_ops *ops;

Where is this ops used? If this is added as a preparatory for next patches, I'd
suggest you to move it to the respective one instead to avoid confusion.

> +	void (*exit_from_l2)(struct dw_pcie_rp *pp);
>  	bool pm_support;
>  };
>  
> @@ -180,6 +182,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
>  	.pf_off = 0xc0000,
>  	.pm_support = true,
> +	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
>  
>  static const struct of_device_id ls_pcie_of_match[] = {
> @@ -213,7 +216,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	pcie->drvdata = of_device_get_match_data(dev);
>  
>  	pci->dev = dev;
> -	pci->pp.ops = &ls_pcie_host_ops;
> +	pci->pp.ops = pcie->drvdata->ops ? pcie->drvdata->ops : &ls_pcie_host_ops;

This one also.

>  
>  	pcie->pci = pci;
>  
> @@ -251,7 +254,7 @@ static int ls_pcie_resume_noirq(struct device *dev)
>  	if (!pcie->drvdata->pm_support)
>  		return 0;
>  
> -	ls_pcie_exit_from_l2(&pcie->pci->pp);
> +	pcie->drvdata->exit_from_l2(&pcie->pci->pp);

You should always check for the existence of the callback first before invoking
it.

- Mani

>  
>  	return dw_pcie_resume_noirq(pcie->pci);
>  }
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
