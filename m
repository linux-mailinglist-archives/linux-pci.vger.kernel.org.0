Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26BD48C66E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354268AbiALOtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbiALOtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 09:49:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E8C06173F;
        Wed, 12 Jan 2022 06:49:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA745B81ED0;
        Wed, 12 Jan 2022 14:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21199C36AEA;
        Wed, 12 Jan 2022 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641998945;
        bh=tUAj1+vcYAmzKzaI31fyw8aqfm34XHOHX4eyc4NGFyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=morh+rIOrKybqitKRfUIUIFi2rcTWKUy8xiWifzxi1P7YtMsmq77Ua/B4yJpe4CwL
         LL44Sai9LAt7ttDvYV0f0GoSXrXxFrChD9miO10WSgmkPTMsU1t7ashiL/xn4VeSyS
         0H0O1fj+5ywoqBQVpnimlmNk7ZxT48qteMlH/XwJkMUvguC9ZWHgCc8mkxmahfHtTk
         GK2jeXBr8Nlg0j1NA2sWrxBliUqs5Omm8hwikUQPENuoaqln/0Wjd+lGKZZP5VFq3T
         WHspIKXqTAWyLqyPHMRt1t7K7U+tPTpAZjKjl3QLTqaGlllX4g+3DG5IOwih+np8R+
         r8l2RQX+64gng==
Date:   Wed, 12 Jan 2022 08:49:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukasz Maniak <lukasz.maniak@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
Message-ID: <20220112144903.GA253960@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222191958.955681-1-lukasz.maniak@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
> As per PCI Express specification, FLR to a PF resets the PF state as
> well as the SR-IOV extended capability including VF Enable which means
> that VFs no longer exist.

Can you add a specific reference to the spec, please?

> Currently, the IOV state is not updated during FLR, resulting in
> non-compliant PCI driver behavior.

And include a little detail about what problem is observed?  How would
a user know this problem is occurring?

> This patch introduces a simple function, called on the FLR path, that
> removes the virtual function devices from the PCI bus and their
> corresponding sysfs links with a final clear of the num_vfs value in IOV
> state.
> 
> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
> ---
>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>  drivers/pci/pci.c |  2 ++
>  drivers/pci/pci.h |  4 ++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 0267977c9f17..69ee321027b4 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>  	return max ? max - bus->number : 0;
>  }
>  
> +/**
> + * pci_reset_iov_state - reset the state of the IOV capability
> + * @dev: the PCI device
> + */
> +void pci_reset_iov_state(struct pci_dev *dev)
> +{
> +	struct pci_sriov *iov = dev->sriov;
> +
> +	if (!dev->is_physfn)
> +		return;
> +	if (!iov->num_VFs)
> +		return;
> +
> +	sriov_del_vfs(dev);
> +
> +	if (iov->link != dev->devfn)
> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> +
> +	iov->num_VFs = 0;
> +}
> +
>  /**
>   * pci_enable_sriov - enable the SR-IOV capability
>   * @dev: the PCI device
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb394986a..535f19d37e8d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>   */
>  int pcie_flr(struct pci_dev *dev)
>  {
> +	pci_reset_iov_state(dev);
> +
>  	if (!pci_wait_for_pending_transaction(dev))
>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..7bb144fbec76 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>  void pci_restore_iov_state(struct pci_dev *dev);
>  int pci_iov_bus_range(struct pci_bus *bus);
> +void pci_reset_iov_state(struct pci_dev *dev);
>  extern const struct attribute_group sriov_pf_dev_attr_group;
>  extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>  {
>  	return 0;
>  }
> +static inline void pci_reset_iov_state(struct pci_dev *dev)
> +{
> +}
>  
>  #endif /* CONFIG_PCI_IOV */
>  
> 
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> -- 
> 2.25.1
> 
