Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045A5554941
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbiFVIt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiFVIt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 04:49:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7B377E2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 01:49:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso16135069pjg.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OqVQQzO2bmTkLsjfEgy0N2PCB5sIpeK0ST4kLBz+5UQ=;
        b=orx2PuQMnX0OKhwpx1a8vrDaZvwWUiHkqTDoEQHrkwRZEosOeBfpccVxdsF1ZWPXEJ
         yTH8eHdJeQpV40LfR2bDJFlTfMyyiRmzSJHZ34dug4e6msew5yk+bO5e5tdmijYN2qAG
         cZk2i23zxwUyRIVJKwFlt8tAuWd3h0oIWUVA3KbOTi7hWJYZ0yzdFAjAtwliJUzP8gyB
         356D0U+FTmx+Ri1laRPXi6DiwJWmG88IzA6HcRvVWUJn5zSdcbi9VxeSyvxDzfXoXgzW
         L+Qx5hACRSAipMGGWhgh5teSFOsKJXFSVAZZN8EaWZ5KHA7rpiS8TLO8X1QmJ12Nc0MT
         SAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OqVQQzO2bmTkLsjfEgy0N2PCB5sIpeK0ST4kLBz+5UQ=;
        b=vEJGicx5FNyEB+KEyHRBHgfIxivIy+7TWIAD26Ji17G8FJqvHvhNphz18pp2/9K0cN
         d+CRSnnqUK1RlnVMTSychkBImaSa3ICSBPOxaRSmsNfNaolY5gn/6jpguB2L04IdCFXG
         bnyuP8+zR7s0kSEA3LUuXmEwvg1oyEARa5Vs5dibRqT9RymVsZUJb5b64VPIFLwXcbyB
         Q5U9ke/3dya/82sYgyCyXA+lMfXYv+cBqIQpXBpTzrsWENcPMKtvFQ0GvtJSd1QRa8gy
         OhgG4454ypiT0scUGAlIa/Mwfz8b++IxM4SoFJkGG8UdL4GoGPZU8l/KVLfz8kADQ8pW
         Dqug==
X-Gm-Message-State: AJIora+Vx7y6sHfCWm+/2utfCtDTS96PeQuEI7PJ0/684OUbzh7+bG8T
        7NjTbOYdl1XMWHqkeVAb/LSY
X-Google-Smtp-Source: AGRyM1tlIKtxTU1k588cgO/Tm9+SVfp1pTEELWWjZ+7MAkDNgQFHHXPx6giTDxFmUDVAH65H87OQug==
X-Received: by 2002:a17:902:d4c2:b0:16a:46e:8c7b with SMTP id o2-20020a170902d4c200b0016a046e8c7bmr26568336plg.142.1655887766135;
        Wed, 22 Jun 2022 01:49:26 -0700 (PDT)
Received: from thinkpad ([117.193.212.116])
        by smtp.gmail.com with ESMTPSA id k198-20020a636fcf000000b003fd1111d73csm12508122pgc.4.2022.06.22.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:49:25 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:19:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Message-ID: <20220622084917.GC6263@thinkpad>
References: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 11:50:31AM +0900, Yoshihiro Shimoda wrote:
> Add pci_epc_release() for epc->dev.release and move kfree(epc)
> to the release function. Otherwise, WARN() happened when a PCIe
> endpoint driver is removed.

So you have mentioned why you are adding the release callback but not justified
the move of kfree() to release callback.

The commit message should clearly state what the patch does and why.

You can use something like below:

Since there is no release callback defined for the PCI EPC device, the below
warning is thrown by driver core when a PCI endpoint driver is removed:

  Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
  WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c

Hence, add the release callback and also move the kfree(epc) from
pci_epc_destroy() so that the epc memory is freed when all references are
dropped.

> 
>  Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
>  WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

With the commit message fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Changes from v1:
>  - Move kfree(epc) to the release function.
>  - Revised the commit description.
>  https://lore.kernel.org/all/20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com/
> 
>  drivers/pci/endpoint/pci-epc-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..2542196e8c3d 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -724,7 +724,6 @@ void pci_epc_destroy(struct pci_epc *epc)
>  {
>  	pci_ep_cfs_remove_epc_group(epc->group);
>  	device_unregister(&epc->dev);
> -	kfree(epc);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_destroy);
>  
> @@ -746,6 +745,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
>  
> +static void pci_epc_release(struct device *dev)
> +{
> +	kfree(to_pci_epc(dev));
> +}
> +
>  /**
>   * __pci_epc_create() - create a new endpoint controller (EPC) device
>   * @dev: device that is creating the new EPC
> @@ -779,6 +783,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	device_initialize(&epc->dev);
>  	epc->dev.class = pci_epc_class;
>  	epc->dev.parent = dev;
> +	epc->dev.release = pci_epc_release;
>  	epc->ops = ops;
>  
>  	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
