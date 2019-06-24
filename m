Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5450EA0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfFXOgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 10:36:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbfFXOgj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 10:36:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0CD4920D55B641FA4EB3;
        Mon, 24 Jun 2019 22:36:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 22:36:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/6] Fixes for HiSilicon LPC driver and logical PIO code
Date:   Mon, 24 Jun 2019 22:35:02 +0800
Message-ID: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
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
is fixed also. This is not a major fix as the list which RCU protects
would be rarely modified.

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

Changes since v1:
- Add more reasoning in RCU fix patch
- Create separate patch to change LOGIC_PIO_CPU_MMIO registration to
  accomodate unregistration

John Garry (6):
  lib: logic_pio: Fix RCU usage
  lib: logic_pio: Avoid possible overlap for unregistering regions
  lib: logic_pio: Add logic_pio_unregister_range()
  bus: hisi_lpc: Unregister logical PIO range to avoid potential
    use-after-free
  bus: hisi_lpc: Add .remove method to avoid driver unbind crash
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration

 drivers/bus/hisi_lpc.c    | 43 +++++++++++++++++---
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 86 +++++++++++++++++++++++++++------------
 3 files changed, 99 insertions(+), 31 deletions(-)

-- 
2.17.1

