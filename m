Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963E023375D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgG3RH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgG3RH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 13:07:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6DAC061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 10:07:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so15628049wrm.6
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U4/fCKEaOg5ivgSUmyymsqN1/3Ase26RqYDuGZ8zEg4=;
        b=YINyiCSYVD/mOoNk+0DnhOqpMeQTejAPufFXW98uU+jXD++YXmYU7QB0+hb0SMbxkZ
         63R4kaOL8vWrPhFwe3Irk5dxIJF3wxcqMy37gY8cFjJvSnTsmrOhMFt28LCWIwARaex4
         +WBMRn6XoXhDyhDYmJxjLduHufz2uAo3QxjnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U4/fCKEaOg5ivgSUmyymsqN1/3Ase26RqYDuGZ8zEg4=;
        b=sOcw7T4mLnRJI80CM4Ye+CRK7Am3vMGpu9fJKPDBmjgChM28TsaBXIyvGUJl9JFNpt
         e2onefXCVK4YKPLMV/OTE0doT4b4nHD/5OiiatVwtOiIPBlyv4N6wjholYQo2ZhgQ1zI
         3e1s5bhA5G5uohdu7I0z+zllWiOtXgxYKkz3fXkwIxXhHn2mW7MJScf8m8fPpmRXKZBW
         TFZiC1Tc4DfGyg2tpHRYBjAXnwDJfx/qNK39IUlyJiwJyWgPlXif1fgAONCQz8Zwx7Vd
         e/M2E1TSirJUHzx2gLJ3G17K1slf0YGwsrFpZe13LfQpR3GR5KjCT/4SKYKR8aDgmIWG
         AWqg==
X-Gm-Message-State: AOAM5328SrmTAym28M97yRvzOQ9GGoabqqEUjWr33hpgonbRnsx8pAN6
        IcCHEhGJbIgvL98VL+p6bEkDwA==
X-Google-Smtp-Source: ABdhPJy+TKxGfhkd4RyaLsf3s0ITIMyWB0UX2+YWsBMAiy6E0el1YFPGkP2mRyuA/h1rPr2f5v0K/A==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr3924303wrs.226.1596128876489;
        Thu, 30 Jul 2020 10:07:56 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m126sm9770222wmf.3.2020.07.30.10.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 10:07:55 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI: iproc: Set affinity mask on MSI interrupts
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0aa1e61f-4c9c-521e-2652-74942ccda970@broadcom.com>
Date:   Thu, 30 Jul 2020 10:07:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-07-29 8:37 p.m., Mark Tomlinson wrote:
> The core interrupt code expects the irq_set_affinity call to update the
> effective affinity for the interrupt. This was not being done, so update
> iproc_msi_irq_set_affinity() to do so.
>
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Should this have a Fixes: added to it?
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

