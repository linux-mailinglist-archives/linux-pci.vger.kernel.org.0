Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D693B4F421C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiDEOql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392036AbiDENta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 09:49:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275113D44
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649162959; x=1680698959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jSLT9G94zGhIjwUiwuzGIuTV8If/WGqEu69SjRXbZI=;
  b=W3bH7L5SD5bwkR3+iiywI70kgxSX6LJpb3wzsyd/cnIksgcDcv4VqWE3
   NWovYlWCE1HNfdFRSgYry9OHATq9dLcQPTU8gMt+uHYFhDbGPNNufpZt8
   tJXZuF47saDhEZ1c13Ac3bLI/RpYL3PORv88XAjw/baa4jKeq0x8U+7lz
   0PdHurgYEt4VPUXcW15TGS2UqhPtQfIvLs+z1NRTI1X9xGQ/BMRDpC54y
   3HRC8mryzm+1fKBcrxsi+l26+YkEXuF9h9WTU9m3cTLvvCjcSaUBIvXrT
   HvXuN7wb4okTEOUJ2NpG2IzMYEWKUqU2zytGPVdORC02wTNxFNxHjOnfy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258323302"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258323302"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:49:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569867567"
Received: from sahanaar-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.37.133])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:49:07 -0700
Date:   Tue, 5 Apr 2022 08:49:05 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be
 unlimited
Message-ID: <Ykw6wbMgk3u3sCLL@intel.com>
References: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 05, 2022 at 12:38:10PM +0300, Mika Westerberg wrote:
> Intel DG2 discrete graphics PCIe endpoints hard-code their acceptable L1
> ASPM latency to be < 1us even though the hardware actually supports
> higher latencies (> 64 us) just fine. In order to allow the links to go
> into L1 and save power, quirk the acceptable L1 ASPM latency for these
> endpoints to be unlimited.
> 
> Note this does not have any effect unless the user requested the kernel
> to enable ASPM in the first place (by default we don't enable it). This
> is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave" command
> line parameters.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..e97b5daa00eb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5895,3 +5895,47 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
> +
> +#ifdef CONFIG_PCIEASPM
> +/*
> + * Intel DG2 graphics card has hard-coded acceptable L1 latency that is
> + * too low which prevents ASPM to be enabled. It does support ASPM L1
> + * and tolerates higher latencies so quirk it to be unlimited.
> + */
> +static void quirk_aspm_accepted_l1_latency(struct pci_dev *dev)
> +{
> +	if ((dev->devcap & PCI_EXP_DEVCAP_L1) >> 9 < 7) {
> +		u32 devcap = dev->devcap;
> +
> +		dev->devcap |= 7 << 9;
> +		pci_info(dev, "quirking devcap for L1 accepted latency 0x%08x -> 0x%08x\n",
> +			 devcap, dev->devcap);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f80, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f81, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f82, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f83, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f84, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f85, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f86, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f87, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f88, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5690, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5691, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5692, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5693, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5694, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5695, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a1, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a2, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a3, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a4, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a5, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a6, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, quirk_aspm_accepted_l1_latency);
> +#endif

This matches our expectations and IDs.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> -- 
> 2.35.1
> 
