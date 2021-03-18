Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAE340F6C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 21:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCRUzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 16:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhCRUy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 16:54:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D4A564E37;
        Thu, 18 Mar 2021 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616100896;
        bh=iI8Uazl5tt1KP7H0SEdxMUR1oadEFMxyq7jgF2Y2rc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BEA+rybpzkriZQNUKA4Yu1a/dGp32eWbgVKoMDy02EDQJfSkCfRu9CMyOviNag2sQ
         aemdmyXefjVBj/W0l+JJQ60fOHLoXNi1WEqtDUoXoMHX4OGgRN+rQo4ePqSjinemJT
         CAwZZ3TpK5uLcl4Rq2w4iILuqL2qKZw4JnS/rIO6krkbavcEbiq+mpDgIXmkHjma5Z
         WdepdxofYrfxED/y4BU9UgZ76cP4xE07gh4c0ATnHzqhAnwEL/RH0iN2JyYSCELzzC
         0NOrelFIT+g7OwOnGo2j2f3LuTCFfR9tMmlhQOW4kNlvqMKfglLDbUCMyk1QPbtiYP
         108VhKsAIlHbg==
Date:   Thu, 18 Mar 2021 15:54:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com,
        zengweiliang.zengweiliang@huawei.com, chenlizhong@huawei.com
Subject: Re: [v5] PCI: Add reset quirk for Huawei Intelligent NIC virtual
 function
Message-ID: <20210318205455.GA160826@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316140847.3326-1-chiqijun@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 10:08:47PM +0800, Chiqijun wrote:
> When multiple VFs do FLR at the same time, the firmware is
> processed serially, resulting in some VF FLRs being delayed more
> than 100ms, when the virtual machine restarts and the device
> driver is loaded, the firmware is doing the corresponding VF
> FLR, causing the driver to fail to load.

Nit: VFs do not do FLR; *software* does FLR on a VF.  And I think this
is a spec compliance issue specific to the Huawei NIC.  I would say
something like "When we do an FLR on several VFs at the same time, the
Huawei Intelligent NIC processes them serially, ..."

"VF FLRs being delayed more than 100ms" does not by itself explain
what the problem is.  I'm guessing the problem is that it exceeds the
"msleep(100)" in pcie_flr(), which is based on PCIe r5.0, sec 6.6.2,
which requires:

  After an FLR has been initiated by writing a 1b to the Initiate
  Function Level Reset bit, the Function must complete the FLR within
  100 ms.

So this device is apparently out of spec.  Is there an erratum for
this?  Please cite it and quote the relevant part here.  I want to
avoid having to update this quirk with future device IDs.

IIUC, VFIO is initiating the FLR, probably as part of assigning the VF
to a VM?

> To solve this problem, add host and firmware status synchronization
> during FLR.
> 
> Signed-off-by: Chiqijun <chiqijun@huawei.com>
> ---
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
> index 653660e3ba9e..343890432ba8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3913,6 +3913,73 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_HINIC_VF      0x375E
> +#define HINIC_VF_FLR_TYPE           0x1000
> +#define HINIC_VF_FLR_CAP_BIT_SHIFT  30
> +#define HINIC_VF_OP                 0xE80
> +#define HINIC_VF_FLR_PROC_BIT_SHIFT 18
> +#define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */

If you did this:

  #define HINIC_VF_FLR_CAP_BIT   (1UL << 30)
  #define HINIC_VF_FLR_PROC_BIT  (1UL << 18)

the code below could be a little more readable, e.g,:

  if (!(val & HINIC_VF_FLR_CAP_BIT))
    ...
  val |= HINIC_VF_FLR_PROC_BIT;

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
> +	if (!(val & (1UL << HINIC_VF_FLR_CAP_BIT_SHIFT))) {
> +		pci_iounmap(pdev, bar);
> +		return -ENOTTY;
> +	}
> +
> +	/*
> +	 * Set the processing bit for the start of FLR, which will be cleared
> +	 * by the firmware after FLR is completed.
> +	 */
> +	val = ioread32be(bar + HINIC_VF_OP);
> +	val = val | (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT);

> +	iowrite32be(val, bar + HINIC_VF_OP);
> +
> +	/* Perform the actual device function reset */
> +	pcie_flr(pdev);
> +
> +	/*
> +	 * The device must learn BDF after FLR in order to respond to BAR's
> +	 * read request, therefore, we issue a configure write request to let
> +	 * the device capture BDF.

Will this device capture the bus/device here even though it hasn't
completed the reset?  Or does this write need to happen below, after
the device has cleared HINIC_VF_FLR_PROC_BIT?

> +	 */
> +	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
> +
> +	/* Waiting for device reset complete */
> +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
> +	do {
> +		val = ioread32be(bar + HINIC_VF_OP);
> +		if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
> +			goto reset_complete;
> +		msleep(20);
> +	} while (time_before(jiffies, timeout));
> +
> +	val = ioread32be(bar + HINIC_VF_OP);
> +	if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
> +		goto reset_complete;
> +
> +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %#010x\n", val);

s/flr/FLR/

> +reset_complete:
> +	pci_iounmap(pdev, bar);
> +
> +	return 0;

You return 0 (success) even if the reset timed out.  Is that what you
want?

I'd consider adding an "int err" local variable, then doing this so
there's a single cleanup place that does the pci_iounmap() and the
straight-line main path is the non-error one:

    int err = 0;

    if (!(val & HINIC_VF_FLR_CAP_BIT)) {
      err = -ENOTTY;
      goto reset_complete;
    }

    do {
      ...
    } while (time_before(jiffies, timeout));

    val = ioread32be(bar + HINIC_VF_OP);
    if (val & HINIC_VF_FLR_PROC_BIT) {
      pci_warn(pdev, "Reset dev timeout, FLR ack reg: %#010x\n", val);
      err = -EBUSY;            /* if you want error here; I dunno */
      goto reset_complete;
    }

    /* Let device capture bus/device, per PCIe r5.0, sec 2.2.9 */
    pci_write_config_word(pdev, PCI_VENDOR_ID, 0);  /* if it goes here? */

  reset_complete:
    pci_iounmap(pdev, bar);
    return err;

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
