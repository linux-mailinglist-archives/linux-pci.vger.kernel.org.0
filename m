Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108453FE94C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbhIBGiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 02:38:12 -0400
Received: from mx20.baidu.com ([111.202.115.85]:35676 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233101AbhIBGiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 02:38:09 -0400
Received: from BJHW-Mail-Ex05.internal.baidu.com (unknown [10.127.64.15])
        by Forcepoint Email with ESMTPS id 78F6DC384F3776F3EF11;
        Thu,  2 Sep 2021 14:37:09 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:09 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:37:08 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <patrice.chotard@foss.st.com>, <mchehab@kernel.org>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2 0/3] drivers: Add the helper function devm_platform_get_and_ioremap_resource_byname()
Date:   Thu, 2 Sep 2021 14:36:59 +0800
Message-ID: <20210902063702.32066-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex28.internal.baidu.com (172.31.51.22) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex05_2021-09-02 14:37:09:472
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since provide the helper function devm_platform_ioremap_resource_byname()
which is wrap platform_get_resource_byname() and devm_ioremap_resource().
But sometimes, many drivers still need to use the resource variables obtained
by platform_get_resource(). In these case, provide this helper function
devm_platform_get_and_ioremap_resource_byname().

devm_platform_get_and_ioremap_resource_byname will be used:
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   |  7 ++---
 drivers/pci/controller/pcie-mediatek-gen3.c   |  5 +---


Cai Huoqing (3):
  driver core: platform: Add the helper function
    devm_platform_get_and_ioremap_resource_byname()
  media: sti/c8sectpfe: Make use of the helper function
    devm_platform_get_and_ioremap_resource_byname()
  PCI: mediatek-gen3: Make use of the helper function
    devm_platform_get_and_ioremap_resource_byname()

 drivers/base/platform.c                       | 30 ++++++++++++++++---
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   |  7 ++---
 drivers/pci/controller/pcie-mediatek-gen3.c   |  5 +---
 include/linux/platform_device.h               |  3 ++
 4 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.25.1

