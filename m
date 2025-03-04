Return-Path: <linux-pci+bounces-22799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509FA4D04F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 01:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35952177C4C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752B38F82;
	Tue,  4 Mar 2025 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BigGyqiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856E2B9A8;
	Tue,  4 Mar 2025 00:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048640; cv=none; b=ljFIUeZG81/d2czHdgfFNMk9JuToo5X1JHP1uvalpHRL7QDu0bTqow0FS9/KWFg1YNcrGgZttoMySTDXzkqlFjMF7M3vsNwLvHuIz5VHS525oARKV3cH3OB+TKP0TIM3UJxoM5bTCaLXl8aMPr5Sx7SfpHTekrtPhO8DiD90CGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048640; c=relaxed/simple;
	bh=8E9k0KWOxAFwiAkcfWmCZQqGYmRe+dEJGe7JMw88EFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQpGILUiSNDFcb5KmNAMIJKHIX3Hbw8k8KkIlsjBLQKaNU317nh/cMo4iHdxKoFHEDJ+AfktD8naRSS4wj3JFt1HVu+0Ab2aXuIj3jJxC93ur5yDcf6dhfl+zegAEqZebVH5pq+IIsVDZ/TOcDQ/dzYrDXhadW7nW83hExu026Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BigGyqiF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso84444556d6.2;
        Mon, 03 Mar 2025 16:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741048636; x=1741653436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkdclXu2BjEaGsp2gaaSDivFgOqo2Ctx5xrHZRDqZfs=;
        b=BigGyqiF7aRm7O6ZxxIvyXEcGQcf0+7Eko8mkHudQnRdH7lkFDD6uQIgrFN5pkRjjS
         csUYKg2143VmomrtvpgVOkBfHZgwbFiUa/VyUi72a+W/hU8ssaLnDEsTtExCMaoGpLXJ
         NsqJ+xttlklzvhaiR8OjWUi+Lo4GUuHIujWl0uSpIsLuQXB2kEpRmOGI462akj0w5J6w
         9+xxteCDJAvNOyCvcc0hl9+Pt0LYfKdVyq7QKzapHluf2cWVuDw86DyRcFybHHJYPeNz
         L7Cz7adW5CO8LmdTkSF+7xDfmkJy+RP8QEbi9kWdDhmEe7YLQnLbaL4S6d8fIYS4mXek
         pr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048636; x=1741653436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkdclXu2BjEaGsp2gaaSDivFgOqo2Ctx5xrHZRDqZfs=;
        b=VN4slf3aNR1wzMoTVWAEco65gs/D6apHwLmhCDjqMOc+P/QwjJLpnFEuKQc97G1lUO
         2KhkFb/JH5Qo0AOPjs+c/CXz3yxRRs2DYk+MI8ULNtOjXy0EQ4E0SiZ+6KQ4fRHh/F7J
         P5yPVb2eSM3Lyg9dhAh4GmCjfOF4bHrcutyEst4XeMJ8pbZZnsJZtSDxg7vV2sQK1hiv
         S8NfVk8lIo0tz0Gy9Ukx3X5sPMj0slG0TDT62FiH5n9c8Hj8XIfd/T6XZLqHaoSvRKFw
         8cw3/rT5MZYaW1+J6n3I5pvi7jCU15OfroRN/8B/RfYMWymm3xHJvp/FKSCGMldqtQ4v
         SO0A==
X-Forwarded-Encrypted: i=1; AJvYcCVUoE9EbpncHN8Jom9smbn3rav3kOAkTfLwBxKiMHFr6e54kmjHsasextzMBk4c9VN+s4yEhm/ofhWwuagr@vger.kernel.org, AJvYcCVk+riM9KN+Vx3w0k3XeujaE5b14Y0YdX9Wfd0QEHqE3AyK+1GP9+kmlHDvVu0SFELq/dMRUWZMu+q5@vger.kernel.org, AJvYcCWkPlvo8GNb+R9Vomdv2evoWux+C/v7yS/BcDqj5z2B5PemG7CdBRTxrbEOuEXKbUkgXgxna2zC+X9p@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPBkEXPtSC/xYM0E8lbJ97oHW3Xe7scXwJeJmLRddCW/Hjvda
	h5hpMYuDx6dpsA+JdonyppF4qTAB+Lb+I6yABj7zUGxs4d3FFyePAfYGQQ==
X-Gm-Gg: ASbGnctPlN8xwl3XzYvgIpQdC3YOmLptJDGled1yC8NKzFH4QVkeiOkyFAhizLZU3R9
	eisySIthwAYtIA1kZ9mRXTodur9kX5T9WPW5ioD+zVDNSLto5pa+KcruOsAhfj3qvgDP2FPf8AF
	t7dQgz5Z9zInDjvv8+0t8HY6xF9KHD0qmTBntOGez0ZIWLjauW7yWS6zb2qf10/ow82cSybbBrz
	JFDdDTht5P+tn9YoQN32MAntiSRw9SR10/y7SP6vOmzIiYY6wlx0EsPoWX4gbg8bSNxNKA7nyd5
	HjeKnuAjDYHmil/cCst+
X-Google-Smtp-Source: AGHT+IGQbwXba2MFwiNePHYnLnKYFfggC79zX3LMmSKQG33QbOsKtz/15wOdDccKw9clJ6yC4X6TZw==
X-Received: by 2002:ad4:5f07:0:b0:6e6:5caa:e5d with SMTP id 6a1803df08f44-6e8a0c8038dmr239929856d6.4.1741048636326;
        Mon, 03 Mar 2025 16:37:16 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976da321sm59229366d6.99.2025.03.03.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:37:15 -0800 (PST)
Date: Tue, 4 Mar 2025 08:36:47 +0800
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
Message-ID: <pgyynmrrtxi2jlrgstcbxh4f2wuxhyulw5gmssjw6rs44nix5y@msi25bjahz37>
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

Yeah, That make sense. I think it serves as a better way for SG2044.

Regards,
Inochi

