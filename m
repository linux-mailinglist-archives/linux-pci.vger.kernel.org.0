Return-Path: <linux-pci+bounces-37874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B529BD2333
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB54E3B3299
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7380F2FBDE5;
	Mon, 13 Oct 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCq5UPan"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423282FB999;
	Mon, 13 Oct 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346289; cv=none; b=JrQB/AVZhLBUGNwMx7ZLQwabG/UTXm3D0DHWf/+jgmIcGkMBPtR0luFyCRMwMZSlnlWQUaiGjO7DAKVsd3NcjSOA9V9F8JG1SA76fLS4DQpIVOWh2zG3QMlauKBI7MmQgWEjxjm8XGBKdOm+vVUJ/NSiQFaEi1qVWJ0Ij3rqIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346289; c=relaxed/simple;
	bh=CYCBFJlkUwFlDxHzpd82uDa6Ga5iYGoVB4SDfOnkGAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC1qE4/fE85PBQZgPo9d584D9f2KHQmRoTphSCmEibPTz7ZUnSwm+uz+bEfkUsW4Mk0foAe5zU1icbmazkPtrCmA0WUxvZ4nIERpz8zg5pnDyFvE+q1pHyevMwadRY3j55ry5HowxcJ9XO8Jb33I0GksjttcjxZjA1oWYprwsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCq5UPan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C16C4CEE7;
	Mon, 13 Oct 2025 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760346288;
	bh=CYCBFJlkUwFlDxHzpd82uDa6Ga5iYGoVB4SDfOnkGAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCq5UPanM3/dCXoCL6CZIjFIbQL4kGEb2de1AgCZkOablhnP5OgJIhjW484Ms2knw
	 TlJF67WjCvSBjA2U5VWBJL8FuVpN0kfox7rVtNaLKN6olb/Y86MkbbRVKTlUqP4FuX
	 KkPDjkvolhnWiVg1tRaF9/Y8zbYoyO2j/TU5U7LZx5d/rc9CAC4pngGEVyOhjNswBK
	 k4JbpRZHSwK5CP3KIVqDAFeR8sg2OyCNl+z6e/9y5AL2X5WRA/Z03V/pq87yzkE2sn
	 wv3jjEfNBDfkBFXYJ0RpU2kj/egCiV3x8KJkCdkK48/6ShOpe4L64NXQPM0EADuirC
	 UA8LsCoHvQsvw==
Date: Mon, 13 Oct 2025 11:04:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v5 2/4] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aOzAqwFysJ0d5zMr@ryzen>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
 <20251009-vntb_msi_doorbell-v5-2-4cfb7b6c4be1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-vntb_msi_doorbell-v5-2-4cfb7b6c4be1@nxp.com>

On Thu, Oct 09, 2025 at 04:54:36PM -0400, Frank Li wrote:
> Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> size and memory size. Prepare for adding support to set an MMIO address to
> a specific BAR.
> 
> Use two variables 'size' and 'aligned_mem_size' to avoid confuse.

Nit: I still think this is wrong. Probably:
Use two parameters 'bar_size' and 'aligned_mem_size' to avoid confusion.

> 
> No functional changes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>

