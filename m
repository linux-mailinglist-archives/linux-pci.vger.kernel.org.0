Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5647917F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhLQQan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 11:30:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4305 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLQQam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 11:30:42 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JFvVs4yb0z67gb0;
        Sat, 18 Dec 2021 00:26:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 17:30:40 +0100
Received: from [10.47.26.158] (10.47.26.158) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 17 Dec
 2021 16:30:39 +0000
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
 <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
 <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
 <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
 <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
 <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
 <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
 <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
 <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
 <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d45ee18a-1faa-9c56-071d-18f5737d225c@huawei.com>
Date:   Fri, 17 Dec 2021 16:30:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.158]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/12/2021 15:55, Arnd Bergmann wrote:
>> > If you have a better way of finding the affected drivers,
>>   > that would be great.
>>
>> Assuming arm64 should select HAS_IOPORT, I am talking about f71805f as
>> an example. According to that patch, this driver additionally depends on
>> HAS_IOPORT; however I would rather arm64, like powerpc, should not allow
>> that driver to be built at all.
> Agreed, I missed these when I looked through the HAS_IOPORT users,
> that's why I suggested to split up that part of the patch per subsystem
> so they can be inspected more carefully.

ok

 >
 > My feeling is that in this case we want some other dependency, e.g. a
 > new CONFIG_LPC. It should actually be possible to use this driver on
 > any machine with an LPC bus, which would by definition be the primary
 > I/O space, so it should be possible to load it on Arm64.

You did suggest HARDCODED_IOPORT earlier in this thread, and the 
definition/premise there seemed sensible to me.

Anyway it seems practical to make all these changes in a single series, 
so need a way forward as Niklas has no such changes for this additional 
kconfig option.

As a start, may I suggest we at least have Niklas' patch committed to a 
dev branch based on -next or latest mainline release for further analysis?

Thanks,
John


