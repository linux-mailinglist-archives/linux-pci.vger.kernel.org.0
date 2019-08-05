Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC77819AF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfHEMnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 08:43:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:58826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728870AbfHEMnU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:20 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id DCF5B1ACE30B50EF7388;
        Mon,  5 Aug 2019 20:43:18 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 5 Aug 2019 20:43:10 +0800
Received: from [127.0.0.1] (10.40.49.11) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 5
 Aug 2019 20:43:10 +0800
Subject: Re: Bug report: AER driver deadlock
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
 <20190625171639.GA103694@google.com>
From:   "Fangjian (Turing)" <f.fangjian@huawei.com>
Message-ID: <7b181647-3158-2a79-c6ca-d81056625fc8@huawei.com>
Date:   Mon, 5 Aug 2019 20:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190625171639.GA103694@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kindly Ping...



Best Regards,
Jay

On 2019/6/26 1:16, Bjorn Helgaas wrote:
> On Tue, Jun 04, 2019 at 11:25:44AM +0800, Fangjian (Turing) wrote:
>> Hi, We met a deadlock triggered by a NONFATAL AER event during a sysfs
>> "sriov_numvfs" operation. Any suggestion to fix such deadlock ?
> 
> Here's a bugzilla report for this; please reference it and this email
> thread in any patches to fix it:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=203981
> 
> .
> 

