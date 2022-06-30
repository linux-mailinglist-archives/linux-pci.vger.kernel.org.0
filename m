Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD8561A90
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiF3MnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 08:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiF3MnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 08:43:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E394D3F31F;
        Thu, 30 Jun 2022 05:43:02 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCDteP020273;
        Thu, 30 Jun 2022 12:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SPcFOAYdFFFMnsH3X6se/q+ppCFh0lnZdnLd9m5A19g=;
 b=RHaDw1FHQxldTfBEZ5OCojNaAkOAMdJW7plSF55XwBsmC7m1BFD+BKkTDesxHqTKcUfv
 9mW6MlLelPtSiIhvDhPQB/ORROcsX85pugcSU/Wcjch7IYJJcwUZmZNT9DxOXCtBvwTN
 U6+QgVhJcQSaHr295v5PXEt4+Mx8x1TogP94oVHqvrx0/6F23StW3sZWcl3bYtdvJe28
 6eqnqP6xP+3Nr+mb73Q6LBQWG87ahh8g9yeOnTaoWePwE6tEjljqK11FrBq/jCmaah21
 kexC1xIbZdje4uBYEcXF9LaysOjWfICQIdyRRrqeSG8QHSnTaphBGoBSwjDjiOGhLMgb nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bn7gtmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:42:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCESkk025303;
        Thu, 30 Jun 2022 12:42:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bn7gtm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:42:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UCdRYB012771;
        Thu, 30 Jun 2022 12:42:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt0903hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:42:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UCfo8Y15860036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 12:41:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70B705204E;
        Thu, 30 Jun 2022 12:42:54 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 15B265204F;
        Thu, 30 Jun 2022 12:42:54 +0000 (GMT)
Message-ID: <3866ec66-d069-05ec-20d4-1df51823d977@linux.ibm.com>
Date:   Thu, 30 Jun 2022 14:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 3/5] PCI: Move jailhouse's isolated function handling
 to pci_scan_slot()
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
 <20220628143100.3228092-4-schnelle@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220628143100.3228092-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yUlERarbB9wATamYsnSaG_TpJ18STDMx
X-Proofpoint-GUID: 0NE3lS2iFzKFH0VkTdxbetUp1_Ib84mm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
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
> The special case of the jailhouse hypervisor passing through individual
> PCI functions handles scanning for PCI functions even if function 0 does
> not exist. Currently this is done with an extra loop duplicating the one
> in pci_scan_slot(). By incorporating the check for jailhouse_paravirt()
> into pci_scan_slot() we can instead do this as part of the normal
> slot scan. Note that with the assignment of dev->multifunction gated by
> fn > 0 we set dev->multifunction unconditionally for all functions if
> function 0 is missing just as in the existing jailhouse loop.
> 
> The only functional change is that we now call
> pcie_aspm_init_link_state() for these functions but this already
> happened if function 0 was passed through and should not be a problem.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/probe.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2c737dce757e..a18e07e6a7df 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2662,8 +2662,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>   			if (fn > 0)
>   				dev->multifunction = 1;
>   		} else if (fn == 0) {
> -			/* function 0 is required */
> -			break;
> +			/*
> +			 * function 0 is required unless we are running on
> +			 * a hypervisor which passes through individual PCI
> +			 * functions.
> +			 */
> +			if (!jailhouse_paravirt())
> +				break;
>   		}
>   		fn = next_fn(bus, dev, fn);
>   	} while (fn >= 0);
> @@ -2862,29 +2867,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>   {
>   	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>   	unsigned int start = bus->busn_res.start;
> -	unsigned int devfn, fn, cmax, max = start;
> +	unsigned int devfn, cmax, max = start;
>   	struct pci_dev *dev;
> -	int nr_devs;
>   
>   	dev_dbg(&bus->dev, "scanning bus\n");
>   
>   	/* Go find them, Rover! */
> -	for (devfn = 0; devfn < 256; devfn += 8) {
> -		nr_devs = pci_scan_slot(bus, devfn);
> -
> -		/*
> -		 * The Jailhouse hypervisor may pass individual functions of a
> -		 * multi-function device to a guest without passing function 0.
> -		 * Look for them as well.
> -		 */
> -		if (jailhouse_paravirt() && nr_devs == 0) {
> -			for (fn = 1; fn < 8; fn++) {
> -				dev = pci_scan_single_device(bus, devfn + fn);
> -				if (dev)
> -					dev->multifunction = 1;
> -			}
> -		}
> -	}
> +	for (devfn = 0; devfn < 256; devfn += 8)
> +		pci_scan_slot(bus, devfn);
>   
>   	/* Reserve buses for SR-IOV capability */
>   	used_buses = pci_iov_bus_range(bus);
> 


Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

-- 
Pierre Morel
IBM Lab Boeblingen
