Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5118CB74
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCTKVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 06:21:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39652 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCTKVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 06:21:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02KAKwg1024302;
        Fri, 20 Mar 2020 05:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584699658;
        bh=rn+lqi6S8AMGiEUZ5KYnC/dX2IgyH3wA5+iFbZlmJVU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=n7bPyOtSVxozgzY+7p0JqNOfXGcBqQiwqk6ci2qDVI6/XFXgv3CeqE4Y0o37olaNq
         OairtZe9Udu4OF4G68Nlg5zBSc8i/HA/TjqyxavwUZcIZuNwo4saorLFhzR7k1DROs
         JOgGkjtTNb68kxYjrv3HOGC3eCOcyJHariOH6oHc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02KAKwas088376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 05:20:58 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 05:20:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 05:20:57 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02KAKsKP008091;
        Fri, 20 Mar 2020 05:20:55 -0500
Subject: Re: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
To:     Sriram Dash <sriram.dash@samsung.com>,
        "'Shradha Todi'" <shradha.t@samsung.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <pankaj.dubey@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
 <20200311102852.5207-1-shradha.t@samsung.com>
 <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a7a6a295-160a-94d6-09f9-63f783c8b28a@ti.com>
Date:   Fri, 20 Mar 2020 15:50:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sriram,

On 3/19/2020 7:06 PM, Sriram Dash wrote:
>> From: Shradha Todi <shradha.t@samsung.com>
>> Subject: [PATCH] PCI: endpoint: Fix NULL pointer dereference for -
>>> get_features()
>>
>> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
>> dereference in pci_epf_test_bind function. Let us add a check for
>> pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid any
>> such NULL pointer dereference and return -ENOTSUPP in case pci_epc_feature
>> is not found.
>>
>> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
>> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
>> ---
> 
> Hi Kishon,
> 
> Any update on this?

Don't we access epc_features only after checking if epc_features is not NULL in
pci_epf_test_bind() function? However we are accessing epc_features in multiple
other functions all over pci-epf-test.

So the patch itself is correct though the commit log has to be fixed. You
should also check if all the endpoint controller drivers existing currently
provides epc_features.

Thanks
Kishon
> 
> 
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
>> b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index c9121b1b9fa9..af4537a487bf 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -510,14 +510,17 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>  		return -EINVAL;
>>
>>  	epc_features = pci_epc_get_features(epc, epf->func_no);
>> -	if (epc_features) {
>> -		linkup_notifier = epc_features->linkup_notifier;
>> -		msix_capable = epc_features->msix_capable;
>> -		msi_capable = epc_features->msi_capable;
>> -		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>> -		pci_epf_configure_bar(epf, epc_features);
>> +	if (!epc_features) {
>> +		dev_err(dev, "epc_features not implemented\n");
>> +		return -ENOTSUPP;
>>  	}
>>
>> +	linkup_notifier = epc_features->linkup_notifier;
>> +	msix_capable = epc_features->msix_capable;
>> +	msi_capable = epc_features->msi_capable;
>> +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>> +	pci_epf_configure_bar(epf, epc_features);
>> +
>>  	epf_test->test_reg_bar = test_reg_bar;
>>  	epf_test->epc_features = epc_features;
>>
>> --
>> 2.17.1
> 
> 
