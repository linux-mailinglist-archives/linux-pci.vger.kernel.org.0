Return-Path: <linux-pci+bounces-16086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B789BD940
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 23:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FBDB22081
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741021218D;
	Tue,  5 Nov 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfSdvuH2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49A1F80C4;
	Tue,  5 Nov 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847591; cv=none; b=Q338NuIDO2wqDxD4vz0WUssmXjH8qhOhGuM19N1kJzhuOMM0unjQ98npUmCJwsZCPp0D1ctcn0TQ6SOJS4hqWzyq7D2g5lzoK5MPe6s0gQzF++XuCfz6uyG0P+LooSRSNC92Fs+MCyRQfHF7jI2fkO8iszEdZUNaz8PLx7giMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847591; c=relaxed/simple;
	bh=HJE5dz22po2ZNYbYCqh8+zGXYdD99qJ9LfUB9/tWNyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CUF7CW6MYOYYY7qvlzbJuvo7MF5Oqfsd9zePABlK10+O8D2slZ0/khJhsqZyAcvjec36GhjX3xQuaXN8KDWiKM4UP5Pfh6PN18C1gRnM/xnJNLbakkPrEboQI+D79oVX1NneEXLv8kH081Gnd5SzXSw0VtYuUV4tZln+Qgf20aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfSdvuH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF538C4CED0;
	Tue,  5 Nov 2024 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730847591;
	bh=HJE5dz22po2ZNYbYCqh8+zGXYdD99qJ9LfUB9/tWNyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BfSdvuH2+4mZyFvnV8XQ1+aIkIQDCI9txbPz5MtMdOfDKDY5Uft6msG3ZACdJV+ov
	 8Fv/s0tsIa4HE8PbNtItV0RZH4+3mnakYSSlEh3I/lhG2LwM3lGJplybnPBLY6RIQT
	 K9FfEqbisztJvCnMKrutED7O1hRVod7175GvGa33JxxnkUGJFPbPEI0yjmAeRk81ub
	 Vw9u61A3iz92EZJ05WfByj/GErUK3jpNffySGuCPpxqPrEBxEM4K1Z1ouoNx+nah+5
	 +T6qbFTj2vCPW5umtO/+RlDTthmy9zHlx5XZjUB+b+JNan8rGSCU7uuD/YBNKKEkp9
	 n293xSpiO0foQ==
Date: Tue, 5 Nov 2024 16:59:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
Message-ID: <20241105225949.GA1493775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083438.10070-8-jhp@endlessos.org>

On Tue, Oct 01, 2024 at 04:34:42PM +0800, Jian-Hong Pan wrote:
> PCI devices' parameters on the VMD bus have been programmed properly
> originally. But, cleared after pci_reset_bus() and have not been restored
> correctly. This leads the link's L1.2 between PCIe Root Port and child
> device gets wrong configs.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> bridge and NVMe device should have the same LTR1.2_Threshold value.
> However, they are configured as different values in this case:
> 
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
>   ...
>   Capabilities: [200 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=0ns
>     L1SubCtl2: T_PwrOn=0us
> 
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
>   ...
>   Capabilities: [900 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=101376ns
>     L1SubCtl2: T_PwrOn=50us
> 
> Here is VMD mapped PCI device tree:
> 
> -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
>  | ...
>  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
>               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
>
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset. Then, when it restores the
> NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
> because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
> before reset.

There's nothing specific to VMD here, is there?  This whole log looks
like it should be made generic.  The VMD *example* is OK, but the
justification should not be VMD-specific.  This last paragraph seems
to be the kernel of the whole thing, and I don't think it's specific
to either VMD or NVMe.

> So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> the parent's L1SS configuration, too. This is symmetric on
> pci_restore_aspm_l1ss_state().
> 
> Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v9:
> - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
> 
> v10:
> - Drop the v9 fix about drivers/pci/controller/vmd.c
> - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
>   and pci_restore_aspm_l1ss_state()
> 
> v11:
> - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
>   which is same as the original pci_configure_aspm_l1ss
> - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
>   both child and parent devices
> - Smooth the commit message
> 
> v12:
> - Update the commit message
> 
>  drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index bd0a8a05647e..17cdf372f7e0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
>  			ERR_PTR(rc));
>  }
>  
> -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	u16 l1ss = pdev->l1ss;
> @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
>  }
>  
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent;
> +
> +	__pci_save_aspm_l1ss_state(pdev);

Is there any point in saving the "pdev" state if there's no parent?

> +	/*
> +	 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
> +	 * substate configuration, if the parent has not saved state.
> +	 */
> +	if (!pdev->bus || !pdev->bus->self)
> +		return;

Is "pdev->bus == NULL" possible here even though it doesn't seem
possible in pci_restore_aspm_l1ss_state()?

> +	parent = pdev->bus->self;
> +	if (!parent->state_saved)
> +		__pci_save_aspm_l1ss_state(parent);
> +}

I see the suggestion for a helper here, but I'm not convinced.
pci_save_aspm_l1ss_state() and pci_restore_aspm_l1ss_state() should
*look* similar, and a helper makes them less similar.

I think you should go to some effort to follow the
pci_restore_aspm_l1ss_state() structure, as much as possible doing the
same declarations, checks, and lookups in the same order, e.g.:

  struct pci_cap_saved_state *pl_save_state, *cl_save_state;
  struct pci_dev *parent = pdev->bus->self;

  if (pcie_downstream_port(pdev) || !parent)
	  return;

  if (!pdev->l1ss || !parent->l1ss)
	  return;

  cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
  pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
  if (!cl_save_state || !pl_save_state)
	  return;

Bjorn

