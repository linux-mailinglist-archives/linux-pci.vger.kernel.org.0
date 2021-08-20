Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0543F2E76
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhHTPCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 11:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235928AbhHTPCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 11:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 926D460FE8;
        Fri, 20 Aug 2021 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629471689;
        bh=f4KQzaUDiLC6t79TdNH0xw/1Soy+9qM8gjQLjwed8kk=;
        h=Date:From:To:Cc:Subject:From;
        b=aGBo/jkqrs/vaOFJB/a5zGqSBMPo/JruDhJOHUnIMNwt7ZH4BBQzkt9CbHIC2thd6
         ABvkIru9/kCZo3wg/TmhYY35r/Bq8jawBoBFjjN7Ck7OOvU7rJURxZ4ykwnPvZoCE1
         56F3Ei7wf3DnDN69Z2k0tB/YwZTr/6QRcF229xDj3GJiLiFrv1DQ7SL6yFNq+xQTsw
         zaFuh/hA/Tof5Kd2boG9RYS+I5RchiYpj55UJ/bjWDRZ/7UtVYj2xj4Nie6GhK/yhs
         8bLq9AhEUG0G9OHv2N0hTKpAJeX0m2XJFcsylIbhEDDvuhyDV7Xp0fYVclFVy/sFeD
         Z1AaUqsqUKnmw==
Date:   Fri, 20 Aug 2021 10:01:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Marcin Bachry <hegel666@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Greg KH <greg@kroah.com>
Subject: [GIT PULL] PCI fixes for v5.14
Message-ID: <20210820150128.GA3317758@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-2

for you to fetch changes up to 045a9277b5615846c7b662ffaba84e781f08a172:

  PCI/sysfs: Use correct variable for the legacy_mem sysfs object (2021-08-19 10:21:53 -0500)


N.B. The sysfs fix will cause a trivial conflict when Greg's
driver-core tree is merged during the v5.15 merge window.

----------------------------------------------------------------
PCI fixes:

  - Add Rahul Tanwar as Intel LGM Gateway PCIe maintainer (Rahul Tanwar)

  - Add Jim Quinlan et al as Broadcom STB PCIe maintainers (Jim Quinlan)

  - Increase D3hot-to-D0 delay for AMD Renoir/Cezanne XHCI (Marcin Bachry)

  - Correct iomem_get_mapping() usage for legacy_mem sysfs (Krzysztof
    Wilczyński)

----------------------------------------------------------------
Jim Quinlan (1):
      MAINTAINERS: Add Jim Quinlan et al as Broadcom STB PCIe maintainers

Krzysztof Wilczyński (1):
      PCI/sysfs: Use correct variable for the legacy_mem sysfs object

Marcin Bachry (1):
      PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI

Rahul Tanwar (1):
      MAINTAINERS: Add Rahul Tanwar as Intel LGM Gateway PCIe maintainer

 MAINTAINERS             | 17 +++++++++++++++++
 drivers/pci/pci-sysfs.c |  2 +-
 drivers/pci/quirks.c    |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)
