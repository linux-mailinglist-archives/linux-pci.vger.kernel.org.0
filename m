Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2479610F94
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJ1LXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJ1LXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:23:39 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877121CDCE0
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 04:23:38 -0700 (PDT)
X-ASG-Debug-ID: 1666956215-1eb14e7e625a6e0001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id COoKn7aXrtQcQk2X (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 28 Oct 2022 19:23:35 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:23:35 +0800
Received: from [10.32.56.18] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 28 Oct
 2022 19:23:33 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <be1c96d6-7c2e-d3a0-1ae9-05babd49ab09@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.56.18
Date:   Fri, 28 Oct 2022 19:23:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20221027220931.GA843829@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20221027220931.GA843829@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1666956215
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2173
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4963 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101736
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



在 2022/10/28 6:09, Bjorn Helgaas 写道:
> On Thu, Oct 27, 2022 at 11:14:58AM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> HEST PCIE AER error source information describes the Uncorrectable Error
>> Severity, CorrectableError Mask and other aer register's value to write to the
>> bridge's Correctable Error Mask register.
> 
> I guess the point is to extract register values from HEST PCI Express
> AER structures (ACPI r6.5, sec 18.3.2.4, etc.) and program them into
> AER Capabilities?
> 
Yes, the purpose of the patch sets is to extract register values from 
HEST PCI Express AER structures and program them into AER Capabilities

Thanks
leoliu-oc

>> leoliu-oc (5):
>>    ACPI/APEI: Add apei_hest_parse_aer()
>>    ACPI/APEI: remove static from apei_hest_parse()
>>    ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
>>    ACPI/PCI: Add pci_acpi_program_hest_aer_params()
>>    ACPI/PCI: config pcie devices's aer register
> 
> If/when you repost this, it would be nice if the patches ([1/5],
> [2/5], etc) were responses to the cover letter ([0/5]).  Since they're
> not responses, b4 doesn't know they're connected and can't grab the
> whole series at once.
> 
> Also capitalize the subject lines consistently and s/PCIE/PCIe/ and
> s/pcie/PCIe/ and s/aer/AER/, e.g., >
>    ACPI/APEI: Add apei_hest_parse_aer()
>    ACPI/APEI: Remove static from apei_hest_parse()
>    PCI: Add AER #defines for PCIe/PCI-X bridges
>    ACPI/PCI: Add pci_acpi_program_hest_aer_params()
>    ACPI/PCI: Configure devices AER registers based on HEST

Got it. I will modify this in the next version patch set.

Thanks
leoliu-oc
> 
>>   drivers/acpi/apei/hest.c      | 121 +++++++++++++++++++++++++++++++++-
>>   drivers/pci/pci-acpi.c        |  92 ++++++++++++++++++++++++++
>>   drivers/pci/pci.h             |   5 ++
>>   drivers/pci/probe.c           |   1 +
>>   include/acpi/actbl1.h         |  69 +++++++++++++++++++
>>   include/acpi/apei.h           |   9 +++
>>   include/uapi/linux/pci_regs.h |   5 ++
>>   7 files changed, 300 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.20.1
>>
