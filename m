Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAB611024
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJ1L5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJ1L5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:57:07 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9661D2F5F
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 04:57:01 -0700 (PDT)
X-ASG-Debug-ID: 1666958216-086e23532754130001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id xPvKL4IXIYgT3cjC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 28 Oct 2022 19:56:57 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:56:56 +0800
Received: from [10.32.56.18] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:56:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <8472b248-11ac-2148-e39f-12647044332b@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.56.18
Date:   Fri, 28 Oct 2022 19:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X
 bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X
 bridges
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20221027215644.GA844326@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20221027215644.GA844326@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1666958217
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1390
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4999 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101737
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/10/28 5:56, Bjorn Helgaas 写道:
> On Thu, Oct 27, 2022 at 11:15:54AM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> Define PCI Express Advanced Error Reporting Extended Capabilities bits.
>>
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   include/uapi/linux/pci_regs.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 57b8e2ffb1dd..3662106fd8dc 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -799,6 +799,11 @@
>>   #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>>   #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
>>   
>> +/* PCI Express Advanced Error Reporting Extended Capabilities for Bridges */
>> +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
>> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
>> +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
> 
> Can you include a spec reference for these?  I'm looking at PCIe r6.0,
> sec 7.8.4, and I don't see anything I can match up with these.
> 
> Bjorn
Please refer to PCI Express to PCI/PCI-X Bridge Specification, sec 
5.2.3.2, 5.2.3.3 and 5.2.3.4.

Thanks
leoliu-oc
