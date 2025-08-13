Return-Path: <linux-pci+bounces-33936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E351FB2445D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BB21647E6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B72EE261;
	Wed, 13 Aug 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJSSqQj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F423D7D3;
	Wed, 13 Aug 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073915; cv=none; b=anI31SbuxP/QcsFoR+nI7wHxYTamHqpFc/C7llyuUArs/CSl1T+AXUMR7OqMu5SvHMhezYEsYbLBtCaw39EfvBeeTmEKcffTX3bjNPk1DWhTwcXZn8IhE21Ow2WdrvpDEZHsVlRt7vTXTS2T4lEyDIkdh7Rvlw4k7gmNreHIbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073915; c=relaxed/simple;
	bh=w8NmJx6WPqJX1rzLR53NqwVoXQxk6tqXHqjADoSUEQU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rXs0YYOLkRk3TAon4gy6YHNo8eQPaOBeWqJN9rlRe2O+o1vzZp6ByLSe7o5yqW9hiohx/rhmjk5pATZtmvcCGAq3k/AFztNYCLodxZkZtB/Po/PJy4dwaUxr9r425QBnZRIMwQOy5Ky05GxNOxQ0FzIm4n1Ideu87BUpzmnGIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJSSqQj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2603C4CEEB;
	Wed, 13 Aug 2025 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755073914;
	bh=w8NmJx6WPqJX1rzLR53NqwVoXQxk6tqXHqjADoSUEQU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FJSSqQj7UVoY7V+Axqj0q39xO3O6DWmWC1e9zkudkzVY39HMRQa24X4B6yrIVNT6b
	 APHM5pTWPjOXe84Dt/At8TmZ2mUhj3aJxlx4MryQfcLmCKodeVhhLRqKpJYdQWSOTh
	 AzINEhQXYz3jWlUwaydThgSHT8JcmEEPpmgUhltxbswZKn88gRMtmtZmNmFi/EzA3a
	 eJorn0nzc7AFK5rEUXvHQa9UfNH9MkfN+JAhDccqUa85OheqmKJPfNKaV08yXSWUZ4
	 d5MiPI2vqr10Xp+X8hd9dPfTQ6AhqSn10T1hcW3lRhPF6H4zsaCyWG9IOQXkPmir23
	 Ks+q1xx7MOeyA==
Date: Wed, 13 Aug 2025 03:31:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mpillai@cadence.com, cix-kernel-upstream@cixtech.com, 
 lpieralisi@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, linux-pci@vger.kernel.org, mani@kernel.org, 
 kw@linux.com, kwilczynski@kernel.org, krzk+dt@kernel.org, 
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com, 
 linux-kernel@vger.kernel.org
To: hans.zhang@cixtech.com
In-Reply-To: <20250813042331.1258272-9-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
Message-Id: <175507391391.3310343.12670862270884103729.robh@kernel.org>
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings


On Wed, 13 Aug 2025 12:23:26 +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813042331.1258272-9-hans.zhang@cixtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


