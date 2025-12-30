Return-Path: <linux-pci+bounces-43850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B0CE9ECC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F13B3031953
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F18230BEC;
	Tue, 30 Dec 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHrY1i2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8317A2F6;
	Tue, 30 Dec 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104565; cv=none; b=GfcR8YOIwCEQKsQiqgmZueylCW806DCVMQ5T1Ghoxs/nnSt7PghpMl1CKPzYH7UUMBz9uYLYwSCZo1K+dGIO5xLjQecJyIsWuT+qHzZxb3/bjO4K/76/gccGAh2B2mqi04ZTkeCSyMe4WIuTSczop8/o6z7QoODytm9vOvGGPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104565; c=relaxed/simple;
	bh=aDLjB01UK3jf7Dq8YDojKtYOpc32gM+BspVDOEkyfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beZz9yEyI0UdIYpltTIi2gUGr/tIfZsIix2cXBZdjrMtxAgERaapwrJxTnoinCQZvd8J2+PPBU6DKKVF0RHk9jM/F6TMxjOsSGa4qiBDYQWsi4ktfCqjH7f2Z1V1DvmoOlrnLYWSNUEQB+lzGlt+vf18vfJ6Gc1agfHON91Oq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHrY1i2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B1AC4CEFB;
	Tue, 30 Dec 2025 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104564;
	bh=aDLjB01UK3jf7Dq8YDojKtYOpc32gM+BspVDOEkyfFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHrY1i2KVVVwolDMtjU8QxJXXRcPMFsEsjLrzfH5PpSSJdKoey6Pl7NHAYgnZg0he
	 v2QjvTLKdiqY1rO2BMhRl80FNLNwdLDPkCvs+7coSSC86jcbDv0QXUCEm/paKc/sdN
	 3BsLGwVimdUKUnl0utu5kxHwp/EP0Mc3A6b8K4G1VNblsW8WEHmZUdFzwiZzWUWiuR
	 qa6G05nmL710k0W6Szg4gvQzyvRAk+l8dZhLp2WVczc+22aNadPoOxCNLIBJTdpkbs
	 b1JU79mz96+JD+buCqYxsS1n4+U4B+8PQVNdvxT6rMIC3rOxDw7zmfk/BEPcb3QHAt
	 MIVmN2kW848JA==
Date: Tue, 30 Dec 2025 15:22:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dwc: Remove duplicate
 dw_pcie_ep_hide_ext_capability() function
Message-ID: <aVPgL2AuAMpx76pI@ryzen>
References: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>

Hello Qiang Yu,

On Wed, Dec 24, 2025 at 02:10:46AM -0800, Qiang Yu wrote:
> Remove dw_pcie_ep_hide_ext_capability() and replace its usage with
> dw_pcie_remove_ext_capability(). Both functions serve the same purpose
> of hiding PCIe extended capabilities, but dw_pcie_remove_ext_capability()
> provides a cleaner API that doesn't require the caller to specify the
> previous capability ID.
> 
> Compile-tested only. Runtime testing on RK3588 hardware would be
> appreciated.

This patch does not appy on top of pci/controller/dwc

Anyway, I applied it manually, and tested, thus:
Tested-by: Niklas Cassel <cassel@kernel.org>

