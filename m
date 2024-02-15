Return-Path: <linux-pci+bounces-3480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F3855DA4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2DE1C22126
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B616415;
	Thu, 15 Feb 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGAUCyMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53A14006;
	Thu, 15 Feb 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988655; cv=none; b=YTE3/nN461n1bZPutHZIMZB3OpK/5f7UV+/gf0lpb1hGOjqtp5fMbE/Y4YpSBRoeNSdDi8oC/+9KZ2lXPzgU4pcMlSO6NgvLJRuteovxQvyuUPMTXhcHg+EXMux3rOVotchJ+Pn0nxRBHFmb7BOGFPloIpiOH2MCSyY0tpOmt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988655; c=relaxed/simple;
	bh=g4fM9SmhycOvEJgP9Jk1eieBn+/gDJgMcoqee5Fq9WA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sFObyxEmqsNehazvxKDfsVBtAANAPmdt2Cy4E/ElbYNQiXUP/B8iibPVWbxcUUpfNIOMiJTHch2e37IlvovaXz+Z2VHxA9aGqUty9+NmXaidIRgVFfH4h50i//jNYsui+Q5mM7x4S/UahoQbXvSJvunx7nnGqCz0D9iFaMyfJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGAUCyMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01A4C433B1;
	Thu, 15 Feb 2024 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707988654;
	bh=g4fM9SmhycOvEJgP9Jk1eieBn+/gDJgMcoqee5Fq9WA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sGAUCyMlyiOzsLRzDnhUKucnFZ5TJq9K/8MxHfMtOZfYzeYAIfOdZf6NplX/yKjqT
	 gEs9IJS3SDU33YQj8NlD6dDC09Qvw6xkDWTJiOffGD+DF5twNR9YYJsNxbbo5qYaDm
	 zgsouqnkjTppt7OgDoHnWklsUzxRWq6U18XcK2dYee+7Zhh/Tkw9MY85e89KBwAFH9
	 md8w8kCxqHHDKHPNbIvyujagQKdWmq9boUNIL3KJaHkudFIYx9lywIsAdHYeEW+ubu
	 qD9ouTNWs3a7CJd2fGsT9/S70YdCNP0j/h3oPidY+7MRSE7RnvAYOq4+uluUVZd9Qr
	 6Lx6Cxt8pNTvQ==
Date: Thu, 15 Feb 2024 03:17:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
 linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 devicetree <devicetree@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
In-Reply-To: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>
References: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>
Message-Id: <170798865265.3193150.14017104193365362131.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Fix remaining binding
 warnings


On Thu, 15 Feb 2024 09:14:47 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This adds the missing num-viewport, phys and phy-name properties to the
> schema. Based on driver code, num-viewport is required for the root
> complex, phys are optional. Their number corresponds to the number of
> lanes. The AM65x supports up to 2 lanes.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dts:50.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


