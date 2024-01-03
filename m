Return-Path: <linux-pci+bounces-1615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039D8225DA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 01:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897731F21CD8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65F19F;
	Wed,  3 Jan 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvJqAlAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E047E;
	Wed,  3 Jan 2024 00:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8BFC433C7;
	Wed,  3 Jan 2024 00:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704240759;
	bh=rTo7bHSTZscbaOSrZrDFMXX97W0sP/G2kTdUTny+Fxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AvJqAlABGx6tTO9tTTIkN+baamjM3G24G2UXDCrNuty4jx95zxXWVJXB3xBP5z2f2
	 AgDmNft0zn+kkdyIxnMRgPCuPfeg1b0uq9g1pfcF/WMHb2S5cEH0CW+6E4LVfkJpic
	 jxylJXJ1JyDQUn1cUCfZq6BeSQrD09wCvysgOV3VC4g8NO+Z+BvTuR28NHiiOzWiAP
	 w8TYRjO58QThStISLzZGmfwdphJPBKYm6B/RNEHyjAcbJfuexKYqcCHGl0QgHzquFP
	 0qxtlUfch2fESz3mmtylXmlM3hzZVZPEsYXeRrf9cDCfB+MuIwgS5jOICKjHZ4lEXk
	 GvnehWXu6GBmw==
Date: Tue, 2 Jan 2024 18:12:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
Message-ID: <20240103001237.GA1755171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cd835e-f84c-4c43-812e-6706f7266150@linux.intel.com>

On Tue, Jan 02, 2024 at 03:33:51PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/2/2024 3:25 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This reverts commit 08d0cc5f34265d1a1e3031f319f594bd1970976c.
> > 
> > Michael reported that when attempting to resume from suspend to RAM on ASUS
> > mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1), 08d0cc5f3426
> > ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") caused a 12-second delay
> > with no output, followed by a reboot.
> > 
> > Workarounds include:
> > 
> >   - Reverting 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> >   - Booting with "pcie_aspm=off"
> >   - Booting with "pcie_aspm.policy=performance"
> >   - "echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm"
> >     before suspending
> >   - Connecting a USB flash drive
> 
> Did you find the root cause? Is this issue specific to that particular
> device? If yes, can we do a quirk?

Unfortunately we don't know the root cause yet.  Without knowing the
root cause, I don't think we can make a good quirk.

Bjorn

