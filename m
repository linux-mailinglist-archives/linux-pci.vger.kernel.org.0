Return-Path: <linux-pci+bounces-40653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC56C44232
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 17:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5013AC4A2
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75B2FFF94;
	Sun,  9 Nov 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjFVkM5d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9005C96;
	Sun,  9 Nov 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705098; cv=none; b=khODiVjiUng32vlr8d1yRow8lvxBa9Rd+Ac7iXW4LZelFZQZNhZwtqnBcn4tzI41RlmuVPe7x3YL0T9Ouehjb3RApt76XIFYKD7Bm9JQo6TIpmGO/3bEdiDzos4DRvSFKrrbaC6K3cKqa0nQ4zEhGmcTrPOX8BFYTp9CSFk5kH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705098; c=relaxed/simple;
	bh=NI6YboA8JS5E8R5DZqhB6Ej/6kcnfJbcc0r0CkZyfok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpiAb5Bq3unxJhzIXtXrPDPaobQrBCllw6v/PDcv7+vis1PoYuF9JV7nJNSZxCSyoZycd+32EqGP9+cxTGeBBRczSJUMono1DBxW5U5URfKf4oYh4bqJ4I7DcgYW1giPgay/do8fl3eynqnPWsOSv8hV6Y/Dmi+q/sF3OR6D0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjFVkM5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC341C19424;
	Sun,  9 Nov 2025 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705096;
	bh=NI6YboA8JS5E8R5DZqhB6Ej/6kcnfJbcc0r0CkZyfok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjFVkM5dwPQ1+LU6/Gyv8cRk6zvs9gBLYbsCUO2a6AMcJp23CYQ38gZc6kZGZlyRV
	 Z75IZLYokWkXIUgtvvrhCKo70x5gaCb7UEMZtpkOEGqToB8tKI7VWd+/2BS1lbpar1
	 7wqC5epNF9G4fe+70Z6Jpatfo0fjAmQHtT2gySWQ2eF+aKRpAbFw91RfEYUQYRepiw
	 wsO0FxDoYrkCJPCOgAYn7ag3USyEwBdw5JjwWxOpNiW8YOweAJMyKTRRHtM7FZk+iI
	 gSkO/G03UuJsU1W4YtqGNlvhdI0M0WN1q8qIJbIIhuiZN6aT9HGF5GvMDHc9E9CT2q
	 lkqVeGDsap4Uw==
Date: Sun, 9 Nov 2025 21:48:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <qrgaulegz2tb7yzklyl7rpkgbf6ysx44bxtyn6n3tcyq4an4e5@bzngutkvfno3>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
 <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>

On Sat, Nov 08, 2025 at 08:10:54PM +0200, Dmitry Baryshkov wrote:
> On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > (SSDs) to the host machine along with additional interfaces like USB, and
> > SMB for debugging and supplementary features. At any point of time, the
> > connector can only support either PCIe or SATA as the primary host
> > interface.
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
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > @@ -0,0 +1,122 @@
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
> Is a generic compatible enough here? Compare this to the USB connectors,
> which, in case of an independent USB-B connector controlled/ing GPIOs,
> gets additional gpio-usb-b-connector?
> 

I can't comment on it as I've not seen such usecases as of now. But I do think
that this generic compatible should satisfy most of the design requirements. If
necessity arises, a custom compatible could be introduced with this generic one
as a fallback.

> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for 3.3v supply.
> > +
> > +  vio1v8-supply:
> > +    description: A phandle to the regulator for VIO 1.8v supply.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: OF graph bindings modeling the interfaces exposed on the
> > +      connector. Since a single connector can have multiple interfaces, every
> > +      interface has an assigned OF graph port number as described below.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: PCIe/SATA interface
> 
> Should it be defined as having two endpoints: one for PCIe, one for
> SATA?
> 

I'm not sure. From the dtschema of the connector node:

"If a single port is connected to more than one remote device, an 'endpoint'
child node must be provided for each link"

Here, a single port is atmost connected to only one endpoint and that endpoint
could PCIe/SATA. So IMO, defining two endpoint nodes doesn't fit here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

