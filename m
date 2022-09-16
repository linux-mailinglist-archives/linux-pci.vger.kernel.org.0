Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA585BA75B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIPHU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIPHU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 03:20:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7627E419A9
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 00:20:25 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTQQf2jYwzBsQQ
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 15:18:18 +0800 (CST)
Received: from [10.174.179.39] (10.174.179.39) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 15:20:22 +0800
From:   "zhangjialin (F)" <zhangjialin11@huawei.com>
Subject: [Question] AB-BA deadlock between reset_lock and device_lock
To:     <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <zhangjialin11@huawei.com>
Message-ID: <ed831249-384a-6d35-0831-70af191e9bce@huawei.com>
Date:   Fri, 16 Sep 2022 15:19:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.39]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500021.china.huawei.com (7.185.36.109)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Sorry to disturb you. We encountered a deadlock between reset_lock
semaphore and device_lock (dev->mutex) in linux-4.19.

After some searching, we found the fix you suggested about the same
question [1]. We wonder if there are new versions of this patch?
If so, would you mind submitting it for upstream branch?

[1] https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/

Thanks,
Jialin
