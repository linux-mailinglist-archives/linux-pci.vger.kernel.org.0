Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7F183BD0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCLV7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 17:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgCLV7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 17:59:04 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CLrCd5018716;
        Thu, 12 Mar 2020 17:58:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yquesjwfw-23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 17:58:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02CLYri9007977;
        Thu, 12 Mar 2020 21:36:14 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 2yqt6q9d6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 21:36:13 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CLaCQB41222408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 21:36:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 908A86E04E;
        Thu, 12 Mar 2020 21:36:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B9F6E04C;
        Thu, 12 Mar 2020 21:36:11 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.72.189])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 21:36:10 +0000 (GMT)
Subject: Re: [PATCH -next] PCI: rpaphp: remove set but not used variable
 'value'
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
Cc:     paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200312144157.GA110750@google.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <f2297ff2-5ba7-da38-4630-0b8f6af4dea6@linux.ibm.com>
Date:   Thu, 12 Mar 2020 14:36:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312144157.GA110750@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_15:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120107
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/12/20 7:41 AM, Bjorn Helgaas wrote:
> On Thu, Mar 12, 2020 at 09:38:02AM -0500, Bjorn Helgaas wrote:
>> On Thu, Mar 12, 2020 at 10:04:12PM +0800, Chen Zhou wrote:
>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>
>>> drivers/pci/hotplug/rpaphp_core.c: In function is_php_type:
>>> drivers/pci/hotplug/rpaphp_core.c:291:16: warning:
>>> 	variable value set but not used [-Wunused-but-set-variable]
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>
>> Michael, if you want this:
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> If you don't mind, edit the subject to follow the convention, e.g.,
>>
>>   PCI: rpaphp: Remove unused variable 'value'
>>
>> Apparently simple_strtoul() is deprecated and we're supposed to use
>> kstrtoul() instead.  Looks like kstrtoul() might simplify the code a
>> little, too, e.g.,
>>
>>   if (kstrtoul(drc_type, 0, &value) == 0)
>>     return 1;
>>
>>   return 0;
> 
> I guess there are several other uses of simple_strtoul() in this file.
> Not sure if it's worth changing them all, just this one, or just the
> patch below as-is.

If we are going to change one might as well do them all at once. If the original
submitter wants to send the follow up that is fine, or I can send a patch when I
have a minute.

-Tyrel

> 
>>> ---
>>>  drivers/pci/hotplug/rpaphp_core.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
>>> index e408e40..5d871ef 100644
>>> --- a/drivers/pci/hotplug/rpaphp_core.c
>>> +++ b/drivers/pci/hotplug/rpaphp_core.c
>>> @@ -288,11 +288,10 @@ EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
>>>  
>>>  static int is_php_type(char *drc_type)
>>>  {
>>> -	unsigned long value;
>>>  	char *endptr;
>>>  
>>>  	/* PCI Hotplug nodes have an integer for drc_type */
>>> -	value = simple_strtoul(drc_type, &endptr, 10);
>>> +	simple_strtoul(drc_type, &endptr, 10);
>>>  	if (endptr == drc_type)
>>>  		return 0;
>>>  
>>> -- 
>>> 2.7.4
>>>

