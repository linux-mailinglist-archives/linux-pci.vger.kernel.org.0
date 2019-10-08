Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60254CF0A7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 03:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfJHBvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 21:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfJHBvD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 21:51:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BF820867;
        Tue,  8 Oct 2019 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570499462;
        bh=O7LI1JD0ujP1YYhs9Ms3TCbBEmobvIolEyCB+ePnRto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r6cZxLC2oppe9bpOyylMDYV9WM2OoM0I91Q1JV3mlhgf4H5f76tA3TjiBwzhdB6B9
         sKBuj+s5szHk1cVWb7EKDiFuCwD7WM9GJ3mSq/s3Yw31Ahsj4TGvIbegP47V7j6+zj
         b1zS8gCwd5p0OCkjt33Zn6uxargCSdp/6o6ooqM4=
Date:   Mon, 7 Oct 2019 20:51:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] PCI/ASPM: Add and use helper pcie_aspm_get_link
Message-ID: <20191008015100.GA68519@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d33770-29de-a9af-4d85-f2b30269d383@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 02:07:18PM +0200, Heiner Kallweit wrote:
> Factor out getting the link associated with a pci_dev and use this
> helper where appropriate. In addition this helper will be used
> in a subsequent patch of this series.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v7:
> - add as separate patch
> ---
>  drivers/pci/pcie/aspm.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 574f822bf..91cfea673 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1066,19 +1066,28 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> +static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream;
> +
> +	if (pcie_downstream_port(pdev))
> +		upstream = pdev;

Is there a case where this is called for a downstream port?  After
this series is completely applied, the callers I see are:

  __pci_disable_link_state()
  pcie_aspm_enabled()
  aspm_attr_show_common()
  aspm_attr_store_common()
  clkpm_show()
  clkpm_store()
  aspm_ctrl_attrs_are_visible()

I'm pretty sure all of these only care about upstream ports, i.e., we
only call them for endpoints, switch upstream ports, etc.

What do you think about something like this?

  static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
  {
    struct pci_dev *bridge;

    if (pci_is_pcie(pdev)) {
      bridge = pci_upstream_bridge(pdev);
      if (bridge && pci_is_pcie(bridge))
        return bridge->link_state;
    }

    return NULL;
  }

Then we could remove the pci_is_pcie() checks from
__pci_disable_link_state() and aspm_ctrl_attrs_are_visible().

> +	else
> +		upstream = pci_upstream_bridge(pdev);
> +
> +	return upstream ? upstream->link_state : NULL;
> +}
> +
>  static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  {
> -	struct pci_dev *parent = pdev->bus->self;
>  	struct pcie_link_state *link;
>  
>  	if (!pci_is_pcie(pdev))
>  		return 0;
>  
> -	if (pcie_downstream_port(pdev))
> -		parent = pdev;
> -	if (!parent || !parent->link_state)
> +	link = pcie_aspm_get_link(pdev);
> +	if (!link)
>  		return -EINVAL;
> -
>  	/*
>  	 * A driver requested that ASPM be disabled on this device, but
>  	 * if we don't have permission to manage ASPM (e.g., on ACPI
> @@ -1095,7 +1104,6 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (sem)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
> -	link = parent->link_state;
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_disable |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> @@ -1188,14 +1196,14 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>   */
>  bool pcie_aspm_enabled(struct pci_dev *pdev)
>  {
> -	struct pci_dev *bridge = pci_upstream_bridge(pdev);
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  	bool ret;
>  
> -	if (!bridge)
> +	if (!link)
>  		return false;
>  
>  	mutex_lock(&aspm_lock);
> -	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> +	ret = link->aspm_enabled;
>  	mutex_unlock(&aspm_lock);

I'm not sure why this mutex is needed; I cc'd you on my query to
Rafael about this.  Unrelated to your patch, of course.

>  	return ret;
> -- 
> 2.23.0
> 
> 
