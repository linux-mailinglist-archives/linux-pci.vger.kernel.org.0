Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250843F9D9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJ2Jae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 05:30:34 -0400
Received: from foss.arm.com ([217.140.110.172]:36314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhJ2Jae (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Oct 2021 05:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872551FB;
        Fri, 29 Oct 2021 02:28:05 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.46.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5183F5A1;
        Fri, 29 Oct 2021 02:28:04 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: aardvark controller fixes BATCH 2
Date:   Fri, 29 Oct 2021 10:27:54 +0100
Message-Id: <163549964017.15948.15238461459509746209.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211028185659.20329-1-kabel@kernel.org>
References: <20211028185659.20329-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Oct 2021 20:56:52 +0200, Marek Behún wrote:
> Lorenzo,
> 
> this is v2 of the second batch of aardvark changes.
> 
> As requested, I have removed patches 4-10, which will be rebased and
> sent in the next batch.
> 
> [...]

Applied to pci/aardvark, thanks!

[1/7] PCI: pci-bridge-emul: Fix emulation of W1C bits
      https://git.kernel.org/lpieralisi/pci/c/7a41ae80bd
[2/7] PCI: aardvark: Fix return value of MSI domain .alloc() method
      https://git.kernel.org/lpieralisi/pci/c/e4313be159
[3/7] PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG
      https://git.kernel.org/lpieralisi/pci/c/95997723b6
[4/7] PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on emulated bridge
      https://git.kernel.org/lpieralisi/pci/c/771153fc88
[5/7] PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
      https://git.kernel.org/lpieralisi/pci/c/84e1b4045d
[6/7] PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
      https://git.kernel.org/lpieralisi/pci/c/bc4fac42e5
[7/7] PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge
      https://git.kernel.org/lpieralisi/pci/c/239edf686c

Thanks,
Lorenzo
