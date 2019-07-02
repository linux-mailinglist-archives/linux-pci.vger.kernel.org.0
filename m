Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D95D04C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBNOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 2 Jul 2019 09:14:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfGBNOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 09:14:07 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 691112B14BA1ABE84440;
        Tue,  2 Jul 2019 21:14:04 +0800 (CST)
Received: from dggeme765-chm.china.huawei.com (10.3.19.111) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 21:14:03 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 21:14:03 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1591.008;
 Tue, 2 Jul 2019 21:14:03 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: A question about shpcp.
Thread-Topic: A question about shpcp.
Thread-Index: AdUw1y6s60N5MVYrQQefLwWPyJccGQ==
Date:   Tue, 2 Jul 2019 13:14:03 +0000
Message-ID: <e5bdb5e7d3ad427a913a7e66e750a464@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, July 2, 2019 at 20:21:18PM +0000,  Lukas wrote:
> On Thu, Jun 27, 2019 at 12:16:18PM +0000, linmiaohe wrote:
> > It's very nice of you if you could tell me why is 5*HZ there and if 
> > this delay can be reduced?
>
> According to Table 2-4 of the PCI Standard Hot-Plug Controller and Subsystem Specification, "System software is waiting 5 seconds to provide the user with an opportunity to cancel the hot-plug operation."
> (http://drydkim.com/MyDocuments/PCI%20Spec/specifications/shpc1_0.pdf)
>
> So the reason the delay can't be reduced or removed is because the spec mandates it.
>
> Thanks,
>
> Lukas

Many thanks for explaining this. Thanks a lot.
Have a nice day.
Best wishes.
