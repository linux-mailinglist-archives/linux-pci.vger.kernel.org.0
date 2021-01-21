Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F32FEEF8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 16:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbhAUPdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 10:33:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733067AbhAUPcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 10:32:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10LF3PLS038979;
        Thu, 21 Jan 2021 10:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aCElnvwKfbrPxUa8VLjgh4RujJId+/ZPrLbTNpvdxW8=;
 b=j5TST7J6cLGnQUIVKVeV1aacwF0dzyIdrz8sRv0NAxKKsGgJ/dmin27QGX4vquvFTYIz
 b8xrmtTNORABcvDD6RdgJwTJ6/lCF0C5SfdeHJILhvTuJVHe/BZSr+o6bJztz1+ZhdEE
 /1EBPgD4UQRTIK9wjV/q7npiRhnL68CdkOIhi2RYkZhb7RXlxiuUS4k5Z1ZCqBHY8tsV
 WleQeuF1OV92/QGHMAWGGG3rgvpu1rKvZmFalYl1IOARB6NfnktdRqazeqk2NusMOfQe
 yWXnHSMgZSNW4snoEnaw6jNxoIJDGuk8SQW2odYOStsUtZbU9+6tcngNkKPtV9u/WimM sg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 367bc2jep6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 10:32:01 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10LFDEf9009582;
        Thu, 21 Jan 2021 15:31:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3668pj8xcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 15:31:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10LFVugW45809974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 15:31:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B4BA404D;
        Thu, 21 Jan 2021 15:31:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7E89A4040;
        Thu, 21 Jan 2021 15:31:55 +0000 (GMT)
Received: from [9.145.88.16] (unknown [9.145.88.16])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jan 2021 15:31:55 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210115152903.GA2086339@bjorn-Precision-5520>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <1cf42837-bf98-944f-697c-8407a0ebd623@linux.ibm.com>
Date:   Thu, 21 Jan 2021 16:31:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115152903.GA2086339@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_08:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210081
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
> On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
>> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
>>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>> ... snip ...
>>
>>>
>>>> 	if (!zpci_global_kset)
>>>> 		return -ENOMEM;
>>>>
>>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
>>>
>>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
>>> that's usually a huge clue that you are doing something wrong.
>>>
>>> Try the above again, with a simple attribute group, and name for it, and
>>> it should "just work".
>>
>> I'm probably missing something but I don't get how this could work
>> in this case. If I'm seeing this right the default attribute group
>> here is pci_bus_type.bus_groups and that is already set in
>> drivers/pci/pci-driver.c so I don't think I should set that.
>>
>> I did however find bus_create_file() which does work when using the
>> path /sys/bus/pci/uid_checking instead. This would work for us if
>> Bjorn is okay with that path and the code is really clean and simple
>> too.
>>
>> That said, I think we could also add something like
>> bus_create_group().  Then we could use that to also clean up
>> drivers/pci/slot.c:pci_slot_init() and get the original path
>> /sys/bus/pci/zpci/uid_checking.
> 
> I don't think "uid_checking" is quite the right name.  It says
> something about the *implementation*, but it doesn't convey what that
> *means* to userspace.  IIUC this file tells userspace something about
> whether a given PCI device always has the same PCI domain/bus/dev/fn
> address (or maybe just the same domain?)
> 
> It sounds like this feature could be useful beyond just s390, and
> other arches might implement it differently, without the UID concept.
> If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
> the name is not s390-specific (and "uid" sounds s390-specific).
> 
> I assume it would also help with the udev/systemd end if you could
> make this less s390 dependent.
> 
> Bjorn
> 

Hi Bjorn,

I've thought about this more and even implemented a proof of concept
patch for a global attribute using a pcibios_has_reproducible_addressing()
hook. 

However after implementing it I think as a more general and
future proof concept it makes more sense to do this as a per device
attribute, maybe as another flag in "stuct pci_dev" named something
like "reliable_address". My reasoning behind this can be best be seen
with a QEMU example. While I expect that QEMU can easily guarantee
that one can always use "0000:01:00.0" for a virtio-pci NIC and
thus enp1s0 interface name, the same might be harder to guarantee
for a SR-IOV VF passed through with vfio-pci in that same VM and
even less so if a thunderbolt controller is passed through and
enumeration may depend on daisy chaining. The QEMU example
also applies to s390 and maybe others will in the future.
I'll send an RFC for a per device attribute but didn't want to
let this discussion stand as if we had abandoned the idea and if
you would prefer a global attribute I can also send an RFC for that.

Besst regards,
Niklas
