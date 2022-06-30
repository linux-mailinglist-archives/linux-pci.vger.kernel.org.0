Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599B561A87
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiF3MlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3MlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 08:41:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B383FDBA;
        Thu, 30 Jun 2022 05:41:19 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UBLoN4007511;
        Thu, 30 Jun 2022 12:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GkXaiqkN9lB0iyXYP33RrScm+EbGQAdPQjyAj+b3OSM=;
 b=qQVsH45DermNfcF5UQkc5PTXSAVl9/fnCVG1bPrYT/ha4HPdQkZAlK00m3gMVlVN+QWC
 X91MtkiHanUbT+4FJxmU0ydf2AR4xxozJwyFjUlVxmRSCZyBlGcUSci3wjwpMJ5QmWn0
 WwWtK7qc/vx5aJbYOhWSFeo5l7LepON58W4UkCY0YL/BSHG1bTVkHgMzcjM1/5xk8elN
 vD54H3+kkKD8OnumbBoFocFaZt8WQk87LYWINeA1+IYvpa/PihfLYvjL7DBVxehCkIpZ
 rDw4/M8K3WGY/HWJdbYVTsIAQHQK+5C/qR3gF7ZGHFWNfUrQqI5yzVMgquUQ7xAnHanp gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1avxt5gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:41:16 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCGtcF015765;
        Thu, 30 Jun 2022 12:41:16 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1avxt5f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:41:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UCeh80023203;
        Thu, 30 Jun 2022 12:41:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3gwt08x2et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:41:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UCfAQL13566426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 12:41:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7307D52050;
        Thu, 30 Jun 2022 12:41:10 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 17D1A5204F;
        Thu, 30 Jun 2022 12:41:10 +0000 (GMT)
Message-ID: <90996285-9ae3-0030-a5e3-a3f1bfa23088@linux.ibm.com>
Date:   Thu, 30 Jun 2022 14:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 4/5] PCI: Extend isolated function probing to s390
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
 <20220628143100.3228092-5-schnelle@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220628143100.3228092-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BJo64tGRqJehdK4oXVVrAy7srVdrrsKh
X-Proofpoint-GUID: HpsKrbPP05NU9-aXZuu2ENmpeVFN3oQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=852 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/28/22 16:30, Niklas Schnelle wrote:
> Like the jailhouse hypervisor s390's PCI architecture allows passing
> isolated PCI functions to an OS instance. As of now this is was not
> utilized even with multi-function support as the s390 PCI code makes
> sure that only virtual PCI busses including a function with devfn 0 are
> presented to the PCI subsystem. A subsequent change will remove this
> restriction.
> 
> Allow probing such functions by replacing the existing check for
> jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> helper.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/probe.c        | 2 +-
>   include/linux/hypervisor.h | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a18e07e6a7df..156dd13594b8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2667,7 +2667,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>   			 * a hypervisor which passes through individual PCI
>   			 * functions.
>   			 */
> -			if (!jailhouse_paravirt())
> +			if (!hypervisor_isolated_pci_functions())
>   				break;
>   		}
>   		fn = next_fn(bus, dev, fn);
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index fc08b433c856..33b1c0482aac 100644
> --- a/include/linux/hypervisor.h
> +++ b/include/linux/hypervisor.h
> @@ -32,4 +32,12 @@ static inline bool jailhouse_paravirt(void)
>   
>   #endif /* !CONFIG_X86 */
>   
> +static inline bool hypervisor_isolated_pci_functions(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +	else
> +		return jailhouse_paravirt();

I would spare the else,

Another remark, shouldn't it be the last patch?

otherwise LGTM

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


> +}
> +
>   #endif /* __LINUX_HYPEVISOR_H */
> 

-- 
Pierre Morel
IBM Lab Boeblingen
