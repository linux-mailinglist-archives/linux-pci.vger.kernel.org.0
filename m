Return-Path: <linux-pci+bounces-22933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA3A4F62E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C123AA5DC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E951C6FF6;
	Wed,  5 Mar 2025 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxUYCV07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DB1A239B;
	Wed,  5 Mar 2025 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149865; cv=none; b=an/64m+uC/5bUKmGngKasvLr9D0Q+YTNYyU1xlgyIbZZ/iu1KZK3ILz88oXjzb1ZOVDTooGVLj+snx2OoxWLE5jmey8K24LnzO1054mhRpb5LIxU3Z+PAxQfg59YUFX9qOzG15KHlP0UU6dhZStxxQ538PYhs9PN2vKVuv5AL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149865; c=relaxed/simple;
	bh=k+9U2djrv68YK/Qykvrhireqd6WhG9M7AdjIxhGTFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwVoeloX1UsMNbLQrKnd7CLqvV4238R14vdjbhyfIAqvwIHFrMksyWu09K5t+F+qctbej60NggmUMhVbfVNzCTNw86DRsj6+fU4iXWId6ib7YRcDKDlUoKWa2i+2dWjNUhrMSPbyOLoDj0f9DT7iFKIpQsKDd2eNG4IwBublkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxUYCV07; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c2303a56d6so693685385a.3;
        Tue, 04 Mar 2025 20:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741149863; x=1741754663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhrXpKwS144c42p98nTp/KcoHaTZ8dOPbT6iHsDq2Ao=;
        b=GxUYCV07VS1oBjQIl1RjWW9KqCOgOGpS8oXGK7hO6jifcRis+0BLbuPUvMQS/oYP/K
         dJKLqYFgSz3gYCYkkVPBSKe8IrkRE9sB0i4mq6w2KqM+o0fHGPnOaP2/dzBhBxFi41BX
         sUy0cFNXbEu2oJaJBZ0bKx7YsAIkEGDh+LdPlrCkNbFqS3aDPGm+OHI6MLndmrfzFd9w
         cDKdMEBk8dziYgJYb9M9wT+7NWpOCq7CyckLkbCqHLiDh5sy+36A44KVzZ5ECxEh5Vt3
         COC3E4rIT9wC04k3Rf7Hpimz3uKHwnTlhAE3RItSCi3v/tU0WDer0jZghfb9fHzcOtcP
         4ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149863; x=1741754663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhrXpKwS144c42p98nTp/KcoHaTZ8dOPbT6iHsDq2Ao=;
        b=auzLgAHbNRuhrLiwlS2Ot14qrSxSUaHHLND4FP86rP/pV/voLoFnCRjFwrQrsU+uLQ
         sNPl8H/Ab09GkI4WyGfmFKeA3+dvwcYbrf8OH/c9HvKD3M9OVTdk/YOA20+NN4ngyK1F
         /tNKL85RDF5WeKoO6pga70AZ/CRZvllgqZoOIFSAw5LNgEiVV4VGHjdYYYG4HMdHgNEn
         R4FNwOWmebFYwGl7V6U9UgTp8wE2FmszNmLGnnLh4hHQAhO7lO23SNuSOdygRbaDYJGu
         IKTUKsIWNbX18kt5r6TQ0T5vx04GoPopdw9J+9H1DF2aKr0b/E9dqdu9DLkeDP3KS/uN
         qrww==
X-Forwarded-Encrypted: i=1; AJvYcCWQjpBSLW1aSE758hPm4WgWbFzOYRJUu+OvBNtGOrdY6uODVHokdzD+5rs6czlm71RKqGKhoHLzekBu@vger.kernel.org, AJvYcCWYY5/rxmE/xvQv2P2o4m7VQ/rkLK6eHfaDcNsHcFhfYgsTpzTRaPYi7ZLcIU/Mis0cnE7VInWMEfysFo7G@vger.kernel.org, AJvYcCXH1utxKGzl1TV0r1BKn8Q4j2S7LXwRjnKq1Rphg37fSOuIO7KuBD86MHQf9zgoDadwMF00Hky8PbPU@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYzzu7khR0CH/4QQujr9KL+QUB9pFRkpdaLB+rxbf63quHH0V
	rOP9njCk7DdUVXnJfh4GtI9M/hslKbBu143W9jiQWUhzRDqV3qeB
