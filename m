Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116B56A5D22
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjB1Qac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 11:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjB1Qac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 11:30:32 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB484EC46;
        Tue, 28 Feb 2023 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601826; x=1709137826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dyojsfFIUKPS3PvJ1BbTCwtCmtNpDYEHb7YR/J13vUk=;
  b=OwLI+VrDCL8o0K15172bWMqQtuNJP/+rTm2b603cwaE5sFZi2J5nM3WO
   IDqO/3MPkkkaBzCrN/29PQAGrS6mF9xt7Cu+NpRfuk3rgQy/4lP3zx258
   uH2rK0EoRmS3fT/5Ej1ZgOmq7AJwC5tKPBnW/sOedp2QtfTOky7up/du8
   S2m3Q1q6B/ykq4U2Byfu9jkYGNLD1Dll3bD1bhuubmGwoKKM5D1fztQOy
   BGxp5XafYGx9NV8WaDbt96aZrIBx9lUSXCHu5yDnq/Yc2omVFvv1yrsGA
   55CcyMUk0O8tugHKNYC6ks6QmhhthCzbLbOXP62hyaxzgjTPb2IYamnNc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396751346"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="396751346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:30:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798107637"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="798107637"
Received: from ticela-az-102.amr.corp.intel.com (HELO [10.209.55.154]) ([10.209.55.154])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:30:24 -0800
Message-ID: <eefaf1bc-586b-aa0f-8899-fcce0460b733@linux.intel.com>
Date:   Tue, 28 Feb 2023 08:30:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
 <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/27/23 8:21 PM, Ganapatrao Kulkarni wrote:
> As per PCI specification (PCI Express Base Specification Revision
> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
> independently for ATS capability, however the STU(Smallest Translation
> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
> the associated PF's value applies to VFs.
> 
> In the current code, the STU is being configured while enabling the PF ATS.
> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
> associated PF already.
> 
> Adding a function pci_ats_stu_configure(), which can be called to
> configure the STU during PF enumeration.
> Latter enumerations of VFs can successfully enable ATS independently.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>  include/linux/pci-ats.h |  3 +++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..1611bfa1d5da 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
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

Is PF allowed to re-configure STU if there are other active
VF's which uses it?

> +
> +	if (!pci_ats_supported(dev))
> +		return -EINVAL;
> +
> +	if (ps < PCI_ATS_MIN_STU)
> +		return -EINVAL;
> +
> +	dev->ats_stu = ps;
> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
> +	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
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
> index df54cd5b15db..7d62a92aaf23 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -8,6 +8,7 @@
>  /* Address Translation Service */
>  bool pci_ats_supported(struct pci_dev *dev);
>  int pci_enable_ats(struct pci_dev *dev, int ps);
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);
> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>  { return false; }
>  static inline int pci_enable_ats(struct pci_dev *d, int ps)
>  { return -ENODEV; }
> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
> +{ return -ENODEV; }
>  static inline void pci_disable_ats(struct pci_dev *d) { }
>  static inline int pci_ats_queue_depth(struct pci_dev *d)
>  { return -ENODEV; }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
