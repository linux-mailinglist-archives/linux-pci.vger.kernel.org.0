Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0D28F5E6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgJOPdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 11:33:03 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:31198 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388749AbgJOPdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 11:33:03 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09FFWrnQ031557;
        Thu, 15 Oct 2020 15:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=tsCv5a712czLA1nu4qAvu55PQpGk+2CkmwhjuDiy1lY=;
 b=Ub6+qobNt/BbUjStNVakejVKlwCj2SwgZYdR+x1rcyaGuRV8TImVcDVEe/DDmx6zeNOG
 iBwlX9sOz91eD63wXQsU6ZXm2M7u1U3KDg5g7j7faXN44ogPLO4Wffu+dzVI4c9PtPFn
 iaa8haiBTgrNjkFIJtAw+gCafRdqmj47xH/TuFuIIGmsjBRFU3bF8ij96oasYEXbypBt
 f+jr3ZdDUGKwlV3wEejZF5kGHINayHxN4tXDjXTrd3CT97oncj93uzREmBsgitM95jRk
 bXr4LgQ5W165xGAMYEfLRCfBZIsFyOtIYhh+dWBp6jw4s6IkAbPJny1tm+SKsP/Zz7vW sw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 345gq7by1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 15:32:53 +0000
Received: from sarge.linuxathome.me (unknown [16.29.146.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id AC5138C;
        Thu, 15 Oct 2020 15:32:36 +0000 (UTC)
Date:   Thu, 15 Oct 2020 16:32:33 +0100
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: Re: [RESEND PATCH v3 1/1] PCI/ERR: don't clobber status after
 reset_link()
Message-ID: <20201015153233.GE8203@sarge.linuxathome.me>
Mail-Followup-To: Sinan Kaya <okaya@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org
References: <20201010221653.2782993-1-hedi.berriche@hpe.com>
 <20201010221653.2782993-2-hedi.berriche@hpe.com>
 <5f5eeaf4-4638-6718-1ec9-002d6753e73f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5f5eeaf4-4638-6718-1ec9-002d6753e73f@kernel.org>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_09:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=1 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150105
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 11, 2020 at 18:56 Sinan Kaya wrote:
>On 10/10/2020 6:16 PM, Hedi Berriche wrote:
>> Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>> broke pcie_do_recovery(): updating status after reset_link() has the ill
>> side effect of causing recovery to fail if the error status is
>> PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET as the following
>> code will *never* run in the case of a successful reset_link()
>>
>>    177         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>    ...
>>    181         }
>>
>>    183         if (status == PCI_ERS_RESULT_NEED_RESET) {
>>    ...
>>    192         }
>>
>> For instance in the case of PCI_ERS_RESULT_NEED_RESET we end up not
>> calling ->slot_reset() (because we skip report_slot_reset()) thus
>> breaking driver (re)initialisation.
>>
>> Don't clobber status with the return value of reset_link(); set status
>> to PCI_ERS_RESULT_RECOVERED, in case of successful link reset, if and
>> only if the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>> or PCI_ERS_RESULT_NO_AER_DRIVER.
>>
>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
>> Cc: Russ Anderson <rja@hpe.com>
>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Joerg Roedel <jroedel@suse.com>
>>
>> Cc: stable@kernel.org # v5.7+
>> ---
>>  drivers/pci/pcie/err.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index c543f419d8f9..2730826cfd8a 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -165,10 +165,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen) {
>>  		pci_walk_bus(bus, report_frozen_detected, &status);
>> -		status = reset_link(dev);
>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(dev, "link reset failed\n");
>>  			goto failed;
>> +		} else {
>> +			if (status == PCI_ERS_RESULT_DISCONNECT ||
>> +			    status == PCI_ERS_RESULT_NO_AER_DRIVER)
>> +				status = PCI_ERS_RESULT_RECOVERED;
>>  		}
>>  	} else {
>>  		pci_walk_bus(bus, report_normal_detected, &status);
>>
>
>Reviewed-by: Sinan Kaya <okaya@kernel.org>

Thanks for the Reviewed-by, Sinan.

Folks,

Any further comments or is this ripe for acceptance?

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
