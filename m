Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F77725EF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjHGNhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 09:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHGNhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:37:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6895
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 06:37:30 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKHN75kRLztRyD;
        Mon,  7 Aug 2023 21:33:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:37:26 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <alyssa@rosenzweig.io>, <maz@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <mahesh@linux.ibm.com>, <oohall@gmail.com>
CC:     <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <yangyingliang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 0/3] PCI: Use pci_dev_id() to simplify the code
Date:   Mon, 7 Aug 2023 21:48:55 +0800
Message-ID: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code and make the code more readable.

Xiongfeng Wang (3):
  PCI: apple: use pci_dev_id() to simplify the code
  PCI/AER: Use pci_dev_id() to simplify the code
  PCI/IOV: Use pci_dev_id() to simplify the code

 drivers/pci/controller/pcie-apple.c | 4 ++--
 drivers/pci/iov.c                   | 3 +--
 drivers/pci/pcie/aer.c              | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.20.1

