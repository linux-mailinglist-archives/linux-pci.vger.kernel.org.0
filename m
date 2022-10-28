Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEB610FD4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJ1Lgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1Lgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:36:46 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B31BF859
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 04:36:44 -0700 (PDT)
X-ASG-Debug-ID: 1666957000-086e23532653f60001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id mfrDrxpG1r2GxzZG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 28 Oct 2022 19:36:40 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:36:40 +0800
Received: from [10.32.56.18] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:36:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <5a601e85-cd6c-2d42-a2db-d706a64718c9@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.56.18
Date:   Fri, 28 Oct 2022 19:36:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] ACPI/APEI: Add apei_hest_parse_aer()
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 1/5] ACPI/APEI: Add apei_hest_parse_aer()
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20221027220746.GA844491@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20221027220746.GA844491@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1666957000
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2739
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4890 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101737
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/10/28 6:07, Bjorn Helgaas 写道:
> On Thu, Oct 27, 2022 at 11:15:18AM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> apei_hest_parse_aer() is used to parse and record the PCI Express AER
>> Structure in the HEST Table.
>>
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/apei/hest.c | 119 ++++++++++++++++++++++++++++++++++++++-
>>   include/acpi/actbl1.h    |  69 +++++++++++++++++++++++
>>   include/acpi/apei.h      |   7 +++
>>   3 files changed, 194 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 6aef1ee5e1bd..0bfdc18758f5 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/platform_device.h>
>>   #include <acpi/apei.h>
>>   #include <acpi/ghes.h>
>> +#include <linux/pci.h>
>>   
>>   #include "apei-internal.h"
>>   
>> @@ -86,7 +87,48 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>   	return len;
>>   };
>>   
>> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>> +static inline bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
> 
> Drop "inline" here and below.  This is not a performance path, so it's
> more clutter than it's worth.

Yes, I agree with it. Will fix it in the next version.

Thanks
leoliu-oc

>> +static inline bool hest_match_pci(struct acpi_hest_header *hest_hdr,
>> +		struct acpi_hest_aer_common *p, struct pci_dev *pci)
>> +{
>> +	if (hest_match_type(hest_hdr, pci))
>> +		return(hest_match_pci_devfn(p, pci));
> 
> No need for parens around hest_match_pci_devfn().
> 
>> +	else
> 
> You can drop the else, too.
> 

Yes, Agree with it. I will also fix it in the next version.

Thanks
leoliu-oc
>> +		return false;
>> +}
> 
>> + * apei_hest_parse_aer - Find the AER structure in the HEST Table and
>> + * match it with the PCI device.
>> + *
>> + * @hest_hdr: To save the acpi aer error source in hest table
>> + *
>> + * Return 1 if the pci dev matched with the acpi aer error source in
>> + * hest table, else return 0.
> 
> In comments and commit logs,
> 
>    s/pci/PCI/
>    s/aer/AER/
>    s/acpi/ACPI/
>    s/hest/HEST/
>    s/HEST Table/HEST/ (since the "T" in "HEST" stands for "Table")
> 
>> +/* HEST Sub-structure for PCIE EndPoint Structure (6) */
> 
> PCIe Root Port, if I'm following this correctly.
> 
>> +/* HEST Sub-structure for PCIE EndPoint Structure (7) */
> 
> PCIe Endpoint.
> 
>> +/* HEST Sub-structure for PCIE/PCI Bridge Structure (8) */
> 
> PCIe/PCI-X Bridge

Got it, will modify it in the next version.

Thanks
leoliu-oc
