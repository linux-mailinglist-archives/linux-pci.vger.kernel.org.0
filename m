Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979F92F61D0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhANNVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:21:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbhANNVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 08:21:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10EDFXcL014631;
        Thu, 14 Jan 2021 08:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K21q5GEVd9IZHgFsopjsF/6ZI6W3+T/M2kVExhooyC8=;
 b=F8bxLBdHTHzrOS8sqtwROVEfyZb8DsZM3QhBd/1qhud+4WEforckc66Rw3lkuGvmEFGA
 upjPnqgfuxqcPDaocOUCuJ21ekE0A2ar67i2940GoNAnVAUZLv9eskajCYMKKwGsi32s
 G9sz1+2ff7hWiyVDVtNObC9IWmI9qZYqvRVpXK/iLvVtxOhQLyfv5WUSZzPzHQmQW29G
 3XttsFXq64fWLamhbxZn0XiGBeaJsqJSA4J54aRuoyICmDBbh/MsCreNTzNpmNWJxJPA
 DYDFFAstqFkyO5ed+Vha2DWLu0/TIUZMbylVeaU1Tg2n/PAERrkavqr3yXPHYJ9TG9IE oQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 362p90923h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 08:20:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10EDHDPf002945;
        Thu, 14 Jan 2021 13:20:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 35y447xegu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 13:20:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10EDKBfY31719866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 13:20:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D5234C05C;
        Thu, 14 Jan 2021 13:20:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0BC44C05E;
        Thu, 14 Jan 2021 13:20:10 +0000 (GMT)
Received: from [9.145.25.124] (unknown [9.145.25.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 13:20:10 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210113185500.GA1918216@bjorn-Precision-5520>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
Date:   Thu, 14 Jan 2021 14:20:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210113185500.GA1918216@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=955 bulkscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140075
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>>> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
>>>> We use the UID of a zPCI adapter, or the UID of the function zero if
>>>> there are multiple functions in an adapter, as PCI domain if and only if
>>>> UID Checking is turned on.
>>>> Otherwise we automatically generate domains as devices appear.
>>>>
>>>> The state of UID Checking is thus essential to know if the PCI domain
>>>> will be stable, yet currently there is no way to access this information
>>>> from userspace.
>>>> So let's solve this by showing the state of UID checking as a sysfs
>>>> attribute in /sys/bus/pci/uid_checking
> 
>>>> +/* Global zPCI attributes */
>>>> +static ssize_t uid_checking_show(struct kobject *kobj,
>>>> +				 struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
>>>> +}
>>>> +
>>>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
>>>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
>>>
>>> Use DEVICE_ATTR_RO instead of __ATTR.
>>
>> It's my understanding that DEVICE_ATTR_* is only for
>> per device attributes. This one is global for the entire
>> Z PCI. I just tried with BUS_ATTR_RO instead
>> and that works but only if I put the attribute at
>> /sys/bus/pci/uid_checking instead of with a zpci
>> subfolder. This path would work for us too, we
>> currently don't have any other global attributes
>> that we are planning to expose but those could of
>> course come up in the future.
> 
> Ah, I missed the fact that this is a kobj_attribute, not a
> device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
> seems like it might fit?
> 
> Bjorn
> 

KERNEL_ATTR_* is currently not exported in any header. After
adding it to include/linuc/sysfs.h it indeed works perfectly.
Adding Christian Brauner as suggested by get_maintainers for
their opinion. I'm of course willing to provide a patch
for that move should it be desired.

@Bjorn apart from the correct macro do you have a preference
for either suggested path /sys/bus/pci/zpci/uid_checking vs
/sys/bus/pci/uid_checking?

For completeness some further internal discussion lets
us tend to rather name it to "unique_uids" but I guess that
doesn't make a difference to non s390 people ;-)


