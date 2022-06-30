Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5A561A6A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiF3MgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiF3MgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 08:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DB3982F;
        Thu, 30 Jun 2022 05:36:14 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UBfvMn024877;
        Thu, 30 Jun 2022 12:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=myC12JeAdbFFP6SHJKO0hewDlMY5COimsUaxqcrVJW0=;
 b=BCmIEaIwGrV/Zp807RjVz5IJdsGmgCYMJXmIRJw7dl8UPNJDw35acF36i5wHH3AOVV25
 g9sZFp6yvDlD/l56dnXIZFxj/FkVXIm+l11GbGzjmZfROdPLUMx4crgQ7RmL2F9SsXAb
 C4de4u3br2+pqdLkAJaTDXUSlk4uKlzES7lXG73HOkwrTIdz/GKoBNjOQyH/l45UGacn
 3k0ejJjc8e99CLsrq01EuTwEm9URRvtkaoh+AzXhncQV4v5zBKC+quSTPbAiJsrPFnc6
 NOs9WrEy1K5U9OY8FzYGry9c6phkfD1gDY65GBdnT4CBJdUF5X7oylBDtBre7lbEkSkR +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1b68sj17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:36:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UBheBX030245;
        Thu, 30 Jun 2022 12:36:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1b68shyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:36:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UCNfMK032270;
        Thu, 30 Jun 2022 12:36:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj84t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:36:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UCa5Uq9634214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 12:36:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0140252050;
        Thu, 30 Jun 2022 12:36:05 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 971285204F;
        Thu, 30 Jun 2022 12:36:04 +0000 (GMT)
Message-ID: <17c30662-7285-0e1a-91fb-071fa2cfc733@linux.ibm.com>
Date:   Thu, 30 Jun 2022 14:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 1/5] PCI: Clean up pci_scan_slot()
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
 <20220628143100.3228092-2-schnelle@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220628143100.3228092-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PjATLTWkMNsNt4gmmQyQfAkjEM9ZIW5P
X-Proofpoint-ORIG-GUID: P2-pxzrGaKPb1qPRa04AoCj0qnWoGRXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=918 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> While determining the next PCI function is factored out of
> pci_scan_slot() into next_fn() the former still handles the first
> function as a special case. This duplicates the code from the scan loop.
> 
> Furthermore the non ARI branch of next_fn() is generally hard to
> understand and especially the check for multifunction devices is hidden
> in the handling of NULL devices for non-contiguous multifunction. It
> also signals that no further functions need to be scanned by returning
> 0 via wraparound and this is a valid function number.
> 
> Improve upon this by transforming the conditions in next_fn() to be
> easier to understand.
> 
> By changing next_fn() to return -ENODEV instead of 0 when there is no
> next function we can then handle the initial function inside the loop
> and deduplicate the shared handling. This also makes it more explicit
> that only function 0 must exist.
> 
> No functional change is intended.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/probe.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..b05d0ed83a24 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2579,8 +2579,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>   }
>   EXPORT_SYMBOL(pci_scan_single_device);
>   
> -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> -			    unsigned int fn)
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>   {
>   	int pos;
>   	u16 cap = 0;
> @@ -2588,24 +2587,26 @@ static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
>   
>   	if (pci_ari_enabled(bus)) {
>   		if (!dev)
> -			return 0;
> +			return -ENODEV;
>   		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
>   		if (!pos)
> -			return 0;
> +			return -ENODEV;
>   
>   		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
>   		next_fn = PCI_ARI_CAP_NFN(cap);
>   		if (next_fn <= fn)
> -			return 0;	/* protect against malformed list */
> +			return -ENODEV;	/* protect against malformed list */
>   
>   		return next_fn;
>   	}
>   
> -	/* dev may be NULL for non-contiguous multifunction devices */
> -	if (!dev || dev->multifunction)
> -		return (fn + 1) % 8;
> +	if (fn >= 7)
> +		return -ENODEV;
> +	/* only multifunction devices may have more functions */
> +	if (dev && !dev->multifunction)
> +		return -ENODEV;
>   
> -	return 0;
> +	return fn + 1;

No more % 8 ?
Even it disapear later shouldn't we keep it ?



>   }
>   
>   static int only_one_child(struct pci_bus *bus)
> @@ -2643,26 +2644,25 @@ static int only_one_child(struct pci_bus *bus)
>    */
>   int pci_scan_slot(struct pci_bus *bus, int devfn)
>   {
> -	unsigned int fn, nr = 0;
>   	struct pci_dev *dev;
> +	int fn = 0, nr = 0;
>   
>   	if (only_one_child(bus) && (devfn > 0))
>   		return 0; /* Already scanned the entire slot */
>   
> -	dev = pci_scan_single_device(bus, devfn);
> -	if (!dev)
> -		return 0;
> -	if (!pci_dev_is_added(dev))
> -		nr++;
> -
> -	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
> +	do {
>   		dev = pci_scan_single_device(bus, devfn + fn);
>   		if (dev) {
>   			if (!pci_dev_is_added(dev))
>   				nr++;
> -			dev->multifunction = 1;
> +			if (fn > 0)
> +				dev->multifunction = 1;
> +		} else if (fn == 0) {
> +			/* function 0 is required */
> +			break;
>   		}
> -	}
> +		fn = next_fn(bus, dev, fn);
> +	} while (fn >= 0);
>   
>   	/* Only one slot has PCIe device */
>   	if (bus->self && nr)
> 

Otherwise LGTM


-- 
Pierre Morel
IBM Lab Boeblingen
