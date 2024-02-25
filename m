Return-Path: <linux-pci+bounces-3984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E1862CB8
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 21:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07577281E80
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129419BBA;
	Sun, 25 Feb 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="If1PKg6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58607175A6;
	Sun, 25 Feb 2024 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891615; cv=none; b=evaW2iob8mGD6b/1XBy1TlqPcbOCTxMoNAQssLMjvsqgPgxa3NQHuwxH5MVdMxaJVgObAVySMpUsN/79jZuQ6k8TpMxFQYILd89FFMPVMI0ZVcQsrN+ot0DPJNki27Hx6FZWEXJqhC+2+CsqfQEdoXqMga5k7sMOuLmRAS5E3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891615; c=relaxed/simple;
	bh=O6vcBGiENNkdA0mo0YmFkQXQyNfGepxUp1HmgXTRVys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS0NMPCsWoDhHGP31rBWqZs6CYVGkR+OsxZiLTw7z1+oWGAn4Fh93jGHKo4z6U6zpzG42069wtWr0+XF0J8EVSdeCM437HjjHBRsF7GkL6WfuvkW5VmDPXeYE5rxCeYtlmMFAigLyfWJB4EtU0Eep51Tjxf+e3lf1eZeI4jDYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=If1PKg6K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891614; x=1740427614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O6vcBGiENNkdA0mo0YmFkQXQyNfGepxUp1HmgXTRVys=;
  b=If1PKg6KV8tYXfxC/MCebr5jy//xORGmpdHUaLNXe6rP/UIOx213MP6Y
   1Hqo3rtNz5CnUN7Qw4T+aVBXbB1X4pIuIMfYqx23zb9Uew8lE75i8xEhR
   f3SW150xxDQwdwSPFS/X90OdX5294eDF4yk9H8DLovU4/uSfRC3u350aP
   hf6VW2S2JSxnhlG8X01KLnnlhHyUIvZzH31iR/dp4vBuITqKBH9YUkoak
   KX1w6ZE5p5qvLicbhBrU6lmamQa6NcX89qw4OIX31vtQrebV6+BZvMP8E
   LpmhGigFM7ApIzHMjErw+OCLZ6UIlZ8NZwCrkBQZAFE3Hi4eTd6O2cYJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3011965"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3011965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6590003"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:06:53 -0800
Message-ID: <572af7f6-2544-4708-a90d-e18c58eb2762@linux.intel.com>
Date: Sun, 25 Feb 2024 12:06:52 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240222221521.32159-1-helgaas@kernel.org>
 <20240222221521.32159-4-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222221521.32159-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_acpi_add_edr_notifier() and pci_acpi_remove_edr_notifier() are only
> referenced inside drivers/pci/.  Move their declarations from
> include/linux/pci-acpi.h to drivers/pci/pci.h so they're not visible
> outside drivers/pci/.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h        | 4 ++++
>  include/linux/pci-acpi.h | 8 --------
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..03bf2776d73b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -432,11 +432,15 @@ void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>  bool pci_dpc_recovered(struct pci_dev *pdev);
> +void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> +void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);

Protect them with CONFIG_ACPI?

>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) { }
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
>  static inline void pci_dpc_init(struct pci_dev *pdev) { }
>  static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
> +static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
> +static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 92e196ba0249..f447ce215adf 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -122,14 +122,6 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>  
> -#ifdef CONFIG_PCIE_DPC
> -void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> -void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
> -#else
> -static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
> -static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
> -#endif /* CONFIG_PCIE_DPC */
> -
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


