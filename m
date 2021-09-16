Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CB40D890
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhIPLcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 07:32:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:19585 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238044AbhIPLcI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 07:32:08 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Sep 2021 20:30:48 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EE3AD2059034;
        Thu, 16 Sep 2021 20:30:47 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 16 Sep 2021 20:30:47 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 9F208C1883;
        Thu, 16 Sep 2021 20:30:47 +0900 (JST)
Received: from [10.212.183.234] (unknown [10.212.183.234])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 5204BB62B3;
        Thu, 16 Sep 2021 20:30:40 +0900 (JST)
Subject: Re: [PATCH v2 0/2] PCI: endpoint: Fix core_init_notifier feature
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <74df1b92-60e8-34da-2d39-236bdeea3fc6@socionext.com>
Date:   Thu, 16 Sep 2021 20:30:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle ping, are there any comments about this series?

Thank you,

On 2021/09/01 14:15, Kunihiko Hayashi wrote:
> This series has two fixes for core_init_notifier feature.
> 
> Fix the bug that the driver can't register its notifier function
> if core_init_notifier == true and linkup_notifier == false.
> 
> If enabling the controller is delayed due to core_init_notifier,
> accesses to the controller register should be avoided rather than
> enabling the controller.
> 
> Changes since v1:
> - Add Acked-by and Reviewed-by lines
> 
> Kunihiko Hayashi (2):
>    PCI: endpoint: pci-epf-test: register notifier if only
>      core_init_notifier is enabled
>    PCI: designware-ep: Fix the access to DBI/iATU registers before
>      enabling controller
> 
>   drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
>   drivers/pci/endpoint/functions/pci-epf-test.c   |  2 +-
>   2 files changed, 42 insertions(+), 41 deletions(-)
> 

-- 
---
Best Regards
Kunihiko Hayashi
