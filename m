Return-Path: <linux-pci+bounces-10629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A593984A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9C51C21940
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530A13667E;
	Tue, 23 Jul 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGSAW0WN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E1E868;
	Tue, 23 Jul 2024 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701985; cv=none; b=X9EjU3AVLtRNPNmqqzY0dvZnCDsjCkal3dQULVarDH55TsSP0Q9A415jdCV5j36wO16r+Oi+8Z53LjT8sdHQwpPpLZJwRgW7Y3KRQz1UN/8bMolo/QWzQnrO3XXibZBIbzH6yAsM4LfAe7Zim7kr7b91M/fPR3Y1GtDBb0kC0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701985; c=relaxed/simple;
	bh=k1zq8RC16oOBhDBEhZsLJj2DJaTIJHhBWBaQQ4mnZsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djXZyqzie/1qYYQAWQmxE+9u7T9SzLQZaVLtNWeAvk5vQGQs0qCrOUWqpWrjtegAZ4BE+vSPXSN5kXGwKZ3K1RWItxDysbYXIEP/3kjEJYZ8vhUsaA4q88/vU4/Ag5kCOqrDCfMnXwkT7ScK5TUu0cLKPuPBtyvagNngvczxpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGSAW0WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DE8C116B1;
	Tue, 23 Jul 2024 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721701984;
	bh=k1zq8RC16oOBhDBEhZsLJj2DJaTIJHhBWBaQQ4mnZsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGSAW0WN/7LByKxqW6WGd4IoEj8rixz1lxVQuuYEjur1fuLgQFXNVNO2CuJQ+YF5k
	 NeAf5uByCquSSoM/AqW1mZZnv18VzK4iRHQ1gksoZ/BV528xKncevJ/UBCWoUd/gbJ
	 /3WiLeQ/LnltD8StM+G+GV6do4mZE7b9Euw/z4x5qDe4UjiOg2ur1j/hYPPZKak0xJ
	 sSgx45QYu1Jwf+M6OdMNd/HfV/2m4tDE6FA8/1yaPhWk23N+iV4fgvhApyXC90SY0q
	 ItR0VdS9fH4fWUs3gUJZSqTRKClvummUygfkGpSPUztC7JBtAMtg21P7nzVI6rvcJ3
	 wtVfUpxTp6ZPg==
Date: Mon, 22 Jul 2024 20:33:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Message-ID: <172170198139.181455.3270535112406829800.robh@kernel.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-4-71d304b817f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-pci-qcom-hotplug-v2-4-71d304b817f8@linaro.org>


On Wed, 17 Jul 2024 22:33:09 +0530, Manivannan Sadhasivam wrote:
> 'linux,pci-domain' property provides the PCI domain number for the PCI
> endpoint controllers in a SoC. If this property is not present, then an
> unstable (across boots) unique number will be assigned.
> 
> Devicetrees can specify the domain number based on the actual hardware
> instance of the PCI endpoint controllers in the SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml       | 11 +++++++++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml |  1 +
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


