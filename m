Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE744875F2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiAGK4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:56:16 -0500
Received: from foss.arm.com ([217.140.110.172]:39478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237912AbiAGK4Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 05:56:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAB8113D5;
        Fri,  7 Jan 2022 02:56:15 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B843F66F;
        Fri,  7 Jan 2022 02:56:13 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] PCI: Keystone: Misc fixes for TI's AM65x PCIe
Date:   Fri,  7 Jan 2022 10:56:06 +0000
Message-Id: <164155292976.23228.14963816874511057147.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Nov 2021 14:01:14 +0530, Kishon Vijay Abraham I wrote:
> Patch series includes miscellaneous fixes for TI's AM65x SoC
> "PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)"  has
> already been sent before [1]
> 
> The other patch is to prevent PCIEPORTBUS driver to write to
> MSI-X table (which is not mapped) leading to ~10sec delay
> due to msix_mask_all().
> 
> [...]

Applied (patches 1 and 2) to pci/keystone, thanks!

[1/5] dt-bindings: PCI: ti,am65: Fix "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
      https://git.kernel.org/lpieralisi/pci/c/d91e775e66
[2/5] PCI: keystone: Use phandle argument from "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"
      https://git.kernel.org/lpieralisi/pci/c/7dcf07ac88

Thanks,
Lorenzo
