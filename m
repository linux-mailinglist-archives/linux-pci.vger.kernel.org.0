Return-Path: <linux-pci+bounces-41703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D1C7178A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E6A76242D1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2F314D3A;
	Wed, 19 Nov 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTUC2ErB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88066308F2B;
	Wed, 19 Nov 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596576; cv=none; b=s7jKbaI2X5rRIVW6sKbsKwh7Ns3+6o+p0WWyLXqz5qw90Xfhpay1O0nJ/yc2fH6zCAa4Ie11oUXSD2+h3hETD/Nspx1zU72GCz8KSdMGqHfppdtqtSJb5cqEdkTDn7F1dAms6HJKRwQPhr9jhJlsReGcpx2Br8FH1NdDviJUZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596576; c=relaxed/simple;
	bh=YzJyIUyNa6g7ZAjFAcPsOhOoHn8RMvlppRcldQWdQfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeuPY4VjZaxfqLmdrQOq17vGt5wljdwvKNPi4Y1sYxVw85NLv2hisk8/Mpd9wdA+DJZO8/Niw8Vun8kalRdJl3Ro+d+U+nqPPhy9QSCaxhkjYOBmXH8eKPkJa+gkxRqA+42oab0BHgBs3ITB/jMPErEe/UFHi1wCg8m9bRprQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTUC2ErB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD104C4CEF5;
	Wed, 19 Nov 2025 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763596576;
	bh=YzJyIUyNa6g7ZAjFAcPsOhOoHn8RMvlppRcldQWdQfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTUC2ErBUxukaTFTxlt/tQxllvksi2OpMtdRaA0wYTAv2p5O0xqbplZQL8/txxmHS
	 chET5hE7nUVW961JWygz4x5CN/OcEC1tyIyI/ESCdl5acX+3VNALfX3l6GZ+iP5xfF
	 6WKo55ie8sKgnKV8ZXYbIJtWzqPZn0fvHS3Gj7FKugZ8n0DZx4X7Qk+ADl8hgtZDY4
	 MeMB9S3P+kUKa/9zhSi5zJOVX4ILm6NyOyYaG22TvGQ/D1VyJFP6P9rGcsHW6o/7ZR
	 3q5SCrqOgvTNG7mobvnoBRGmbe9LGvvSq6WLCJXrpdVNJvl6atejUJqnm8UGnaVIEK
	 E+ZcZ4IKlAoyA==
Date: Wed, 19 Nov 2025 17:56:14 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <20251119235614.GA3566558-robh@kernel.org>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
 <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>
 <qrgaulegz2tb7yzklyl7rpkgbf6ysx44bxtyn6n3tcyq4an4e5@bzngutkvfno3>
 <5kedk7c6kc2e5j4kqeyik6i7ju54sdn6etjhpwl2vt4nq6c6ug@2yld4hpvbuzg>
 <n3efko3q7i64qmipgxz5yjeqvgmw26b4dvwofe6qnx7xqsjtx5@bbbpxmfioxrj>
 <zjwuk4mg6n5wm7yecsjv6lrwb42rpmpdtoyh2dnh23h6kr57d6@iqxvrrdgs7vn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zjwuk4mg6n5wm7yecsjv6lrwb42rpmpdtoyh2dnh23h6kr57d6@iqxvrrdgs7vn>

