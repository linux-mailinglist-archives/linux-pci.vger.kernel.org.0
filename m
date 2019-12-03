Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81290111B60
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 23:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfLCWJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 17:09:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCWJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 17:09:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so2513905pfe.10
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 14:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSBIYOscptZnYWaI4AeOjEh64oDv5ru63qkreKiXvlY=;
        b=geuMiRjARcxU+pIzzuOeH6lx6cneFVRMrKbm5tRMvY3hwxiwCgtP/MLufBqpU4RJ7h
         3UO8ZYfwl1j2qXpO4wsmCZlyRB/63Co3z+e4AVTFnaN3wUIXNoU58uL87/FjdMvz5C9t
         dSKy47buYSGEPK+Do9zawbCYg+AbEQpnBDPBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSBIYOscptZnYWaI4AeOjEh64oDv5ru63qkreKiXvlY=;
        b=khfYJEZU5teCPL51A6k2tcxPfMlt0Emx4c7a1Pcx57xeFzSpVkZ1A4nH4PNNUjRt03
         fCGADz+xIw72HoEg9vy1CW++8Yg3Rq3ULigurnF78GF3eWwvqArTFNF1mSPf/y0/zVUS
         dlGLgmYA1HFYiYwnTiuaG63hwE+Q8pM+MZ3oWui6VZWOD/QTHFd5E5jpy3FN9IoG7kLx
         uGNvsbYcVH5iQYvw+GTiQVRpVzSjup8ejFWf1goWbNrUtLfOJueI2Q2vtZaGruXLfqB+
         OlE7zLNwH0LE5pILAmIJOVoeW/gB2lVXNEjxFwsvWAoeAFSTCyxiMx6YPgcBl7QHw6Hq
         xTpw==
X-Gm-Message-State: APjAAAUWhz5wDXkUYGYks+EEzQriR+zTcdtugAEGyh/BdeHRL867ic89
        2aN4PBFzGXfguJ2OJUfVZHsoIg==
X-Google-Smtp-Source: APXvYqylfTPPGwnkmI3aoo7y5yzJGuEDLuZJ1o057PLvAd+XFAn29jSN6QkIzubcCN2MEgWSyp95Dg==
X-Received: by 2002:a63:6704:: with SMTP id b4mr8002284pgc.424.1575410973842;
        Tue, 03 Dec 2019 14:09:33 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k12sm4471207pgm.65.2019.12.03.14.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 14:09:33 -0800 (PST)
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com>
 <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
 <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <40fffa66-4b06-a851-84c2-4de36d5c6777@broadcom.com>
Date:   Tue, 3 Dec 2019 14:09:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/3/19 11:27 AM, Andy Shevchenko wrote:
> On Tue, Dec 3, 2019 at 5:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
>> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:
> 
>>> +     /* go through INTx A, B, C, D until all interrupts are handled */
>>> +     do {
>>> +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
>>
>> By performing this read once and outside of the do/while loop you may improve
>> performance. I wonder how probable it is to get another INTx whilst handling
>> one?
> 
> May I ask how it can be improved?
> One read will be needed any way, and so does this code.
> 

I guess the current code will cause the IPROC_PCIE_INTX_CSR register to 
be read TWICE, if it's ever set to start with.

But then if we do it outside of the while loop, if we ever receive an 
interrupt while servicing one, the interrupt will still need to be 
serviced, and in this case, it will cause additional context switch 
overhead by going out and back in the interrupt context.

My take is that it's probably more ideal to leave this portion of code 
as it is.

>>> +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
>>> +                     virq = irq_find_mapping(pcie->irq_domain, bit);
>>> +                     if (virq)
>>> +                             generic_handle_irq(virq);
>>> +                     else
>>> +                             dev_err(dev, "unexpected INTx%u\n", bit);
>>> +             }
>>> +     } while ((status & SYS_RC_INTX_MASK) != 0);
> 
