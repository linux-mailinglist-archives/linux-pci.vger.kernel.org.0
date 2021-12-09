Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1696646F469
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 20:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhLIUAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:00:09 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36535 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhLIUAJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:00:09 -0500
Received: by mail-ed1-f50.google.com with SMTP id z5so23622686edd.3;
        Thu, 09 Dec 2021 11:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=etVnRI6ZRHhBn4vB+MwW8/5VjsopR6YxRFheLhtUulE=;
        b=rx8sEQSGmhLEXq7U1haWFGFGbRviv2mePtqBpwpxnc9ofRHf72BC19WgjNTjsgT/nQ
         mMaVgNq/Ia7r9Db55/Lkk5d0OHb+VvczV1ipRkw7BHE/m1kmcumhCozz4G79MqDgXdU7
         gbf+gS8awy+A1YI3n76eI1XZnJi5CFYJWs5l2SK1UnK5smdhM5HzceNJJ5kSZUQOVlRk
         KHuoNKInlCzxZ4AYddGSRBdeKnp1rjr0WL2zlmvXQ/iK9NyhjT7DqKX0WJ1ZlI/wGu2R
         kcLU7JBeU9UE8AufK0a2CTFjYuQjfD9SIcxHFxdH7/hQYYVXHXi+QLY1uQnMIZvtzJ5l
         AUzw==
X-Gm-Message-State: AOAM533HnmsvX2+gVuWxCbrR3XLBQ45+ceLMPaD6/GASOMhrO3xADGGf
        PPv4dH8fqbMANeMMlKXIYY8=
X-Google-Smtp-Source: ABdhPJzkU3GY1APpFd1hqtKX1f89fzY/ya9eRGM6yiQSw69ygD1FdTdhD6X79jZr8NvCTdylR2yDFQ==
X-Received: by 2002:a17:907:9152:: with SMTP id l18mr18672468ejs.382.1639079794155;
        Thu, 09 Dec 2021 11:56:34 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id cw5sm421279ejc.74.2021.12.09.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:56:33 -0800 (PST)
Date:   Thu, 9 Dec 2021 20:56:32 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] pci_ids: Keep Intel PCI IDs sorted by value
Message-ID: <YbJfcClu5FVH4Kwz@rocinante>
References: <20211209195231.2785-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209195231.2785-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

> Keep Intel PCI IDs sorted by value.

OK! :-)

I don't mind, and I hope that Bjorn does not mind either!  Some spring
cleaning and such.

>  include/linux/pci_ids.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 86678588d191..306201cb9aff 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2738,12 +2738,6 @@
>  #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
>  #define PCI_DEVICE_ID_INTEL_82801EB_12	0x24dc
>  #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
> -#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
> -#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
> -#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
> -#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
> -#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
> -#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
>  #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
>  #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
>  #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
> @@ -2758,14 +2752,15 @@
>  #define PCI_DEVICE_ID_INTEL_82915G_IG	0x2582
>  #define PCI_DEVICE_ID_INTEL_82915GM_HB	0x2590
>  #define PCI_DEVICE_ID_INTEL_82915GM_IG	0x2592
> +#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
> +#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
> +#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
> +#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
> +#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
> +#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
>  #define PCI_DEVICE_ID_INTEL_5000_ERR	0x25F0
>  #define PCI_DEVICE_ID_INTEL_5000_FBD0	0x25F5
>  #define PCI_DEVICE_ID_INTEL_5000_FBD1	0x25F6
> -#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
> -#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
> -#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
> -#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
> -#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
>  #define PCI_DEVICE_ID_INTEL_ICH6_0	0x2640
>  #define PCI_DEVICE_ID_INTEL_ICH6_1	0x2641
>  #define PCI_DEVICE_ID_INTEL_ICH6_2	0x2642
> @@ -2777,6 +2772,11 @@
>  #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
>  #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
>  #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
> +#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
> +#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
> +#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
> +#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
> +#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
>  #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
>  #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
>  #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
> @@ -2941,16 +2941,16 @@
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
> -#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
> -#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
> -#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
> -#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
>  #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
>  #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
> -#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>  #define PCI_DEVICE_ID_INTEL_EP80579_0	0x5031
>  #define PCI_DEVICE_ID_INTEL_EP80579_1	0x5032
> +#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
> +#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
> +#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
> +#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
> +#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
