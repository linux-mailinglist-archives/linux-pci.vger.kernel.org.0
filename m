Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B83D316B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhGWBPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 21:15:37 -0400
Received: from mx21.baidu.com ([220.181.3.85]:58340 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230318AbhGWBPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 21:15:37 -0400
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
        by Forcepoint Email with ESMTPS id 3550B4C274F9BF6F3B13;
        Fri, 23 Jul 2021 09:56:09 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 23 Jul 2021 09:56:08 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 09:56:08 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <bhelgaas@google.com>, <jonathan.derrick@intel.com>,
        <kw@linux.com>, <lorenzo.pieralisi@arm.com>, <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2 0/2] PCI: Make use of PCI_DEVICE_XXX() helper function
Date:   Fri, 23 Jul 2021 09:55:57 +0800
Message-ID: <20210723015559.695-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Could make use of PCI_DEVICE_XXX() helper function

Cai Huoqing (2):
  PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
  PCI: vmd: Make use of PCI_DEVICE_DATA() helper function

 drivers/pci/controller/vmd.c      | 38 +++++++++++++++----------------
 drivers/pci/hotplug/cpqphp_core.c | 13 ++---------
 drivers/pci/search.c              | 14 ++----------
 include/linux/pci_ids.h           |  2 ++
 4 files changed, 25 insertions(+), 42 deletions(-)

-- 
2.25.1

