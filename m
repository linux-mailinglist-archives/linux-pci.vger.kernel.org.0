Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD6B5B431B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiIIXiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIIXiv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:38:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452BAD9AD;
        Fri,  9 Sep 2022 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662766730; x=1694302730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UM+CsFuyHR7XmPwPWS7xh878miaRhvzSVRFt/J7CgIA=;
  b=a/+OxBl55lv8elEXHX4firw/ySj/VujLIOQN/l2FA0Sc5cSKYNupwyBt
   eMWwSf3Fef/A9EqqKao14XUjUNh3dViI56JrFKsaBajTHO2WSXXWMeOi9
   BzNFTwzUfXDSre8g/8GDxCeUKSqeTBakx/deSwGd58Y9ZdaJy1+UoX+Fh
   2880PYSF1fOEFK/PEzSpqQaUbngcusexRqlJ/VBSf2xXU20JQXi3HgVU3
   kDh2cT90jJy5YoTgrIjRe/65mhx6/+BbUJu0iNxXATUKpOthwaVZn7lOu
   i2T0b9s7YFKhSseqi7whi+lLaV/JJs+UOcbJXvGJJw49B52VPu5WkeOW2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="361545041"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="361545041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677363744"
Received: from gtpedreg-mobl.amr.corp.intel.com (HELO [10.209.57.19]) ([10.209.57.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:38:42 -0700
Message-ID: <21de0e12-5e3d-c27a-d857-23ad3e83dd1c@linux.intel.com>
Date:   Fri, 9 Sep 2022 16:38:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/9] PCI/PTM: Add pci_upstream_ptm() helper
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220909202505.314195-1-helgaas@kernel.org>
 <20220909202505.314195-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909202505.314195-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/22 1:24 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PTM requires an unbroken path of PTM-supporting devices between the PTM
> Root and the ultimate PTM Requester, but if a Switch supports PTM, only the
> Upstream Port can have a PTM Capability; the Downstream Ports do not.
> 
> Previously we copied the PTM configuration from the Switch Upstream Port to
> the Downstream Ports so dev->ptm_enabled for any device implied that all
> the upstream devices support PTM.
> 
> Instead of making it look like Downstream Ports have their own PTM config,
> add pci_upstream_ptm(), which returns the upstream device that has a PTM
> Capability (either a Root Port or a Switch Upstream Port).
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/ptm.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 85382c135885..0df6cdfe38b4 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -76,6 +76,29 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
>  }
>  
> +/*
> + * If the next upstream device supports PTM, return it; otherwise return
> + * NULL.  PTM Messages are local, so both link partners must support it.
> + */
> +static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
> +{
> +	struct pci_dev *ups = pci_upstream_bridge(dev);
> +
> +	/*
> +	 * Switch Downstream Ports are not permitted to have a PTM
> +	 * capability; their PTM behavior is controlled by the Upstream
> +	 * Port (PCIe r5.0, sec 7.9.16), so if the upstream bridge is a
> +	 * Switch Downstream Port, look up one more level.
> +	 */
> +	if (ups && pci_pcie_type(ups) == PCI_EXP_TYPE_DOWNSTREAM)
> +		ups = pci_upstream_bridge(ups);
> +
> +	if (ups && ups->ptm_cap)
> +		return ups;
> +
> +	return NULL;
> +}
> +
>  void pci_ptm_init(struct pci_dev *dev)
>  {
>  	u16 ptm;
> @@ -95,19 +118,6 @@ void pci_ptm_init(struct pci_dev *dev)
>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
>  		return;
>  
> -	/*
> -	 * Switch Downstream Ports are not permitted to have a PTM
> -	 * capability; their PTM behavior is controlled by the Upstream
> -	 * Port (PCIe r5.0, sec 7.9.16).
> -	 */
> -	ups = pci_upstream_bridge(dev);
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM &&
> -	    ups && ups->ptm_enabled) {
> -		dev->ptm_granularity = ups->ptm_granularity;
> -		dev->ptm_enabled = 1;
> -		return;
> -	}
> -
>  	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
>  	if (!ptm)
>  		return;
> @@ -124,6 +134,7 @@ void pci_ptm_init(struct pci_dev *dev)
>  	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
>  	 * furthest upstream Time Source as the PTM Root.
>  	 */
> +	ups = pci_upstream_ptm(dev);
>  	if (ups && ups->ptm_enabled) {
>  		ctrl = PCI_PTM_CTRL_ENABLE;
>  		if (ups->ptm_granularity == 0)
> @@ -173,7 +184,7 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  	 * associate the endpoint with a time source.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> -		ups = pci_upstream_bridge(dev);
> +		ups = pci_upstream_ptm(dev);
>  		if (!ups || !ups->ptm_enabled)
>  			return -EINVAL;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
