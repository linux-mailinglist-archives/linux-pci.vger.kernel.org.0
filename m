Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113843F8816
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 14:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbhHZMyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 08:54:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhHZMyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 08:54:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B998106F;
        Thu, 26 Aug 2021 05:53:27 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5143F766;
        Thu, 26 Aug 2021 05:53:23 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh+dt@kernel.org, bhelgaas@google.com,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
        devicetree@vger.kernel.org, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 0/6] PCI: mediatek: Spilt PCIe node to comply with hardware design
Date:   Thu, 26 Aug 2021 13:53:12 +0100
Message-Id: <162998235864.26306.15150607621994016843.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
References: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 23 Aug 2021 11:27:54 +0800, Chuanjia Liu wrote:
> There are two independent PCIe controllers in MT2712 and MT7622 platform.
> Each of them should contain an independent MSI domain.
> 
> In old dts architecture, MSI domain will be inherited from the root
> bridge, and all of the devices will share the same MSI domain.Hence that,
> the PCIe devices will not work properly if the irq number which required
> is more than 32.
> 
> [...]

Applied to pci/mediatek, thanks!

[1/4] dt-bindings: PCI: mediatek: Update the Device tree bindings
      https://git.kernel.org/lpieralisi/pci/c/aa6eca5b81
[2/4] PCI: mediatek: Add new method to get shared pcie-cfg base address
      https://git.kernel.org/lpieralisi/pci/c/87e8657ba9
[3/4] PCI: mediatek: Add new method to get irq number
      https://git.kernel.org/lpieralisi/pci/c/436960bb00
[4/4] PCI: mediatek: Use PCI domain to handle ports detection
      https://git.kernel.org/lpieralisi/pci/c/77216702c8

Thanks,
Lorenzo
