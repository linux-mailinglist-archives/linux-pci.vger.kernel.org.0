Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A72484424
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiADPEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:04:37 -0500
Received: from foss.arm.com ([217.140.110.172]:60492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233194AbiADPEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 10:04:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0D113A1;
        Tue,  4 Jan 2022 07:04:37 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A284F3F774;
        Tue,  4 Jan 2022 07:04:34 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] pci: mvebu: Various fixes
Date:   Tue,  4 Jan 2022 15:04:28 +0000
Message-Id: <164130858682.16382.8296252945836815553.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Nov 2021 13:45:50 +0100, Pali Rohár wrote:
> This patch series contains various fixes for pci-mvebu.c driver. Only
> bugfixes, no new features.
> 
> For pci-mvebu.c I have prepared another 30+ patches with cleanups and
> new features, they are currently available in my git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu
> 
> [...]

Dropped stable tags and applied on top of my pci/mvebu branch (please
check I rebased commits correctly), thanks!

[01/15] PCI: mvebu: Check for valid ports
        https://git.kernel.org/lpieralisi/pci/c/8cdabfdd5a
[02/15] PCI: mvebu: Check for errors from pci_bridge_emul_init() call
        https://git.kernel.org/lpieralisi/pci/c/5d18d702e5
[03/15] PCI: mvebu: Check that PCI bridge specified in DT has function number zero
        https://git.kernel.org/lpieralisi/pci/c/489bfc5187
[04/15] PCI: mvebu: Handle invalid size of read config request
        https://git.kernel.org/lpieralisi/pci/c/11c2bf4a20
[05/15] PCI: mvebu: Disallow mapping interrupts on emulated bridges
        https://git.kernel.org/lpieralisi/pci/c/319e6046bd
[06/15] PCI: mvebu: Fix support for bus mastering and PCI_COMMAND on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/e42b855837
[07/15] PCI: mvebu: Do not modify PCI IO type bits in conf_write
        https://git.kernel.org/lpieralisi/pci/c/2cf150216e
[08/15] PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers
        https://git.kernel.org/lpieralisi/pci/c/e7a0187672
[09/15] PCI: mvebu: Setup PCIe controller to Root Complex mode
        https://git.kernel.org/lpieralisi/pci/c/df08ac0161
[10/15] PCI: mvebu: Set PCI Bridge Class Code to PCI Bridge
        https://git.kernel.org/lpieralisi/pci/c/f587775828
[11/15] PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/91a8d79fc7
[12/15] PCI: mvebu: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/d75404cc08
[13/15] PCI: mvebu: Fix support for PCI_EXP_DEVCTL on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/ecae073e39
[14/15] PCI: mvebu: Fix support for PCI_EXP_RTSTA on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/838ff44a39
[15/15] PCI: mvebu: Fix support for DEVCAP2, DEVCTL2 and LNKCTL2 registers on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/4ab34548c5

Thanks,
Lorenzo
