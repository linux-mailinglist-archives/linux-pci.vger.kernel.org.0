Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72B3D22BC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhGVKta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 06:49:30 -0400
Received: from mx21.baidu.com ([220.181.3.85]:59582 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231585AbhGVKta (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 06:49:30 -0400
Received: from BC-Mail-Ex15.internal.baidu.com (unknown [172.31.51.55])
        by Forcepoint Email with ESMTPS id BA5588E307F8FBA3AC07;
        Thu, 22 Jul 2021 19:30:00 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex15.internal.baidu.com (172.31.51.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 22 Jul 2021 19:30:00 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 22 Jul 2021 19:30:00 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jonathan.derrick@intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 0/2] PCI: Make use of PCI_DEVICE_XXX() helper function
Date:   Thu, 22 Jul 2021 19:29:52 +0800
Message-ID: <20210722112954.477-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex30.internal.baidu.com (172.31.51.24) To
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

