Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE7364040
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhDSLLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 07:11:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A10C06174A
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 04:11:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k26so17145931wrc.8
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EW0S0jZqxvlgUUh75p+vjwpXMROXOCE7ObppkDAu6rE=;
        b=vSuO366mew4zwK6K8l1TS5E1MhvoVbr1tYtihRF3ZUVG6hY9aAkfBgH78wUSjNCgns
         kUJsEsfL1373eS0oIxJZddteo44J8fBf/aKKiR8IKEAuo8hjvGjKRtE59mrwyIfJQbP2
         PuNOfsA1WdXsmdcFmvK5kLpEacjR5E5uRHb7oUZivOtWkB+y2pnkYgOHt/9skMGIAPvu
         UBX37ATICH4nMaH3cw8c1uPXVEF+5e0zFlEYYv08jfuIxecwCvQT1Ls1Pj8IVdLO8tqt
         tFkxmSm7AuLUU839vdZfKjjHIIodPZ+GHs9bmdrRyD0htMjEOzGPhp9M0c4pNZLaRcN2
         D2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EW0S0jZqxvlgUUh75p+vjwpXMROXOCE7ObppkDAu6rE=;
        b=JsB9v/JzYeWo/vcynSw31BVMgSsAqNHeq7477aJKxXUBrKSBbNfX6j0W4eX3bNr18g
         UcXbIHtoCN79IVGegDq12Ao0Pm9HV4FoMraWZsflI277d37eJ7EFa8XBcvsU1b4dtB9K
         daPOOIy6FUgcSoNUmafrb3CYf+gn6Wq2NVYcfsh4D1EIJfXyLuQHyvzWbH/99BLH+zDI
         hpEHqiZH9Cn1YWLJu/EPR8FFvqbmfLGJXXhUxE8gluAPCug+lKnS39deLC1Jp3jUHevV
         4LLW7uiGq1O1yZUROMZrSyxGvuXAjuU0eTIJRIozNviE0KE4kDpdVHGvJKuILGfu23pa
         rgIg==
X-Gm-Message-State: AOAM533z2vgNU52iheyvMgepZM56anRZvyFWa6VXuutjJGwak3TfrT7f
        TP83vSNAIz22kYQGuyo0Cekzz4C20+CYDQ==
X-Google-Smtp-Source: ABdhPJwrS5pL6Mpjvnm3+gIWkbhoHjfcP2OaINNqmj4DdFTMYBrCz52TzFKbWaqdWDXrIpq6WXsqDg==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr14056960wrn.311.1618830664682;
        Mon, 19 Apr 2021 04:11:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:cc84:7538:8299:9b35? (p200300ea8f384600cc84753882999b35.dip0.t-ipconnect.de. [2003:ea:8f38:4600:cc84:7538:8299:9b35])
        by smtp.googlemail.com with ESMTPSA id v4sm24370665wrf.36.2021.04.19.04.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:11:04 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helper in pci_vpd_write
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <79d337f4-25d6-9024-2cbd-63801cbd9992@gmail.com>
Message-ID: <f66dc844-0b2e-3508-1c68-2433fe6576ea@gmail.com>
Date:   Mon, 19 Apr 2021 13:10:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <79d337f4-25d6-9024-2cbd-63801cbd9992@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.04.2021 11:19, Heiner Kallweit wrote:
> Use helper get_unaligned_le32() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 60573f27a..2888bb300 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/sched/signal.h>
> +#include <asm/unaligned.h>
>  #include "pci.h"
>  
>  /* VPD access through PCI 2.2+ VPD capability */
> @@ -235,10 +236,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  }
>  
>  static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
> -			     const void *arg)
> +			     const void *buf)
>  {
>  	struct pci_vpd *vpd = dev->vpd;
> -	const u8 *buf = arg;
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> @@ -264,14 +264,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  		goto out;
>  
>  	while (pos < end) {
> -		u32 val;
> -
> -		val = *buf++;
> -		val |= *buf++ << 8;
> -		val |= *buf++ << 16;
> -		val |= *buf++ << 24;
> -
> -		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
> +		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
> +						  get_unaligned_le32(buf));
>  		if (ret < 0)
>  			break;
>  		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
> @@ -286,6 +280,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  			break;
>  
>  		pos += sizeof(u32);
> +		buf += sizeof(u32);
>  	}
>  out:
>  	mutex_unlock(&vpd->lock);
> 

Please disregard this patch. According to PCI 2.2 spec the address needs to be dword-aligned.
I will address this in a separate patch.
