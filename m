Return-Path: <linux-pci+bounces-2869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E8843925
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1193B1C28FDA
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC937149;
	Wed, 31 Jan 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rblj7/+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DE33070;
	Wed, 31 Jan 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690040; cv=none; b=ZCBOYjt5kRUaJTC/HE3PBHWg6Uobh/YmC2XcewE/ZktxdKtNQzNtoFK3eRtcrBySso+KFJc8yZpbZR58NdqD43BeFaVqfE15WF25lmRsCk0Qev1XzVWI+lSjaeJhsSEbGGsqws2S8XT5eUxmV7JK++HorVUXUw7bczHCeg7Qa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690040; c=relaxed/simple;
	bh=Ds+jo8rWFteG9lgQpLFq1+D6AtcbRKkjfB5jTBmecYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHDeeR6afrc/amdPvt8m0dmiIkhOhywwRqu4kvqIps3RplcLPrdGiycjnY3Sulm/mSS7wt1fFB5aX9q9L5Odc2DxVq4vLhbWZGJomfSyyc7HuIW/9cEYd6r/L41b3N/IRmglYYxPGSdMCfuWwBgq+dunyKFvKSF3CC9Hc6VSOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rblj7/+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D8AC433F1;
	Wed, 31 Jan 2024 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690040;
	bh=Ds+jo8rWFteG9lgQpLFq1+D6AtcbRKkjfB5jTBmecYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rblj7/+FUa/03DuJmcd1Py8YT3dD5+x8qj6V7Uq2C5aoF5BZaa1UBDCFWLw/jAKbS
	 N+NBdDL8B5r4ouWWMaA1wA1E2xYdeGGJM2bIOGBQdIBIKjM6JdQE2ku9byLwicSsGy
	 cmILQowNm2FRc6hg+5IGMCYCrduFfeA0f2C7jA35IgC+nT9zVaiqCkoOe47MgkHnuu
	 BMaRl6p9jZ8j6qFEhhzK9iL+EJP6PG4PCPHbvQxrc/g1pinpyJvlsoyM5OjlyHqGFK
	 C2+XNd/2unMqQXE5xi8ssF65BHQ9j5CkvAkW8wLCWhfyJIL+9qB2A0PDoyEttU+lJ2
	 rvMaEeZ/+Yatg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rV62g-000000004Rm-2Srz;
	Wed, 31 Jan 2024 09:33:58 +0100
Date: Wed, 31 Jan 2024 09:33:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 2/2] PCI: vmd: enable PCI PM's L1 substates of remapped
 PCIe port and NVMe
Message-ID: <ZboF9oSWi5OAV_NJ@hovoldconsulting.com>
References: <20240130100050.14182-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130100050.14182-2-jhp@endlessos.org>

On Tue, Jan 30, 2024 at 06:00:51PM +0800, Jian-Hong Pan wrote:
> The remmapped PCIe port and NVMe have PCI PM L1 substates capability on
> ASUS B1400CEAE, but they are disabled originally:
> 
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following "Section 5.5.4 of PCIe Base Spec Revision 5.0
> Version 0.1". Then, PCI PM's L1 substates control are enabled
> accordingly.
 
> +static int vmd_power_on_pci_device(struct pci_dev *pdev, void *userdata)
> +{
> +	pci_set_power_state(pdev, PCI_D0);

As I believe Bjorn already hinted at, this should probably be done in
vmd_pm_enable_quirk().

Also, you need to use the new pci_set_power_state_locked() helper since
these callbacks are called from pci_walk_bus() with the bus semaphore
held:

	https://lore.kernel.org/lkml/20240130100243.11011-1-johan+linaro@kernel.org/

> +	return 0;
> +}
> +
>  /*
>   * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
>   */
> @@ -928,6 +934,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> +
> +	/*
> +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> +	 * Section 5.5.4 of PCIe Base Spec Revision 5.0 Version 0.1
> +	 */
> +	pci_walk_bus(vmd->bus, vmd_power_on_pci_device, NULL);
> +
>  	vmd_domain_reset(vmd);
>  
>  	/* When Intel VMD is enabled, the OS does not discover the Root Ports

Johan