On Wed, Nov 12, 2025 at 10:12:36PM +0200, Dmitry Baryshkov wrote:
> On Tue, Nov 11, 2025 at 07:19:45PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Nov 09, 2025 at 10:13:59PM +0200, Dmitry Baryshkov wrote:
> > > On Sun, Nov 09, 2025 at 09:48:02PM +0530, Manivannan Sadhasivam wrote:
> > > > On Sat, Nov 08, 2025 at 08:10:54PM +0200, Dmitry Baryshkov wrote:
> > > > > On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> > > > > > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > > > > > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > > > > > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > > > > > (SSDs) to the host machine along with additional interfaces like USB, and
> > > > > > SMB for debugging and supplementary features. At any point of time, the
> > > > > > connector can only support either PCIe or SATA as the primary host
> > > > > > interface.
> > > > > > 
> > > > > > The connector provides a primary power supply of 3.3v, along with an
> > > > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > > > > > 1.8v sideband signaling.
> > > > > > 
> > > > > > The connector also supplies optional signals in the form of GPIOs for fine
> > > > > > grained power management.
> > > > > > 
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > ---
> > > > > >  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
> > > > > >  1 file changed, 122 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > > > > > new file mode 100644
> > > > > > index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > > > > > @@ -0,0 +1,122 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: PCIe M.2 Mechanical Key M Connector
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > +
> > > > > > +description:
> > > > > > +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> > > > > > +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> > > > > > +  host system over PCIe/SATA interfaces. These connectors also offer optional
> > > > > > +  interfaces like USB, SMB.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: pcie-m2-m-connector
> > > > > 
> > > > > Is a generic compatible enough here? Compare this to the USB connectors,
> > > > > which, in case of an independent USB-B connector controlled/ing GPIOs,
> > > > > gets additional gpio-usb-b-connector?
> > > > > 
> > > > 
> > > > I can't comment on it as I've not seen such usecases as of now. But I do think
> > > > that this generic compatible should satisfy most of the design requirements. If
> > > > necessity arises, a custom compatible could be introduced with this generic one
> > > > as a fallback.
> > > 
> > > Ack
> > > 
> > > > 
> > > > > > +
> > > > > > +  vpcie3v3-supply:
> > > > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > > > +
> > > > > > +  vio1v8-supply:
> > > > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > > > > > +
> > > > > > +  ports:
> > > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > > +    description: OF graph bindings modeling the interfaces exposed on the
> > > > > > +      connector. Since a single connector can have multiple interfaces, every
> > > > > > +      interface has an assigned OF graph port number as described below.
> > > > > > +
> > > > > > +    properties:
> > > > > > +      port@0:
> > > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > > +        description: PCIe/SATA interface
> > > > > 
> > > > > Should it be defined as having two endpoints: one for PCIe, one for
> > > > > SATA?
> > > > > 
> > > > 
> > > > I'm not sure. From the dtschema of the connector node:
> > > > 
> > > > "If a single port is connected to more than one remote device, an 'endpoint'
> > > > child node must be provided for each link"
> > > > 
> > > > Here, a single port is atmost connected to only one endpoint and that endpoint
> > > > could PCIe/SATA. So IMO, defining two endpoint nodes doesn't fit here.
> > > 
> > > I think this needs to be better defined. E.g. there should be either one
> > > endpoint going to the shared SATA / PCIe MUX, which should then be
> > > controlled somehow, in a platform-specific way (how?) or there should be
> > > two endpoints defined, e.g. @0 for SATA and @1 for PCIe (should we
> > > prevent powering up M.2 if PEDET points out the unsupported function?).
> > > (Note: these questions might be the definitive point for the bare
> > > m2-m-connector vs gpio-m2-m-connector: the former one defines just the
> > > M.2 signals, letting e.g. UEFI or PCIe controller to react to them, the
> > > latter one defines how to control MUXes, the behaviour wrt PEDET, etc.,
> > > performing all those actions in OS driver).
> > > 
> > 
> > In the case of an external GPIO controlled MUX for PCIe/SATA interface, I would
> > assume that the MUX will be controlled by the PEDET itself. PEDET will be driven
> > low by the card if it uses SATA, pulled high (NC) if it uses PCIe. Then that
> > signal will help the MUX to route the proper interface to the connector.
> > 
> > Even in that case, there should be a single endpoint coming from the MUX to the
> > connector.
> 
> How would you model this in the actual DT? We don't have separate
> PCIe/SATA muxes in DT, do we?

Do we have to describe it? On an x86 system, does something have to 
describe what's connected? Wouldn't you try a PCIe link and then a SATA 
link if the PCIe link doesn't come up?

Rob

