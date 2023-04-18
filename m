Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F56E5799
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 04:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDRCuw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRCuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 22:50:51 -0400
X-Greylist: delayed 702 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 19:50:49 PDT
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291E740D2
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 19:50:48 -0700 (PDT)
X-ASG-Debug-ID: 1681785542-086e237e5218da0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id CDsaA5w1Rrb9DrPG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 18 Apr 2023 10:39:02 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 10:39:02 +0800
Received: from [10.32.64.2] (10.32.64.2) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 10:39:00 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <dd3e967a-1f1a-9d3e-1058-a5e7951b1dbd@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.2
Date:   Tue, 18 Apr 2023 10:38:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
        <leoliu@zhaoxin.com>
References: <20230412161012.GA48719@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20230412161012.GA48719@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681785542
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2519
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107569
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/4/13 0:10, Bjorn Helgaas 写道:
> On Wed, Apr 12, 2023 at 05:49:55PM +0800, LeoLiuoc wrote:
> 
>>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>>> index 57b8e2ffb1dd..37f3baa336d7 100644
>>>> --- a/include/uapi/linux/pci_regs.h
>>>> +++ b/include/uapi/linux/pci_regs.h
>>>> @@ -799,6 +799,11 @@
>>>>    #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>>>>    #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
>>>> +/* PCIe advanced error reporting extended capabilities for PCIe to PCI/PCI-X Bridge */
>>>> +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
>>>> +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
>>>> +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
>>>
>>> Please squash these right up next to the other PCI_ERR_* definitions
>>> so it's obvious that they overlap PCI_ERR_ROOT_STATUS and
>>> PCI_ERR_ROOT_ERR_SRC (which is fine since one device can't have both),
>>> e.g.,
>>>
>>>     #define PCI_ERR_ROOT_STATUS     0x30
>>>     #define  PCI_ERR_ROOT_COR_RCV           0x00000001 /* ERR_COR Received */
>>>     ...
>>>     #define PCI_ERR_ROOT_ERR_SRC    0x34    /* Error Source Identification */
>>>     #define PCI_ERR_UNCOR_MASK2     0x30    /* PCIe to PCI/PCI-X bridge */
>>>     #define PCI_ERR_UNCOR_SEVER2    0x34    /* PCIe to PCI/PCI-X bridge */
>>>     #define PCI_ERR_CAP2            0x38    /* PCIe to PCI/PCI-X bridge */
>>
>> I don't seem to understand what you mean. PCI_ERR_UNCOR_MASK2,
>> PCI_ERR_UNCOR_SEVER2, and PCI_ERR_CAP2 represent the control and handling of
>> individual errors that occur on traditional PCI or PCI-x secondary bus
>> interfaces, these registers are valid only for Bridge. Although
>> PCI_ERR_ROOT_ERR_SRC and PCI_ERR_UNCOR_SEVER2 have the same value, they
>> represent register definitions for different device types.
> 
> Right.  I just don't want the blank line in the middle because it
> might be mistaken for items in a different capability.  All the other
> AER capability registers are defined together in a block, with no
> blank lines in the middle, so I think these new ones should be part of
> that block.
> 
> Bjorn

Ok，I see your point. Do you think this line of comment is still necessary?
/* PCIe advanced error reporting extended capabilities for PCIe to 
PCI/PCI-X Bridge */

Yours sincerely,
Leoliu-oc


