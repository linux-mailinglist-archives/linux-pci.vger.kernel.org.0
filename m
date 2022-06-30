Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84D561E5B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiF3OqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiF3OqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 10:46:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088B1A835;
        Thu, 30 Jun 2022 07:45:59 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEfBvp037543;
        Thu, 30 Jun 2022 14:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bVRAqFqxas/+eql8YkiW8QnBAmPd4iM27hO1S1rVvF0=;
 b=l41518QLo4u6n987JN9ZWVwxrGoYMVPBVIFrfvBafMUz0oFArhBPIFZSQ3n5e7ViGP+i
 Df03rgAEzdgMA0pQwdjofG4pXYhLc6JUqKa41hz2qZBx00osXGuP2Vxnqq5li+FmSIyU
 EFyEPcG/6ijWeERIvrjh3WJo6OrdgwbxSEYx4bKKXMGOBKlOMibj4nxOMEvlbfXd1h5z
 JcMymp4DxZOB3AhEm6k6lfDVcdHrZsHPcUMdmThz9uwO0beptGh7yeHRQrxBjHCrZh6W
 Oec4Oj2AI+g1a3vCzIVs3487fm2/VAUYe0nJ2DxCXhBUYWZub0rxegTD/fVgOk7ln1T0 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1dj00p0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:45:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UEgHWN014243;
        Thu, 30 Jun 2022 14:45:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1dj00nyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:45:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UELLvK001956;
        Thu, 30 Jun 2022 14:45:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj8byv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:45:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UEjn6l19595528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 14:45:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C9A52050;
        Thu, 30 Jun 2022 14:45:49 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07AFB5204E;
        Thu, 30 Jun 2022 14:45:48 +0000 (GMT)
Message-ID: <03fff591-63e1-2dab-06d5-1fac242c248f@linux.ibm.com>
Date:   Thu, 30 Jun 2022 16:50:18 +0200
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
 <17c30662-7285-0e1a-91fb-071fa2cfc733@linux.ibm.com>
 <7741c617519b786750fbe04029fbb6295c8d6c85.camel@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <7741c617519b786750fbe04029fbb6295c8d6c85.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uzFNaawNg303gaMLjQF4qkwg89nNNtjf
X-Proofpoint-ORIG-GUID: GPI8DY7uDQv7WelYfyAChgLCkkvJ0ki2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/30/22 15:48, Niklas Schnelle wrote:
> On Thu, 2022-06-30 at 14:40 +0200, Pierre Morel wrote:
>>
>> On 6/28/22 16:30, Niklas Schnelle wrote:
>>> While determining the next PCI function is factored out of
>>> pci_scan_slot() into next_fn() the former still handles the first
>>> function as a special case. This duplicates the code from the scan loop.
>>>
>>> Furthermore the non ARI branch of next_fn() is generally hard to
>>> understand and especially the check for multifunction devices is hidden
>>> in the handling of NULL devices for non-contiguous multifunction. It
>>> also signals that no further functions need to be scanned by returning
>>> 0 via wraparound and this is a valid function number.
>>>
>>> Improve upon this by transforming the conditions in next_fn() to be
>>> easier to understand.
>>>
>>> By changing next_fn() to return -ENODEV instead of 0 when there is no
>>> next function we can then handle the initial function inside the loop
>>> and deduplicate the shared handling. This also makes it more explicit
>>> that only function 0 must exist.
>>>
>>> No functional change is intended.
>>>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>>    drivers/pci/probe.c | 38 +++++++++++++++++++-------------------
>>>    1 file changed, 19 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 17a969942d37..b05d0ed83a24 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2579,8 +2579,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>>>    }
>>>    EXPORT_SYMBOL(pci_scan_single_device);
>>>    
>>> -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
>>> -			    unsigned int fn)
>>> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>>>    {
>>>    	int pos;
>>>    	u16 cap = 0;
>>> @@ -2588,24 +2587,26 @@ static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
>>>    
>>>    	if (pci_ari_enabled(bus)) {
>>>    		if (!dev)
>>> -			return 0;
>>> +			return -ENODEV;
>>>    		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
>>>    		if (!pos)
>>> -			return 0;
>>> +			return -ENODEV;
>>>    
>>>    		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
>>>    		next_fn = PCI_ARI_CAP_NFN(cap);
>>>    		if (next_fn <= fn)
>>> -			return 0;	/* protect against malformed list */
>>> +			return -ENODEV;	/* protect against malformed list */
>>>    
>>>    		return next_fn;
>>>    	}
>>>    
>>> -	/* dev may be NULL for non-contiguous multifunction devices */
>>> -	if (!dev || dev->multifunction)
>>> -		return (fn + 1) % 8;
>>> +	if (fn >= 7)
>>> +		return -ENODEV;
>>> +	/* only multifunction devices may have more functions */
>>> +	if (dev && !dev->multifunction)
>>> +		return -ENODEV;
>>>    
>>> -	return 0;
>>> +	return fn + 1;
>>
>> No more % 8 ?
>> Even it disapear later shouldn't we keep it ?
> 
> The "% 8" became unnecessary due to the explicit "if (fn >= 7)"
> above.
> The original "% 8" did what I referred to in the commit message with
> "It [the function] also signals that no further functions need to be
> scanned by returning 0 via wraparound and this is a valid function
> number.". Instead we now explicitly return -ENODEV in this case.

Yes it goes with it.
With this code next_fn returns -ENODEV for fn = 8 instead of previously 
returning 1. (If I am right)

With the previous code, did we assume that next_fn is never called with 
fn > 7?
I guess yes as we test pci_ari_enabled first and without ARI we do not 
have more than 7 more functions. is it right?

For what I think this new code seems better as it does not make the 
assumption that it get called with fn < 8.

> 
>>
>>
>>
>>>    }
>>>    
>>>    static int only_one_child(struct pci_bus *bus)
>>> @@ -2643,26 +2644,25 @@ static int only_one_child(struct pci_bus *bus)
>>>     */
>>>    int pci_scan_slot(struct pci_bus *bus, int devfn)
>>>    {
>>> -	unsigned int fn, nr = 0;
>>>    	struct pci_dev *dev;
>>> +	int fn = 0, nr = 0;
>>>    
>>>    	if (only_one_child(bus) && (devfn > 0))
>>>    		return 0; /* Already scanned the entire slot */
>>>    
>>> -	dev = pci_scan_single_device(bus, devfn);
>>> -	if (!dev)
>>> -		return 0;
>>> -	if (!pci_dev_is_added(dev))
>>> -		nr++;
>>> -
>>> -	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
>>> +	do {
>>>    		dev = pci_scan_single_device(bus, devfn + fn);
>>>    		if (dev) {
>>>    			if (!pci_dev_is_added(dev))
>>>    				nr++;
>>> -			dev->multifunction = 1;
>>> +			if (fn > 0)
>>> +				dev->multifunction = 1;
>>> +		} else if (fn == 0) {
>>> +			/* function 0 is required */
>>> +			break;
>>>    		}
>>> -	}
>>> +		fn = next_fn(bus, dev, fn);
>>> +	} while (fn >= 0);
>>>    
>>>    	/* Only one slot has PCIe device */
>>>    	if (bus->self && nr)
>>>
>>
>> Otherwise LGTM
>>
> 
> Thanks for taking a look!
> 

-- 
Pierre Morel
IBM Lab Boeblingen
