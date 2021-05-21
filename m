Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677F238CA40
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhEUPgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 11:36:10 -0400
Received: from ale.deltatee.com ([204.191.154.188]:34770 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhEUPgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 11:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=5osgiyoJSua/C3Ot9VDmDizFioxQiLgD/6PyuDPB/Cs=; b=ijZVsYc5TqkTI3cCkwCU8wljnU
        S/FknVxTYQjj8E+022tSo1g/sJqzOtL5QulDN9xL3DG+6jFvEgWbV+NDVjSxe7fOnyxJntODB17u1
        9o1FOdXCZGaLgtNsJs6vKXBsOd5uzl4Guy+Q8HHf7PAXxYj6o87qdTnIHCfQZe4ZGW6rWRJDNEb5W
        iX8EwquFci/wRv6IS5YaY2VWEXSvAdMX4zWNynf8OvfxLb+2PJPx+vDElpWC8Itk+dnO1aXwnnDXE
        yCAXmmOvvfb2V7XVpZbVxmZNmoImjqSFxrSNyQX9k0qc3VGiJQOd6XLOYZzbJ1qP36oSCKPnLMNA4
        ts9dnJ/Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lk7Aj-0005Vv-W4; Fri, 21 May 2021 09:34:46 -0600
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
References: <20210518034109.158450-1-kw@linux.com>
 <20210518034109.158450-12-kw@linux.com>
 <20210521151443.GB39346@rocinante.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <050c9f5c-5260-9546-bdb9-b5e6ac12e8dc@deltatee.com>
Date:   Fri, 21 May 2021 09:34:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521151443.GB39346@rocinante.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org, wangxiongfeng2@huawei.com, vidyas@nvidia.com, kurt.schwemmer@microsemi.com, ruscur@russell.cc, tyreld@linux.ibm.com, paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au, oohall@gmail.com, joe@perches.com, bhelgaas@google.com, kw@linux.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_OFFER,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 12/14] PCI: Fix trailing newline handling of
 resource_alignment_param
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-21 9:14 a.m., Krzysztof Wilczyński wrote:
> [+cc Greg and Sasha for visibility]
> 
> Hi Bjorn and Logan,
> 
> [...]
>> Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
> [...]
> 
> This probably would be a candidate for a back-port to stable and
> long-term releases.  But, since the move to sysfs_emit()/sysfs_emit_at()
> would be then irrelevant, I can split this patch so that it fixes the
> issue first, and then other patch will move it to sysfs_emit(), so that
> it would be easier to apply when back-porting.
> 
> Would this be fine with you Logan?  Especially since you already offered
> your review.  I think Bjorn wouldn't mind the split either.

Totally fine by me. I can re-review the two patches if you like.

Thanks,

Logan
