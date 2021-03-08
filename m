Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5133309A8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHInG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 03:43:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232199AbhCHImr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 03:42:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1288YITF196471;
        Mon, 8 Mar 2021 03:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zWXYuhMFZhSwUgA+a72tpYVWBXlkWy3QgwyVRBRPdss=;
 b=TDo9jn3AT0s0Dw4B631RWwGrehUFEzXrQwSoeZxAJOEO9wDOQhCd9sBBSkXPUIC2RSYL
 j8R63xLwRr6rEW6WHooX9zNOAoRR06mco3i5xaqJdBscSK/YTd96s21k0RMEnX/2n20p
 2gcY5DSNIaF5wK6yDWHngDdO41oLJu5o9cGv1yharfeRvlQFRI8QLXtTEVxlfUsjcQ+q
 g5jllrCY3wyy3JAhtbsabxU1mkiQGkHt9hj0FKv9oIYwxv6T1G00Vyexs8wKKfQQA6/t
 /1qWNcme8CXEDIzPg8ZfdWnFTq45cIwFAw0SSqDw7foJJIvuYJTBYqY2sYSYkLTCVI0U DQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37596qs9e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 03:42:43 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1288bI5C030568;
        Mon, 8 Mar 2021 08:42:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3741c8guka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:42:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1288gcIN43974952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 08:42:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACCDE11C052;
        Mon,  8 Mar 2021 08:42:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1DC311C04A;
        Mon,  8 Mar 2021 08:42:37 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.158.35])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 08:42:37 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose a PCI device's UID as its index
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210303095250.1360007-1-schnelle@linux.ibm.com>
 <20210303095250.1360007-2-schnelle@linux.ibm.com>
 <YEU7iFjxNxQK3ldc@rocinante>
 <c714ca55-7189-e196-7b8d-f02da555b399@linux.ibm.com>
From:   Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-ID: <e2f45e3e-210b-0b98-c8bd-bbe6609b85f1@linux.ibm.com>
Date:   Mon, 8 Mar 2021 09:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c714ca55-7189-e196-7b8d-f02da555b399@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=947
 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080045
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/8/21 8:02 AM, Niklas Schnelle wrote:
> 
> 
> On 3/7/21 9:46 PM, Krzysztof Wilczyński wrote:
>> Hi Niklas,
>>
>> [...]
>>> +static ssize_t index_show(struct device *dev,
>>> +			  struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
>>> +	u32 index = ~0;
>>> +
>>> +	if (zpci_unique_uid)
>>> +		index = zdev->uid;
>>> +
>>> +	return sprintf(buf, "%u\n", index);
>> [...]
>>
>> Would it be possible to use the new sysfs_emit() rather than sprintf()
>> even though the zpci_attr macro and still use mio_enabled_show() still
>> would use sprintf().  What do you think?
>>
>> See https://www.kernel.org/doc/html/latest/filesystems/sysfs.html for
>> the changes in the internal API.
>>
>> Krzysztof
>>
> 
> Of course that makes sense and thanks for pointing me to this API!
> @Viktor, may I carry your R-b over?
> 
Sure, please go ahead.
> I'll also update the other attributes in a clean up patch.
> 
> Thanks,
> Niklas
> 

-- 
Kind Regards,
    Viktor
