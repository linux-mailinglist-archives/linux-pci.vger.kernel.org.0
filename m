Return-Path: <linux-pci+bounces-36864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E0B9AD39
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D0B7A0618
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8032264DB;
	Wed, 24 Sep 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a31fF5Ul"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8E1D8E01;
	Wed, 24 Sep 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730564; cv=none; b=T4liP11VZ8EguOSlI151n6cDeao2vEiMmSZ+Nj4UMYW5y3cZPr38VNCiQRVPVnPZumxvuWXR590SHueW0kMk3QqFGDk4COkyILD/qn8o4Zo32ux6hxNgw7F32oWYbnBqlyLv2ObPd2XBw9GBjy+2pAej69D63ewo3OgBRH6dNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730564; c=relaxed/simple;
	bh=kkjtwtL1939kS3KHWd3nmrExrzEMNg8o8jRFiH4e5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6NXzQMiFk8+BLxlPiLRRroH8UlDiYFOLKHW5Y/roelr1ptdFVAMGKEwbFmvPzMmAI+R2Tjc0d+G0ZyNNUsB3Bp5CInqrByEawbBdKgDuIm0sM0gV2mb7aRmqhrUrqDFmbhXGD+hmyAVPSZ7KzVNXV3o0GX77Sn+PpNv2zarsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a31fF5Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF22BC4CEE7;
	Wed, 24 Sep 2025 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758730563;
	bh=kkjtwtL1939kS3KHWd3nmrExrzEMNg8o8jRFiH4e5wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a31fF5Ul5zvpwWOxxnlwJU+KT1ObHYc8kGdqsb+sllZg6T0IanElHtNYLCzbXTCaF
	 yLdWcyMZW+h0mPUZqoantXB8CtStYV/1h8R5DnRpcTpQMa9MM5ZdD+Fxm9DpfdoMoU
	 Vkp7zRZv1Jp5ceggGyokQYvJm5UlojNKw+fUG5eF/27997l6QrC6VZTUcY0mEgZ1D5
	 04LVRuAY+sNnTuALBu2NIMDfM03KZi2HEdjFcO4y0UGERgTJmJW4hbbZE+9TwV9nOp
	 UYZb5FeA/J/r54rf0a99FTXMO5U/fIjPGbEq+INas7R6vwvk5N5VuXxPGhDJsuHNGW
	 rLA7L0NuAwDoA==
Date: Wed, 24 Sep 2025 21:45:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint
 mode
Message-ID: <emyizd7i6wo2ljh2d6bvryvqlrqkcnzztrof6b5ue3jwoyiakd@rlgw3aymft2a>
References: <20250919131646.167330-2-cassel@kernel.org>
 <lrox3l5cafqsom3eier6n7wpbfatlic42rxs5q5utrhg4fekls@kj3b5ue7ggt7>
 <aNFJ8awYYwxb2o6B@ryzen>
 <elejp25mi7fwrhoavwrxsp4ekh645r57ajn3rq7pzi7qmxlnvg@56dov3itxoie>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <elejp25mi7fwrhoavwrxsp4ekh645r57ajn3rq7pzi7qmxlnvg@56dov3itxoie>

On Wed, Sep 24, 2025 at 09:27:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 22, 2025 at 03:06:57PM +0200, Niklas Cassel wrote:
> > On Sat, Sep 20, 2025 at 09:04:01PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Sep 19, 2025 at 03:16:47PM +0200, Niklas Cassel wrote:
> > > > Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> > > > This is sufficient for pci-epf-test to not allocate backing memory and to
> > > > not call set_bar() for those BARs.
> > > > 
> > > > However, the host side driver, pci_endpoint_test, simply does an ioremap
> > > > for all enabled BARs, and will run tests against all enabled BARs.
> > > > 
> > > > After running the BARs tests (which will write to all enabled BARs), the
> > > > inbound address translation is broken.
> > > > This is because the tegra controller exposes the ATU Port Logic Structure
> > > > in BAR4. So when BAR4 is written, the inbound address translation settings
> > > > get overwritten.
> > > > 
> > > 
> > > BAR4 or BAR0?
> > 
> > BAR4.
> > Just because a BAR is marked as BAR_RESERVED does not mean that the BAR is
> > disabled. Hence this patch.
> > I can make this clearer in V2.
> > 
> 
> First paragraph says that BAR0 is marked as BAR_RESERVED, and here you were
> saying BAR4, hence I asked the question without cross checking the driver. Now,
> I checked the driver and I think you mistakenly said BAR0 instead of BAR4.
> 

Oops.. I misread it, actually. All fine.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

