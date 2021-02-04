Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9456430F2A0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhBDLng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 06:43:36 -0500
Received: from foss.arm.com ([217.140.110.172]:56774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235586AbhBDLnf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 06:43:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8852D6E;
        Thu,  4 Feb 2021 03:42:49 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.48.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78FEF3F73B;
        Thu,  4 Feb 2021 03:42:48 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh@kernel.org, linux-pci@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com,
        "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        cyril.jean@microchip.com, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v21 0/4] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Thu,  4 Feb 2021 11:42:42 +0000
Message-Id: <161243891187.17448.11139405975325668129.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210125162934.5335-1-daire.mcnamara@microchip.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 25 Jan 2021 16:29:30 +0000, daire.mcnamara@microchip.com wrote:
> This patchset adds support for the Microchip PCIe PolarFire PCIe
> controller when configured in host (Root Complex) mode.
> 
> Updates since v20:
> * Changed module license from GPLv2 to GPL
> * Removed bus-shift for mc_ecam_ops
> 
> [...]

Applied to pci/microchip, tentatively for v5.12, thanks !

[1/4] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
      https://git.kernel.org/lpieralisi/pci/c/5aa5282680
[2/4] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
      https://git.kernel.org/lpieralisi/pci/c/1d8b748536
[3/4] PCI: microchip: Add host driver for Microchip PCIe controller
      https://git.kernel.org/lpieralisi/pci/c/8a09a17d15
[4/4] MAINTAINERS: Add Daire McNamara as maintainer for the Microchip PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/e9ddffa6a4

Thanks,
Lorenzo
