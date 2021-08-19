Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902AC3F237E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 01:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhHSXDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 19:03:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:17311 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhHSXDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 19:03:41 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Aug 2021 08:03:03 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CD33D2022041;
        Fri, 20 Aug 2021 08:03:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 20 Aug 2021 08:03:03 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7DB5DB631E;
        Fri, 20 Aug 2021 08:03:03 +0900 (JST)
Received: from [10.212.29.185] (unknown [10.212.29.185])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id BB673A911B;
        Fri, 20 Aug 2021 08:03:02 +0900 (JST)
Subject: Re: [PATCH] PCI: uniphier: Take lock in INTX irq_{mask,unmask,ack}
 callbacks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210819112908.GA3188927@bjorn-Precision-5520>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <6ae226a6-dc3d-94da-a356-6bd78053de06@socionext.com>
Date:   Fri, 20 Aug 2021 08:03:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819112908.GA3188927@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Thank you for checking.

On 2021/08/19 20:29, Bjorn Helgaas wrote:
> Possibly update subject to be more descriptive, along lines of:
> 
>    Serialize INTx masking/unmasking

Okay, I'll apply it to the subject.

> On Thu, Aug 19, 2021 at 07:56:06PM +0900, Kunihiko Hayashi wrote:
>> The same condition register PCI_RCV_INTX is used in irq_mask(),
>> irq_unmask() and irq_ack() callbacks. Accesses to register can occur at the
>> same time without lock.
>> This introduces a lock into the callbacks to prevent the issue.
> 
> Rewrap into a single paragraph or add blank line between paragraphs.
> 
> s/This introduces/Add/ to make this an imperative description of what
> you want this patch to do.  No need for "This" since the context is
> obvious.

I see. I'll rewrite the message to convey it more directly.

Thank you,

---
Best Regards
Kunihiko Hayashi
