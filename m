Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37014631DF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhK3LPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 06:15:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhK3LPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 06:15:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A7C41063;
        Tue, 30 Nov 2021 03:11:54 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142B43F766;
        Tue, 30 Nov 2021 03:11:49 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] arm: ioremap: Remove pci_ioremap_io() and mvebu_pci_host_probe()
Date:   Tue, 30 Nov 2021 11:11:43 +0000
Message-Id: <163827065859.21977.786435593890374586.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211124154116.916-1-pali@kernel.org>
References: <20211124154116.916-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Nov 2021 16:41:11 +0100, Pali Rohár wrote:
> This patch series removes ARM specific functions pci_ioremap_io() and
> mvebu_pci_host_probe() functions.
> 
> pci_ioremap_io() is replaced by standard PCI core function pci_remap_iospace()
> and mvebu_pci_host_probe() by standard PCI core function pci_host_probe().
> 
> ARM needs custom implementation of pci_remap_iospace() because of
> pci_ioremap_set_mem_type() hook used by Marvell Armada 375, 38x and 39x
> platforms due to HW errata.
> 
> [...]

Applied to pci/mvebu, thanks!

[1/5] arm: ioremap: Implement standard PCI function pci_remap_iospace()
      https://git.kernel.org/lpieralisi/pci/c/bc02973a06
[2/5] PCI: mvebu: Replace pci_ioremap_io() usage by devm_pci_remap_iospace()
      https://git.kernel.org/lpieralisi/pci/c/c1aa4b55aa
[3/5] PCI: mvebu: Remove custom mvebu_pci_host_probe() function
      https://git.kernel.org/lpieralisi/pci/c/de58d49470
[4/5] arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
      https://git.kernel.org/lpieralisi/pci/c/9c8facde92
[5/5] arm: ioremap: Remove unused ARM-specific function pci_ioremap_io()
      https://git.kernel.org/lpieralisi/pci/c/ea76d27fb3

Thanks,
Lorenzo
