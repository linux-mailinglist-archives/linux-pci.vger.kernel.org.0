Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E4481FD0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhL3TVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Dec 2021 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbhL3TVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Dec 2021 14:21:33 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1BC061574;
        Thu, 30 Dec 2021 11:21:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h15so28650667ljh.12;
        Thu, 30 Dec 2021 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29ZCKi+UYzfbhhlJGwYUn8LArOBBrJMbEQDCucP9wW0=;
        b=oYK77syPVHf9WjJUqDaa/+9viAoEgnBaoIHI1uQSzo0DU7cyoWXv8Asdj1r6GFy4n6
         UPCotKGpU02eUvPmNsFG4drmFRZlq8LPztA8D6BDReSTVnyJVNFn8q7+ZRpHcEI9X4KC
         pB/Fl8iB7mYDsuKRuaZi5d6Ga10am9ikNtDVJMAi39HN35MRVCVa06nFdIcGGg1XVWrG
         BdAEhqlSsVRFdufxzT4DypO3AVaNrvbXMZNfltO2b4zQuLNWNnw0QsmpJ8sY9WKQ6/9k
         tbufgpZgKJdJViikuQ5JA7v/DusFQIY70J/JJ7KcX7G+OKtyzIIRTKOxTwYzLPQxVvz2
         RoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29ZCKi+UYzfbhhlJGwYUn8LArOBBrJMbEQDCucP9wW0=;
        b=aCKIt1relVwsqKYt1qP/T6pe+h/W9fb4K/qQ0HqSmmJiZlzf6PcZqcZgoJPniX0gJ4
         qJbLz7HbjW4TFphQYhHGaZqFecM8RZncd3yjpO1pN9Hujdb6LzCNO0Iwa73tLtpiV+F6
         jWju1mcQdyj0wDTJ5w8jnA1kYUzGqOyH6ENOLWpuhcv5VxcCsg1lsAfd9fowalXOgFlT
         zFOusuF614jCuUrxCLur4j1uALoKdpNY3EAtRajxe9kNQLqtXSGUw5KegwQouyaiLUn9
         WFnaz8EWJ1ZK0PUULE0fRcrf7Sv5+J9lsUtwqp8Fd0nzl3+7u/ILRG9ghtmZQjOS4JUJ
         SCgA==
X-Gm-Message-State: AOAM530lzqHWXHzcgzO8SIUxxvjP5AkSqQy623oF37rm18p+pUsB5R5S
        DlyXnTYxlKgbNtDE4SJBHhDgxmrfkpo=
X-Google-Smtp-Source: ABdhPJzPf/616b1vKZjygFJ9jDrkf1rprCIdL5VRNA9yIBZcjKjShCOpY6FdvEkErC1hZwDxUhPfVA==
X-Received: by 2002:a2e:990:: with SMTP id 138mr26702257ljj.507.1640892090620;
        Thu, 30 Dec 2021 11:21:30 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.215])
        by smtp.gmail.com with ESMTPSA id br31sm2558552lfb.279.2021.12.30.11.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 11:21:30 -0800 (PST)
Subject: Re: [PATCH v3 1/3] PCI: Add device code for AMD FCH SATA Controller
 in AHCI mode
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0df4ec50-b986-6a9b-3908-1cf62b53341b@gmail.com>
Date:   Thu, 30 Dec 2021 22:21:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 12/29/21 7:11 PM, Paul Menzel wrote:

> The ASUS F2A85-M PRO with the fusion controller hub (FCH) AMD A85
> (Hudson D4) has the SATA controller below.
> 
>     $ lspci -s 00:11.0
>     00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7801] (rev 40)
> 
> Add the ID for it, when in AHCI mode.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..fe944b44858a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -602,6 +602,7 @@
>  #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
>  #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
> +#define PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI	0x7801

   We only add device IDs to this file if they are used in 2+ places.

[...]

MBR, Sergey
