Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E795559B7E2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 05:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiHVDTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHVDTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 23:19:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253B193E3
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661138373; x=1692674373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RHdIPABHm5G4mxoBbM8iezH5AMduC3yy6QaMW/fwXhc=;
  b=G/u2lzDdE4PWsHUbrPjOpA/dInfqolzS9FKT7A03NIQFiBUMuzGcJ0/N
   aftoBw6AAR/DZoOsIxuMMmRe/bWUxLxixmkHYq2K6O2qYHLQnxvYBaQgo
   4Sad9Qqp0/CAAiS5mCNNBmJjOlDy2iLz108a8JVNJpcjkM7ej1RL1vI0a
   lwKPwJbuB/CWiIZi8j5ZBTy5Pl3x8mfIhbC104rn7AQRM4w/BNINusrIP
   qGsRoIWSbGw2a7Jtp71rdSgIBjJBguAdUM98yuWLdW+wBFxxS46XzyU1s
   xE/CA/FXX0OMtxxK4nsSMBRd7V86QAA9q/dppv4EqTEMC/I9OyqB2257K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="273066172"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="273066172"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 20:19:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="734955237"
Received: from sravindr-mobl1.amr.corp.intel.com (HELO [10.212.173.200]) ([10.212.173.200])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 20:19:32 -0700
Message-ID: <af6097d5-52f0-1152-a1a9-b84c0cdf6ccb@linux.intel.com>
Date:   Sun, 21 Aug 2022 20:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for certain Intel PCIe root
 ports
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
References: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/16/22 3:20 AM, Mika Westerberg wrote:
> There is a BIOS bug on Intel Tiger Lake and Alder Lake systems that
> accidentally clears the root port PIO log size even though it should be 4.
> Fix the affected root ports by forcing the log size to be 4 if it is set
> to 0. The BIOS for the next generation CPUs should have this fixed.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209943
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/pci/pcie/dpc.c | 13 ++++++++-----
>  drivers/pci/quirks.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d..ab06c801a2c1 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -335,11 +335,14 @@ void pci_dpc_init(struct pci_dev *pdev)
>  		return;
>  
>  	pdev->dpc_rp_extensions = true;
> -	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> -	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> -		pci_err(pdev, "RP PIO log size %u is invalid\n",
> -			pdev->dpc_rp_log_size);
> -		pdev->dpc_rp_log_size = 0;
> +	/* If not already set by the quirk in quirks.c */
> +	if (!pdev->dpc_rp_log_size) {
> +		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> +			pci_err(pdev, "RP PIO log size %u is invalid\n",
> +				pdev->dpc_rp_log_size);
> +			pdev->dpc_rp_log_size = 0;
> +		}
>  	}
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4944798e75b5..260d8b50f68d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5956,3 +5956,40 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>  #endif
> +
> +#ifdef CONFIG_PCIE_DPC
> +/*
> + * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
> + * log size of the integrated Thunderbolt PCIe root ports so we quirk
> + * them here.
> + */
> +static void dpc_log_size(struct pci_dev *dev)
> +{
> +	u16 dpc_cap, val;
> +
> +	dpc_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
> +	if (!dpc_cap)
> +		return;
> +
> +	pci_read_config_word(dev, dpc_cap + PCI_EXP_DPC_CAP, &val);
> +	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
> +		return;
> +
> +	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
> +		pci_info(dev, "quirking RP PIO log size\n");
> +		dev->dpc_rp_log_size = 4;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a29, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> +#endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
