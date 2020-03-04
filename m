Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8841789D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 06:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgCDFK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 00:10:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDFK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 00:10:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0245Aj6M021833;
        Tue, 3 Mar 2020 23:10:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583298645;
        bh=3uVn5qRo3GIhs0+ZbtDUve7iCbFJIoICLR+tQsFcDj0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SXGn1tDVA49ju/vtsxC1o7ab7U82Vbrb7oPVdm60wwpx+s3pa/tzbojstV6oHqrQ0
         TCCCzqJRKfwlMG5MaX/ZNGvIh6DeXwu738wDedIw60zeVhn/2wd7en+Wliu1+/iKGs
         fGWrk6Ry3WfMkbjoQBF3Kc8Ihw9lseAiQADPaCds=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0245AjBD049080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 23:10:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 23:10:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 23:10:45 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0245AfCp025360;
        Tue, 3 Mar 2020 23:10:42 -0600
Subject: Re: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA
 support to transfer data
To:     Alan Mikhak <alan.mikhak@sifive.com>
CC:     <amurray@thegoodpenguin.co.uk>, <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>
References: <20200225091130.29467-1-kishon@ti.com>
 <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
 <7e1202a3-037b-d1f3-f2bf-1b8964787ebd@ti.com>
 <CABEDWGz=4E8mYx0usw4A1UAMHrq+MGyKOX47yO7Cdgmcq=aOag@mail.gmail.com>
 <CABEDWGwejv-1h=pLt_o5n=Mct+6r9oQdQCLT7GZSMgBR2bDJHg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <eb57e52a-be34-dd2c-3820-21fe7dc68185@ti.com>
Date:   Wed, 4 Mar 2020 10:45:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABEDWGwejv-1h=pLt_o5n=Mct+6r9oQdQCLT7GZSMgBR2bDJHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 04/03/20 5:27 am, Alan Mikhak wrote:
> On Wed, Feb 26, 2020 at 9:39 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> On Tue, Feb 25, 2020 at 9:27 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Hi Alan,
>>>
>>> On 26/02/20 2:41 am, Alan Mikhak wrote:
>>>> @@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>>>>         int bar;
>>>>
>>>>         cancel_delayed_work(&epf_test->cmd_handler);
>>>> +       pci_epf_clean_dma_chan(epf_test);
>>>>         pci_epc_stop(epc);
>>>>         for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>>>>                 epf_bar = &epf->bar[bar];
>>>> @@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>>                 }
>>>>         }
>>>>
>>>> +       epf_test->dma_supported = true;
>>>> +
>>>> +       ret = pci_epf_init_dma_chan(epf_test);
>>>> +       if (ret)
>>>> +               epf_test->dma_supported = false;
>>>> +
>>>>         if (linkup_notifier) {
>>>>                 epf->nb.notifier_call = pci_epf_test_notifier;
>>>>                 pci_epc_register_notifier(epc, &epf->nb);
>>>>
>>>> Hi Kishon,
>>>>
>>>> Looking forward to building and trying this patch series on
>>>> a platform I work on.
> 
> Hi Kishon,
> 
> I applied this v1 patch series to kernel.org linux 5.6-rc3 and built for
> x86_64 Debian and riscv. I verified that when I execute the pcitest
> command on the x86_64 host with -d flag, the riscv endpoint performs
> the transfer by using an available dma channel.

Thank you for testing this.
I've posted a new version after renaming the function names to
pci_epf_test_init_dma_chan() and pci_epf_test_cleanup_dma_chan() [1]
Can you add your "Tested-by: " tag in that series so that Lorenzo can
pick it up?

Thanks
Kishon

[1] -> http://lore.kernel.org/r/20200303103752.13076-1-kishon@ti.com

> 
> Regards,
> Alan
> 
>>>>
>>>> Would you please point me to where I can find the patches
>>>> which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
>>>> to Linux PCI Endpoint Framework?
>>>
>>> I've added these functions in pci-epf-test itself instead of adding in
>>> the core files. I realized adding it in core files may not be helpful if
>>> the endpoint function decides to use more number of DMA channels etc.,
>>
>> Thanks Kishon,
>>
>> I now realize they are in [PATCH 1/5] of this series. May I suggest renaming
>> them to pci_epf_test_init_dma_chan() and pci_epf_test_cleanup_dma_chan()?
>> With just pci_epf in their name, I was looking for them in pci-epf-core.c.
>>
>> Regards,
>> Alan
>>
>>>
>>> Thanks
>>> Kishon
