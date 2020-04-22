Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366B51B36BA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 07:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDVFNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 01:13:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:9242 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVFNK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 01:13:10 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Apr 2020 14:13:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 14A4760057;
        Wed, 22 Apr 2020 14:13:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Apr 2020 14:13:09 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 923B11A12D0;
        Wed, 22 Apr 2020 14:13:08 +0900 (JST)
Received: from [10.213.29.177] (unknown [10.213.29.177])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 5C7BF120131;
        Wed, 22 Apr 2020 14:13:07 +0900 (JST)
Subject: Re: [PATCH v3 0/2] PCI: Add new UniPhier PCIe endpoint driver
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1584956454-8829-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <18cf881e-1d80-76bc-8c91-2fa9fa633558@socionext.com>
Date:   Wed, 22 Apr 2020 14:13:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1584956454-8829-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/03/23 18:40, Kunihiko Hayashi wrote:
> This series adds PCIe endpoint controller driver for Socionext UniPhier
> SoCs. This controller is based on the DesignWare PCIe core.
> 
> This driver supports Pro5 SoC only, so Pro5 needs multiple clocks and
> resets in devicetree node.
> 
> Changes since v2:
> - dt-bindings: Add clock-names, reset-names, and fix example for Pro5
> - Remove 'is_legacy' indicating that the compatible is for legacy SoC
> - Use pci_epc_features instead of defining uniphier_soc_data
> - Remove redundant register read access
> - Clean up return code on uniphier_add_pcie_ep()
> - typo: intx -> INTx
> 
> Changes since v1:
> - dt-bindings: Add Reviewed-by line
> - Fix register value to set EP mode
> - Add error message when failed to get phy
> - Replace INTx assertion time with macro
> 
> Kunihiko Hayashi (2):
>    dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
>    PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller
>      driver
> 
>   .../devicetree/bindings/pci/uniphier-pcie-ep.txt   |  53 +++
>   MAINTAINERS                                        |   4 +-
>   drivers/pci/controller/dwc/Kconfig                 |  13 +-
>   drivers/pci/controller/dwc/Makefile                |   1 +
>   drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 380 +++++++++++++++++++++
>   5 files changed, 447 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
>   create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c
> 

Gentle ping.
Are there any comments about changes since v2?
v2: https://www.spinics.net/lists/linux-pci/msg92429.html

Thank you,

---
Best Regards
Kunihiko Hayashi
