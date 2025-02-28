Return-Path: <linux-pci+bounces-22623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5914A494B8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46FF170FB7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6D256C95;
	Fri, 28 Feb 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+F0/kZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73667276D3B;
	Fri, 28 Feb 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734454; cv=none; b=eglgmljqUx9n+rSaqoaTZ2YQdpOKIdg6BAwhxvHA3jlNqTAr399fJ/t3g+hSDD2Zirk1n1r/PuUhSGFagNmJHtZa1Yf4z7B9QTPDOjpkNcLn0IG1iWZq1tK8s+6uXCww1weYErPvPY8yo3RzL7R4lZ61pzHGFltDqK9+6DqTZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734454; c=relaxed/simple;
	bh=pT8SYiw0Jf3GK6+hkue2igSEx8l2G2tJjL2ie6IuEjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POBdjDQ/hvBHTaKeRiR2PpnrVvK+sWA8E214Z5ebjxnS8WfO9C5b/R/eLV8omObV1AxmC4tpdNF+8wQbOpRf01GJ8m6UwDSH4WpCxKjVnRXE0BDXsILVNTUaR2MGDrRJkNA/OAFj98kbGcsNRbWqw1Nk8CuMzWPFLfaoDzKqVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+F0/kZ5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be8f281714so245441085a.1;
        Fri, 28 Feb 2025 01:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740734451; x=1741339251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSPWzRvDH6bTdwnRoGnWYj88h3YoRDAMeqRglP+0iQ8=;
        b=O+F0/kZ5s7XOhs2iSn3mSNH+dN5NgQYaEmJ92W25uzhC1E0kPxTxNd5nmoXcSVahHW
         1v+Ga4QnAvsV1y48nawveYhfSFhd+GlZPP+bWsmilTSEUL+2edXCO24dvANp+SHkWIsD
         43W4EfJipKn8A2U69Kc/QDZWGu9nzNlrjT6ODGzzv30F4+sgpRTKhg0mapsglNsBnB2m
         1t+ZkqIssWHktyZH1w+LNk1BfrC18j/xY+lbgTU6BRvIARWfNw3Hy6RjDIQ2SxxP1lOL
         shmew8cW6Ya9buH6dJOMNm6fIhqQRtbaJ7XfreAkzFu45BfUAe0tiN8y9gr4RjkKfkTU
         Vr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734451; x=1741339251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSPWzRvDH6bTdwnRoGnWYj88h3YoRDAMeqRglP+0iQ8=;
        b=X/frvj0sTyQ83MZZPFtY5e5pWC+G8uoWWAzvycufvks4BY7hr+A0se7ySGH/O857Rb
         gF48uoM3x7elDwnOgA4SkooI5mTLaCBFBtkyEOdfVG64kEekwIIAS+NrmcO3/2KSV7VK
         m9pWLDqlxSnTIUBa7xhJZYl3VMUarnLEzhgDYJ0/kwNB1/I3+0XBXTpi5174BMBDzh1s
         r5iZcJISwdwLMmY1r0En6aCRtwkgCOAFzWe2JAy14t3npAJG8UVXKxzqHPgtMy3bvLuT
         AebAQ6VIl3SYnEuDKcLGM5PtsoOan1xSM3KsgsMYhg3Kjf9U04cEyYqGgbBBOpjag2mI
         Y4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV300F2X/S/ML9MAR7IlvT4KxYuDU5pe5zJBKu63eiuyBUKHAHyW/fFO9UFunDwP1y7J1ycRR93+Gd7@vger.kernel.org, AJvYcCVBGwnMMKMRvy10HXT635A28f0piWQqcfCzMyzxMGDEmjVKMYQ3/CVQjfN1/Tpgr4doH9cI6bhTFVR1@vger.kernel.org, AJvYcCX+EMF9L/iMkUJxYg2uYjN1Ak0u1LRy86v+Ea4pKDOsp6RlBJDmh9ygu+AMQLDZbSOKYrNA2fbANkmeeJme@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoYuLZiricQGHD2jHr4O6UW2fjTuVe7SChSJs73hB8xX6apkW
	tNMksKlGckPctpeEsP6jEx4z4d+groE2vuRoS4YmbWg7ojJQXzjm
