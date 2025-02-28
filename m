Return-Path: <linux-pci+bounces-22619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C442AA493E1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD53AC729
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADC254842;
	Fri, 28 Feb 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3LLmEsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8621FE451;
	Fri, 28 Feb 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732408; cv=none; b=ePXDNLp2orPFc3n9801Er8jsJ+vHd/60HYH/yGt0rvIT518+/mzMJuEzCORJ4yzTw/i6B+wUxYatZouWLwqTrV2OtiXo05l/vnmVzcWlYWM0+C1tNEw9xY20ThucTp+lG9vmFZBywAQorU/8yaiK5noqnWNwJeci+tzLRdIC8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732408; c=relaxed/simple;
	bh=e5m3SMRr5O4UR7zd4yFRdhL57g1VhnwFolUSg7qB4e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuslbWbNZ09h2e823c9udEL/P70TCLVwF9xtRaBOY5mtRM9CnrwiEHPALpTC9Y/xVxz2iGTGdp7Ep8eEfe8tyL+SKApm0W6fnI9NRQEWkzA6CtV+D6tqwrNiQXxT7kskdFnYwdmMomopEI5zaFR44gljdPGvZmYbQo5qIrdaWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3LLmEsU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46c8474d8daso16324731cf.3;
        Fri, 28 Feb 2025 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740732406; x=1741337206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLmHR/SpSqY6N3h+Iw3NISXuCevyPVad+x0gw7x/vBw=;
        b=S3LLmEsUnutjiNUvMewtaLnK1MtZuF8dSEByxCO+F4zme+9HlOMkBXYR2xXchkOTWk
         bxlIhZaucD/+M+H9Yy4lEDY3VD+M2ed52mMIFT29uXDc4PNuuDFf+H6HTtUAathCCev0
         w4+DrpyFSpdRmbDFf1uRZhJQMRHZCon8NlEFTw0ZJveRkZvHppxPfREiSA0ekSETgnDw
         x29kSapeEWessUfCp1f0QGrAplHtAuTuIMCAU18AxXefl/UkLaCpbatHXKy73TQ+w8bg
         KV2TcIqk+6adwdD2cch99D+6Ak1NLi3K+ZZboHaEEtG0Iv+3Pbq/qP0u4Yi4KhL1XamP
         W2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732406; x=1741337206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLmHR/SpSqY6N3h+Iw3NISXuCevyPVad+x0gw7x/vBw=;
        b=BN4xWBs/FTOluAiAxnO6hhCDWIIPK8jZMMelMfEgI9komKUpwlOZD304pxfh+50gJh
         9sRcnELyf7jd55ILXZ3R+FheJdYTwKWWWhAQrdPZYicsp6/MC/2jAZx37q/4Seqphj0x
         pREofL9/Kq6Rbz6G8eIojoHgsuVHT9kKqVJzEn73ax16+qoUjbxSExSDTfa5+jec6Dp2
         Gc5lsZILRkVzKbNbLIUNlBXu7qgsnBPAQJwur+wIpBJSkd/tzl/adMsBCza+zfFzmlsQ
         Ez0kAZlNurH6Wfrvokc3ZEEHFiUVFqcvciEkqW+5fqYn7u1V0Orzf/Wcc/Fay8XD31uB
         QOqg==
X-Forwarded-Encrypted: i=1; AJvYcCUuMegaGOFbN4kSKVmJR/5ymB0vY2QveUPnSHsZhp2xrczd4luO2y5S9p/k7PiuHhOISuH1gRzKuH0JHNrv@vger.kernel.org, AJvYcCVM/dPdyKCj04o2H+45F6h6p/kLV+6tzRi6C/3gllpn71T+pyiiqGVa6/+3tI11ikobbWS96mEQle3h@vger.kernel.org, AJvYcCXznzzx/irtucf3uoql+0BU9EdcCLNxAWNsiFVsZ9lBhGgsQvYkkNSMbKeeOxLH6FHy101eTC8OOoPr@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYPDU6cfFtRm1IBsG2w4vpaX8V0Bl9MDB+7joTKuuwhNoS6cn
	YizVcKYMiYV7ciRqzBMod8uQiv1qJrTPotGHQwajXWIcIHK+K5QI
