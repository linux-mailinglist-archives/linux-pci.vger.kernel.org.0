Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3505D3D3C3A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGWObe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 10:31:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235438AbhGWObd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:31:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD6F1063;
        Fri, 23 Jul 2021 08:12:06 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866E83F73D;
        Fri, 23 Jul 2021 08:12:04 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: PCI_IXP4XX should depend on ARCH_IXP4XX
Date:   Fri, 23 Jul 2021 16:11:52 +0100
Message-Id: <162705309666.19732.14327880252939965345.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <6a88e55fe58fc280f4ff1ca83c154e4895b6dcbf.1624972789.git.geert+renesas@glider.be>
References: <6a88e55fe58fc280f4ff1ca83c154e4895b6dcbf.1624972789.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jun 2021 15:20:45 +0200, Geert Uytterhoeven wrote:
> The Intel IXP4xx PCI controller is only present on Intel IXP4xx
> XScale-based network processor SoCs.  Hence add a dependency on
> ARCH_IXP4XX, to prevent asking the user about this driver when
> configuring a kernel without support for the XScale processor family.

Applied to pci/misc, thanks!

[1/1] PCI: controller: PCI_IXP4XX should depend on ARCH_IXP4XX
      https://git.kernel.org/lpieralisi/pci/c/9f1168cf26

Thanks,
Lorenzo
