Return-Path: <linux-pci+bounces-4059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F77868263
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12CBB21D03
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98617130E5E;
	Mon, 26 Feb 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6XZ/b2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B3130E3E;
	Mon, 26 Feb 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981724; cv=none; b=aQ8w4Lqeex3D8HFsix6rle25cInVLNj7J/t5G07VnFIHxQaYpdjPU+pV3IU4EbUaXY/DV/lPxqT1x7UltasFJBEtTJewe6xJO/QZW49O8lm/NGoedkNlawQNt9lG0bggzziU1Yye7y0jiMUTMaIvuit4l41ytUKjPawZ4fzSiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981724; c=relaxed/simple;
	bh=oXPrqjv4D7Q7fzj84Tav7jY1Yd0hQh/KK5Bn9pmwA3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ao6ZodoQh3XEgccmDOnijI8NfDrLheCHyE3D9PNeQUu6y2L4rDpmBmRyA+GkE0q2lIVK8kdi+IsMjg/6U+d9zykmG2NJpDyhfsqRwv6+3IMv9r11Bb9b7q3qjCar/2mKwkrCcYDgzcm3+uVZOHKPM1lHLFydef8ibUM3jUOlNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6XZ/b2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF85FC433F1;
	Mon, 26 Feb 2024 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981724;
	bh=oXPrqjv4D7Q7fzj84Tav7jY1Yd0hQh/KK5Bn9pmwA3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L6XZ/b2xLv4h3tNDaRBIHoHAY0dEKbK1gPmdQ67XRubTqwQQ91AyFsG5xo0sgIDCm
	 1I/hzJbgVdHNyiwU3Q8cPSKOHijDkJ+g3arbjfCjPFJvQnoB8ZBYVf77QGsR3OKrUS
	 M36fVbofEV+ihQ/w7giRLTPWOWQ/b5DnQhDCAJqYSnvLJMutXrqyPo7n6JvS7tfbBd
	 uaBInLbxpK77fOy4tCGH0GmvZ/zy1FCp+G8z2wCQtgHSjgmxFCJ/7CZAb9YXWKghTo
	 t949QwvKTOjs+IDkmJaagkZx9+9Eizq49D2i9t0fvUkd49K9iWojgfjPEYCyKczi8N
	 rP53J5/ARQG1A==
Date: Mon, 26 Feb 2024 15:08:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240226210842.GA211190@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226195711.270153-1-Frank.Li@nxp.com>

On Mon, Feb 26, 2024 at 02:57:11PM -0500, Frank Li wrote:
> Convert the layerscape-pci PCIe binding document to yaml format.
> 
> Additionally, changes for the layerscape-pci endpoint part:
> - Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
> fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
> - Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' is
> required by snps,dw-pcie-ep.
> - Add an example.

Not for me to say since this would go via some other tree, but in
general, I would prefer to see this as two or three patches:

  1) Strict conversion to yaml with no additional changes
  2) Add new layerscape-ep stuff
  3) Add new layerscape root complex stuff

That makes it easier to see what is actually being added.

> Changes for the layerscape-pci root complex part:
> - Add required property: 'reg-names', "#address-cells", "#size-cells",
> 'device_type', 'bus-range', 'ranges', "#interrupt-cells",
> 'interrupt-map-mask' and 'interrupt-map'.
> - Interrupt-names requirement split to each compatible string.
> - Add register name restrictions: 'reg' and 'config'. 'config' is required
> by snps,dw-pcie.

