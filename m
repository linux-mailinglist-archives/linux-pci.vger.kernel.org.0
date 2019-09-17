Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC770B46EA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfIQFlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 01:41:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37974 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQFlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 01:41:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8H5etax020871;
        Tue, 17 Sep 2019 00:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568698855;
        bh=KrUGt79L9HyCReyRHy+1q7weFGZYycU7t3SvXD8FMjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rPP77/drpjX80wevN/uf2h4aL9EqqnnWsRtm8KsqulnHb+cV5MXs2Uvn/1ROtP1p2
         WwDwPYzkADTc7nj95BnK+fb4xuN4sl9AnLjIvT0NgsNUAjT+KAAbTsKFuIGFNVHAzv
         7anpduu0AStmrvwfpZftm3YumoWYMc2Dq5lUzr7M=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8H5etfQ075764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Sep 2019 00:40:55 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 17
 Sep 2019 00:40:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 17 Sep 2019 00:40:52 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8H5ep9o094511;
        Tue, 17 Sep 2019 00:40:52 -0500
Subject: Re: pci: endpoint test BUG
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hillf Danton <hdanton@sina.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190916020630.1584-1-hdanton@sina.com>
 <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <815ad936-8b98-0931-89f7-b97922a7c77d@ti.com>
Date:   Tue, 17 Sep 2019 11:10:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 16/09/19 4:52 PM, Lorenzo Pieralisi wrote:
> On Mon, Sep 16, 2019 at 10:06:30AM +0800, Hillf Danton wrote:
>>
>> On Sun, 15 Sep 2019 09:34:37 -0700
>>>
>>> Kernel is 5.3-rc8 on x86_64.
>>>
>>> Loading and removing the pci-epf-test module causes a BUG.
>>>
>>>
>>> [40928.435755] calling  pci_epf_test_init+0x0/0x1000 [pci_epf_test] @ 12132
>>> [40928.436717] initcall pci_epf_test_init+0x0/0x1000 [pci_epf_test] returned 0 after 891 usecs
>>> [40936.996081] ==================================================================
>>> [40936.996125] BUG: KASAN: use-after-free in pci_epf_remove_cfs+0x1ae/0x1f0
>>> [40936.996153] Write of size 8 at addr ffff88810a22a068 by task rmmod/12139
>>
>> Fix fb0de5b8dcc6 and ef1433f717a2 if the current group::group_entry
>> used by pci epf does not break how configfs uses it.
>>
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -153,9 +153,11 @@ static void pci_epf_remove_cfs(struct pc
>>  		return;
>>  
>>  	mutex_lock(&pci_epf_mutex);
>> -	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>> +	list_for_each_entry_safe(group, tmp, &driver->epf_group,
>> +							group_entry) {
>> +		list_del_init(&group->group_entry);
>>  		pci_ep_cfs_remove_epf_group(group);
>> -	list_del(&driver->epf_group);
>> +	}
>>  	mutex_unlock(&pci_epf_mutex);
>>  }


Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> 
> Thank you Hillf. Kishon, can you confirm that's the proper fix for
> this bug please ? I would like to turn this into a patch and merge
> it in the upcoming merge window PR so it ought to be fairly quick,
> please let me know asap.
> 
> Lorenzo
> 
