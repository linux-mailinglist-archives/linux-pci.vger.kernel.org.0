Return-Path: <linux-pci+bounces-43604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254CCD9F40
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A853014138
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF1293B75;
	Tue, 23 Dec 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPCWgb5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C32773C3;
	Tue, 23 Dec 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507243; cv=none; b=SJZ1ikMUCBUcqORyfgBUruTCZn7GOPvqLuflEGI2DJz1IBQ2T2M/b7w/6/gibooaNiPsbJsb9IbyEr92PtBC6EiynLF8C4gnkpfF8Hd4bSkusyuRV20NR/02vGynFiTwaiZR2Yg69k5RFtD7DG866IHaj0Ha1W3qbzBjwvt4M7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507243; c=relaxed/simple;
	bh=+rAjVS/FZUEAz55yzrpVpFDFVO48Hb8odyG8xVSIiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe4RekCv5je7SGjcwGBdfyZKFcoDgTGNT+qQC6dzn/8Ly/Xn1NjV00yhjcH0m5QsSHaou/ocZMxAL2ekLKEQbcWOzHe26Z7oFFyRJYon3LFp9z5s22FQudKbEKpcTWjUJ+V3yjfc+SKNCLfz4fAaoeWhzuE2P4VhPDARmHYxX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPCWgb5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769E2C113D0;
	Tue, 23 Dec 2025 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507241;
	bh=+rAjVS/FZUEAz55yzrpVpFDFVO48Hb8odyG8xVSIiK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPCWgb5Wkq8OztthytEeJjBkP5PnhGzGNtNrDzCvr4x9tSZ/lMNZunmEBl76G5uwg
	 K2aocaBvOLzNawAFrr4IIAgxFDmCQWZ7v0bGpPPHFK9R+cate62VB6+sTyMMqEwrqJ
	 HXfapzUEpPwiQkZZwGmyaMy7nCwf3tjZckZYZqPuPj2HkY02cpZ3bHVCbmcGA+jK4h
	 1MJvYZ58/+PXsTTciZpasbGidNTJqXD5jmYOMXOiiTpkcZhqHyRDCJAqdgJyTDtfO6
	 WbajMxgiNf8wleMHUG4+Nnmhj3XTCNOutlvaz/oynLnpdFdsDudBEAijJd8sOwoK2o
	 PvZueinScPtbw==
Date: Tue, 23 Dec 2025 21:57:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Cadence: Avoid possible signed 64-bit truncation
Message-ID: <racdnvit3j2plo4v3c3liz55ocbr7irofl2cgglvfltanxa54m@bebkiecxrrlj>
References: <20251209223756.2321578-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251209223756.2321578-1-irogers@google.com>

On Tue, Dec 09, 2025 at 02:37:56PM -0800, Ian Rogers wrote:
> 64-bit truncation to 32-bit can result in the sign of the truncated
> value changing. The cdns_pcie_host_dma_ranges_cmp is used in list_sort
> and so the truncation could result in an invalid sort order. This
> would only happen were the resource_size values large.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to pci/controller/cadence!

- Mani

> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index fffd63d6665e..e5fd02305ab6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -414,11 +414,19 @@ static int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
>  					 const struct list_head *b)
>  {
>  	struct resource_entry *entry1, *entry2;
> +	u64 size1, size2;
>  
> -        entry1 = container_of(a, struct resource_entry, node);
> -        entry2 = container_of(b, struct resource_entry, node);
> +	entry1 = container_of(a, struct resource_entry, node);
> +	entry2 = container_of(b, struct resource_entry, node);
>  
> -        return resource_size(entry2->res) - resource_size(entry1->res);
> +	size1 = resource_size(entry1->res);
> +	size2 = resource_size(entry2->res);
> +
> +	if (size1 > size2)
> +		return -1;
> +	if (size1 < size2)
> +		return 1;
> +	return 0;
>  }
>  
>  static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

