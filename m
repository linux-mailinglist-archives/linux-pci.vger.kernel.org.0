Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831CE2C769F
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgK1XaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 18:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgK1XaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 18:30:01 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C3821973;
        Sat, 28 Nov 2020 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606606160;
        bh=yuq0PbgmcnYynxk+LQOmqhGRw6FTHb0aju1NqDXGS1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t2/S3vOtX1J+MLAUzi4aQB3iqHnLYlVV/wYP7VyzVRZJP3Oxr7sN3eB4mlPVL5rSU
         azjAhOclVsRC9eceSV+xaPpZeGhDRPhgYE0XYSrK/F2Um70oEHo1PRH+xvobN4xyDR
         QQONnkuSsvjL1+5zciYtPBDowi8DZ8UEER0h8HqM=
Date:   Sat, 28 Nov 2020 17:29:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com, zengweiliang.zengweiliang@huawei.com,
        chenlizhong@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add pci reset quirk for Huawei Intelligent NIC
 virtual function
Message-ID: <20201128232919.GA929748@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128061825.2629-1-chiqijun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Sat, Nov 28, 2020 at 02:18:25PM +0800, Chiqijun wrote:
> When multiple VFs do FLR at the same time, the firmware is
> processed serially, resulting in some VF FLRs being delayed more
> than 100ms, when the virtual machine restarts and the device
> driver is loaded, the firmware is doing the corresponding VF
> FLR, causing the driver to fail to load.
> 
> To solve this problem, add host and firmware status synchronization
> during FLR.

Is this because the Huawei Intelligent NIC isn't following the spec,
or is it because Linux isn't correctly waiting for the FLR to
complete?

If this is a Huawei Intelligent NIC defect, is there documentation
somewhere (errata) that you can reference?  Will it be fixed in future
designs, so we don't have to add future Device IDs to the quirk?

> Signed-off-by: Chiqijun <chiqijun@huawei.com>
> ---
>  drivers/pci/quirks.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..bd6236ea9064 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3912,6 +3912,71 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_HINIC_VF  0x375E
> +#define HINIC_VF_FLR_TYPE       0x1000
> +#define HINIC_VF_OP             0xE80
> +#define HINIC_OPERATION_TIMEOUT 15000
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
> +	 * FLR cap bit bit30, FLR ACK bit: bit18, to avoid big-endian conversion
> +	 * the big-endian bit6, bit10 is directly operated here
> +	 */
> +	val = readl(bar + HINIC_VF_FLR_TYPE);
> +	if (!(val & (1UL << 6))) {
> +		pci_iounmap(pdev, bar);
> +		return -ENOTTY;
> +	}
> +
> +	val = readl(bar + HINIC_VF_OP);
> +	val = val | (1UL << 10);
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
> +		if (!(val & (1UL << 10)))
> +			goto reset_complete;
> +		msleep(20);
> +	} while (time_before(jiffies, timeout));
> +
> +	val = readl(bar + HINIC_VF_OP);
> +	if (!(val & (1UL << 10)))
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
> @@ -3923,6 +3988,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
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
