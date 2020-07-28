Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED91F231054
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgG1RBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731478AbgG1RBj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 13:01:39 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6971C2053B;
        Tue, 28 Jul 2020 17:01:35 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        iommu@lists.linux-foundation.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping APIs
Date:   Tue, 28 Jul 2020 18:01:33 +0100
Message-Id: <159595564192.31263.3059824977932788766.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Jun 2020 09:20:01 +0100, Lorenzo Pieralisi wrote:
> This series is a v2 of a previous posting:
> 
> v1 -> v2
> 
> - Removed _rid() wrappers
> - Fixed !CONFIG_ACPI compilation issue
> - Converted of_pci_iommu_init() to use of_iommu_configure_dev_id()
> 
> [...]

Applied to arm64 (for-next/msi-iommu), thanks!

[01/12] ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for NC
        https://git.kernel.org/arm64/c/07d2e59f27cd
[02/12] ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
        https://git.kernel.org/arm64/c/d1718a1b7a86
[03/12] ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
        https://git.kernel.org/arm64/c/39c3cf566cea
[04/12] ACPI/IORT: Remove useless PCI bus walk
        https://git.kernel.org/arm64/c/3a3d208beede
[05/12] ACPI/IORT: Add an input ID to acpi_dma_configure()
        https://git.kernel.org/arm64/c/b8e069a2a8da
[06/12] of/iommu: Make of_map_rid() PCI agnostic
        https://git.kernel.org/arm64/c/746a71d02b5d
[07/12] of/device: Add input id to of_dma_configure()
        https://git.kernel.org/arm64/c/a081bd4af4ce
[08/12] dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus
        https://git.kernel.org/arm64/c/5bda70c6162d
[09/12] of/irq: make of_msi_map_get_device_domain() bus agnostic
        https://git.kernel.org/arm64/c/6f881aba0110
[10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
        https://git.kernel.org/arm64/c/2bcdd8f2c07f
[11/12] bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver
        https://git.kernel.org/arm64/c/998fb7badf03
[12/12] bus: fsl-mc: Add ACPI support for fsl-mc
        https://git.kernel.org/arm64/c/6305166c8771

-- 
Catalin

