Return-Path: <linux-pci+bounces-26438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894DDA9769D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5518F3BD841
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A391EB5C2;
	Tue, 22 Apr 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edMk6YdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD117BED0;
	Tue, 22 Apr 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352969; cv=none; b=utzjCjcpi1tkvnq9Ph4XnI5Efy4pNbZoVxaOzMwUniCVsFBZZVk9/2unqAmqBplF8OQYSxymJpU9fLYqUtIU5od75wmAr9PXbh9i3/zoNeBeP2yFc1wJH+5KNl2JJSC2YLV4o6YYlD/OsTkDQJloST/xhrtc500kKs7A+D1ROj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352969; c=relaxed/simple;
	bh=Vs7Qc14bKtAKxYTiOYVK2EPyto+5uFtO7mBwDT4QoPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8GX/a6r/loX02HZye+Ag45QbiZBfnvGJmDqP8BInjJc9dtQUxmlUpWtIlCEE/ZJynBnX+HNhTum4ctU6/Efgl1uBPO7c/Bpi7JaDYn4F2AMRl+Cds5uTvKHzwrpcIs5adVJWin7VL0f0bD4K1Cbbn9aYAThP+8JhvMnnnhuEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edMk6YdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47761C4CEE9;
	Tue, 22 Apr 2025 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745352968;
	bh=Vs7Qc14bKtAKxYTiOYVK2EPyto+5uFtO7mBwDT4QoPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edMk6YdLw9l4+NApwkWU2Kxhinxf85nQvd47TMEKbr0xvksdvxkpbPtNsqQIPf1oF
	 qrg3n1uTXjEl1kM2Ty2Ai+OAb+g7/u1RJnp00HL4KTRG6p2cE6t+xAujhvFIjF4IJp
	 sdwfip/7XQMDLwCZLb4NqGISJhWib6X01q4f+CcuqJLRBkxiXZ8cjcOmxqAQiqlbuC
	 fxO8BWoLhAvw+aniD6nn8MRijqgWeBXFDYtGeL9TgfZ7nvoMB3d+cjWt6K3r0C6Kem
	 X1IhQ2n5Zjr6RS0MmTekbJs/jDQa0jrWzTXAjkdO6ypunEXHjAEjHcpgbEXUmeb+JE
	 YJ821jokCV0Pg==
Date: Tue, 22 Apr 2025 22:15:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <aAf45sGB8IBRxCB4@gmail.com>
References: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>


* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Unfortunately, there is no mechanism for FW to indicate OS which parts
> of PCIe configuration should not be altered. Thus, the only option is
> to add such logic into the kernel as quirks.
> 
> There is a pre-existing quirk flag to disable Extended Tags. Depending
> on CONFIG_PCIE_BUS_* setting, MRRS may be overwritten by what the
> kernel thinks is the best for performance (the largest supported
> value), resulting in performance degradation instead with these Root
> Ports. (There would have been a pre-existing quirk to disallow
> increasing MRRS but it is not identical to rejecting >128B MRRS.)
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port is
> bifurcated to x2. Reject >128B MRRS only when it is going to be written
> by the kernel (this assumes FW configured a good initial value for MRRS
> in case the kernel is not touching MRRS at all).
> 
> It was first attempted to always write MRRS when the quirk is needed
> (always overwrite the initial value). That turned out to be quite
> invasive change, however, given the complexity of the initial setup
> callchain and various stages returning early when they decide no changes
> are necessary, requiring override each. As such, the initial value for
> MRRS is now left into the hands of FW.
> 
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> - Explain in changelog why FW cannot solve this on its own
> - Moved the quirk under arch/x86/pci/
> - Don't NULL check value from pci_find_host_bridge()
> - Added comment above the quirk about the performance degradation
> - Removed all setup chain 128B quirk overrides expect for MRRS write
>   itself (assumes a sane initial value is set by FW)
> 
>  arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    | 15 ++++++++-------
>  include/linux/pci.h  |  1 +
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index efefeb82ab61..aa9617bc4b55 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -294,6 +294,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
>  
> +/*
> + * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
> + * performance with Extended Tags and MRRS > 128B. Workaround the performance
> + * problems by disabling Extended Tags and limiting MRRS to 128B.

No objections to your fix, just an obligatory:

 s/Workaround
  /Work around

:)

With that, FWIIW:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

