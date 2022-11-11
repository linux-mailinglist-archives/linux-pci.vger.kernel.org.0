Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB6625CFC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiKKO1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKO1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:27:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA8C1;
        Fri, 11 Nov 2022 06:27:28 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N81Cg3gHNzbnfm;
        Fri, 11 Nov 2022 22:23:43 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:27:25 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [RFC 0/4] pci/sriov: support VFs dynamic addition
Date:   Fri, 11 Nov 2022 22:27:18 +0800
Message-ID: <20221111142722.1172-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
this operation needs to spend lots of time if there has a large amount of VFs.      
                                                            
For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
concurrently would cost about 200-250ms. However most of them are not need to be
used at the moment, so we can enable SRIOV first but add VFs on demand.

This series introduces two interfaces:
1. sriov_numvfs_no_scan: enable SRIOV without add the VFs.
2. sriov_scan_vf_id: add a specific VF.

Longpeng (4):
  pci/sriov: extract sriov_numvfs common helper
  pci/sriov: add vf_bitmap to mark the vf id allocation
  pci/sriov: add sriov_numfs_no_scan interface
  pci/sriov: add sriov_scan_vf_id interface

 drivers/pci/iov.c | 162 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.h |   1 +
 2 files changed, 148 insertions(+), 15 deletions(-)

-- 
2.23.0

