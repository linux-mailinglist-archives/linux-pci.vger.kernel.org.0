Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB562B6FA2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 21:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgKQUHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 15:07:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:60970 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbgKQUHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 15:07:42 -0500
IronPort-SDR: 1bsCtKMA7Ava+LjMH2G6GMxwtUVsTjdGPLZevdSwbFQJUwQxjpvNTj6qouPxMg5Hhf9i3hBavz
 kUAJND5aVfSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="235150850"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="235150850"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:07:31 -0800
IronPort-SDR: tHxCm68NdJYNCsRjH4dG+7hOd/jo48FFQchA5IW94CLuatAKB8hUNPpwOq4P6ooCyZxv03jxPa
 mQJK/qkUXUzQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544191455"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:07:31 -0800
Subject: Re: [PATCH v11 02/16] PCI/RCEC: Add RCEC class code and extended
 capability
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-3-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f90fcafa-3aea-758a-b3ef-636aeaf0ee4b@linux.intel.com>
Date:   Tue, 17 Nov 2020 12:07:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-3-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/17/20 11:19 AM, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> A PCIe Root Complex Event Collector (RCEC) has base class 0x08, sub-class
> 0x07, and programming interface 0x00.  Add the class code 0x0807 to
> identify RCEC devices and add #defines for the RCEC Endpoint Association
> Extended Capability.
> 
> See PCIe r5.0, sec 1.3.4 ("Root Complex Event Collector") and sec 7.9.10
> ("Root Complex Event Collector Endpoint Association Extended Capability").
Why not merge this change with usage patch ? Keeping changes together will help
in case of reverting the code.
> 
> Link: https://lore.kernel.org/r/20201002184735.1229220-2-seanvk.dev@oregontracks.org
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/linux/pci_ids.h       | 1 +
>   include/uapi/linux/pci_regs.h | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1ab1e24bcbce..d8156a5dbee8 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -81,6 +81,7 @@
>   #define PCI_CLASS_SYSTEM_RTC		0x0803
>   #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>   #define PCI_CLASS_SYSTEM_SDHCI		0x0805
> +#define PCI_CLASS_SYSTEM_RCEC		0x0807
>   #define PCI_CLASS_SYSTEM_OTHER		0x0880
>   
>   #define PCI_BASE_CLASS_INPUT		0x09
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a95d55f9f257..bccd3e35cb65 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -831,6 +831,13 @@
>   #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
>   #define PCI_EXT_CAP_PWR_SIZEOF	16
>   
> +/* Root Complex Event Collector Endpoint Association  */
> +#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
> +#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least version with BUSN present */
> +#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
> +#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
> +
>   /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
>   #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
>   #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
