Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34F741D5C8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbhI3Izp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 04:55:45 -0400
Received: from foss.arm.com ([217.140.110.172]:50682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348952AbhI3Izp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 04:55:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803C8D6E;
        Thu, 30 Sep 2021 01:54:02 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53843F793;
        Thu, 30 Sep 2021 01:54:00 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
Date:   Thu, 30 Sep 2021 09:53:53 +0100
Message-Id: <163299201477.31815.18190082659502039608.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210531085934.2662457-1-luca@lucaceresoli.net>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 May 2021 10:59:30 +0200, Luca Ceresoli wrote:
> This is an series of mixed improvements to the DRA7 PCI controller driver:
> allow building as a loadabel module, allow to get and enable a clock and a
> small cleanup.
> 
> Luca
> 
> Luca Ceresoli (4):
>   PCI: dwc: Export more symbols to allow modular drivers
>   PCI: dra7xx: Make it a kernel module
>   PCI: dra7xx: Remove unused include
>   PCI: dra7xx: Get an optional clock
> 
> [...]

Applied to pci/dwc, thanks!

[1/4] PCI: dwc: Export more symbols to allow modular drivers
      https://git.kernel.org/lpieralisi/pci/c/3a7fb86758
[2/4] PCI: dra7xx: Make it a kernel module
      https://git.kernel.org/lpieralisi/pci/c/3b868d150e
[3/4] PCI: dra7xx: Remove unused include
      https://git.kernel.org/lpieralisi/pci/c/b9a6943dc8
[4/4] PCI: dra7xx: Get an optional clock
      https://git.kernel.org/lpieralisi/pci/c/5af9405397

Thanks,
Lorenzo
