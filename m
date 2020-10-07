Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6664C285784
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 06:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgJGEXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 00:23:12 -0400
Received: from mx.socionext.com ([202.248.49.38]:21676 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJGEXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 00:23:12 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Oct 2020 13:23:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 370B260060;
        Wed,  7 Oct 2020 13:23:10 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 7 Oct 2020 13:23:10 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C81684031B;
        Wed,  7 Oct 2020 13:23:09 +0900 (JST)
Received: from [10.212.0.119] (unknown [10.212.0.119])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2B04C120499;
        Wed,  7 Oct 2020 13:23:09 +0900 (JST)
Subject: Re: [PATCH v7 0/3] PCI: uniphier: Add PME/AER support for UniPhier
 PCIe host controller
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <aef99409-ae8e-3559-2b19-10a77d70749b@socionext.com>
Date:   Wed, 7 Oct 2020 13:23:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Gentle ping.
Are there any comments about this series?

Thank you,

On 2020/09/11 18:33, Kunihiko Hayashi wrote:
> The original subject up to v6 is
> "PCI: uniphier: Add features for UniPhier PCIe host controller".
> 
> This adds a new function called by MSI handler in DesignWare PCIe framework,
> that invokes PME and AER funcions to detect the factor from SoC-dependent
> registers.
> 
> The iATU patches is split from this series as
> "PCI: dwc: Move iATU register mapping to common framework".
> 
> Changes since v6:
> - Separate patches for iATU and phy error from this series
> - Add Reviewed-by: line
> 
> Changes since v5:
> - Add pcie_port_service_get_irq() function to pcie/portdrv
> - Call pcie_port_service_get_irq() to get vIRQ interrupt number for PME/AER
> - Rebase to the latest linux-next branch,
>    and remove devm_platform_ioremap_resource_byname() replacement patch
> 
> Changes since v4:
> - Add Acked-by: line to dwc patch
> 
> Changes since v3:
> - Move msi_host_isr() call into dw_handle_msi_irq()
> - Move uniphier_pcie_misc_isr() call into the guard of chained_irq
> - Use a bool argument is_msi instead of pci_msi_enabled()
> - Consolidate handler calls for the same interrupt
> - Fix typos in commit messages
> 
> Changes since v2:
> - Avoid printing phy error message in case of EPROBE_DEFER
> - Fix iATU register mapping method
> - dt-bindings: Add Acked-by: line
> - Fix typos in commit messages
> - Use devm_platform_ioremap_resource_byname()
> 
> Changes since v1:
> - Add check if struct resource is NULL
> - Fix warning in the type of dev_err() argument
> 
> Kunihiko Hayashi (3):
>    PCI: portdrv: Add pcie_port_service_get_irq() function
>    PCI: dwc: Add msi_host_isr() callback
>    PCI: uniphier: Add misc interrupt handler to invoke PME and AER
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c |  3 +
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   drivers/pci/controller/dwc/pcie-uniphier.c        | 77 +++++++++++++++++++----
>   drivers/pci/pcie/portdrv.h                        |  1 +
>   drivers/pci/pcie/portdrv_core.c                   | 16 +++++
>   5 files changed, 87 insertions(+), 11 deletions(-)
> 

-- 
---
Best Regards
Kunihiko Hayashi
