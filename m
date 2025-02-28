Return-Path: <linux-pci+bounces-22615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB478A4919C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 07:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831BC18838F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCB23DE;
	Fri, 28 Feb 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKaQRJM/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217811AF0CB;
	Fri, 28 Feb 2025 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724466; cv=none; b=UR9SXvF4C1x8YWGQ8DHZEagwLOzt31P28WRxuXjfulaVgFLL8isc34VIBd5q+nKaWyt3pO6AstHE1Y1JE2a3/IXj/yB65SIZC65+Z8Zdfzpqb1TCrPRjUkHPSsbS2mTVgPG8Y7rkenc3TX9iCQF+bGk55eKaYXJNvNlr0DZJL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724466; c=relaxed/simple;
	bh=rzVgtvY1SM56HqPtFVnZDRtqos6uI14mQmNqWNQKwKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEq2uUyvmS32soTXQmh8eiBO/dMlxVg/8a8pHVUeuurKraXBMygmzHxMNrt/SXR17fKqiGz01PyLDq6bC6TAiRHrIwMw/Hh/45Chi9FgLFKUbQdBKz1B1vyN+CwAuOC+kTXOVTkxh1NiobsK3S9xofBgowwu8rLCHfoKcfLafbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKaQRJM/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e895fd83d3so12578606d6.3;
        Thu, 27 Feb 2025 22:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740724463; x=1741329263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyxvtTDvP2i08pzEmArBnEwNU9XeUSRwTgWHm1HVVpw=;
        b=WKaQRJM/OPYwCT1WTykaL2W94szVg7ZtbGY6GNtiE40ggTJ+EyfUD5A9sAxifZBHIY
         17aCFbOWfXqvG5hWwJWFOUtzwlEGPJMeoghZHRhqjao/hckU4MFzOB8e8hsv05I3VhFh
         UbZ0hI3yTqYINFvNOJ9jFjcm/f5Xn87ZRj9kgbPjprSngpdf0mJdbG5jYFBL33Lxfelj
         f0Yn/i5niRy3Axpfe0OYOjb1wuqWAZY98f+YWudeLbO0Jtk2PR7GUTW2cwmRliNnJVCd
         yEbYocdv4dualPOlN4UFUlOAKy1lzs4Eo9bLMVl/Y+i7q7DKLUAymCPRD5/O1Gxi3MOe
         JStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740724463; x=1741329263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyxvtTDvP2i08pzEmArBnEwNU9XeUSRwTgWHm1HVVpw=;
        b=CGj0TVW9Fr59Mzy2UsFt+Q62dCUEZtfcjzmjPeJgYEkCjWbavQ1hL2lhZKirpce9A+
         x9SHhb5hM7sy/oGr4pwVQzdol39zu0Cz6H056pcKTeU9czcmlb1rkJQzBGI+Bs4QYEMm
         ciQMtfXnLFVC+ZoGzrwNFEWpfwuBUgf3dx27956X3BICyJVRMI2szDWJp97dqabecl2D
         qUQCrj5uAddaN4iGU8uf5HrW6pQyLCpjHm8PcOBHlM9qhJXwO5uMPOVnndZZGyiV6kgH
         jU4aomIO+ALZ4MOIWiekrDGy6PEXkAufDp/MDR44aIQCxFgrVmAs3N1zBGY8lcdFZ5fv
         1KiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/nJep+6z+Hv4UwT0kMg52GM/PW7oSpGIERkSbJXflpdantwzivncNJgRO6a7zllkGqKlcNUSZTovG@vger.kernel.org, AJvYcCVM+BPGwbBQE7NmamocCaBqUA4e5ha7sZt2uxXzCAJTL15flQQFASnN4LbjbQmLJiE+7Lw+5qEiFMkgesbe@vger.kernel.org, AJvYcCWlikvS8Bx9VAu3SN1rpS/lusYwxfQZYWzUXSIQu2odViWk1HNdsk6Jl1qldpEWBIQVCCoT0uBGohyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0ARtaIGsEfEbWWEr5b+T4EfJrPhSucf7S22/aCyCZhb7ZHHD
	7ZTABiaUpbdR2kFIphahZq/S28WpOs/sGw5ot/tTTNsAbqqTQrya
