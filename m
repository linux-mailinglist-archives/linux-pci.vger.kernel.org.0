Return-Path: <linux-pci+bounces-28278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EDAC10E6
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB960501D9B
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289A7DA73;
	Thu, 22 May 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCsWDYRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC04D8D1
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930801; cv=none; b=Q9p9z+2Yr2QW1jnXfUWz0FN3DPRpYPWdDRoTW56ZQ7CInQf6pkAE0vNt4f5A/+oRUh5XXRL8s1XB2KBifCaakkum4QH73Yda74OC1svrK2JOozbNHXixhz1207k2vAVsuykLmAy+tgpG+82n84VLvKYo8viZw/9lHaavqB7CBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930801; c=relaxed/simple;
	bh=zlH8oICRa6wtL6smu6IsIyqJByEonGaQOagmnxsbYyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DdyboJ55hM8w11n8EOlAV/EUe3wak5sCXSM3o40pOanMpJDt0T1TDaPQF0HXMNt3SWWwtlCeeAMBpJw2aitf6uFb6e3XUDyRISU08kyg/OZwjm/VPkKmVpX7UEI1psxHWkLuTC7KWA3msWOkePfgCcouezjZNTLvKGbeclbXnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCsWDYRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A41C4CEE4;
	Thu, 22 May 2025 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747930800;
	bh=zlH8oICRa6wtL6smu6IsIyqJByEonGaQOagmnxsbYyA=;
	h=Date:From:To:Cc:Subject:From;
	b=BCsWDYREPMekI03doGnAM19P+UoD4QvacO5I/f3dmhKV1VebjFomKY4BT20pmuF44
	 KaR/mF2qQDxwBM9R2CxslPbG0Hx9Iq0smSbTLIVfSp5Qdix3soxrtVHOvitz9f4jGV
	 ilQ+s88ew3cSGPgc0aaSwGlKGg0mQAKZIJT88l4pMppzxSdllInAji5DcyxJaK16lG
	 quEBnIHrFe82AjgJ9MxI4vy2v+EXu6cN5SbYv4GSIK8UWJw6hz4l/2yThFJ6eCnrxl
	 Xcp99IUX5Zf1vldmvfHw/nMQFop1PSI2GWW2IjCurwFKquBJaslokyLA/VaEp0iUHH
	 6s5bN+2cd3DdQ==
Date: Thu, 22 May 2025 18:19:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: reset_slot() callback not respecting MPS config
Message-ID: <aC9OrPAfpzB_A4K2@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello there,


As you know the reset_slot() callback patches were merged recently.

Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
reset_slot() callback has been invoked. The issue is reproduced when MPS
configuration is set to performance, but might be applicable for other
MPS configurations as well. The problem appears to be that reset_slot()
feature does not respect/restore the MPS configuration.


When having two Rock 5Bs, one in RC mode, one in EP mode:

# Boot with MPS bus performance
pci=pcie_bus_perf on kernel command line

# lspci RC
lspci -vvvs 0000:00:00.0 | grep -E MaxPayload
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                DevCtl: MaxPayload 256 bytes, MaxReadReq 256 bytes

# Run pcitests
All tests pass

# Perform hot reset of EP
echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

# lspci RC
lspci -vvvs 0000:00:00.0 | grep -E MaxPayload
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                DevCtl: MaxPayload 128 bytes, MaxReadReq 512 bytes

# Run pcitests
FAIL  pci_ep_data_transfer.dma.READ_TEST
Compared to before, DMA read test now fails.

Wilfred has been able to track this down to being because MPS in the RC
is different before/after a ->reset_slot(), and simply re-storing MPS using
a dirty hack, the DMA read issues go away.



My first thinking was that pci_configure_device() (and thus pci_configure_mps())
was not called,
so I added some prints in pci_configure_mps().
pci_configure_mps() was not called for RC nor EP during ->reset_slot()
(I did not check if pcie_bus_configure_settings() was called.)


I tried Mani's earlier patch instead of what is queued up:
https://lore.kernel.org/linux-pci/20250221172309.120009-2-manivannan.sadhasivam@linaro.org/

And in this version pci_configure_mps() does get called,
for both the RC and EP during ->retrain_link()
(I did not check if pcie_bus_configure_settings() was called.)

But... MaxPayload was still incorrectly set after retrain_link().


I think the solution is to add a call to add a pcie_bus_configure_settings()
call in pcie_do_recovery() / pci_host_recover_slots() / pci_host_reset_slot() /
pcibios_reset_secondary_bus().


Or possibly a:
        list_for_each_entry(child, &bus->children, node)
                pcie_bus_configure_settings(child);

as done in pci_host_probe().

I'm not sure if we need to make sure that pci_configure_device() /
pci_configure_mps() gets called as well. Since we did reset the endpoint,
it seems that calling pci_configure_mps() does make sense.


Normally, I would wait for Wilfred and myself to come up with a nice fix,
and test it, but, considering that the ->reset_slot() patches are queued
up already, and the merge window is opening soon, I'm sharing our findings
on the list, as it might take some time to come up with a nice solution.


Kind regards,
Niklas

P.S. Thanks to Wilfred for all the hours spent root-causing this.