X-Gm-Gg: ASbGnct5Mr+DNkSHYQsbU/Eh3OicLpPrCFmYEEAOL1CJ7hpmC7l6Xv0dBFU1MEeJ7GO
	vRKyMeLq8Ia7p7rNoRE+uAvbmOV6orGKhzba/NGgX8J+jRJaL7553fONfPFFoa00yYTKOHEntrG
	cv9Y3kl8Jj3SP6pekEdEyMBuNRYtWFmM8+LTF1LopT3GyIoQ25Pnam+Dsqt1aUDXp3zrYjGaIsn
	FvzOMBoyOwbWr4LNqV3ZeDQk0+GIBHDRcAh92M83dMSMx9bRdbgPedobI5bDJXy6trHGao45X9y
	MMfMXUAMuPMHRG8BCKB+
X-Google-Smtp-Source: AGHT+IH+vwPw5d9BtFzBzxswU9NO4u9DM/L9MRuhwAnolL31OGQxHT7JUwcb3wef6b2uE612tHPZkQ==
X-Received: by 2002:a05:620a:688f:b0:7c0:abe0:ce64 with SMTP id af79cd13be357-7c3d8e46593mr335671185a.9.1741149862764;
        Tue, 04 Mar 2025 20:44:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3be1f0c05sm354577285a.102.2025.03.04.20.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:44:21 -0800 (PST)
Date: Wed, 5 Mar 2025 12:43:54 +0800
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
Message-ID: <ktnqf4s4hw2o6x6ir4n5hsrvbxri5cxgjyofrl76by6fwazda3@4ejw2k7k2ush>
References: <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
 <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
 <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>
 <je4falvfemkemlvdfzdmgc7jx2gz6grpbmo6hwtpedjm7xi2gk@jr4frv3tn3l5>
 <20250303-aground-snitch-40d6dfe95238@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-aground-snitch-40d6dfe95238@spud>

