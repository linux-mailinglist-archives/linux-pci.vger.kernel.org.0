Return-Path: <linux-pci+bounces-38924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C5BF79B5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6626419C30AE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C933B968;
	Tue, 21 Oct 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFtJkkqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9793321DC
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063352; cv=none; b=bLnoxzX5euMrlzyh63OtqXWCRbu1GGnwiq/D5QkqUqlxax2cawe541MNbCVq8/Y0na0aTnyy/WuCzuDYQBhRdAixoaktfYVTexAm1T09i2iFuqCdeVl7Q0ap+NV3k3rr8RG/jKy1NNdJVadWQoB0J/ec0MoRBrSmtU9FWFw1/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063352; c=relaxed/simple;
	bh=LiSbNcmRa2yu8jdXNxJMcj7qTFVoVNeWJnjvO94/uJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VUib86Nwm7vWjr8TpJf46CIaTceABz5hFSjRtVIOsxbi/b7PXvIOKtUijjShLdSdMw0GcECNPGcuHelNvLQMnd6oTT0n/fkE8THulp1oTUOGw0oT3WzGFFwjIvMFdNPD3LNMSPlIp3d5gtJ1YuZzR+5Y4A6heTCc8/FZfQRjJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFtJkkqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E1C4CEF1;
	Tue, 21 Oct 2025 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761063351;
	bh=LiSbNcmRa2yu8jdXNxJMcj7qTFVoVNeWJnjvO94/uJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YFtJkkqDGohq49Zov2UaITeo1WCoGUWNtVN51ykm5jhJp0pxxGUCKfJZIWgV56dzw
	 6zAcNuMBYu9XkeGnjGKFOypeTU+nqYq9hTLHHpNuk8gfCTANJFz9G19N2EV3ITDBO6
	 ndImYBGrJO8tNAoz1Kyf8sph1VDu6JJYRNiEMVTzOzD64FNbxoUg2t5sfW3ZgVZH7A
	 c+Y2VMj4yRdCMhgct04tyDnT930yypr5oVQpIwRuFhpY4zkhK6ue0k/tNcJ0pGrp7m
	 RpN7zVEDssO2K0vUK1SdMF4Hlpvs+MasragCV3AsX0V0eqlfA0y/0JCkXOeSrSfnQz
	 aleANylDKSCDA==
Date: Tue, 21 Oct 2025 11:15:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ravi Kumar Bandi <ravib@amazon.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ
 handling
Message-ID: <20251021161550.GA1194528@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a93b96-c641-41cb-9ab4-ae6cc7c4af1f@mailbox.org>

On Tue, Oct 21, 2025 at 06:02:40PM +0200, Stefan Roese wrote:
> On 10/21/25 17:53, Bjorn Helgaas wrote:
> > On Tue, Oct 21, 2025 at 05:43:22PM +0200, Stefan Roese wrote:
> > > While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
> > > on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
> > > the NVMe interrupts are not delivered to the host CPU resulting in
> > > timeouts while probing.
> > > 
> > > Debugging has shown, that the hwirq numbers passed to this device driver
> > > (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
> > > controller registers bits (0...3).
> > > 
> > > This patch now adds pci_irqd_intx_xlate to the INTx IRQ domain ops,
> > > handling this IRQ number translation correctly.
> ...

> > I wonder how many other drivers have this issue.
> > pci_irqd_intx_xlate() is used only by:
> > 
> >    dwc/pci-dra7xx.c
> >    pcie-altera.c
> >    pcie-xilinx-nwl.c
> >    pcie-xilinx.c
> >    pcie-xilinx-dma-pl.c   # this patch
> > 
> > Is there something different about these drivers that means they need
> > it when all the others don't?
> 
> I can't really tell. I'm pretty sure that this driver also needs
> pci_irqd_intx_xlate():
> 
> pcie-xilinx-cpm.c
> 
> I can't test it right now though. Perhaps in a few weeks though.
> 
> My best guess is, that legacy PCI IRQs are very rarely (not at all?)
> used and therefor tested these days. On our ZynqMP / Versal platforms this
> is currently sometimes used, as the RP does not support MSI-X
> (only MSI which is very unfortunate - and legacy of course). So it
> might be that some other drivers are missing this intx_xlate as well.
> Should be easy to test by booting with pci=nomsi.

I suspect many other drivers are also broken but not tested with INTx.
I guess we should ask about testing when merging new drivers that
claim to support INTx.

