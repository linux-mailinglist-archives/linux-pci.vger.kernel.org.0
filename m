Return-Path: <linux-pci+bounces-33951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CAB24E18
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD03B61336
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563D286D72;
	Wed, 13 Aug 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTXqYtgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932A285C85;
	Wed, 13 Aug 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099810; cv=none; b=ol6YlF/mMrLcEs//2z3kOEU0JJNI8Hy5LPp0KsCis7N1Azz7GZNLAAUmLUazOaTT/ZYmQM7vFSQtGnT+pQhy2jmHmUhxlBY5mHJ3Hqr8ifbwaMvYgKDlsV2k+6bRM+Z+iEyBn2L5kWkYGACtNihBKmpMjzyPUMHJUb1M8wVbEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099810; c=relaxed/simple;
	bh=OCVS1nKCZktGk9eJd0qFRaW2McBTaTP8gAMmGlBkVBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LieJ4hmV9+DrIap7ztfYjTMnsFW3WhEEQx0mAms5Ihh9NtSVw2kg+PZDnci0H/tGSUHi2wggVotohmjd2BbIIFtXHfug6jnRQkMH8Wt9oru1e/3TAvvtobEqM/avm8B0XoPayjYTjMT9WVm/1f27kGu023+VMwbEkKYI7+RZ3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTXqYtgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E2C4CEEB;
	Wed, 13 Aug 2025 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755099809;
	bh=OCVS1nKCZktGk9eJd0qFRaW2McBTaTP8gAMmGlBkVBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTXqYtgrHymg/AgcfavetFeRIi6t1/wDE/vuxDqfjs4YOmWgeFk0hf74GfTDM95OC
	 LQFw7XNNNJzDu0qor+FdRRSnYwqa2uxCq0dNYAHa/ypyIsHib/q43+7Ucnd5gEeHrc
	 qUmFm79ztubtjOhtbbkfJFce0/P7FEFHn4l6NWdBgflJxuquSE1kk4ghkxvlpk/PVe
	 BAPNkE4lvKncGYxeOSKktRFWmysZ+9C4aG8J+3VIRgxCwc9Zex4ApPTj/Zn/Zzy9D+
	 sV7VjCPAYowhmmJkbskc2fnVfAnclYfGrxLKE8EIGE+U54UiwVwbnGfDRoMpGxEm4i
	 67iAE+Zd+v2GQ==
Date: Wed, 13 Aug 2025 10:43:28 -0500
From: Rob Herring <robh@kernel.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: mpillai@cadence.com, cix-kernel-upstream@cixtech.com,
	lpieralisi@kernel.org, bhelgaas@google.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, mani@kernel.org, kw@linux.com,
	kwilczynski@kernel.org, krzk+dt@kernel.org, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, peter.chen@cixtech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings
Message-ID: <20250813154328.GA114155-robh@kernel.org>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
 <175507391391.3310343.12670862270884103729.robh@kernel.org>
 <cb35dfbd-2fa4-4125-bd87-9f86405983eb@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb35dfbd-2fa4-4125-bd87-9f86405983eb@cixtech.com>

On Wed, Aug 13, 2025 at 05:12:57PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/8/13 16:31, Rob Herring (Arm) wrote:
> > EXTERNAL EMAIL
> > 
> > On Wed, 13 Aug 2025 12:23:26 +0800, hans.zhang@cixtech.com wrote:
> > > From: Hans Zhang <hans.zhang@cixtech.com>
> > > 
> > > Document the bindings for CIX Sky1 PCIe Controller configured in
> > > root complex mode with five root port.
> > > 
> > > Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> > > 
> > > Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> > > ---
> > >   .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
> > >   1 file changed, 79 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'compatible' is a required property
> >          from schema $id: http://devicetree.org/schemas/root-node.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'model' is a required property
> >          from schema $id: http://devicetree.org/schemas/root-node.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813042331.1258272-9-hans.zhang@cixtech.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> Dear Rob,
> 
> I'm very sorry. No errors were detected on my PC. I'll check my local
> environment and fix this issue in the next version.
> 
> If I have done anything wrong, please remind me.
> 
> 
> 
> hans@hans:~/code/kernel_org/linux$ export CROSS_COMPILE=/home/hans/cix/bringup_master/tools/gcc/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
> hans@hans:~/code/kernel_org/linux$ export ARCH=arm64
> hans@hans:~/code/kernel_org/linux$ make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   ./Documentation/devicetree/bindings
>   LINT    ./Documentation/devicetree/bindings
>   DTEX Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts
>   DTC [C]
> Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb
> hans@hans:~/code/kernel_org/linux$ make W=1 dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

DT_SCHEMA_FILES limits testing to only the matching pattern. 
Ultimately, you have to test without it.

Rob

