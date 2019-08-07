Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290D384E49
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfHGOJd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 10:09:33 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:61588 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbfHGOJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 10:09:33 -0400
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8BEB719F4C8;
        Wed,  7 Aug 2019 16:09:10 +0200 (CEST)
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after
 platform_get_irq()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mans Rullgard <mans@mansr.com>, Marc Zyngier <maz@kernel.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-32-swboyd@chromium.org>
 <20190730215626.GA151852@google.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <fece42c0-f511-173a-b16a-5b1f3a1c1a4e@free.fr>
Date:   Wed, 7 Aug 2019 16:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730215626.GA151852@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/07/2019 23:56, Bjorn Helgaas wrote:

>> diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
>> index 21a208da3f59..b87aa9041480 100644
>> --- a/drivers/pci/controller/pcie-tango.c
>> +++ b/drivers/pci/controller/pcie-tango.c
>> @@ -273,10 +273,8 @@ static int tango_pcie_probe(struct platform_device *pdev)
>>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
>>  
>>  	virq = platform_get_irq(pdev, 1);
>> -	if (virq <= 0) {
>> -		dev_err(dev, "Failed to map IRQ\n");
>> +	if (virq <= 0)
>>  		return -ENXIO;
>
> Why <= 0 and -ENXIO?

Smirk. I remember discussing this in the past...
Here it is:

	https://patchwork.kernel.org/patch/10006651/

A) AFAIU platform_get_irq() = 0 signals an error.

	https://yarchive.net/comp/linux/zero.html
	https://lkml.org/lkml/2016/2/9/212
	https://patchwork.ozlabs.org/patch/486056/

B) I don't remember why I picked ENXIO.
Perhaps it made more sense to me (at the time) than EINVAL or ENODEV.

Regards.
