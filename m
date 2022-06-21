Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B36553462
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiFUOVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351375AbiFUOVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 10:21:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDD222AD
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 07:21:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k14so1192229plh.4
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GRsv7drQw2ERQmAVxWNghAdU2R4uu9ssy2NxQwDwrBY=;
        b=xPGl4IrWQfBQ+vG7TfDRNd/W7uZAUYdEUW1d/Ce9gELIGxvW0hGjizDEuy7Qb5ekhZ
         G38V2B1ArPHeoJdOKB7NLvcVVmkCi+9ebhkMn0m5qb/p2G/IU4uxqL767HKAsCdSpn0z
         AQqJSRc4TOueI2xWf0iWbCC1tc89T9ZVeZvVbjsON+5r1FVTL63HUnUrkvQWmO5KyWjP
         GJL5koutzAPB/P+OUhP8Nl/fIzSTiTyMUyONjbmTgl1R2Vprt/xi3Du0/a4BwAZJ5XPf
         IsKML+8rLwfXoUASR5UfFemFKGcftYU4D2XAoHQsJEOeqRe6kOfZZick4yn5fVCC0gRd
         SkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GRsv7drQw2ERQmAVxWNghAdU2R4uu9ssy2NxQwDwrBY=;
        b=kHV/YGzuHqloU+eayPqBMsKy1EvePBzOEhOVXgMwM+j88BhpshBxHvNvdyTOkL9FeW
         gROeOBOF5zCQiZbgiKSWSJgJZsxI1z14ZVP0bHGKV9ZuQNV8iclSYHDE5deMP2mmg2PZ
         6ktn/PdGWGvo1E3izdejaBZAnKpChiaJBwvNPcUoX3bdGVInK0i9gK2rBoaz9ZS7Vjfv
         IDnjx2WeQ2dVR4XCOoQ2QVOHo9y+tUz69Ag+B8yK/jFX7160mZA2q3Cj/whubjB65dck
         OJzu6r8IRhE1gpc2F81heiGTOjnlMd056hm4ahQl2Eao8lIat8Rpooq4mYzUGZpWAps9
         HARw==
X-Gm-Message-State: AJIora+UGubW7+QbKuZi8Fbwf38DMEDZWvZv0d17T55l7AClXomPK4c1
        nLBkFrtrfrqRNKD04RQEjFJm
X-Google-Smtp-Source: AGRyM1v+gUvbQCm70x6EpSUqIAzUuhdAyOQaY5QNN7y7FRuK+wRBdhAJGvjl+18PlInXO56vucELAw==
X-Received: by 2002:a17:902:f391:b0:16a:2d12:152c with SMTP id f17-20020a170902f39100b0016a2d12152cmr7529281ple.102.1655821263380;
        Tue, 21 Jun 2022 07:21:03 -0700 (PDT)
Received: from thinkpad ([117.193.212.116])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b00163f3e91ea0sm210437pln.238.2022.06.21.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:21:02 -0700 (PDT)
Date:   Tue, 21 Jun 2022 19:50:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Message-ID: <20220621142058.GE17181@thinkpad>
References: <20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 09:11:47PM +0900, Yoshihiro Shimoda wrote:
> Add pci_epc_nop_release() for epc->dev.release. Otherwise,
> WARN() happened when a PCIe endpoint driver is removed.
> 
>  Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
>  WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c
> 

Hmm... So the core is correctly throwing the warning here but just using a NOP
release function is not the right solution IMO.

Currently, pci_epc_destroy() is handling all resource release including freeing
the memory for epc. But I think the "kfree(epc)" should be moved to this
release callback. Reason is quite obvious. Until the release() callback gets
called, there would be a "epc" device instance floating around and we should not
free it until then.

Thanks,
Mani

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..cb533821b072 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -746,6 +746,10 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
>  
> +static void pci_epc_nop_release(struct device *dev)
> +{
> +}
> +
>  /**
>   * __pci_epc_create() - create a new endpoint controller (EPC) device
>   * @dev: device that is creating the new EPC
> @@ -779,6 +783,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	device_initialize(&epc->dev);
>  	epc->dev.class = pci_epc_class;
>  	epc->dev.parent = dev;
> +	epc->dev.release = pci_epc_nop_release;
>  	epc->ops = ops;
>  
>  	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
