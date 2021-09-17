Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF04101E3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 01:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhIQXud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 19:50:33 -0400
Received: from mx.socionext.com ([202.248.49.38]:35866 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhIQXuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 19:50:14 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Sep 2021 08:48:51 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4F16E205902A;
        Sat, 18 Sep 2021 08:48:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Sat, 18 Sep 2021 08:48:51 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 27767AB192;
        Sat, 18 Sep 2021 08:48:51 +0900 (JST)
Received: from [10.212.183.152] (unknown [10.212.183.152])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 5B85EB62B3;
        Sat, 18 Sep 2021 08:48:46 +0900 (JST)
Subject: Re: [PATCH v2 0/2] PCI: uniphier: Fix INTx masking/unmasking
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
 <64fd8ea9-1d78-5e3a-8097-6206f03e69de@socionext.com>
 <87ee9nb94s.wl-maz@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <8f2b77a5-e2a8-71a5-1b32-3ca2944cad28@socionext.com>
Date:   Sat, 18 Sep 2021 08:48:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87ee9nb94s.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thank you for your comment.

On 2021/09/17 22:54, Marc Zyngier wrote:
> On Thu, 16 Sep 2021 12:30:52 +0100,
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
>>
>> Gentle ping, are there any comments about this series?
>>
>> Thank you,
>>
>> On 2021/08/30 11:22, Kunihiko Hayashi wrote:
>>> This series includes some fixes to INTx masking/unmasking for UniPhier PCIe
>>> host controller driver.
>>>
>>> - Remove unnecessary bit clears to INTX mask field
>>> - Remove unnecessary irq_ack() function because write access to status field
>>>     doesn't work
>>> - Add lock into callback functions to avoid race condition
>>>
>>> Kunihiko Hayashi (2):
>>>     PCI: uniphier: Fix INTx mask/unmask bit operation and remove ack
>>>       function
>>>     PCI: uniphier: Serialize INTx masking/unmasking
>>>
>>>    drivers/pci/controller/dwc/pcie-uniphier.c | 26 ++++++++++----------------
>>>    1 file changed, 10 insertions(+), 16 deletions(-)
>>>
> 
> Patches look OK, although I would personally squash them into a single
> one (INTx masking never really worked before that). FWIW:

Surely applying only the first patch leaves the issue with the second one.
I'll squash them in v3.

Thank you,

> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	N,
> 

---
Best Regards
Kunihiko Hayashi
