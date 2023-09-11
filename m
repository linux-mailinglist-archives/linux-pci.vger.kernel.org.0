Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5979BE9E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbjIKVhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjIKJzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 05:55:13 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C6E68
        for <linux-pci@vger.kernel.org>; Mon, 11 Sep 2023 02:55:08 -0700 (PDT)
X-ASG-Debug-ID: 1694426104-086e234a2b485f0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id Y8LIEnxLF2E8zCXN (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 11 Sep 2023 17:55:04 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:55:02 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:54:56 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <9e4fa680-f96e-4dfc-a047-37a2a5f8b779@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Mon, 11 Sep 2023 17:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ACPI/APEI: Remove static from apei_hest_parse()
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v3 2/5] ACPI/APEI: Remove static from apei_hest_parse()
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <ErosZhang@zhaoxin.com>
References: <20230810231718.GA49532@bhelgaas>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230810231718.GA49532@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1694426104
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3311
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113956
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/11 7:17, Bjorn Helgaas 写道:
> On Tue, Jul 04, 2023 at 08:05:17PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> Each dev with AER capability needs to call the apei_hest_parse function to
>> match and extract register values from HEST PCIe AER structures.
>> Therefore, remove static from apei_hest_parse() so that it can be called
>> in another file.
> 
> Can you reword the subject line and commit log in the positive?
> "Removing static" is a negative thing and it's semantically a bit too
> low level -- it's clearly what the *code* does, but we can see that
> from the patch, and what we want to know here is *why* it's important.
> What this really does is expose apei_hest_parse() for use by other
> subsystems.
> 
> Browsing the drivers/acpi commit log history, I see that Rafael adds
> "()" after function names, so please do the same here (you did do that
> once above, but not in the first line).
> 


This function is required in patch v3 4/5 to traverse the HEST to find 
the HEST AER structures, so changed the definition to be global.

I will pay attention to this matter in the next version.

LeoLiu-oc

>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/apei/hest.c | 2 +-
>>   include/acpi/apei.h      | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index fb839a5c480ee..fd40c035c9b2e 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -132,7 +132,7 @@ static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
>>   	return false;
>>   }
>>   
>> -static int apei_hest_parse(apei_hest_func_t func, void *data)
>> +int apei_hest_parse(apei_hest_func_t func, void *data)
> 
> If this is going to exported to the PCI subsystem, I think it needs
> some kernel-doc.  For example, it's important to know that it stops
> parsing the HEST if func returns anything non-zero.  This is how
> pci_acpi_program_hest_aer_params() knows that it got good data that
> matches the device it wants.
> 
> Given the fact that apei_hest_parse_aer() fills in the struct
> acpi_hest_parse_aer_info with pointers into the HEST table data, it's
> also important to know that this HEST table data is persistent.
>
Thank you suggestion, and I will consider carefully.

Best Regards.
LeoLiu-oc

>>   {
>>   	struct acpi_hest_header *hest_hdr;
>>   	int i, rc, len;
>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>> index 8a0b2b9edbafe..f975e4fe78fcb 100644
>> --- a/include/acpi/apei.h
>> +++ b/include/acpi/apei.h
>> @@ -37,9 +37,14 @@ typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>   
>>   #ifdef CONFIG_ACPI_APEI
>>   void __init acpi_hest_init(void);
>> +int apei_hest_parse(apei_hest_func_t func, void *data);
>>   int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
>>   #else
>>   static inline void acpi_hest_init(void) { }
>> +static inline int apei_hest_parse(apei_hest_func_t func, void *data)
>> +{
>> +	return -EINVAL;
>> +}
>>   static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
>>   {
>>   	return -EINVAL;
>> -- 
>> 2.34.1
>>
