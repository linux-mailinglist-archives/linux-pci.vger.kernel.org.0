Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3600A2F4581
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 08:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbhAMHss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 02:48:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52244 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbhAMHsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 02:48:47 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10D7WcJl106904;
        Wed, 13 Jan 2021 02:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TLZkSzF3w0LiuNL5vx4vpqA4yZpHH23AY3+3fIMCqRg=;
 b=fxIUwi1K4Jfq50/4t+cnijf8FugshoQldI0k+F4QOeSKbhbtRN36+O2Mf7twP9KrVQtS
 87Xnw7/IQ2QZHd1tHblEu57U5dXM38XHbqAXCKJ+Lrdn8MsrrwcwQ8PlkJUBvjKnkKEk
 uvHO/dUvvz7/9hDIrSj9DMr0OxyZQHrLd8c/fIlt4bTN1wxq9/QTtP28HlU+MaTn0yS/
 BJM0hwGTYVFeynx3KD5usp45vrJ5QPpSocKrsRiAoHj8MGBFoT1TjQMy6fAhe0A6OxQQ
 YVUz+w/psAO8GjstvWmyX+E2T81NxDYLgYWu7PFWP2GhpXZNBm95/N7FmvxvbufPw/e+ 0Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361vgwrcrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 02:48:04 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10D7hCZ8017007;
        Wed, 13 Jan 2021 07:48:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 35ydrdcats-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 07:48:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10D7lxqo18284954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 07:47:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74E0BA405C;
        Wed, 13 Jan 2021 07:47:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16801A4054;
        Wed, 13 Jan 2021 07:47:59 +0000 (GMT)
Received: from [9.145.5.191] (unknown [9.145.5.191])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jan 2021 07:47:59 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20210112215004.GA1855697@bjorn-Precision-5520>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <4f5013a1-3dde-1633-a0cc-591fc439e29d@linux.ibm.com>
Date:   Wed, 13 Jan 2021 08:47:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112215004.GA1855697@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_03:2021-01-12,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130040
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
>> We use the UID of a zPCI adapter, or the UID of the function zero if
>> there are multiple functions in an adapter, as PCI domain if and only if
>> UID Checking is turned on.
>> Otherwise we automatically generate domains as devices appear.
>>
>> The state of UID Checking is thus essential to know if the PCI domain
>> will be stable, yet currently there is no way to access this information
>> from userspace.
>> So let's solve this by showing the state of UID checking as a sysfs
>> attribute in /sys/bus/pci/uid_checking
> 
> Cosmetic: can't tell if the above is two paragraphs separated by blank
> lines or four separated by either blank lines or short last lines.
> Please separate or reflow to avoid the ambiguity.

Thanks, you're right I split it in 3 proper paragraphs now.
Also the commit message was out of sync with the documentation,
cover letter and code. This version actually uses
/sys/bus/pci/zpci/uid_checking sorry about that.

> 
> I don't have any input on the s390 issues, and I assume this will go
> via the s390 tree.
> 
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
>>  arch/s390/include/asm/pci.h             |  3 +++
>>  arch/s390/pci/pci.c                     |  4 +++
>>  arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
>>  4 files changed, 52 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 25c9c39770c6..a174aac0ebb0 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -375,3 +375,14 @@ Description:
>>  		The value comes from the PCI kernel device state and can be one
>>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>>  		The file is read only.
>> +What:		/sys/bus/pci/zpci/uid_checking
>> +Date:		December 2020
>> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
>> +Description:
>> +		This attribute exposes the global state of UID Checking on
>> +		an s390 Linux system. If UID Checking is on this file
>> +		contains '1' otherwise '0'. If UID Checking is on the UID of
>> +		a zPCI device, or the UID of function zero for a multi-function
>> +		device will be used as its PCI Domain number. If UID Checking
>> +		is off PCI Domain numbers are generated automatically and
>> +		are not stable across reboots.
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 212628932ddc..3cfa6cc701ba 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -285,6 +285,9 @@ void zpci_debug_exit_device(struct zpci_dev *);
>>  /* Error reporting */
>>  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
... snip ...
>> +
>> +/* Global zPCI attributes */
>> +static ssize_t uid_checking_show(struct kobject *kobj,
>> +				 struct kobj_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
>> +}
>> +
>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> 
> Use DEVICE_ATTR_RO instead of __ATTR.

It's my understanding that DEVICE_ATTR_* is only for
per device attributes. This one is global for the entire
Z PCI. I just tried with BUS_ATTR_RO instead
and that works but only if I put the attribute at
/sys/bus/pci/uid_checking instead of with a zpci
subfolder. This path would work for us too, we
currently don't have any other global attributes
that we are planning to expose but those could of
course come up in the future.

> 
... snip ...
>>
