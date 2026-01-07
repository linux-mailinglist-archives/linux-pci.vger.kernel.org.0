Return-Path: <linux-pci+bounces-44234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3DD00626
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 00:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806AA30245F2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65712EDD76;
	Wed,  7 Jan 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cswAK8FL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F22F6935;
	Wed,  7 Jan 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828127; cv=none; b=X7RZLJHmkb/4rMUufJyfqPUPvPOWnkHbcoL/IsuBWBv3idAWcKCHNeo5roeRFi+2qOFccLziyiB/1ZrW1vt3GIgPscARhEyneksBMq6goR9TZRKz8jJ+uMj300Y3IYmEJNE5bnPZUk0PI5q5PXt9NM36vRDyRAV2wndnvzJO7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828127; c=relaxed/simple;
	bh=cN9S9O/4HJG7EzHzKhFL7xloKBhasEs+8qTLxStgemc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qxpfvo59lyMt9WG4iKk3y69WpI+0CiyMfB40sIacI21mhUkLnXqWQSDReEM3iRX3ULxEmBw1HBtc74bJnuweXkKFjR8mC6LBd7bEaNdX8m9nxE1KQNzyd9yuGLp36vSRZT1J0BQTAHlALQMG+RsibzyHlz4Q+3Z1spGkoPs7B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cswAK8FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF17C19423;
	Wed,  7 Jan 2026 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767828127;
	bh=cN9S9O/4HJG7EzHzKhFL7xloKBhasEs+8qTLxStgemc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cswAK8FLdhEhtQ1S2SA7nzogITFrn/PKhEvuplYvXsRVxe65WuJywwUJ8gfx+Ks+S
	 s4kAX8dSrS7ZmxfHFLEcHav5cGj3JLVc+G2qF39nC1HjRK94XP7v2yeWrRFS5hcEjl
	 az3Nm12Q83XAo7c2OqdZA4YkedKeyY5j7IDc8PhxdtYBpDS4q5pGxM1BbqWrA4eIDY
	 pCVuRBOHzO3M8HYCxM306DZBXJD1X2GYQDfe6XuAFwlUFiuwx0kkGoG9lCmkczBZ/6
	 K32ESvoMcaAvjislIZvFcyfivF+zUDuaDCNrcS5SD74BGxYGNB/uJa5m1IFuSy8nK9
	 PuGypki5OccfA==
Date: Wed, 7 Jan 2026 17:22:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Casey Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	dingtianhong <dingtianhong@huawei.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Message-ID: <20260107232205.GA447140@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205142831.4063891-1-haakon.bugge@oracle.com>

[+cc Alexander's @fb.com address]

On Fri, Dec 05, 2025 at 03:28:29PM +0100, Håkon Bugge wrote:
> After commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if
> supported"), the kernel controls enablement of extended tags
> (ExtTag). Similar, after commit a99b646afa8a ("PCI: Disable PCIe
> Relaxed Ordering if unsupported"), the kernel controls the relaxed
> ordering bit (RO), in the sense that the kernel keeps the bit set (if
> already set) unless the RC does not support it.
> 
> On some platforms, when program_hpx_type2() is called and the _HPX
> object's Type2 records are, let's say, dubious, we may end up
> resetting ExtTag and RO, although they were explicit set or kept set
> by the OSPM [1].

This text about Type 2 records in ACPI r6.6, sec 6.2.10.3, seems a
little ambiguous to me:

  A PCI Express-aware OS that has assumed ownership of native hot plug
  (via _OSC) but does not support or does not have ownership of the
  AER register set must use the data values returned by the _HPX
  object’s Type 2 record to program the AER registers of a hot-added
  PCI Express device. However, since the Type 2 record also includes
  register bits that have functions other than AER, OSPM must ignore
  values contained within this setting record that are not applicable.

If I squint, I can read that as meaning that Type 2 is really there
just for AER, and the OS:

  - should only use a Type 2 record when it owns PCIe native hotplug
    (native_pcie_hotplug) but does not own AER (!native_aer),

  - should only program AER registers, and

  - should *ignore* bits unrelated to AER.

Most of the registers in Type 2 are in the AER Capability.  Device
Control is in the PCIe Capability, but if _OSC has granted AER
ownership to the OS, that includes the Error Reporting Enable bits in
Device Control (there's a PCI Firmware spec ECN to this effect:
https://members.pcisig.com/wg/Firmware/document/20514).

Type 2 does include Link Control, which is in the PCIe Capability and
doesn't seem related to AER, so maybe I'm on the wrong track.  But if
Type 2 was intended to handle things *other* than AER, I would think
the PCIe Capability Slot Control and Root Control would have been
included.

So *maybe* program_hpx_type2() should mask out everything from
pci_exp_devctl_or except PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE,
PCI_EXP_DEVCTL_FERE, and PCI_EXP_DEVCTL_URRE?  I have no idea what we
would do with Link Control though.

I wish I knew the history of this, but I don't.

> The Advanced Configuration and Power Interface (ACPI) Specification
> version 6.6 has a provision that gives the OSPM the ability to
> control these bits any way. In a note in section 6.2.9, it is stated:
> 
> "OSPM may override the settings provided by the _HPX object's Type2
> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
> Settings) when OSPM has assumed native control of the corresponding
> feature."
> 
> So, in order to preserve the increased performance of ExtTag and RO on
> platforms that support any of these, we make sure program_hpx_type2()
> doesn't reset them.
> 
> [1] Operating System-directed configuration and Power Management
> 
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/pci/pci-acpi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 9369377725fa0..6a2ae1b821732 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -324,15 +324,18 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
>  		return;
>  	}
>  
> -	/*
> -	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
> -	 * those to make sure they're consistent with the rest of the
> -	 * platform.
> +	/* Don't allow _HPX to change MPS, MRRS, ExtTag, or RO
> +	 * settings.  We manage those to make sure they're consistent
> +	 * with the rest of the platform.
>  	 */
>  	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
> -				    PCI_EXP_DEVCTL_READRQ;
> +				   PCI_EXP_DEVCTL_READRQ  |
> +				   PCI_EXP_DEVCTL_EXT_TAG |
> +				   PCI_EXP_DEVCTL_RELAX_EN;
>  	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
> -				    PCI_EXP_DEVCTL_READRQ);
> +				    PCI_EXP_DEVCTL_READRQ  |
> +				    PCI_EXP_DEVCTL_EXT_TAG |
> +				    PCI_EXP_DEVCTL_RELAX_EN);
>  
>  	/* Initialize Device Control Register */
>  	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> -- 
> 2.43.5
> 

