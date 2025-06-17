Return-Path: <linux-pci+bounces-29912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298ECADBFFD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 05:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04ED172506
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 03:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF61C5485;
	Tue, 17 Jun 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAcrH6Xb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7682BEFF1;
	Tue, 17 Jun 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131831; cv=none; b=fJPinA7IwjEhmlGWMcOXPHVH52yMhJjufgu9jVn9GnSwNOz9nL5tvkEuwh+3QZOTr6H+G9MZDXnW66KI3ZvaMIwDI53GShyaD1qIa1UpxMJnUUXjmn6ZdmyUqrJwkIqrs+lBxVKDrAC+cOGz/grwKiAAm8fF0FM1IIu5yzbUxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131831; c=relaxed/simple;
	bh=IVM+SBWwe+LMKFMWidQm7buxQDhFKeBN3mUZ21V7TPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPeTMlc7zpaTKuY5l9Inp49VRZV2YAt4Mtz0qZDAbjUSYg1/izB/4DsRT5psvw9qCsaDpC3FRoTaVbmzDbFo9TkkDmVDtqiOorT+Zt9DvKnVcj68BG8aNjG6pdOGFPlivxg2qW1lCmZsiE6sF3ynkNOvicoKExnfrskIvVaIo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAcrH6Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD3C4CEEA;
	Tue, 17 Jun 2025 03:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750131831;
	bh=IVM+SBWwe+LMKFMWidQm7buxQDhFKeBN3mUZ21V7TPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAcrH6XbiAwgi+V5HDUMIjbGBiQoZGczC2WI3Q6KOTaKlAMEd48zKG0fEeIUPmLyi
	 a7AzEBlj7k9gJaW3HgAlzzhCpT1UcfYr+wrM6HOmgAPB0KKkm4R5ioKZckwcQBTE0H
	 qeFqgTIFzK5t6/b260r6yViE8AzxSV+8ytzyGzRCVcUIsxC4x88fo6T84WFKktE9h9
	 ImIVeKg5goPrcFuOvOlachVs3piFEwFDU8oxEh8COOa7PwvXV34wysv+QCIPzeQJp7
	 Yizf+HBuxBCSgCcN8+gFY+OTYStn2l7Gy8OEiyMc7IH4kdtDtO9eFVnHSyIWFmsI4G
	 B41fu0bpo89MA==
Date: Mon, 16 Jun 2025 20:43:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is
 enabled
Message-ID: <20250617034321.GF8289@sol>
References: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>

On Sun, Jun 08, 2025 at 09:03:05AM +0530, Manivannan Sadhasivam wrote:
> Otherwise, the following build error will happen for CONFIG_DEBUG_FS=n &&
> CONFIG_PCIE_PTM=y.
> 
>     drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
>       498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>           |                         ^
>     ./include/linux/pci.h:1915:2: note: previous definition is here
>      1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>           |  ^
>     drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
>       546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>           |      ^
>     ./include/linux/pci.h:1918:1: note: previous definition is here
>      1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
>           |
> 
> Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/pcie/ptm.c | 2 ++
>  1 file changed, 2 insertions(+)

This is still broken in mainline.  Bjorn, can you apply this?

- Eric