On Mon, Mar 03, 2025 at 05:04:28PM +0000, Conor Dooley wrote:
> On Fri, Feb 28, 2025 at 05:20:28PM +0800, Inochi Amaoto wrote:
> > On Fri, Feb 28, 2025 at 04:46:22PM +0800, Inochi Amaoto wrote:
> > > On Fri, Feb 28, 2025 at 02:34:00PM +0800, Inochi Amaoto wrote:
> > > > On Tue, Feb 25, 2025 at 11:35:23PM +0000, Conor Dooley wrote:
> > > > > On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> > > > > > On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > > > > > > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > > > > > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > > > > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > > > > > > > > The pcie controller on the SG2044 is designware based with
> > > > > > > > > > custom app registers.
> > > > > > > > > > 
> > > > > > > > > > Add binding document for SG2044 PCIe host controller.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
> > > > > > > > > >  1 file changed, 125 insertions(+)
> > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > > > 
> > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..040dabe905e0
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > > > > > > @@ -0,0 +1,125 @@
> > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > > > +%YAML 1.2
> > > > > > > > > > +---
> > > > > > > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > > +
> > > > > > > > > > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > > > > > > > > > +
> > > > > > > > > > +maintainers:
> > > > > > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > > > +
> > > > > > > > > > +description: |+
> > > > > > > > > > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
> > > > > > > > > > +  PCIe IP and thus inherits all the common properties defined in
> > > > > > > > > > +  snps,dw-pcie.yaml.
> > > > > > > > > > +
> > > > > > > > > > +allOf:
> > > > > > > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > > > > > > +
> > > > > > > > > > +properties:
> > > > > > > > > > +  compatible:
> > > > > > > > > > +    const: sophgo,sg2044-pcie
> > > > > > > > > > +
> > > > > > > > > > +  reg:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > > > > > > +      - description: iATU registers
> > > > > > > > > > +      - description: Config registers
> > > > > > > > > > +      - description: Sophgo designed configuration registers
> > > > > > > > > > +
> > > > > > > > > > +  reg-names:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - const: dbi
> > > > > > > > > > +      - const: atu
> > > > > > > > > > +      - const: config
> > > > > > > > > > +      - const: app
> > > > > > > > > > +
> > > > > > > > > > +  clocks:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - description: core clk
> > > > > > > > > > +
> > > > > > > > > > +  clock-names:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - const: core
> > > > > > > > > > +
> > > > > > > > > > +  dma-coherent: true
> > > > > > > > > 
> > > > > > > > > Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> > > > > > > > > used to indicate systems/devices that are not.
> > > > > > > > 
> > > > > > > > The PCIe is dma coherent, but the SoC itself is marked as
> > > > > > > > dma-noncoherent.
> > > > > > > 
> > > > > > > By "the SoC itself", do you mean that the bus that this device is on is
> > > > > > > marked as dma-noncoherent? 
> > > > > > 
> > > > > > Yeah, I was told only PCIe device on SG2044 is dma coherent.
> > > > > > The others are not.
> > > > > > 
> > > > > > > IMO, that should not be done if there are devices on it that are coherent.
> > > > > > > 
> > > > > > 
> > > > > > It is OK for me. But I wonder how to handle the non coherent device
> > > > > > in DT? Just Mark the bus coherent and mark all devices except the
> > > > > > PCIe device non coherent?
> > > > > 
> > > > > Don't mark the bus anything (default is coherent) and mark the devices.
> > > > 
> > > > I think this is OK for me.
> > > > 
> > > 
> > > In technical, I wonder a better way to "handle dma-noncoherent".
> > > In the binding check, all devices with this property complains 
> > > 
> > > "Unevaluated properties are not allowed ('dma-noncoherent' was unexpected)"
> > > 
> > 
> > > It is a pain as at least 10 devices' binding need to be modified.
> > > So I wonder whether there is a way to simplify this.
> > > 
> > 
> > Ignore this, I misunderstood the dma device. it seems like 
> > only dmac and eth needs it.
> 
> Nah, not gonna ignore it ;) You do make a valid point about it being
> painful, but given you mention a different master for the pci device,
> having two different soc@<foo> nodes sounds like it might make sense.
> One marked dma-noncoherent w/ the existing devices and one that is
> unmarked (since that's default) to represent the master than pci is on?

Hi, Conor,

After some testing. It has some new problems. As the pcie
register area and ranges mapping are not isolated. It is a
disaster to figure the right mapping. If writing this with
soc ranges, the thing may look like the following:

/* this is for pcie */
soc@6c00000000 {
		 /* pcie ip register area */
	ranges = <0x6c 0x00000000 0x6c 0x00000000 0x0  0xc0000000>,
		 /* pcie vendor registes area and other mapping */
		 <0x40 0x00000000 0x40 0x00000000 0x28 0x00000000>,
		 /* for 32 bit memory */
		 <0x0  0x00000000 0x0  0x00000000 0x0  0x70000000>;
};

/* this is for others */
soc@6800000000 {
		 /* clint and some peripherals */
	ranges = <0x68 0x00000000 0x68 0x00000000 0x4  0x0000000>,
		 /* other peripherals */
		 <0x6d 0x00000000 0x6d 0x00000000 0x13 0x00000040>,
		 /* this one is for the external msi controller */
		 <0x0  0x7ee00000 0x0  0x7ee00000 0x0  0x00000040>;
	dma-noncoherent;
};

It is complete a mess. I think it is more clear to just make the
dmac and eth device as noncoherent, and use one soc bus for all.
Do you have any suggestions on it?

Regards,
Inochi

