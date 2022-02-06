Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D803E4AAFFA
	for <lists+linux-pci@lfdr.de>; Sun,  6 Feb 2022 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiBFOhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Feb 2022 09:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiBFOhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 09:37:04 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:37:01 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0025DC06173B
        for <linux-pci@vger.kernel.org>; Sun,  6 Feb 2022 06:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c734QoJ0N3ubA4P/xF6Cud+YWMs/xlJgGiqXQkFUJtw=;
        b=Iivso7wo4Z1IF0f6Ruxxh9mh+ouXPGO/ymjWilnYAFnOF9Gy8Mgg//UFt9G6x+LJhDC6VL
        PW+ijsLPeGR7Zrc4y5JFklE0UJSBdmiIyz58enBmHG6Hwt+zw0Y8AYrIj4IZO93Z12fhZe
        pYyaTdHbaZx9wB6b4F0LoFUU9KEkLS8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-QTs5h3IxOCKHI3EiR_XniQ-1; Sun, 06 Feb 2022 09:34:58 -0500
X-MC-Unique: QTs5h3IxOCKHI3EiR_XniQ-1
Received: by mail-ed1-f72.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so2463206edz.8
        for <linux-pci@vger.kernel.org>; Sun, 06 Feb 2022 06:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c734QoJ0N3ubA4P/xF6Cud+YWMs/xlJgGiqXQkFUJtw=;
        b=ECurBb7o4zv47KAMi96MnqZXbqTu1coWEzf3BzACqz1B9eXVpw+E3+fFyiBntJdqLy
         4YtwSnzaDtTlc5WKzw3I5HOCslq/nhWwQjIEOcGP7B7vWRyW9JOAGg+iZPpxBFcq2pBO
         1HSuywgHq11R+xrJ6l4kJ6s0qecePCvGmqnZ/T7AXZnPUhI8/Ukn6GEB6OCK7bgYSKhu
         clB3iS77QH8cOEvnn1fh9FikTiAjTS0je27aDLOziCa0dhZU7NHquYh1YXQT26W/wzcP
         97o+4HOsBtO/TCg50ozo3g1vEHe6LMTBlBN8kioSqgyvrdf1Md5YHaoLl147x9JbKeDz
         VoSg==
X-Gm-Message-State: AOAM532kep2YVY0yt5QMAAbASt4c2KXWEaKEjNsEZe45pTRxIWq3ryT6
        hA32dVW0SRY9/eJ6Lz9Cjcd72PblwoB5E1HySllJ3jlM+lalEe9lY+0CDQgWVFjfeIFGJidHnKb
        02cCBvPuJ4LdNlAwcKH1S
X-Received: by 2002:a17:906:5e4d:: with SMTP id b13mr4155068eju.271.1644158097380;
        Sun, 06 Feb 2022 06:34:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0oHNNtzVmCFZOWlDJpP0DSA/8ie8X2TT1i2q/7Nl+3B7iVDpovx2H353TqPRVdkUJpNccoA==
X-Received: by 2002:a17:906:5e4d:: with SMTP id b13mr4155063eju.271.1644158097167;
        Sun, 06 Feb 2022 06:34:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b6sm2681551ejb.80.2022.02.06.06.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 06:34:56 -0800 (PST)
Message-ID: <4b9d7ddc-9e91-5fbf-da2a-f2bd4b52beec@redhat.com>
Date:   Sun, 6 Feb 2022 15:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] PCI:pciehp: Replace request_threaded_irq with
 devm_request_threaded_irq
Content-Language: en-US
To:     lizhe <sensor1010@163.com>, bhelgaas@google.com, lukas@wunner.de,
        ameynarkhede03@gmail.com, naveennaidu479@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220206140705.10705-1-sensor1010@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220206140705.10705-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lihze,

On 2/6/22 15:07, lizhe wrote:
> Memory allocated with this function is automatically
> freed on driver detach
> 
> Signed-off-by: lizhe <sensor1010@163.com>

You must use your real name (first-name + last-name) as author,
as well as in the Signed-off-by line, see:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1c1ebf3dad43..aca59c6fdcbc 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -66,7 +66,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
>  	}
>  
>  	/* Installs the interrupt handler */
> -	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> +	retval = devm_request_threaded_irq(irq, pciehp_isr, pciehp_ist,
>  				      IRQF_SHARED, "pciehp", ctrl);
>  	if (retval)
>  		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
> @@ -78,8 +78,6 @@ static inline void pciehp_free_irq(struct controller *ctrl)
>  {
>  	if (pciehp_poll_mode)
>  		kthread_stop(ctrl->poll_thread);
> -	else
> -		free_irq(ctrl->pcie->irq, ctrl);
>  }
>  
>  static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> 

You cannot just go and change a single allocation into a devm managed
resource, esp. not a request_irq call.

Changing this into a devm_allocation means that the irq now will not be
free-ed until after pciehp_remove() has completed and that function calls:
pciehp_release_ctrl(ctrl); which releases the memory the ctrl pointer points
to and that same memory / pointer is used by pciehp_isr.

So after your patch it is possible for the IRQ to trigger after
pciehp_release_ctrl(ctrl) has free-ed the memory (and before the devm
framework calls free_irq() disabling the IRQ), causing pciehp_isr
to reference free-ed memory, leading to a crash.

Since this patch introduces a bug we cannot accept it, nack.

Regards,

Hans





