Return-Path: <linux-pci+bounces-34476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B5B30053
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA66AC6032
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47502E0418;
	Thu, 21 Aug 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft3NZvYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078E2E03F8
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794378; cv=none; b=ixQu77sDpmGXvzpMpvbPnKPpIx6JowN56icDsxkHZmDSzaLQYpkznPw2uL074OkabiPtBAC46NQFmH/24aToH6kOAMKUhLaoM6n3e7ajPsSIB8I0LDufwS6r0Q16Nqsk3ULnbWiCZz96i5oyjK0J4XmVIEtjfNjfJp2duxMd8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794378; c=relaxed/simple;
	bh=cmZWp00zfeqbRmxA1bdQFwu6WLZptUjpd1SS6ibFJh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EVF3mgsazreREac8OoqvaTsFVkc7C0sNi7tBQ3GInvxbDS2RcDcDVZTLJUmQ3witP73e1OU1z52XsVQeYpF6b5QEPdNdPhjz9w0fumChOGUNJHfJOft94HVp2v2LeyIwLYdDaBDjmMgP9covs2fSusseBK2IOTmfBUiWSoRm1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft3NZvYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A2C4CEEB;
	Thu, 21 Aug 2025 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755794378;
	bh=cmZWp00zfeqbRmxA1bdQFwu6WLZptUjpd1SS6ibFJh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ft3NZvYnK4XGVrHCAHK2Er3MU1zoWWuYzmdDOq4ieqYupC7rrgc8QEhgRRspHFY/s
	 R07eoQ10IuZ3eqKrjssWFiJ9/9dSqYboYPDyjQqwVBeTSLcaltGVGkh8/JqnIvf2RL
	 uHnC/9QCKpf78My2Ro22O1RFid2LIc7zZ14CArFStfm1yYi82w/VMmh6EHFSyhcIA6
	 xrSwhBMzXZ2eBv+2o+vJHT4eaQF7OuQZIDIx1RO35sGbAblGgBRpkyzXj7JZLaZyvV
	 DuJ7ZTwlEX+WArJOHAL+3vbzwEEg8szBTZCM/HFpN3BRIIbytegTZBqWFWx6hbGtTl
	 klHgP2Bkyq3Aw==
Date: Thu, 21 Aug 2025 11:39:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250821163936.GA681451@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eae31738-5d5d-4c74-af1c-66168c36ead5@canonical.com>

On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
> On 7/2/25 17:43, Hui Wang wrote:
> > On 7/2/25 07:23, Bjorn Helgaas wrote:
> > > On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
> > > > Sorry for late response, I was OOO the past week.
> > > > 
> > > > This is the log after applied your patch:
> > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61
> > > > 
> > > > 
> > > > Looks like the "retry" makes the nvme work.
> > > Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
> > > a long time after we think the device should be able to respond with
> > > RRS.
> > > 
> > > I always thought the spec required that after the delays, a device
> > > should respond with RRS if it's not ready, but now I guess I'm not
> > > 100% sure.  Maybe it's allowed to just do nothing, which would lead to
> > > the Root Port timing out and logging an Unsupported Request error.
> > > 
> > > Can I trouble you to try the patch below?  I think we might have to
> > > start explicitly checking for that error.  That probably would require
> > > some setup to enable the error, check for it, and clear it.  I hacked
> > > in some of that here, but ultimately some of it should go elsewhere.
> > 
> > OK, built a testing kernel, wait for bug reporter to test it and collect
> > the log.
> > 
> This is the testing result and log.
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/65

Thanks!  This looks like an Intel S2600WFT, and I assume it has a BMC
that maintains a System Event Log.  Any chance you check or keep that
log?

> > > @@ -1305,14 +1321,33 @@ static int pci_dev_wait(struct pci_dev *dev,
> > > char *reset_type, int timeout)
> > >             if (root && root->config_rrs_sv) {
> > >               pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> > > -            if (!pci_bus_rrs_vendor_id(id))
> > > -                break;
> > > +
> > > +            if (pci_bus_rrs_vendor_id(id)) {
> > > +                pci_info(dev, "%s: read %#06x (RRS)\n",
> > > +                     __func__, id);
> > > +                goto retry;
> > > +            }
> > > +
> > > +            if (PCI_POSSIBLE_ERROR(id)) {
> > > +                pcie_capability_read_word(root, PCI_EXP_DEVSTA,
> > > +                              &devsta);
> > > +                if (devsta & PCI_EXP_DEVSTA_URD)
> > > +                    pcie_capability_write_word(root,
> > > +                                PCI_EXP_DEVSTA,
> > > +                                PCI_EXP_DEVSTA_URD);
> > > +                pci_info(root, "%s: read %#06x DEVSTA %#06x\n",
> > > +                     __func__, id, devsta);

We're waiting for 01:00.0, and we're seeing the poll message for about
375 ms:

  [   10.334786] pci 10000:01:00.0: pci_dev_wait: VF- bus reset timeout 59900
  [   10.334792] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000
  ...
  [   10.708367] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000

The 00:02.0 Root Port has RRS enabled, but the config reads of the
01:00.0 Vendor ID did not return the RRS value (0x0001).  Instead,
they returned 0xffffffff, which typically means an error on PCIe.

If an error occurred, I think it *should* set one of the Error
Detected bits in the Device Status register, but we always see 0
there.

I think the platform enabled firmware-first error handling and
declined to give Linux control of AER, so I'm wondering if BIOS is
capturing and clearing those errors before Linux would see them, hence
my question about the SEL.

  [    6.565996] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
  [    6.702329] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR DPC]
  [    6.702463] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]

Even if this is the case and the SEL has error info, I don't know how
that would help us, other than maybe to understand why Linux doesn't
see the errors.

Bjorn

