Return-Path: <linux-pci+bounces-5625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F0897348
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4199728E97D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 15:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCD73506;
	Wed,  3 Apr 2024 15:01:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E83D96B;
	Wed,  3 Apr 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156517; cv=none; b=P2tPrMMgmU/clXhw75itX+3CCshLbCthf7wDl7xe+qbjNusKB64P2v9Llw5hw5JJt7dSCwT0XEZ8P/wjyp2h0DRUpsvhVjoY7EFXkK6lWjDlQ/IIySDsPF0d47Q9AsbeBVtRKU8/3qRxDhyIHCkbH6095vvRaasv1Y4zqGSst2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156517; c=relaxed/simple;
	bh=b5MDY1Li4PmUqo4TPIVk1kD9WGqB5ZAbkqfe3B13vgM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szM6X4K2q5HrZH3slH0ci9xGRGvzbxyjS9jufEJkZ6Fp6oJ0G2V8CO8hZ86bx2lV3FRmFQ+PZ4pXQicaGYCzujqpxjbdCU+88pehHQYf/01WxKixUIfnsWpUBKRLaTrq5UIqx38jtcXYJxDvqAV+cqmdXrZTJ2vdcJtTs8mVVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8nxB5zwGz6D8W5;
	Wed,  3 Apr 2024 23:00:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 729CF141251;
	Wed,  3 Apr 2024 23:01:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 16:01:50 +0100
Date: Wed, 3 Apr 2024 16:01:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 2/4] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240403160149.000041b0@Huawei.com>
In-Reply-To: <20240402234848.3287160-3-dave.jiang@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-3-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Apr 2024 16:45:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.
> 
> When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
> appear to have executed successfully. However the operation is actually
> masked. The intention is to inform the user that SBR for the CXL device
> is masked and will not go through.
> 
> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
> successfully.
> 
> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM though Lukas' comment make sense so I'll assume you'll tidy that up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v3:
> - Move and rename PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL.
>   Move to pci_ids.h in a different patch. (Bjorn)
> - Remove of CXL device checking. (Bjorn)
> - Rename defines to PCI_DVSEC_CXL_PORT_*. (Bjorn)
> - Fixup SBR define in commit log. (Bjorn)
> - Update comment on dvsec not found. (Dan)
> - Check return of dvsec value read for error. (Dan)
> ---
>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  5 ++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..00eddb451102 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static int cxl_port_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_PORT);
> +}
> +
> +static bool cxl_sbr_masked(struct pci_dev *dev)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	/*
> +	 * No DVSEC found, either is not a CXL port, or not connected in which
> +	 * case mask state is a nop (CXL r3.1 sec 9.12.3 "Enumerating CXL RPs
> +	 * and DSPs"
> +	 */
> +	dvsec = cxl_port_dvsec(dev);
> +	if (!dvsec)
> +		return false;
> +
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	if (rc || PCI_POSSIBLE_ERROR(reg))
> +		return false;
> +
> +	/*
> +	 * CXL spec r3.1 8.1.5.2
> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
> +	 * Control gets set to 1.
> +	 */
> +	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>  	int rc;
>  
> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
> +	if (bridge && cxl_sbr_masked(bridge)) {
> +		if (probe)
> +			return 0;
> +
> +		return -ENOTTY;
> +	}
> +
>  	rc = pci_dev_reset_slot_function(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..d61fa43662e3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1148,4 +1148,9 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> +/* Compute Express Link (CXL) */
> +#define PCI_DVSEC_CXL_PORT				3
> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +
>  #endif /* LINUX_PCI_REGS_H */


