Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8322EFB39
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 23:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbhAHW0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 17:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbhAHW0C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 17:26:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D93BC23A3C;
        Fri,  8 Jan 2021 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610144721;
        bh=3X4R3MdRto1KQXxhjRVL+U925hb7ZY1M1xT36pIAaAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PkDHX05iELQPMNb+6Lt1xlwzwGc3qd7WEacCaF6GqnfAGDuTNYAuum/npaGvDGacz
         SMRB8qallMTJvN3bJ6vAGW51bsAq3EZzELIbKwX+QNB4yH8p8g7f7I3SCF8RLRoAKw
         xPeuSloJtCFsJItNBt/HTO88Eun/n4hjdieisHNfybLNXLomGZdIIWJNrK0/LkYJ8K
         FZOHilVOAL3rP3zw0nR/V9rztIyNW0W4WjeJV1gyAPx1rtMS3HqFcUWnGP1pKiBX69
         0mwaSMou1kb5kTmh6qRI29M7mOxJ6K2EI3S24uUvC6V82b4g8SKNh0fRxAkJFFtrds
         vE/FFOlOA45Xg==
Date:   Fri, 8 Jan 2021 16:25:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com,
        zengweiliang.zengweiliang@huawei.com, chenlizhong@huawei.com
Subject: Re: [v3] PCI: Add pci reset quirk for Huawei Intelligent NIC virtual
 function
Message-ID: <20210108222519.GA1473637@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225092530.5728-1-chiqijun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/pci reset/reset/ in subject (it's obvious this is for PCI).

On Fri, Dec 25, 2020 at 05:25:30PM +0800, Chiqijun wrote:
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
>  drivers/pci/quirks.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..9c310012ef19 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3912,6 +3912,81 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
> +#define HINIC_VF_FLR_TYPE           0x1000
> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  6
> +#define HINIC_VF_OP                 0xE80
> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 10
> +#define HINIC_OPERATION_TIMEOUT     15000

Add a comment so we know the scale here.  "15 sec" or "15000 msec"
or similar.

> +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
> +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
> +{
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u16 command;
> +	u32 val;
> +
> +	if (probe)
> +		return 0;
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar)
> +		return -ENOTTY;
> +
> +	/*
> +	 * FLR cap bit bit30, FLR processing bit: bit18, to avoid big-endian
> +	 * conversion the big-endian bit6, bit10 is directly operated here.

I don't understand the big-endian comments here.  Unless the above
adds useful information, I'd say just remove it.

Obviously, the code here has to work correctly on both big- and
little-endian systems.

Below you use be32_to_cpu() before printing HINIC_VF_OP.  Why aren't
you using it here for HINIC_VF_FLR_TYPE?  be32_to_cpu() is common in
drivers/net/ethernet/huawei/hinic/, which I assume is for the same
device.

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
> +	/*
> +	 * The device must learn BDF after FLR in order to respond to BAR's
> +	 * read request, therefore, we issue a configure write request to let
> +	 * the device capture BDF.
> +	 */
> +	pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	pci_write_config_word(pdev, PCI_COMMAND, command);

I assume this is because of this requirement from PCIe r5.0, sec
2.2.9:

  Functions must capture the Bus and Device Numbers supplied with all
  Type 0 Configuration Write Requests completed by the Function, and
  supply these numbers in the Bus and Device Number fields of the
  Completer ID for all Completions generated by the Device/Function.

I'm a little concerned because it seems like this requirement should
apply to *all* resets, and I don't see where we do a similar write
following other resets.  Can you help me out?  Do we need this in
other cases?  Do we do it?

I'm also slightly nervous about writing the Command register, even
though we just reset the device (so the register should be all zeroes)
and we're writing the same value we just read from it.  Wouldn't
writing 0 to the Vendor ID register, which is guaranteed to be HwInit,
accomplish the same?

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

"%#010x" so it's obvious that this is hex, no matter what the value.

> +		 be32_to_cpu(val));
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
> @@ -3923,6 +3998,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
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
