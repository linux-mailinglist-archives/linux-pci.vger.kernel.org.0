Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293881B5ACC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgDWLy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 07:54:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbgDWLy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 07:54:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26987EB5EBEF06FDEC79;
        Thu, 23 Apr 2020 19:54:56 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Apr 2020
 19:54:55 +0800
Subject: Re: [PATCH RFC] pci: Make return value of pcie_capability_read*()
 consistent
To:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        <helgaas@kernel.org>
References: <20200419065113.15259-1-refactormyself@gmail.com>
CC:     <bjorn@helgaas.com>, <skhan@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <80f70efc-0ff6-a53f-9a86-d52e053e6a69@hisilicon.com>
Date:   Thu, 23 Apr 2020 19:55:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200419065113.15259-1-refactormyself@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bolarinwa,

Please +cc me in the following patches,  and find some minor comments below.

On 2020/4/19 14:51, Bolarinwa Olayemi Saheed wrote:
> pcie_capability_read*() could return 0, -EINVAL, or any of the
> PCIBIOS_* error codes (which are positive).
> This is behaviour is now changed to return only PCIBIOS_* error
> codes on error.
> This is consistent with pci_read_config_*(). Callers can now have
> a consitent way for checking which error has occured.
>
> An audit of the callers of this function was made and no case was found
> where there is need for a change within the caller function or their 
> dependencies down the heirarchy.
> Out of all caller functions discovered only 8 functions either persist the
> return value of pcie_capability_read*() or directly pass on the return 
> value.
>
> 1.) "./drivers/infiniband/hw/hfi1/pcie.c" :
> => pcie_speeds() line-306
>
> 	if (ret) {
> 		dd_dev_err(dd, "Unable to read from PCI config\n");
> 		return ret;
> 	}
>
> remarks: The variable "ret" is the captured return value.
>          This function passes on the return value. The return value was
> 	 store only by hfi1_init_dd() line-15076 in 
>          ./drivers/infiniband/hw/hfi1/chip.c and it behave the same on all
> 	 errors. So this patch will not require a change in this function.
>
> => update_lbus_info() line-276
>
> 	if (ret) {
> 		dd_dev_err(dd, "Unable to read from PCI config\n");
> 		return;
> 	}
>
> remarks: see below
> => save_pci_variables() line-415, 420, 425
>
> 	if (ret)
> 		goto error;
>
> remarks: see below
>
> => tune_pcie_caps() line-471
>
> 	if ((!ret) && !(ectl & PCI_EXP_DEVCTL_EXT_TAG)) {
> 		dd_dev_info(dd, "Enabling PCIe extended tags\n");
> 		ectl |= PCI_EXP_DEVCTL_EXT_TAG;
> 		ret = pcie_capability_write_word(dd->pcidev,
> 						 PCI_EXP_DEVCTL, ectl);
> 		if (ret)
> 		     dd_dev_info(dd, "Unable to write to PCI config\n");
> 	}
>
> remarks: see below
>
> => do_pcie_gen3_transition() line-1247, 1274
>
> 	if (ret) {
> 		dd_dev_err(dd, "Unable to read from PCI config\n");
> 		return_error = 1;
> 		goto done;
> 	}
>
> remarks: The variable "ret" is the captured return value.
>          These functions' behaviour is the same on all errors, so they are
> 	 not be affected by this patch.
>
> 2.) "./drivers/net/wireless/realtek/rtw88/pci.c":
> => rtw_pci_link_cfg*() line-1221
>
> 	if (ret) {
> 		rtw_err(rtwdev, "failed to read PCI cap, ret=%d\n", ret);
> 		return;
> 	}
>
> remark: The variable "ret" is the captured return value.
>         This function returns on all errors, so it will not be affected
> 	by this patch.
>
> 3.) "./drivers/pci/hotplug/pciehp_hpc.c":
> => pciehp_check_link_active() line-219
>
> 	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> 		return -ENODEV;
>
> remark: see below
>
> =>pciehp_card_present() line-404
>
> 	{Same code as above}
>
> remark: The variable "ret" is the captured return value.
>         This 2 functions will not be affected by this patch since they are
> 	only testing for *DEVICE_NOT_FOUND error.
>
> 4.) "./drivers/pci/pcie/bw_notification.c":
> =>pcie_link_bandwidth_notification_supported() line-26
>
> 	return (ret == PCIBIOS_SUCCESSFUL) 
> 			&& (lnk_cap & PCI_EXP_LNKCAP_LBNC);
>
> remark: see below
>
> =>pcie_bw_notification_irq() line-56
>
> 	if (ret != PCIBIOS_SUCCESSFUL || !events)
> 		return IRQ_NONE;
>
> remark: The variable "ret" is the captured return value.
>         In these 2 functions returning PCIBIOS_BAD_REGISTER_NUMBER instead
> 	of -EINVAL as done in this patch will not affect the behaviour.
>
> 5.) "./drivers/pci/probe.c":
> => pci_configure_extended_tags() line-1951
>
> 	if (ret)
> 		return 0;
>
> remark: The variable "ret" is the captured return value.
>         This function will not be affected by this patch since it retuns 0
> 	on ALL error codes.
>
> 6.) "./drivers/pci/pci-sysfs.c":
> => current_link_speed_show() line-180
>
> 	if (err)
> 		return -EINVAL;
>
> remark: see below
>
> =>current_link_width_show() line-215
>
>         {same code as in the above function}
>
> remark: The variable "err" is the captured return value.
>         This 2 functions will not be affected directly by this patch since
> 	it retuns -EINVAL on ALL error codes. However, depending on the 
> 	intent, after this patch, this may now be to too generic. This is 
> 	because it will then be possible to use the returned PCIBIOS_* 
> 	error code to identify the error.
>
> 7.) "./drivers/dma/ioat/init.c":
> =>ioat3_dma_probe() line-1193
>
> 	if (err)
> 		return err;
>
> remark: The variable "ret" is the captured return value.
>         This function passes on the return value. Only ioat_pci_probe()
> 	line-1392 in the same file persists the return value and it's
> 	behaviour is the same on all errors. So this patch will not change
> 	the behaviour of these functions.
>
> 8.) "./drivers/pci/access.c":
> =>pcie_capability_clear_and_set_word() line-493
>
> 	if (!ret) {
> 		val &= ~clear;
> 		val |= set;
> 		ret = pcie_capability_write_word(dev, pos, val);
> 	}
>
> 	return ret;
>
> =>pcie_capability_clear_and_set_dword() line-508
>
>     {same as above function}
>
> remark: The variable "ret" is the captured return value.
>      This 2 functions will not be affected directly. But after this patch
>      they will now be returning PCIBIOS_BAD_REGISTER_NUMBER instead of 
>      -EINVAL. No case was found where the return value of any of both 
>      functions were persisted. But their return values are passed on
>      directly by:
> 	- pcie_capability_set_{word|dword}() and 
> 	  pcie_capability_clear_{word|dword}() in ./include/linux/pci.h
>           lines(1100-1136): these pass on the recieved return values 
> 	  directly to:
>           - pcie_capability_clear_dword() is not referenced anywhere
>           - pcie_capability_set_dword() is referenced but it's return 
> 	    values are not cached
>           - pcie_capability_{set, clear}_word() : return value passed on 
> 	    by pci_enable_pcie_error_reporting() in drivers/pci/pcie/aer.c
> 	    lines-(350,362) these are used by other drivers to log errors,
>             in all examined cases all errors are treated the same.
> 	  - pcie_capability_clear_word() : return value passed on by 
> 	    pci_disable_pcie_error_reporting() in /drivers/pci/pcie/aer.c 
> 	    lines-362 which treats all errors are treated the same.
>
> 	- pcie_set_readrq() line-5662 and pcie_set_mps() line-5703 in 
> 	  ./drivers/pci/pci.c : both functions pass on the return value of
> 	  pcie_capability_clear_and_set_word() but also return -EINVAL in
> 	  cases of some other errors. Currently these errors will not be 
> 	  differentiated, this patch will help differentiate errors in 
> 	  this kind of situation. The function will not be affected but
> 	  rather it will be enhanced in correctness.
>
>         - pqi_set_pcie_completion_timeout() line-7423 in 
> 	  ./drivers/scsi/smartpqi/smartpqi_init.c : This function will not
>           be affected. Although, it passes on the return value, all error 
>           values are handled the same way by the only reference found at 
>           line-7473 in the same file.
>
>           
>  
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> ---
> Changed in version 4:
>  - make patch independent of earlier versions
>  - add commit log
>  - add justificaation and report on audit of affected functions
>
> NOTE:
>  Please let me know if I have missed some possible callers
>  I am not sure if pcie_capability_write*() needs this kind of fix
>
>  drivers/pci/access.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..451f2b8b2b3c 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)

Maybe provide some comments for the function, to notify the outside users to do the error code
conversion.

BTW, pci_{read, write}_config_*() may also have the issues that export the private err code
outside. You may want to solve these in a series along with this patch.

Regards,
Yicong


>  
>  	*val = 0;
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  
>  	*val = 0;
>  	if (pos & 3)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);

