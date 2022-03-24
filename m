Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDB4E6341
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 13:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbiCXMZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350115AbiCXMZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 08:25:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FF6C901
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:23:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o8so3686052pgf.9
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z4WNUE0SQ7AcTZpUyW34flyJ5yZIuj5U0XV1//+SiUE=;
        b=xpVgGbKhRJ+1HIMaEPQ0AyhFZdEUyEiuQgaKzkRb5Oclm8XUZJrLudG1Zaib3KsMGZ
         LrS4NdfkcCurEOuw377SB6nduFWl3U6WgN+WHv916Eqq0PBGlZRhi51tEiemNS3H463z
         erXPeFy+n3XSmQWcyI2eNKAGKlQvnDaDNfe0LjhX1SzvN1ZfkxWg3KevWQEpDXZoU/pD
         JfMRrJDQRnksZpCq1Qq/2rHlZGDNMAUAQPzJZt04gB3rkLQjIB+aiEncLBpjh5R3cMrm
         fHehMW1NvifBE+j9sn1prOWJSIt7gGEmMQn3Z9p6CHYgYVPU7WuW0jNfyXJIAt6M+mtj
         LM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4WNUE0SQ7AcTZpUyW34flyJ5yZIuj5U0XV1//+SiUE=;
        b=okKzXMDQPBrPnXyahgAdqEuuVU/L3bHaOinHb06JP80tNK+RPVIldQz6fV9weB+70N
         5orI9qTRPTHQpSIm0viAyDrR4jtxBgBHHY4r1lyo1NBRBANULVUyDqDWMYmn2Zj4hIXD
         IcHcmebps1Ov9I/zjNSQNE8NhzM9IO5HYZH2WNPRtE4+O2Hl0a7H6m1mpPJ87H56CJSk
         SgURhKS4m24ojvpSAyD7jLp9z9bEBlV7aBQHc4quwDcGwNXHOLEZ8ZJlUVh40BNIjCGQ
         cT0VAiLl/+tC4GHmvFevpi7XAmBUIY/SoVgeB7n3Vbw9ZBwUQYYu5+iL4NlSdUKKg8AS
         3Pmw==
X-Gm-Message-State: AOAM532wg5jfBPoJnMK9v2luTnpgMpXtirNOgQCswjaVVi2bWyfuvWGq
        hvxhZNNAX5dUwzrmxvRLS2bN
X-Google-Smtp-Source: ABdhPJzu5lQz+0A0M8ta/nScF7b2q+qBxwB6tHLT2lACLcu6rC5B5SveT4xGuVy1CPvM3S71qULoyA==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr5126389pfu.6.1648124622239;
        Thu, 24 Mar 2022 05:23:42 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id pf2-20020a17090b1d8200b001c6f65ca66fsm9888363pjb.47.2022.03.24.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:23:41 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:53:36 +0530
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
Subject: Re: [PATCH 10/12] PCI: dwc-plat: Simplify the probe method return
 value handling
Message-ID: <20220324122336.GJ2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-11-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:21AM +0300, Serge Semin wrote:
> The whole switch-case-logic implemented in the DWC PCIe RC/EP probe
> procedure doesn't seem well thought through. First of all the ret variable
> is unused in the EP-case and is only partly involved in the RC-case of the
> switch-case statement, which unnecessary complicates the code. Secondly
> the probe method will return zero if an unknown mode is detected. That is
> improbable situation since the OF-device data is initialized only with
> valid modes, but such code is still wrong at least from maintainability
> point of view. So let's convert the switch-case part of the probe function
> to being more coherent. We suggest to use the local ret variable to
> preserve the status of the case-clauses and return its value from the
> probe procedure after the work is done.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 0c5de87d3cc6..fea785096261 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -153,20 +153,21 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  			return -ENODEV;
>  
>  		ret = dw_plat_add_pcie_port(dw_plat_pcie, pdev);
> -		if (ret < 0)
> -			return ret;
>  		break;
>  	case DW_PCIE_EP_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_EP))
>  			return -ENODEV;
>  
>  		pci->ep.ops = &pcie_ep_ops;
> -		return dw_pcie_ep_init(&pci->ep);
> +		ret = dw_pcie_ep_init(&pci->ep);
> +		break;
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
> +		ret = -EINVAL;
> +		break;
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static const struct dw_plat_pcie_of_data dw_plat_pcie_rc_of_data = {
> -- 
> 2.35.1
> 
