Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F5CAB3C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJCR0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 13:26:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:52006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfJCR0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 13:26:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="343728350"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2019 10:23:44 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id C5CB3580378;
        Thu,  3 Oct 2019 10:23:44 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 7/7] PCI: Skip Enhanced Allocation (EA) initialization
 for VF device
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0b86bafdeaf8293d6360bed1760586493935f16e.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <ecff2638-7a5a-3d5d-6f30-f9517b139696@linux.intel.com>
Date:   Thu, 3 Oct 2019 10:21:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0b86bafdeaf8293d6360bed1760586493935f16e.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 8/28/19 3:14 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> As per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
> Capability. So skip pci_ea_init() for virtual devices.
>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
This patch was also dropped in your v8. Is this also intentional?
> ---
>   drivers/pci/pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1b27b5af3d55..266600a11769 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3025,6 +3025,13 @@ void pci_ea_init(struct pci_dev *dev)
>   	int offset;
>   	int i;
>   
> +	/*
> +	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced
> +	 * Allocation Capability.
> +	 */
> +	if (dev->is_virtfn)
> +		return;
> +
>   	/* find PCI EA capability in list */
>   	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
>   	if (!ea)

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

