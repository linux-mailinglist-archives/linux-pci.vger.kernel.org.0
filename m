Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6053C4C1DA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFST4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 15:56:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:26202 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFST4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 15:56:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 12:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="162310218"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2019 12:56:51 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 5B7FE580889;
        Wed, 19 Jun 2019 12:56:51 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 2/2] PCI/IOV: Assume SR-IOV VFs support extended config
 space.
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Hao Zheng <yinhe@linux.alibaba.com>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, nanhai.zou@linux.alibaba.com,
        quan.xu0@linux.alibaba.com, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
References: <156046609596.29869.5839964168034189416.stgit@gimli.home>
 <156046664016.29869.16676461736240878900.stgit@gimli.home>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <60712d78-b7a3-f50f-f5c3-a5e99841da4f@linux.intel.com>
Date:   Wed, 19 Jun 2019 12:54:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156046664016.29869.16676461736240878900.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/13/19 3:57 PM, Alex Williamson wrote:
> The SR-IOV specification requires both PFs and VFs to implement a PCIe
> capability.  Generally this is sufficient to assume extended config
> space is present, but we generally also perform additional tests to
> make sure the extended config space is reachable and not simply an
> alias of standard config space.  For a VF to exist extended config
> space must be accessible on the PF, therefore we can also assume it to
> be accessible on the VF.  This enables a micro performance
> optimization previously implemented in commit 975bb8b4dc93 ("PCI/IOV:
> Use VF0 cached config space size for other VFs") to speed up probing
> of VFs.
>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Hao Zheng <yinhe@linux.alibaba.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   drivers/pci/probe.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3a3c6b28343..439244ff8f09 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1561,6 +1561,21 @@ int pci_cfg_space_size(struct pci_dev *dev)
>   	u32 status;
>   	u16 class;
>   
> +#ifdef CONFIG_PCI_IOV
> +	/*
> +	 * Per the SR-IOV specification (rev 1.1, sec 3.5), VFs are required to
> +	 * implement a PCIe capability and therefore must implement extended
> +	 * config space.  We can skip the NO_EXTCFG test below and the
> +	 * reachability/aliasing test in pci_cfg_space_size_ext() by virtue of
> +	 * the fact that the SR-IOV capability on the PF resides in extended
> +	 * config space and must be accessible and non-aliased to have enabled
> +	 * support for this VF.  This is a micro performance optimization for
> +	 * systems supporting many VFs.
> +	 */
> +	if (dev->is_virtfn)
> +		return PCI_CFG_SPACE_EXP_SIZE;
> +#endif

It looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> +
>   	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
>   		return PCI_CFG_SPACE_SIZE;
>   
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

