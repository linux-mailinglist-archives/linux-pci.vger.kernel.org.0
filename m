Return-Path: <linux-pci+bounces-24692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D342EA70902
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 19:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879A168273
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB719CC0E;
	Tue, 25 Mar 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS8q3J9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14441991D2
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927363; cv=none; b=lGG1tYkOQ4u9TW8m1+6eO91SWUKONhGKHPj/QNivL4ebY9TcesoT+AJVGBjvFFlxUvP3SyIHN3FnVPWQv+YjCDEqasGUVo1uSnkk4C1L5NOqLDcyOw67P0s7Ld9cRF7ySuv5zji123B3/q0MSiH+FpEw3rn6Ms/YINxASqGsy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927363; c=relaxed/simple;
	bh=crRjvH14g0jO6YfpzbicsPBlEzvQ8/tcMCqAvE641/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPBvcoyftuVBjUk+YVk3q3zaItuzybKm26Q0FqhYpim++LA0PVLOpIJopi3Q2i+3g1uSCNPMhpZuIgXdegScF5wJiSqkk+hDN7QEFstOeyoexfo+eiBZEUL6R/oQDhUlfc8HIdvZclbGNSh1mCMyorC2HPkLga+J1/nVtg7q3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tS8q3J9V; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30332dfc821so4881491a91.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742927361; x=1743532161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmx5ewE9CpmYmb/EWKQ5oR/rMw7j+z90kb/HX9r8TaE=;
        b=tS8q3J9VBGSlOe/2M5DQbB3nvjCoTFI6DvekRPPCB6WFkXObMoMM2OOx6B9wAnvImL
         blMc/jGdPldTqOWT8yfXFoPs4jNnJmSUoCHwsW1MPrVSQoQVjpEfzeRao37vzrLS7v0b
         UnONrWQscTTNqILVn0jcsRkGdNmMaet8qS3o4Np+gXhhP+z/hnSYrSA06c7sKnwIGAR1
         87PI3YsWiF+aIXsbz6EAbesIrNKCEUhYd0TMNs2Vgw4QPBQ5fu+IxzfRkH19wcYcyeAr
         OGH77v70r1qfZc2VFwfBOEWION9V3xzIm1z/7ixXfqg3OiQWa2TvslbwDaZFK4rt8MD2
         Dl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927361; x=1743532161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmx5ewE9CpmYmb/EWKQ5oR/rMw7j+z90kb/HX9r8TaE=;
        b=jQvUtP3xNxqpY24l+sI+TaQk0o6rw5ZCHJnnYQnBc8Kf51l7lIOlNoLXWTHfRc6RSQ
         Okl+pw0gAYVVwcF8eL6ru9ThMhOO2omv+kEaPjSg97yZrJhACjL8YMAm3DsZzdmbD92A
         SttgGRX87FA3Xt7MkWrbUbd/0MMwf5k8aFJXvymLBd5CRRYCEt0p2XatLlYjGDMZ4lCk
         1LlRzAfbzSiaZPgK/Vijx5wzHLGnkMLmKbSwJwR2jOTz3GUFL8vgVL9AY6UgC4bS01Hc
         8n1N9Rh2apch6uREwsghdXyCp8Ai5PljqXlWWuw6QeK34C9whnmXUqF5lo5oux1mWYAw
         DM4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvuaDvcXnVo5w1+yJuR1CnduZ16OC7By/W+jETHECsuFtgIXiI26qOUyDz6rYjLG65LexVBiAJA2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5GN8/bknTNQIEU9uUBF220MUmmdNR+pDxusvCdawwRcLItpf
	LPQA1ri3rwUQYxugGdwcVAzCjVMSvE8vQbmocFIAUSJ0rU5w/aOm14tgZKmMpA==
