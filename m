Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A769D0336
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJHWGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 18:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJHWGs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 18:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDCE110CC1E9;
        Tue,  8 Oct 2019 22:06:47 +0000 (UTC)
Received: from [10.3.117.216] (ovpn-117-216.phx2.redhat.com [10.3.117.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE8535D71C;
        Tue,  8 Oct 2019 22:06:46 +0000 (UTC)
Subject: Re: [PATCH] PCI/IOV: update num_VFs earlier
To:     Bjorn Helgaas <helgaas@kernel.org>,
        CREGUT Pierre IMT/OLN <pierre.cregut@orange.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20191008213835.GA230403@google.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <4ac38c7a-b8d4-9a1c-10ab-ce8b4cf2991f@redhat.com>
Date:   Tue, 8 Oct 2019 18:06:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008213835.GA230403@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 08 Oct 2019 22:06:48 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/08/2019 05:38 PM, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 05:10:07PM -0500, Bjorn Helgaas wrote:
>> On Thu, Oct 03, 2019 at 11:04:45AM +0200, CREGUT Pierre IMT/OLN wrote:
>>> ...
> 
>>> NIC drivers send netlink events when their state change, but it is
>>> the core that changes the value of num_vfs. So I would think it is
>>> the core responsibility to make sure the exposed value makes sense
>>> and it would be better to ignore the details of the driver
>>> implementation.
>>
>> Yes, I think you're right.  And I like your previous suggestion of
>> just locking the device in the reader.  I'm not enough of a sysfs
>> expert to know if there's a good reason to avoid a lock there.  Does
>> the following look reasonable to you?
> 
> I applied the patch below to pci/virtualization for v5.5, thanks for
I hope not... see below

> your great patience!
> 
>> commit 0940fc95da45
>> Author: Pierre Crégut <pierre.cregut@orange.com>
>> Date:   Wed Sep 11 09:27:36 2019 +0200
>>
>>      PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes
>>      
>>      When sriov_numvfs is being updated, drivers may notify about new devices
>>      before they are reflected in sriov->num_VFs, so concurrent sysfs reads
>>      previously returned stale values.
>>      
>>      Serialize the sysfs read vs the write so the read returns the correct
>>      num_VFs value.
>>      
>>      Link: https://bugzilla.kernel.org/show_bug.cgi?id=202991
>>      Link: https://lore.kernel.org/r/20190911072736.32091-1-pierre.cregut@orange.com
>>      Signed-off-by: Pierre Crégut <pierre.cregut@orange.com>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index b3f972e8cfed..e77562aabbae 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -254,8 +254,14 @@ static ssize_t sriov_numvfs_show(struct device *dev,
>>   				 char *buf)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> +	u16 num_vfs;
>> +
>> +	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
>> +	device_lock(&pdev->dev);
                ^^^^^ lock
>> +	num_vfs = pdev->sriov->num_VFs;
>> +	device_lock(&pdev->dev);
                ^^^^ and lock again!
>>   
>> -	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
>> +	return sprintf(buf, "%u\n", num_vfs);
>>   }
>>   
>>   /*

