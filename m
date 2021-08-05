Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D013E11AE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhHEJzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 05:55:14 -0400
Received: from foss.arm.com ([217.140.110.172]:42048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhHEJzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 05:55:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 790B81FB;
        Thu,  5 Aug 2021 02:55:00 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C813F719;
        Thu,  5 Aug 2021 02:54:59 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: aardvark: PIO fixes
Date:   Thu,  5 Aug 2021 10:54:51 +0100
Message-Id: <162815723088.27490.10016762497670346640.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210722144041.12661-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org> <20210722144041.12661-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 22 Jul 2021 16:40:37 +0200, Pali Rohár wrote:
> This patch series fix PIO functions used for accessing PCI config space.
> 
> In v2 is fixed processing of CRS response which depends on emulation of
> CRSVIS and CRSSVE bits in config space of emulated PCIe bridge.
> 
> Patch "PCI: aardvark: Fix checking for PIO Non-posted Request" was
> dropped from v2 as it was already applied.
> 
> [...]

Applied to pci/aardvark, thanks!

[1/4] PCI: aardvark: Fix checking for PIO status
      https://git.kernel.org/lpieralisi/pci/c/fcb461e2bc
[2/4] PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO response
      https://git.kernel.org/lpieralisi/pci/c/02bcec3ea5
[3/4] PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
      https://git.kernel.org/lpieralisi/pci/c/e902bb7c24
[4/4] PCI: aardvark: Fix reporting CRS value
      https://git.kernel.org/lpieralisi/pci/c/43f5c77bcb

Thanks,
Lorenzo
