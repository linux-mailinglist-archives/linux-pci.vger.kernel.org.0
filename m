Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAA23370B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgG3Qp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgG3Qp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 12:45:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF41C061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 09:45:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so25536343wrl.4
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ej86RLhiH25iZDP4wdWxFB2UmXj5vFm/8QPxIezwAmw=;
        b=YTk7AnLaFlkL+C5U3ihsRpQI0XMJOdvkoUEWMS9jcSJYPJZwNBQDr6HcZ+wxr3xCaw
         AuAy4DSgV2DR6MQgxwofQT7xWRRUHdLTqDRgjutaTia7srGw7KXsio2BKdaK15EOYGL8
         HNWPYs2SUOV5KARFWNpe9q41o1boLHHtcq1GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ej86RLhiH25iZDP4wdWxFB2UmXj5vFm/8QPxIezwAmw=;
        b=IiM5Af7aDIUZN0+Pd8vzEfhk93I/mPFLM3DQVpXkuNR2BxsDH+a8Pt4DXTqlzKWVMh
         X7vEzeviBaQoE14URElytiI84ZbWWic7eJbUI8MvPkx3hILukRj3y7/CO9P/5Vza1Gd2
         JBZxKGIxNpthxY/z/lHnIkqmgVyoY/cBMwFsl/PyS71QMUzQEENLAJdLvSHhlPEo0qk7
         vtn/EJt+HWikmBDYgeqrWKJvX/WAosyYmmnR71jTMvN8xPaHcyS+j01K+NtmOfi4gDOe
         HlK4JDlPtgC1emoDlgks/XBcgtLKLS4gMGKiMAjiyj1JTXgqQbmzY6co3+Ielu+OTJL5
         KcaA==
X-Gm-Message-State: AOAM531fnAsu3w5gpyyIWxkpjReRvNy+4on9YqW6AWwmNd0lzlNbzNvj
        gzOzrumUZ3lxZM6kFL5FbCtgJQ==
X-Google-Smtp-Source: ABdhPJxQ+4Py8GSmISIKP5nUNjBHnbsK7/iDIeqxIPnglPJHKmzJTwilIeilvMYgJKN8kLcSf/V1Ng==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr36482383wro.239.1596127524535;
        Thu, 30 Jul 2020 09:45:24 -0700 (PDT)
Received: from [10.136.8.246] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n5sm10013589wrx.22.2020.07.30.09.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:45:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI: iproc: Set affinity mask on MSI interrupts
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <ddef93f0-4f5b-f860-bc2e-96ccc84ad040@broadcom.com>
Date:   Thu, 30 Jul 2020 09:45:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/29/2020 8:37 PM, Mark Tomlinson wrote:
> The core interrupt code expects the irq_set_affinity call to update the
> effective affinity for the interrupt. This was not being done, so update
> iproc_msi_irq_set_affinity() to do so.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
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

This change looks good to me. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
