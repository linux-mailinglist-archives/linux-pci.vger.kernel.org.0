Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA041E298
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhI3UVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 16:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhI3UVp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 16:21:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E668961439;
        Thu, 30 Sep 2021 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633033202;
        bh=eHVjgQVQ3o/+zTrjKH2Jy2IkIIM4qWeeIyY1HhsgZTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K825TWjImFo7pD0Ga9oPLweBdXvViUmyHwVGLwQxmXlrdVRaAL5vFmsoR6eusDgH9
         zWY6TsYMSOb6qujEcbmX7UjOWk8wwA/yyar0Wkj1jKl/k1gipRwnUAkDg8JlNQuNXI
         K7sF/eB9E17Lhh8jN9sId69fj5pB0pPWh3qgOuyYkd6u7ZpjwkkE+Mlb/4tC2XUBD7
         AUkY+TnBr3XBsko8ihArvR4G2xKGmA3u1KNZnN/rcP5ipYfYGuI37T9AKODxBjS/EY
         dF7MAWyxQ+ScytGMH03asUzXpNQUCkBTV3bHLDd/VVwafri6T8C61pPguabOJP/0P6
         PR1Z+zcNWvSZw==
Date:   Thu, 30 Sep 2021 15:20:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] PCI/ASPM: Remove struct
 pcie_link_state.clkpm_disable
Message-ID: <20210930202000.GA906085@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004400.25717-5-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:44:00AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> The clkpm_disable member of the struct pcie_link_state indicates
> if the Clock PM state of the device is disabled. There are two
> situations which can cause the Clock PM state disabled.
> 1. If the device fails sanity check as in pcie_aspm_sanity_check()
> 2. By calling __pci_disable_link_state()

And, 3. clkpm_store(), when the user writes to the "clkpm" sysfs file,
right?

IIUC, clkpm_disable really tells us whether we can enable clkpm.  The
only place we test clkpm_disable is in pcie_set_clkpm():

  pcie_set_clkpm(struct pcie_link_state *link, int enable)
  {
    if (!link->clkpm_capable || link->clkpm_disable)
      enable = 0;
    pcie_set_clkpm_nocheck(link, enable);
  }

So in other words, if clkpm_disable is set, we will never call
pcie_set_clkpm_nocheck() to *enable* clkpm.  We will only call it to
*disable* clkpm.

Tangent: I think the usefulness of pcie_set_clkpm_nocheck() being a
separate function is gone.  I think things will be a little simpler if
we integrate it into pcie_set_clkpm().  Separate preliminary patch, of
course.

> It is possible to set the Clock PM state of a device ON or OFF by
> calling pcie_set_clkpm(). The state can be retieved by calling
> pcie_get_clkpm_state().

s/retieved/retrieved/

> pcie_link_state.clkpm_disable is only accessed in pcie_set_clkpm()
> to ensure that Clock PM state can be reenabled after being disabled.
> 
> This patch:
>   - add pm_disable to the struct pcie_link_state, to indicate that
>     the kernel has marked the device's AS and Clock PM states disabled
>   - removes clkpm_disable from the struct pcie_link_state
>   - removes all instance where clkpm_disable is set
>   - ensure that the Clock PM is always disabled if it is part of the
>     states passed into __pci_disable_link_state(), regardless of the
>     global policy
> 
> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 368828cd427d..e6ae00daa7ae 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -60,8 +60,7 @@ struct pcie_link_state {
>  	u32 aspm_default:7;		/* Default ASPM state by BIOS */
>  	u32 aspm_disable:7;		/* Disabled ASPM state */
>  
> -	/* Clock PM state */
> -	u32 clkpm_disable:1;		/* Clock PM disabled */
> +	u32 pm_disabled:1;		/* Disabled AS and Clock PM ? */

What did we gain by renaming this?  AFAICT this only affects clkpm
(the only test of pm_disabled is in pcie_set_clkpm()).

>  	/* Exit latencies */
>  	struct aspm_latency latency_up;	/* Upstream direction exit latency */
> @@ -198,7 +197,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	 * Don't enable Clock PM if the link is not Clock PM capable
>  	 * or Clock PM is disabled
>  	 */
> -	if (!capable || link->clkpm_disable)
> +	if (enable && (!capable || link->pm_disabled))
>  		enable = 0;
>  	/* Need nothing if the specified equals to current state */
>  	if (pcie_get_clkpm_state(link->pdev) == enable)
> @@ -206,11 +205,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
> -static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> -{
> -	link->clkpm_disable = blacklist ? 1 : 0;
> -}
> -
>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>  	struct pci_dev *parent = link->pdev;
> @@ -952,8 +946,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	 */
>  	pcie_aspm_cap_init(link, blacklist);
>  
> -	/* Setup initial Clock PM state */
> -	pcie_clkpm_cap_init(link, blacklist);
> +	link->pm_disabled = blacklist;
>  
>  	/*
>  	 * At this stage drivers haven't had an opportunity to change the
> @@ -1129,8 +1122,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	if (state & PCIE_LINK_STATE_CLKPM)
> -		link->clkpm_disable = 1;
> -	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +		pcie_set_clkpm(link, 0);
> +
>  	mutex_unlock(&aspm_lock);
>  	if (sem)
>  		up_read(&pci_bus_sem);
> @@ -1301,7 +1294,6 @@ static ssize_t clkpm_store(struct device *dev,
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  
> -	link->clkpm_disable = !state_enable;

Something is seriously wrong here because clkpm_store() no longer does
anything with "state_enable", the value we got from the user.

>  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  
>  	mutex_unlock(&aspm_lock);
> -- 
> 2.20.1
> 
