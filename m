Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDEF354AE3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 04:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhDFCdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Apr 2021 22:33:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15910 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhDFCdi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Apr 2021 22:33:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FDs3h2GkbzjYB7;
        Tue,  6 Apr 2021 10:31:44 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 10:33:29 +0800
Subject: Re: [PATCH 2/4] PCI: Enable 10-Bit tag support for PCIe Endpoint
 devices
To:     Christoph Hellwig <hch@infradead.org>
References: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
 <1617440059-2478-3-git-send-email-liudongdong3@huawei.com>
 <20210403095028.GA2082662@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <bb1dc648-c4b8-4cfd-0d73-44a4fc68915e@huawei.com>
Date:   Tue, 6 Apr 2021 10:33:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210403095028.GA2082662@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph

Many Thanks for your review.
On 2021/4/3 17:50, Christoph Hellwig wrote:
>> +	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>> +	if (ret)
>> +		return;
>
> Wouldn't it make sense to store the devcap value in the pci_dev
> structure instead of reading it multiple times?
>
Good suggestion.
>> +	/* 10-Bit Tag Requester Enable in Device Control 2 Register is RsvdP for VF */
>
> Please avoid the overly long lines.

Will fix.
>
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT &&
>> +	    dev->ext_10bit_tag_comp_path == 1 &&
>> +	    (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ)) {
>> +		pci_info(dev, "enabling 10-Bit Tag Requester\n");
>
> I think that printk might become a little too noisy when lots of
> devices support this capability.
>
Yes, How about change to pci_dbg.

>> +	unsigned int	ext_10bit_tag_comp_path:1; /* 10-Bit Tag Completer Supported from root to here */
>
> Another crazy long line.  And why not just name this
> 10bit_tags?

OK, will fix. How about name this _10bit_tag or ext_10bit_tag
as C language variable names cannot start with a number.
>
> Also a lot of this walk the upstream bridges until we hit the
> root port code seems duplicatated for different capabilities.  Shouldn't
> we have one such walk that checks all the interesting capabilities?  Or
> even turn the thing around and set them on the fly while scanning
> the topology?

I will investigate more about this. Thanks for your suggestion.

Thanks,
Dongdong

> .
>
