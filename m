Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12B339A5B2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFCQ20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:28:26 -0400
Received: from foss.arm.com ([217.140.110.172]:45280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCQ20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:28:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A97411B3;
        Thu,  3 Jun 2021 09:26:41 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39ACD3F73D;
        Thu,  3 Jun 2021 09:26:39 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2] PCI: ftpci100: rename macro name collision
Date:   Thu,  3 Jun 2021 17:26:34 +0100
Message-Id: <162273757835.25424.5463028137806948110.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210517234117.3660-1-rdunlap@infradead.org>
References: <20210517234117.3660-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 May 2021 16:41:17 -0700, Randy Dunlap wrote:
> PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
> of the PCI_* macros in pci-ftpci100.c to use FTPCI_* so that they are
> more localized and won't conflict with other drivers or arches.
> 
> ../drivers/pci/controller/pci-ftpci100.c:37: warning: "PCI_IOSIZE" redefined
>    37 | #define PCI_IOSIZE 0x00
>       |
> In file included from ../arch/mips/include/asm/addrspace.h:13,
> ...              from ../drivers/pci/controller/pci-ftpci100.c:15:
> arch/mips/include/asm/mach-loongson64/spaces.h:11: note: this is the location of the previous definition
>    11 | #define PCI_IOSIZE SZ_16M

Applied to pci/ftpci100, thanks!

[1/1] PCI: ftpci100: rename macro name collision
      https://git.kernel.org/lpieralisi/pci/c/b1cb890637

Thanks,
Lorenzo
