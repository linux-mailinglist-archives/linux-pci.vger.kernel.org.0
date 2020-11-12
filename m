Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC32B08B1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgKLPoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKLPoj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:44:39 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A13C0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 07:44:39 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so2963387pll.13
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7xcwdTxVm41d4gjbfOf0AH5XJu51BlKtxTRP7hoXHew=;
        b=UQSFnAfI5Le4bZ0HbYhiCfcI7fNewKFQTE1IQMpz/+EVUEVDerdkqfFG10mxyFhyGk
         JVT+7RUa9SGsbgw9gIucfsBPGRmFlaA3vWpm0EJhF89gPe1b2JZQvhq93MrAn5ZT5ocm
         BPIX7grcZYyRK6eUd7KRxkgPCy7OGSu5z2bFVvlGuM+DJdbP7JwXw20yih89LaQMzO9c
         vb0mMvgzv9usAfqZABsnanqrcy6qTPi39F99b/STbSqnBwZ392Ab1EF4H1aMicOf5Y+C
         56bOWCpDEd38n7VrhKsSWLctuMA2ap4ydpzE7Taxa/AsOtix2peijSHXi9G+wAoVY+GT
         l3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xcwdTxVm41d4gjbfOf0AH5XJu51BlKtxTRP7hoXHew=;
        b=R+msxDj1kKytoBQD1DFxB25p6KrzhJyVmIlDIRCDBeolL2i+FI8TIdUzodA5tL2guc
         iM5IEMybzJ8eiGguCElh1Lxca0S5+WMmJQPBm5kagIoh8NLdEeoySURhwKJV5cC/gUiJ
         wUa69D3bGeP/dc2EeRu9IrkDfi6AZzXy3W1oQh2d5ErrzzcO5IKIxDWFZB2ZfY6gkIlZ
         sdBpZQesN05f2XTGP4jKDZZz5tHTz4Cj3BdH1gG7vvlrw+W90jyMSRohkNoD8c5qSWoS
         SDFHVgjxVQrjBFVY49agldBO65vWt/QswVMXe8RFTAL5rkkmem0B1rPTZILRivFSK6WW
         Qnkw==
X-Gm-Message-State: AOAM532jM6F2bju3FYCdZE7N4N9D4ZlegMQQiEBsKvgWyWFGUtZhs58l
        HYPj+XF1/hXJtlJ/5XGW5u8=
X-Google-Smtp-Source: ABdhPJy2kPH5oad8/5nbULnrao0JRrnZN0WXDAOSc8Xs7L3DjikXy29I4bPxFbvs9SmoPr1ese+4tA==
X-Received: by 2002:a17:902:fe18:b029:d6:991c:6379 with SMTP id g24-20020a170902fe18b02900d6991c6379mr305847plj.20.1605195878767;
        Thu, 12 Nov 2020 07:44:38 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id r2sm6818771pji.55.2020.11.12.07.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:44:37 -0800 (PST)
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
To:     Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Jim Quinlan <james.quinlan@broadcom.com>
References: <20201112131400.3775119-1-phil@raspberrypi.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com>
Date:   Thu, 12 Nov 2020 07:44:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201112131400.3775119-1-phil@raspberrypi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+JimQ,

On 11/12/2020 5:14 AM, Phil Elwell wrote:
> Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> replaced a single reset function with a pointer to one of two
> implementations, but also removed the call asserting the reset
> at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> used for USB booting but then need to be reset so that the kernel
> can reconfigure them. The lack of a reset causes the firmware's loading
> of the EEPROM image to RAM to fail, breaking USB for the kernel.
> 
> Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>

This does indeed seem to have been lost during that commit, I will let
JimQ comment on whether this was intentional or not. Please make sure
you copy him, always, he wrote the driver after all.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index bea86899bd5d..a90d6f69c5a1 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -869,6 +869,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> +	pcie->perst_set(pcie, 1);
> +
>  	usleep_range(100, 200);
>  
>  	/* Take the bridge out of reset */
> 

-- 
Florian
