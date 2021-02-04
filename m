Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882BF30F548
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 15:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhBDOmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 09:42:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236886AbhBDOm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 09:42:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114EZBGp024022;
        Thu, 4 Feb 2021 09:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JKjQmFsAW2neqppkMppeLkt8OZRHfO/VIL0sG/T7MEc=;
 b=hZs1eax9HxlNub5KpsftgE+JKK6k7QwL01uu77sibtAMW8DZsxUNvjFP0wy1Pbz3gS8G
 F8NY4LQN5cHSWh8WK5ExDNlAf/tso+kbP1co/B5NbqA1UzCnZ919STgH35ou5meywJGy
 QPZhkygxIdnO76nhNjXrxgQ6a5JwAX6+tf9oVpx0XvJV5a4bKhHEiVbV1zUbHSgPW00P
 4AS0Lm7PlG7h3A17Nr0Hj1Zc9SapNB5nCmgPdaB56ZcFeFOESHp7Eie8RHxq3rETlOgy
 ABEGaRYzIy99l8gMiB7rEMNrXAtbdENW4SVe7fdzv2YFzeYEW1Dtz6u2pGEtjNYPHBaF TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gjfyh0fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 09:41:35 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114EZU68025439;
        Thu, 4 Feb 2021 09:41:35 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gjfyh0eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 09:41:35 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114EXvao003762;
        Thu, 4 Feb 2021 14:41:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 36cy38amc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 14:41:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114EfU6e44892644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 14:41:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 623CAA4051;
        Thu,  4 Feb 2021 14:41:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDBAAA4040;
        Thu,  4 Feb 2021 14:41:29 +0000 (GMT)
Received: from [9.145.50.6] (unknown [9.145.50.6])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 14:41:29 +0000 (GMT)
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com> <YBvPBD+fCtQkCFFD@kroah.com>
 <7b85c218-88a4-b6db-e5de-7004475564ee@linux.ibm.com>
 <YBv45HFPe109GT9e@kroah.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <7631ff35-ef7d-dff7-2295-69f8fb96238c@linux.ibm.com>
Date:   Thu, 4 Feb 2021 15:41:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBv45HFPe109GT9e@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_07:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040090
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/4/21 2:38 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 04, 2021 at 01:02:51PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 2/4/21 11:40 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
>>>> The global UID uniqueness attribute exposes whether the platform
>>>> guarantees that the user-defined per-device UID attribute values
>>>> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
>>>> a global identifier for the associated PCI device. With this commit
>>>> it is exposed at /sys/bus/pci/zpci/unique_uids
>>>>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>>>>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>>>>  2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>>>> index 25c9c39770c6..812dd9d3f80d 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>>>> @@ -375,3 +375,12 @@ Description:
>>>>  		The value comes from the PCI kernel device state and can be one
>>>>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>>>>  		The file is read only.
>>>> +What:		/sys/bus/pci/zpci/unique_uids
>>>
>>> No blank line before this new line?
>>
>> Good catch, thanks!
>>
>>>
>>> And why "zpci"?
>>
>> There doesn't seem to be a precedent for arch specific attributes under
>> /sys/bus/pci so I went with a separate group for the RFC.
> 
> Why?  There's nothing arch-specific here, right?  Either the file is
> present or not.

Good point, will change this to /sys/bus/pci/unique_uids

> 
>> "zpci" since that's what we've been calling the s390 specific PCI.
>> I'm not attached to that name or having a separate group, from
>> my perspective /sys/bus/pci/unique_uids would actually be ideal
>> if Bjorn is okay with that, we don't currently foresee any additional
>> global attributes and no one else seems to have them but
>> one never knows and a separate group would then of course,
>> well group them.
> 
> Why not just a simple file, no need for arch-specific names if this
> really can show up under other arches?

I guess other arches would be free to implement the same UID concept
as above I'm happy to change this to a simple file.

