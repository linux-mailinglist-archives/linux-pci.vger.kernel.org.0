Return-Path: <linux-pci+bounces-9190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948129149C5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA96284C45
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36FD13B58C;
	Mon, 24 Jun 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIBxER7U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40DD137C2A;
	Mon, 24 Jun 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231887; cv=none; b=ZNJG3IRqv0qmY+iC6v3CQfRfmFNaFmYe8nPYANl8RBLbJj2mUjkx56bGcbHOGtbKdCp9BGw3DOd1t8Ne7nw5sO6Kfcryxi54JIeI+Lnze9OoWdTlVEEyh5kWxJy2rYa5LKDOYqjvEU9rZukB0YCVXNyoiFZAHvWqjSEos4NyKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231887; c=relaxed/simple;
	bh=MhXPY4jkPeEgToke4ZZxebjQj4gyU5p56kP7/FrJt7A=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oljJaa4shv+jY9nc0/csLs+VD9mcYBZSrpPCg9Vs8Kaz+KQFKmMht67fOqMtBybSuP3DI6lLG8l7LlxJpbEYsOBilvtrp1OehfGK9Q1gYQSdLXf6UV7NPZbw+OXhNl87FZorlIN03WRFlU/YKjlt0Vsg18XDnj9BA9rMohVdsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIBxER7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB59C2BBFC;
	Mon, 24 Jun 2024 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719231887;
	bh=MhXPY4jkPeEgToke4ZZxebjQj4gyU5p56kP7/FrJt7A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EIBxER7Unnl7GxAws+lCzwVlzTfi+xvvaUhhkNVEleBUFCUT+qqqJXeRINkCEUerf
	 jyRJz0QCf/ymPvUCKSsY74N2dFAl8uP83Dg9Wj2PxsBLC+41qPmrVO9a0CwK2/yIh8
	 OdS7pmVLQRRcRf7DE116a43k/ROEmojOOgwtpgbiOjbuz07Mc+Kzh6+Bho4vIFKA8x
	 JwfA5vPF/uQvOlARjQAFKktC/orAzkp3rC64Mc76mcDaqk9PXgJoCTKGLJeM8NUPWb
	 yG/7mJ54dPI2kKAREvMzIdR4p06MnXE5GaEdohCJuPLdXcV8eivdCgo/5oWTEGo2if
	 7AnLuxB5016dg==
Date: Mon, 24 Jun 2024 06:24:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, bharat.kumar.gogada@amd.com, 
 conor+dt@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com, 
 kw@linux.com, krzk+dt@kernel.org
In-Reply-To: <20240624110755.133625-2-thippesw@amd.com>
References: <20240624110755.133625-1-thippesw@amd.com>
 <20240624110755.133625-2-thippesw@amd.com>
Message-Id: <171923188592.3023374.12489554300919408758.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge


On Mon, 24 Jun 2024 16:37:54 +0530, Thippeswamy Havalige wrote:
> Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
>  .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 41 ++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dts:55.31-79.15: Warning (pci_bridge): /example-0/soc/axi-pcie@80000000: node name is not "pci" or "pcie"
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: axi-pcie@80000000: $nodename:0: 'axi-pcie@80000000' does not match '^pcie?@'
	from schema $id: http://devicetree.org/schemas/pci/xlnx,xdma-host.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: axi-pcie@80000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'device_type' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/xlnx,xdma-host.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240624110755.133625-2-thippesw@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


