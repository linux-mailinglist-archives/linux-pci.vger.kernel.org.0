Return-Path: <linux-pci+bounces-40607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A664C425B8
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 04:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99BD14E2239
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860A2D1932;
	Sat,  8 Nov 2025 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+SBLtMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496825DD1E;
	Sat,  8 Nov 2025 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572114; cv=none; b=sAsGO5tkfdo5dB1P2JEe2HBRCCql5I9aafFeNzA8nhHQB3e0l0MByT7AicU5azaoRtV1D7uuHUrwGR+HliiIOExjRypx7hfq0lI2q0iNZAaKj0N7lGD0wUe9DGtet5YXKUlh3UNP9jmr2PI++YB+31xTDoJkuhDCFCjnRRRUnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572114; c=relaxed/simple;
	bh=Trogj8VamHHp9plhkDe9guXWe6JH2JI/+sIFCkZ0L9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otT8B4dcB0LEtOFayFKU+H/xzrmV8pDO+ZPJEARxyjISwXiZQ6uCOv+ofuGu1yDgAn/nhSI2deYjuAS29hlxlDitp47/vkh34iW/80EuOD5nCGpEpZouVfM/DQR38oXqEWZRXU7CjwsMbxkFFXTpXD253P6GVI0UwdUAXLO/E+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+SBLtMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21339C4CEF5;
	Sat,  8 Nov 2025 03:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762572114;
	bh=Trogj8VamHHp9plhkDe9guXWe6JH2JI/+sIFCkZ0L9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+SBLtMyyFoz+yvZCgpojZHM28OaeqVsPa4JiKI1IKoMc6Vxv0OPgn3p0A9vOx2tZ
	 qJnQGe2I4ViO3qdC5F8f4jpO5njpHOnTQuqTjyZZxbeyIt3WzUeJ/7Uu2NuKWrCAq9
	 aVN307fp1cnsaF9Fcza+7yjrMrX7etz2IXcbVt5+srG9hX79+SXP/0aHStEybHxbOE
	 rYCUHUZherovMknSiBYPJFEP8Bg23kraGugR+c/CfQ9wo9Ato/ibbtG2bOmwW6Cb5q
	 EjySuZljMKb750xbok4b0zZFGgzugo7zwEzQIkTtDR3NO1zkbhdf3wsnP/OkJkx1/s
	 cOVEAQWyTjDIg==
Date: Sat, 8 Nov 2025 08:51:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Message-ID: <g6me3bgstp7pooylyiexv3u3gg7c6v4bbxuukjsqw6avd77ki3@usokcdmyl7i6>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>
 <20251106-legibly-resupply-1d3cef545229@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106-legibly-resupply-1d3cef545229@spud>

On Thu, Nov 06, 2025 at 05:57:17PM +0000, Conor Dooley wrote:
> On Wed, Nov 05, 2025 at 02:45:49PM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key M connector. This
> > connector provides interfaces like PCIe and SATA to attach the Solid State
> > Drives (SSDs) to the host machine along with additional interfaces like
> > USB, and SMB for debugging and supplementary features. At any point of
> > time, the connector can only support either PCIe or SATA as the primary
> > host interface.
> > 
> > The connector provides a primary power supply of 3.3v, along with an
> > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > 1.8v sideband signaling.
> > 
> > The connector also supplies optional signals in the form of GPIOs for fine
> > grained power management.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 121 +++++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..2db23e60fdaefabde6f208e4ae0c9dded3a513f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe M.2 Mechanical Key M Connector
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > +
> > +description:
> > +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> > +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> > +  host system over PCIe/SATA interfaces. These connectors also offer optional
> > +  interfaces like USB, SMB.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-m-connector
> 
> Is this something generated from a standard that's going to be
> practically identical everywhere, or just some qcom thing?

This is as per the PCI Express M.2 Specification, nothing Qcom specific.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

