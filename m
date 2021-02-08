Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DB31373F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBHPWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 10:22:22 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53560 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhBHPP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 10:15:59 -0500
Received: by mail-wm1-f46.google.com with SMTP id j11so12916957wmi.3;
        Mon, 08 Feb 2021 07:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xsTtximJORmbGu92bYawlwbCWEmDlVyOMVFnk9uz3xg=;
        b=iqMwM3ZHxW2NrYXfbnmPETC8mIIp7pjALl6Z8GuHn7suHQ4R8iRH7gDdIf8fHmmTYW
         D/0/kmz5WfYbwgMnqU4qD8lX0/m85ZnzrQBV9GOzX4dZWDAHpEfdTSHOnof/SJTuexaY
         dc5iSpRAKAzEBy2EbnhuqRLRjheIeIUROAhx5hmUzc+fYshw51og09A33wr2gbxjtJgA
         bfDQMK9CHOmzyadfqez8jO885cMo4Bwe7659nLi2/5krgSMoQzpWqXGDA+JOOOWHhMQH
         xW4U1N0ckKJNdSKlBdHqpM1Pk04OOVl/domOHTqqU6pFlzFFvYS6eOpBmBP51wWn+Qsq
         bEOw==
X-Gm-Message-State: AOAM533zm368T6wQILmrDVjaHYKgvk3qIx98dQaNmwr6GGk2JJetrF/V
        3ZD7RTgnXDfboXwH8J9yJ80=
X-Google-Smtp-Source: ABdhPJwSlYUCF1mOXmi/BAJmaTj1pe9z7KuxZRZ9lAf5aAD9OGnFuC4oOmeRFP8yg2PE/EYo3o6JDA==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr15125878wmk.41.1612797311442;
        Mon, 08 Feb 2021 07:15:11 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w15sm28324738wrp.15.2021.02.08.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 07:15:10 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:15:09 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <mhu@silicom.dk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PCI: Add Silicom Denmark vendor ID
Message-ID: <YCFVfc7HUuP7cn5F@rocinante>
References: <20210208150158.2877414-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208150158.2877414-1-mhu@silicom.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Thank you!

> Update pci_ids.h with the vendor ID for Silicom Denmark. The define is
> going to be referenced in driver(s) for FPGA accelerated smart NICs.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
> 
> Changes since v1:
>  * Align commit message/shortlog with similar changes to pci_ids.h
> 
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f968fcda338e..c119f0eb41b6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2589,6 +2589,8 @@
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36
>  
> +#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
> +
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
>  
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
> -- 
> 2.29.2

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
