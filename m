Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0741C36550B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhDTJN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 05:13:27 -0400
Received: from foss.arm.com ([217.140.110.172]:59190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhDTJN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 05:13:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944B51435;
        Tue, 20 Apr 2021 02:12:55 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.58.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B35EB3F85F;
        Tue, 20 Apr 2021 02:12:52 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        sin_jieyang@mediatek.com, chuanjia.liu@mediatek.com,
        devicetree@vger.kernel.org, Krzysztof Wilczyski <kw@linux.com>,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        youlin.pei@mediatek.com, Rex-BC.Chen@mediatek.com,
        qizhong.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        anson.chuang@mediatek.com
Subject: Re: [PATCH v10 0/7] PCI: mediatek: Add new generation controller support
Date:   Tue, 20 Apr 2021 10:12:43 +0100
Message-Id: <161890993967.14131.8304781872037527456.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210420061723.989-1-jianjun.wang@mediatek.com>
References: <20210420061723.989-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Apr 2021 14:17:16 +0800, Jianjun Wang wrote:
> These series patches add pcie-mediatek-gen3.c and dt-bindings file to
> support new generation PCIe controller.
> 
> Changes in v10:
> 1. Fix the subject line format in commit message;
> 2. Use EXPORT_SYMBOL_GPL() to export pci_pio_to_address().
> 
> [...]

Applied to pci/mediatek, thanks!

[1/7] dt-bindings: PCI: mediatek-gen3: Add YAML schema
      https://git.kernel.org/lpieralisi/pci/c/07ca255e3d
[2/7] PCI: Export pci_pio_to_address() for module use
      https://git.kernel.org/lpieralisi/pci/c/9cc742078c
[3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
      https://git.kernel.org/lpieralisi/pci/c/441903d9e8
[4/7] PCI: mediatek-gen3: Add INTx support
      https://git.kernel.org/lpieralisi/pci/c/c58148e657
[5/7] PCI: mediatek-gen3: Add MSI support
      https://git.kernel.org/lpieralisi/pci/c/e0282a61f4
[6/7] PCI: mediatek-gen3: Add system PM support
      https://git.kernel.org/lpieralisi/pci/c/a7583c42f4
[7/7] MAINTAINERS: Add Jianjun Wang as MediaTek PCI co-maintainer
      https://git.kernel.org/lpieralisi/pci/c/fcf132f196

Thanks,
Lorenzo
