Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B82F6532
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbhANPwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 10:52:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbhANPwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 10:52:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10EFoU8d092619;
        Thu, 14 Jan 2021 10:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QLAG9lBXQQqSFhXhqB6kFaR2vfSqly39etrPJYaMVUA=;
 b=sS6KYO4dDNAXCdPWDIp0vK9QOF1lLwwFa9xoHUXThi671yHwsu+oOzZ+5tYoPklHKkdN
 23++dx+XhhaFqr8YnuY/S7RaxSI4v6SXGTRohV3jFbdDfbAaJu1OcsqyHk/9POOUT1M0
 JoRhKjEDBoESq3gQ5yGly47erCybUiLaxHDyWgqtdjVxl6SivaBwLDM6a9SiTQeD7ZDy
 hCNc0QFu2ncqiJs7Io9iI7F7uWKFXLGsn8MUFVoPNmj3BT1H6iBbdJTXH6oXCvv1Ictr
 m724szG/ZDa9F9Ak/ijyMYYO4X1d5oIyUin4UZCu0+0u5lfgP+thmkHLyB38HhIQDrjX FQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362ry0r0et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 10:51:23 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10EFXLkr019320;
        Thu, 14 Jan 2021 15:51:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 35y447xk7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 15:51:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10EFpIKK39846186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 15:51:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C40B65206B;
        Thu, 14 Jan 2021 15:51:17 +0000 (GMT)
Received: from [9.145.25.124] (unknown [9.145.25.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4EFD152054;
        Thu, 14 Jan 2021 15:51:17 +0000 (GMT)
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
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <f63d5de5-6a31-8839-72ce-c6e937f91d4a@linux.ibm.com>
Date:   Thu, 14 Jan 2021 16:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YABgcnWPLJxYlWUR@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_05:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>
>>>>>
>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>>>>>>>> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
>>>>>>>>> We use the UID of a zPCI adapter, or the UID of the function zero if
>>>>>>>>> there are multiple functions in an adapter, as PCI domain if and only if
>>>>>>>>> UID Checking is turned on.
>>>>>>>>> Otherwise we automatically generate domains as devices appear.
>>>>>>>>>
>>>>>>>>> The state of UID Checking is thus essential to know if the PCI domain
>>>>>>>>> will be stable, yet currently there is no way to access this information
>>>>>>>>> from userspace.
>>>>>>>>> So let's solve this by showing the state of UID checking as a sysfs
>>>>>>>>> attribute in /sys/bus/pci/uid_checking
>>>>>>
>>>>>>>>> +/* Global zPCI attributes */
>>>>>>>>> +static ssize_t uid_checking_show(struct kobject *kobj,
>>>>>>>>> +				 struct kobj_attribute *attr, char *buf)
>>>>>>>>> +{
>>>>>>>>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
>>>>>>>>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
>>>>>>>>
>>>>>>>> Use DEVICE_ATTR_RO instead of __ATTR.
>>>>>>>
>>>>>>> It's my understanding that DEVICE_ATTR_* is only for
>>>>>>> per device attributes. This one is global for the entire
>>>>>>> Z PCI. I just tried with BUS_ATTR_RO instead
>>>>>>> and that works but only if I put the attribute at
>>>>>>> /sys/bus/pci/uid_checking instead of with a zpci
>>>>>>> subfolder. This path would work for us too, we
>>>>>>> currently don't have any other global attributes
>>>>>>> that we are planning to expose but those could of
>>>>>>> course come up in the future.
>>>>>>
>>>>>> Ah, I missed the fact that this is a kobj_attribute, not a
>>>>>> device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
>>>>>> seems like it might fit?
>>>>>>
>>>>>> Bjorn
>>>>>>
>>>>>
>>>>> KERNEL_ATTR_* is currently not exported in any header. After
>>>>> adding it to include/linuc/sysfs.h it indeed works perfectly.
>>>>> Adding Christian Brauner as suggested by get_maintainers for
>>>>> their opinion. I'm of course willing to provide a patch
>>>>
>>>> Hey Niklas et al. :)
>>>>
>>>> I think this will need input from Greg. He should be best versed in
>>>> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
>>>> supposed to be kernel internal. Now, that might just be a matter of
>>>> renaming the macro but let's see whether Greg has any better idea or
>>>> more questions. :)
>>>
>>> The big question is, why are you needing this?
>>>
>>> No driver or driver subsystem should EVER be messing with a "raw"
>>> kobject like this.  Just use the existing DEVICE_* macros instead
>>> please.
>>>
>>> If you are using a raw kobject, please ask me how to do this properly,
>>> as that is something that should NEVER show up in the /sys/devices/*
>>> tree.  Otherwise userspace tools will break.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>> this is for an architecture specific but global i.e. not device bound PCI
>> attribute. That's why DEVICE_ATTR_* does not work. BUS_ATTR_* would work
>> but only if we place the attribute directly under /sys/bus/pci/new_attr.
> 
> Then you are doing something wrong :)

That is very possible.

> 
> Where _exactly_ are you wanting to put this attribute?

I'm trying for /sys/bus/pci/zpci/uid_checking, I'm using
the below code and the attribute even shows up but reading
it gives me two 0 bytes only.
The relevant code is only a slight alteration of the original patch
as follows:

static ssize_t uid_checking_show(struct bus_type *bus, char *buf)
{
	return sprintf(buf, "%i\n", zpci_unique_uid);
}
static BUS_ATTR_RO(uid_checking);

static struct kset *zpci_global_kset;

static struct attribute *zpci_attrs_global[] = {
	&bus_attr_uid_checking.attr,
	NULL,
};

static struct attribute_group zpci_attr_group_global = {
	.attrs = zpci_attrs_global,
};

int __init zpci_sysfs_init(void)
{
	struct kset *pci_bus_kset;

	pci_bus_kset = bus_get_kset(&pci_bus_type);

	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
	if (!zpci_global_kset)
		return -ENOMEM;

	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
}


> 
>> I'm aware that this is quite unusual in fact I couldn't find anything
>> similar. That's why this is an RFC, with a lengthy cover letter
>> explaining our use case, that I sent to Bjorn to figure out where to
>> even place the attribute.
>>
>> So I guess this is indeed me asking you how to do this properly.
>> That said it does not show up under /sys/devices/* only /sys/bus/pci/*.
> 
> Do NOT put random kobjects under a bus subsystem.  If you need that,
> then use BUS_ATTR_* as that is what it is there for.
> 
> Again, if you are in a driver subsystem, do not use a raw kobject.
> Either something is already there for you, or what you want to do is not
> correct :)

Understood and thanks for the clear advice!

> 
> thanks,
> 
> greg k-h
> 
