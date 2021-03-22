Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158F0343D23
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 10:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCVJm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 05:42:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51408 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhCVJmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 05:42:44 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M9YAuV140884;
        Mon, 22 Mar 2021 05:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sLa6Tut7wxd/kICgOds4JxcRim1BubXqJxiDGMzFMU0=;
 b=KFwvgqqa3IVkhZfXjrGTHyjDV+bkRfjxbbtkmR0uDUArUt2O+H44n8Zeo2sHtmMlI4pe
 oJsiOQ07ya1bH97rKtbpsH7WgcPRtnEtvjdJk5dxh9KUoe1CuN1tqfLR1JxXb193MPOU
 qo6uRBuXB2BsIL3UwEQDm6n5ZtvXLt/ihahUou39928diszS2z6m6cRZ9VXAdCpw7cnz
 cc0vHd/iiaYM78Fw4Qdf6q1XtBzPLoRRPRz5LYPBbGHK0Pc8hSjkf0ELoCgU7mXw7nzw
 xPPmEQbc9KprW3XjLXJqiCSqH4t0augVc4e4ysTwiC+RhED8P6vDEVamj4d57hEkApJ4 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx9xb6ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 05:42:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12M9YCGs141077;
        Mon, 22 Mar 2021 05:42:38 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx9xb6c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 05:42:38 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12M9ITvs012919;
        Mon, 22 Mar 2021 09:42:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 37d9by949d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 09:42:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12M9gGwo25887158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 09:42:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98C72AE04D;
        Mon, 22 Mar 2021 09:42:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44941AE056;
        Mon, 22 Mar 2021 09:42:34 +0000 (GMT)
Received: from [9.145.10.82] (unknown [9.145.10.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 09:42:34 +0000 (GMT)
Subject: Re: [PATCH] pci/hotplug: fix potential memory leak in disable_slot()
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        gerald.schaefer@linux.ibm.com, bhelgaas@google.com
References: <245c1063-f0cf-551a-b93c-1a0a5ac06eff@huawei.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <64ab0093-b4b6-834f-4249-d38e1e1637c0@linux.ibm.com>
Date:   Mon, 22 Mar 2021 10:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <245c1063-f0cf-551a-b93c-1a0a5ac06eff@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_03:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220072
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/03/2021 16:51, Zhiqiang Liu wrote:
> 
> In disable_slot(), if we obtain desired PCI device
> successfully by calling pci_get_slot(), we should
> call pci_dev_put() to release its reference.

Thanks for the patch! This should however be fixed independently by 
commit 0b13525c20fe ("s390/pci: fix leak of PCI device structure")
which was just added to v5.12-rc4 and will be backported to stable.
There were a few similar cases that also got fixed by that commit.

> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> ---
>   drivers/pci/hotplug/s390_pci_hpc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
> index c9e790c74051..999a34b6fd50 100644
> --- a/drivers/pci/hotplug/s390_pci_hpc.c
> +++ b/drivers/pci/hotplug/s390_pci_hpc.c
> @@ -89,9 +89,11 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
>   		return -EIO;
> 
>   	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
> -	if (pdev && pci_num_vf(pdev)) {
> +	if (pdev) {
> +		rc = pci_num_vf(pdev);
>   		pci_dev_put(pdev);
> -		return -EBUSY;
> +		if (rc)
> +			return -EBUSY;
>   	}
> 
>   	zpci_remove_device(zdev);
> 
