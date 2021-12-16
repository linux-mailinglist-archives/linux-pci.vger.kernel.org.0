Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C393A4779FE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhLPRGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 12:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhLPRGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 12:06:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB74C061574;
        Thu, 16 Dec 2021 09:06:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD54461ECF;
        Thu, 16 Dec 2021 17:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8416EC36AE0;
        Thu, 16 Dec 2021 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639674410;
        bh=QbH2wf6ZQw+Rj1To0Zs1NCj0dJZADSpL6SQawpbST3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ev00SHoYu4PNT4pQVmjlvU2bOSLQj/YBgtHPc6sHSHYeHd8T/ihfTzOjfLN0RT7ZK
         nMXKUxVsJakWJ+cPrWL3AlqXhOXRCoRQb3+MHCldp1VEQ+06kpH/KfsN2a51s/0bxd
         4HuFFBOtipboPKxna7ms+gbU8zdMoTml2TKF5OWWpD8yG6CUcoDCz74ttWiGPfC/FG
         mFemT/RkamVNUNwSUUBSqA4jNa/p8r8LeVmdf+h4xdUWr/YEiY26ei3q+OCsNXsyT/
         fQgzSJnRYEjgRWKvvIOmySFCoK7grwnbsZd3p++WmctGZiP37gGitbxC064qLmOLmq
         TOcsryvpnoOiw==
Date:   Thu, 16 Dec 2021 11:06:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/2] PCI/ASPM: Add ASPM BIOS override function
Message-ID: <20211216170647.GA773917@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216055600.2425362-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 09:55:59PM -0800, David E. Box wrote:
> From: Michael Bottini <michael.a.bottini@linux.intel.com>
> 
> Devices that appear under the Intel VMD host bridge are not visible to BIOS
> and therefore not programmed by BIOS with ASPM settings. For these devices,
> it is necessary for the driver to configure ASPM. 

The VMD-related parts of this commit log belong in the next patch,
because this patch has nothing in particular to do with VMD.

> Since ASPM settings are adjustable at runtime by module parameter,
> use the same mechanism to allow drivers to override the default (in
> this case never configured) BIOS policy to ASPM_STATE_ALL. Then,
> reconfigure ASPM on the link. Do not override if ASPM control is
> disabled.

The module parameter ("policy") has global effect: it runs
pcie_aspm_set_policy(), which assigns the global "aspm_policy" and
then reconfigures all links in the system.

This is not that; it's a link-based thing that doesn't change
"aspm_policy" and only affects a single link.  This is more like
aspm_attr_store_common() for the sysfs "l0s_aspm" and similar
attributes, or the pci_disable_link_state() interface for drivers.

> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4
>  - No changes.
> V3
>  - Fix missing semicolon in static inline function.
> 
> V2
>  - Change return type to int so caller can determine if override was
>    successful.
>  - Return immediately if link is not found so that lock it not
>    unecessarily taken, suggested by kw@linux.com.
>  - Don't override if aspm_disabled is true.
> 
>  drivers/pci/pci.h       |  2 ++
>  drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..c9c55d43cd8a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -562,11 +562,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +int pcie_aspm_policy_override(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL; }
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 52c74682601a..e2c61e14e724 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1140,6 +1140,25 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> +int pcie_aspm_policy_override(struct pci_dev *pdev)
> +{
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +
> +	if (!link || aspm_disabled)
> +		return -EINVAL;
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +	link->aspm_default = ASPM_STATE_ALL;
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);

This is essentially the inverse of pci_disable_link_state().  Why not
name it so the connection is obvious?  Probably also make the
signature ("int state") similar.

> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_aspm_policy_override);
> +
>  static int pcie_aspm_set_policy(const char *val,
>  				const struct kernel_param *kp)
>  {
> -- 
> 2.25.1
> 
