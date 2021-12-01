Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F84652DD
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 17:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351107AbhLAQlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 11:41:13 -0500
Received: from foss.arm.com ([217.140.110.172]:41708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347953AbhLAQlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 11:41:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4954A14BF;
        Wed,  1 Dec 2021 08:37:50 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0BF3F766;
        Wed,  1 Dec 2021 08:37:48 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "maintainer:BROADCOM STB PCIE DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: brcmstb: Do not use __GENMASK
Date:   Wed,  1 Dec 2021 16:37:40 +0000
Message-Id: <163837664322.27871.17191687502099805776.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211122190459.3189616-1-f.fainelli@gmail.com>
References: <20211122190459.3189616-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Nov 2021 11:04:58 -0800, Florian Fainelli wrote:
> Define the legacy MSI intterupt bitmask as well as the non-legacy
> interrupt bitmask using GENMASK and then use them in brcm_msi_set_regs()
> in place of __GENMASK().
> 
> 

Applied to pci/brcmstb, thanks!

[1/1] PCI: brcmstb: Do not use __GENMASK
      https://git.kernel.org/lpieralisi/pci/c/53c6ccfa65

Thanks,
Lorenzo
