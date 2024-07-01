Return-Path: <linux-pci+bounces-9542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC091E9F6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 23:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E71C20F66
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD916F85E;
	Mon,  1 Jul 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnEKgN6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AC381C4;
	Mon,  1 Jul 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868019; cv=none; b=PvfyGo5c+1RYOAQelHDe7sycZS+/zGPF+UkYHgJdp803D5qOmHvW4/on5V3SIIZbOeQgw3SrU0TbUHnmq56ZDxsecxEdPIY5vWG1/Ea8jgu/xxaMecA1JA0awmpfHhIHbHH4JaXT3kwRzjLd0nA9yH+jZ+3gLvLDx1Xbev33nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868019; c=relaxed/simple;
	bh=icwFKyaGqnlGKLMZKMHhEmLPtpcpRxOzqd2cuz1wh2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sR4Q/2wa+PasMBVQt8wA7D7gJQnorcD6HZL88W0UUQP4a9jaPSEDMlMy0fvtl2ClHFaF9RkBY84eIhTXUMShMI5c23ZUSrIv/qaS/DojWOtNOpv7IjCwX3qtg3dmHXtKB0T3oOucY87yr4bbsA5aPVx6toYZfkAgtR7TEWGyITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnEKgN6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A3CC116B1;
	Mon,  1 Jul 2024 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868019;
	bh=icwFKyaGqnlGKLMZKMHhEmLPtpcpRxOzqd2cuz1wh2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pnEKgN6L3qH6pFcXKHxo2T/XIV15XU3WdQvMvzl2K3yWKIr4jBXb5+hLGUU9k2Dud
	 j7bbMutMJmqR8eBGaZwmRLQ9dew/1J8Ekyl0ZEHtHCeR0ogLS3D+mmcb9nW4erwhP1
	 m1TSlx59dCxy9F/9dqWhM6vjbA6DTFmopHEFofch9PUdks0g5K+TaOQvnF9vKX94T9
	 0IDgrwOL+9CDEHaX827o+1GycnLNihzserNo+yGOhZTfdj0iNwK2L3FssKomsJwPmc
	 5nhyN8sQ/24SP94+alAU0Qz3aTWg/9pAcIeaGjepLpApmUrl6yblAi4F8B/dDtGtPA
	 X5Pmq2K+Wxtaw==
Date: Mon, 1 Jul 2024 16:06:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lkp@intel.com,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu
 root port
Message-ID: <20240701210656.GA16926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240630025225.9910-1-zhoushengqing@ttyinfo.com>

On Sun, Jun 30, 2024 at 02:52:25AM +0000, Zhou Shengqing wrote:
> > On Thu, Jun 27, 2024 at 12:58:56AM +0000, Zhou Shengqing wrote:
> > > This patch add 1k granularity for intel root port bridge.Intel latest
> > > server CPU support 1K granularity,And there is an BIOS setup item named
> > > "EN1K",but linux doesn't support it. if an IIO has 5 IOU (SPR has 5 IOUs)
> > > all are bifurcated 2x8.In a 2P server system,There are 20 P2P bridges
> > > present.if keep 4K granularity allocation,it need 20*4=80k io space,
> > > exceeding 64k.I test it in a 16*nvidia 4090s system under intel eaglestrem
> > > platform.There are six 4090s that cannot be allocated I/O resources.
> > > So I applied this patch.And I found a similar implementation in quirks.c,
> > > but it only targets the Intel P64H2 platform.
> > > 
> > > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> > > ---
> > >  drivers/pci/probe.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 5fbabb4e3425..909962795311 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -461,6 +461,9 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
> > >  	u32 buses;
> > >  	u16 io;
> > >  	u32 pmem, tmp;
> > > +	u16 ven_id, dev_id;
> > > +	u16 en1k = 0;
> > > +	struct pci_dev *dev = NULL;
> > >  	struct resource res;
> > >  
> > >  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
> > > @@ -478,6 +481,26 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
> > >  	}
> > >  	if (io) {
> > >  		bridge->io_window = 1;
> > > +		if (pci_is_root_bus(bridge->bus)) {
> > > +			list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
> > > +				pci_read_config_word(dev, PCI_VENDOR_ID, &ven_id);
> > > +				pci_read_config_word(dev, PCI_DEVICE_ID, &dev_id);
> > > +				if (ven_id == PCI_VENDOR_ID_INTEL && dev_id == 0x09a2) {
> > > +					/*IIO MISC Control offset 0x1c0*/
> > > +					pci_read_config_word(dev, 0x1c0, &en1k);
> > > +				}
> > > +			}
> > > +		/*
> > > +		 *Intel ICX SPR EMR GNR
> > > +		 *IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
> > > +		 *bit 2:Enable 1K (EN1K)
> > > +		 *This bit when set, enables 1K granularity for I/O space decode
> > > +		 *in each of the virtual P2P bridges
> > > +		 *corresponding to root ports, and DMI ports.
> > > +		 */
> > > +		if (en1k & 0x4)
> > > +			bridge->io_window_1k = 1;
> > > +		}
> > 
> > I still think this is not going to work because I don't want this kind
> > of device-specific clutter in this generic path. The pcibios_*
> > interfaces are history that we'd like to get rid of also, but it would
> > be better than putting it here.
> 
> Do you think it should be putted to the pci_bios* interface?
> 
> And if there is no suitable place to apply this patch, 
> then let's just ignore this issue.

What are the device/function addresses of the IIO and the Root Ports?

They must all be on the root bus, and if the IIO is enumerated first
(i.e., if it has a smaller device/function number), you may be able to 
make a quirk that applies to the Root Port vendor/device ID but reads
the config bit from the IIO.

quirk_passive_release(), quirk_vialatency(), quirk_amd_780_apc_msi(),
etc. do similar things.

Bjorn

