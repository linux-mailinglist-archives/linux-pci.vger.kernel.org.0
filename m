Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB448752B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiAGKEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:04:20 -0500
Received: from foss.arm.com ([217.140.110.172]:37808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236856AbiAGKET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 05:04:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3502A1042;
        Fri,  7 Jan 2022 02:04:19 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E003F66F;
        Fri,  7 Jan 2022 02:04:15 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11 0/7] PCI: brcmstb: root port turns on sub-device power
Date:   Fri,  7 Jan 2022 10:04:09 +0000
Message-Id: <164154982643.27548.5471667773667990055.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jan 2022 11:03:23 -0500, Jim Quinlan wrote:
> v11 -- Only one commit has changed from v10: "PCI: brcmstb: Add mechanism
>        to turn on subdev regulators". Lorenzo requested that this commit's
>        code be moved from pci/pci.h and pci/bus.c to
>        pci/controller/pcie-brcmstb.c as a stopgap measure until we figure
>        out a better way of offering this feature for all.  This will most
>        likely involve Pali's upcoming changes to refactor PCI host probe
>        code.
> 
> [...]

Applied to pci/brcmstb, thanks!

[1/7] PCI: brcmstb: Fix function return value handling
      https://git.kernel.org/lpieralisi/pci/c/ec16b36f89
[2/7] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
      https://git.kernel.org/lpieralisi/pci/c/7d0ad0c8cc
[3/7] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
      https://git.kernel.org/lpieralisi/pci/c/9a617ffe0d
[4/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
      https://git.kernel.org/lpieralisi/pci/c/2d8bb00647
[5/7] PCI: brcmstb: Add mechanism to turn on subdev regulators
      https://git.kernel.org/lpieralisi/pci/c/c2c8468565
[6/7] PCI: brcmstb: Add control of subdevice voltage regulators
      https://git.kernel.org/lpieralisi/pci/c/31d8fedc28
[7/7] PCI: brcmstb: Do not turn off WOL regulators on suspend
      https://git.kernel.org/lpieralisi/pci/c/d25f7bee89

Thanks,
Lorenzo
