Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E64A82C4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiBCK4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 05:56:10 -0500
Received: from foss.arm.com ([217.140.110.172]:38744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243664AbiBCK4J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 05:56:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6BC11D4;
        Thu,  3 Feb 2022 02:56:09 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.39.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6DD3F774;
        Thu,  3 Feb 2022 02:56:06 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 00/11] PCI: Small improvements for pci-bridge-emul and mvebu
Date:   Thu,  3 Feb 2022 10:56:00 +0000
Message-Id: <164388574160.14310.5659554004338344602.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org> <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Jan 2022 16:35:18 +0100, Pali Rohár wrote:
> This patch series contains small improvements for pci-bridge-emul and
> mvebu drivers. This patch series is based on top of the patches:
> https://lore.kernel.org/linux-pci/20211125124605.25915-1-pali@kernel.org/
> (which are now in pci/mvebu branch)
> 
> In V2 was added comment into code explaining PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
> and PCI_BRIDGE_EMUL_NO_IO_FORWARD flags.
> 
> [...]

Applied to pci/mvebu, thanks!

[01/11] MAINTAINERS: Add Pali Rohár as pci-mvebu.c maintainer
        https://git.kernel.org/lpieralisi/pci/c/e621e106a1
[02/11] PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
        https://git.kernel.org/lpieralisi/pci/c/64a70f521e
[03/11] PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
        https://git.kernel.org/lpieralisi/pci/c/d3f332b568
[04/11] PCI: pci-bridge-emul: Add support for new flag PCI_BRIDGE_EMUL_NO_IO_FORWARD
        https://git.kernel.org/lpieralisi/pci/c/05241c1365
[05/11] PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
        https://git.kernel.org/lpieralisi/pci/c/7f09a4b195
[06/11] PCI: mvebu: Remove duplicate nports assignment
        https://git.kernel.org/lpieralisi/pci/c/7a02acdb5d
[07/11] PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
        https://git.kernel.org/lpieralisi/pci/c/5c88ed7985
[08/11] PCI: mvebu: Properly initialize vendor, device and revision of emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/16038ebb0f
[09/11] PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/d76a6ed096
[10/11] PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/c94ea32c0d
[11/11] PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/c3bd7dc553

Thanks,
Lorenzo
