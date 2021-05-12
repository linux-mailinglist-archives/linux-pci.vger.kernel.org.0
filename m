Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB237B6DC
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELHaP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 03:30:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2636 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:30:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg5tH6RkVzQlRn;
        Wed, 12 May 2021 15:25:43 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 15:29:03 +0800
Subject: Re: [PATCH V2 1/5] PCI: Use cached Device Capabilities 2 Register
To:     Christoph Hellwig <hch@infradead.org>
References: <1620745744-91316-1-git-send-email-liudongdong3@huawei.com>
 <1620745744-91316-2-git-send-email-liudongdong3@huawei.com>
 <YJqiEAoxcCkVAEsK@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <9119e466-e153-52b2-051a-bdb17081872b@huawei.com>
Date:   Wed, 12 May 2021 15:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YJqiEAoxcCkVAEsK@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph
Many thanks for your review.
On 2021/5/11 23:26, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 11:09:00PM +0800, Dongdong Liu wrote:
>> It will make sense to store the devcap2 value in the pci_dev structure
>> instead of reading Device Capabilities 2 Register multiple times.
>> So we add pci_init_devcap2() to get the value of devcap2, then use
>> cached devcap2 in the needed place.
>
> This looks sensible.  Should the devcap field maybe grow a pcie_
> prefix?
Yes, It will be good to use pcie_prefix.
> What about caching PCI_EXP_DEVCAP as well while you're at it?
Make sense, will do.

Thanks,
Dongdong
>
