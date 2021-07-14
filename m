Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2B3C7E90
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 08:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNGgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 02:36:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11301 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbhGNGgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 02:36:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GPndx2yCvz8shC
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 14:29:09 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 14:33:37 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 14:33:37 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
Subject: [question]: Query regarding the PCI addresses
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <lijinlin3@huawei.com>
Message-ID: <bb7e27ea-5957-21a0-34b4-5adf517c3546@huawei.com>
Date:   Wed, 14 Jul 2021 14:33:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since linux identify PCI peripheral by [domain:bus:device:function] 
number like following,

# lspci -D
0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
0000:00:01.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
0000:00:02.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub 
PCI Express Root Port 0 (rev 02)
0000:00:02.1 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub 
PCI Express Root Port 0 (rev 02)
0000:00:02.2 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub 
PCI Express Root Port 0 (rev 02)
0000:00:02.3 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub 
PCI Express Root Port 0 (rev 02)
0000:01:00.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
0000:02:01.0 USB controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) 
USB2 EHCI Controller (rev 10)
0000:02:02.0 Unclassified device [00ff]: Virtio: Virtio memory balloon
0000:02:03.0 SCSI storage controller: Virtio: Virtio SCSI
0000:02:04.0 Display controller: Virtio: Virtio GPU (rev 01)
0000:03:00.0 Ethernet controller: Virtio: Virtio network device (rev 01)

Here are my questions: Are these [domain:bus:device:function] number 
come from hardware's
physical connection or allocated by software dynamic? If hardware do not 
change, can we
guarantee these number do not change after system reboot? If they are 
not fixed, then is there
anyway I can get a fixed ID which can indicate physical connection.

Thanks, Hope to get your help.
