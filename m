Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED33239E3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhBXJuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 04:50:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13372 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhBXJsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 04:48:51 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DlrfF4zMyz7pk3;
        Wed, 24 Feb 2021 17:46:29 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Feb 2021
 17:47:58 +0800
Subject: Re: [PATCH v2] PCI/DPC: Check host->native_dpc before enable dpc
 service
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <1612356795-32505-1-git-send-email-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <8ab7923c-c9d4-d864-86f0-743077e15d98@hisilicon.com>
Date:   Wed, 24 Feb 2021 17:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1612356795-32505-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/3 20:53, Yicong Yang wrote:
> Per Downstream Port Containment Related Enhancements ECN[1]
> Table 4-6, Interpretation of _OSC Control Field Returned Value,
> for bit 7 of _OSC control return value:
> 
>   "Firmware sets this bit to 1 to grant the OS control over PCI Express
>   Downstream Port Containment configuration."
>   "If control of this feature was requested and denied,
>   or was not requested, the firmware returns this bit set to 0."
> 
> We store bit 7 of _OSC control return value in host->native_dpc,
> check it before enable the dpc service as the firmware may not
> grant the control.
> 
> [1] Downstream Port Containment Related Enhancements ECN,
>     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/12888
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - use correct reference for _OSC control return value
> 
>  drivers/pci/pcie/portdrv_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed664..7445d03 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -253,7 +253,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (pcie_ports_dpc_native ||
> +	    ((services & PCIE_PORT_SERVICE_AER) && host->native_dpc)))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  

the check here maybe problematic. the bit 7 of _OSC return value is reserved
previously and the change here may break the backward compatibility.
currently we make dpc enabled along with aer, which can ensure the native
dpc won't be enabled if the edr is enabled.

i feel a bit confused as the bit 7 is not used.
does it provide a way to enable native dpc regardless of aer ownership?
just as pcie_ports=dpc-native does when i checked the discussion in [1].

[1] https://lore.kernel.org/linux-pci/20191023192205.97024-1-olof@lixom.net/

Thanks,
Yicong

>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> 

