Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5D42226D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJEJiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:38:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhJEJiH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:38:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151846D;
        Tue,  5 Oct 2021 02:36:17 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2757E3F66F;
        Tue,  5 Oct 2021 02:36:15 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_HOST)
Date:   Tue,  5 Oct 2021 10:36:09 +0100
Message-Id: <163342655846.12064.11677535124745483381.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Jun 2021 17:01:02 +0300, Andy Shevchenko wrote:
> First of all, the "depends on" is no-op in the selectable options.
> Second, no need to repeat menu dependencies (PCI).
> 
> Clean up the users of PCIE_DW_HOST and introduce idiom
> 
> 	depends on PCI_MSI_IRQ_DOMAIN
> 	select PCIE_DW_HOST
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_HOST)
      https://git.kernel.org/lpieralisi/pci/c/a0ac7ee069
[2/2] PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_EP)
      https://git.kernel.org/lpieralisi/pci/c/2d614eea21

Thanks,
Lorenzo
