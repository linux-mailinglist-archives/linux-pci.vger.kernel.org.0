Return-Path: <linux-pci+bounces-8613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF39046FA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E0328397A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACF155326;
	Tue, 11 Jun 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwDqETpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B715278E;
	Tue, 11 Jun 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145260; cv=none; b=OBSdnU6jBUD39uCf6R2bUC8gkEPxiKOKSeb2jaFKxgPCpIOL+7c718mlHnw5sRR9FnaeVvuuhF4EOhGjBVWH84DyzLY+PUyN1qKJF1iJBseS329TTAovIh5Ht1zMz2emF19uN7BwTrSRMa2x02Q3+CqZPYrSknwMODfLoSCZRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145260; c=relaxed/simple;
	bh=6GordRBuWLTh8oc2MWZSDiy0M1wmL4hf/uHeNjmS/ro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YebBnHKSi5v94dqZWCraWtdgh5satUW4dL+2sYQdtVUAXVtTbTDM2VCSdXkgyjhfH8LwIardUUyzcQpt/vVLjMQmcmqcGURSrsvu1+MuBXvHd9XiZNpHjfJ9FaB22rLF8DkMXw1WUiUb5rFxjYZxB01ZAhtAMXfFCIbTa/1IWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwDqETpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04546C2BD10;
	Tue, 11 Jun 2024 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718145260;
	bh=6GordRBuWLTh8oc2MWZSDiy0M1wmL4hf/uHeNjmS/ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BwDqETpDWwUBovAPWXpDW0NWycNLHqut/W54RAkDadU2ysbnSKfG8jfuPWiOxC9RT
	 fihJ7LbCHoeS8bDWXwxEEsHeE2Qfk4yS9B42OcNlPWy+rTCKuU5YfkqIJp/OE/GYsa
	 87KR+LgL7ZecOBrpudO1rRMvyYdjEbXgRYRw6PVHZpKmSZanRBWN5sCQfr9tKegf8A
	 4t+hlUbPvq0ZSpiOvA9agaOkeI29qb0e71OJohWUsaFADjYZyY/k06IxSjcqlP/uDh
	 KF94o4U27nN5yvWu2q/7i68L10Eb5KLsoFtqQgUgLox94fvA/RQaukzntOSMxb1kF3
	 rSBh7eArWpcMw==
Date: Tue, 11 Jun 2024 17:34:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Songyang Li <leesongyang@outlook.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  PCI: Cancel compilation restrictions on function
 pcie_clear_device_status
Message-ID: <20240611223418.GA1005201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2754E7F2E61B266F610E8876B4C72@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>

On Tue, Jun 11, 2024 at 11:15:10PM +0800, Songyang Li wrote:
>     Some PCIe devices do not have AER capabilities, but they have device
>     status registers.
> 
>     Signed-off-by: Songyang Li <leesongyang@outlook.com>

Unindent this.

Add "()" after function names.

Please explain what this patch does and why we want it.  I can see
from the patch that it makes it so pcie_clear_device_status() is
always compiled, but the commit log should say that and should say why
we need that.

> ---
>  drivers/pci/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/pci/pci.c
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> old mode 100644
> new mode 100755
> index 35fb1f17a589..e6de55be4c45
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2263,7 +2263,12 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>  }
>  EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  
> -#ifdef CONFIG_PCIEAER
> +/**
> + * pcie_clear_device_status - Clear device status.
> + * @dev: the PCI device.
> + *
> + * Clear the device status for the PCI device.
> + */
>  void pcie_clear_device_status(struct pci_dev *dev)
>  {
>  	u16 sta;
> @@ -2271,7 +2276,6 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> -#endif
>  
>  /**
>   * pcie_clear_root_pme_status - Clear root port PME interrupt status.
> -- 
> 2.34.1
> 

