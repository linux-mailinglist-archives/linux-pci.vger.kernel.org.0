Return-Path: <linux-pci+bounces-7032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C38BA38A
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABDA1C218A0
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CF57C87;
	Thu,  2 May 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+tiodUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106C1B947
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690571; cv=none; b=tD8MxIyujm84FNzkwTPtKjGtAsiN7S9UF7YPtn0x+NrCfXtnUsclVvhyb64D3xYltsNDAE0V+5qcE/z0hxYLVen7h+FZXoHy4MNEVo5gOqG223DCp80bTssb5gP3PitJ1YUuBe74gP3gLWpxQKWiDBoV0gNneS+jGdkf4w46bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690571; c=relaxed/simple;
	bh=YKMRm8nvrW6l2B6dSTOHxKPB9TxHFOvwsaXd2uTFiM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XhVEFCithEGGGV24g3huyRXMrN/I797fDyJ9id5pN24mS9iGnE9bIaDHext9QAo3ZQX5UQrATWpE12F/spmSa3Qh2PucxSFGjPgTp3S5WqQhnyiESsJfYMg0dAw5qqYg+IiYzuHCxoNZV2hln9+uap0X05+0Gl/exyHoSv6wjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+tiodUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1FAC113CC;
	Thu,  2 May 2024 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714690570;
	bh=YKMRm8nvrW6l2B6dSTOHxKPB9TxHFOvwsaXd2uTFiM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A+tiodUMyEf5M+8/1igRWbXy87F4D1vNPofxu+OCfTeAxF2oYc7rcFotw6Vh5uj2H
	 vbdsqzrA211mHXeIoXcbidkjK7U1qSeVvuw2NCLMafQBtdISfJHLc4bA4XIjv2l2rq
	 ZnoTDYRtpfEhbADXriPLx7m5g5Z3p/7IrxPMy2kUbjItZAVY6ir7C/Dcl8qZ2917sJ
	 Nrrg1NoMwfScj45+/gn6IgnteQ+k2LyaTkWabxsMFXjs6OH4rIFbmX46yw+33rLFLt
	 01AktDY+d8T01tHkwGamZGjFofz7ZfRYys4+nvqzzYO4zSjku9QzvllBVc9SveNxSp
	 ig4h5anDZB8Cg==
Date: Thu, 2 May 2024 17:56:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
Message-ID: <20240502225608.GA1553882@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafed3eb-f698-41fa-867c-bfec87e429a4@intel.com>

On Thu, May 02, 2024 at 03:38:00PM -0700, Paul M Stillwell Jr wrote:
> On 5/2/2024 3:08 PM, Bjorn Helgaas wrote:
> > On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr wrote:
> > > Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") added
> > > code to copy the _OSC flags from the root bridge to the host bridge for each
> > > vmd device because the AER bits were not being set correctly which was
> > > causing an AER interrupt storm for certain NVMe devices.
> > > 
> > > This works fine in bare metal environments, but causes problems when the
> > > vmd driver is run in a hypervisor environment. In a hypervisor all the
> > > _OSC bits are 0 despite what the underlying hardware indicates. This is
> > > a problem for vmd users because if vmd is enabled the user *always*
> > > wants hotplug support enabled. To solve this issue the vmd driver always
> > > enables the hotplug bits in the host bridge structure for each vmd.
> > > 
> > > Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> > > ---
> > >   drivers/pci/controller/vmd.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index 87b7856f375a..583b10bd5eb7 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> > >   static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > >   				       struct pci_host_bridge *vmd_bridge)
> > >   {
> > > -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> > > -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> > > +	/*
> > > +	 * there is an issue when the vmd driver is running within a hypervisor
> > > +	 * because all of the _OSC bits are 0 in that case. this disables
> > > +	 * hotplug support, but users who enable VMD in their BIOS always want
> > > +	 * hotplug suuport so always enable it.
> > > +	 */
> > > +	vmd_bridge->native_pcie_hotplug = 1;
> > > +	vmd_bridge->native_shpc_hotplug = 1;
> > 
> > Deferred for now because I think we need to figure out how to set all
> > these bits the same, or at least with a better algorithm than "here's
> > what we want in this environment."
> > 
> > Extended discussion about this at
> > https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com
> 
> That's ok by me. I thought where we left it was that if we could find a
> solution to the Correctable Errors from the original issue that maybe we
> could revert 04b12ef163d1.
> 
> I'm not sure I would know if a patch that fixes the Correctable Errors comes
> in... We have a test case we would like to test against that was pre
> 04b12ef163d1 (BIOS has AER disabled and we hotplug a disk which results in
> AER interrupts) so we would be curious if the issues we saw before goes away
> with a new patch for Correctable Errors.

My current theory is that there's some issue with that particular
Samsung NVMe device that causes the Correctable Error flood.  Kai-Heng
says they happen even with VMD disabled.

And there are other reports that don't seem to involve VMD but do
involve this NVMe device ([144d:a80a]):

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1852420
  https://forums.unraid.net/topic/113521-constant-errors-on-logs-after-nvme-upgrade/
  https://forums.unraid.net/topic/118286-nvme-drives-throwing-errors-filling-logs-instantly-how-to-resolve/
  https://forum.proxmox.com/threads/pve-kernel-panics-on-reboots.144481/
  https://www.eevblog.com/forum/general-computing/linux-mint-21-02-clone-replace-1tb-nvme-with-a-2tb-nvme/

NVMe has weird power management stuff, so it's always possible we're
doing something wrong in a driver.

But I think we really need to handle Correctable Errors better by:

  - Possibly having drivers mask errors if they know about defects
  - Making the log messages less alarming, e.g.,  a single line report
  - Rate-limiting them so they're never overwhelming
  - Maybe automatically masking them in the PCI core to avoid interrupts

> > >   	vmd_bridge->native_aer = root_bridge->native_aer;
> > >   	vmd_bridge->native_pme = root_bridge->native_pme;
> > >   	vmd_bridge->native_ltr = root_bridge->native_ltr;
> > > -- 
> > > 2.39.1
> > > 
> > 
> 

