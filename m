Return-Path: <linux-pci+bounces-36862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D035B9AC9D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08C217B008
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD6221726;
	Wed, 24 Sep 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk1M3oC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2164A8F;
	Wed, 24 Sep 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729476; cv=none; b=EzCsUZ2L4F0Im5CW8NbJQSZ/ouP7KbIN8M71NeQkD2fJCNgcYl8VYWHJbwwytJZMGKzS52N32xmsTdyYolU80eZItW1oxBThrcFChi1R6pyjax5xJX76mW/Qzbo9eJoxoNticx7PzMH1ka2k0HNVe7smND3UznqamaU9ztlGHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729476; c=relaxed/simple;
	bh=mz1QJIb/G8qrH8WKXceYVLJEKZaa7bTTTOH+SQLWmzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5acjcDYTEfsYIrBA3KsswWxVCPAxVfOy3iGImjRbAD1NSj8W3rFBgrKLj0khM3YWAvNbgrgNIvLn5cjYpQnjwgmAca7KuCarTjj8sOphRHG4hZPij4ozkoDsnSBX9cE9NRMJxa3dY+EQX7Dw3xTw6uLlh4n2mddfjhzLZ+ytl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk1M3oC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9D8C4CEE7;
	Wed, 24 Sep 2025 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758729475;
	bh=mz1QJIb/G8qrH8WKXceYVLJEKZaa7bTTTOH+SQLWmzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pk1M3oC/1ehI7S/MahOj7FlEqHrlmwrV7urd0XDUYUVlyhNhKABNug/uHil/1MBOg
	 zqhjEfcuD3ajqb9CDj4nInYcNoKJqqHAY1dS7sS4bYJ+KmRiHm94rutXHQx6vfstcF
	 IDOEGK+1fgPrqfNUuvo6uqxv53qFuS4z5z+QmlMuTMF62eiIxxi9va1nKN9t7nLLsZ
	 MwdM2bdciW5rViCA8phVw7GJhewtvclg+FYw72w9+QDYV+ocQccS+VV4YeMtMj0YDT
	 JdfDuDEY9+3CoGbGH+P/4Spc+4uLjXkiciTiF9JkMeo0yd8TUqLGfAaFUvLh4pT/2V
	 /mR7d9PWdRLSg==
Date: Wed, 24 Sep 2025 21:27:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint
 mode
Message-ID: <elejp25mi7fwrhoavwrxsp4ekh645r57ajn3rq7pzi7qmxlnvg@56dov3itxoie>
References: <20250919131646.167330-2-cassel@kernel.org>
 <lrox3l5cafqsom3eier6n7wpbfatlic42rxs5q5utrhg4fekls@kj3b5ue7ggt7>
 <aNFJ8awYYwxb2o6B@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNFJ8awYYwxb2o6B@ryzen>

On Mon, Sep 22, 2025 at 03:06:57PM +0200, Niklas Cassel wrote:
> On Sat, Sep 20, 2025 at 09:04:01PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 19, 2025 at 03:16:47PM +0200, Niklas Cassel wrote:
> > > Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> > > This is sufficient for pci-epf-test to not allocate backing memory and to
> > > not call set_bar() for those BARs.
> > > 
> > > However, the host side driver, pci_endpoint_test, simply does an ioremap
> > > for all enabled BARs, and will run tests against all enabled BARs.
> > > 
> > > After running the BARs tests (which will write to all enabled BARs), the
> > > inbound address translation is broken.
> > > This is because the tegra controller exposes the ATU Port Logic Structure
> > > in BAR4. So when BAR4 is written, the inbound address translation settings
> > > get overwritten.
> > > 
> > 
> > BAR4 or BAR0?
> 
> BAR4.
> Just because a BAR is marked as BAR_RESERVED does not mean that the BAR is
> disabled. Hence this patch.
> I can make this clearer in V2.
> 

First paragraph says that BAR0 is marked as BAR_RESERVED, and here you were
saying BAR4, hence I asked the question without cross checking the driver. Now,
I checked the driver and I think you mistakenly said BAR0 instead of BAR4.

> I think a better solution would be for pci-epf-test to actually do something
> like call a .disable_bar() for BARs that are marked as BAR_RESERVED.
> 
> But, implementing this callback is non-trivial, especially for non-DWC based
> drivers where we dont have an equivalent to dw_pcie_ep_reset_bar().
> Thus, I chose to keep with the existing convention of calling
> dw_pcie_ep_reset_bar() in the .init callback, like it is done for all other
> DWC-based EPC drivers.
> 

That's fine. I was just pointing out the discrepancy.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

