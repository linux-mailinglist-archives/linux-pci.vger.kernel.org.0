Return-Path: <linux-pci+bounces-32081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32902B047DC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B771888EE2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A961FCF7C;
	Mon, 14 Jul 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKlSriaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF22E36F0;
	Mon, 14 Jul 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520745; cv=none; b=cJ7CZV7fliHJgDxQINojLjOYaTl1Jsq+1xNIdj+usf6F0kS+WTQ4L9yRrl6/EnundeUVF+CU99FqBxD+oqxIIJBcQvw/SxvvROTSAuXCHQSxbwbx7CUxKNEazBeGSHDxSL27EVWdWwcfC/f/ygv/rTLzNT8CJJVSKgP1dOV6wXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520745; c=relaxed/simple;
	bh=JGfoNuNdgEmmvwOQjuJ/pE3uNH4lp4rvy6hViPgD98I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LjmEz9oK29S2F0apsR2xV5ajYPOlAMbgf9aF77+/TYKGqc6zvyBVanlPoi0j3GnlNJ0CvgGH5HyanIEF5h+XB99HwNvJa5YcV5Wzmp4puDwnmDVBatW01/wSkZbldd4XhPEqD/sUjVjvPC5chHGleIQm1QuZOpf3Hd/Z3W7rKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKlSriaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CF8C4CEED;
	Mon, 14 Jul 2025 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752520745;
	bh=JGfoNuNdgEmmvwOQjuJ/pE3uNH4lp4rvy6hViPgD98I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RKlSriaSuvQlw7vspXF8A2n3kf7NODkc76SHe233Qk0PWXUzyR25na7GtFAVTMQwu
	 if/+bk3iFn+HJs21IhsGmsWqQvKk4tBcLybKMx/BHd4xY+vJGduvO949XFyAq/MSL9
	 0mOWAiQi579jcPS1kgcgaKo7NXJqr+3z/mwG10jNZ6zAYZuih+GGLYE/uZy7iqCNsL
	 pYcU50EO81a3fnRzuF1m73EWW9ov0TlkF5ouqM0ZsOwUqfQzL9U5H5p1YGagdZ0qIU
	 Sw2G4pUhPLpsAxR0cYFo3ywokXw5TxA7WA5mUEabxPDciSAwuQQv6UtbprwSWMq4Gf
	 Og16CeHczR2vQ==
Date: Mon, 14 Jul 2025 14:19:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Weili Qian <qianweili@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liulongfang@huawei.com,
	Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] PCI: Add device-specific reset for Kunpeng virtual
 functions
Message-ID: <20250714191903.GA2414617@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712113028.15682-1-qianweili@huawei.com>

[+cc Hui]

On Sat, Jul 12, 2025 at 07:30:28PM +0800, Weili Qian wrote:
> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
> Configuration RRS"), pci_dev_wait() polls PCI_COMMAND register until
> its value is not ~0(i.e., PCI_ERROR_RESPONSE). After d591f6804e7e,
> if the Configuration Request Retry Status Software Visibility (RRS SV)
> is enabled, pci_dev_wait() polls PCI_VENDOR_ID register until its value
> is not the reserved Vendor ID value 0x0001.
> 
> On Kunpeng accelerator devices, RRS SV is enabled. However,
> when the virtual function's FLR (Function Level Reset) is not
> ready, the pci_dev_wait() reads the PCI_VENDOR_ID register and gets
> the value 0xffff instead of 0x0001. It then incorrectly assumes this
> is a valid Vendor ID and concludes the device is ready, returning
> successfully. In reality, the function may not be fully ready, leading
> to the device becoming unavailable.
> 
> A 100ms wait period is already implemented before calling pci_dev_wait().
> In most cases, FLR completes within 100ms. However, to eliminate the
> risk of function being unavailable due to an incomplete FLR, a
> device-specific reset is added. After pcie_flr(), the function continues
> to poll PCI_COMMAND register until its value is no longer ~0.

As far as I can tell, there's nothing specific to Kungpeng devices
here.  We've seen a similar issue with Intel NVMe devices [1], and I
don't want a whole mess of quirks and device-specific reset methods.

We need some sort of generic solution for this.  My understanding was
that if devices are not ready 100ms after a reset, they are required
to respond with RRS.  Maybe these devices are defective.  Or maybe my
understanding is incorrect.  Either way, I think we should at least
check for a PCIe error before assuming that 0xffff is a valid
response.

[1] https://lore.kernel.org/linux-pci/20250611101442.387378-1-hui.wang@canonical.com/

> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/pci/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee634263..1df1756257d2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4205,6 +4205,36 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define KUNPENG_OPERATION_WAIT_CNT	3000
> +#define KUNPENG_RESET_WAIT_TIME		20
> +
> +/* Device-specific reset method for Kunpeng accelerator virtual functions */
> +static int reset_kunpeng_acc_vf_dev(struct pci_dev *pdev, bool probe)
> +{
> +	u32 wait_cnt = 0;
> +	u32 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	pcie_flr(pdev);
> +
> +	do {
> +		pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
> +		if (!PCI_POSSIBLE_ERROR(cmd))
> +			break;
> +
> +		if (++wait_cnt > KUNPENG_OPERATION_WAIT_CNT) {
> +			pci_warn(pdev, "wait for FLR ready timeout; giving up\n");
> +			return -ENOTTY;
> +		}
> +
> +		msleep(KUNPENG_RESET_WAIT_TIME);
> +	} while (true);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4220,6 +4250,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF,
> +		reset_kunpeng_acc_vf_dev },
> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF,
> +		reset_kunpeng_acc_vf_dev },
> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF,
> +		reset_kunpeng_acc_vf_dev },
>  	{ 0 }
>  };
>  
> -- 
> 2.33.0
> 

