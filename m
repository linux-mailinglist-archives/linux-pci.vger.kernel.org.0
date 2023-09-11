Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1F79B2E7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350627AbjIKVjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjIKKB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 06:01:57 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819BDE68
        for <linux-pci@vger.kernel.org>; Mon, 11 Sep 2023 03:01:52 -0700 (PDT)
X-ASG-Debug-ID: 1694426509-1eb14e75131cf40001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id 3x4PcVHX4EIasQrC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 11 Sep 2023 18:01:49 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 18:01:48 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 18:01:47 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <bb01b8f1-bb25-48e5-9445-63d40703e919@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Mon, 11 Sep 2023 18:01:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] ACPI/PCI: Add pci_acpi_program_hest_aer_params()
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v3 4/5] ACPI/PCI: Add pci_acpi_program_hest_aer_params()
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <ErosZhang@zhaoxin.com>
References: <20230810233007.GA41830@bhelgaas>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230810233007.GA41830@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1694426509
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5996
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113957
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/11 7:30, Bjorn Helgaas 写道:
> On Tue, Jul 04, 2023 at 08:05:44PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> The extracted register values from HEST PCI Express AER structures are
>> written to AER Capabilities.
> 
> In the subject, the prevailing style for this file is
> (see "git log --oneline drivers/pci/pci-acpi.c"):
> 
>    PCI/ACPI: ...
> 
> And I'd like the subject to tell users why they might want this patch.
> It's obvious from the patch that this adds a function.  What's *not*
> obvious is *why* we want this new function.  So the commit log should
> tell us what the benefit is, and the subject line should be one-line
> summary of that benefit.
> 
> This patch adds a function but no caller.  The next patch is one-liner
> that adds the caller.  I think these two should be squashed so it's
> easier to review (and easier to explain the benefit of *this* patch :))
> 

Ok, I will merge this patch with 5/5 in the next version.

>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/pci/pci-acpi.c | 92 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h      |  5 +++
>>   2 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a05350a4e49cb..cff54410e2427 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pm_qos.h>
>>   #include <linux/rwsem.h>
>> +#include <acpi/apei.h>
>>   #include "pci.h"
>>   
>>   /*
>> @@ -783,6 +784,97 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>>   	return -ENODEV;
>>   }
>>   
>> +/*
>> + * program_aer_structure_to_aer_registers - Write the AER structure to
>> + * the corresponding dev's AER registers.
>> + *
>> + * @info - the AER structure information
>> + *
> 
> Remove the spurious blank comment line.
>

OK.

>> + */
>> +static void program_aer_structure_to_aer_registers(struct acpi_hest_parse_aer_info info)
>> +{
>> +	u32 uncorrectable_mask;
>> +	u32 uncorrectable_severity;
>> +	u32 correctable_mask;
>> +	u32 advanced_capabilities;
>> +	u32 root_error_command;
>> +	u32 uncorrectable_mask2;
>> +	u32 uncorrectable_severity2;
>> +	u32 advanced_capabilities2;
>> +	int port_type;
>> +	int pos;
>> +	struct pci_dev *dev;
> 
> Order these declarations in order of use.
> 

OK.

>> +	dev = info.pci_dev;
>> +	port_type = pci_pcie_type(dev);
>> +
>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +	if (!pos)
>> +		return;
>> +
>> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>> +		uncorrectable_mask = info.acpi_hest_aer_root_port->uncorrectable_mask;
>> +		uncorrectable_severity = info.acpi_hest_aer_root_port->uncorrectable_severity;
>> +		correctable_mask = info.acpi_hest_aer_root_port->correctable_mask;
>> +		advanced_capabilities = info.acpi_hest_aer_root_port->advanced_capabilities;
>> +		root_error_command = info.acpi_hest_aer_root_port->root_error_command;
> 
> Except for this new code, this file fits in 80 columns, so I'd like
> the new code to match.
>

OK.

>> +
>> +		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
> 
> I'm not sure we need to copy everything into local variables.  Maybe
> this could be split into three helper functions, which would save a
> level of indent and a level of struct traversal (e.g., "rp->" instead
> of "info.acpi_hest_aer_root_port->".
> 
>    pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, rp->uncorrectable_mask);
> 
> or
> 
>    pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK,
>                           rp->uncorrectable_mask);
> 
> If you have to define a new struct acpi_hest_aer_root_port, you could
> make the member names shorter.  But hopefully you *don't* have to do
> that, so maybe we're stuck with the long existing member names in
> acpi_hest_aer_common.
> >> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
>> +{
>> +	struct acpi_hest_parse_aer_info info = {
>> +		.pci_dev	= dev,
>> +		.hest_matched_with_dev	= 0,
>> +		.acpi_hest_aer_endpoint = NULL,
>> +		.acpi_hest_aer_root_port = NULL,
>> +		.acpi_hest_aer_for_bridge = NULL,
> 
> Drop the tab from the .pci_dev initialization since the other members
> aren't lined up anyway.  I think you can drop the other
> initializations completely since they will be initialized to 0 or NULL
> pointers by default.
> 

Thanks for your guidance, I will make changes to the code where it fits 
and does not conform to the specification.

Best Regards.
LeoLiu-oc

>> +	};
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return -ENODEV;
>> +
>> +	apei_hest_parse(apei_hest_parse_aer, &info);
>> +	if (info.hest_matched_with_dev == 1)
>> +		program_aer_structure_to_aer_registers(info);
>> +	else
>> +		return -ENODEV;
>> +	return 0;
>> +}
>> +
>>   /**
>>    * pciehp_is_native - Check whether a hotplug port is handled by the OS
>>    * @bridge: Hotplug port to check
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a4c3974340576..37aa4a33eeed2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -713,6 +713,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>>   int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>>   bool acpi_pci_need_resume(struct pci_dev *dev);
>>   pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
>> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
>>   #else
>>   static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>>   {
>> @@ -752,6 +753,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>>   {
>>   	return PCI_POWER_ERROR;
>>   }
>> +static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
>> +{
>> +	return -ENODEV;
>> +}
>>   #endif
>>   
>>   #ifdef CONFIG_PCIEASPM
>> -- 
>> 2.34.1
>>
