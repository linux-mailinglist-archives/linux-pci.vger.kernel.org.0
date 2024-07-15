Return-Path: <linux-pci+bounces-10303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4361931B2E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2187B1C21D05
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD313A404;
	Mon, 15 Jul 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3xxMCtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2F13A3E8;
	Mon, 15 Jul 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072586; cv=none; b=mqnjYMhJVuwirVJCdFNmuvEPAdMK6iNG1YauBTvvg2UoCdz5HCpA+aEbD2LdMpgFSeRcTRm9jEHPOJFzligviIeOFTTZmC8QqdagxpgnOlLWQqoTovoGkxw3Bnjoq5VcYPkkMcNASo8YTWYRCi5y8YLHhti/7PMVmakxM0mNlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072586; c=relaxed/simple;
	bh=6OkqtEtdcylF98rnSlcz396nviq1dQ0ZNpnbmb7x5fc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TrqVrcQE7t1hx9qdm0G8NBJlJeLL52ZIgEqykgpIhtnDn5pJy8XlSPFWbqgeh2kBknIE3aFdczKbJIa9+oMtnRRx8ksfE2szdz2tsB72ifmv1qTo1v9+e5xgkGQuj0e5ukoJmBYYfosZUXxk03lGS3eXXF9Qd08jhNhFluaVjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3xxMCtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC4C32782;
	Mon, 15 Jul 2024 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721072586;
	bh=6OkqtEtdcylF98rnSlcz396nviq1dQ0ZNpnbmb7x5fc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f3xxMCttBoHZdrpU38m1eG8q1D5J1WzyI3ueTDFnZvFyXE+3TERapwl9n/i5HZG9b
	 YvGDCQy6Xd480+rQP8nOvO0JhQCocABehkK6sDclzkaRoUCJtqHw3m7PwDBuqzc3Jc
	 +Q/ws/gxPGSgfeh/SWR7+sRHi2GZNL8V91Hk8UkIefz6hI0ptVEcu8mu4UYAfbYxY1
	 5IiWTLghjR5N3a6Sxp2sjko4XSuFi1eapdk7bH8xyOHPqAVkTBj8ChgIQJviOS80jV
	 0Hcx9PjnKlLhNf63GpZ8xBZ/UYwov8eBApCXIBp+JzZR9ui2EtZM9qsV2HCZXbDobj
	 zjIEA36wlzzUQ==
Date: Mon, 15 Jul 2024 13:43:04 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: krzk+dt@kernel.org, vidyas@nvidia.com, thierry.reding@gmail.com, 
 s-vadapalli@ti.com, will@kernel.org, linux-pci@vger.kernel.org, 
 Frank.Li@nxp.com, marek.vasut+renesas@gmail.com, jingoohan1@gmail.com, 
 conor+dt@kernel.org, cassel@kernel.org, quic_nkela@quicinc.com, 
 quic_nitegupt@quicinc.com, lpieralisi@kernel.org, 
 linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com, 
 yoshihiro.shimoda.uh@renesas.com, bhelgaas@google.com, 
 quic_msarkar@quicinc.com, dlemoal@kernel.org, quic_ramkri@quicinc.com, 
 quic_shazhuss@quicinc.com, amishin@t-argos.ru, kw@linux.com, 
 u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org, 
 manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com
In-Reply-To: <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
Message-Id: <172107258433.1308620.2636416830233013593.robh@kernel.org>
Subject: Re: [PATCH V226/7] dt-bindings: PCI: host-generic-pci: Add
 snps,dw-pcie-ecam-msi binding


On Mon, 15 Jul 2024 11:13:34 -0700, Mayank Rana wrote:
> To support MSI functionality using Synopsys DesignWare PCIe controller
> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
> compatible binding which uses provided SPIs to support MSI functionality.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/host-generic-pci.yaml:137:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1721067215-5832-7-git-send-email-quic_mrana@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


