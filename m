Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51D51CE62
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388175AbiEFBps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 21:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388101AbiEFBpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 21:45:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AAF62129;
        Thu,  5 May 2022 18:41:27 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvYB84Mk6zGpVF;
        Fri,  6 May 2022 09:38:40 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:41:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:41:22 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <martin.oliveira@eideticom.com>, <thunder.leizhen@huawei.com>,
        <axboe@kernel.dk>, <kch@nvidia.com>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <mcgrof@kernel.org>,
        <jiangguoqing@kylinos.cn>, <jpittman@redhat.com>,
        <dave@stgolabs.net>, <liupeng256@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: [PATCH 0/2] null_blk: fix wrong use of nr_online_nodes
Date:   Fri, 6 May 2022 01:57:59 +0000
Message-ID: <20220506015801.757918-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Helper node_available is introduced to judge whether a node can be
used, and it is used to fix the wrong use of nr_online_nodes when
numa node is sparse.

Peng Liu (2):
  include/linux/nodemask.h: create node_available() helper
  null_blk: fix wrong use of nr_online_nodes

 arch/ia64/hp/common/sba_iommu.c |  2 +-
 arch/x86/pci/acpi.c             |  2 +-
 drivers/acpi/arm64/iort.c       |  2 +-
 drivers/block/null_blk/main.c   | 45 ++++++++++++++++++++-------------
 drivers/pci/pci-sysfs.c         |  2 +-
 include/linux/nodemask.h        |  3 +++
 mm/mempolicy.c                  |  2 +-
 7 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.25.1

