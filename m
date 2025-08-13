Return-Path: <linux-pci+bounces-33990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C3B254B7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 22:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2762A9A5D41
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05ED2D0275;
	Wed, 13 Aug 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0UfULAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFB2FD7BF;
	Wed, 13 Aug 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118153; cv=none; b=LvTJ45nVFdEQe1dagIQsDzaA0Us+6rOTYoXQWAsRT1Gc9yKF1xogekcExOgJlXSVjYYVhKYUAC1yH5ZOmym/xuAo1a12QemiyFIeupZvbkYWVCDx+xfndyCvybPVuQwsVqpIfj958dZyRs9P1wvEuRklsfxUc2dvzqjpr04JBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118153; c=relaxed/simple;
	bh=En5jD+6SzXG0w35/yCAtjMw836BoYpU5e7zAqhvqenU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iWNWGUjnGyDnVLaFTEBjqesg8tLauq5+NDgSD5fFVf1GJcJTKGP+nVyvKudBNGXg/3CsdSsmf7zqDt8Ctmw7YJnnFnALeG7HXy1i8Fw///MZ5sU9dVL6fAsgWTZBYXaaOSiHaRbHL01T5jkL1EHrrUMCGl15HfDlKgrdAnqZXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0UfULAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D397BC4CEEB;
	Wed, 13 Aug 2025 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118153;
	bh=En5jD+6SzXG0w35/yCAtjMw836BoYpU5e7zAqhvqenU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=m0UfULAvPzW1UV4NWJR/KO1nIqBQWt7OIUJMvJE1kV6QoeVFj1y3pxcjcUPIb0WY7
	 FG7tzUsaBZJgrKWgndTzPRH4rSzCE4xnLP/3CgT3wVeJ5myhxowveApOV7tHNv3333
	 CtL3s0SV6W//e4Xlj69D6Kvc90C+Kdupips9YUBivVrZ3XuIyi5XUECn+XUv3aUO2G
	 XLZdZw2G0ummYwBP7Mbil+ciVKEW0aMTuens6nJJe6Jw3sjtVAECFhTjctqX4ir6qv
	 fL6YcVgoCLaClKSa5knVy4NEPetrOAIwyQXBPCJvOUq/Juyg2rebIEWBFUD/OTpJjc
	 YSndnlgEcm7hA==
Date: Wed, 13 Aug 2025 15:49:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, quic_schintav@quicinc.com, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, inochiama@gmail.com, 
 fan.ni@samsung.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
 palmer@dabbelt.com, paul.walmsley@sifive.com, spacemit@lists.linux.dev, 
 thippeswamy.havalige@amd.com, namcao@linutronix.de, 
 linux-pci@vger.kernel.org, shradha.t@samsung.com, vkoul@kernel.org, 
 dlan@gentoo.org, johan+linaro@kernel.org, kishon@kernel.org, 
 mani@kernel.org, mayank.rana@oss.qualcomm.com, tglx@linutronix.de, 
 bhelgaas@google.com, linux-phy@lists.infradead.org, kwilczynski@kernel.org, 
 linux-riscv@lists.infradead.org
To: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250813184701.2444372-4-elder@riscstar.com>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
Message-Id: <175511815210.798605.10564052572461813362.robh@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex


On Wed, 13 Aug 2025 13:46:57 -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.example.dtb: /example-0/pcie@ca000000: failed to match any schema with compatible: ['spacemit,k1-pcie-rc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813184701.2444372-4-elder@riscstar.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


