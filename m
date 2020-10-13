Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2128D3AF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgJMSch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgJMScg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2020 14:32:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9DC0613D0;
        Tue, 13 Oct 2020 11:32:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so1239749ejx.0;
        Tue, 13 Oct 2020 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qc54GK+Ty5pId9hBt15XZ2P9bTDoR5ttEPUTX251CQ=;
        b=UAABpbflE3V4islHYiXlskpNFKwmAB2bCvHYSozZRJfwtQ+c6UvdbWgaA8ke2NzIn2
         0C2nt/K1+E3wfx8Ko1pIDaPs0XbY5ba2Jt51AfFpQSW5VdMQrxo1oQgfkD01qRxgYtOR
         JMmDFbYJZrsx9BeocMBmrZiPpxqFffnZ+x6VeTKkPz9SXHh8rsExsz6KHjvJJwIj9jjS
         LVmWg56Z76RK/S0JpiDGeyHZdOLNs8LcfBlHQv20PIzvqvKRpJIUsVaW3QFgVtwnFHK4
         yUUnKVoCxWAMZfjodQLQ1DbQVb0pTO1c25II/Is4h6CJBh/6wyEvwgvxOBTWEUF+AlT/
         UCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qc54GK+Ty5pId9hBt15XZ2P9bTDoR5ttEPUTX251CQ=;
        b=tpdp5ZCPlAnyAmtjYUzF26oKXLk39EEfQc3Vb9ACkELPM9WY9d8Jdpk+auE62Y7E1E
         2MmVBAfXa+8BlgvcWb5iQJGGgWpLBA8wBUiKYRB5sQM+1inBMn+tqG1dZbqitTrmBKD9
         CBpGuMILi3tl76g2gQzjmG58HfLfPAnBvZQ11P4m1mmsxAGO05/xyXp7eqDBlUrJEY5i
         pPk64KVIFdTDJJkXtgaYOjhGFmzeUjmbmpMVi4FjGBpoKXwyohnG3ZNr5itCY1rnPZWq
         s7YY6nF7LtRQhwJ+2b252YEDAiX3qP+Ro1bGYYogl18rJpLdploKjlnG7ykc1SSy8mRz
         62Mg==
X-Gm-Message-State: AOAM532VEgKAoDlxqYCalGYUo8FkitY6Dk6NkrVU87udvCntyzcR1qRe
        lhXlsU1bbc0sZPGBaFG1/kjyuVihlG/vRA==
X-Google-Smtp-Source: ABdhPJwVdfPRWEgt1uZEneAkSnVKZVTAG1ExCSv0L+E8yk0E4pr8rHUc6l+lMOJgfh37HN+odm3A1g==
X-Received: by 2002:a17:906:a119:: with SMTP id t25mr1174067ejy.67.1602613954792;
        Tue, 13 Oct 2020 11:32:34 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id b8sm295815edv.20.2020.10.13.11.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 11:32:33 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add L1 link state fix into data abort hook
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20201011160045.574323-1-marek.vasut@gmail.com>
 <CAMuHMdU0xF3rMNMqn54cF7eOS8JuHDh9WFNTJi5ftq4ypHBeHg@mail.gmail.com>
Message-ID: <82915d16-e873-be7e-d04f-0eba60b71f70@gmail.com>
Date:   Tue, 13 Oct 2020 20:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU0xF3rMNMqn54cF7eOS8JuHDh9WFNTJi5ftq4ypHBeHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/20 9:18 AM, Geert Uytterhoeven wrote:

[...]

>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
> 
>> @@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
>>         },
>>         .probe = rcar_pcie_probe,
>>  };
>> +
>> +#ifdef CONFIG_ARM
>> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>> +               unsigned int fsr, struct pt_regs *regs)
>> +{
>> +       u32 pmsr;
>> +
>> +       if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
>> +               return 1;
>> +
>> +       pmsr = readl(pcie_base + PMSR);
>> +
>> +       /*
>> +        * Test if the PCIe controller received PM_ENTER_L1 DLLP and
>> +        * the PCIe controller is not in L1 link state. If true, apply
>> +        * fix, which will put the controller into L1 link state, from
>> +        * which it can return to L0s/L0 on its own.
>> +        */
>> +       if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
>> +               writel(L1IATN, pcie_base + PMCTLR);
>> +               while (!(readl(pcie_base + PMSR) & L1FAEG))
>> +                       ;
>> +               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
>> +               return 0;
>> +       }
>> +
>> +       return 1;
>> +}
>> +
>> +static const struct of_device_id rcar_pcie_abort_handler_of_match[] = {
> 
> __initconst (if you intend to keep this, see below).

I do, see below.

>> +       { .compatible = "renesas,pcie-r8a7779" },
>> +       { .compatible = "renesas,pcie-r8a7790" },
>> +       { .compatible = "renesas,pcie-r8a7791" },
>> +       { .compatible = "renesas,pcie-rcar-gen2" },
>> +       {},
>> +};
>> +
>> +static int __init rcar_pcie_init(void)
>> +{
>> +       if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> 
> I guess it doesn't really hurt to use the existing rcar_pcie_of_match[]
> instead? It just contains two additional entries, which will never match
> in the CONFIG_ARM=y case.

Unless you try to build 32bit kernel for the R-Car3, like they do e.g.
for RPi3. So I would prefer to keep this to handle that case too.

[...]
