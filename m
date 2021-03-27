Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4534B70F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 13:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhC0MLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 08:11:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15019 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC0MLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 08:11:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKv0H7gzPsw1;
        Sat, 27 Mar 2021 20:08:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:10:58 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 00/12] acpi: fix some coding style issues
Date:   Sat, 27 Mar 2021 20:08:12 +0800
Message-ID: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl.
Only cleanup and no function changes.

Differences from v2 to v3:
- Remove the modifications that may cause function change.

Differences from v1 to v2:
- Add subsystem and module name in the name of patch 05/15.
- Change to use more proper module name for some patch names.

Xiaofei Tan (12):
  ACPI: APD: fix a block comment align issue
  ACPI: processor: fix some coding style issues
  ACPI: ipmi: remove useless return statement for void function
  ACPI: LPSS: add a missed blank line after declarations
  ACPI: acpi_pad: add a missed blank line after declarations
  ACPI: battery: fix some coding style issues
  ACPI: button: fix some coding style issues
  ACPI: CPPC: fix some coding style issues
  ACPI: custom_method: fix a coding style issue
  ACPI: PM: add a missed blank line after declarations
  ACPI: sysfs: fix some coding style issues
  ACPI: dock: fix some coding style issues

 drivers/acpi/acpi_apd.c       |  8 ++---
 drivers/acpi/acpi_ipmi.c      |  1 -
 drivers/acpi/acpi_lpss.c      |  2 ++
 drivers/acpi/acpi_pad.c       |  4 +++
 drivers/acpi/acpi_processor.c | 18 +++--------
 drivers/acpi/battery.c        | 63 ++++++++++++++++++++------------------
 drivers/acpi/button.c         |  9 ++----
 drivers/acpi/cppc_acpi.c      | 71 ++++++++++++++++++++++---------------------
 drivers/acpi/custom_method.c  |  2 +-
 drivers/acpi/device_pm.c      |  3 ++
 drivers/acpi/device_sysfs.c   | 15 ++++++---
 drivers/acpi/dock.c           |  7 +++--
 12 files changed, 106 insertions(+), 97 deletions(-)

-- 
2.8.1

