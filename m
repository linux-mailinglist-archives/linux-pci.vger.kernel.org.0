Return-Path: <linux-pci+bounces-5532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81D8950F5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB17B25DCE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7465E060;
	Tue,  2 Apr 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWos++ge"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C860B96;
	Tue,  2 Apr 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055168; cv=none; b=JIWw4tGzFQVFsdAYcGn/DaEeKVpvsJpjd6E5xYTHyH5lc/bAn41N+947yK6pu9L0QuZA8FlXZHIr9+mhAWPfFzOWJmnEx1BCCMjkb+6h4HbnAoNa8DcRgKXJ0N3C4oBnWSn4U5HXqCmTdnjtVPrlUOqnU+/WV39FXTVEYgwRF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055168; c=relaxed/simple;
	bh=ZF82itqXoux1iUe5N+4wdpuRPbFh5wKpcsySPEhqzH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyLJhgRprWZvnlf3qvQ2qPwsiygAdMHbuYMdQwzhUDRoY2JtDmePCtAVvmllUrmI6GmDJAwC12QBLs0TAOhGCRu2794D5hgXYeBD0Tl7OKSksH56UZB2gFSbBMVOdqctNN7WNElmZHUbWhtlYaqcrTMRG3ySpki+/aUBV8iKdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWos++ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C54C433F1;
	Tue,  2 Apr 2024 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055168;
	bh=ZF82itqXoux1iUe5N+4wdpuRPbFh5wKpcsySPEhqzH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWos++gejDBmuBDJdhiV06Aeauz7TvHU2AGu4Xkm+Zqb8H8GqqHMXxNXF7f5aWTBB
	 VL9n0bYwgbLk2NPaMuwo2p/INH+zVzr/cmRW0J5p3qz8wykUjIXvzvpZP89aE/h1Ek
	 f5ZrApQLK+qXKF/Ha9JFrFtzQYDHNywSumaUa9mGzg3F+6nPK2UDm6dT5sViUnVTBm
	 O8yA/mzp0ulSSAqMd8m5Na1Js3Z4tID7qMUCxB+C4/pf1eWXlX/Nd/GD18I2YQkM23
	 ucVY0Ur4QlkMQdw6gTYvaAPHVuJqsGn90Zd6c+P1POCN0Owt8npyqy0NnIqM/OsYQ2
	 rpuu3akAXQ4TA==
Date: Tue, 2 Apr 2024 12:52:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: Make host reboot handling more
 robust
Message-ID: <ZgvjeXQgTAV0kcT0@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>

On Mon, Apr 01, 2024 at 09:20:26PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This is the follow up series of [1], to improve the handling of host reboot in
> the endpoint subsystem. This involves refining the PERST# and Link Down event
> handling in both the controller and function drivers.
> 
> Testing
> =======
> 
> This series is tested on Qcom SM8450 based development board with both MHI_EPF
> and EPF_TEST function drivers.
> 
> Dependency
> ==========
> 
> This series depends on [1] and [2].
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
> [2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Tested-by: Niklas Cassel <cassel@kernel.org>

