Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E832C2935A
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfEXIqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 04:46:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47892 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389349AbfEXIqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 04:46:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4O8k6S3092885;
        Fri, 24 May 2019 03:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558687566;
        bh=DXFEDPWPKDOFxRB075nEECWtEkWPXsJvcN4FB3Z5q1Y=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Bfhp6HtrbU4jNqmpwALOr7PuPYMbsCKxQAY9SrbT2FRyn33xyzinHbS+fW9MZ9YYx
         woEVabr2VXFv/C4NiUl2k5nSdN1vJQHlaR/2WZbchu/o3/4R98whqTp16nuMVOj57N
         rLPDj86zqVw1fiKqm8tqzOgD8n/QDDsr/Gophvi8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4O8k6Gj087569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 May 2019 03:46:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 24
 May 2019 03:46:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 24 May 2019 03:46:05 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4O8k1C2076108;
        Fri, 24 May 2019 03:46:02 -0500
Subject: Re: [PATCH v2] PCI: endpoint: Allocate enough space for fixed size
 BAR
To:     Alan Mikhak <alan.mikhak@sifive.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <wen.yang99@zte.com.cn>,
        <kjlu@umn.edu>
References: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGxMXg7RAgrUL-7W6vgC0BpCj9ys+i7myjxdBgn3vn_P6Q@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a08ce87a-d515-b1c3-a903-6777e18c87ae@ti.com>
Date:   Fri, 24 May 2019 14:14:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGxMXg7RAgrUL-7W6vgC0BpCj9ys+i7myjxdBgn3vn_P6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24/05/19 5:26 AM, Alan Mikhak wrote:
> +Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu
> 
> On Thu, May 23, 2019 at 2:48 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> PCI endpoint test function code should honor the .bar_fixed_size parameter
>> from underlying endpoint controller drivers or results may be unexpected.
>>
>> In pci_epf_test_alloc_space(), check if BAR being used for test register
>> space is a fixed size BAR. If so, allocate the required fixed size.
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 27806987e93b..7d41e6684b87 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>         int bar;
>>         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>         const struct pci_epc_features *epc_features;
>> +       size_t test_reg_size;
>>
>>         epc_features = epf_test->epc_features;
>>
>> -       base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
>> +       if (epc_features->bar_fixed_size[test_reg_bar])
>> +               test_reg_size = bar_size[test_reg_bar];
>> +       else
>> +               test_reg_size = sizeof(struct pci_epf_test_reg);
>> +
>> +       base = pci_epf_alloc_space(epf, test_reg_size,
>>                                    test_reg_bar, epc_features->align);
>>         if (!base) {
>>                 dev_err(dev, "Failed to allocated register space\n");
>> --
>> 2.7.4
>>
