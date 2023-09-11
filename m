Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D116279B0A1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbjIKVjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjIKJVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 05:21:23 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31851CD7
        for <linux-pci@vger.kernel.org>; Mon, 11 Sep 2023 02:21:17 -0700 (PDT)
X-ASG-Debug-ID: 1694424073-086e234a2b48550001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id ejET5smsoWwWJovg (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 11 Sep 2023 17:21:13 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:21:12 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:21:11 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <fbbff3ed-5b4a-4288-94a9-fd8ec37741df@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Mon, 11 Sep 2023 17:21:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ACPI/APEI: Add apei_hest_parse_aer()
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v3 1/5] ACPI/APEI: Add apei_hest_parse_aer()
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <ErosZhang@zhaoxin.com>
References: <20230810231734.GA41600@bhelgaas>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230810231734.GA41600@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1694424073
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 11289
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113955
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
> On Tue, Jul 04, 2023 at 08:05:05PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> apei_hest_parse_aer() is used to parse and extract register values
>> from HEST PCIe AER structures.
>>
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/apei/hest.c | 114 ++++++++++++++++++++++++++++++++++++++-
>>   include/acpi/actbl1.h    |  69 ++++++++++++++++++++++++
>>   include/acpi/apei.h      |   7 +++
>>   3 files changed, 189 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 6aef1ee5e1bdb..fb839a5c480ee 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -26,6 +26,7 @@
>>   #include <acpi/apei.h>
>>   #include <acpi/ghes.h>
>>   
>> +#include <linux/pci.h>
> 
> Should go in the list above along with the other <linux/...> includes.
> The trend is to alphabetize the list, so I'd put it here:
> 
>     #include <linux/io.h>
>    +#include <linux/pci.h>
>     #include <linux/platform_device.h>
> 

OK, I will make the change according to your suggestion.

LeoLiu-oc

>>   #include "apei-internal.h"
>>   
>>   #define HEST_PFX "HEST: "
>> @@ -86,7 +87,50 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>   	return len;
>>   };
>>   
>> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> 
> I think moving this typedef to include/acpi/apei.h should happen in
> the patch where it is needed.  I *think* that's the "Remove static
> from apei_hest_parse()" patch.
> 
Yes，Agree with you. It's more appropriate to move typedef into "Remove 
static from apei_hest_parse()" patch.

LeoLiu-oc

