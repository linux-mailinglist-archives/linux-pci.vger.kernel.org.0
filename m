Return-Path: <linux-pci+bounces-22042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E2A40276
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D249919C426E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA672512DB;
	Fri, 21 Feb 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJrE1/q/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1220127C;
	Fri, 21 Feb 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176012; cv=none; b=YkzRde7p5UhRym/wh9BCQoRazD2XKhbI2RPd8/t5qa7A8oi83mPRiKUav2UPXpGAj2gtIS2DD1IusNpQzLUm/0hL4eOctSOwplxWLTYTb3A2vtL5VkJQ58CINw7J2FDFG1XQCagNIC4NuUDGjMUcZaW98z5ohkDYaDHcgZkTRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176012; c=relaxed/simple;
	bh=BbE8d/oK1jS2Di+ALxnwvuqfQy6s3esDrDmP52JzzjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PqjNetQwvNfHwfFl629A/Q3zl7/u7vEsHmEY6MW91HFy7W2rDTubrPISYc5o2oGysYFP/tFqCx23v5pDJ3eSRRvQKctqscbYQ/gYjV6Hue/e+0nFRHAugGHZK8iitjBAUeKf7fjy9FAxeJ7rDZnuz/TPN/xU4I2ShM/45OSwlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJrE1/q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D089AC4CED6;
	Fri, 21 Feb 2025 22:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176012;
	bh=BbE8d/oK1jS2Di+ALxnwvuqfQy6s3esDrDmP52JzzjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oJrE1/q/B74dT9qapArjBmpVVo7vOYj7wTgz501vS7EN1Kcg6VFdcPIo+1yTL//OQ
	 qC6KG+DaZF1xOOaZlVSK4yEctM8JYVOaZ7IYUoeWn7RUKYYRfw9sTKS2DV9AV0NGG9
	 O+loZPDJ6g1CCwTPpfcXudJzXIeKs8P0T1KoGdOmmR+96EqrXGaAemAavd30GLshMx
	 3tnUq0hPAyq43ftvGkNm7AeMaFYhaRRgMpC4tyHIX4Un9vPXp3bclzAGIh59KCjnDA
	 EEaLmMVEVlCwu4vDPlAX6mtsFe/2SuiSXNBQFPENmNmaHk5YaQeC9s8QHeuZ9x93ul
	 gITNQJ35XTxKA==
Date: Fri, 21 Feb 2025 16:13:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh+dt@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250221221330.GA367172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0PR01MB5662DF3C3D71A274A2E5B9C2FEC72@PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM>

[cc->to: Rob]

On Fri, Feb 21, 2025 at 11:29:20AM +0800, Chen Wang wrote:
> On 2025/2/20 2:22, Bjorn Helgaas wrote:
> > On Wed, Feb 12, 2025 at 01:54:11PM +0800, Chen Wang wrote:
> > > On 2025/2/12 12:25, Bjorn Helgaas wrote:
> > > [......]
> > > > > pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
> > > > > different "sophgo,core-id" values, they can distinguish and access
> > > > > the registers they need in cdns_pcie1_ctrl.
> > > > Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
> > > > both pcie_rc1 and pcie_rc2?
> > > cdns_pcie1_ctrl is defined as a syscon node,  which contains registers
> > > shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a diagram
> > > to describe the relationship between them, copy here for your quick
> > > reference:
> > > 
> > > +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
> > > +                     |                                |                 |
> > > +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> > > +                     |                                |                 |
> > > +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
> > > 
> > > The following is an example with cdns_pcie1_ctrl added. For simplicity, I
> > > deleted pcie_rc0.
> >
> > Looks good.  It would be nice if there were some naming similarity or
> > comment or other hint to connect sophgo,core-id with the syscon node.
> > 
> > > pcie_rc1: pcie@7062000000 {
> > >      compatible = "sophgo,sg2042-pcie-host";
> > >      ...... // host bride level properties
> > >      linux,pci-domain = <1>;
> > >      sophgo,core-id = <0>;
> > >      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > >      port {
> > >          // port level properties
> > >          vendor-id = <0x1f1c>;
> > >          device-id = <0x2042>;
> > >          num-lanes = <2>;
> > >      };
> > > };
> > > 
> > > pcie_rc2: pcie@7062800000 {
> > >      compatible = "sophgo,sg2042-pcie-host";
> > >      ...... // host bride level properties
> > >      linux,pci-domain = <2>;
> > >      sophgo,core-id = <1>;
> > >      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > >      port {
> > >          // port level properties
> > >          vendor-id = <0x1f1c>;
> > >          device-id = <0x2042>;
> > >          num-lanes = <2>;
> > >      }
> > > 
> > > };
> > > 
> > > cdns_pcie1_ctrl: syscon@7063800000 {
> > >      compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
> > >      reg = <0x70 0x63800000 0x0 0x800000>;
> > > };
> 
> I find dtb check will report error due to "port" is not a evaulated property
> for pcie host. Should we add a vendror specific property for this?
> 
> Or do you have any example for reference?

Sorry, I don't know enough about dtb to answer this.  Maybe Rob?

