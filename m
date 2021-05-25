Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F7390632
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhEYQIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 12:08:37 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38082 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhEYQIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 12:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=bMSykNOnDrSLzZd4YGTT1jegBxJN7hV+lKNP/+EU6Bs=; b=ZV7bE1VoOTfh29nV8f+IWLNpHH
        7NBxywppA1+TujQvojfjR3FJK56qyxhztVFSBHJx5GkV7FM0enFX/sxYSHAm5gA+uJjZsPiihHtCe
        AFXZ1PLt40YXMQdzeC32y6fooeFW+T3m6s/O87jvrHqniT+BGrB2XlrAzli6jlAe22wDuQKo/ZwKs
        judkqf+JR9srivAIre9jhdfLWL1ZgT+B91fMeGoRB4Yw4RyLaawR0KLrlim+PJy4QXHN4f6tj06kM
        02SOkyvXhxFXo2VJEzJo019qja42QH12MVG6M2YWtItfunnA0rlBkt88VQCFwqxPGCfc/ZnbKHRiv
        uS9uvuog==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1llZaD-00067f-9u; Tue, 25 May 2021 10:07:06 -0600
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
References: <20210524211430.GA1123248@bjorn-Precision-5520>
 <20210524211934.GA1124194@bjorn-Precision-5520>
 <20210525103257.GB48588@rocinante.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bc72df8b-f652-e88a-fcd6-bbf3c8fb184d@deltatee.com>
Date:   Tue, 25 May 2021 10:07:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525103257.GB48588@rocinante.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, wangxiongfeng2@huawei.com, vidyas@nvidia.com, kurt.schwemmer@microsemi.com, ruscur@russell.cc, tyreld@linux.ibm.com, paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au, oohall@gmail.com, joe@perches.com, bhelgaas@google.com, helgaas@kernel.org, kw@linux.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 03/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-25 4:32 a.m., Krzysztof Wilczyński wrote:
> Hi Bjorn,
> 
> [...]
>>> I really like this, but I would like it even better if the
>>> sysfs_emit() change were easier to review.
>>>
>>> It seems pointless that the current code uses strlen() when
>>> scnprintf() and dsm_label_utf16s_to_utf8s() both have that
>>> information and we just throw it away.
>>>
>>> I think it should be possible to split the len and
>>> dsm_label_utf16s_to_utf8s() changes to a separate patch, which would
>>> remove the need for the strlen, and then the conversion to
>>> sysfs_emit() would be completely trivial like all the rest of them.
>>>
>>> My goal is to make all the sysfs_emit() changes look almost
>>> mechanical, with the non-trivial parts separated out.
>>
>> And BTW, when all the sysfs_emit() changes are trivial like that, I
>> would probably squash them all into one patch that converts all of
>> drivers/pci/ at once.
>>
>> That would still leave a few separate patches:
>>
>>   - This dsm_label_utf16s_to_utf8s() change
>>   - The resource_alignment newline change
>>   - The devspec_show newline change
>>   - The driver_override change
> 
> Got it!  I will send v4 updated as per the above suggestion.  Also, if
> Logan does not mind, I will carry his "Reviewed-by" over as there will
> be no changes to the actual code, just how the patch will be arranged.

Yup, I'm good with that. Still looks fine by me.

Logan

