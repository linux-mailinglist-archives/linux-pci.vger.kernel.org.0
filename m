Return-Path: <linux-pci+bounces-8602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E5904256
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA7C1F2774D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF30F4F215;
	Tue, 11 Jun 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca3NFRtd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E942067;
	Tue, 11 Jun 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126514; cv=none; b=pCLACd7xS0lKQXNriSPxbBh+Ev9ijh5JM5icnLCo6R2uR3moLGsI5ju0o1TT7wh7V3Q+vl4zIKI4zrNuXDSnt07qyAMb+BpGB6CNVP2LUO/A7Cuqw1di0lMyY2yuksKdVcMXuKzSoojJBMEhMlQLijqlhKCro3HtaYnlqWngytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126514; c=relaxed/simple;
	bh=Al6HONR3WVVBrk0Upd3B3HzomVEKxemyrAHy7G9ejOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SZ7Aqj5DYvpwMTPISkJ5yq1A3BlcLQ0zTJlHa5U3KeNaaHPev4GwlX+XR7jTCNq+0TwfninL0u2GdeGT2zapRPXetd27EBEiQfuGcZJTpHUnLc8In8bFhSWw7SfJIxdGwhVNOxPpAIFjNBnHMZkGvahGJVrqp3Q0zgwq383gIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca3NFRtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAB1C2BD10;
	Tue, 11 Jun 2024 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126514;
	bh=Al6HONR3WVVBrk0Upd3B3HzomVEKxemyrAHy7G9ejOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ca3NFRtd1Be+TG67Ym1YkrdBC58hIXQz0u6Ek04a2f3Qc9+Ft0yYHuDCFeHEZHjXN
	 XTg4mtOTNpxNg6DO2x3oSwsBmoDl+Yq9n87/BL25urTqIGI68duEeKAOPDuul0b7cu
	 M76+vU/rN6bWPVNvaAqZAsnbhnPS2DaeFyY+fZLjirdJUAdAv+D7bK2Mg2hBT0JSN6
	 h5RUfeClfDIAi7MOJMY/AIqiv0zt3h7rNbxTOQe+XtTa6LksGo28+vHHsLTbYchuT0
	 SCnrASccS4AzCUTIGPhwWfwaiK1JxfrFXgSYfmAYWiHJjs+WEbthHcqsD20gZw8g2j
	 yt0dI+Oq1l8qg==
Date: Tue, 11 Jun 2024 12:21:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jieyy.yang@mediatek.com,
	chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
	jian.yang@mediatek.com, jianguo.zhang@mediatek.com
Subject: Re: [PATCH v2 1/3] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent()
Message-ID: <20240611172147.GA990220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864ja2l2jd.wl-maz@kernel.org>

On Sun, Jun 09, 2024 at 01:32:38PM +0100, Marc Zyngier wrote:
> On Sat, 08 Jun 2024 10:01:52 +0100,
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> > 
> > On Mon, Dec 11, 2023 at 04:52:54PM +0800, Jianjun Wang wrote:
> > > Use dmam_alloc_coherent() to allocate the MSI address, instead of using
> > > virt_to_phys().
> > 
> > What is the reason for this change? So now PCIE_MSI_VECTOR becomes unused?
> 
> More importantly, this is yet another example of the DW reference
> driver nonsense, where memory is allocated for *MSI*, while the whole
> point of MSIs is that it is a write that doesn't target memory, making
> any form of RAM allocation absolutely pointless.
> 
> This silly approach has been cargo-culted for years, and while I
> caught a few in my time, you can't beat copy-paste.
> 
> IMO, this patch is only making things worse instead of fixing things.

Probably partly my fault.  I think there are two pieces here:

  1) allocating the MSI address
  2) computing the PCI bus address

I don't know how to do 1), but I do encourage people not to use
virt_to_phys() for 2), since (in general) CPU physical addresses are
not the same as PCI bus addresses.

