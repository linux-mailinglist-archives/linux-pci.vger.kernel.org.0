Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7609C376581
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhEGMvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 08:51:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17152 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhEGMvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 08:51:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc9F52R6VzqTD8;
        Fri,  7 May 2021 20:46:49 +0800 (CST)
Received: from huawei.com (10.174.185.226) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 20:50:00 +0800
From:   Wang Xingang <wangxingang5@huawei.com>
To:     <will@kernel.org>, <joro@8bytes.org>
CC:     <bhelgaas@google.com>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>,
        <wangxingang5@huawei.com>
Subject: [PATCH 0/1] iommu/of: Fix request and enable ACS for of_iommu_configure
Date:   Fri, 7 May 2021 12:49:52 +0000
Message-ID: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xingang Wang <wangxingang5@huawei.com>

When request ACS in of_iommu_configure, the pci_acs_init procedure has
already been called. The pci device probe procedure is like the following:
pci_host_common_probe
    pci_device_add
        pci_acs_init
of_iommu_configure
    pci_request_acs

The pci_request_acs() does not work because the pci_acs_init and
pci_enable_acs procedure has already finished, so the ACS is not
enabled as expected.  Besides, the ACS is enabled only if IOMMU is
detected and the device is pci.

So this fix 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core
when configuring IOMMU linkage"), add pci_enable_acs() and IOMMU check
to make sure ACS is enabled for the pci_device.

Xingang Wang (1):
  iommu/of: Fix request and enable ACS for of_iommu_configure

 drivers/iommu/of_iommu.c | 10 +++++++++-
 drivers/pci/pci.c        |  2 +-
 include/linux/pci.h      |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.19.1