X-Gm-Gg: ASbGncuKObwC1apgW8BgbbJbrHF2D3Rt3nxUL1JoHKBWvLzkMJJe3O+8x5/MGv6Y59H
	fjK/cHp7ig3RNVXHde5oBdNPAMxwL745dqj2t8ilvA748SE/PEIVPzpU/HjUqPGJsIlLL0b3PiL
	Xqv2IHqzxU9mVymsU5+H5XgHsFHBeUdYwHJMNxADHMsZonXfnYIdW9p8VQolN+77VoPcEi+kNE3
	u0GeY4wnvY2Enw5rJwGMwJY0pe+GoakCsvEBSqLIajJL/7DyDeMYkulGgkgJk6ec3sbKV+0lWnT
	Qw==
X-Google-Smtp-Source: AGHT+IGISZX5hCGeBtad2Mh3HcBYPIE/9ril4UARwLS+NFYZNru7HfBxGLbthbXqB8fmJUSStrU7og==
X-Received: by 2002:a05:6214:2687:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6e8a0ad8ff5mr42554456d6.0.1740724462935;
        Thu, 27 Feb 2025 22:34:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472409ac2sm21028501cf.58.2025.02.27.22.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:34:22 -0800 (PST)
Date: Fri, 28 Feb 2025 14:34:00 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Niklas Cassel <cassel@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-lapel-unhappy-9e7978e270e4@spud>

On Tue, Feb 25, 2025 at 11:35:23PM +0000, Conor Dooley wrote:
> On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> > On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > > > > The pcie controller on the SG2044 is designware based with
> > > > > > custom app registers.
> > > > > > 
> > > > > > Add binding document for SG2044 PCIe host controller.
> > > > > > 
> > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > ---
> > > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
> > > > > >  1 file changed, 125 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..040dabe905e0
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > @@ -0,0 +1,125 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > +
> > > > > > +description: |+
> > > > > > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
> > > > > > +  PCIe IP and thus inherits all the common properties defined in
> > > > > > +  snps,dw-pcie.yaml.
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: sophgo,sg2044-pcie
> > > > > > +
> > > > > > +  reg:
> > > > > > +    items:
> > > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > > +      - description: iATU registers
> > > > > > +      - description: Config registers
> > > > > > +      - description: Sophgo designed configuration registers
> > > > > > +
> > > > > > +  reg-names:
> > > > > > +    items:
> > > > > > +      - const: dbi
> > > > > > +      - const: atu
> > > > > > +      - const: config
> > > > > > +      - const: app
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    items:
> > > > > > +      - description: core clk
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    items:
> > > > > > +      - const: core
> > > > > > +
> > > > > > +  dma-coherent: true
> > > > > 
> > > > > Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> > > > > used to indicate systems/devices that are not.
> > > > 
> > > > The PCIe is dma coherent, but the SoC itself is marked as
> > > > dma-noncoherent.
> > > 
> > > By "the SoC itself", do you mean that the bus that this device is on is
> > > marked as dma-noncoherent? 
> > 
> > Yeah, I was told only PCIe device on SG2044 is dma coherent.
> > The others are not.
> > 
> > > IMO, that should not be done if there are devices on it that are coherent.
> > > 
> > 
> > It is OK for me. But I wonder how to handle the non coherent device
> > in DT? Just Mark the bus coherent and mark all devices except the
> > PCIe device non coherent?
> 
> Don't mark the bus anything (default is coherent) and mark the devices.

I think this is OK for me.

> That said, Is the PCIe controller actually on the same bus as the
> other devices? (Not talking about the same DT node, the actual bus
> in the device)

It share the same bus with other device, but on a different
master interface.

Regards,
Inochi





