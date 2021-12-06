Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F646958D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 13:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhLFMXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 07:23:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242984AbhLFMXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 07:23:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3AFF1042;
        Mon,  6 Dec 2021 04:20:03 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E313F73D;
        Mon,  6 Dec 2021 04:20:02 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Date:   Mon,  6 Dec 2021 12:19:57 +0000
Message-Id: <163879317819.3988.9390653012838076482.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Nov 2021 16:59:38 +0100, Pali Rohár wrote:
> This patch series contains various fixes for pci-bridge-emul code.
> This code is used only by pci-aardvark.c and pci-mvebu.c drivers.
> 
> Pali Rohár (6):
>   PCI: pci-bridge-emul: Make expansion ROM Base Address register
>     read-only
>   PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
>     space
>   PCI: pci-bridge-emul: Add definitions for missing capabilities
>     registers
>   PCI: pci-bridge-emul: Fix definitions of reserved bits
>   PCI: pci-bridge-emul: Correctly set PCIe capabilities
>   PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
> 
> [...]

Applied to pci/bridge-emul, thanks!

[1/6] PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only
      https://git.kernel.org/lpieralisi/pci/c/1c1a3b4d3e
[2/6] PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space
      https://git.kernel.org/lpieralisi/pci/c/7b067ac63a
[3/6] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
      https://git.kernel.org/lpieralisi/pci/c/faa3e547f4
[4/6] PCI: pci-bridge-emul: Fix definitions of reserved bits
      https://git.kernel.org/lpieralisi/pci/c/a3ab28a2e3
[5/6] PCI: pci-bridge-emul: Correctly set PCIe capabilities
      https://git.kernel.org/lpieralisi/pci/c/0f7ba81700
[6/6] PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
      https://git.kernel.org/lpieralisi/pci/c/32051099e8

Thanks,
Lorenzo
