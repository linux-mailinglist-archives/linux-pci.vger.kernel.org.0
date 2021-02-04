Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15DF30F2DA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 13:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhBDMG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 07:06:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235560AbhBDMG0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 07:06:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114C5SmC135427;
        Thu, 4 Feb 2021 07:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cZTh+I5F9V24r0zN//Jr7xMF9Y0BpJvuCyeacWDt1Xs=;
 b=L78uHQrIg5qaiTKtz4iV1QnxQEXmIw2emlQSXDpPnXQ/OI0aayTKbB0h/1eylKqJEzKs
 sq4R/MZDz8cZIjEHhlhiUDXzdaP2t4vjWi+pguPLItD3jV/CpS5EwF2qbm8vIAAX5D63
 DE/3LjqCOndboQdK1uyIALkrzU8ifyRbkY9YJZSWvzww8nk+Qbf8ppPUp8LXn19Ic+Mg
 9Y8W0RyuGRBbAhVunnzPEENub7BJzuiNjj3/AgtAPZSu+PIgII7/wthj+TgjFDq548fb
 rtC++bU8/EgKOv/rOWL39tZCI8ZEfUxHPJEOO/FZPuMeFuebTj9XEdChIWSfCPNZagR5 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ggew0a91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 07:05:44 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114C5fGg137276;
        Thu, 4 Feb 2021 07:05:41 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ggew0945-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 07:05:40 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114C2t6A014468;
        Thu, 4 Feb 2021 12:02:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 36evvf2fq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 12:02:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114C2qT741550204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 12:02:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58580A40EF;
        Thu,  4 Feb 2021 12:02:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC8DEA40EB;
        Thu,  4 Feb 2021 12:02:51 +0000 (GMT)
Received: from [9.145.50.6] (unknown [9.145.50.6])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 12:02:51 +0000 (GMT)
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com> <YBvPBD+fCtQkCFFD@kroah.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <7b85c218-88a4-b6db-e5de-7004475564ee@linux.ibm.com>
Date:   Thu, 4 Feb 2021 13:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBvPBD+fCtQkCFFD@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040077
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/4/21 11:40 AM, Greg Kroah-Hartman wrote:
> On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
>> The global UID uniqueness attribute exposes whether the platform
>> guarantees that the user-defined per-device UID attribute values
>> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
>> a global identifier for the associated PCI device. With this commit
>> it is exposed at /sys/bus/pci/zpci/unique_uids
>>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 25c9c39770c6..812dd9d3f80d 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -375,3 +375,12 @@ Description:
>>  		The value comes from the PCI kernel device state and can be one
>>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>>  		The file is read only.
>> +What:		/sys/bus/pci/zpci/unique_uids
> 
> No blank line before this new line?

Good catch, thanks!

> 
> And why "zpci"?

There doesn't seem to be a precedent for arch specific attributes under
/sys/bus/pci so I went with a separate group for the RFC.
"zpci" since that's what we've been calling the s390 specific PCI.
I'm not attached to that name or having a separate group, from
my perspective /sys/bus/pci/unique_uids would actually be ideal
if Bjorn is okay with that, we don't currently foresee any additional
global attributes and no one else seems to have them but
one never knows and a separate group would then of course,
well group them.

> 
>> +Date:		February 2021
>> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
>> +Description:
>> +		This attribute exposes the global state of UID Uniqueness on an
>> +		s390 Linux system. If this file contains '1' the per-device UID
>> +		attribute is guaranteed to provide a unique user defined
>> +		identifier for that PCI device. If this file contains '0' UIDs
>> +		may collide and do not provide a unique identifier.
> 
> What are they "colliding" with?  And where does the UID come from, the
> device itself or somewhere else?

If this attribute is 0 multiple PCI devices seen by Linux may have the same UID i.e.
they may collide with each other on the same Linux instance. The
UIDs are exposed under /sys/bus/pci/devices/<dev>/uid. Even if the attribute is 1
multiple Linux instances will often see the same UID. The main use case
we currently envision is naming PCI based network interfaces "eno<UID>"
which of course only works if the UIDs are unique for that Linux.
On the same mainframe multiple Linux instances may then e.g. use the same
UID for VFs from the same physical PCI network card or different cards
but the same physical network all defined by an administrator/management
system.

The UIDs come from the platform/firmware/hypervisor and are provided
for each device by the CLP List PCI Functions "instruction" that is used
on s390x where an OS can't probe the physical PCI bus but instead
that is done by firmware. On QEMU/KVM they can be set on the QEMU cli,
on our machine hypervisor they are defined by the machine administrator/management
software as part of the definition of VMs/Partitions on that mainframe which includes
everything from the number of CPUs, memory, I/O devices etc. With the exposed UID uniqueness
attribute the platform then certifies that it will ensure that a UID is set to
a unique non-zero value. I can of course add more of this explanation
in the documentation too.

Both the uniqueness guarantee (this attribute) as well as the UIDs themselves
are part of the Z (s390x) architecture so fall under the mainframe typical
backwards compatibility considerations.

Thanks,
Niklas

> 
> thanks,
> 
> greg k-h
> 