X-Gm-Gg: ASbGnctwV6ryFPQTsVDs82mR07lPKWeK2YSgZmbRi01uBr6OZ6PuaUlfw8WBD65wBQE
	84US/Wivj5b8KEXERX9hyGoRa8pF2/o1gu1XIHkEsbanqwveymNtV3hRRoBhzviq3ieq7kd2zcC
	4giCOZDf3CER7bJwqM1UR+JJ0+ezJikStelDic6yhiPNW0W4LPgEjMT2CuPYUGJcEzk4Us4X1iK
	PuFN91Yy6Wov/wO30D23wSWFvUdj0QInWGx2Xn+fVWa9mqfby/HEWDMbMhG6J7D+1clkFSjDLco
	FQ==
X-Google-Smtp-Source: AGHT+IGlyCXuariPZPwL7PuD8T0egLT46qA1ZdYfUWGVbxZHrud8Fu7VDXUjdtaUdRLOr7L0vfkfvA==
X-Received: by 2002:a05:622a:198a:b0:472:1812:23d3 with SMTP id d75a77b69052e-474bc04ec55mr26784781cf.10.1740732405593;
        Fri, 28 Feb 2025 00:46:45 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472409ab5sm22150091cf.63.2025.02.28.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:46:45 -0800 (PST)
Date: Fri, 28 Feb 2025 16:46:22 +0800
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
Message-ID: <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
 <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>

On Fri, Feb 28, 2025 at 02:34:00PM +0800, Inochi Amaoto wrote:
> On Tue, Feb 25, 2025 at 11:35:23PM +0000, Conor Dooley wrote:
> > On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> > > On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > > > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > > > > > The pcie controller on the SG2044 is designware based with
> > > > > > > custom app registers.
> > > > > > > 
> > > > > > > Add binding document for SG2044 PCIe host controller.
> > > > > > > 
> > > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > > ---
> > > > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
> > > > > > >  1 file changed, 125 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..040dabe905e0
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > @@ -0,0 +1,125 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > > +
> > > > > > > +description: |+
> > > > > > > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
> > > > > > > +  PCIe IP and thus inherits all the common properties defined in
> > > > > > > +  snps,dw-pcie.yaml.
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: sophgo,sg2044-pcie
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    items:
> > > > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > > > +      - description: iATU registers
> > > > > > > +      - description: Config registers
> > > > > > > +      - description: Sophgo designed configuration registers
> > > > > > > +
> > > > > > > +  reg-names:
> > > > > > > +    items:
> > > > > > > +      - const: dbi
> > > > > > > +      - const: atu
> > > > > > > +      - const: config
> > > > > > > +      - const: app
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    items:
> > > > > > > +      - description: core clk
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    items:
> > > > > > > +      - const: core
> > > > > > > +
> > > > > > > +  dma-coherent: true
> > > > > > 
> > > > > > Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> > > > > > used to indicate systems/devices that are not.
> > > > > 
> > > > > The PCIe is dma coherent, but the SoC itself is marked as
> > > > > dma-noncoherent.
> > > > 
> > > > By "the SoC itself", do you mean that the bus that this device is on is
> > > > marked as dma-noncoherent? 
> > > 
> > > Yeah, I was told only PCIe device on SG2044 is dma coherent.
> > > The others are not.
> > > 
> > > > IMO, that should not be done if there are devices on it that are coherent.
> > > > 
> > > 
> > > It is OK for me. But I wonder how to handle the non coherent device
> > > in DT? Just Mark the bus coherent and mark all devices except the
> > > PCIe device non coherent?
> > 
> > Don't mark the bus anything (default is coherent) and mark the devices.
> 
> I think this is OK for me.
> 

In technical, I wonder a better way to "handle dma-noncoherent".
In the binding check, all devices with this property complains 

"Unevaluated properties are not allowed ('dma-noncoherent' was unexpected)"

It is a pain as at least 10 devices' binding need to be modified.
So I wonder whether there is a way to simplify this.

Regars,
Inochi

