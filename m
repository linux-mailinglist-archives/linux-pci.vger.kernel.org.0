Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99A346586E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhLAVlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhLAVlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:41:08 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA08C061574;
        Wed,  1 Dec 2021 13:37:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id u74so51412146oie.8;
        Wed, 01 Dec 2021 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G2sTZZ3FWNke9r8lAjufreDBdF6RHYfz1xoRcRYM/XA=;
        b=I/DE2EM+AkghqX1vEKQGRiGyrUVIiyr9ggZB2ncbtGLiPGTv+nueAb8J2mYTCKpoVD
         eVfi8ne3VxCCzMYImnxAyM+TlaBfXrmTbPJeb8aV346VFEVX8PsRuYuo4IMZQHqL+5NG
         5XBetpL2Zn9BkwAPQzCCNzL5+56r4oQCJaNRYSRR6vIYCs/6aOZvDhcOhp0yyXfvDCuS
         wsKKawktYfbXqma4bts4orjsmPg7v6X2IaPrX0HA2FDlR7EqdUIgARZaUdWZpqNL+E/s
         p+m2qa2vxXWa0CtDZ91mpKVM5BPQo+62ousSFGNxtCbBEs0MvUAr+UGolk5qtLvlzLP2
         iuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G2sTZZ3FWNke9r8lAjufreDBdF6RHYfz1xoRcRYM/XA=;
        b=bnXDZEXUKM33G63g2K8E/hD8gs2NwE7gGitYiqmZ9GAFmZ8bWaE2zUHOnF9OvDtwc9
         uiUnXbqmk/oPp7a8uaR2Jb15MEXkrolZjcyq0RZyJ/QlW/QG5K8OjVqqk3NDMcLeSpgj
         vMspG69tD8QmxtzVyydoeSumUtJxF+6y7UaqhyJ/tZ50DXQ8nF1S93FAqHn8PT7zupTu
         aaF5jJJ/bTt7wjtTEVCu2Ezb3TDSqUYbUvjXnFbVUF2cdFo/tnbujYliH8X1+DOvdi+h
         WyUvBWihXQOQGldtSWpVPgrJoSBqAPXPxO78GqystFRDxFbJw3UsjpoD/6ue1potRass
         ieJw==
X-Gm-Message-State: AOAM530e67eRA9P+mnBU+PUe3tyKUres6vYYgvVPLtXr3aQ3QO77FS+M
        ASMqHpaah8LBUnk/mmEEgL4x5FKE53Q=
X-Google-Smtp-Source: ABdhPJwGJqXS9w8qNvdZ1Fq75kjcPuBP61skmCLRClCMOdBKhx5D80XocVPs3Uk/dMwfOGB1fiEacQ==
X-Received: by 2002:a05:6808:20e:: with SMTP id l14mr795580oie.119.1638394666100;
        Wed, 01 Dec 2021 13:37:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm346945ooq.36.2021.12.01.13.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:37:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Kconfig: Convert driver into 'bool'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20211201213402.22802-1-sergio.paracuellos@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <753baba9-ba09-a55c-d969-a498a695faa9@roeck-us.net>
Date:   Wed, 1 Dec 2021 13:37:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201213402.22802-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/1/21 1:34 PM, Sergio Paracuellos wrote:
> Driver is not ready yet to be compiled as a module since it depends on some
> MIPS not exported symbols. We have the following current problems:
> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> 
> Temporarily move from 'tristate' to 'bool' after a better solution is ready.

s/after/until/

> 
> Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
> simplify condition.
> 
> Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-and-Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/pci/controller/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 93b141110537..7fc5135ffbbf 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -332,8 +332,8 @@ config PCIE_APPLE
>   	  If unsure, say Y if you have an Apple Silicon system.
>   
>   config PCIE_MT7621
> -	tristate "MediaTek MT7621 PCIe Controller"
> -	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> +	bool "MediaTek MT7621 PCIe Controller"
> +	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
>   	select PHY_MT7621_PCI
>   	default SOC_MT7621
>   	help
> 

