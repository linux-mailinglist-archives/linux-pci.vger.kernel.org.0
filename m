Return-Path: <linux-pci+bounces-36650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC4B90540
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF857ADDFE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776D2FDC3C;
	Mon, 22 Sep 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKJGz7DA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D9192B66;
	Mon, 22 Sep 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539870; cv=none; b=kHidg+N7aKqaT/i7hsvQHGiS2c9wbNJ4d00W2Iqe4s2fL7AJVOv6uqiAZ3t8Y5dcSuVjUn5YyLV6e5SwUYbeet7YmoYo3ijNfgU7AQdsDcq96EnKiTSrH+iv0YfaXEAMMXaBD+jeppE6x4Lk1YBiap/oS52hWTz9uwXIjTeQlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539870; c=relaxed/simple;
	bh=P/WkZtU1feRYKGYIu/69vRBdYK8dAJ5LkCF7pU4LxlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEs9pedC4MMpAfQt6ic+0y2rXXF6pPcmc7meoSegZ6xs+7vMpvcrkc6JeQMKGIOCabT8rXt/a8/WQDERLBq/qTKxf0l6Syy8nPkm+TUJdNMN/p6fr1b2GfIbI+mBeIVKURARYKTYfECm+SXwE5opmLpAoiVXhFokLE1e3JLatNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKJGz7DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E89C4CEF7;
	Mon, 22 Sep 2025 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758539869;
	bh=P/WkZtU1feRYKGYIu/69vRBdYK8dAJ5LkCF7pU4LxlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKJGz7DAwj69nbNV0Rne3G36MBMl3WicbxYo6d7/PZP9HsdCs9jzrSchd9/jHIKqh
	 eC2bZZEHCsGN4N4ZjON/bMrnCwOhqa0Os1N7KJWuMjSw+XaigO4bNnPP29mIoyGd3+
	 7F3hGlAzdzUOX0U1gYbhMMaEGa0tDc/aQuhAs7hz7pJe2DJhVHfiseVb88nyqnfL3J
	 oAjYyS3B2+9/8BOmeNggh52hqwFR1obtXc3pkg/gGB4Zc0JcV2tc1rgT96yL5RiGN3
	 Tekq60Op8YyvRVW4fusY5YxcIylwCl8inJOMdsraDdJTZflRMrJi11D9bDCTifMqOI
	 hPpMTm27c61NA==
Date: Mon, 22 Sep 2025 16:47:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	quic_wenbyao@quicinc.com, inochiama@gmail.com, mayank.rana@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, shradha.t@samsung.com, cassel@kernel.org, kishon@kernel.org, 
	sergio.paracuellos@gmail.com, 18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Message-ID: <qdz2d57q3hyosmvh7xzxy2qdhpjyxkl2mh6dr4or4nj4qakpoh@gg6ihzpaynst>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
 <175852954905.18749.5091036983349477093.b4-ty@kernel.org>
 <3sjuplupmdoxqhyz2i2p4he5vw7krqokixoy6ddoiox6p536n6@xzfcyhwjx3hv>
 <590d183c-8971-4728-9aa3-4e02bd3d0845@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590d183c-8971-4728-9aa3-4e02bd3d0845@ti.com>

On Mon, Sep 22, 2025 at 02:55:05PM +0530, Siddharth Vadapalli wrote:
> On Mon, Sep 22, 2025 at 02:02:43PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Mon, Sep 22, 2025 at 01:56:08PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > On Mon, 22 Sep 2025 12:42:12 +0530, Siddharth Vadapalli wrote:
> > > > This series enables support for the 'pci-keystone.c' driver to be built
> > > > as a loadable module. The motivation for the series is that PCIe is not
> > > > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > > > does not need to be built-in.
> > > > 
> > > > Series is based on commit
> > > > dc72930fe22e Merge branch 'pci/misc'
> > > > of pci/next.
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
> > >       commit: c514ba0fa8938ae09370beecb77257868c1568a7
> > > [2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
> > >       commit: db9ff606a5535aee94bf41682f03aba500ff3ad6
> > > [3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
> > >       commit: 76d23c87a3e06af003ae3a08053279d06141c716
> > > [4/4] PCI: keystone: Add support to build as a loadable module
> > >       commit: e82d56b5f3844189f2b2240b1c3eaeeafc8f1fd2
> > > 
> > 
> > I just noticed the build dependency mentioned in the cover letter after applying
> > the series. This is problematic since there is no guarantee that the dependent
> > commit will reach mainline first. So if this series gets applied by Linus first,
> > then building this driver as module will break the build. We should not have the
> > build error at any cost.
> 
> As feedback for the future, is there a better way that I could have
> highlighted the build dependency? I agree that a build failure is
> unacceptable which is why I tried to highlight the dependency, but, it
> probably wasn't the best approach to point it out by mentioning it in
> the cover letter. Please let me know if I could make it easier for you
> and other Maintainers to notice such stated dependencies.
> 

Mentioning the build dependency in the cover letter is the right thing to do.
But somehow I failed to spot it as it was not highlighted enough (just for my
eyes).

Maybe you could mention the dependencies under a sub-section. Like,

Dependency
==========

Some people also mark the patches as DNM (Do Not Merge), but that's for patches
not intended to be merged as is. Not for this series though.

Anyhow, I take the blame of not going through the cover letter properly, but you
did the right thing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

