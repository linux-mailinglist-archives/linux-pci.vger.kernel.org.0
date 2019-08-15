Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1798EE5D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfHOOhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 10:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22767 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbfHOOhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 10:37:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ABABCF22;
        Thu, 15 Aug 2019 14:37:15 +0000 (UTC)
Received: from [10.3.117.107] (ovpn-117-107.phx2.redhat.com [10.3.117.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42E0760CC0;
        Thu, 15 Aug 2019 14:37:14 +0000 (UTC)
Subject: Re: [Linux-kernel-mentees] [PATCH v2 2/3] PCI: sysfs: Change
 permissions from symbolic to octal
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-3-skunberg.kelsey@gmail.com>
 <20190814053846.GA253360@google.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <b4c0d5b4-7243-ba96-96d1-041a264ac499@redhat.com>
Date:   Thu, 15 Aug 2019 10:37:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190814053846.GA253360@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 15 Aug 2019 14:37:15 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/14/2019 01:38 AM, Bjorn Helgaas wrote:
> [+cc Bodong, Don, Greg for permission question]
> 
> On Tue, Aug 13, 2019 at 02:45:12PM -0600, Kelsey Skunberg wrote:
>> Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
>> preferred and octal permissions should be used instead. Change all
>> symbolic permissions to octal permissions.
>>
>> Example of old:
>>
>> "(S_IWUSR | S_IWGRP)"
>>
>> Example of new:
>>
>> "0220"
> 
> 
>>   static DEVICE_ATTR_RO(sriov_totalvfs);
>> -static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
>> -				  sriov_numvfs_show, sriov_numvfs_store);
>> +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
>>   static DEVICE_ATTR_RO(sriov_offset);
>>   static DEVICE_ATTR_RO(sriov_stride);
>>   static DEVICE_ATTR_RO(sriov_vf_device);
>> -static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
>> -		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
>> +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
>> +		   sriov_drivers_autoprobe_store);
> 
> Greg noticed that sriov_numvfs and sriov_drivers_autoprobe have
> "unusual" permissions.  These were added by:
> 
>    0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
>    1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> Kelsey's patch correctly preserves the existing permissions, but we
> should double-check that they are the permissions they want, and
> possibly add a comment about why they're different from the rest.
> 
> Bjorn
> 
The rest being? ... 0644 vs 0664 ?
The file is read & written, thus the (first) 6; I'll have to dig through very old (7 yr) notes to see if the second 6 is needed for libvirt (so it doesn't have to be root to enable).

-dd

