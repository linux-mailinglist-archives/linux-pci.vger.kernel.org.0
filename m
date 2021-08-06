Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4543E2776
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbhHFJkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 05:40:21 -0400
Received: from foss.arm.com ([217.140.110.172]:56766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244184AbhHFJkU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 05:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B91A31B;
        Fri,  6 Aug 2021 02:40:04 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCF143F719;
        Fri,  6 Aug 2021 02:40:00 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>, matthias.bgg@gmail.com,
        bhelgaas@google.com, robh+dt@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, yong.wu@mediatek.com,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org, jianjun.wang@mediatek.com
Subject: Re: [PATCH v11 0/4] PCI: mediatek: Spilt PCIe node to comply with hardware design
Date:   Fri,  6 Aug 2021 10:39:54 +0100
Message-Id: <162824274659.11010.3812952145024175369.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Jul 2021 15:34:52 +0800, Chuanjia Liu wrote:
> There are two independent PCIe controllers in MT2712 and MT7622 platform.
> Each of them should contain an independent MSI domain.
> 
> In old dts architecture, MSI domain will be inherited from the root bridge,
> and all of the devices will share the same MSI domain.Hence that,
> the PCIe devices will not work properly if the irq number
> which required is more than 32.
> 
> [...]

Applied patches 1-2 to pci/mediatek (we don't merge dts changes), thanks!

[1/2] dt-bindings: PCI: mediatek: Update the Device tree bindings
      https://git.kernel.org/lpieralisi/pci/c/9c23251640
[2/2] PCI: mediatek: Add new method to get shared pcie-cfg base address and parse node
      https://git.kernel.org/lpieralisi/pci/c/302e503e08

Thanks,
Lorenzo