X-Gm-Gg: ASbGncuVE5cOPwPU2zOlRkuaqNoS/TJ2sw2DehcuDb9wDWFvEucvH1h0n0jB94688Xn
	4F5Vwn6E8hDYXWmMp55r2J/A7jEkB/VSceCTcZ6x6/QmvjfZcpAZSTA+b/yEpeW8xwdh31d3vMU
	rDr2aAIX/e7iVH0srT+T0ou9UXLdNKiMd4i1cmWX4OaMJBuwceiLlsmbTuiJDUNY7tVWCmPbZEk
	9AbxLHDDlUQtkzsC/6BNsA3rsNYBv+QnAnqD226ANlwToOPG2kJWUWhqJ6hg4rEZJkrReRRN+VR
	Iw==
X-Google-Smtp-Source: AGHT+IGaqnCcJ7W3QzbD5/MOWmJeyOSJ3VUovHm5pxJ14O5OpxxE+BEJWbEG0JBMkkwTfQFOvIVyFQ==
X-Received: by 2002:a05:620a:44cd:b0:7c0:b714:7ec6 with SMTP id af79cd13be357-7c39c4cd13fmr388005285a.24.1740734451206;
        Fri, 28 Feb 2025 01:20:51 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c378d9fec4sm222609485a.67.2025.02.28.01.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:20:50 -0800 (PST)
Date: Fri, 28 Feb 2025 17:20:28 +0800
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
Message-ID: <je4falvfemkemlvdfzdmgc7jx2gz6grpbmo6hwtpedjm7xi2gk@jr4frv3tn3l5>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
 <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
 <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>

On Fri, Feb 28, 2025 at 04:46:22PM +0800, Inochi Amaoto wrote:
> On Fri, Feb 28, 2025 at 02:34:00PM +0800, Inochi Amaoto wrote:
> > On Tue, Feb 25, 2025 at 11:35:23PM +0000, Conor Dooley wrote:
> > > On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> > > > On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > > > > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > > > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > > > > > > The pcie controller on the SG2044 is designware based with
> > > > > > > > custom app registers.
> > > > > > > > 
> > > > > > > > Add binding document for SG2044 PCIe host controller.
> > > > > > > > 
> > > > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > ---
> > > > > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
> > > > > > > >  1 file changed, 125 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..040dabe905e0
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > @@ -0,0 +1,125 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > +
> > > > > > > > +description: |+
> > > > > > > > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
> > > > > > > > +  PCIe IP and thus inherits all the common properties defined in
> > > > > > > > +  snps,dw-pcie.yaml.
> > > > > > > > +
> > > > > > > > +allOf:
> > > > > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    const: sophgo,sg2044-pcie
> > > > > > > > +
> > > > > > > > +  reg:
> > > > > > > > +    items:
> > > > > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > > > > +      - description: iATU registers
> > > > > > > > +      - description: Config registers
> > > > > > > > +      - description: Sophgo designed configuration registers
> > > > > > > > +
> > > > > > > > +  reg-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: dbi
> > > > > > > > +      - const: atu
> > > > > > > > +      - const: config
> > > > > > > > +      - const: app
> > > > > > > > +
> > > > > > > > +  clocks:
> > > > > > > > +    items:
> > > > > > > > +      - description: core clk
> > > > > > > > +
> > > > > > > > +  clock-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: core
> > > > > > > > +
> > > > > > > > +  dma-coherent: true
> > > > > > > 
> > > > > > > Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> > > > > > > used to indicate systems/devices that are not.
> > > > > > 
> > > > > > The PCIe is dma coherent, but the SoC itself is marked as
> > > > > > dma-noncoherent.
> > > > > 
> > > > > By "the SoC itself", do you mean that the bus that this device is on is
> > > > > marked as dma-noncoherent? 
> > > > 
> > > > Yeah, I was told only PCIe device on SG2044 is dma coherent.
> > > > The others are not.
> > > > 
> > > > > IMO, that should not be done if there are devices on it that are coherent.
> > > > > 
> > > > 
> > > > It is OK for me. But I wonder how to handle the non coherent device
> > > > in DT? Just Mark the bus coherent and mark all devices except the
> > > > PCIe device non coherent?
> > > 
> > > Don't mark the bus anything (default is coherent) and mark the devices.
> > 
> > I think this is OK for me.
> > 
> 
> In technical, I wonder a better way to "handle dma-noncoherent".
> In the binding check, all devices with this property complains 
> 
> "Unevaluated properties are not allowed ('dma-noncoherent' was unexpected)"
> 

> It is a pain as at least 10 devices' binding need to be modified.
> So I wonder whether there is a way to simplify this.
> 

Ignore this, I misunderstood the dma device. it seems like 
only dmac and eth needs it.

Regards,
Inochi

