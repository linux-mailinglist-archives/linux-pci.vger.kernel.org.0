Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0902E9EB8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 21:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhADUOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 15:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728159AbhADUOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 15:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609791186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7AopbdliPzk094KL/6LdCyv8OyaZvzMKWpZI2pvt0I=;
        b=fo4Zx2cc39TOOBT0TWpUyOe5uhqC+5eJ8YalOzQm1c9QbQBz53u5RDHiOcnkbxSFainRcI
        rBbZbfM0Tlnf2k26MNvBeKSL8v0jH8YKxB4/VvunRRjVS/zQkl3XtdURES1vAEvkl+pTxO
        GZdoXO0rkztx9Or5VP5CzTWGvBLqDxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-XK8bh5C6Mqia8LLOm3VUYA-1; Mon, 04 Jan 2021 15:13:03 -0500
X-MC-Unique: XK8bh5C6Mqia8LLOm3VUYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50F76107ACE3;
        Mon,  4 Jan 2021 20:13:01 +0000 (UTC)
Received: from omen.home (ovpn-112-183.phx2.redhat.com [10.3.112.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C8D227C20;
        Mon,  4 Jan 2021 20:13:00 +0000 (UTC)
Date:   Mon, 4 Jan 2021 13:13:00 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Chiqijun <chiqijun@huawei.com>
Cc:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>,
        <zengweiliang.zengweiliang@huawei.com>, <chenlizhong@huawei.com>
Subject: Re: [v3] PCI: Add pci reset quirk for Huawei Intelligent NIC
 virtual function
Message-ID: <20210104131300.62c83a1f@omen.home>
In-Reply-To: <20201225092530.5728-1-chiqijun@huawei.com>
References: <20201225092530.5728-1-chiqijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Dec 2020 17:25:30 +0800
Chiqijun <chiqijun@huawei.com> wrote:

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


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

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
> +
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
> +	/*
> +	 * The device must learn BDF after FLR in order to respond to BAR's
> +	 * read request, therefore, we issue a configure write request to let
> +	 * the device capture BDF.
> +	 */
> +	pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	pci_write_config_word(pdev, PCI_COMMAND, command);
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

