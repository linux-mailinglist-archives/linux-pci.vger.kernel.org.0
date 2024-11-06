Return-Path: <linux-pci+bounces-16148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CD9BF274
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCD1F220D0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8A2040B7;
	Wed,  6 Nov 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMU/krQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC42064E7;
	Wed,  6 Nov 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908961; cv=none; b=NEp/czHLmmwfYG3Mbzm3s7eDFZt6jZZyZgCW7KoiW5SIODJdpWBqgYzgAl8J37cOM8qRuiDd1JtNCieOU5cz2nVC7vpI2oCRNP7WZvCp4HnYMwv05Ft+Lt4yfGd50CZOMmMOiuo4ZNCwW1d0NcEx2RZ3VSw4LabQw+YHDSQREhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908961; c=relaxed/simple;
	bh=0qutDu9YbEj/rRQis2rl/rg++RhIXZjpIIS7syx2Ycs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tPakA9aepfb7x4pHNAIIeMmNoonEgZlkNQriFW6WCO4TXtIU5G5c7d5vePNQSINJStTSSGHHstCxkdSEIike4XBFLXRRnTpfDo/GWs+z7zrMzd5tgsCfGRwLToaMNE8IrYVgstxUlmFOepFSSIhiX6iqxo9Jow0qZrR2j3Zw/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMU/krQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7CCC4CED3;
	Wed,  6 Nov 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908960;
	bh=0qutDu9YbEj/rRQis2rl/rg++RhIXZjpIIS7syx2Ycs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lMU/krQ3d8TNadrJVau3eQBLcgfj2Q8/6s/lIRz8YgO7m64dWRsY/9dfplvaYvyHe
	 m2jRIMMk99Z07fEDy4jjEJZAbbw5Fva0c2ERyalNDNHzDwjci/09/oJ0MtDjOmQjWV
	 cc7dj8SuaTwRgTVARtD3UBzZO6x+YKTLV/epCddQI75Rxn/9oTa/bnlX9Pe/UMQ7X7
	 Hy+YQ9DypoJNDTJg0y9C7cxJb7sr0fi83wLs+99mzdi+rFCjnqg714CFURmWK3ZT44
	 ghZMhfmliM/dYvNDdoMnyUwb7sBe27yrc4r+5ZAK9C4LC5D90QM5LLYqFuxI5VlR1i
	 s7SvPShdgcAew==
Date: Wed, 6 Nov 2024 10:02:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	mahesh@linux.ibm.com, oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC PATCH v1 2/2] PCI/AER: report fatal errors of RCiEP and EP
 if link recoverd
Message-ID: <20241106160238.GA1526691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106090339.24920-3-xueshuai@linux.alibaba.com>

On Wed, Nov 06, 2024 at 05:03:39PM +0800, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of an
> endpoint or RCiEP that reported a fatal error, considering the link to that
> device unreliable. Consequently, when a fatal error occurs, the AER and DPC
> drivers do not report specific error types, resulting in logs like:
> 
> [  245.281980] pcieport 0000:30:03.0: EDR: EDR event received
> [  245.287466] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
> [  245.295372] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
> [  245.300849] pcieport 0000:30:03.0: AER: broadcast error_detected message
> [  245.307540] nvme nvme0: frozen state error detected, reset controller
> [  245.722582] nvme 0000:34:00.0: ready 0ms after DPC
> [  245.727365] pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> But, if the link recovered after hot reset, we can safely access AER status of
> the error device. In such case, report fatal error which helps to figure out the
> error root case.

Explain why we can access these registers after reset.  I think it's
important that these registers are sticky ("RW1CS" per spec).

> After this patch, the logs like:
> 
> [  414.356755] pcieport 0000:30:03.0: EDR: EDR event received
> [  414.362240] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
> [  414.370148] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
> [  414.375642] pcieport 0000:30:03.0: AER: broadcast error_detected message
> [  414.382335] nvme nvme0: frozen state error detected, reset controller
> [  414.645413] pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
> [  414.788016] nvme 0000:34:00.0: ready 0ms after DPC
> [  414.796975] nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
> [  414.807312] nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
> [  414.815305] nvme 0000:34:00.0:    [ 4] DLP                    (First)
> [  414.821768] pcieport 0000:30:03.0: AER: broadcast slot_reset message

Capitalize subject lines to match history (use "git log --oneline
drivers/pci/pcie/aer.c" to see it).

Remove timestamps since they don't help understand the problem.

Indent the quoted material two spaces.

Wrap commit log to fit in 75 columns (except the quoted material;
don't insert line breaks there).

> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/pci/pci.h      |  1 +
>  drivers/pci/pcie/aer.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/err.c |  6 +++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0866f79aec54..143f960a813d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -505,6 +505,7 @@ struct aer_err_info {
>  };
>  
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> +int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  #endif	/* CONFIG_PCIEAER */
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 13b8586924ea..0c1e382ce117 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1252,6 +1252,56 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	return 1;
>  }
>  
> +/**
> + * aer_get_device_fatal_error_info - read fatal error status from EP or RCiEP
> + * and store it to info
> + * @dev: pointer to the device expected to have a error record
> + * @info: pointer to structure to store the error record
> + *
> + * Return 1 on success, 0 on error.

Backwards from the usual return value convention.

> + * Note that @info is reused among all error devices. Clear fields properly.
> + */
> +int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	int type = pci_pcie_type(dev);
> +	int aer = dev->aer_cap;
> +	u32 aercc;
> +
> +	pci_info(dev, "type :%d\n", type);

I don't see this line in the sample output in the commit log.  Is this
debug that you intended to remove?

> +	/* Must reset in this function */
> +	info->status = 0;
> +	info->tlp_header_valid = 0;
> +	info->severity = AER_FATAL;
> +
> +	/* The device might not support AER */

Unnecessary comment.

> +	if (!aer)
> +		return 0;
> +
> +
> +	if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END) {
> +		/* Link is healthy for IO reads now */
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
> +			&info->status);
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> +			&info->mask);
> +		if (!(info->status & ~info->mask))
> +			return 0;
> +
> +		/* Get First Error Pointer */
> +		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
> +		info->first_error = PCI_ERR_CAP_FEP(aercc);
> +
> +		if (info->status & AER_LOG_TLP_MASKS) {
> +			info->tlp_header_valid = 1;
> +			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
> +		}
> +	}
> +
> +	return 1;
> +}
> +
>  static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  {
>  	int i;
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..a74ae6a55064 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	struct pci_dev *bridge;
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	struct aer_err_info info;
>  
>  	/*
>  	 * If the error was detected by a Root Port, Downstream Port, RCEC,
> @@ -223,6 +224,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_warn(bridge, "subordinate device reset failed\n");
>  			goto failed;
>  		}
> +
> +		/* Link recovered, report fatal errors on RCiEP or EP */
> +		if (aer_get_device_fatal_error_info(dev, &info))
> +			aer_print_error(dev, &info);
>  	} else {
>  		pci_walk_bridge(bridge, report_normal_detected, &status);
>  	}
> @@ -259,6 +264,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	if (host->native_aer || pcie_ports_native) {
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
>  	}
>  
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> -- 
> 2.39.3
> 

