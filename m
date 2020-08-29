Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE42256733
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH2LoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 07:44:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbgH2Li5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Aug 2020 07:38:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48A1753D649A8990E617;
        Sat, 29 Aug 2020 19:22:31 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 29 Aug 2020 19:22:20 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 0/2] lspci: Decode 10-Bit Tag Requester Enable
Date:   Sat, 29 Aug 2020 18:58:40 +0800
Message-ID: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is to:
1. Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition to keep the
same style between the Linux kernel source [1] and lspci.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651

2. Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.

Dongdong Liu (2):
  lspci: Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition
  lspci: Decode 10-Bit Tag Requester Enable

 lib/header.h | 27 +++++++++++++++------------
 ls-caps.c    | 23 ++++++++++++-----------
 2 files changed, 27 insertions(+), 23 deletions(-)

--
1.9.1

