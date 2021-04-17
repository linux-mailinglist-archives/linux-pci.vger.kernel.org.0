Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651B362F57
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDQKsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 06:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33862 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhDQKsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 06:48:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13HAWfSx040122;
        Sat, 17 Apr 2021 06:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NlSuYwEDnI1Qgw1LSlRwNcUbu4zoK3TH2SeI9d9HqyQ=;
 b=hWAMzO+lPOTDsgCDD8lJkminIkeoIupvHkP3fPFEpdS5qqtvzqZsaBYeoW2K2Q+/bDO4
 lJJwvlOD8va2KHn/N+ecQORcNq8f3EnMOQg/soDiS0BzwODdhuZ6HKrYcnYbN+w6VXS0
 vvTkD/dp5NVLfM0mjVqJGGBneyGzOsHeOWlafwxpDrFI6lOYXSTA+xPgHTr+k6FoJt6h
 KDqG69RA43QGic/4VHrJU+AaTJCFJSAIPXNmFVdqRMW5MgyGiqEd/0WOOg+YGNWOedgW
 FWoYEcBAy+KbDy5Yj/yeE0axz33eaMImUQvTyhot2gRhlPIhAH78XKHiNVbyExRpUgaA Gg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ytg9usc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 06:47:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13HAljnr004340;
        Sat, 17 Apr 2021 10:47:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 37yqa882ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 10:47:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13HAlf1H46334248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 10:47:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71DD7A404D;
        Sat, 17 Apr 2021 10:47:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B422AA4040;
        Sat, 17 Apr 2021 10:47:40 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.188.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 17 Apr 2021 10:47:40 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
To:     "K, Narendra" <Narendra.K@dell.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
References: <20210414201755.GA2532433@bjorn-Precision-5520>
 <bd95605ed435ad3978535d865b883f58c1d542d6.camel@linux.ibm.com>
 <BYAPR19MB471115B37A7B15323ABADAF0814C9@BYAPR19MB4711.namprd19.prod.outlook.com>
From:   Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-ID: <7765cc9a-7e21-708a-1286-a8340d4874ca@linux.ibm.com>
Date:   Sat, 17 Apr 2021 12:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <BYAPR19MB471115B37A7B15323ABADAF0814C9@BYAPR19MB4711.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zeV035-6hY1oQ1j0_Ef7pA7A7zIL8yI1
X-Proofpoint-ORIG-GUID: zeV035-6hY1oQ1j0_Ef7pA7A7zIL8yI1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_06:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=957 impostorscore=0
 clxscore=1011 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170073
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/16/21 7:58 PM, K, Narendra wrote:
>> -----Original Message-----
>> From: Niklas Schnelle <schnelle@linux.ibm.com>
>> Sent: Thursday, April 15, 2021 12:55 PM
>> To: Bjorn Helgaas
>> Cc: K, Narendra; Viktor Mihajlovski; Stefan Raspl; Peter Oberparleiter; linux-
>> netdev@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-s390@vger.kernel.org
>> Subject: Re: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Wed, 2021-04-14 at 15:17 -0500, Bjorn Helgaas wrote:
>>> On Mon, Apr 12, 2021 at 03:59:05PM +0200, Niklas Schnelle wrote:
>>>> On s390 each PCI device has a user-defined ID (UID) exposed under
>>>> /sys/bus/pci/devices/<dev>/uid. This ID was designed to serve as the
>>>> PCI device's primary index and to match the device within Linux to
>>>> the device configured in the hypervisor. To serve as a primary
>>>> identifier the UID must be unique within the Linux instance, this is
>>>> guaranteed by the platform if and only if the UID Uniqueness
>>>> Checking flag is set within the CLP List PCI Functions response.
>>>>
>>>> In this sense the UID serves an analogous function as the SMBIOS
>>>> instance number or ACPI index exposed as the "index" respectively
>>>> "acpi_index" device attributes and used by e.g. systemd to set
>>>> interface names. As s390 does not use and will likely never use ACPI
>>>> nor SMBIOS there is no conflict and we can just expose the UID under the
>> "index"
>>>> attribute whenever UID Uniqueness Checking is active and get
>>>> systemd's interface naming support for free.
>>>>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
>>>
>>> This seems like a nice solution to me.
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Thanks! Yes I agree it's a simple solution that also makes sense from a design
>> point. I'll wait for Narendra's opinion of course.
> 
> Hi Niklas,
> 
> It seems like the UID and the index are not equivalent in their meaning.
> 
Hi Narendra,

the reasoning behind the wish to reuse index is that we think it's
similar in the sense that it provides a stable, firmware-reported
interface identifier.
Some background: s390 is a highly virtualized platform. There's
no traditional bare metal mode of operation, neither for the computer
system nor the I/O subsystem.
The equivalent to a standalone system is a logical partition (LPAR)
which in essence is a kind of virtual machine. LPARs access I/O devices
in a virtualized fashion as well. E.g., for PCI devices the I/O
subsystem is responsible for the management of PCI hardware and
will provide the PCI functions to the LPARs.
This is where UID and function_id come into play. Each PCI function will
carry a function_id attribute which defines it uniquely within the
entire s390 system. If a UID is configured for the function, it must
be unique within an LPAR, but doesn't need to be unique system-wide.
For instance, the admistrator may want to ensure that for every
LPAR the primary ethernet interface has the same identifier, to
allow miigration of Linux instances accross LPARs.
This can't be achieved with a slot-based name.
> The index SMBIOS type 41 device type instance indicates that
> 
> 1. The device is an onboard device.
> 2. A specific order of the onboard devices.
> 
> The UID described seems to indicate that the PCI device is unique within the Linux instance (sufficient for naming).
> But it does not indicate that PCI device is onboard and any order.
> 
> As all devices with UID will be named as eno<UID> (Ethernet onboard), names are not in sync with how each PCI function is exposed on a PCI slot (appears
> closer to SMBIOS type 9 record) as described below.
> 
> https://github.com/systemd/systemd/pull/19017
> https://github.com/systemd/systemd/commit/a496a238e8ee66ce25ad13a3f46549b2e2e979fc
> 
> In summary, it seems like the eno<UID> names on s390 will be unique names, but may not match the meaning of the index.
> 
> Also,
> 
> a) Will UID remain unique/same as initially exposed across reboots ?
Yes, the UID is the primary identifier for a PCI function and part of
the LPAR configuration. Even hotplug will not change the UID.
> 
> b) Is the reuse of index related to the 'slots' based naming scheme described below ?
> 
> https://github.com/systemd/systemd/pull/19017
> https://github.com/systemd/systemd/commit/a496a238e8ee66ce25ad13a3f46549b2e2e979fc
> 
No, this is independent. The commit above fixes the slot name parsing.
> c) If the slot based naming is fixed with the naming scheme from changes below, any thoughts on why is reuse of index needed ?
> 
> https://github.com/systemd/systemd/pull/19017
> https://github.com/systemd/systemd/commit/a496a238e8ee66ce25ad13a3f46549b2e2e979fc
As I wrote above, the slot describes the PCI function at the system
level, whereas the uid/index does it in the context off the LPAR.
>  > With regards,
> Narendra K
> 

-- 
Kind Regards,
    Viktor