X-Gm-Gg: ASbGnctd9EsMlyqce+j4Zj8ssFRW2SdjYaZU2kTCyXVPRaE14uio73/eNZ3Jh9f/+PH
	JPepBqE2HV4b8wq9pSjW7ft54TKNWZBmJvCDpV2n+pX7X4grbucHm0wXRtq9UevueO/oin+CTYM
	yh7O9UWczK2mNZ4s6QZuJ/462wU3tLCaYduhaTQh9QANZ3ShWI61dYCB4umgBl7CYYqtDNsLfCD
	imUKohCTND7l3mSyqt+O6kIibIOHifIajJdr4dRKeYmKwFCukF7ZvNWtusTrGrL5/vBlaP9cy0A
	2iQ2kIlzcLUDLUbI7AdAbPV1nl0FAWEpYpU4oN1GHFpMdu9yXEY0nWip
X-Google-Smtp-Source: AGHT+IGsYGiIj3zMmleKzhoEAggL4APoyOgKkCTRvkg+1ndeCLopUInmEMl2y5a6pf3LwaqPqiR7kA==
X-Received: by 2002:a17:90b:2d0c:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-3030fd769d1mr34439112a91.0.1742927361019;
        Tue, 25 Mar 2025 11:29:21 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2857sm93735025ad.155.2025.03.25.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:29:20 -0700 (PDT)
Date: Tue, 25 Mar 2025 23:59:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Message-ID: <5hkzuqptaor4v5fc7ljxb36zdipeg67lsjfkcah5fkxfyyjt6e@oknqdtbwjitj>
References: <j3qw4zmopulpn3iqq5wsjt6dbs4z3micoeoxkw3354txkx22ml@67ip5sfo6wwd>
 <20250324182827.GA1257218@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324182827.GA1257218@bhelgaas>

On Mon, Mar 24, 2025 at 01:28:27PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 24, 2025 at 10:48:23PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Mar 15, 2025 at 03:15:40PM -0500, Bjorn Helgaas wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > Return the offset from CPU physical address to the parent bus address of
> > > the specified element of the devicetree 'reg' property.
> 
> > > +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > > +					  const char *reg_name,
> > > +					  resource_size_t cpu_phy_addr)
> > > +{
> > 
> > s/cpu_phy_addr/cpu_phys_addr/g
> 
> Fixed, thanks!
> 
> > > +	struct device *dev = pci->dev;
> > > +	struct device_node *np = dev->of_node;
> > > +	int index;
> > > +	u64 reg_addr;
> > > +
> > > +	/* Look up reg_name address on parent bus */
> > 
> > 'parent bus' is not accurate as the below code checks for the 'reg_name' in
> > current PCI controller node.
> 
> We want the address of "reg_name" on the node's primary side.  We've
> been calling that the "parent bus address", I guess because it's the
> address on the "parent bus" of the node.
> 

Yeah, 'parent bus address' sounds bogus to me. 'ranges' property is described
as:

	ranges = <child_addr parent_addr child_size>

Here, child_addr refers to the PCIe host controller's view of the address space
and parent_addr refers to the CPU's view of the address space.

So the register address described in the PCIe controller node is not a 'parent
bus address'.

> I'm not sure what the best term is for this.  Do you have a
> suggestion?
> 

We are just extracting the offset between translated (cpu_phy_addr) and
untranslated (reg_addr) addresses of a specific register. Maybe the function
should just return the 'untranslated address' and the caller should compute the
offset to make it simple?

> If "parent bus address" is the wrong term, maybe we need to rename
> dw_pcie_parent_bus_offset() itself?  
> 

Yes!

> Currently we pass in cpu_phys_addr, but this function doesn't need it
> except for the debug code added later.  I would really rather have
> something like this in the callers:
> 
>   pci->parent_bus_offset = pp->cfg0_base -
>       dw_pcie_parent_bus_addr(pci, "config");
> 

I agree. This should become, dw_pcie_get_untranslated_addr().

> because then the offset is computed sort of at the same level where
> it's used, and a grep for "cfg0_base" would find both the set and the
> use and they would be easy to match up.
> 
> > > +	index = of_property_match_string(np, "reg-names", reg_name);
> > > +
> > > +	if (index < 0) {
> > > +		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
> > 
> > Both of these callers are checking for the existence of the
> > 'reg_name' property before calling this API. So this check seems to
> > be redundant (for now).
> 
> True, but I don't see a way to enforce the caller checks.  I don't
> like the idea of calling of_property_read_reg(np, index, ...) where we
> have to look the caller to verify that "index" is valid.
> 

Ok.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

