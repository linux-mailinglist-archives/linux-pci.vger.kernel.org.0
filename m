Return-Path: <linux-pci+bounces-3221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54E84D293
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D14328B5BB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A78665E;
	Wed,  7 Feb 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3uUcr1h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6E126F0A;
	Wed,  7 Feb 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336340; cv=none; b=Lob+zuEoV+EE0wyB2iyIMf7w0LVJDv8CP9ecYxsPix6VnysQG6cFIr/rNpidCJSwZPOKKpGqJ50J68rk/RMosPs/RZPlAW3I89mPqbIdTYLtC9+QtqRYj29+yHt7KF5C19wp9J6SmyAOJzu86Vmnc2HA91G2+RAsghn02IswCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336340; c=relaxed/simple;
	bh=zVLu/Me3Xv0QeEeWdOcnivT42o54BAx6yp83UTbIVRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ta4yzzRMMwXnPPn1aCIOVX/+gboJOYPPPlKSXTno6ktUdwcfCC29Szt9Da1BrSVY5TWM0UMC7S+tY7lDMGQFMT30MFRi0WW7OIBGj9Zz5UBwMVYginGxYChYFKjoVzRpJR3PErH9ouiORWG5R98cPfOWjTa6xC1+1PPccExze+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3uUcr1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF8C433F1;
	Wed,  7 Feb 2024 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707336340;
	bh=zVLu/Me3Xv0QeEeWdOcnivT42o54BAx6yp83UTbIVRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A3uUcr1hFB1TaQI4fFerVSyrdccM8G6kZ8Ir6zq0BMAL4h94HRt0tQEmNntzxZxWi
	 aLSUhWima9yS32RbFBN3xx0qZ/uiKuI5XuBB3UZpiwm6r7EcMMp6ONDS03fXr8zmEa
	 kGEmx1/iBFZzW1ylFdmwKdDDSGrFfzV/pU7jNBXheKIIth28PgSpQ0lENJ3H5CFzri
	 xrX/T68gWXQsMHIkNSuDtuURU4LR8J5i/5BHmTdAap8GXcGCrfXZiVwVWVTYM8eZ6Z
	 mNkTm4Zffl6FuBgxfIIOVzJl6nQr1uXHG30QQKHtcRDYgF7cgYdTfrV61kGwfAVOtu
	 gQuiGyYKtutIw==
Date: Wed, 7 Feb 2024 14:05:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, david.e.box@linux.intel.com,
	mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Message-ID: <20240207200538.GA912749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207084452.9597-1-drake@endlessos.org>

On Wed, Feb 07, 2024 at 09:44:51AM +0100, Daniel Drake wrote:
> The Asus B1400 with original shipped firmware versions and VMD disabled
> cannot resume from suspend: the NVMe device becomes unresponsive and
> inaccessible.
> 
> This is because the NVMe device and parent PCI bridge get put into D3cold
> during suspend, and this PCI bridge cannot be recovered from D3cold mode:
> 
>   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
>   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
>   setpci -s 00:06.0 CAP_PM+4.b=03 # D3hot
>   acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
>   acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
>   setpci -s 00:06.0 CAP_PM+4.b=0 # D0
>   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
>   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
>   # NVMe probe fails here with -ENODEV

Can you run "sudo lspci -vvxxxx -s00:06.0" before putting the Root
Port in D3hot, and then again after putting it back in D0 (when NVMe
is inaccessible), and attach both outputs to the bugzilla?

> This appears to be an untested D3cold transition by the vendor; Intel
> socwatch shows that Windows leaves the NVMe device and parent bridge in D0
> during suspend, even though these firmware versions have StorageD3Enable=1.
> 
> Experimenting with the DSDT, the _OFF method calls DL23() which sets a L23E
> bit at offset 0xe2 into the PCI configuration space for this root port.
> This is the specific write that the _ON routine is unable to recover from.
> This register is not documented in the public chipset datasheet.
> 
> Disallow D3cold on the PCI bridge to enable successful suspend/resume.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
> Signed-off-by: Daniel Drake <drake@endlessos.org>
> ---
>  arch/x86/pci/fixup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> v2:
> Match only specific BIOS versions where this quirk is required.
> Add subsequent patch to this series to revert the original S3 workaround
> now that s2idle is usable again.
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index f347c20247d30..6b0b341178e4f 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -907,6 +907,51 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
>  
> +/*
> + * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.

I doubt the 00:06.0 PCI address is relevant here.

> + * On this platform with VMD off, the NVMe's parent PCI bridge cannot
> + * successfully power back on from D3cold, resulting in unresponsive NVMe on
> + * resume. This appears to be an untested transition by the vendor: Windows
> + * leaves the NVMe and parent bridge in D0 during suspend.
> + * This is only needed on BIOS versions before 308; the newer versions flip
> + * StorageD3Enable from 1 to 0.

Given that D3cold is just "main power off," and obviously the Root
Port *can* transition from D3cold to D0 (at initial platform power-up
if nothing else), this seems kind of strange and makes me think we may
not completely understand the root cause, e.g., maybe some config
didn't get restored.

But the fact that Windows doesn't use D3cold in this case suggests
that either (1) Windows has a similar quirk to work around this, or
(2) Windows decides whether to use D3cold differently than Linux does.

I have no data, but (1) seems sort of unlikely.  In case it turns out
to be (2) and we figure out how to fix it that way someday, can you
add the output of "sudo lspci -vvxxxx" of the system to the bugzilla?

What would be the downside of skipping the DMI table and calling
pci_d3cold_disable() always?  If this truly is a Root Port defect, it
should affect all platforms with this device, and what's the benefit
of relying on BIOS to use StorageD3Enable to avoid the defect?

Rewrap into a single paragraph or add a blank line between paragraphs.

> + */
> +static const struct dmi_system_id asus_nvme_broken_d3cold_table[] = {
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.304"),
> +		},
> +	},
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.305"),
> +		},
> +	},
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.306"),
> +		},
> +	},
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.307"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
> +{
> +	if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
> +		pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
> +
>  #ifdef CONFIG_SUSPEND
>  /*
>   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> -- 
> 2.43.0
> 

