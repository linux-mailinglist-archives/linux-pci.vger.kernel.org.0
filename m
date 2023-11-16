Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21C7EE553
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjKPQlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 11:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPQlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 11:41:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B0AD;
        Thu, 16 Nov 2023 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700152909; x=1731688909;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ENc58iiDD7naN+MUGYEeiCLwWArf3YSExYXPLRVX/ok=;
  b=LISfpslLNzP9Vt/n5q7MZDUXjrvww6epsbLzcqxLPpkZ2K++WwbD3lq+
   aL3dDRnfbRxY6IjYl7lVymt2eSFGSMuBjS7VNM9yF0qq+sIrDGD7w3bMW
   yhTWWbnyNSOBI5qudIAMMY1JRx7YPv+lgcU2GLDwDNTDf3lhV6di9eO2h
   FMyG28dIaoW1lwUZEqE41fjwU3lz/CmP7CvzFdg3/g+9K5/0ZKesbCzdw
   z96AsNnj+1xBHDuGhWC2ee6X1iL6PmN/Qf8OYBE7ZIUO3IQdRLeQkuGYn
   5zVkpfiSpDwnypnnLXy0YWEe3OqX3kN+9IypMvf8DQa1Pd75VZvsC1dY0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9768435"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="9768435"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 08:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="856054858"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="856054858"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 08:41:46 -0800
Date:   Thu, 16 Nov 2023 18:41:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jian-Hong Pan <jhp@endlessos.org>
cc:     Jonathan Bither <jonbither@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Subject: Re: [PATCH v3] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects
 to Intel PCI bridge
In-Reply-To: <20231116041834.8310-2-jhp@endlessos.org>
Message-ID: <1c27232-c626-5ba2-eb99-f61d80afb116@linux.intel.com>
References: <ea1d2505-7396-92c0-4687-facad575d299@gmail.com> <20231116041834.8310-2-jhp@endlessos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Nov 2023, Jian-Hong Pan wrote:

> Disable RTL8723BE's ASPM in a PCI quirk and rtl8723be module if the
> Realtek RTL8723BE PCIe Wireless adapter connects to some Intel PCI
> bridges, such as Skylake and Kabylake. Otherwise, the PCI AER flood
> hangs system:
> 
> pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218127
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2: Add the switch case's default condition with comment:
>     "The ASPM has already been enabled by initializing
>     rtl8723be_mod_params' aspm_support as 1."
> 
> v3: Rework with a PCI qurik which disables RTL8723BE PCIE's ASPM, if it
>     connects to some Intel bridges, such as Skylake and Kabylake. Then,
>     rtl8723be checks the PCIE ASPM is enabled, or not. If it is not,
>     disables rtl8723be's aspm_support parameter.
> 
>  .../wireless/realtek/rtlwifi/rtl8723be/sw.c   |  6 ++++
>  drivers/pci/quirks.c                          | 36 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> index 43b611d5288d..fe9acbaa879b 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> @@ -26,6 +26,12 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
>  	struct rtl_priv *rtlpriv = rtl_priv(hw);
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  
> +	/* Disable ASPM if the link control disables it */
> +	if (!pcie_aspm_enabled(rtlpci->pdev)) {
> +		pci_info(rtlpci->pdev, "PCIE ASPM is disabled\n");
> +		rtlpriv->cfg->mod_params->aspm_support = 0;
> +	}
> +
>  	/*close ASPM for AMD defaultly */
>  	rtlpci->const_amdpci_aspm = 0;
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..170321f4b23b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3606,6 +3606,42 @@ DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
>  			quirk_broken_intx_masking);
>  
> +

Remove extra new line.

> +static void quirk_disable_int_bridge_sub_pci_aspm(struct pci_dev *dev)
> +{
> +	struct pci_dev *pdev;
> +	u16 val;
> +
> +	if (dev->bus && dev->bus->self)
> +		pdev = dev->bus->self;
> +	else
> +		return;
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch (pdev->device) {
> +		case 0x9d15:
> +		/* PCI bridges on Skylake */
> +		case 0xa110 ... 0xa11f:
> +		case 0xa167 ... 0xa16a:
> +		/* PCI bridges on Kabylake */
> +		case 0xa290 ... 0xa29f:
> +		case 0xa2e7 ... 0xa2ee:
> +			pci_info(dev, "quirk: disable the device's ASPM\n");
> +			pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &val);
> +			val &= ~PCI_EXP_LNKCTL_ASPMC;
> +			pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);

Never do RMW ops on LNKCTL like that but use a RMW-safe accessor:

			pcie_capability_clear_word(dev, PCI_EXP_LNKCTL,
						   PCI_EXP_LNKCTL_ASPMC);

However, isn't there quirk_disable_aspm_l0s_l1() already which this 
function could call? Why not use it?

-- 
 i.

