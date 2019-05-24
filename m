Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4877C2936D
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbfEXIvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 04:51:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48556 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbfEXIvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 04:51:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4O8ovh5094264;
        Fri, 24 May 2019 03:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558687857;
        bh=Aje9IYjKWVDmlh2mOCB+vZPfc1Meqh7hIaNo9RIRcMs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QmK2v5jvRYSYeDLbuCGoHeyk2u7tDrXAVYJWkzMEHfwk+sbe2PIikuxmpzpO2thCX
         H/OydCpeq2HfxCpZJRxBjAEOUksuSCIe9E2rqTGB7k90WbtJpYzCyOVvuwPhaPXQDm
         zS0DNQTqcKxeBuATkwHI439JFkhJZTVCyAm1UDUE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4O8ovUt048595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 May 2019 03:50:57 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 24
 May 2019 03:50:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 24 May 2019 03:50:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4O8or34125751;
        Fri, 24 May 2019 03:50:54 -0500
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
To:     Alan Mikhak <alan.mikhak@sifive.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <wen.yang99@zte.com.cn>,
        <kjlu@umn.edu>
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <baa68439-f703-a453-34a2-24387bb9112d@ti.com>
Date:   Fri, 24 May 2019 14:19:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/05/19 5:25 AM, Alan Mikhak wrote:
> +Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu
> 
> On Thu, May 23, 2019 at 2:55 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> Always skip odd bar when skipping 64bit BARs in pci_epf_test_set_bar()
>> and pci_epf_test_alloc_space().
>>
>> Otherwise, pci_epf_test_set_bar() will call pci_epc_set_bar() on odd loop
>> index when skipping reserved 64bit BAR. Moreover, pci_epf_test_alloc_space()
>> will call pci_epf_alloc_space() on bind for odd loop index when BAR is 64bit
>> but leaks on subsequent unbind by not calling pci_epf_free_space().
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
>> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 27806987e93b..96156a537922 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>>
>>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>>  {
>> -       int bar;
>> +       int bar, add;
>>         int ret;
>>         struct pci_epf_bar *epf_bar;
>>         struct pci_epc *epc = epf->epc;
>> @@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>>
>>         epc_features = epf_test->epc_features;
>>
>> -       for (bar = BAR_0; bar <= BAR_5; bar++) {
>> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
>>                 epf_bar = &epf->bar[bar];
>> +               /*
>> +                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
>> +                * if the specific implementation required a 64-bit BAR,
>> +                * even if we only requested a 32-bit BAR.
>> +                */

set_bar shouldn't set PCI_BASE_ADDRESS_MEM_TYPE_64. If a platform supports only
64-bit BAR, that should be specified in epc_features bar_fixed_64bit member.

Thanks
Kishon
