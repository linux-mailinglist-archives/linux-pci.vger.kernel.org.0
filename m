Return-Path: <linux-pci+bounces-29061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140CACF9C6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89301899784
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12D27FD4F;
	Thu,  5 Jun 2025 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuTWCTNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34327FD45;
	Thu,  5 Jun 2025 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163302; cv=none; b=R1WSFPzzRWQgmYFGYzW0mAryf2PyVyMXsb47cYJ9IpI67BMc2AJN1cHFIzKSPDiwUS7EppfvusZY7dhhWRMLuhWA8AQb8ArJ/y5iuRb6LP2FPKmgMUG1c2RaGRtIOafcrnP1Hk+CZ70DDK+oQ9z8/UgWzpogzgXOjBqs6bwp7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163302; c=relaxed/simple;
	bh=hIS2pQctSMpFIPaTq3L1zuxzZbTTneZFumBe8jVekkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+HpKZqCojp5ICcP0Mg6oP5EMUR37ut7+tIF4LePSgDnJMUIWL7WLI6oVYVyxY2dP8aGcUXVKO3I9S89wYfKIq+DhheqUAXj4Bf7ODHVv+idQIFnM5hIgubj7CO5E3H8Q491h/Dwj3shpFFHuULLToaS6vTKJmxedN1V0iOTTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuTWCTNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE720C4CEE7;
	Thu,  5 Jun 2025 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749163301;
	bh=hIS2pQctSMpFIPaTq3L1zuxzZbTTneZFumBe8jVekkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuTWCTNvhw0Qv8ZeFQeiEq6lkY864n1iROVB2/iNWkI3ajSPoxBdSWAJ+c4I0QWK1
	 LnMJMP/VRfRUF+fFTdkk2kOzj+cluF5kO++6SGxTpvEAQUP7/lEcnDO/q94sdply0c
	 dz7ZfUr5SZ5S8PEhqa1FvnnBTlYwwzgfx15boVFjqQEM/KMmSk+o/50AElgPC8TQig
	 +6IdQbf/WcBznprlXZMiPrMJ11Hj1JrlrlfD2JPWKTutdM1XYGpzjzWVn2Yni35d8V
	 0pYCBQUWwlHq9RqsAuVGbcYhAltRNSkhExMYa/li+z5wjIQzLGXTnp2vEgrMe7DgVV
	 sN/V6lJhkmVHA==
Date: Thu, 5 Jun 2025 17:41:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
Message-ID: <174916329542.3386220.14917608144191847883.robh@kernel.org>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530224035.41886-2-james.quinlan@broadcom.com>


On Fri, 30 May 2025 18:40:32 -0400, Jim Quinlan wrote:
> Add optional num-lanes property Broadcom STB PCIe host controllers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


