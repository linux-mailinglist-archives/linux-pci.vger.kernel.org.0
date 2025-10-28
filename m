Return-Path: <linux-pci+bounces-39592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C4C175F9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 00:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D76A54E3657
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1FF2C11F8;
	Tue, 28 Oct 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZBDyun8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94248280033;
	Tue, 28 Oct 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694415; cv=none; b=DS21D1mMyrBHZe5arsD4/EQ7vkcsdBjyOzPsgHKVCvyO/ILwe13t8u8jb8n+R+tjM1iDNj/Q/GvN6isXSK7+QfPSmCrtHdPKQANpKQme1+v9r5SOLwTlI/EJGwEynQwvqUeKNn7lyZwcTizTzZdMIH0SWaWUqMT/foeHGZjMWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694415; c=relaxed/simple;
	bh=HUOsnm5Nk+6xTsUUMwpytKpcd3je4nJFnLJK5pa2yWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kvyKzSX+lE0Ceebu2o021p5zF2qalA62lspmKCjNEgnJcl6z7+A7PqvyBm+eOZ1894raqlMPmj/Ywk5PdZsOmuO+lccL39qiA1To3Z6Fj8aEZSa5xHU7E2G5kLHi9CBXxbnIHDconpEG3PgSyEe9SQK3evuE5PuOCEZI5wKC0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZBDyun8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27E0C4CEE7;
	Tue, 28 Oct 2025 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694415;
	bh=HUOsnm5Nk+6xTsUUMwpytKpcd3je4nJFnLJK5pa2yWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QZBDyun8yiZBdSUzQHF1+2JJRcD4znNaEFpCr/zDqada5768JIuN44wzkJC+6msSh
	 q7w55UUYDhZ+XA3yCU3qfZ1uIjNtiyug2HCW6jX9hoNH7V3G3bY98nAuA2++vlN9K8
	 wAlXc+k7Zl//pAJrqV/wInOao3V7lmsfOubcVuRSZ1ulRRN2bzla0nbDigJMqMkwg4
	 lYp7mBo4dWuUMn4i9PLfa/KQYLpRadb64qLud7B1zWmJxbjHfkam1+Obj5JpVMPSSy
	 E48LLXKHAIdrUksbZjOSUqTnDLUuB9CB5ZJYZIIyRly1x7k8JGZimV7QnAl2+LyQ1z
	 D5dy17RW2HUsA==
Date: Tue, 28 Oct 2025 18:33:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <Frank.li@nxp.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251028233333.GA1467459@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa95b26-7801-476e-840f-5976b0ee11c1@xenosoft.de>

On Mon, Oct 27, 2025 at 06:12:24PM +0100, Christian Zigotzky wrote:
> Hi All,
> 
> I activated CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT again for the RC3 of
> kernel 6.18. Unfortunately my AMD Radeon HD6870 doesn't work with the latest
> patches.
> 
> But that doesn't matter because we disable the above kernel options by
> default. We don't need power management for PCI Express because of boot
> issues and performance issues.

It matters to me!  The kernel should work correctly with or without
CONFIG_PCIEASPM and any of the CONFIG_PCIEASPM_* settings.  We can't
expect users to know a magic combination of config settings to make
things work.

I assume AMD Radeon HD6870 is used on a variety of platforms, and I
don't see other reports of ASPM problems with it, so I suspect the
problem is something else.

  - v6.17 CONFIG_PCIEASPM=y, works OK

  - v6.18-rc3 CONFIG_PCIEASPM unset, works OK, as expected since we
    don't do anything with ASPM

  - v6.18-rc3 CONFIG_PCIEASPM=y, boot fails (this report, no logs)

I looked at Hypexed's logs from
https://github.com/chzigotzky/kernels/issues/17#issuecomment-3400419966,
all of which worked fine:

  - 6.18.0-a8-dmesg.log, looks like CONFIG_PCIEASPM unset, so we would
    expect this to be fine.

  - 6.18.0-a7-dmesg.log, CONFIG_PCIEASPM=y, ASPM fully enabled,
    reported to work fine.

    Hardware name: pasemi,nemo PA6T 0x900102 A-EON Amigaone X1000
    Found PA-PXP PCI host bridge.
    pci 0000:00:10.0: [1959:a002] type 01 class 0x060400 PCIe Root Port

    All the Root Ports are [1959:a002], and ASPM for 01:00.0 and
    05:12.0 (apparently the only endpoints that advertise ASPM) seemed
    to work fine.

  - 6.18.0-a7-2-dmesg.log, looks like CONFIG_PCIEASPM unset, so we would
    expect this to be fine.

So the only data point I see is that [1959:a002] seems to work.

Christian, can you collect the output of "sudo lspci -vv" from your
machine where CONFIG_PCIEASPM=y doesn't work?  Doesn't matter what
kernel you're running when you collect it.

I assume your machine is this:

  Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic

  Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->1
  Found FSL PCI host bridge at 0x0000000ffe201000. Firmware bus number: 0->8
  fsl-pci ffe200000.pcie: PCI host bridge to bus 0000:00
  pci 0000:00:00.0: [1957:0451] type 01 class 0x060400 PCIe Root Port
  pci 0000:01:00.0: [1002:6738] type 00 class 0x030000 PCIe Legacy Endpoint
  pci 0000:01:00.1: [1002:aa88] type 00 class 0x040300 PCIe Legacy Endpoint

  [1957:0451] Freescale (some kind of Root Port)
  [1002:6738] AMD Barts XT [Radeon HD 6870]
  [1002:aa88] AMD Barts HDMI Audio [Radeon HD 6790/6850/6870 / 7720 OEM]

I don't see any real info about that Freescale Root Port.

If you have a chance, could you try the patch below on top of
v6.18-rc3 with CONFIG_PCIEASPM=y?

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..2b6d4e0958aa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

