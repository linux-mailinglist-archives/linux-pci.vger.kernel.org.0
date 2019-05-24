Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2129350
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbfEXInF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 04:43:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32932 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389478AbfEXInF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 04:43:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4O8gp4B024403;
        Fri, 24 May 2019 03:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558687371;
        bh=fin7XhZZt8YCoI8vomIMRZu6HitZPEiD+fW8ZGt0YLk=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RryeXkT1iXd8RNGAW3xhN0h2WU2blOPNNoJy1Kp+PfxFAN5vMjk6M4hUTHDMA4L48
         zVl8dDvCPgyj3Ah89N2m6KAJx9kVOTkB/sZnqP5mOjeB8z3ah7UWEG+7/Vg3SDjB0l
         P0M5EhH5IzkqNvagmza8Yu+KCmoN2mWKgNqiZYm0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4O8gpvA038357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 May 2019 03:42:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 24
 May 2019 03:42:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 24 May 2019 03:42:50 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4O8glfl071191;
        Fri, 24 May 2019 03:42:48 -0500
Subject: Re: [PATCH v2] PCI: endpoint: Set endpoint controller pointer to null
To:     Alan Mikhak <alan.mikhak@sifive.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGyb3zTaiRqt7-mvrS6Dvhu0Fkhjp4nvaJ-vaJrD3n=0_Q@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0e4cfe24-adf6-8966-9f58-69f7aba7a6fa@ti.com>
Date:   Fri, 24 May 2019 14:11:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGyb3zTaiRqt7-mvrS6Dvhu0Fkhjp4nvaJ-vaJrD3n=0_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24/05/19 5:27 AM, Alan Mikhak wrote:
> +Bjorn Helgaas
> 
> On Thu, May 23, 2019 at 2:46 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> Set endpoint controller pointer to null in pci_epc_remove_epf()
>> to avoid -EBUSY on subsequent call to pci_epc_add_epf().
>>
>> Requires checking for null endpoint function pointer.
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/endpoint/pci-epc-core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index e4712a0f249c..2091508c1620 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>>  {
>>         unsigned long flags;
>>
>> -       if (!epc || IS_ERR(epc))
>> +       if (!epc || IS_ERR(epc) || !epf)
>>                 return;
>>
>>         spin_lock_irqsave(&epc->lock, flags);
>>         list_del(&epf->list);
>> +       epf->epc = NULL;
>>         spin_unlock_irqrestore(&epc->lock, flags);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>> --
>> 2.7.4
>>