>> +static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
>> +{
>> +	switch (hest_hdr->type) {
>> +	case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +	case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +	case ACPI_HEST_TYPE_AER_BRIDGE:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static bool hest_match_type(struct acpi_hest_header *hest_hdr,
>> +				struct pci_dev *dev)
> 
> Align "struct pci_dev" under "struct acpi_hest_header", as is typical
> (see apei-base.c, erst.c, ghes.c)
> 

OK, I will modify in next version.

LeoLiu-oc

>> +{
>> +	u16 hest_type = hest_hdr->type;
>> +	u8 pcie_type = pci_pcie_type(dev);
>> +
>> +	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
>> +		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
>> +		(hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
>> +		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
>> +		(hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
>> +		(pcie_type == PCI_EXP_TYPE_PCI_BRIDGE || pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE)))
>> +		return true;
>> +	return false;
>> +}
>> +
>> +static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
>> +		struct pci_dev *pci)
> 
> Align parameters.
>

OK.

>> +{
>> +	return	ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
>> +			ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
>> +			p->device                 == PCI_SLOT(pci->devfn) &&
>> +			p->function               == PCI_FUNC(pci->devfn);
> 
> Remove double space before ACPI_HEST_SEGMENT().  Align the other lines
> under ACPI_HEST_SEGMENT() and don't bother indenting the
> pci->bus->number, PCI_SLOT, PCI_FUNC, since they don't line up anyway,
> i.e.,
> 
>    return ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
>           ACPI_HEST_BUS(p->bus) == pci->bus->number &&
> 	 p->device == PCI_SLOT(pci->devfn) &&
>           p->function == PCI_FUNC(pci->devfn);
> 
> The only allowable variable names for a pci_dev pointer are "dev" or
> "pdev" :)  In this context, I think "dev" is fine (as you used above
> for hest_match_type()).
> 

I'm going to unify the variable names for a "pci_dev" pointer.

LeoLiu-oc

>> +}
>> +
>> +static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
>> +		struct acpi_hest_aer_common *p, struct pci_dev *pci)
>> +{
>> +	if (hest_match_type(hest_hdr, pci))
>> +		return hest_match_pci_devfn(p, pci);
>> +	return false;
>> +}
>>   
>>   static int apei_hest_parse(apei_hest_func_t func, void *data)
>>   {
>> @@ -124,6 +168,74 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * apei_hest_parse_aer - Find the AER structure in the HEST and
>> + * match it with the PCIe device.
>> + *
>> + * @hest_hdr: To save the ACPI AER error source in HEST
>> + *
>> + * Return 1 if the PCIe dev matched with the ACPI AER error source in
>> + * HEST, else return 0.
>> + */
>> +int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
> 
> Follow the naming pattern of all the other parse functions:
> 
>    hest_parse_ghes_count
>    hest_parse_ghes
>    hest_parse_cmc
> 
> E.g., "hest_parse_pcie_aer" or "hest_parse_aer".
> 

OK.

>> +{
>> +	struct acpi_hest_parse_aer_info *info = data;
> 
>> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint = NULL;
>> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port = NULL;
>> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge = NULL;
> 
> Unnecessary initializations since you always set these below before
> using them.  But maybe there's a way to do this without these pointers
> (see below).
> 

OK.

>> +	if (!hest_source_is_pcie_aer(hest_hdr))
>> +		return 0;
>> +
>> +	switch (hest_hdr->type) {
>> +	case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +		acpi_hest_aer_root_port = (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
>> +		if (acpi_hest_aer_root_port->flags & ACPI_HEST_GLOBAL) {
>> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
>> +				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
>> +				info->hest_matched_with_dev = 1;
>> +			}
>> +		} else if (hest_match_pci(hest_hdr,
>> +					(struct acpi_hest_aer_common *)acpi_hest_aer_root_port,
>> +					info->pci_dev)) {
>> +			info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
>> +			info->hest_matched_with_dev = 1;
>> +		}
>> +		break;
> 
> Could this be refactored along the lines of this?
> 
>    static bool matches(struct acpi_hest_header *hest_hdr, struct pci_dev *dev)
>    {
>      u16 hest_type = hest_hdr->type;
>      u8 pcie_type = pci_pcie_type(dev);
>      struct acpi_hest_aer_common *common =
>          (struct acpi_hest_aer_common *) (hest_hdr + 1);
> 
>      switch (hest_type) {
>      case ACPI_HEST_TYPE_AER_ROOT_PORT:
>        if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
>          return false;
>        break;
>      case ACPI_HEST_TYPE_AER_ENDPOINT:
>        if (pcie_type != PCI_EXP_TYPE_ENDPOINT)
>          return false;
>        break;
>      case ACPI_HEST_TYPE_AER_BRIDGE:
>        if (pcie_type != PCI_EXP_TYPE_BRIDGE &&
>            pcie_type != PCI_EXP_TYPE_PCIE_BRIDGE)
>          return false;
>        break;
>      default:
>        return false;
>      }
> 
>      if (common->flags & ACPI_HEST_GLOBAL)
>        return true;
> 
>      if (hest_match_pci_devfn(common, dev))
>        return true;
> 
>      return false;
>    }
> 
>    int apei_hest_parse_aer(...)
>    {
>      if (!matches(hest_hdr, info->pci_dev))
>        return 0;
> 
>      switch (hest_type) {
>      case ACPI_HEST_TYPE_AER_ROOT_PORT:
>        info->acpi_hest_aer_root_port =
>            (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
>        info->hest_matched_with_dev = 1;
>        return 1;
>      case ACPI_HEST_TYPE_AER_ENDPOINT:
>        ...
>      }
> 
>      return 0;
>    }
> 

Yes, your advice makes the code clearer.

LeoLiu-oc

>> +	case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +		acpi_hest_aer_endpoint = (struct acpi_hest_aer_endpoint *)(hest_hdr + 1);
>> +		if (acpi_hest_aer_endpoint->flags & ACPI_HEST_GLOBAL) {
>> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
>> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
>> +				info->hest_matched_with_dev = 1;
>> +			}
>> +		} else if (hest_match_pci(hest_hdr,
>> +					(struct acpi_hest_aer_common *)acpi_hest_aer_endpoint,
>> +					info->pci_dev)) {
>> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
>> +				info->hest_matched_with_dev = 1;
>> +		}
>> +		break;
>> +	case ACPI_HEST_TYPE_AER_BRIDGE:
>> +		acpi_hest_aer_for_bridge = (struct acpi_hest_aer_for_bridge *)(hest_hdr + 1);
>> +		if (acpi_hest_aer_for_bridge->flags & ACPI_HEST_GLOBAL) {
>> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
>> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
>> +				info->hest_matched_with_dev = 1;
>> +			}
>> +		} else if (hest_match_pci(hest_hdr,
>> +					(struct acpi_hest_aer_common *)acpi_hest_aer_for_bridge,
>> +					info->pci_dev)) {
>> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
>> +				info->hest_matched_with_dev = 1;
>> +			}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return info->hest_matched_with_dev;
>> +}
>> +
>>   /*
>>    * Check if firmware advertises firmware first mode. We need FF bit to be set
>>    * along with a set of MC banks which work in FF mode.
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 58b0490a2ad12..31abe06c6e792 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -1583,6 +1583,75 @@ struct acpi_hest_aer_bridge {
>>   	u32 advanced_capabilities2;
>>   };
>>   
>> +struct acpi_hest_parse_aer_info {
>> +	struct pci_dev *pci_dev;
>> +	int hest_matched_with_dev;
>> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint;
>> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port;
>> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge;
>> +};
>> +
>> +/* HEST Sub-structure for PCIe Root Port Structure (6) */
>> +
>> +struct acpi_hest_aer_root_port {
> 
> How are these different from the existing acpi_hest_aer_root,
> acpi_hest_aer, and acpi_hest_aer_bridge?
> 
> I see that the existing acpi_hest_aer_root includes a struct
> acpi_hest_header and the new acpi_hest_aer_root_port does not, but
> that doesn't seem like enough reason to duplicate all the rest of the
> structure.
> 
> Sorry if you've answered this before.  If we really need both
> acpi_hest_aer_root and acpi_hest_aer_root_port, we should put a hint
> about the reason in the commit log and maybe even in a code comment
> here.
> 

Agree with you. I will remove that part of the definition and use the 
existing definition in the next version.

LeoLiu-oc

>> +	u16 reserved1;
>> +	u8 flags;
>> +	u8 enabled;
>> +	u32 records_to_preallocate;
>> +	u32 max_sections_per_record;
>> +	u32 bus;
>> +	u16 device;
>> +	u16 function;
>> +	u16 device_control;
>> +	u16 reserved2;
>> +	u32 uncorrectable_mask;
>> +	u32 uncorrectable_severity;
>> +	u32 correctable_mask;
>> +	u32 advanced_capabilities;
>> +	u32 root_error_command;
>> +};
> 
>> +/* HEST Sub-structure for PCIe/PCI-X Bridge Structure (8) */
>> +
>> +struct acpi_hest_aer_for_bridge {
> 
> If this struct is needed, s/for_// (the other structs don't include
> "for_" and there's no need here).
OK.

Best Regards.
LeoLiu-oc
