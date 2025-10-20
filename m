Return-Path: <linux-pci+bounces-38768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E756BF2183
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 491F43468FE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E22265632;
	Mon, 20 Oct 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVkNZ9dI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD19227E95;
	Mon, 20 Oct 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974060; cv=none; b=Te0j8Iyi01RZS7HzaV7mj2rWcTBxt+CL84vh6E19mMh4Y4WxhlAMyq0EjFIDfSxkLwuGPh8v68YAVzYcC5eeQRfel7oSImWTWnoWHu6DtgQp3MCzEKaB3QqI/nzq/tZohD0wJJG0LPth6PfXzw6NHUPG06qczYxkmukLM+MASBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974060; c=relaxed/simple;
	bh=UOpfM+xG4yaTnrf6eR2Keedi/K21Lbg5jb6dI4UbDUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wa9JdPbsYTKmXcLOTCtJntOzQtKKqr5qjOCKjq2UUEYBLU6V7m2CfRE7+k61ccuhlgTaD+u/k1DmTJkg77zCfpy4dzzMf1KaIZRgRZGKWVz3Nw5n8Q4nrG1H5hFy9H0Hr9Yg1cNN4d4Raf3qw6jvC1WVjKUaC5W9vylCAYXT4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVkNZ9dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18867C4CEF9;
	Mon, 20 Oct 2025 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974060;
	bh=UOpfM+xG4yaTnrf6eR2Keedi/K21Lbg5jb6dI4UbDUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VVkNZ9dIMG5Ele79avDBZoHpB4JF3hJigf0eAsJ3sFRgeX19nSzaCDFpss9Sx8gCi
	 YTa5W3gkgkfGghv2zrweMGVoAzo5bI+GT/sLzE0LnZHukihOxJ8vlWdBE8P4JY89zI
	 aEDSY7317tV7z0jLpXfltL505aaQHKC7nosx6BnPXfWuUY5JBMO2vPsQ70d9ehWRy5
	 p7lU/g78pSzelufO7ucOE5SV0roxWA0fYpMzDOgQ0joNQVPRJHG4Xrj/NqNS12pqn6
	 VgpSuPE8nixwAAzojEyPOR02QTFFJ+Op7YgasPGsPkULYPQ5ZWmFhCUrNF+THHPvTA
	 jW8UIUlay4GCg==
Date: Mon, 20 Oct 2025 10:27:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
Message-ID: <20251020152738.GA1141158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN6PR01MB11717CDA6EBC89511A6B567B6FEEAA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Oct 13, 2025 at 10:31:22AM +0800, Chen Wang wrote:
> Hi，Manivannan,
> 
> I see 6.18-rc1 is released. Could you please pick this fix for 6.18-rcX?

Mani queued this for v6.19.  Is there a reason it should be in v6.18
instead?  We're after the v6.18 merge window now, so we only add
things to v6.18 if they fix a serious issue.

> On 9/30/2025 8:43 AM, Chen Wang wrote:
> > 
> > On 9/30/2025 2:13 AM, Christophe JAILLET wrote:
> > > devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
> > > should not be called explicitly in the remove function.
> > > 
> > > Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > LGTM.
> > 
> > Acked-by: Chen Wang <unicorn_wang@outlook.com>
> > 
> > Tested-by: Chen Wang <unicorn_wang@outlook.com> # on Pioneerbox.
> > 
> > Thanks,
> > 
> > Chen
> > 
> > > ---
> > > Compile tested only
> > > ---
> > >   drivers/pci/controller/cadence/pcie-sg2042.c | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c
> > > b/drivers/pci/controller/cadence/pcie-sg2042.c
> > > index a077b28d4894..0c50c74d03ee 100644
> > > --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> > > +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> > > @@ -74,15 +74,12 @@ static int sg2042_pcie_probe(struct
> > > platform_device *pdev)
> > >   static void sg2042_pcie_remove(struct platform_device *pdev)
> > >   {
> > >       struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> > > -    struct device *dev = &pdev->dev;
> > >       struct cdns_pcie_rc *rc;
> > >         rc = container_of(pcie, struct cdns_pcie_rc, pcie);
> > >       cdns_pcie_host_disable(rc);
> > >         cdns_pcie_disable_phy(pcie);
> > > -
> > > -    pm_runtime_disable(dev);
> > >   }
> > >     static int sg2042_pcie_suspend_noirq(struct device *dev)

