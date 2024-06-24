Return-Path: <linux-pci+bounces-9183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98E914892
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889992826AA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3E13A894;
	Mon, 24 Jun 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxngycje"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65F13BAD5;
	Mon, 24 Jun 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228273; cv=none; b=PV5q/f3YixniEedgwCTY4w4IZH3qEV/afqQFA5qmt/4hjZVEkZjghHcLrCwtRz0pntf9DB+aFltd1XvnZUkOlakCUOAEvjhiRAeTzW0e2iB10PUymHlD4Ix/2T3F7wOSEfGUfDGQ/bPND7uUlT4X5ZXe2GQcwFPpc+9xVMzlLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228273; c=relaxed/simple;
	bh=6FG4g8WOMTlTCUG9kUMTzoYUhqGKv7txyGP6CFbyer0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=L9uPvQ5x5hpyn8KeUAMizjbEee60CmeFWbI3PqDe0VVu4coy6CBPkRfj75cp/0AbCy1PL57QSp6TeBRLQmhm1uIpwhxZioHzFAcJ4vHU/spUY4bGX0E77X2T/bz/wNGPoMI+7Eu4vFEBCHnXNVqBr64xMylJ92/tO3UDe+a3uTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxngycje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D1C32781;
	Mon, 24 Jun 2024 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719228273;
	bh=6FG4g8WOMTlTCUG9kUMTzoYUhqGKv7txyGP6CFbyer0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nxngycjevwg2xHMUjCATV/iuoYDR3PAcjTpM1UCaq4Bh1fG4oZ4mufn/b2VCVoMkO
	 Wqa6bRsEM06rBThx3GMZVmbNqTEBtiC65X+AJUZylR06uLJVykMzgQjP2KXT/BF9wE
	 HSqGkP3x7KGKebQ8fMjZhHjyu62zSj00l2SDPuY5N7jgXb6b57r0ZmRRUEKkO98VLL
	 yQZZBfCHfV1uzbrGUx3VLySK09Y11reepIWZ/YTGrIvUiRHFOjQC2LU912KFRktZOD
	 HJazIKVFFBhsyXq8ckefDl9OAmw+j3NoXcmtsthO8jFhMDrh7UOQS82GgOYue4KK+j
	 1A1SK5VJI/clQ==
Date: Mon, 24 Jun 2024 05:24:31 -0600
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
Cc: linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org, 
 bharat.kumar.gogada@amd.com, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 michal.simek@amd.com, lpieralisi@kernel.org, kw@linux.com, 
 bhelgaas@google.com, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20240624104239.132159-2-thippesw@amd.com>
References: <20240624104239.132159-1-thippesw@amd.com>
 <20240624104239.132159-2-thippesw@amd.com>
Message-Id: <171922826860.2823206.15042792370053552959.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge


On Mon, 24 Jun 2024 16:12:38 +0530, Thippeswamy Havalige wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240624104239.132159-2-thippesw@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


