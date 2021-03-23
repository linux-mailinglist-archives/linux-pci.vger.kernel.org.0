Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E634345BE7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWKbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 06:31:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhCWKab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 06:30:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A505E1042;
        Tue, 23 Mar 2021 03:30:30 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.56.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 615AD3F719;
        Tue, 23 Mar 2021 03:30:28 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Minghuan Lian <Minghuan.Lian@nxp.com>
Subject: Re: [PATCH] PCI: mobiveil: Improve PCIE_LAYERSCAPE_GEN4 dependencies
Date:   Tue, 23 Mar 2021 10:30:22 +0000
Message-Id: <161649540110.20748.7096266995911563432.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210208142301.413582-1-geert+renesas@glider.be>
References: <20210208142301.413582-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 Feb 2021 15:23:01 +0100, Geert Uytterhoeven wrote:
>   - Drop the dependency on PCI, as this is implied by the dependency on
>     PCI_MSI_IRQ_DOMAIN,
>   - Drop the dependencies on OF and ARM64, as the driver compiles fine
>     without OF and/or on other architectures,
>   - The Freescale Layerscape PCIe Gen4 controller is present only on
>     Freescale Layerscape SoCs.  Hence depend on ARCH_LAYERSCAPE, to
>     prevent asking the user about this driver when configuring a kernel
>     without Freescale Layerscape support, unless compile-testing.

Applied to pci/misc, thanks!

[1/1] PCI: mobiveil: Improve PCIE_LAYERSCAPE_GEN4 dependencies
      https://git.kernel.org/lpieralisi/pci/c/021a90fe60

Thanks,
Lorenzo
