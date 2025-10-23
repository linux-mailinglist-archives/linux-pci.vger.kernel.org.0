Return-Path: <linux-pci+bounces-39203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA2C036AD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197FE1AA31B1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA503824A3;
	Thu, 23 Oct 2025 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8HF2r44"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC3C2E0;
	Thu, 23 Oct 2025 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252349; cv=none; b=A18V3BlazoiSUBjIN2a6pW+bLMvdsaRJ4IqvzR2HDoVYhRNbNiMYN3dvF3mLgNjfio5TMa+ty0VZqDggUdBMafxf4K8ALEzyxvA7qgnhk30W/PsRGvVrDKoHkuUBgaqylPkgURUn54AsWj+DACQNPUO/TR7TQoHUc8pBz3PvBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252349; c=relaxed/simple;
	bh=+mP1pvM4InKqRlScVcASL4W4+e15L6r0Y16hTzd6U1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PpQzQv2fioGqErUhfdXRVhnIkAlYwg3LbYaOrzAhSpz9h0pOBBsNWWs3bZ6p2r9IOTRIesbAVHUV4VmFqU1HutWmbdgJGoE1wwrVfX3q3dLgnBIfUg5XEmaf8y3/y7KmTDMBcMOM+BM5Ru7X7CrN10CFZx6+vu5mDt3iH5bsaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8HF2r44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1926BC4CEE7;
	Thu, 23 Oct 2025 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761252349;
	bh=+mP1pvM4InKqRlScVcASL4W4+e15L6r0Y16hTzd6U1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b8HF2r44gXjOpem75sfXsYhOVaAy6VyKAljZ399LBb2twmYVfDx7uL/hUCTfw1zjj
	 MfjbryAd3zg3FyQcyj1O+cXHG5lIPySMBFIAySExphNI2nR0jCTzB5HUuNBtj76Ipa
	 mB5NjR4icOf+S4KUtw7g+CczAwqSB/dQ5VuHXxjcZvTjfc4wWvJtaaVnEPBPYeIlBf
	 7PvEVrr75ifXzP/VsVpZ0P9VPbmv0Z3RKTDm6mKKZlljgk+1T1tC1WT33j/Uq6ethn
	 U0smBQGcpEkc3kwr2HdOIa5ESoa59PqXw4GGpejuaZmhXLbVf7TO8OLDLQnKZBzckb
	 8JGCLVT8B0+AQ==
Date: Thu, 23 Oct 2025 15:45:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, pjw@kernel.org, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v9 0/4] Add support for Andes Qilai SoC PCIe controller
Message-ID: <20251023204547.GA1314904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023120933.2427946-1-randolph@andestech.com>

On Thu, Oct 23, 2025 at 08:09:29PM +0800, Randolph Lin wrote:
> Add support for Andes Qilai SoC PCIe controller
> 
> These patches introduce driver support for the PCIe controller on the
> Andes Qilai SoC.

> Randolph Lin (4):
>   dt-bindings: PCI: Add Andes QiLai PCIe support
>   riscv: dts: andes: Add PCIe node into the QiLai SoC
>   PCI: andes: Add Andes QiLai SoC PCIe host driver support
>   MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

I wonder if you should use "qilai" instead of "andes" as the tag,
e.g.,

  riscv: dts: qilai: Add ...
  PCI: qilai: Add Andes QiLai ...

in case Andes ever makes another SoC with a different product name.

No need to repost for this; just let us know your thoughts.

>  .../bindings/pci/andestech,qilai-pcie.yaml    |  86 ++++++++
>  MAINTAINERS                                   |   7 +
>  arch/riscv/boot/dts/andes/qilai.dtsi          | 106 ++++++++++
>  drivers/pci/controller/dwc/Kconfig            |  13 ++
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-andes-qilai.c | 198 ++++++++++++++++++
>  6 files changed, 411 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c
> 
> -- 
> 2.34.1
> 

