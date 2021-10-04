Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A59421927
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhJDVYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJDVYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 17:24:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDCEC061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 14:22:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e144so21986733iof.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MuilptXu/lrbHdYIjm49Orq1L38EfLHYhkCQZMQN58Y=;
        b=YxVu7riC7j4LVz42GKgYXGTFCKJqdQPDoBbNgq6DmDMCPYIgq7r0JSZLEMwRUv3grr
         cdiedFdp4r+iNBBN/mXe7pWqYYu2JUV8jVVKsIYViY6+g5jaCREmtkDy07NScmLqvK+S
         JgdZ4x2qrsy/bvSg3+wlyjybySzvvSnkRl7J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MuilptXu/lrbHdYIjm49Orq1L38EfLHYhkCQZMQN58Y=;
        b=5H8nhwJWF3niuXamAJKSbZ9aPSB1OuPGc2XOgJxDMyZ1g2wOG4SY1ngofUIolC9RHJ
         lGWLK/ZNaIDCsvCClK9ZypiwJjk6m2v+K3lGCuFZoXNTq+jlGEkNQBCEGLsB3rUoSbvk
         ZOmFvs0kz93+xSIkvMdPm8aYIFK5diYcAAFQUVReDIdXQJkR/Dtc9SgKlD6IyGWxDr6l
         n+VdkK1TbUm3yedeLb5U4BpgKuKNFLVQU0QNhnJ/g/FM9YY6F1aog4H5vQS96p4gQqKn
         62OfpSZBjMNVKCR9Yrlt5LzAb4B09ZiGFvrG5gS62uZkdlOzglJr2fUeZSxn5cSGVn5F
         Fvig==
X-Gm-Message-State: AOAM531PlDitSiVRTx53vlIzDBGGcdPyAe0fjyeSwMp4LLUR6Ad9iM9y
        3kZqmtxkOjXOmDph47e0s/xvzxSZeoaM1g==
X-Google-Smtp-Source: ABdhPJx1RzTfEn170/4xRIBn0Qw7X57+hgrKnGZ4qAFynZArJaATjwdrmMQXQOmPcAV4ahbaG9Xzng==
X-Received: by 2002:a5e:a916:: with SMTP id c22mr10780139iod.211.1633382546674;
        Mon, 04 Oct 2021 14:22:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v63sm9635481ioe.17.2021.10.04.14.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 14:22:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] PCI/AER: Remove ID from aer_agent_string[]
To:     Naveen Naidu <naveennaidu479@gmail.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
 <b4c5a5005d4549420cf6e86f31a01d3fb2876731.1633357368.git.naveennaidu479@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a51d90cb-2ffb-8d4e-6097-54d03e6ef693@linuxfoundation.org>
Date:   Mon, 4 Oct 2021 15:22:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b4c5a5005d4549420cf6e86f31a01d3fb2876731.1633357368.git.naveennaidu479@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/4/21 8:29 AM, Naveen Naidu wrote:
> Before 010caed4ccb6 ("PCI/AER: Decode Error Source RequesterID")
> the AER error logs looked like:
> 
>    pcieport 0000:00:03.0: AER: Corrected error received: id=0018
>    pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=0018 (Receiver ID)
>    pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
>    pcieport 0000:00:03.0:    [ 6] BadTLP
> 
> In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
> the "id" field was removed from the AER error logs, so currently AER
> logs look like:
> 
>    pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
>    pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
>    pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
>    pcieport 0000:00:03.0:    [ 6] BadTLP
> 
> The second line in the above logs prints "(Receiver ID)", even when
> there is no "id" in the log line. This is confusing.
> 

Starting your commit log to say that message are confusing and then talk
about why will make it easier to understand why the change is needed.

> Remove the "ID" from the aer_agent_string[]. The error logs will
> look as follows (Sample from dummy error injected by aer-inject):
> 
>    pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
>    pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
>    pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
>    pcieport 0000:00:03.0:    [ 6] BadTLP
> 

It is good to see before and after messages. However, it will be helpful
to know why this change is necessary. It isn't very clear why in this
commit log.

> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>

Extra signed-off-by?

> ---
>   drivers/pci/pcie/aer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9784fdcf3006..241ff361b43c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -516,10 +516,10 @@ static const char *aer_uncorrectable_error_string[] = {
>   };
>   
>   static const char *aer_agent_string[] = {
> -	"Receiver ID",
> -	"Requester ID",
> -	"Completer ID",
> -	"Transmitter ID"
> +	"Receiver",
> +	"Requester",
> +	"Completer",
> +	"Transmitter"
>   };
>   
>   #define aer_stats_dev_attr(name, stats_array, strings_array,		\
> @@ -703,7 +703,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	const char *level;
>   
>   	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent)\n",
>   			aer_error_severity_string[info->severity]);
>   		goto out;
>   	}
> 

thanks,
-- Shuah
