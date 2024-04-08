Return-Path: <linux-pci+bounces-5877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B189BC4E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D8E1C21ADA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DF4CE0E;
	Mon,  8 Apr 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf2meAYW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D814C634;
	Mon,  8 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569792; cv=none; b=oadqY/kZqvnvD+Lh42aQ0O3AV/+ZM01rR8SIkQ7UnAVYfMOuAdzecRBC9K5/aBUSLo/lft8irEiaBsbLI64RUo2aIOLE5C+xkxrQDPnTThEWY++1Bq6f6vNT13/VWG4w1mBJEIg6LZGBoqYSG+ii6fJ0bYig/0XoMDkm1dl+/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569792; c=relaxed/simple;
	bh=xL1SCPj347yWFVgdwNXote2UupJzfKZAH1a3FbrLt0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZBduevjYj6piioilkGyCPyTQ/dB0W1b4vHQLgWjPWPkyjjcsp+egua8S96nvqEMVsDDbmcgKm/ySDs0SwPB5eWu5AfRWCATOgimFB4A56RyVmkCgtLX946Hy5zLaJXzL52zx/uj40NnBvxo54jI7SA2aIfuynteV4ldvIHWkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf2meAYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D28C433C7;
	Mon,  8 Apr 2024 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712569791;
	bh=xL1SCPj347yWFVgdwNXote2UupJzfKZAH1a3FbrLt0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf2meAYWAM11DwJ0kDIFvs6Trkrm1Nh9eLBdYZjK4edSqgu1ZWAZumhJTxAhGqBkG
	 WtQ0TD0UUTWp3eVJp+pIWbqE5TBxTBoT3UKuCF/buV8yQ6UVwBhOXjiR6uWvyRxCeb
	 j+lc+Qq83O2Lae+A8hHGNozFermlDwy+d4PRcCaugp4+dGnuYMG7Lv1BA0KySWd0Uq
	 tsKH/cOXghoKB825UVQCIYGcsPlJVbFM56FkmGIuLHHTtqDyubDAy35dE6f88I3mn1
	 xk5wq81NQLpEEAKtM5dGqQTD2HEPxz8+c1T3IPeIJ6SDrqpQ7iyPt/WnFstUzuCTfk
	 hlGJLGyb21I5Q==
Date: Mon, 8 Apr 2024 11:49:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 00/10] PCI: endpoint: Make host reboot handling more
 robust
Message-ID: <ZhO9udfcdUrNDqQj@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <ZgvSrLpvChG4jqQl@ryzen>
 <20240403134825.GM25309@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403134825.GM25309@thinkpad>

On Wed, Apr 03, 2024 at 07:18:25PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 11:41:00AM +0200, Niklas Cassel wrote:
> > On Mon, Apr 01, 2024 at 09:20:26PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This is the follow up series of [1], to improve the handling of host reboot in
> > > the endpoint subsystem. This involves refining the PERST# and Link Down event
> > > handling in both the controller and function drivers.
> > > 
> > > Testing
> > > =======
> > > 
> > > This series is tested on Qcom SM8450 based development board with both MHI_EPF
> > > and EPF_TEST function drivers.
> > > 
> > > Dependency
> > > ==========
> > > 
> > > This series depends on [1] and [2].
> > > 
> > > - Mani
> > 
> > Hello Mani,
> > 
> > > [1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
> > > [2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/
> > 
> > AFAICT both these series [1] (DBI rework v12, not v10) and [2] are fully
> > reviewed and seem to be ready to go.
> > 
> > Considering that we have patches depending on [1] and [2],
> > namely the series in $subject, but also:
> > https://lore.kernel.org/linux-pci/20240330041928.1555578-1-dlemoal@kernel.org/T/#t
> > 
> > I think it would be a good idea if you could apply [1] and [2] to the
> > pci/endpoint branch.
> > 
> 
> Unfortunately, I cannot merge the patches outside 'pci/endpoint' even though
> these are related to the PCI Endpoint subsystem. But I have delegated these 2
> series to Krzysztof, so hopefully he'll apply it soon.

Hello Mani, Krzysztof,

These three series:
https://patchwork.kernel.org/project/linux-pci/list/?series=836730&state=*
https://patchwork.kernel.org/project/linux-pci/list/?series=838789&state=*

Still haven't been merged.

Considering that the PCI endpoint memory mapping series:
https://patchwork.kernel.org/project/linux-pci/list/?series=839970
conflicts with both of these series, I think that it would be nice if the
two fully reviewed series above could get picked up.

Right now, I think we still have time to get the PCI endpoint memory mapping
series fully reviewed to live in linux-next for 2 weeks before the next merge
window opens, but time is running out (because of delays for what appears to
be no apparent reason).


Kind regards,
Niklas


P.S.
It would also be nice to see:
https://patchwork.kernel.org/project/linux-pci/list/?series=838545&state=*
getting picked up.

