Return-Path: <linux-pci+bounces-5935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAF89DA52
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB95C1F21ABC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53632137740;
	Tue,  9 Apr 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcYfZ8Gt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259ED136E3D;
	Tue,  9 Apr 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669291; cv=none; b=YsGPipPMGWJYV3SfgWkoMPVgwZKR4O2rZJIJ+vYfYJD+zGyHznXvcM/Vn+J2Gb5ZdcIvr/TXV4NEJ77HqdYskksHEQxxcLoEu/udvSJ2JhwvDriYiTFZjYYzjCYY8PxsX3xLTcADQE6nmEf1pGR71dClzQwJfebk2epV4lnw8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669291; c=relaxed/simple;
	bh=HOJtXBcppUU+aQAwrlJyYEWKDyMaLDEV80FbFejpZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W0E5CVOnA3SaN+lW/UHStBUL7IDaX2B4zOQYFRaeGdnKaCatQAeTEzUTaYieBVUrVL2ZFVmhimRcOPLlOrj6HywKI4o6gGKbgvj8hUlFYa9y868yKTohqycgO9FKsvw98l28BcDsxlWXcqWXa/sodzcj1KkqeMRX1TF84PcHsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcYfZ8Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63163C433F1;
	Tue,  9 Apr 2024 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669290;
	bh=HOJtXBcppUU+aQAwrlJyYEWKDyMaLDEV80FbFejpZKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VcYfZ8GtK+3jrdb//TKysWx8cjqyUKp2ggTvTeFCgJwHdWOvDUCHEd4Fax/cXaWkC
	 5f+djQfIsSg5X+RI2UkYVaYNJ9tx0XyzDYYBoT9T9xVws2G8A1RNG2Vgt9KwgjeQas
	 qRUtYXhRypQXHETc7YTZTCth4xCzta0IgAWX1De+tIb3rkEWGQuK+5xtYyZ2hMHFaK
	 SuykwdtX7iY0xXLcZeyQnY62PsyEaLx/+kobCIGxivW9PojQjHaj/EopJhwDSK1jFW
	 sIifIEW2Wva6sURqrjo1zKyskCLxH224kIyH0BR3WjnTIW4wy4T8I3YzlAQTM5J2rC
	 3TsYtA2B1jmeg==
Date: Tue, 9 Apr 2024 08:28:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 0/7] PCI: dwc: rcar-gen4: Add R-Car V4H support
Message-ID: <20240409132808.GA2071934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408012458.3717977-1-yoshihiro.shimoda.uh@renesas.com>

On Mon, Apr 08, 2024 at 10:24:51AM +0900, Yoshihiro Shimoda wrote:

> Yoshihiro Shimoda (7):
>   dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
>   dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
>   PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
>   PCI: dwc: rcar-gen4: Add rcar_gen4_pcie_platdata
>   PCI: dwc: rcar-gen4: Add .ltssm_enable() for other SoC support
>   PCI: dwc: rcar-gen4: Add support for r8a779g0

Previous history for this file uses a "PCI: rcar-gen4: " prefix
(without "dwc:").  I don't think we need to replicate the whole file
path here in the precious subject line space, so "PCI: rcar-gen4: "
should be enough.

>   misc: pci_endpoint_test: Document a policy about adding pci_device_id
> 
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        |   4 +-
>  .../bindings/pci/rcar-gen4-pci-host.yaml      |   4 +-
>  drivers/misc/pci_endpoint_test.c              |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   6 +
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 272 +++++++++++++++++-
>  5 files changed, 270 insertions(+), 17 deletions(-)
> 
> -- 
> 2.25.1
> 

