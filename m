Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEC2FF155
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbhAURF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 12:05:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732032AbhAURFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 12:05:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10LH1U3t110545;
        Thu, 21 Jan 2021 12:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=91HdZqAOvQz1z9I0C/iZ1oOw1Qmk4nObYmd0w2BsZZc=;
 b=CAAOkhQ2992mKG/7hCiR9M2f7ly1/OnHS9cFPF24+ZTs4YYo3d966sOlFfUNTWub7Afg
 GysmDGMJHoQKz7zkd4HNKm/jxiwhfQmKsrr9L7khhOvD+OQNri+zF+bfDHvo9ms75Be9
 ryAWKNSYe6vJ6rL5ccN/E+XrUSFkoZV9AUDjpU70ESDgwzUQkl3KaH1grbzLWH1HZ/zE
 IL5jAGsDI0TA/fn6sA0sD/FVwNDpIb6zNKH+vDkq8QJ6IYk7pD3DiBqsSN8bjvjlbqif
 9pPqaJbD5KAQdAcnin+zqCcsoxKt72dGebN0EY24v+dBp0kTVjhT2Gck1+niiioBiKGv YQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 367cwmshpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 12:04:57 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10LGld4D017962;
        Thu, 21 Jan 2021 17:04:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3668nwsugm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 17:04:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10LH4r8534275796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 17:04:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A16152050;
        Thu, 21 Jan 2021 17:04:53 +0000 (GMT)
Received: from [9.145.88.16] (unknown [9.145.88.16])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8726D52051;
        Thu, 21 Jan 2021 17:04:52 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210121155445.GA2657778@bjorn-Precision-5520>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <ae24ccfb-9fb6-5fad-8495-538fab95066e@linux.ibm.com>
Date:   Thu, 21 Jan 2021 18:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210121155445.GA2657778@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_09:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210089
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/21/21 4:54 PM, Bjorn Helgaas wrote:
> [Greg may be able to help compare/contrast this s390 UID with udev
> persistent names]
> 
> On Thu, Jan 21, 2021 at 04:31:55PM +0100, Niklas Schnelle wrote:
>> On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
>>> On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
>>>> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
>>>>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>>>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>>>> ... snip ...
>>>>
>>>>>
>>>>>> 	if (!zpci_global_kset)
>>>>>> 		return -ENOMEM;
>>>>>>
>>>>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
>>>>>
>>>>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
>>>>> that's usually a huge clue that you are doing something wrong.
>>>>>
>>>>> Try the above again, with a simple attribute group, and name for it, and
>>>>> it should "just work".
>>>>
>>>> I'm probably missing something but I don't get how this could work
>>>> in this case. If I'm seeing this right the default attribute group
>>>> here is pci_bus_type.bus_groups and that is already set in
>>>> drivers/pci/pci-driver.c so I don't think I should set that.
>>>>
>>>> I did however find bus_create_file() which does work when using the
>>>> path /sys/bus/pci/uid_checking instead. This would work for us if
>>>> Bjorn is okay with that path and the code is really clean and simple
>>>> too.
>>>>
>>>> That said, I think we could also add something like
>>>> bus_create_group().  Then we could use that to also clean up
>>>> drivers/pci/slot.c:pci_slot_init() and get the original path
>>>> /sys/bus/pci/zpci/uid_checking.
>>>
>>> I don't think "uid_checking" is quite the right name.  It says
>>> something about the *implementation*, but it doesn't convey what that
>>> *means* to userspace.  IIUC this file tells userspace something about
>>> whether a given PCI device always has the same PCI domain/bus/dev/fn
>>> address (or maybe just the same domain?)
>>>
>>> It sounds like this feature could be useful beyond just s390, and
>>> other arches might implement it differently, without the UID concept.
>>> If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
>>> the name is not s390-specific (and "uid" sounds s390-specific).
>>>
>>> I assume it would also help with the udev/systemd end if you could
>>> make this less s390 dependent.
>>
>> I've thought about this more and even implemented a proof of concept
>> patch for a global attribute using a pcibios_has_reproducible_addressing()
>> hook. 
>>
>> However after implementing it I think as a more general and
>> future proof concept it makes more sense to do this as a per device
>> attribute, maybe as another flag in "stuct pci_dev" named something
>> like "reliable_address". My reasoning behind this can be best be seen
>> with a QEMU example. While I expect that QEMU can easily guarantee
>> that one can always use "0000:01:00.0" for a virtio-pci NIC and
>> thus enp1s0 interface name, the same might be harder to guarantee
>> for a SR-IOV VF passed through with vfio-pci in that same VM and
>> even less so if a thunderbolt controller is passed through and
>> enumeration may depend on daisy chaining. The QEMU example
>> also applies to s390 and maybe others will in the future.
> 
> I'm a little wary of using the PCI geographical address
> ("0000:01:00.0") as a stable name.  Even if you can make a way to use
> that to identify a specific device instance, regardless of how it is
> plugged in or passed through, it sounds like we could end up with
> "physical PCI addresses" and "virtual PCI addresses" that look the
> same and would cause confusion.
> 
> This concept sounds similar to the udev concept of a "persistent
> device name".  What advantages does this s390 UID have over the udev
> approach?
> 
> There are optional PCI device serial numbers that we currently don't
> really make use of.  Would that be a generic way to help with this?
> 

As far as I understand systemd/udev uses the PCI geographical address
by default ("enP<domain>p<bus>s<hotplug_slot_idx>...") for PCI attached
network interfaces in many cases and a lot of users have already built
their firewall/routing rules on these.

At the same time as you said this isn't ideal. On s390 things are a
bit special since it's either really unstable, if UID Checking
is not enforced (the value I wanted to expose is 0) the domain
part and thus the interface name may change between reboots.
On the other hand when it is enforced, the Domain can be defined
in the machine configuration (IOCDS, think Domain XML but formatted
for punch cards) and the bus is always 00.
The PCI geographical address and thus network interface names are then
stable in the same way as with our CCW attached network interfaces where
the CCW addresses have been stable for a long time and are regularly
used for configuration. The interface would however still conform to
the existing systemd/udev standard theme so the only change the user
sees is that we would prefer the interface naming scheme which
does not include the hotplug slot index (ehotplug slot indices are unique
in the machine hypervisor and thus can't be the same in to guests
on the same machine). We would thus not add a new name at all and
thanks to the altname mechanism all existing rules including
persistent naming via manual udev rules would keep working.

Now taking this beyond s390 my idea is that under some circumstances
just as with UID Uniqueness for us, the platform can tell if a PCI
geographical address is a reliable identifier thus sytemd/udev
has more information about the quality of existing naming schemes
incorporating information from the geographical address.

Looking at my personal KVM guests (Ubuntu, Arch Linux, Ubuntu ARM64)
as well as my workstation (Arch Linux) all of them use a scheme
with parts of the geographical address.

So in essence my idea is all about either choosing the best existing
default name or making sure we at least know if it may not be reliable.

I hope that makes sense and I have added Lennart Poettering
as he's the one everyone likes to blame for these names or at
least can probably tell me what I missed.

Best,
Niklas