> 
>>>> +Date:		February 2021
>>>> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
>>>> +Description:
>>>> +		This attribute exposes the global state of UID Uniqueness on an
>>>> +		s390 Linux system. If this file contains '1' the per-device UID
>>>> +		attribute is guaranteed to provide a unique user defined
>>>> +		identifier for that PCI device. If this file contains '0' UIDs
>>>> +		may collide and do not provide a unique identifier.
>>>
>>> What are they "colliding" with?  And where does the UID come from, the
>>> device itself or somewhere else?
>>
>> If this attribute is 0 multiple PCI devices seen by Linux may have the same UID i.e.
>> they may collide with each other on the same Linux instance.
> 
> So can't userspace figure this out on its own?

Userspace can figure out that they do not currently collide but
without this attribute it doesn't know that the platform also guarantees
that no collision will be introduced by e.g. hotplug. We are however
pushing to have this always turned on so yes over time this attribute
will hopefully be always 1 but this will take years.

> 
>> The
>> UIDs are exposed under /sys/bus/pci/devices/<dev>/uid. Even if the attribute is 1
>> multiple Linux instances will often see the same UID. The main use case
>> we currently envision is naming PCI based network interfaces "eno<UID>"
>> which of course only works if the UIDs are unique for that Linux.
>> On the same mainframe multiple Linux instances may then e.g. use the same
>> UID for VFs from the same physical PCI network card or different cards
>> but the same physical network all defined by an administrator/management
>> system.
>>
>> The UIDs come from the platform/firmware/hypervisor and are provided
>> for each device by the CLP List PCI Functions "instruction" that is used
>> on s390x where an OS can't probe the physical PCI bus but instead
>> that is done by firmware. On QEMU/KVM they can be set on the QEMU cli,
>> on our machine hypervisor they are defined by the machine administrator/management
>> software as part of the definition of VMs/Partitions on that mainframe which includes
>> everything from the number of CPUs, memory, I/O devices etc. With the exposed UID uniqueness
>> attribute the platform then certifies that it will ensure that a UID is set to
>> a unique non-zero value. I can of course add more of this explanation
>> in the documentation too.
> 
> Please explain it more, but why would userspace care about this?  If
> userspace sees a UID "collision" then it just adds something else to the
> end of the name to make it unique.

The idea is that userspace can be sure that no collisions will ever
happen. Consequently we can tell users that if they have UID uniqueness
checking on in their partition definition and they add a PCIe NIC with UID
X the network device will be named "enoX". This is particularly important
since during installation users might have to specify the interface name
as part of the installer's boot parameters _before_ Linux even boots.
Note that in our usual environments a lot of customers do not use things
like DHCP and might have very strict rules which interfaces will be
used for what. Similarly this would allow users to know exact interface
names when specifying e.g a Cloud Init configuration.

> 
> What is it supposed to do differently based on the value/presense of
> this file?

When UIDs are not guaranteed to be unique they are often unset that
is 0 and then the most stable identifier for a PCI function that a user
can know before even booting Linux is /sys/bus/pci/function_id.
This Function ID (FID) is also used as the hotplug slot
number and thus the X in "ensX.." interface names.
Thus, this would instead be the preferred interface naming scheme that
still allows the user to relate the interface names inside Linux
to what they can see in their machine/hypervisor configuration.

It should be noted that in our environments often the Linux admin(s)
will be a different group with very different background then the machine/mainframe
admin and the FID and UID are ofent the only per device information both
sides can see to identify an interface. Currently not even
the MAC address can be seen from the machine configuration or
even when listing devices in the z/VM hypervisor so we really want to use
either the FID or the UID in interface names.

In the future similar considerations may apply to other PCI devices.

> 
>> Both the uniqueness guarantee (this attribute) as well as the UIDs themselves
>> are part of the Z (s390x) architecture so fall under the mainframe typical
>> backwards compatibility considerations.
> 
> So what can userspace do with this?  What tool is going to rely on this?

We have a systemd/udev patch waiting on this RFC discussion
that will use this attribute for the aforementioned decision of either
preferring the existing "ens<hotplug_slot_numnber>…" or "eno<UID>…"
interface names based on this value.

As I mentioned in the cover letter we are also
considering instead going for /sys/firmware/.. but as far as
I can see that currently really needs much uglier raw kobject handling and
would lose the direct relation to PCI and creates the question
why PCI code puts stuff in /sys/firmware/… or alternatively which
other code deals with a PCI specific value.

> 
> thanks,
> 
> greg k-h
> 
