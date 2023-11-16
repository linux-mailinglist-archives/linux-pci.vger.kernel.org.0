Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45977EE625
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjKPRw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 12:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035F189;
        Thu, 16 Nov 2023 09:52:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EE0C433C8;
        Thu, 16 Nov 2023 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157142;
        bh=TBSqtZj5VEJrx1z2nzy0nr0gmNZfBNLK6YJFTy610rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YXvO3gcJYwG3CXcP6dZnZjxg5LgatVYGMKhoArrEpDxmCqMB0b1uLDGUXzWNBtFmJ
         FRBo8zFC1TosBhnokN7woxBW3akq6VPs1+GjJiLwjIvryEKPoRPbI113N+iQcUFIcv
         BzHYG1enysk69av9KguJ6fFeFG+0G3y3xHVwnCjyKTbawu57+q20HKf91AZpnaM/n7
         3AiEtGs3/CSoumtUw0XSRysUEZh6duV5gGhz7Cdqtc4UErBfbUvytpEvnkG6aI8uwX
         1X+zUEq7jOAF2M0adGItWPxgYQVzmdco1o7GCynryVnc69Rlx2DhkVG5f3wBtJuNdJ
         mLdfxJjKEykkg==
Date:   Thu, 16 Nov 2023 11:52:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     Jonathan Bither <jonbither@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org
Subject: Re: [PATCH v3] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE
 connects to Intel PCI bridge
Message-ID: <20231116175219.GA51724@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116041834.8310-2-jhp@endlessos.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 16, 2023 at 12:18:35PM +0800, Jian-Hong Pan wrote:
> Disable RTL8723BE's ASPM in a PCI quirk and rtl8723be module if the
> Realtek RTL8723BE PCIe Wireless adapter connects to some Intel PCI
> bridges, such as Skylake and Kabylake. Otherwise, the PCI AER flood
> hangs system:

"Kaby Lake".  Annoying but seems to be the case that "Skylake" has no
space while "Kaby Lake" does.

I don't feel good about this fix because we don't have a root cause
for the issue, we don't know if Skylake and Kaby Lake are the only
affected bridges, and we're giving up some power savings on a lot of
systems.

I *assume* ASPM probably works OK under Windows on these platforms?
Can anybody confirm/deny that?

Do we know whether Realtek parts other than rtl8723be have the same
issue?  There are about a dozen rtlwifi drivers that look basically
identical so I assume there's a lot of shared IP there.

The flood seems to start when rtl8723be probes the device, and I
assume it fiddles with the ASPM config then.  My guess is it's doing
something wrong then, and if we could figure it out, we could fix it.

Theoretically, drivers shouldn't need to deal with ASPM at all because
the PCI core does that already.  But these parts seem to have issues
that require special handling.

Bjorn

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
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * Disable Realtek RTL8723BE PCIE's ASPM, if it connects to some Intel bridges,
> + * such as Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
> + */
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REALTEK, 0xb723,
> +			quirk_disable_int_bridge_sub_pci_aspm);
> +
>  /*
>   * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
>   * DisINTx can be set but the interrupt status bit is non-functional.
> -- 
> 2.42.1
> 
