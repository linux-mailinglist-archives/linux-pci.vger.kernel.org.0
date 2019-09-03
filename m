Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B17A6AD8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfICOJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 10:09:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfICOJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 10:09:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50AF157CBA547659F7F6;
        Tue,  3 Sep 2019 22:09:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 22:09:41 +0800
From:   John Garry <john.garry@huawei.com>
Subject: PCI/kernel msi code vs GIC ITS driver conflict?
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
Date:   Tue, 3 Sep 2019 15:09:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc, Bjorn, Thomas,

We've come across a conflict with the kernel/pci msi code and GIC ITS 
driver on our arm64 system, whereby we can't unbind and re-bind a PCI 
device driver under special conditions. I'll explain...

Our PCI device support 32 MSIs. The driver attempts to allocate msi 
vectors with min msi=17, max msi = 32, and affd.pre vectors = 16. For 
our test we make nr_cpus = 1 (just anything less than 16).

We find that the pci/kernel msi code gives us 17 vectors, but the GIC 
ITS code reserves 32 lpi maps in its_irq_domain_alloc(). The problem 
then occurs when unbinding the driver in its_irq_domain_free() call, 
where we only clear bits for 17 vectors. So if we unbind the driver and 
then attempt to bind again, it fails.

Where the fault lies, I can't say. Maybe the kernel msi code should 
always give power of 2 vectors - as I understand, the PCI spec mandates 
this. Or maybe the GIC ITS driver has a problem in the free path, as 
above. Or maybe the PCI driver should not be allowed to request !power 
of 2 min/max vectors.

Opinion?

Thanks in advance,
John

