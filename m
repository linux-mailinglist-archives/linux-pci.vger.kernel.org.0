Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8583298267
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 16:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414641AbgJYPvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgJYPvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 11:51:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60584C0613CE;
        Sun, 25 Oct 2020 08:51:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w25so6890236edx.2;
        Sun, 25 Oct 2020 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ENM8NUlE+VbmDvxGv+dxsLS9+OxbsabhFcC8lexS+kg=;
        b=fnE9KK2bm1iWLICzjnjJf2DlsTjFVGZOdG7lqDMAzsofkYTSiU7mi5GJQF59rChlg7
         yHySxnocodqpVkhaPV7GYwEk7IHIOCXog1I6sBy47YJYhJZzy7hIVeK6Lcc6tBwy+IgU
         KpMQpXGdGLE/SO18YcJez1cMEEBXmNgR/BKH/4C0aMZABtm8mvkqOd7TGYa6DMdTogL2
         sJMvuWrrHph9U27TT6sgAWes8Yh2XmJ1kD5Uy1CQP9aRE3XZWPwZdbvmj6dnEeFGrlbM
         yLk+b5An1UUN6dFkpu4RrX3VyVgP0YM+KnMMI1o4ehHbb5NXbeGcF/Yvmuoore1iSCsF
         a/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ENM8NUlE+VbmDvxGv+dxsLS9+OxbsabhFcC8lexS+kg=;
        b=BZjsylWK1brJbVKAG77jszChveqIwbXqXYWqPPU4QbIWHcT8M5CUlCzYPEUCqFQ3Aa
         nmGDMLDE/as0RJUEaQ0DhK0bztKIGP0DSvC9G+W32JHaNcMMcRjb36W9EDjNmuj0L8Je
         9ZvTGK2tjmfg2MLly2+PjOJKp8e47PtFvszRma2bWlc/pg6BpzKgZvHCnwjVj7w0A25N
         dHv/isYsKwYw3hUA43DL1hrstI3Rsyr3dJsRwoAyyANfLV95WMhsrZ2mXNu96eNfCrtT
         svexUQo/l474BtzAhyXnRAEtHhEHdxXn94l4el6uF2FYnMrUkLcS85Vind/ew1wngkGI
         5FKg==
X-Gm-Message-State: AOAM532GjfBnSkYrbAcfd3botyDU2fH2dO51VbrRtMHr1CWCuxl62wtg
        PoktSwbcPAuPq1Z4rw2CbPvIMiz1Btk=
X-Google-Smtp-Source: ABdhPJyg4AURQQWoA5ScuhUpZnzNoyasJ3Md0JAcI6Gjkk6KRO7pJedOyZnQV/dozoHLiXNXrnZggg==
X-Received: by 2002:a50:88e5:: with SMTP id d92mr12093424edd.145.1603641104733;
        Sun, 25 Oct 2020 08:51:44 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id p9sm4089326ejo.75.2020.10.25.08.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 08:51:43 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
 <CAMuHMdW3obrfdnt7=oTxrpav2+rXhNhDiJ3fWRP3aF0jZQYNNQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5f056161-8adc-384f-9b60-842d9d7a3e8f@gmail.com>
Date:   Sun, 25 Oct 2020 16:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW3obrfdnt7=oTxrpav2+rXhNhDiJ3fWRP3aF0jZQYNNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/20 9:47 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

[...]

>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>>         }
>>
>>         /* setup MSI data target */
>> -       msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> +       msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
> 
> BTW, can this fail, especially now this is allocated from a more
> limited pool?

I am pretty sure this can fail on systems that don't have DRAM below 4
GiB , but that is never the case on any hardware with this controller.

[...]
