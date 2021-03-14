Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212C633A88D
	for <lists+linux-pci@lfdr.de>; Sun, 14 Mar 2021 23:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCNWcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 18:32:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhCNWcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Mar 2021 18:32:20 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12EM4GQ0012031;
        Sun, 14 Mar 2021 18:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bMYUf3tPZFWdirmjnTyN0au4/D2kRROPwGdA+rqqfdU=;
 b=TEpncx+odWV9X5oMS9ArcFXbvTMeYMx4F5WdjZ11KGH7onYQunvsX6fcKFJEUcHwZ+jS
 BNLWKUk7O8fQWatSF1GHHUANqr8XtFEUOXSzkc2l4AGQT+/Z5xXvkPSPPpx8/dNRlqrK
 jSIAdlLi/PEaoMDCZrCXG2DXk/AeaWIz5zdHgHYsIxBixFaTEWgZGt9RFmtfHLh7WQNQ
 vFflz4/YOqJOgKSIABSiRnW8Z4qbq9AN/X/pJcOzFhIlMUN7Zx426BvLSykmdff2pnQj
 m/bd85W3uQFyvKO8ON7lBrPDXsesxkcuZd1KPQXx1HK8q5f2lwqp2P95/800u75573wc tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379swxsb5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 18:32:12 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12EM4dL6012561;
        Sun, 14 Mar 2021 18:32:11 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379swxsb5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 18:32:11 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12EMVurl016371;
        Sun, 14 Mar 2021 22:32:10 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 378n19dttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:32:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12EMW9Zb15860146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Mar 2021 22:32:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DE42BE053;
        Sun, 14 Mar 2021 22:32:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D3F8BE051;
        Sun, 14 Mar 2021 22:32:08 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.44.137])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 14 Mar 2021 22:32:07 +0000 (GMT)
Subject: Re: [PATCH] rpadlpar: fix potential drc_name corruption in store
 functions
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, mmc@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210310223021.423155-1-tyreld@linux.ibm.com>
 <20210313091751.GM6564@kitsune.suse.cz>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <a67af978-1c47-c66b-47f0-3d754da738f9@linux.ibm.com>
Date:   Sun, 14 Mar 2021 15:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210313091751.GM6564@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_13:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140170
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/13/21 1:17 AM, Michal Suchánek wrote:
> On Wed, Mar 10, 2021 at 04:30:21PM -0600, Tyrel Datwyler wrote:
>> Both add_slot_store() and remove_slot_store() try to fix up the drc_name
>> copied from the store buffer by placing a NULL terminator at nbyte + 1
>> or in place of a '\n' if present. However, the static buffer that we
>> copy the drc_name data into is not zeored and can contain anything past
>> the n-th byte. This is problematic if a '\n' byte appears in that buffer
>> after nbytes and the string copied into the store buffer was not NULL
>> terminated to start with as the strchr() search for a '\n' byte will mark
>> this incorrectly as the end of the drc_name string resulting in a drc_name
>> string that contains garbage data after the n-th byte. The following
>> debugging shows an example of the drmgr utility writing "PHB 4543" to
>> the add_slot sysfs attribute, but add_slot_store logging a corrupted
>> string value.
>>
>> [135823.702864] drmgr: drmgr: -c phb -a -s PHB 4543 -d 1
>> [135823.702879] add_slot_store: drc_name = PHB 4543°|<82>!, rc = -19
>>
>> Fix this by NULL terminating the string when we copy it into our static
>> buffer by coping nbytes + 1 of data from the store buffer. The code has
> Why is it OK to copy nbytes + 1 and why is it expected that the buffer
> contains a nul after the content?

It is my understanding that the store function buffer is allocated as a
zeroed-page which the kernel copies up to at most (PAGE_SIZE - 1) of user data
into. Anything after nbytes would therefore be zeroed.

> 
> Isn't it much saner to just nul terminate the string after copying?

At the cost of an extra line of code, sure.

-Tyrel

> 
> diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
> index cdbfa5df3a51..cfbad67447da 100644
> --- a/drivers/pci/hotplug/rpadlpar_sysfs.c
> +++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
> @@ -35,11 +35,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		return 0;
>  
>  	memcpy(drc_name, buf, nbytes);
> +	&drc_name[nbytes] = '\0';
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_add_slot(drc_name);
>  	if (rc)
> @@ -66,11 +66,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
>  		return 0;
>  
>  	memcpy(drc_name, buf, nbytes);
> +	&drc_name[nbytes] = '\0';
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_remove_slot(drc_name);
>  	if (rc)
> 
> Thanks
> 
> Michal
> 
>> already made sure that nbytes is not >= MAX_DRC_NAME_LEN and the store
>> buffer is guaranteed to be zeroed beyond the nth-byte of data copied
>> from the user. Further, since the string is now NULL terminated the code
>> only needs to change '\n' to '\0' when present.
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>> ---
>>  drivers/pci/hotplug/rpadlpar_sysfs.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
>> index cdbfa5df3a51..375087921284 100644
>> --- a/drivers/pci/hotplug/rpadlpar_sysfs.c
>> +++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
>> @@ -34,12 +34,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
>>  	if (nbytes >= MAX_DRC_NAME_LEN)
>>  		return 0;
>>  
>> -	memcpy(drc_name, buf, nbytes);
>> +	memcpy(drc_name, buf, nbytes + 1);
>>  
>>  	end = strchr(drc_name, '\n');
>> -	if (!end)
>> -		end = &drc_name[nbytes];
>> -	*end = '\0';
>> +	if (end)
>> +		*end = '\0';
>>  
>>  	rc = dlpar_add_slot(drc_name);
>>  	if (rc)
>> @@ -65,12 +64,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
>>  	if (nbytes >= MAX_DRC_NAME_LEN)
>>  		return 0;
>>  
>> -	memcpy(drc_name, buf, nbytes);
>> +	memcpy(drc_name, buf, nbytes + 1);
>>  
>>  	end = strchr(drc_name, '\n');
>> -	if (!end)
>> -		end = &drc_name[nbytes];
>> -	*end = '\0';
>> +	if (end)
>> +		*end = '\0';
>>  
>>  	rc = dlpar_remove_slot(drc_name);
>>  	if (rc)
>> -- 
>> 2.27.0
>>

