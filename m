Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7341D2D692F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgLJUxW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 15:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404587AbgLJUxS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 15:53:18 -0500
Date:   Thu, 10 Dec 2020 14:52:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607633557;
        bh=Sg6DgaLPdSyUnyaqVuqvYc5bGigZPnDbQlDcRjAkLh4=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=tz1qcCIsV1Y+8av9sEypRQ1l9QxVbHKveAAMEKK+5pjtfllQ1utvyYg5n+4HOUXKD
         TYTSH2zu1Qt9RS78Cg+afW6C9HEoRpqR9ud7tcRrl1ZenNxb2/9CD6ZQjCIAA/F7Lk
         kZqBC3Db1GnjWhKsjmaXnuEgMNgRxLypmlsi9NleFpinr430K/WhWhMd4zh4vMNg2H
         tfFkNO5Qxr0Sb7Yx/YgI9wJtmJl4dky+/+l8gRPho0ZQ/XDklFwKjmoLbNH0nv8dCT
         QX/eMSsDqL1Vs0b+qfLnMJPIkSYiZ5QrVf90E8jNeSmFzp6EHq/wt1r+P9E9tTPNZv
         9O+HI0E69amQg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com, zengweiliang.zengweiliang@huawei.com,
        chenlizhong@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [v2] PCI: Add pci reset quirk for Huawei Intelligent NIC virtual
 function
Message-ID: <20201210205236.GA53173@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202113450.2283-1-chiqijun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex (please include people who have commented on previous
versions]

Looking for your ack before applying this, Alex.

On Wed, Dec 02, 2020 at 07:34:50PM +0800, Chiqijun wrote:
> When multiple VFs do FLR at the same time, the firmware is
> processed serially, resulting in some VF FLRs being delayed more
> than 100ms, when the virtual machine restarts and the device
> driver is loaded, the firmware is doing the corresponding VF
> FLR, causing the driver to fail to load.
> 
> To solve this problem, add host and firmware status synchronization
> during FLR.
> 
> Signed-off-by: Chiqijun <chiqijun@huawei.com>
> ---
> v2:
>  - Update comments
>  - Use the HINIC_VF_FLR_CAP_BIT_SHIFT and HINIC_VF_FLR_PROC_BIT_SHIFT
>    macro instead of the magic number
> ---
>  drivers/pci/quirks.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..c9ad55709d03 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3912,6 +3912,79 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
> +#define HINIC_VF_FLR_TYPE           0x1000
> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  6
> +#define HINIC_VF_OP                 0xE80
> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 10
> +#define HINIC_OPERATION_TIMEOUT     15000
> +
> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
> +{
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u16 old_command;
> +	u32 val;
> +
> +	if (probe)
> +		return 0;
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar)
> +		return -ENOTTY;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &old_command);
> +
> +	/*
> +	 * FLR cap bit bit30, FLR processing bit: bit18, to avoid big-endian
> +	 * conversion the big-endian bit6, bit10 is directly operated here.
> +	 *
> +	 * Get and check firmware capabilities.
> +	 */
> +	val = readl(bar + HINIC_VF_FLR_TYPE);
> +	if (!(val & (1UL << HINIC_VF_FLR_CAP_BIT_SHIFT))) {
> +		pci_iounmap(pdev, bar);
> +		return -ENOTTY;
> +	}
> +
> +	/*
> +	 * Set the processing bit for the start of FLR, which will be cleared
> +	 * by the firmware after FLR is completed.
> +	 */
> +	val = readl(bar + HINIC_VF_OP);
> +	val = val | (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT);
> +	writel(val, bar + HINIC_VF_OP);
> +
> +	/* Perform the actual device function reset */
> +	pcie_flr(pdev);
> +
> +	pci_write_config_word(pdev, PCI_COMMAND,
> +			      old_command | PCI_COMMAND_MEMORY);
> +
> +	/* Waiting for device reset complete */
> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
> +	do {
> +		val = readl(bar + HINIC_VF_OP);
> +		if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
> +			goto reset_complete;
> +		msleep(20);
> +	} while (time_before(jiffies, timeout));
> +
> +	val = readl(bar + HINIC_VF_OP);
> +	if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
> +		goto reset_complete;
> +
> +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %x\n",
> +		 be32_to_cpu(val));
> +
> +reset_complete:
> +	pci_write_config_word(pdev, PCI_COMMAND, old_command);
> +	pci_iounmap(pdev, bar);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3923,6 +3996,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
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
