Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541D2570DFD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGKXL0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGKXL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 19:11:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE786509EB;
        Mon, 11 Jul 2022 16:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CE4FB81614;
        Mon, 11 Jul 2022 23:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0CEC3411C;
        Mon, 11 Jul 2022 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657581079;
        bh=hbjCuI4LFeNLRJgLro7+lbaVQ+PcWcqQbC2LOg4e1Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Zu04jqa6icPQJexIaWAv9B1aGuO1HVUafN33YBKkEIT0gHdIcn2T6jYKkyg6UeS8q
         dPJ1zR/hizq5IsX1fedeOsJk5YFKdbVeuVblABXznthJO7YaXMlfx64VeyMQ91X7Em
         81ScRoWdtkeRpHYcEZ+MWLiVJORBz7+OE+kF3dZ4mwcnVHF8jdfikGQ6LM2YRHWZ8l
         FqO71RptN4Bv0VbGtG2Q+FWG3idPX84cn/BDX+kBDpB3CmshvTdrMAKKKqGauDZf3u
         mkoFAkjipB+hYQcjh/Mn1cgpULaOkS59taQx5ZDjZF6720iHsGNOW4eviZtkiKYUkR
         P8wVwvwNmlyxQ==
Date:   Mon, 11 Jul 2022 18:11:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI:ASPM: Remove pcie_aspm_pm_state_change()
Message-ID: <20220711231117.GA706272@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 03:36:37PM +0800, Kai-Heng Feng wrote:
> pcie_aspm_pm_state_change() was introduced at the inception of PCIe
> ASPM code.
> 
> However, it can cause some issues. For instance, when ASPM config is
> changed via sysfs, those changes won't persist across power state change
> because pcie_aspm_pm_state_change() overwrites them.
> 
> In addition to that, if the driver is to restore L1ss [1] after system
> resume, the restored states will also be overwritten by
> pcie_aspm_pm_state_change().
> 
> So remove pcie_aspm_pm_state_change() for now, if there's any hardware
> really needs it to function, a quirk can be used instead.
> 
> [1] https://lore.kernel.org/linux-pci/20220201123536.12962-1-vidyas@nvidia.com/
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/aspm for v5.20, thanks!

> ---
>  drivers/pci/pci.c       |  3 ---
>  drivers/pci/pci.h       |  2 --
>  drivers/pci/pcie/aspm.c | 19 -------------------
>  3 files changed, 24 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f1..d09f7b60ee4dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1181,9 +1181,6 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	if (need_restore)
>  		pci_restore_bars(dev);
>  
> -	if (dev->bus->self)
> -		pcie_aspm_pm_state_change(dev->bus->self);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a15..86a19f293d4ad 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -560,12 +560,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> -static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>  
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc8..7f76a5875feb4 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1012,25 +1012,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> -/* @pdev: the root port or switch downstream port */
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> -{
> -	struct pcie_link_state *link = pdev->link_state;
> -
> -	if (aspm_disabled || !link)
> -		return;
> -	/*
> -	 * Devices changed PM state, we should recheck if latency
> -	 * meets all functions' requirement
> -	 */
> -	down_read(&pci_bus_sem);
> -	mutex_lock(&aspm_lock);
> -	pcie_update_aspm_capable(link->root);
> -	pcie_config_aspm_path(link);
> -	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> -}
> -
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link = pdev->link_state;
> -- 
> 2.34.1
> 
