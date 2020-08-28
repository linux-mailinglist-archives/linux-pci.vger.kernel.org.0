Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DE25548E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgH1Gew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 02:34:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgH1Gev (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 02:34:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95984D73A9C96674860A;
        Fri, 28 Aug 2020 14:34:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 14:34:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH 0/2] fix memleak when using pci_iounmap()
Date:   Fri, 28 Aug 2020 14:34:01 +0800
Message-ID: <20200828063403.3995421-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

config GENERIC_IOMAP is not selected on some arch, pci_iounmap()
don't implement, when we using pci_iomap/pci_iounmap, it will
lead to memory leak.
This patch set moves the implemention of pci_iounmap() to
lib/pci_iomap.c to fix this.

Yang Yingliang (2):
  iomap: move some definitions to include/linux/io.h
  pci: fix memleak when calling pci_iomap/unmap()

 include/asm-generic/pci_iomap.h |  2 ++
 include/linux/io.h              | 36 ++++++++++++++++++++++++++
 lib/iomap.c                     | 46 ---------------------------------
 lib/pci_iomap.c                 |  8 ++++++
 4 files changed, 46 insertions(+), 46 deletions(-)

-- 
2.25.1

