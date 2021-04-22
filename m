Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2954368481
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhDVQNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 12:13:48 -0400
Received: from mx.socionext.com ([202.248.49.38]:8022 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237663AbhDVQNp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 12:13:45 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Apr 2021 01:13:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 41E27205902A;
        Fri, 23 Apr 2021 01:13:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Apr 2021 01:13:10 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A76A8B1D40;
        Fri, 23 Apr 2021 01:13:09 +0900 (JST)
Received: from [10.212.21.208] (unknown [10.212.21.208])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 05A6B6270;
        Fri, 23 Apr 2021 01:13:08 +0900 (JST)
Subject: Re: [PATCH v10 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <20210414194654.GA2526782@bjorn-Precision-5520>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <53a0792c-3bb8-723a-f5b0-7ef59533fad5@socionext.com>
Date:   Fri, 23 Apr 2021 01:13:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414194654.GA2526782@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2021/04/15 4:46, Bjorn Helgaas wrote:
> On Sat, Apr 10, 2021 at 01:22:18AM +0900, Kunihiko Hayashi wrote:
>> This patch adds misc interrupt handler to detect and invoke PME/AER event.
>>
>> In UniPhier PCIe controller, PME/AER signals are assigned to the same
>> signal as MSI by the internal logic. These signals should be detected by
>> the internal register, however, DWC MSI handler can't handle these signals.
>>
>> DWC MSI handler calls .msi_host_isr() callback function, that detects
>> PME/AER signals using the internal register and invokes the interrupt
>> with PME/AER vIRQ numbers.
>>
>> These vIRQ numbers is obtained by uniphier_pcie_port_get_irq() function,
>> that finds the device that matches PME/AER from the devices associated
>> with Root Port, and returns its vIRQ number.
> 
> Why do you use the term "vIRQ"?  What exactly is a vIRQ?  It seems no
> different than the simple "irq" as stored in pci_dev.irq or
> pcie_device.irq and passed to generic_handle_irq().  "virq" is also
> used in the patch, so if you change one, please change the other as
> well.
Indeed, I used "virq" in contrast to "hwirq", but that seems wrong.
This interrupt number is equivarent to pci_dev.irq, so I'll fix it.

Thank you,

---
Best Regards
Kunihiko Hayashi
