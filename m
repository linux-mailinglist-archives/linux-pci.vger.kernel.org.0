Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F12F7785
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbhAOLVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 06:21:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47802 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbhAOLVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 06:21:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10FB2Vnb137221;
        Fri, 15 Jan 2021 06:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QdKpibyt3j07Ur30JcvPON3QdeWUrnH8CWmdF3tGrNU=;
 b=OEPUWW1CccLDv0RJ8UiSInwKwa/1WPvIMkFVQ2Uoikwn+bRjWVUD4dU49HwwNCnrNC4s
 B69C8jY4yVnnOZZtv1r4XhZwqXv5fENT4uHGPpTdbisdg/n5CiVLZ75+/LgkKwSLCOxN
 1C617GCUsfQOQLZ4Rq3V8N/8BFK9c1BC6tAphEoynlgfWeAueuPts5lj7NsaBeZLXHfY
 l5b5kqcIOfVcmO7/Z9d2W9OaxmQo6gAcwp7+IQmOfw+W3SkjS2PIYEO4jzgMF7EJOOnZ
 58F85tLmeco1wdfrLKgCOoZjDkfxKAxjjPo9+OXViQKlRcjIMFUS7mGW16341bby5foW fQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36394rskhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 06:21:05 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10FBGrUn021690;
        Fri, 15 Jan 2021 11:21:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 35y4483xmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 11:21:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10FBL0TM49545636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 11:21:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADFF5AE045;
        Fri, 15 Jan 2021 11:21:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39F1DAE056;
        Fri, 15 Jan 2021 11:21:00 +0000 (GMT)
Received: from [9.145.69.127] (unknown [9.145.69.127])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jan 2021 11:21:00 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210113185500.GA1918216@bjorn-Precision-5520>
 <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
 <20210114134453.bkfik4zjt5ehz6d5@wittgenstein> <YABOHuejsuriwSPn@kroah.com>
 <a567c3d2-1dd2-6b33-8b1a-0a607b601ef8@linux.ibm.com>
 <YABgcnWPLJxYlWUR@kroah.com>
 <f63d5de5-6a31-8839-72ce-c6e937f91d4a@linux.ibm.com>
 <YABt38yz5BJ8gARG@kroah.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <aeae8e23-0263-dfe7-d068-ec925432a4a2@linux.ibm.com>
Date:   Fri, 15 Jan 2021 12:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YABt38yz5BJ8gARG@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_06:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150063
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>>>
>>>>
>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
... snip ...
>>>>>>
>>>>>> Hey Niklas et al. :)
>>>>>>
>>>>>> I think this will need input from Greg. He should be best versed in
>>>>>> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
>>>>>> supposed to be kernel internal. Now, that might just be a matter of
>>>>>> renaming the macro but let's see whether Greg has any better idea or
>>>>>> more questions. :)
>>>>>
>>>>> The big question is, why are you needing this?
>>>>>
>>>>> No driver or driver subsystem should EVER be messing with a "raw"
>>>>> kobject like this.  Just use the existing DEVICE_* macros instead
>>>>> please.
>>>>>
>>>>> If you are using a raw kobject, please ask me how to do this properly,
>>>>> as that is something that should NEVER show up in the /sys/devices/*
>>>>> tree.  Otherwise userspace tools will break.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> Hi Greg,
>>>>
>>>> this is for an architecture specific but global i.e. not device bound PCI
>>>> attribute. That's why DEVICE_ATTR_* does not work. BUS_ATTR_* would work
>>>> but only if we place the attribute directly under /sys/bus/pci/new_attr.
>>>
>>> Then you are doing something wrong :)
>>
>> That is very possible.
>>
>>>
>>> Where _exactly_ are you wanting to put this attribute?
>>
>> I'm trying for /sys/bus/pci/zpci/uid_checking, I'm using
>> the below code and the attribute even shows up but reading
>> it gives me two 0 bytes only.
>> The relevant code is only a slight alteration of the original patch
>> as follows:
>>
>> static ssize_t uid_checking_show(struct bus_type *bus, char *buf)
>> {
>> 	return sprintf(buf, "%i\n", zpci_unique_uid);
>> }
>> static BUS_ATTR_RO(uid_checking);
>>
>> static struct kset *zpci_global_kset;
>>
>> static struct attribute *zpci_attrs_global[] = {
>> 	&bus_attr_uid_checking.attr,
>> 	NULL,
>> };
>>
>> static struct attribute_group zpci_attr_group_global = {
>> 	.attrs = zpci_attrs_global,
>> };
> 
> Name your attribute group, and then you do not have to mess with a
> "raw" kobject like you are below:

Thanks for this tip and sorry for bothering you again.

> 
>>
>> int __init zpci_sysfs_init(void)
>> {
>> 	struct kset *pci_bus_kset;
>>
>> 	pci_bus_kset = bus_get_kset(&pci_bus_type);
>>
>> 	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
> 
> No, do not mess with at kset, just set the default attribute group for
> the bus to the above, and you should be fine.

Oh ok, I got this idea from the code adding /sys/bus/pci/slots/ in
drivers/pci/slot.c:pci_slot_init(). See below maybe we can clean that up too.

> 
>> 	if (!zpci_global_kset)
>> 		return -ENOMEM;
>>
>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
> 
> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
> that's usually a huge clue that you are doing something wrong.
> 
> Try the above again, with a simple attribute group, and name for it, and
> it should "just work".

I'm probably missing something but I don't get how this could work in
this case. If I'm seeing this right the default attribute group here
is pci_bus_type.bus_groups and that is already set in drivers/pci/pci-driver.c
so I don't think I should set that.

I did however find bus_create_file() which does work when using the path
/sys/bus/pci/uid_checking instead. This would work for us if Bjorn is okay with
that path and the code is really clean and simple too.

That said, I think we could also add something like bus_create_group().
Then we could use that to also clean up drivers/pci/slot.c:pci_slot_init()
and get the original path /sys/bus/pci/zpci/uid_checking.

I think this would also allow us to get rid of pci_bus_get_kset() which is
only used in that function and seems to me like it encourages use of raw ksets.
Or I'm completely off the mark and just missing something important.

thanks,
Niklas
