Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64938F670
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 01:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEXXpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 19:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhEXXov (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 19:44:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E90176140F;
        Mon, 24 May 2021 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621899803;
        bh=bzWATNTPaYHTgas/Ru4ikVqAuF22p6QgBAnd0xCRvlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U0ndxR7l73gsZ4FDhlPe62bGK9fQ6j+qvxlo1GuEKzYiC68TVizE/HT2E9Upsfh5N
         QeEH2jnkKAN+9Vkr55FoBr6E53fCF7Yg/7SwvnnyfHhY+Zzimvk3wfzmadG9negzuf
         AeKvIR7/vABzouc/W3ofMYHw0GsU1sIZdvL6d5dB4TVe0UmKNhxGGd6+tYlLOE4McX
         dj4J2kg6jmqOy+rKvmVyf7RKH5YccwjdNzTcYG2vlIWFw0nIa3WoFtTHPzTUfHHZ06
         XeC3sany43hxiV02zxV3ssbD7NKOcG2VhmM+4cuCdm3Fz1JEaxvLvXv8swhbJxBkTX
         FbQrGFvEYzRsQ==
Date:   Mon, 24 May 2021 18:43:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com,
        zengweiliang.zengweiliang@huawei.com, chenlizhong@huawei.com
Subject: Re: [v6] PCI: Add reset quirk for Huawei Intelligent NIC virtual
 function
Message-ID: <20210524234321.GA1141045@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414132301.1793-1-chiqijun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 14, 2021 at 09:23:01PM +0800, Chiqijun wrote:
> When we do an FLR on several VFs at the same time, the Huawei
> Intelligent NIC processes them serially, resulting in some VF
> FLRs being delayed more than 100ms, when the virtual machine
> restarts and the device driver is loaded, the firmware is doing
> the corresponding VF FLR, causing the driver to fail to load.
> Link: https://support.huawei.com/enterprise/en/doc/EDOC1100063073/87950645/vm-oss-occasionally-fail-to-load-the-in200-driver-when-the-vf-performs-flr
> 
> To solve this problem, add host and firmware status synchronization
> during FLR.
> 
> Signed-off-by: Chiqijun <chiqijun@huawei.com>

Applied to pci/reset for v5.14 with subject
"PCI: Work around Huawei Intelligent NIC VF FLR erratum" and the
following commit log:

  pcie_flr() starts a Function Level Reset (FLR), waits 100ms (the maximum
  time allowed for FLR completion by PCIe r5.0, sec 6.6.2), and waits for the
  FLR to complete.  It assumes the FLR is complete when a config read returns
  valid data.

  When we do an FLR on several Huawei Intelligent NIC VFs at the same time,
  firmware on the NIC processes them serially.  The VF may respond to config
  reads before the firmware has completed its reset processing.  If we bind a
  driver to the VF (e.g., by assigning the VF to a virtual machine) in the
  interval between the successful config read and completion of the firmware
  reset processing, the NIC VF driver may fail to load.

  Prevent this driver failure by waiting for the NIC firmware to complete its
  reset processing.  Not all NIC firmware supports this feature.

Let me know if that's not accurate.

I applied Alex's Reviewed-by (from v3) because the patch is basically
identical except for cosmetic changes.

> ---
> v6:
>  - Addressed Bjorn's review comments
> 
> v5:
>  - Fix build warning reported by kernel test robot
> 
> v4:
>  - Addressed Bjorn's review comments
> 
> v3:
>  - The MSE bit in the VF configuration space is hardwired to zero,
>    remove the setting of PCI_COMMAND_MEMORY bit. Add comment for
>    set PCI_COMMAND register.
> 
> v2:
>  - Update comments
>  - Use the HINIC_VF_FLR_CAP_BIT_SHIFT and HINIC_VF_FLR_PROC_BIT_SHIFT
>    macro instead of the magic number
> ---
>  drivers/pci/quirks.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..6677b7220442 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3913,6 +3913,73 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
> +#define HINIC_VF_FLR_TYPE           0x1000
> +#define HINIC_VF_FLR_CAP_BIT        (1UL << 30)
> +#define HINIC_VF_OP                 0xE80
> +#define HINIC_VF_FLR_PROC_BIT       (1UL << 18)
> +#define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */
> +
> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
> +{
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u32 val;
> +
> +	if (probe)
> +		return 0;
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar)
> +		return -ENOTTY;
> +
> +	/* Get and check firmware capabilities. */
> +	val = ioread32be(bar + HINIC_VF_FLR_TYPE);
> +	if (!(val & HINIC_VF_FLR_CAP_BIT)) {
> +		pci_iounmap(pdev, bar);
> +		return -ENOTTY;
> +	}
> +
> +	/*
> +	 * Set the processing bit for the start of FLR, which will be cleared
> +	 * by the firmware after FLR is completed.
> +	 */
> +	val = ioread32be(bar + HINIC_VF_OP);
> +	val = val | HINIC_VF_FLR_PROC_BIT;
> +	iowrite32be(val, bar + HINIC_VF_OP);
> +
> +	/* Perform the actual device function reset */
> +	pcie_flr(pdev);
> +
> +	/*
> +	 * The device must learn BDF after FLR in order to respond to BAR's
> +	 * read request, therefore, we issue a configure write request to let
> +	 * the device capture BDF.
> +	 */
> +	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
> +
> +	/* Waiting for device reset complete */
> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
> +	do {
> +		val = ioread32be(bar + HINIC_VF_OP);
> +		if (!(val & HINIC_VF_FLR_PROC_BIT))
> +			goto reset_complete;
> +		msleep(20);
> +	} while (time_before(jiffies, timeout));
> +
> +	val = ioread32be(bar + HINIC_VF_OP);
> +	if (!(val & HINIC_VF_FLR_PROC_BIT))
> +		goto reset_complete;
> +
> +	pci_warn(pdev, "Reset dev timeout, FLR ack reg: %#010x\n", val);
> +
> +reset_complete:
> +	pci_iounmap(pdev, bar);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3924,6 +3991,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
> +		reset_hinic_vf_dev },
>  	{ 0 }
>  };
>  
> -- 
> 2.17.1
> 
