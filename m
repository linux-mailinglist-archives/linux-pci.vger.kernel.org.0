Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE512B7123
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 22:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKQV6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 16:58:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:9888 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQV6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 16:58:41 -0500
IronPort-SDR: UiWoy1hIrgGpOmricjRR5QzIY2YkgALuutVAKtR3xnmhRVuuyP0wXN14p4mKu4LYvdg+0PgC5t
 W5bPerDA5pGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150867407"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150867407"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:58:38 -0800
IronPort-SDR: B+xFNCS5/yZL0R++PpXTVj+Yc9brAxYzIpD1yhxmH35WmaW8UnLPODj3VEHMNPrmPMLZ6i1EXT
 9AiEosLdczMQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544223980"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:58:37 -0800
Subject: Re: [PATCH v11 07/16] PCI/ERR: Simplify by computing pci_pcie_type()
 once
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-8-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <248d4a59-fa56-60cc-edb1-e3871431664d@linux.intel.com>
Date:   Tue, 17 Nov 2020 13:58:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-8-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/17/20 11:19 AM, Sean V Kelley wrote:
> Instead of calling pci_pcie_type(dev) twice, call it once and save the
> result.  No functional change intended.

Same optimization can be applied to drivers/pci/pcie/portdrv_pci.c and
drivers/pci/pcie/aer.c.

Can you fix them together ?

> 
> [bhelgaas: split to separate patch]
> Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/pci/pcie/err.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 05f61da5ed9d..7a5af873d8bc 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -150,6 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   		pci_channel_state_t state,
>   		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>   {
> +	int type = pci_pcie_type(dev);
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
>   
> @@ -157,8 +158,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	 * Error recovery runs on all subordinates of the first downstream port.
>   	 * If the downstream port detected the error, it is cleared at the end.
>   	 */
> -	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> +	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> +	      type == PCI_EXP_TYPE_DOWNSTREAM))
>   		dev = pci_upstream_bridge(dev);
>   	bus = dev->subordinate;
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
