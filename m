Return-Path: <linux-pci+bounces-39167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C973EC0257F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 222264FB1F2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540F2D3ED2;
	Thu, 23 Oct 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXtsxzp9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952F28504F;
	Thu, 23 Oct 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235862; cv=none; b=KylrdpjTvHk9Oqsx/YrMmDNM7KDpWopPKvNE1hSG3fF5egToLGVbX8wwYP4EFQNQS/pxm0gbDB3l80hZZfoGZrA7QK72PDvGwg+uWhe9n143vjCVTGjIC6Z1NA5yDZdttFkB5wj9hyqYD0/t9A/5pvYknAS/CJc4MDs2PDo+c6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235862; c=relaxed/simple;
	bh=QoQ0G1vzfRKHWUkpNlMaZxVkeeSKpfz8eW4ukxGyOFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CRKbZkrPUZONlhYPJ7OFbBPydaJtkGbanRihucswIX03R/I3SnQcyyRJFp2dARsToVvBT1SlurCtS4ETEdXaXr+BRlrUCoAhClIfkWb/tsxKTyl1BFjwvGG4+jOE3CDv4ZiDs5atumQqZ/r8jPL1WYK4CNdFRh9waMd1kMBGjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXtsxzp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37110C4CEE7;
	Thu, 23 Oct 2025 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235861;
	bh=QoQ0G1vzfRKHWUkpNlMaZxVkeeSKpfz8eW4ukxGyOFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YXtsxzp9O3qmvAboQgiGhtU2a4kOVmoOZAF18a40K9jWaODby5Dr5KkClDRCmRecB
	 5Kwhfe9OVtuVJwx7qlFIa1qenNEhOQdQBQeGgPvf3lk0m6+mNz10ONzXFOpFn1jjIr
	 KnAfYrzBAregsG25fnWb4MgB0VgFPDZdM6xqlySUvRHmA1c3X80Sx1UtHUntoeJfu+
	 AbKhx8Y8ctx3lE2ly7QbBlNrFLoOe/j/gTTqV+cP5JNhmdetJjk0b7qZhQ1wtwzhGN
	 KpS+Yc1Tj4SG7JVI4fFMWtkkhO2QkT0pkvm1HJLRz6uJzE0GfUQPYIuHjzYITZin/R
	 kW8LtX2vAFT+g==
Date: Thu, 23 Oct 2025 11:11:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"Bandi, Ravi Kumar" <ravib@amazon.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Message-ID: <20251023161100.GA1297651@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c7e43c3-24e9-4b08-a6ce-2035b50226f4@mailbox.org>

On Thu, Oct 23, 2025 at 09:03:07AM +0200, Stefan Roese wrote:
> On 10/23/25 08:35, Musham, Sai Krishna wrote:
> > > -----Original Message-----
> > > From: Stefan Roese <stefan.roese@mailbox.org>
> > > On 10/22/25 14:48, Musham, Sai Krishna wrote:
> ...

> > > > > > We even don’t need ravi patch, as we have tested this at
> > > > > > our end it works fine by just updating interrupt-map
> > > > > > Property. We need to now understand the difference in
> > > > > > design.
> > > > > 
> > > > > Ok, please let us know with your findings. In the meantime,
> > > > > I'll keep Ravi's patch in tree, as it seems to be required
> > > > > on his setup.
> > > > 
> > > > We tested on Linux version 6.12.40 without applying either
> > > > Stefan's or Ravi's patches.  Instead, we applied only the
> > > > following interrupt-map property change (entries 0,1,2,3) and
> > > > verified that legacy interrupts are working correctly.
> > > > 
> > > > interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> > > > <0 0 0 2 &pcie_intc_0 1>,
> > > > <0 0 0 3 &pcie_intc_0 2>,
> > > > <0 0 0 4 &pcie_intc_0 3>;
> > > > 
> > > > 38:       1143          0  pl_dma:RC-Event  16 Level     80000000.axi-pcie
> > > > 39:       1143          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
> > > 
> > > Okay. Same here. I don't need Ravi's patch for the INTx bit
> > > enabling.
> > > 
> > > I understand that you want us to change the interrupt map in the
> > > auto- generated device-tree from Vivado. Which is IMHO a bit
> > > "suboptimal".
> > > 
> > > I would prefer to have a solution which works out-of-the-box,
> > > w/o the need to manually change DT properties. Is it planned to
> > > change / fix this interrupt map in pl.dtsi generated with a
> > > newer version of Vivado?
> > 
> > Yes Stefan, this will be fixed in the newer versions and the
> > auto-generated device tree will include the correct interrupt-map
> > property entries.
> 
> Understood. And thanks the update on this.
> 
> @Bjorn & Mani, this patch can be dropped then.

Just to confirm, we can drop both of these patches:

  https://patch.msgid.link/20250920225232.18757-1-ravib@amazon.com
  https://patch.msgid.link/20251021154322.973640-1-stefan.roese@mailbox.org

AND there are no DTs in the field that will need to be updated for
things to work?

It's OK if you need to update internal DTs that haven't been shipped
to users, but we do not want to force users to update DTs that have
previously been working.

Bjorn

