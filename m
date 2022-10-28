Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A88610F8C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ1LTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ1LTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:19:42 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEA1006
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 04:19:30 -0700 (PDT)
X-ASG-Debug-ID: 1666955967-1eb14e7e615a670001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id FgnDhU8rPNPgZAr4 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 28 Oct 2022 19:19:27 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:19:27 +0800
Received: from [10.32.56.18] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:19:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <d4096cf3-7f16-b20c-01ea-e235bc90ae77@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.56.18
Date:   Fri, 28 Oct 2022 19:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <robert.moore@intel.com>, <ying.huang@intel.com>,
        <rdunlap@infradead.org>, <bhelgaas@google.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@acpica.org>
X-ASG-Orig-Subj: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>
References: <20221027031458.2855599-1-LeoLiu-oc@zhaoxin.com>
 <a0f29483-9557-9900-bcb7-ec832dc5d2d1@linux.intel.com>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <a0f29483-9557-9900-bcb7-ec832dc5d2d1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1666955967
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1763
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4979 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101736
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



在 2022/10/27 12:17, Sathyanarayanan Kuppuswamy 写道:
> 
> 
> On 10/26/22 8:14 PM, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> HEST PCIE AER error source information describes the Uncorrectable Error
>> Severity, CorrectableError Mask and other aer register's value to write to the
> 
> /s/CorrectableError/Correctable Error
> /s/aer/AER

Got it. I will modify this in next version patch set.

Thanks
leoliu-oc
> 
>> bridge's Correctable Error Mask register.
> 
> Can you add spec reference?
> 
Please refer to Section 18.3.2 ACPI Error Source of acpi spec v6.3. 
Links to the online versions of ACPI Spec 6.3 is
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/18_ACPI_Platform_Error_Interfaces/error-source-discovery.html#acpi-error-source. 

Section 18.3.2.4 describes PCI Express Root Port AER Structure, section 
18.3.2.5 describes PCI Express Device AER Structure, section 18.3.2.6 
describes PCI Express/PCI-X Bridge AER Structure.

Thanks
leoliu-oc
>>
>> leoliu-oc (5):
>>    ACPI/APEI: Add apei_hest_parse_aer()
>>    ACPI/APEI: remove static from apei_hest_parse()
>>    ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
>>    ACPI/PCI: Add pci_acpi_program_hest_aer_params()
>>    ACPI/PCI: config pcie devices's aer register
>>
>>   drivers/acpi/apei/hest.c      | 121 +++++++++++++++++++++++++++++++++-
>>   drivers/pci/pci-acpi.c        |  92 ++++++++++++++++++++++++++
>>   drivers/pci/pci.h             |   5 ++
>>   drivers/pci/probe.c           |   1 +
>>   include/acpi/actbl1.h         |  69 +++++++++++++++++++
>>   include/acpi/apei.h           |   9 +++
>>   include/uapi/linux/pci_regs.h |   5 ++
>>   7 files changed, 300 insertions(+), 2 deletions(-)
>>
> 
