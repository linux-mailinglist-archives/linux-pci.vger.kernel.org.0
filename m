Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE96A4ADA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB0T3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjB0T3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 14:29:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98811234FA;
        Mon, 27 Feb 2023 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677526189; x=1709062189;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v3mSa++3w5di4VuVyxMCx7ivKLHS0LlRNUH1BB+AgB8=;
  b=hZ/SOCRwBXaRf2haKwIDhDVWoiuGDCxQCFc49c1o8U/4vK9dS9cAqhtO
   XjdUWa5zZOYzf+llEc3jV4yPm/UxEByEkTF4iFo3c/XYMexgpVS4FTLp1
   BL5yNUwznYP34nOINwbuITzBxdeuxqzCtDWZ09kJFP0iLVQ088ZqvtvlA
   SY4wx3uLtydVLdcNBb/fD9uGVbh11w0qYAQlns9fm/k+oTlS7nCTsWDJE
   9VCePvBTMA/NbiIeX4PvT+c0Mh/YW73vW+vdFWTe8FuiSuO6RUhhRlnKX
   x3wdoFaawKZ7jAohAp8JIO+fECXjAxo1BQUXOcdIkdj/bZyvikbYBh6tr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313619215"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313619215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 11:29:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="737856265"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="737856265"
Received: from cpalit-mobl2.amr.corp.intel.com (HELO [10.212.235.220]) ([10.212.235.220])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 11:29:48 -0800
Message-ID: <b7a71cca-8223-7346-c024-edc80a106042@linux.intel.com>
Date:   Mon, 27 Feb 2023 11:29:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] PCI/ATS: Add a helper function to configure ATS STU
 of a PF.
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
 <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/27/23 5:21 AM, Ganapatrao Kulkarni wrote:
> As per PCI specification (PCI Express Base Specification Revision
> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
> independently for ATS capability, however the STU(Smallest Translation
> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
> the associated PF's value applies to VFs.
> 
> In the current code, the STU is being configured while enabling the PF ATS.
> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
> associated PF already.> 
> Adding a function pci_ats_stu_configure(), which can be called to
> configure the STU during PF enumeration.
> Latter enumerations of VFs can successfully enable ATS independently.

Why not enable ATS in PF before enabling it in VF? Just updating STU of
PF and not enabling it seem odd.

> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  drivers/pci/ats.c       | 32 ++++++++++++++++++++++++++++++--
>  include/linux/pci-ats.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..70e1982efdb4 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -46,6 +46,34 @@ bool pci_ats_supported(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>  
> +/**
> + * pci_ats_stu_configure - Configure STU of a PF.
> + * @dev: the PCI device
> + * @ps: the IOMMU page shift
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> +{
> +	u16 ctrl;
> +
> +	if (dev->ats_enabled || dev->is_virtfn)
> +		return 0;
> +
> +	if (!pci_ats_supported(dev))
> +		return -EINVAL;
> +
> +	if (ps < PCI_ATS_MIN_STU)
> +		return -EINVAL;
> +
> +	dev->ats_stu = ps;
> +	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);

If you just want to update the STU, don't overwrite other fields.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -68,8 +96,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  		return -EINVAL;
>  
>  	/*
> -	 * Note that enabling ATS on a VF fails unless it's already enabled
> -	 * with the same STU on the PF.
> +	 * Note that enabling ATS on a VF fails unless it's already
> +	 * configured with the same STU on the PF.
>  	 */
>  	ctrl = PCI_ATS_CTRL_ENABLE;
>  	if (dev->is_virtfn) {
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index df54cd5b15db..9b40eb555124 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -8,6 +8,7 @@
>  /* Address Translation Service */
>  bool pci_ats_supported(struct pci_dev *dev);
>  int pci_enable_ats(struct pci_dev *dev, int ps);
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);

What about dummy declaration for !CONFIG_PCI_ATS case?

>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
