Return-Path: <linux-pci+bounces-31220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252EAF0C69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12127A974B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23978223DEA;
	Wed,  2 Jul 2025 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy0FuTey"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCF1E47AE;
	Wed,  2 Jul 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440820; cv=none; b=hyRKUHC1iblUZfeHLoX8NdmJrcuGz6ZZcGMFNe2/cwdns5qqWEWmIj5+l/eSSmMWzMEXGoceqLKz79ZiCwjwtpjFPrpgX3RW0XxboAwF5TsvlRYA0Zn/xs89Fi/cTJvGTvKuGkygXkfPFarr1wFbxBqBBq7gSj6OjohByxTT5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440820; c=relaxed/simple;
	bh=7yY3zyP+o+CAM1z9NSmikiT0F2RunHbGbuYLre9AHjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOIBvhLBnhQdaNvDWaPNcR8KgPqVgrKI1t3xlgLiFZyS0yXFmYIeQythfMZYtLdxTOLDbX5g4B4GXo3vJ2hk8F2yKsEHRlF6W1bD0QVVHm/ac8aE4AbgcKaUO5FrRmGfyXgEgspDtbtxYy3wYp/l6flzkq6D/TzixG51Qi3d1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy0FuTey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E42C4CEED;
	Wed,  2 Jul 2025 07:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751440819;
	bh=7yY3zyP+o+CAM1z9NSmikiT0F2RunHbGbuYLre9AHjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy0FuTeySt704kfG/qqAezRaPepVmtIYpIVz3quaUljatnThExlU+VlrOC65DZKD7
	 oYgGNrpXvHEtLq4G22He62+RrK7CodWU8QmhZk45BTVegTQPpX2Tn5+sIGSJCGV+oN
	 PXqkfDIM238tvNjoPkxXy5nRUGkP1iSJaFhEEAALxCspq9J4AeQoMCHVQLYEt1icgh
	 OfsrZgPx1xjma8TGRoH0r2UTwdslvIC7MqhFxPmiqBfsw6AkUWkxjNumPaWXC0xaPB
	 baWeJ2//vXzet/qZFz/x8RqNRg+Kcy5lyQV1VY1bdiEpiqEe4+z1kFGAUHOkmNM/wj
	 9qihALQG/DBlg==
Date: Wed, 2 Jul 2025 12:50:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <stvmzmcfsubtt2mvpzy4245qk5sr2afgle4gvgwcfiw33aqsbt@ttv5atldoy4q>
References: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
 <20250701210138.GA1849044@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701210138.GA1849044@bhelgaas>

On Tue, Jul 01, 2025 at 04:01:38PM -0500, Bjorn Helgaas wrote:
> [+cc Bart, Krzysztof, update Mani's addr to kernel.org]
> 
> On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > If devicetree describes power supplies related to a PCI device, we
> > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > not enabled.
> > 
> > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > core will rescan the bus after turning on the power. However, if
> > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> > 
> > This may break PCI enumeration on any system that describes power supplies
> > in devicetree but does not use pwrctrl. Jim reported that some brcmstb
> > platforms break this way.
> > 
> > While the actual fix would be to convert all the platforms to use pwrctrl
> > framework, we also need to skip creating the pwrctrl device if
> > CONFIG_PCI_PWRCTL is not enabled and let the PCI core scan the device
> > normally (assuming it is already powered on or by the controller driver).
> 
> I'm fine with this change, but I think the commit log leaves the wrong
> impression.  If CONFIG_PCI_PWRCTRL is not enabled, we shouldn't do
> anything related to it, independent of what other platforms or drivers
> do.
> 
> So I wouldn't describe this as "the actual fix is converting all
> platforms to use pwrctrl."  Even if all platforms use pwrctrl, we
> *still* shouldn't run pci_pwrctrl_create_device() unless
> CONFIG_PCI_PWRCTRL is enabled.
> 
> I think all we need to say is something like this:
> 
>   We only need pci_pwrctrl_create_device() when CONFIG_PCI_PWRCTRL is
>   enabled.  Compile it out when CONFIG_PCI_PWRCTRL is not enabled.
> 

Sounds fair.

> > Cc: stable@vger.kernel.org # 6.15
> > Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> 
> Not sure about this.  If the problem we're solving is "we run pwrctrl
> code when CONFIG_PCI_PWRCTRL is not enabled," 957f40d039a9 is not the
> commit that added that behavior.
> 

Well, this exact commit causes breakage on Jim's platform. That's why I've added
it as the fixes tag irrespective of the pwrctrl functionality.

> Maybe 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
> nodes of the port node") would be more appropriate?
> 
> > Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> 
> I'm also not sure this really merits a "Closes:" tag.  All this does
> is enable a workaround (disable CONFIG_PCI_PWRCTRL when brcmstb is
> enabled).  That's not a fix because we *should* be able to enable both
> pwrctrl and brcmstb at the same time.
> 

Hmm, yeah. For this patch to work, one has to make sure that CONFIG_PCI_PWRCTRL
is not set. This requires not supporting the ATH11K/12K chipsets and Jim said
that they don't have a usecase for supporting these chipsets yet on the brcmstb
platform (which only the internal team uses to run mainline).

> If 2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if
> pwrctrl device is created") was purely an optimization (see
> https://lore.kernel.org/r/20250701203526.GA1849466@bhelgaas), I think
> I would:
> 
>   - Revert 2489eeb777af with a stable tag for v6.15, and
> 

But reverting 2489eeb777af alone wouldn't fix this regression [1].

>   - Apply this patch with a Fixes: 8fb18619d910 ("PCI/pwrctl: Create
>     platform devices for child OF nodes of the port node") but no
>     stable tag.  8fb18619d910 appeared in v6.11 and the "don't enable
>     CONFIG_PCI_PWRCTRL" workaround was enough for brcmstb until
>     2489eeb777af, so if we revert 2489eeb777af, we wouldn't need to
>     backport *this* patch.
> 

Which means, this patch will only get applied for v6.16. I don't understand how
that will ensure v6.15 is not broken (even after the revert).

- Mani

[1] https://lore.kernel.org/all/CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com

- Mani

-- 
மணிவண்ணன் சதாசிவம்

