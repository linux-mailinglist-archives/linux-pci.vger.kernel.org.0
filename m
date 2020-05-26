Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F71E1E4F
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgEZJWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 05:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgEZJWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 05:22:05 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB85C03E97E;
        Tue, 26 May 2020 02:22:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 5A5C220CF0;
        Tue, 26 May 2020 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590484923; bh=I46BI7cOgVu3y1OcELr0ljjJTjMQQeMOztYsGts+LgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mF6Owjpoz2JoaDhf357+NWiHhPpiad3mgAU/Y4KDD3KnNznbkfHcu9qIG/nmGAyIS
         BPI1oOHsC3TBOCSW6p5Qcp6e+bz9WSdvM8N31hGcjfDRs6WOtODJFhkQwufV/qLoS0
         E/rsywvKaxEONzbAXDFCDlAm2G1dfWi9Hp1nb2jFdIfvvpyhbSzUDkbLZqIIgLcV9S
         yTbIj5I0MyCdF0HHwdSQw8VlYnQg87vPHV1XU5VPLU0G3LD+3CELJN9kfotGiY2GW3
         yLn16oDAPcxx6RMIr1i4QkTLBVkbYAGD3qY+OU0zLNJlHXo7zOs1/CJ9cvrQHVmzBo
         LLwiMMcdVXJDA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v11 0/5] Loongson Generic PCI v11
Date:   Tue, 26 May 2020 17:21:11 +0800
Message-Id: <20200526092130.145550-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v11 fixes a minor style issue in patch 2.

Now it have got enough ack,
Thomas, cloud you please apply it to mips-next?

Thanks.

Jiaxun Yang (5):
  PCI: Don't disable decoding when mmio_always_on is set
  PCI: Add Loongson PCI Controller support
  dt-bindings: Document Loongson PCI Host Controller
  MIPS: DTS: Loongson64: Add PCI Controller Node
  MIPS: Loongson64: Switch to generic PCI driver

 .../devicetree/bindings/pci/loongson.yaml     |  62 +++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  12 +
 arch/mips/loongson64/Makefile                 |   2 +-
 arch/mips/loongson64/vbios_quirk.c            |  29 ++
 arch/mips/pci/Makefile                        |   1 -
 arch/mips/pci/fixup-loongson3.c               |  71 -----
 arch/mips/pci/ops-loongson3.c                 | 116 --------
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-loongson.c         | 247 ++++++++++++++++++
 drivers/pci/probe.c                           |   2 +-
 12 files changed, 364 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
 create mode 100644 arch/mips/loongson64/vbios_quirk.c
 delete mode 100644 arch/mips/pci/fixup-loongson3.c
 delete mode 100644 arch/mips/pci/ops-loongson3.c
 create mode 100644 drivers/pci/controller/pci-loongson.c

-- 
2.27.0.rc0

