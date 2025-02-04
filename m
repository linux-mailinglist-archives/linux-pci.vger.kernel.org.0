Return-Path: <linux-pci+bounces-20714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78CA27CDD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 21:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61F3A5F89
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA4219E8D;
	Tue,  4 Feb 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyGNvxeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761A2046B1;
	Tue,  4 Feb 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738701579; cv=none; b=TJh5elCR4rDpVW908lA4uU1EEc51ltL3Mw5DGPhIavcZa3Mb9PrC4q5sq0yrS5HzP6xWyuJoRgCqUrdQW7anZfRyLD6RO5LwLG+LO+RkMmBc7ucgvc3JsMo7ZkjnEcU9aSgEferGwko640cfBc8kv6MiKOXh9nq8GeMs2yWl+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738701579; c=relaxed/simple;
	bh=f4g6bqfAT9+Gt7eiCy02v5g9+I4V2HS1JOGUwyG51iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=auKLfpK0lnZEK97nzpHwVEyMFcgojrZwE6TK/CNBFbNNiZdsV30Gn0+qhb+vFa3L2BKyAg7uCRm8FKTQZDBhYckVSg5FiNBBCHFUZOZvJ9KbQA7l5KRVUc5RibRE43K7hgBOhScRgYr1GFXF0mSDIroDGRlMTaAy91zBPxXSkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyGNvxeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C53C4CEDF;
	Tue,  4 Feb 2025 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738701578;
	bh=f4g6bqfAT9+Gt7eiCy02v5g9+I4V2HS1JOGUwyG51iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WyGNvxeDRjt3Zv+K1eAJfX1iuKoV43u6V51makn4ADDUZSjejXchnDkdKarEecxiA
	 GFXa+6vBUv9EYLCV6xLj1TLqSONt9kCP0pX/qcsgN2lAnghFv3VV1SjGp0g38jjuIQ
	 Se4a3AzXf8D+/WyIq+FfxrIR7SdCuB1VqBiOfG+TE2qrulQP2eYhJVQZbP9Yk7qZT3
	 GxFsoI4bkjFMJ8VmLR0dY+Dm6gpX0XBNrLBun4EUFrxSGqBJGGkNzW5nCFEZZrH+5E
	 1aDpLIAZJlAo/BCp84ei5FowM6c+R0Dkr6fEbVSZ8p8K1DFGUHi2QVfsJKZtBU9Ev0
	 J9whJjwrEkO5w==
Date: Tue, 4 Feb 2025 14:39:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
Message-ID: <20250204203936.GA860339@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131152913.2507-1-ilpo.jarvinen@linux.intel.com>

[+cc Rafael]

On Fri, Jan 31, 2025 at 05:29:13PM +0200, Ilpo Järvinen wrote:
> The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
> pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for both
> the Upstream Port and its upstream bridge when handling an Upstream
> Port, which matches what the L1SS restore side does. However,
> parent->state_saved can be set true at an earlier time when the
> upstream bridge saved other parts of its state. 

So I guess the scenario is that we got here because some driver called
pci_save_state(pdev):

  pci_save_state
    dev->state_saved = true                <--
    pci_save_pcie_state
      pci_save_aspm_l1ss_state
        if (pcie_downstream_port(pdev))
          return
        # save pdev L1SS state here
        if (parent->state_saved)           <--
          return
        # save parent L1SS state here

and the problem is that we previously called pci_save_state(parent),
which set "parent->state_saved = true" but did not save its L1SS state
because pci_save_aspm_l1ss_state() is a no-op for Downstream Ports,
right?

But I would think this would be a very common situation because
pcie_portdrv_probe() calls pci_save_state() for Downstream Ports when
pciehp, AER, PME, etc, are enabled, and this would happen before the
pci_save_state() calls from Endpoint drivers.

So I'm a little surprised that this didn't blow up for everybody
immediately.  Is there something that makes this unusual?

> Then later when
> attempting to save the L1SS config while handling the Upstream Port,
> parent->state_saved is true in pci_save_aspm_l1ss_state() resulting in
> early return and skipping saving bridge's L1SS config because it is
> assumed to be already saved. Later on restore, junk is written into
> L1SS config which causes issues with some devices.
> 
> Remove parent->state_saved check and unconditionally save L1SS config
> also for the upstream bridge from an Upstream Port which ought to be
> harmless from correctness point of view. With the Upstream Port check
> now present, saving the L1SS config more than once for the bridge is no
> longer a problem (unlike when the parent->state_saved check got
> introduced into the fix during its development).
> 
> Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219731
> Reported-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
> Tested-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..da3e7edcf49d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
>  	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
>  
> -	if (parent->state_saved)
> -		return;
> -
>  	/*
>  	 * Save parent's L1 substate configuration so we have it for
>  	 * pci_restore_aspm_l1ss_state(pdev) to restore.
> 
> base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
> -- 
> 2.39.5
> 

