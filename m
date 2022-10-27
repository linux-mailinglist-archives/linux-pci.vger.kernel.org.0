Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C060EF42
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 06:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ0E7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 00:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiJ0E7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 00:59:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45915819A;
        Wed, 26 Oct 2022 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666846741; x=1698382741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VIboXZAzPOAyqYw2WVL+sf/zfuy9m8FGbkzVfNiyFOo=;
  b=Nukh5lyMS4N81XwHuDdamTBBB+XJcSeLXUj52fLhSCkpTcGE9RvVDgDb
   5JFsSZYcG26G4XJORIS4mjIWtG3IfAx9vh9IQP3iBb5Ftsm8DNQh2QQMx
   nOdA3a6Z1hSZpCo61jSJ7BU5VaDlNAkub1sZtUatV928aQoRVj0t6r+aw
   XwsnUqLKl5BPsdtx0wEy5XRighr4dvz/5aWBEGCOtKq7GBDdrJP0XWFpL
   kh0R+BgYD3COtEgWPUznvyPUzQriMaDHXmdsXjhzk6bGa17VNQ2nJ7C7X
   eG+dqGnst5wQaTXyQ35EvVl0gG4J6CpMAeBjkVBilkCJvoRxYj0SffV+a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295538600"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295538600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:59:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774854441"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774854441"
Received: from holmeskx-mobl.amr.corp.intel.com (HELO [10.209.105.249]) ([10.209.105.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:59:00 -0700
Message-ID: <f00d1a76-d066-2a03-d5e9-d445a8307e85@linux.intel.com>
Date:   Wed, 26 Oct 2022 21:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] ACPI/APEI: Add apei_hest_parse_aer()
Content-Language: en-US
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, robert.moore@intel.com, ying.huang@intel.com,
        rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Cc:     CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
References: <20221027031518.2855743-1-LeoLiu-oc@zhaoxin.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221027031518.2855743-1-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/22 8:15 PM, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> apei_hest_parse_aer() is used to parse and record the PCI Express AER
> Structure in the HEST Table.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>

Does this code compile? It looks like there are some compile time issues.

> ---
>  drivers/acpi/apei/hest.c | 119 ++++++++++++++++++++++++++++++++++++++-
>  include/acpi/actbl1.h    |  69 +++++++++++++++++++++++
>  include/acpi/apei.h      |   7 +++
>  3 files changed, 194 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..0bfdc18758f5 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> +#include <linux/pci.h>
>  
>  #include "apei-internal.h"
>  
> @@ -86,7 +87,48 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  	return len;
>  };
>  
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);

You are still using apei_hest_func_t. Why remove it?

> +static inline bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
> +{
> +	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
> +		hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
> +		hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
> +				struct pci_dev *dev)
> +{
> +	u16 hest_type = hest_hdr->type;
> +	u8 pcie_type = pci_pcie_type(dev);
> +
> +	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
> +		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
> +		(hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
> +		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
> +		(hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
> +		(pcie_type == PCI_EXP_TYPE_PCI_BRIDGE || pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE)))
> +		return true;
> +	return false;
> +}
> +
> +static inline bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
> +		struct pci_dev *pci)
> +{
> +	return	ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
> +			ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
> +			p->device                 == PCI_SLOT(pci->devfn) &&
> +			p->function               == PCI_FUNC(pci->devfn);
> +}
> +
> +static inline bool hest_match_pci(struct acpi_hest_header *hest_hdr,
> +		struct acpi_hest_aer_common *p, struct pci_dev *pci)
> +{
> +	if (hest_match_type(hest_hdr, pci))
> +		return(hest_match_pci_devfn(p, pci));

I think it is return hest_match_pci_devfn(p, pci);

> +	else
> +		return false;
> +}
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
> @@ -124,6 +166,81 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  	return 0;
>  }
>  
> +/*
> + * apei_hest_parse_aer - Find the AER structure in the HEST Table and
> + * match it with the PCI device.
> + *
> + * @hest_hdr: To save the acpi aer error source in hest table
> + *
> + * Return 1 if the pci dev matched with the acpi aer error source in
> + * hest table, else return 0.
> + */
> +int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	struct acpi_hest_parse_aer_info *info = data;
> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint = NULL;
> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port = NULL;
> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge = NULL;
> +
> +	if (!hest_source_is_pcie_aer(hest_hdr))
> +		return 0;
> +
> +	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT) {
> +		acpi_hest_aer_root_port = (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
> +		if (acpi_hest_aer_root_port->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_root_port,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	} else if (hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT) {
> +		acpi_hest_aer_endpoint = (struct acpi_hest_aer_endpoint *)(hest_hdr + 1);
> +		if (acpi_hest_aer_endpoint->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_endpoint,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	} else if (hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE) {
> +		acpi_hest_aer_for_bridge =
> +			(struct acpi_hest_aer_for_bridge *)(hest_hdr + 1);
> +		if (acpi_hest_aer_for_bridge->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_for_bridge,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	}
> +	return info->hest_matched_with_dev;
> +}
> +
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
>   * along with a set of MC banks which work in FF mode.
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..7f52035512b2 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1385,6 +1385,75 @@ struct acpi_hest_aer_bridge {
>  	u32 advanced_capabilities2;
>  };
>  
> +struct acpi_hest_parse_aer_info {
> +	struct pci_dev *pci_dev;
> +	int hest_matched_with_dev;
> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint;
> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port;
> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge;
> +};
> +
> +/* HEST Sub-structure for PCIE EndPoint Structure (6) */
> +
> +struct acpi_hest_aer_root_port {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;		/* Bus and Segment numbers */
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +	u32 root_error_command;
> +};
> +
> +/* HEST Sub-structure for PCIE EndPoint Structure (7) */
> +
> +struct acpi_hest_aer_endpoint {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;		/* Bus and Segment numbers */
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +};
> +
> +/* HEST Sub-structure for PCIE/PCI Bridge Structure (8) */
> +
> +struct acpi_hest_aer_for_bridge {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +	u32 uncorrectable_mask2;
> +	u32 uncorrectable_severity2;
> +	u32 advanced_capabilities2;
> +};
> +
>  /* 9: Generic Hardware Error Source */
>  
>  struct acpi_hest_generic {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524..8a0b2b9edbaf 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -33,10 +33,17 @@ void __init acpi_ghes_init(void);
>  static inline void acpi_ghes_init(void) { }
>  #endif
>  
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  int erst_write(const struct cper_record_header *record);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
