Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07521092F0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKYRjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 12:39:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39123 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 12:39:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so16089127wrt.6
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TV4TtQY54yx5GhkPUxvlJqPnJhK7lHKBPk0JvM1tXs8=;
        b=HoWFt4lGKBDIUjs6oMT2yCWq831dBO3a1HRnlnp7KyIgja04A+Ra0JpK+t36XeQ9Pg
         VOHvtI2uTUDpbFDN/Yy4GQCliUMLBI9rsw1vxAfdRh1gQjdj2dTQqFl5FVqbmTEgb3qu
         NiQfU4eH87xIOwYnYTnTUZFZzIlhhZEtUKT8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TV4TtQY54yx5GhkPUxvlJqPnJhK7lHKBPk0JvM1tXs8=;
        b=nRG6ECndStsRMOhkvbVdKJ/RAYM9hKf91euBPBVnmcqpDbcLaXgxEwr32XXZwfCl7q
         5KgcoAJKYPgNXD5nZ1UpC8zcmlviLj5FTD43EZQ4mUk6ArOnsjqiZHxNzba9TPwNa8g9
         aE3VogeuFJAQ8DbvUd7FtHOnpagTZV7opE906BwxdQsDK7sbKTGEN1SpuV/yLpb0RKQi
         SmUomJyZETTwn8yEUJ4o205sDjPwLERUBkMbXojh7fnPT9gadyDeln7cYUVMHkdV8T25
         N5eL9OYESRD3g2MVMviG3Cd4eS66zTm40dvwVtF+KKyysorX/I93RaExuoqXCEriM0c6
         IXrA==
X-Gm-Message-State: APjAAAXHKklSeND+UkRbUE0O3J+DV9C+X+eQMxnD9qt0NVO0R6uZD1D/
        LgkIhPayR6Sd/EbZXGpWTmEUjg==
X-Google-Smtp-Source: APXvYqxAkenLagCyIFfPPRtA8QkC3dbYCutjToI+p46ubKx8p7u8DtoXQtR45jIRHd5HzEauxGFYCg==
X-Received: by 2002:a05:6000:354:: with SMTP id e20mr18291923wre.17.1574703545172;
        Mon, 25 Nov 2019 09:39:05 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c1sm10990040wrs.24.2019.11.25.09.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 09:39:04 -0800 (PST)
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, rjui@broadcom.com
References: <20191115135842.119621-1-wei.liu@kernel.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <f88847fa-07be-264a-5408-7df362f2fb03@broadcom.com>
Date:   Mon, 25 Nov 2019 09:39:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115135842.119621-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wei,

On 11/15/19 5:58 AM, Wei Liu wrote:
> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> in.  Removing the ifdef will allow us to build the driver as a module.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Alternatively, we can change the condition to:
> 
>    #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
> .
> 
> I chose to remove the ifdef because that's what other quirks looked like
> in this file.
> ---
>   drivers/pci/quirks.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..cd0e7c18e717 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>   			 PCI_DEVICE_ID_TIGON3_5719,
>   			 quirk_brcm_5719_limit_mrrs);
>   
> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>   static void quirk_paxc_bridge(struct pci_dev *pdev)
>   {
>   	/*
> @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> -#endif
>   
>   /*
>    * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
> 

The change looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
