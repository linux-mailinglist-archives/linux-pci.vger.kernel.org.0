Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0852523D404
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 00:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHEWsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgHEWsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2020 18:48:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF6C061574
        for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2020 15:48:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f193so13411451pfa.12
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2020 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2f0chzsU8plamndGAVa0L+UE4xurrF8AKN1ix/elzeo=;
        b=LOq++iuhI8DCPBmvAeXeK/R4Egf9sXfsO+JT+/SfxSso00VNm7Owtu/33R1IS0Wdeg
         5cgE+2K4leqV8LFpAL8zTtFMcgIOH1TEuj2VQguyDAXEa0Fn1TvGiD5vMj9rq10q3ukx
         xTNbJJ62lXn8Aog2ut6XDKkljIOiYrE58r4Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2f0chzsU8plamndGAVa0L+UE4xurrF8AKN1ix/elzeo=;
        b=jHBAQnFWwY6dbgYngDGMQrbN5UvG8UmE89gkFinO/FCsmrh44yBDOXMBfh3gTqbEaZ
         mOttKh8UMBGgcolsumgK9lJJDAbsbWBSin8H+WeO9bsvnb2jRVU/mfs08AT8X9e190J/
         dzMapA9UBWckNlmaaqd+ci6/GEcMMNiBCpZoqoTD58ifXRo9Fphfic2z6IIi7a8LcHjm
         tLn/XQv9W98/mcjojRdo6e/MemfVm1pzcHTeTFqgdb3M+sPTB6yjL+9SBTu0x6oeaIWb
         KuKaXYLfBsRlWCvsfMa2JgYCCKjfM78WhIcTzO/FOEGBusku8AvPbld6+TUpd2NA2rca
         KLdQ==
X-Gm-Message-State: AOAM530fjqC8U/tmlP1+Vc4S5SBP51FZXEaNR3asWF7/BbD3/6I6riHu
        4fFDYg6YfuFM8ge2xAkPXJ9IJA==
X-Google-Smtp-Source: ABdhPJyC+rZ3Bjtr0TdW+a+bIzEPmblHyS5UqJfZswoqNuslOCgYSdiV2Xf7kGGECmLcSIkxYh4bpA==
X-Received: by 2002:a63:5349:: with SMTP id t9mr5210648pgl.204.1596667718770;
        Wed, 05 Aug 2020 15:48:38 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id f3sm5378263pfj.206.2020.08.05.15.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 15:48:37 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] PCI: iproc: Set affinity mask on MSI interrupts
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        helgaas@kernel.org, sbranden@broadcom.com, f.fainelli@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <00166b29-f284-984c-81c2-54d5c1e3343a@broadcom.com>
Date:   Wed, 5 Aug 2020 15:48:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2020 8:52 PM, Mark Tomlinson wrote:
> The core interrupt code expects the irq_set_affinity call to update the
> effective affinity for the interrupt. This was not being done, so update
> iproc_msi_irq_set_affinity() to do so.
> 
> Fixes: 3bc2b2348835 ("PCI: iproc: Add iProc PCIe MSI support")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
> changes in v2:
>  - Patch 1/2 Added Fixes tag
>  - Patch 2/2 Replace original change with change suggested by Bjorn
>    Helgaas.
> 
> changes in v3:
>  - Use bitfield rather than bool to save memory.
> 
>  drivers/pci/controller/pcie-iproc-msi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 3176ad3ab0e5..908475d27e0e 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -209,15 +209,20 @@ static int iproc_msi_irq_set_affinity(struct irq_data *data,
>  	struct iproc_msi *msi = irq_data_get_irq_chip_data(data);
>  	int target_cpu = cpumask_first(mask);
>  	int curr_cpu;
> +	int ret;
>  
>  	curr_cpu = hwirq_to_cpu(msi, data->hwirq);
>  	if (curr_cpu == target_cpu)
> -		return IRQ_SET_MASK_OK_DONE;
> +		ret = IRQ_SET_MASK_OK_DONE;
> +	else {
> +		/* steer MSI to the target CPU */
> +		data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +		ret = IRQ_SET_MASK_OK;
> +	}
>  
> -	/* steer MSI to the target CPU */
> -	data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
>  
> -	return IRQ_SET_MASK_OK;
> +	return ret;
>  }
>  
>  static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
> 

Looks good with the Fixes tag added. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
