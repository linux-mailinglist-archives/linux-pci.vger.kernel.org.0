Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694E148655B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiAFNi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 08:38:58 -0500
Received: from foss.arm.com ([217.140.110.172]:54480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbiAFNi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 08:38:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11BA12FC;
        Thu,  6 Jan 2022 05:38:56 -0800 (PST)
Received: from e123427-lin.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30C333F5A1;
        Thu,  6 Jan 2022 05:38:54 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: mvebu: Add support for unbinding and unloading driver
Date:   Thu,  6 Jan 2022 13:38:45 +0000
Message-Id: <164147629708.11320.5014072725666944970.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211126144307.7568-1-pali@kernel.org>
References: <20211126144307.7568-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Nov 2021 15:43:05 +0100, Pali Rohár wrote:
> This patch series add support for unbinding device from pci-mvebu driver,
> allow to compile pci-mvebu.c as kernel module pci-mvebu.ko and allow to
> rmmod this module.
> 
> This patch series depends on another patch series which converts
> pci-mvebu.c driver to use devm_pci_remap_iospace() function:
> 
> [...]

Applied to pci/mvebu, thanks!

[1/2] bus: mvebu-mbus: Export symbols for public API window functions
      https://git.kernel.org/lpieralisi/pci/c/859186e238
[2/2] PCI: mvebu: Add support for compiling driver as module
      https://git.kernel.org/lpieralisi/pci/c/0746ae1be1

Thanks,
Lorenzo
