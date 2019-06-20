Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060974CBF1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTKdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:33:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731400AbfFTKdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:33:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7DAC6567D15C60CAF22;
        Thu, 20 Jun 2019 18:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 18:33:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] Fixes for HiSilicon LPC driver and logical PIO code
Date:   Thu, 20 Jun 2019 18:31:51 +0800
Message-ID: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As reported in [1], the hisi-lpc driver has certain issues in handling
logical PIO regions, specifically unregistering regions.

This series add a method to unregister a logical PIO region, and fixes up
the driver to use them.

RCU usage in logical PIO code looks to always have been broken, so that
is fixed also. This is not a major fix as the list which RCU protects is
very rarely modified.

There is another patch to simplify logical PIO registration, made possible
by the fixes.

At this point, there are still separate ongoing discussions about how to
stop the logical PIO and PCI host bridge code leaking ranges, as in [2].

Hopefully this series can go through the arm soc tree and the maintainers
have no issue with that. I'm talking specifically about the logical PIO
code, which went through PCI tree on only previous upstreaming.

Cc. linux-pci@vger.kernel.org

[1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
[2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/

John Garry (5):
  lib: logic_pio: Fix RCU usage
  lib: logic_pio: Add logic_pio_unregister_range()
  bus: hisi_lpc: Unregister logical PIO range to avoid potential
    use-after-free
  bus: hisi_lpc: Add .remove method to avoid driver unbind crash
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration

 drivers/bus/hisi_lpc.c    | 43 ++++++++++++++++++---
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 78 ++++++++++++++++++++++++++++-----------
 3 files changed, 95 insertions(+), 27 deletions(-)

-- 
2.17.1

