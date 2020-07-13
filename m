Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AFA21D7A1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMN5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:57:05 -0400
Received: from foss.arm.com ([217.140.110.172]:36394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbgGMN5E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 09:57:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C42B30E;
        Mon, 13 Jul 2020 06:57:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59213F7BB;
        Mon, 13 Jul 2020 06:57:03 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:56:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh@kernel.org, maz@kernel.org
Subject: Re: [PATCH v9 0/2]  Adding support for Versal CPM as Root Port driver
Message-ID: <20200713135658.GA27845@e121166-lin.cambridge.arm.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 06:26:52PM +0530, Bharat Kumar Gogada wrote:
> - Adding support for Versal CPM as Root port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.
> 
> Changes for v9:
> - Removed interrupt enablement outside irqchip flow as suggested
>   by Marc.
> - Removed using WARN_ON in if statement.
> 
> Bharat Kumar Gogada (2):
>   PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
>   PCI: xilinx-cpm: Add Versal CPM Root Port driver
> 
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  99 ++++
>  drivers/pci/controller/Kconfig                     |   8 +
>  drivers/pci/controller/Makefile                    |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c           | 615 +++++++++++++++++++++
>  4 files changed, 723 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

Applied to pci/xilinx (I removed a function kerneldoc comment
(xilinx_cpm_pcie_clear_err_interrupts()) since it was not matching
the function name and honestly it is not really needed) for v5.9.

Thanks,
Lorenzo
