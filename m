Return-Path: <linux-pci+bounces-18418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B504A9F198B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5197A02F3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13BF19048A;
	Fri, 13 Dec 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJUFyK8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781F189F57;
	Fri, 13 Dec 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130936; cv=none; b=Ou6m0G+cmug6Gltpd8FtL0CGYmZ4uvCyUL0OCZ+ftYANRy7RPa1Ww8PtpT8VaLvVntqKAZY2qmFZiAMnYSmafidFeoFoOpBN8G3nI59L8NiYBW4jb3oPj+8rTyykQ/F6TAMurCPmEqeeGbiQ/fRKDDijToRq/SdfU7gzlQovqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130936; c=relaxed/simple;
	bh=aMg/Fa1ig9296Id38Ab5dklcdLPAGvF2Y5/AfsPbEYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dr+LDnZw2W8HAPMaZZhkpATjH8MxIn0lSnNLkGGb3XeFS+2yomwTdTMqptYiboj5P86CcQdyhgT2pIGtULR5idEkSC4q+ZMMMMu162ncrhJJQP1Z4DMCCx2oepXDLRMhThFfYg2eFiYbS1vwnr8lxejeuyMjwb09XUZ+WkLA0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJUFyK8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A59C4CED0;
	Fri, 13 Dec 2024 23:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734130936;
	bh=aMg/Fa1ig9296Id38Ab5dklcdLPAGvF2Y5/AfsPbEYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vJUFyK8gAc1pTWLCQcMA2ct+P4fpANC3Ri6JSKcmK/XoXy9UHVeeEzCDs9MHWDDW7
	 +QmXNk0AatmHhxgDcJi4gZQKW1qD5EOQQyDRqtLXzZPkIPyYMte6CplVhnGiIKw21S
	 d9D7OXHZNHgBUhrqZ7KbZBTLpLddzIKm8arp2RFMP+34CDA4y9WOZGnC6xhHYdkJhc
	 ejhmpLS4Sh7XLU0gIGUtm9nUQ1FwMx6Avt9Tl2NCd08RBWEbidelUj1Nr7eSurjs2p
	 3eDI8IIUp3xGXoZLMasNbgEQvCvw1fGyivzWVS+6MnJRdpKPHj5k+/BIdE7bd0WmhQ
	 ghR/Ct71LN/9Q==
Date: Fri, 13 Dec 2024 17:02:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.ntel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	You-Sheng Yang <vicamo.yang@canonical.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20241213230214.GA3434438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f708fdf-ca54-488f-8c7e-160c1164308a@panix.com>

[cc->to: David, Nirmal]

On Fri, Dec 13, 2024 at 02:26:37PM -0800, Kenneth Crudup wrote:
> OK, it looks like the effective change (that's not already contained in the
> LTR SNOOP patches already in Linus' master (et al.)) comes from this line
> from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for
> links under VMD domain"):
> 
> ----
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 00143f5fb83a..d2ff44e7fbb1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state
> *link, int blacklist)
>         aspm_l1ss_init(link);
> 
>         /* Save default state */
> -       link->aspm_default = link->aspm_enabled;
> +       link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
> +                            ASPM_STATE_ALL : link->aspm_enabled;

So I thought the "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)" in
f492edb40b54 would effectively do the same thing:

> > > > > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/
> > > > > lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
> > > > 
> > > > This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
> > > > domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
> > > > IDs 0x9a09 and 0xa0b0.
> > > > 
> > > > This looks like it should also be handled by upstream f492edb40b54
> > > > ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
> > > > "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".

But I guess it doesn't actually work.  I'm hoping David or Nirmal can
figure out why it doesn't because it seems obvious that it's the
intent.

Thanks a lot for all your work to narrow it down to this!

Bjorn

