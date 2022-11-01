Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E121614502
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 08:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKAHZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKAHZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 03:25:24 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B214D2C
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 00:25:22 -0700 (PDT)
X-ASG-Debug-ID: 1667287519-1eb14e7e6464290001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id ANfyOyV56KqKhGxX (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 01 Nov 2022 15:25:19 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 1 Nov
 2022 15:25:19 +0800
Received: from [10.32.56.18] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 1 Nov
 2022 15:25:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <9429d525-5e06-95a2-3340-f6e2b6009f76@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.56.18
Date:   Tue, 1 Nov 2022 15:25:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <robert.moore@intel.com>, <ying.huang@intel.com>,
        <rdunlap@infradead.org>, <bhelgaas@google.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@acpica.org>,
        <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>
References: <20221028151512.GA889708@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20221028151512.GA889708@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1667287519
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1356
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4904 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101826
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



在 2022/10/28 23:15, Bjorn Helgaas 写道:
> On Fri, Oct 28, 2022 at 07:19:25PM +0800, LeoLiuoc wrote:
>> 在 2022/10/27 12:17, Sathyanarayanan Kuppuswamy 写道:
>>> On 10/26/22 8:14 PM, LeoLiu-oc wrote:
> 
>>> Can you add spec reference?
>>>
>> Please refer to Section 18.3.2 ACPI Error Source of acpi spec v6.3. Links to
>> the online versions of ACPI Spec 6.3 is
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/18_ACPI_Platform_Error_Interfaces/error-source-discovery.html#acpi-error-source.
>>
>> Section 18.3.2.4 describes PCI Express Root Port AER Structure, section
>> 18.3.2.5 describes PCI Express Device AER Structure, section 18.3.2.6
>> describes PCI Express/PCI-X Bridge AER Structure.
> 
> Thanks.  It's OK to have the spec references in the email thread, but
> the real point is that they should be in the commit log and, when it
> makes sense, in code comments.
> 
> Cite the most recent spec version when you can.  In this case, I think
> it is ACPI r6.5.
> 
> Personally I don't really care for URL references because they tend to
> get stale over time as websites are reorganized and domains change.
> Something like "ACPI r6.5, sec 18.3.2.4" is unambiguous and will
> remain usable forever.
> 
> Bjorn

Got it. Thanks for your advice. This will be modified in the next version.

Thanks
leoliu-oc
