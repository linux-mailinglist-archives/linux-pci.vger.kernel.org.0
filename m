Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042840D8BD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhIPLc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 07:32:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:46028 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238226AbhIPLc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 07:32:28 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Sep 2021 20:31:07 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 1D3AD2021820;
        Thu, 16 Sep 2021 20:31:07 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 16 Sep 2021 20:31:07 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 98378C1883;
        Thu, 16 Sep 2021 20:31:06 +0900 (JST)
Received: from [10.212.183.234] (unknown [10.212.183.234])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 0D687B62B3;
        Thu, 16 Sep 2021 20:30:57 +0900 (JST)
Subject: Re: [PATCH v2 0/2] PCI: uniphier: Fix INTx masking/unmasking
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <64fd8ea9-1d78-5e3a-8097-6206f03e69de@socionext.com>
Date:   Thu, 16 Sep 2021 20:30:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle ping, are there any comments about this series?

Thank you,

On 2021/08/30 11:22, Kunihiko Hayashi wrote:
> This series includes some fixes to INTx masking/unmasking for UniPhier PCIe
> host controller driver.
> 
> - Remove unnecessary bit clears to INTX mask field
> - Remove unnecessary irq_ack() function because write access to status field
>    doesn't work
> - Add lock into callback functions to avoid race condition
> 
> Kunihiko Hayashi (2):
>    PCI: uniphier: Fix INTx mask/unmask bit operation and remove ack
>      function
>    PCI: uniphier: Serialize INTx masking/unmasking
> 
>   drivers/pci/controller/dwc/pcie-uniphier.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 

---
Best Regards
Kunihiko Hayashi
