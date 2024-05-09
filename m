Return-Path: <linux-pci+bounces-7287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9934B8C0D1E
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDEFB20DB0
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62E14A4E7;
	Thu,  9 May 2024 09:07:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991F13C8F8
	for <linux-pci@vger.kernel.org>; Thu,  9 May 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245621; cv=none; b=IyZIRNy9Je38eQYSqOqlUGTxtzOgwEYoBGD0IWb9ZTnug2V5+fAvRhCJEmCpcRVtyHixqYrrY5xSdN04tQtTT4r5eJzZ03qpPx/cD6DQdnF1lgfShkPrNVGoVRfrY8pAj5WKMUMmyWS48REM91Nldfg8vpCsqxut9uOtxgoC5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245621; c=relaxed/simple;
	bh=5Chm87/w6gann49MFLtPr3wM+utczo7OtUCocIrYdM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AuBJFsrU/mhcEbmlR4/KHLNj8eSRz83SAPRPAL8qbZeFV7/NgWuLenvQFe/iR151OfWp/h8lcQ2YzrezqjLrsWTAR7YnSJFCv7BuSitgH+C8dReWAwJle6SImnPjugdmIpMXhUmM/RuKYvigbXCXCFF3T8SoLd4FKOdxLHK+1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1715245615-086e2325ca0dbd0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id M9WqRzFhjCh0Ezmg (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 09 May 2024 17:06:55 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 17:06:55 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 17:06:53 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Thu, 9 May 2024 17:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>
References: <20240508222459.GA1791619@bhelgaas>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20240508222459.GA1791619@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1715245615
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6136
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.124626
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2024/5/9 6:24, Bjorn Helgaas 写道:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On Mon, Dec 18, 2023 at 11:04:30AM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
>> the purpose of this function is to extract register value from HEST PCIe
>> AER structures and program them into AER Capabilities.
>>
>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   drivers/pci/pci-acpi.c | 98 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h      |  9 ++++
>>   drivers/pci/probe.c    |  1 +
>>   3 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 004575091596..3a183d5e20cb 100644
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
>> @@ -783,6 +784,103 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>>        return -ENODEV;
>>   }
>>
>> +#ifdef CONFIG_ACPI_APEI
>> +static void program_hest_aer_endpoint(struct acpi_hest_aer_common aer_endpoint,
>> +                             struct pci_dev *dev, int pos)
>> +{
>> +     u32 uncor_mask;
>> +     u32 uncor_severity;
>> +     u32 cor_mask;
>> +     u32 adv_cap;
>> +
>> +     uncor_mask = aer_endpoint.uncorrectable_mask;
>> +     uncor_severity = aer_endpoint.uncorrectable_severity;
>> +     cor_mask = aer_endpoint.correctable_mask;
>> +     adv_cap = aer_endpoint.advanced_capabilities;
>> +
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
> 
> This is named for "endpoint", but it is used for Root Ports,
> Endpoints, and PCIe to PCI/PCI-X bridges.  It relies on these four
> fields being in the same place for all those HEST structures.
>
Change the function name " program_hest_aer_endpoint " to
"program_hest_aer_common" and the parameters of the function
"aer_endpoint" to "aer_common". Do you think this is appropriate?

> That makes good sense, but maybe should have a one-line hint about
> this and maybe even a compiletime_assert().
> 

I intend to add the following comment to the function in next
version："/* Configure AER common registers for Root Ports, Endpoints,
and PCIe to PCI/PCI-X bridges */", Is this description appropriate?

>> +}
>> +
>> +static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root, struct pci_dev *dev, int pos)
>> +{
>> +     u32 root_err_cmd;
>> +
>> +     root_err_cmd = aer_root->root_error_command;
>> +
>> +     pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
>> +}
>> +
>> +static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
>> +                             struct pci_dev *dev, int pos)
>> +{
>> +     u32 uncor_mask2;
>> +     u32 uncor_severity2;
>> +     u32 adv_cap2;
>> +
>> +     uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
>> +     uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
>> +     adv_cap2 = hest_aer_bridge->advanced_capabilities2;
>> +
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
>> +}
>> +
>> +static void program_hest_aer_params(struct hest_parse_aer_info info)
>> +{
>> +     struct pci_dev *dev;
>> +     int port_type;
>> +     int pos;
>> +     struct acpi_hest_aer_root *hest_aer_root;
>> +     struct acpi_hest_aer *hest_aer_endpoint;
>> +     struct acpi_hest_aer_bridge *hest_aer_bridge;
>> +
>> +     dev = info.pci_dev;
>> +     port_type = pci_pcie_type(dev);
> 
> I'd put these two initializations up at the declarations, e.g.,
> 
>    struct pci_dev *dev = info.pci_dev;
>    int port_type = pci_pcie_type(dev);
> 
Okay, this will be modified in the next version.

>> +     pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +     if (!pos)
>> +             return;
>> +
>> +     switch (port_type) {
>> +     case PCI_EXP_TYPE_ROOT_PORT:
>> +             hest_aer_root = info.hest_aer_root_port;
>> +             program_hest_aer_endpoint(hest_aer_root->aer, dev, pos);
>> +             program_hest_aer_root(hest_aer_root, dev, pos);
>> +             break;
>> +     case PCI_EXP_TYPE_ENDPOINT:
>> +             hest_aer_endpoint = info.hest_aer_endpoint;
>> +             program_hest_aer_endpoint(hest_aer_endpoint->aer, dev, pos);
>> +             break;
>> +     case PCI_EXP_TYPE_PCI_BRIDGE:
>> +     case PCI_EXP_TYPE_PCIE_BRIDGE:
> 
> PCI_EXP_TYPE_PCIE_BRIDGE is a PCI/PCI-X to PCIe Bridge, also known as
> a "reverse bridge".  This has a conventional PCI or PCI-X primary
> interface and a PCIe secondary interface.  It's not clear to me that
> these bridges can support AER.
> 
> For one thing, the AER Capability must be in extended config space,
> which would only be available for PCI-X Mode 2 reverse bridges.
> 
> The acpi_hest_aer_bridge certainly makes sense for
> PCI_EXP_TYPE_PCI_BRIDGE (a PCIe to PCI/PCI-X bridge), but the ACPI
> spec (r6.5, sec 18.3.2.6) is not very clear about whether it also
> applies to PCI_EXP_TYPE_PCIE_BRIDGE (a reverse bridge).
> 
> Do you actually need this PCI_EXP_TYPE_PCIE_BRIDGE case?
> 
Yes, you are right. I will fix this in the next version.

Yours sincerely
Leoliu-oc

>> +             hest_aer_bridge = info.hest_aer_bridge;
>> +             program_hest_aer_endpoint(hest_aer_bridge->aer, dev, pos);
>> +             program_hest_aer_bridge(hest_aer_bridge, dev, pos);
>> +             break;
>> +     default:
>> +             return;
>> +     }
>> +}

