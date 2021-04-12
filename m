Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E213235B8F2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhDLDcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Apr 2021 23:32:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:53631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhDLDcj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Apr 2021 23:32:39 -0400
IronPort-SDR: 71vS4xqlgBv4PkezW+Lx8ijRQHYeHjbZsJCGUqKzn7q8xNhp+Vy46zMSnkWPeRuqY8KaVVTi+g
 6lbdMY2o2wRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194214217"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194214217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 20:32:21 -0700
IronPort-SDR: hPdTHlLA+TYIuQvv0uPR7m5cvPSvIRg1cMkI9OUS6Z87orh2bRVn/kDRqtCIOzSOiJeoUeIhEd
 x1f6jynEsoFA==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="423612261"
Received: from gregleun-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.180.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 20:32:21 -0700
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, kbusch@kernel.org,
        sean.v.kelley@intel.com, qiuxu.zhuo@intel.com,
        prime.zeng@huawei.com, linuxarm@openeuler.org
References: <20210410152103.GA2043340@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <dcd63859-2c66-2f0b-b6ca-877e50fbcee3@linux.intel.com>
Date:   Sun, 11 Apr 2021 20:32:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210410152103.GA2043340@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/10/21 8:21 AM, Bjorn Helgaas wrote:
> On Wed, Feb 03, 2021 at 08:53:15PM +0800, Yicong Yang wrote:
>> Per Downstream Port Containment Related Enhancements ECN[1],
>> Table 4-6 Interpretation of _OSC Control Field Returned Value,
>> for bit 7 of _OSC control return value:
>>
>>    "If firmware allows the OS control of this feature, then,
>>    in the context of the _OSC method the OS must ensure that
>>    Downstream Port Containment ERR_COR signaling is disabled
>>    as described in the PCI Express Base Specification."
>>
>> and PCI Express Base Specification Revision 4.0 Version 1.0
>> section 6.2.10.2, Use of DPC ERR_COR Signaling:
>>
>>    "...DPC ERR_COR signaling is primarily intended for use by
>>    platform firmware..."
>>
>> Currently we don't set DPC ERR_COR enable bit, but explicitly
>> clear the bit to ensure it's disabled.
Instead of spec reference, can you explain what error you are
fixing? without this fix what will be the impact and explain
how you mitigating it with your fix.
>>
>> [1] Downstream Port Containment Related Enhancements ECN,
>>      Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>>      https://members.pcisig.com/wg/PCI-SIG/document/12888
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Anybody want to chime in and review this?  Sometimes I feel like a
> one-man band :)
> 
>> ---
>>   drivers/pci/pcie/dpc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index e05aba8..5cc8ef3 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>>   	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>>   	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>>   
>> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>> +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>>   	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>>   	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>>   
>> -- 
>> 2.8.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
