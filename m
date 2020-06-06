Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A041F0673
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFFMPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Jun 2020 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFMPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Jun 2020 08:15:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD24C03E96A;
        Sat,  6 Jun 2020 05:15:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a25so13066297ejg.5;
        Sat, 06 Jun 2020 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZtcKYlep3zGwZP2ydpQQPrqzGdx2imA3C3m2OlS+gPg=;
        b=Kzo1kJDpDVQy8T2P6QhgUA6LkwykYiOgRxa7RdR+qylzG+j5c6nm0a2BxJivFPfdS4
         8iYQpiZXlqaSWwTDz1w+CZGzNrFWZrTMfwvr1+V1+orsrIC3NS6z+4IWBKHSvbCS7lFM
         8PvJYbBW3osXJYR5XQhLq+Bj6L/NM0hatqLbdmYJr88YjEXZb97d4Efem1aArxDiANIK
         u8rQAm/EnMaYTqtJ1dkYJkdOzCoCeyDU+DxrNDzl3Z8+3Apu/WnKAueyN29pUbHlscfT
         pdKBzPfzMdVotRN3wanNEqd5jpjsvbwL7mkp5VcswjsVxpuh31n/t3/j9rVaaqS6WH/e
         Lb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtcKYlep3zGwZP2ydpQQPrqzGdx2imA3C3m2OlS+gPg=;
        b=Ua3TtP/qaeP/FKEenOwk/AdurAVC4hAm0efVM6gGsyFP5o15f0tSf6/KtT6oYpGZLO
         LQrLkv900TXs9kDdjUHz/QwGxh8tKDFM00xYFrgLAhdHrfocLH6PSUcf7QF7OdLZIkB9
         dbEsuczzUsg13Kkhw1pxQk4Q4My6lO2qwLF7yrApbCdre+h42lVojyy1yrWtPdJX+8fa
         JNHXn5X6MZ4TQxPtoRtODUAvdU+NQxM9SnWEka1vInS4AgLDYs4Eyorxg7ZeORJMsV2f
         mDrrXnOJ7T0CzctIFUGpxvC7ybgTwyQttLe+1n2Xtf7yhlZkoUWsTy95hdJRiAW53lne
         0NaQ==
X-Gm-Message-State: AOAM5307I5bbe3hGHP//vdLNtOVi4NYqgMBGiWmdpH3ZDESOZqJ2Tz+l
        lPhNxA5s8SGO1AYI4xLssi05Zfc5
X-Google-Smtp-Source: ABdhPJzeIZy7InkYKT4eh2nr0qbd56/PWSHQBM0Jk4Dt1kjFFpxKmJrEJT2EvGaJOYiT/6tfoNepdw==
X-Received: by 2002:a17:906:7083:: with SMTP id b3mr12589707ejk.57.1591445729806;
        Sat, 06 Jun 2020 05:15:29 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id qp15sm6297508ejb.69.2020.06.06.05.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 05:15:29 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: fix runtime pm imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200520082228.26881-1-dinghao.liu@zju.edu.cn>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5cf73d31-33ab-b9ba-c9d5-faa3977484eb@gmail.com>
Date:   Sat, 6 Jun 2020 14:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520082228.26881-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/20/20 10:22 AM, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Sorry for the late reply.

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/pcie-rcar.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 759c6542c5c8..a9de65438051 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1207,9 +1207,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	irq_dispose_mapping(pcie->msi.irq1);
>  
>  err_pm_put:

You might want to remove this label too.
I'm not runtime-pm expert to comment on the validity of this patch though.

> -	pm_runtime_put(dev);
> -
>  err_pm_disable:
> +	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	pci_free_resource_list(&pcie->resources);
>  
> 
