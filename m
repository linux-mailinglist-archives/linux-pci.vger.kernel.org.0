Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C696DF0FC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDLJuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDLJuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 05:50:01 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FA65B9
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:49:59 -0700 (PDT)
X-ASG-Debug-ID: 1681292997-1eb14e6d7a6f5b0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id 4kBpg2Oifq8Tdx6B (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 12 Apr 2023 17:49:57 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 12 Apr
 2023 17:49:56 +0800
Received: from [10.32.64.2] (10.32.64.2) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 12 Apr
 2023 17:49:55 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <f3c4f38c-d45b-cf68-33e5-2e73dd73213d@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.2
Date:   Wed, 12 Apr 2023 17:49:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/5] ACPI/PCI: Add AER bits #defines for PCIe to
 PCI/PCI-X Bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 3/5] ACPI/PCI: Add AER bits #defines for PCIe to
 PCI/PCI-X Bridge
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20230407232220.GA3830804@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20230407232220.GA3830804@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681292997
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3198
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107310
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/4/8 7:22, Bjorn Helgaas 写道:
> Since this patch has nothing to do with ACPI, update subject line to:
> 
>    PCI: Add PCIe to PCI/PCI-X Bridge AER fields
> 

Your description is more reasonable and I will update the header of this 
patch later.

Yours sincerely,
Leoliu-oc

> On Tue, Nov 15, 2022 at 11:12:44AM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> Define secondary uncorrectable error mask register, secondary
>> uncorrectable error severity register and secondary error capabilities and
>> control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
>> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
>> 5.2.3.3 and 5.2.3.4.
> 
> Capitalize register names to match the spec usage.
> 
Your suggestion is right, I'll update this in the next release.

Yours sincerely,
Leoliu-oc
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Assuming this goes along with a patch series that adds uses of these
> definitions:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> ---
>>   include/uapi/linux/pci_regs.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 57b8e2ffb1dd..37f3baa336d7 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -799,6 +799,11 @@
>>   #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>>   #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
>>   
>> +/* PCIe advanced error reporting extended capabilities for PCIe to PCI/PCI-X Bridge */
>> +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
>> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
>> +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
> 
> Please squash these right up next to the other PCI_ERR_* definitions
> so it's obvious that they overlap PCI_ERR_ROOT_STATUS and
> PCI_ERR_ROOT_ERR_SRC (which is fine since one device can't have both),
> e.g.,
> 
>    #define PCI_ERR_ROOT_STATUS     0x30
>    #define  PCI_ERR_ROOT_COR_RCV           0x00000001 /* ERR_COR Received */
>    ...
>    #define PCI_ERR_ROOT_ERR_SRC    0x34    /* Error Source Identification */
>    #define PCI_ERR_UNCOR_MASK2     0x30    /* PCIe to PCI/PCI-X bridge */
>    #define PCI_ERR_UNCOR_SEVER2    0x34    /* PCIe to PCI/PCI-X bridge */
>    #define PCI_ERR_CAP2            0x38    /* PCIe to PCI/PCI-X bridge */
> 

I don't seem to understand what you mean. PCI_ERR_UNCOR_MASK2, 
PCI_ERR_UNCOR_SEVER2, and PCI_ERR_CAP2 represent the control and 
handling of individual errors that occur on traditional PCI or PCI-x 
secondary bus interfaces, these registers are valid only for Bridge. 
Although PCI_ERR_ROOT_ERR_SRC and PCI_ERR_UNCOR_SEVER2 have the same 
value, they represent register definitions for different device types.

Yours sincerely,
Leoliu-oc

>>   /* Virtual Channel */
>>   #define PCI_VC_PORT_CAP1	0x04
>>   #define  PCI_VC_CAP1_EVCC	0x00000007	/* extended VC count */
>> -- 
>> 2.20.1
>>
