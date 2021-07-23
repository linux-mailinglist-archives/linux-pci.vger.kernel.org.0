Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631BE3D3243
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 05:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhGWCzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 22:55:54 -0400
Received: from mx21.baidu.com ([220.181.3.85]:37624 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233612AbhGWCzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 22:55:53 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id 54C61CC6DD851F5524AF;
        Fri, 23 Jul 2021 11:36:26 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:26 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:25 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <kw@linux.com>, <bhelgaas@google.com>,
        <jonathan.derrick@intel.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v3 0/2] PCI: Make use of PCI_DEVICE_XXX() helper macro
Date:   Fri, 23 Jul 2021 11:36:16 +0800
Message-ID: <20210723033618.1025-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Could make use of PCI_DEVICE_XXX() helper macro

v1->v2: *fix extra indent for git-apply failure

v2->v3: *update the subject line from "function" to "macro"
	*add changelog to commit message

commit date: 7-23-2021 11:00

Cai Huoqing (2):
  PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper macro
  PCI: vmd: Make use of PCI_DEVICE_DATA() helper macro

 drivers/pci/controller/vmd.c      | 38 +++++++++++++++----------------
 drivers/pci/hotplug/cpqphp_core.c | 13 ++---------
 drivers/pci/search.c              | 14 ++----------
 include/linux/pci_ids.h           |  2 ++
 4 files changed, 25 insertions(+), 42 deletions(-)

-- 
2.25.1

