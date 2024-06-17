Return-Path: <linux-pci+bounces-8875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62390B665
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C682817A0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E315B10E;
	Mon, 17 Jun 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxkp14kQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7715B0F0;
	Mon, 17 Jun 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641868; cv=none; b=Zp7RYtPoTMNcBmpn+jGq9oLbvn+1jn+XLtG2yQZ/tNpeLQul8isqzzIJUdhnWBB33lrEcmqwHX3LrdgAqbLxpAAy3SKP9XhhGgClmZxgCrpChl2Bd2p4yvUtbmtCKRU86XQz3KyxcIjAKe/m1oq770A4Skn56srbPDA2S/rDyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641868; c=relaxed/simple;
	bh=v/fzNDpfj3nv+7kRqz8+Sg+gzfCBtYUHAc4Cqg1q6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BfC5ELp7/LEoCOHtJQZe9/11TjEdtyxxnpf223MnolmDanW2L2dpTpGfADEmXF+KTKVD1H7+KnDZFjdkClPNv69Hu4QuDWZY5wAVfYZ4gwGJayNWYvFVJwv5qyvsBGgzdK9HjsDCvTExPoOOvPXAanEi8NAM+jxyMl4mb36/k9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxkp14kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37F8C2BD10;
	Mon, 17 Jun 2024 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718641868;
	bh=v/fzNDpfj3nv+7kRqz8+Sg+gzfCBtYUHAc4Cqg1q6aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rxkp14kQ/i1c8KhTzvR2UePzPqgAD6t1pRCpkzySgEZW2z+JabhOQHpR77mUNUkCR
	 UBQLT9nIZ76S/wOVUn8VbCSwi3RwSMuQMCsvgoRzOGFM2A6F33GEG9PZC6gixAG1Jm
	 15KMs4A5IfC1Gchj8X2POOMZMtYjDO+dWSnaZG7tgVikVepTvZeKk5+4Z3q2JuCdKh
	 Tb0tKgn0CtDGtFfUAFUVDDZPFp0/cWz01ds2VQzRQtALXXqMc3N3GXSS28W9wIpS0Z
	 HUE5UPzA43aEaA49o8yB+2V2hSx4iIR+WlqkWCqthcdCqn1gTRiNwzat5S/7/TYeIy
	 Fa7g07USdKmRA==
Date: Mon, 17 Jun 2024 11:31:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Songyang Li <leesongyang@outlook.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Cancel compilation restrictions on function
 pcie_clear_device_status
Message-ID: <20240617163106.GA1217016@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2754F489000B7FA6F9CF19D8B4CD2@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>

On Mon, Jun 17, 2024 at 09:35:20PM +0800, Songyang Li wrote:
> On Sat, 15 Jun 2024 16:26:03 -0500, Bjorn Helgaas wrote:
> > > On Wed, 12 Jun 2024 15:14:32 -0500, Bjorn Helgaas wrote:
> > > > I think all current any callers of pcie_clear_device_status() are also
> > > > under CONFIG_PCIEAER, so I don't think this fixes a current problem.
> > > > 
> > > > As you point out, it might make sense to use
> > > > pcie_clear_device_status() even without AER, but I think we should
> > > > include this change at the time when we add such a use.
> > > > 
> > > > If I'm missing a use with the current kernel, let me know.
> > > 
> > > As far as I know, some PCIe device drivers, for example,
> > > [net/ethernet/broadcom/tg3.c],[net/ethernet/atheros/atl1c/atl1c_main.c],
> > > which use the following code to clear the device status register,
> > > pcie_capability_write_word(tp->pdev, PCI_EXP_DEVSTA,
> > >                 PCI_EXP_DEVSTA_CED |
> > >                 PCI_EXP_DEVSTA_NFED |
> > >                 PCI_EXP_DEVSTA_FED |
> > >                 PCI_EXP_DEVSTA_URD);
> > > I think it may be more suitable to export the pcie_clear_device_status()
> > > for use in the driver code.
> > 
> > If we want to use this from drivers, it would make sense to do
> > something like this patch, and this patch could be part of a series to
> > call it from the drivers.
> > 
> > But at the same time, we should ask whether drivers should be clearing
> > this status themselves, or whether it should be done by the PCI core.
> 
> After careful consideration, I agree with your point of view.
> I hold a viewpoint that it should be done by the PCI core,
> rather than pcie drivers. I give up this patch, and then I have
> gained a profound understanding of PCIe Core from this communication.

I tend to think this should be done by the PCI core, but I haven't
looked at it enough to know how or where.  If you pursue it, I'd love
to see your ideas!

Thanks,
  Bjorn

