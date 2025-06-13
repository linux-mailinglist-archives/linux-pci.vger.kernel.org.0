Return-Path: <linux-pci+bounces-29772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AEFAD95C0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569CB3BE041
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A5239E85;
	Fri, 13 Jun 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXDvkxnc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAD3FE7
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843808; cv=none; b=WajtPY5563tw0NtUS8DhjTNUffS498ugdlrvg/HVwyLF+N3kK+nXwo8KbJ9zMfOLzWmIS69ZAgFvT5G0PaArjJySWDPMQZTLd6au8/q8rfHLdeOibqD0bnIj1c1kjulZn/jT8Znak8aBq2ogcokASONMpZPuTiC7B3dhY4fAtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843808; c=relaxed/simple;
	bh=QiDA7k+apeVBCt10ixLRqYpjlFPI9227xfxGvzoA0bU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lu+Oflg9oX2egifGfc2HO7jDGE7U1UfmVcR4Bf/XvBCdf97jgSOwj2BgNFAG8Af7RkewSB7MJXGLgtLCFyPJKlU9AlaUQNcnknvk5jrjfR1CArlInBEJo7KSzI48dcSyS4kak5W81AVtaYBgA8nzJxZfr3lh8TT49qSM7xVgKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXDvkxnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7DC4CEE3;
	Fri, 13 Jun 2025 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749843807;
	bh=QiDA7k+apeVBCt10ixLRqYpjlFPI9227xfxGvzoA0bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eXDvkxncl8vSrY3gzQtqH2fHrnh9XGtkk9qaf2Q2XT/NtMPeByzRitNanvoL390sN
	 TBh4p5ZwmUO+siaT2Y63Si5x9cOPfwZngfk8T5uFcT1FWb66oZS6FYtn7wk8PWxln+
	 KVtxpUbe3a+XZZGxEO8AoWb0gCUV3u+DzAvb3xpoamy5VMjMvboL4l0VYxTAlsEyaU
	 mjNHmM2TKnK6ua6BlqHH1UD9TGcNPN7m/9yj+zPQbJ9rXijEljxZJCkXc0umkvaKdR
	 SbQ7GHDq303/dJ4ABW4VY5jNI4HFjwReWja2i+zx992y47odD1oPwukBnoqKXHWRSk
	 7UD4XuceM2paw==
Date: Fri, 13 Jun 2025 14:43:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Set up runtime PM on devices that don't support
 PCI PM
Message-ID: <20250613194326.GA972698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611233117.61810-1-superm1@kernel.org>

On Wed, Jun 11, 2025 at 06:31:16PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") intended to put PCI devices into D0, but in doing so
> unintentionally changed runtime PM initialization not to occur on
> devices that don't support PCI PM.  This caused a regression in vfio-pci
> due to an imbalance with it's use.
> 
> Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
> runtime PM is still initialized.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
> Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
> Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

4d4c10f763d7 appeared in v6.16-rc1, so I applied this to pci/for-linus
for v6.16, thanks for the quick resolution!

> ---
> v2:
>  * remove pointless return
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3dd44d1ad829b..160a9a482c732 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3222,14 +3222,14 @@ void pci_pm_init(struct pci_dev *dev)
>  	/* find PCI PM capability in list */
>  	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
>  	if (!pm)
> -		return;
> +		goto poweron;
>  	/* Check device's ability to generate PME# */
>  	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
>  
>  	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>  		pci_err(dev, "unsupported PM cap regs version (%u)\n",
>  			pmc & PCI_PM_CAP_VER_MASK);
> -		return;
> +		goto poweron;
>  	}
>  
>  	dev->pm_cap = pm;
> @@ -3274,6 +3274,7 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +poweron:
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
>  	pm_runtime_set_active(&dev->dev);
> -- 
> 2.43.0
> 

