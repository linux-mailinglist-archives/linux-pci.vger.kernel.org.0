Return-Path: <linux-pci+bounces-40561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE3C3E970
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 07:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E053A7242
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5F281357;
	Fri,  7 Nov 2025 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfRhim6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559D17A2E8;
	Fri,  7 Nov 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495807; cv=none; b=iNhiyevmiuENg4grBxF3nVWo0Ln+kspiqZ6Bx5lJRDcd623SUpZvI6I5y5cM6KrgZANY/BwXFLW+ZD8oczVqdfHjL/UZWr8OsYELtsXUzhlulOXnvvj3eBeuUr/+RtyBfIwHASKMVNHjHSXt1VVF2QMuj6pf9VoYwqCt7dwW6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495807; c=relaxed/simple;
	bh=Qw47Ypxh6hCFBJwUZNmfzHzoZf62V55gj0I8Wbneo2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCIL/5qcgP0jsGmyjW+rTiNeHNzCphPgCsJEvrba6uEmcFvyi8ULWgGIdJeMt7yuu8TmxlyUx6f1ucoZUms79jfZe5T2d8baf0e36Q5MQH2JMfR0awNaDh7ux4cVqQjcHoPnoIzUY3KRVjkYZ03+gSeAcOtmWiMAXw4XmH7VfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfRhim6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86FDC4CEF5;
	Fri,  7 Nov 2025 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762495805;
	bh=Qw47Ypxh6hCFBJwUZNmfzHzoZf62V55gj0I8Wbneo2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfRhim6ylIxts3xnNHkB7gm6zcHD1Jy69uXevGxzCCF5oaN9yLlEmGqGMbxxR3QEx
	 iIBh9pgnRsEW0eNMazmYNzfUSgJwAo1q/4BvoIB/jqAAjBLaYS4Ye4E1nsaP36ts4f
	 y7XFx+Rg14Bbj53V2bW+o7vqINfIoSP/T5bio6AQhzQSFiqFQh1lvWLGnR9gn34wcS
	 hqC8UTGRWfHwJ0tvepmuc/82HNuOgjpHHOg4LD31RyqUW+2fQU2dC74qw9Pb15Gr3e
	 3Q1GfGhHowctqQ5cTa4XVftpSx/EQbL00AC6qMJ8heP6jaiBiMzrcVuY7KQ7a+58o2
	 P/FdDkL7E/yvg==
Date: Fri, 7 Nov 2025 11:39:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>, 
	Darren Stevens <darren@stevens-zone.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, 
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, 
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Message-ID: <ogkty663ld7fe3qmbxyil47pudidenqeikol5prk7n3qexpteq@h77qi3sg5xo4>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106183643.1963801-3-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:39PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
> ASPM states for devicetree platforms") broke booting on the A-EON X5000.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
> )
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..44e780718953 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +/*
> + * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
> + * aspm.c won't try to enable them.
> + */
> +static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
> +{
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);

From the commit message of the earlier version [1] you shared:

    Removing advertised features prevents aspm.c from enabling them, even if
    users try to enable them via sysfs or by building the kernel with
    CONFIG_PCIEASPM_POWERSAVE or CONFIG_PCIEASPM_POWER_SUPERSAVE.

Going by this reasoning, shouldn't we be doing this for the other quirks
(quirk_disable_aspm_l0s_l1/quirk_disable_aspm_l0s) as well?

- Mani

[1] https://lore.kernel.org/linux-pci/20251105220925.GA1926619@bhelgaas

-- 
மணிவண்ணன் சதாசிவம்

