Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7699435E7F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJUKCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:02:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41504 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhJUKCE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 06:02:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19L9xfxg064374;
        Thu, 21 Oct 2021 04:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634810381;
        bh=5J6m7tgno1BzBY3nY5levni6jbnm6AhGYz8qFE6UKyU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nYgnn8fRkq9xcQDvgbKTnEFXN0fqtCgiS8gKp9snWgCmnCRVD/zFEJTIfBJfCsuuW
         T/yhA2IfDJWcoi06em3i9sEE3YUnvDYgziT6VHiTkZRA8EwpAes5N/hjIp+YWKTlar
         WRAtRkrjSg7L8zRDAE7nEzcFeHpFnBD2a+lABMTs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19L9xfl3089251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Oct 2021 04:59:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Oct 2021 04:59:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Oct 2021 04:59:41 -0500
Received: from [10.250.235.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19L9xcWQ054766;
        Thu, 21 Oct 2021 04:59:39 -0500
Subject: Re: [EXT] Re: Linux PCIe EP NTB function
To:     Frank Li <frank.li@nxp.com>, "kw@linux.com" <kw@linux.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <AS8PR04MB850055DFB524C99D64560B6188B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
 <AS8PR04MB85008E09EAE36DFD6A51F4B588B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
 <459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com>
 <AS8PR04MB850020CCA53E0BA2378CCC5588BC9@AS8PR04MB8500.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ce049cab-ab31-eab7-39b6-835e43ecc265@ti.com>
Date:   Thu, 21 Oct 2021 15:29:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AS8PR04MB850020CCA53E0BA2378CCC5588BC9@AS8PR04MB8500.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 18/10/21 10:40 pm, Frank Li wrote:
> 
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Sunday, October 17, 2021 11:18 PM
>> To: Frank Li <frank.li@nxp.com>; kw@linux.com; Sherry Sun
>> <sherry.sun@nxp.com>; Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: linux-pci@vger.kernel.org
>> Subject: [EXT] Re: Linux PCIe EP NTB function
>>
>> Caution: EXT Email
>>
>> Hi Frank,
>>
>> On 15/10/21 2:10 am, Frank Li wrote:
>>> Sorry, correct Linux-pci mail list address.
>>>
>>>> -----Original Message-----
>>>> From: Frank Li
>>>> Sent: Thursday, October 14, 2021 3:35 PM
>>>> To: kishon@ti.com; kw@linux.com; Sherry Sun <sherry.sun@nxp.com>;
>> Richard
>>>> Zhu <hongxing.zhu@nxp.com>
>>>> Cc: inux-pci@vger.kernel.org
>>>> Subject: Linux PCIe EP NTB function
>>>>
>>>> Kishon:
>>>>
>>>>      We use VOP(virtio over PCIe) communication between PCI RC and EP
>> side.
>>>> But VOP already removed and switch into NTB solution.
>>>>      I saw you submit patch and already accepted by community about pci-
>>>> epf-ntb.
>>>>
>>>>      According to document, whole system work as Device1 (PCI host) ->
>> EP1
>>>> -> EP2 -> Device2(PCI host).
>>>>      But our user case is Device 1(RC Host) ->  Device 2(EP).
>>>>
>>>>      I am not sure how to apply ntb frame work into this user case.
>>
>> NTB by definition is PCIe RC-to-RC communication. For RC-to-EP, see
>> pci_endpoint_test.c (RC) and pci-epf-test.c (EP) that provides sample
>> endpoint
>> usecase.
>>
>> One more RC<->EP communication model was built in [1], but that is not yet
>> upstreamed.
> 
> Thank you very much. We already can run pci_endpoint_test, which
> is too basic and just proof data can transfer between RC and EP.
> 
> We want to hook into standard interface such as net. I also find below patches by
> Google. The patch set was sent out last years. What's reason why not continues such
> Work. I just saw NTB solution is acceptable by community.

I didn't have the bandwidth to pursue it. So the expectation was to update the
Virtio Spec to standardize PCIe RC to Configurable PCIe EP and then continue on
the patch series.

NTB provides a PCIe host side interface which cannot be used for PCIe endpoint.

Thanks,
Kishon

> 
> Previously we were working on VOP solution, kernel dropped VOP just when we prepare upstream
> our work. We don't want to these happen again. So I want to check RC-EP communication direction.
> 
> So we can work at the same directions.   
> 
> Best regards
> Frank Li
> 
>>
>> [1] ->
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kern
>> el.org%2Fr%2F20200702082143.25259-1-
>> kishon%40ti.com&amp;data=04%7C01%7Cfrank.li%40nxp.com%7C09c9aaaba663411c1bd
>> a08d991ee3cd4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6377012746822016
>> 79%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
>> aWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kJkAPZHywJfv9gwj5MhI9BUAG2veDyouMcBH%2B
>> rx8xWY%3D&amp;reserved=0
>>
>> Thanks,
>> Kishon
>>
>>>>
>>>>      I think we can modify pci-epf-ntb to register a ntb devices. But I
>> am
>>>> not sure that this is recommunicate method.  I think this user case is
>>>> quite common. I don't want to implement a local solution.
>>>>
>>>>      Any suggestion?
>>>>
>>>>
>>>> Best regards
>>>> Frank Li
