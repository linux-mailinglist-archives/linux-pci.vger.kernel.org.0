Return-Path: <linux-pci+bounces-38831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B97BF43D6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C637F4E3B40
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B121C194;
	Tue, 21 Oct 2025 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwnf0FWt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FA54918;
	Tue, 21 Oct 2025 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009736; cv=none; b=QCptGsg9BJZogyFsySmmipk8RhVrkCbx3ZG+EmSv0zGzJ6sSiMbE5Jo1WdJ5TL8f0zZf2i4H64DlVKVtWaXBFXabB0LAZzcxc5pbjJFNVLerRdmWXWJgCI6BJjf+YqqXnFmu4sQ3ForYKF1Ul3vQx6mewH1RUFiRMFStLJeIXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009736; c=relaxed/simple;
	bh=OnEWViiPhOB58rPZCDEBcxBM8GNn8eKC8Q7NgoTqBKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRNjDbYNtO0iDqTNwcKTzeWVOtTNAaxmOGjj9D/5rqf8+06KvMZ2ppFQ6tLYps0UKGzYC+PwxBM0DaUkijG/byllZI8xu37Go49GzxJCMcCgg6KZs54KS0nQMT66mD97m0e/56Y4Mnc4VMAE1PIiKvDETnYLAAxGoV4d5iVmjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwnf0FWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267FEC4CEFB;
	Tue, 21 Oct 2025 01:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009734;
	bh=OnEWViiPhOB58rPZCDEBcxBM8GNn8eKC8Q7NgoTqBKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rwnf0FWtDxTp8uROYpn+nNwsLMTn/+2/9Zja4vGZdUvSRF9gv37jj/4ykwrJjPkmM
	 /cieUGcPiekho1qqZJG7OeMNzREvQF3lPSRQU6aMl6Aaem+BfKmE3SfUo7Nx2NmAJb
	 rl/k57+u/Ay3FqetmWhDvmTqypWIHQqaJ4cdQOKVi9L1IAV4Li4v9QrrYfhK41hA6y
	 JUV/vhptN6ypgutEpejOCL7PisUJRXVmRkjfMXdzh275bLlgYYDrhZUaFbyruKFSP1
	 r9ykW71PQfgbL+wgtvcLgP4uPoZo60u8BP7f2/0C75D0vw6OLinIjNktxr7MIiB5Ao
	 7ZvHGN/FeT+iA==
Date: Tue, 21 Oct 2025 06:52:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
Message-ID: <dscsxzccevbc2aw7wupz4bsl3rf2cyuue776pbgchtptnebnth@rwbg5bum6pby>
References: <PN6PR01MB11717CDA6EBC89511A6B567B6FEEAA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
 <20251020152738.GA1141158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020152738.GA1141158@bhelgaas>

On Mon, Oct 20, 2025 at 10:27:38AM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 10:31:22AM +0800, Chen Wang wrote:
> > Hi，Manivannan,
> > 
> > I see 6.18-rc1 is released. Could you please pick this fix for 6.18-rcX?
> 
> Mani queued this for v6.19.  Is there a reason it should be in v6.18
> instead?  We're after the v6.18 merge window now, so we only add
> things to v6.18 if they fix a serious issue.
> 

The implication of calling pm_runtime_disable() manually in the remove() path
is, 'dev->power.disable_depth' will be incremented twice. When the driver gets
probed again, devm_pm_runtime_enable() will not enable runtime PM for the 'dev',
but just decrement 'dev->power.disable_depth'.

So this will result in an imbalanced runtime PM state. This is an issue, but
the severity is less since the driver is not itself making use of runtime PM.
So the driver should continue to work fine, but the runtime PM chain might be
broken.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

