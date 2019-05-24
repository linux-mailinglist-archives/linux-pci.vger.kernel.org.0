Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403C029371
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbfEXIwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 04:52:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbfEXIwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 04:52:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4O8psb4026496;
        Fri, 24 May 2019 03:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558687914;
        bh=tVT52Dzdto40qLgUQsoiwvxwFkE3lFwq1Lgc68900vM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Kcvrh1kXVoX/YJiWEs8BfbWsIDglItrja6+dBLtuB9DVYFkvrV0oRVqmyjZk4oTp7
         grZVsyeaA5YhCj8O6plfJUE8oIS279hb7BaWMb/8nIEa55c8C9QM97qR75Kj193kCD
         SMgZoWRxEJuw2ANWHSTkyUNAbtbzE+Ks3V0XzjJU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4O8psvr094843
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 May 2019 03:51:54 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 24
 May 2019 03:51:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 24 May 2019 03:51:54 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4O8poJT045361;
        Fri, 24 May 2019 03:51:50 -0500
Subject: Re: [PATCH v2] PCI: endpoint: Clear BAR before freeing its space
To:     Alan Mikhak <alan.mikhak@sifive.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <wen.yang99@zte.com.cn>,
        <kjlu@umn.edu>
References: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGy8PhHqqRPpZjVrd3VtwxmtxV+Gs-8442e9EvKjFQLELw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a1787130-9f36-3e0f-f35e-640a47dfdf5f@ti.com>
Date:   Fri, 24 May 2019 14:20:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGy8PhHqqRPpZjVrd3VtwxmtxV+Gs-8442e9EvKjFQLELw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24/05/19 5:20 AM, Alan Mikhak wrote:
> +Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu
> 
> 
> On Thu, May 23, 2019 at 2:57 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
>> would be cleared in pci_epf_free_space(), if called first, and BAR
>> would not get cleared.
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 27806987e93b..f81a219dde5b 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>>                 epf_bar = &epf->bar[bar];
>>
>>                 if (epf_test->reg[bar]) {
>> -                       pci_epf_free_space(epf, epf_test->reg[bar], bar);
>>                         pci_epc_clear_bar(epc, epf->func_no, epf_bar);
>> +                       pci_epf_free_space(epf, epf_test->reg[bar], bar);
>>                 }
>>         }
>>  }
>> --
>> 2.7.4
>>
