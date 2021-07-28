Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FB3D8A7E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhG1JWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 05:22:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12276 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhG1JWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 05:22:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZShQ6M9Lz1CPbW;
        Wed, 28 Jul 2021 17:16:22 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 17:22:18 +0800
Received: from [127.0.0.1] (10.69.38.196) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 28
 Jul 2021 17:22:18 +0800
Subject: Re: [PATCH v2] PCI/DPC: Check host->native_dpc before enable dpc
 service
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <20210726220512.GA648162@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <aad9bf53-470a-8e92-5c90-2b847486e9cc@hisilicon.com>
Date:   Wed, 28 Jul 2021 17:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210726220512.GA648162@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/7/27 6:05, Bjorn Helgaas wrote:
> On Wed, Feb 24, 2021 at 05:47:58PM +0800, Yicong Yang wrote:
>> On 2021/2/3 20:53, Yicong Yang wrote:
>>> Per Downstream Port Containment Related Enhancements ECN[1]
>>> Table 4-6, Interpretation of _OSC Control Field Returned Value,
>>> for bit 7 of _OSC control return value:
>>>
>>>   "Firmware sets this bit to 1 to grant the OS control over PCI Express
>>>   Downstream Port Containment configuration."
>>>   "If control of this feature was requested and denied,
>>>   or was not requested, the firmware returns this bit set to 0."
>>>
>>> We store bit 7 of _OSC control return value in host->native_dpc,
>>> check it before enable the dpc service as the firmware may not
>>> grant the control.
>>>
>>> [1] Downstream Port Containment Related Enhancements ECN,
>>>     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>>>     https://members.pcisig.com/wg/PCI-SIG/document/12888
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>> Change since v1:
>>> - use correct reference for _OSC control return value
>>>
>>>  drivers/pci/pcie/portdrv_core.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index e1fed664..7445d03 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -253,7 +253,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>>>  	 */
>>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>>  	    pci_aer_available() &&
>>> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>>> +	    (pcie_ports_dpc_native ||
>>> +	    ((services & PCIE_PORT_SERVICE_AER) && host->native_dpc)))
>>>  		services |= PCIE_PORT_SERVICE_DPC;
>>>  
>>
>> the check here maybe problematic. the bit 7 of _OSC return value is reserved
>> previously and the change here may break the backward compatibility.
>> currently we make dpc enabled along with aer, which can ensure the native
>> dpc won't be enabled if the edr is enabled.
> 
> Since you think this is problematic, I'll drop it for now.  If you
> decide it's the right thing to do, please post it again.
> 

yes, I still think this has problem. sorry for the noise.

>> i feel a bit confused as the bit 7 is not used.
>> does it provide a way to enable native dpc regardless of aer ownership?
>> just as pcie_ports=dpc-native does when i checked the discussion in [1].
>>
>> [1] https://lore.kernel.org/linux-pci/20191023192205.97024-1-olof@lixom.net/
>>
>> Thanks,
>> Yicong
>>
>>>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>>>
>>
> 
> .
> 

