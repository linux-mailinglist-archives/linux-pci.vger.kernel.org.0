Return-Path: <linux-pci+bounces-14959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E49A9332
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CE21C22A3F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F31FDFA3;
	Mon, 21 Oct 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ34JwqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791551FEFD3
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549198; cv=none; b=IRcqohbsiaUIORzmlFj6lokkmjk83EUE0ayodVgd5gwmZhlCX+VNDN5eOVikPFB2mDHzYdymVBBYn4gN1p+pB06kBOQyJH51Zt+0d6Ic3VL/NHR2dt1podFkhhiDkp0BqG0H8HMBEFZGiNQjem6QF8lW4bxMvLoEFLQjSh7DHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549198; c=relaxed/simple;
	bh=09Ijz41U47mkMumPzE+LePDz5mhm4t3mUEOYcdwRjgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p/LCVRFSkjNOa4rG5k1mz4rKQcIv+8W+TyqT9U2dWbzYNGkki/xrEdYkz459UGlrA9swD+CNW4h2zyo9Z8PRMG87XjrQks462dDxAcLnLSa6ft0LVWHtTHGt/rbvxsAAqZBajyXrYFvnQgakzF5IVucGp4JpgWy55jSjdcmlqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ34JwqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D80C4CEC3;
	Mon, 21 Oct 2024 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729549198;
	bh=09Ijz41U47mkMumPzE+LePDz5mhm4t3mUEOYcdwRjgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mJ34JwqIfCKCXnxFDk5mghtJM+v7zFIW3KoHMEiOKNeJqU5ioGciE/XcPjiX3d/nG
	 3Vk1BKh2jt147smDGR+95NZSGUvyNU4Fj8z8OKi0YiZNRW4WtQRA9b94CUjqqhFv7o
	 TJmiajTTFYa7lz8c0U16pKmFF2/L6vq94kj3ve/vzO41+SMq80ejo/v/H/7QJ0Y0Yi
	 ziXKF9N0umVLod2rLTqrujYc/UmX6Ud81xmfVeXwYsYJSHH5tKvS3TPGwDNymQhhCT
	 WgXdMKOx9zObRsoFCzDbhE3ba1L6nXhajyN+hAEhMMWmOo/ksVYJ092WFKKXoxIbn7
	 rrmBCPxd4rs4A==
Date: Mon, 21 Oct 2024 17:19:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241021221956.GA851955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>

On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> This series introduces the new functions pci_epc_mem_map() and
> pci_epc_mem_unmap() to improve handling of the PCI address mapping
> alignment constraints of endpoint controllers in a controller
> independent manner.

Hi Damien, I know this is obvious to everybody except me, but who uses
this mapping?  A driver running on the endpoint that does MMIO?  DMA
(Memory Reads or Writes that target an endpoint BAR)?  I'm still
trying to wrap my head around the whole endpoint driver model.

Bjorn

