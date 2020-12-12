Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84D2D89A5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439861AbgLLTUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLLTUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2020 14:20:07 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3DC0613D6;
        Sat, 12 Dec 2020 11:19:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id x16so17023817ejj.7;
        Sat, 12 Dec 2020 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2NV+t4SUDYEyMQJANM60zUoBpZh63OILDleNEu2fXI=;
        b=fhvegS1QaH8XhDW5DTWb3rQhFUmHVyAXQ4wmo61vch/n8hpb58mGVczeLqzKusX+2o
         9X3zx2+8HB+DJ/AEZAbTqZVdLbHn5YdLbiN0TJ+vVQgJyovKeM0+4Y2GW2nSe3elBV78
         fxssFAxHT/f6FcR7RxgdD5jeLHBe8RPGWRePpjWU4BgfN2mZ95+9UwmjSpP6WXY5a6hG
         BFDWc3hSI/kwE+9YuvMrSRsf+7B5ZTiFI1tA9/FskF0+ms4ci8ZXZwroyVmi4ntevvTu
         pJDCacbE278pvKxkji36IEa6Om32OJ22Y/YLV1YS0SFuN6ANZSyIzc4ktxw9L4to9evz
         PS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2NV+t4SUDYEyMQJANM60zUoBpZh63OILDleNEu2fXI=;
        b=lBIDsTx88cO0HMLECMW+BmTw9sfph1IY4KWp2qq7b/CG0KIVt+9GU7IrzHKJYh0MT1
         h9ilEsZLBWZz50wfHDIhQlzaV982HKEy55viCto1SUMRCXa9WqEWuQe8jizMqTb0RgCN
         hMgK8I4gthq3uqnlp1XkQZAUb/ASqnmFymBNvt/ehT09W21iBX/QIbxjDNnfXJqvJiEo
         QPTXW38/DPvwSSxZj2zlB2anrJoY4+seBw/jYUZIlQv/qdyD5CXMqIZAfa/GbiwcDRAq
         9iV64SKG0lt/sn6PmIWN2cW5cSwWsW1crxTj0oBdrNloJ+pfSaZkg94JgOaqJYif7dL0
         kUKg==
X-Gm-Message-State: AOAM533C2B8mmSQhN8k9yc5QTlF7CcVzka/9cxMn7Wf4sM5BMkO3E/ng
        UWFpEwWHjeQOlssfVgxdcM2hqvjqKpL9Og==
X-Google-Smtp-Source: ABdhPJz9WQ8tSKMNQh7Ect/KoAjZEr2HmqORhV8q+vBMPqt16mKlBkR4TwVAuSgmP/DaStaBmYNvXw==
X-Received: by 2002:a17:907:2116:: with SMTP id qn22mr16273138ejb.483.1607800766246;
        Sat, 12 Dec 2020 11:19:26 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id cf17sm10738211edb.16.2020.12.12.11.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 11:19:25 -0800 (PST)
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201016120431.7062-1-marek.vasut@gmail.com>
 <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <83135f6f-8a98-4537-0df5-91a06af07955@gmail.com>
Date:   Sat, 12 Dec 2020 20:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/20 7:11 PM, Lorenzo Pieralisi wrote:

[...]

>> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
>> index 1194d5f3341b..ac5c7d7573a6 100644
>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>>   	}
>>   
>>   	/* setup MSI data target */
>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
> 
> This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).

How come? I would expect GFP_DMA32 allocates a buffer below 4 GiB in any 
case.

[...]
