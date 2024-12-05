Return-Path: <linux-pci+bounces-17793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E873B9E5CF0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81292839BA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB1224AF3;
	Thu,  5 Dec 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rftU0Zqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E22218847;
	Thu,  5 Dec 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419224; cv=none; b=KCaTJlYoOWiE+Mz504WXyCMOJYIDBuGtB/dBFm5c1w/M+2pM6TdxpxZyMAdzHF6FYcZUp83A+rBHflqzQhJdgXjr7vAitjv1Stw3h1c9vBTMTJL4RLv3W/zJq+d369c140a8TkjVmxT7DISQ9t7IaYmGN55Y7zFnZYppd4fJV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419224; c=relaxed/simple;
	bh=J4RkZ5QcEl8BbbxZ0oiUNZ6PyUOhfVv0KK0hpYX0QHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X5DdSjJ47xwfpQqXuXpqDpSLZ22uVWr3HAcI7EAQqxkNivaE6MO/q90hP7lFMqIK6TOnQJWk+Yx8GqWH3QRD18m6lqPG4u+C7oUJQkq5or6PkqnI3mHzmWsg8nfkE9xpAp4s1BEAZ+vreJitPCmaOwEctWRHOSTwz/rnss2Xruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rftU0Zqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD3C4CED1;
	Thu,  5 Dec 2024 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419223;
	bh=J4RkZ5QcEl8BbbxZ0oiUNZ6PyUOhfVv0KK0hpYX0QHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rftU0Zqtc9rZbHZ3b72ZLSyJ+U1EXcTYa5W6E7+3oB48oYixbQ6rPv41EdATIKyPA
	 eceinoMbrJOg2T+pWNemssUo+s2q2FALIGGfuMiyZNOHhkdFw42D/2FcopxvVKJXC4
	 8lL5dr+LSh7aWZZMYTtFB1nvFOS2f0GurLvUb8wNkB3SgOa9p9Oon25AEz+X5Ne/6/
	 xM5wD4MOqGx00Q37pa0Htl/wWXrID9mZszE8JWqVlDzqZi6uG1Iq2vjVQkZ+o9AQgp
	 rjypv9377pYhtbLIceudyFqTvMInGom0gyAtzceg/vyPdXLTTEgFh7GD03QzOZK6yd
	 e0wjh2DmCu4BQ==
Date: Thu, 5 Dec 2024 11:20:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241205172022.GA3053765@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569904ad-2b70-4a58-98fe-4f24e1089e17@foss.st.com>

[cc->to: Rob for RC/RP separation conversation]

On Thu, Dec 05, 2024 at 02:41:26PM +0100, Christian Bruel wrote:
> On 12/3/24 23:25, Bjorn Helgaas wrote:
> > On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
> > > Document the bindings for STM32MP25 PCIe Controller configured in
> > > root complex mode.
> > > 
> > > Supports 4 legacy interrupts and MSI interrupts from the ARM
> > > GICv2m controller.

> > > +  wake-gpios:
> > > +    description: GPIO controlled connection to WAKE# input signal
> > 
> > I'm not a hardware guy, but this sounds like a GPIO that *reads*
> > WAKE#, not controls it.
> 
> Rephrasing as
> "GPIO used as WAKE# input signal" (output for the endpoint bindings)

Perfect, that makes a lot of sense.

> > > +    pcie@48400000 {
> > > +        compatible = "st,stm32mp25-pcie-rc";
> > > +        device_type = "pci";
> > > +        num-lanes = <1>;
> > 
> > num-lanes applies to a Root Port, not to a Root Complex.  I know most
> > bindings conflate Root Ports with the Root Complex, maybe because many
> > of these controllers only support a single Root Port?
> > 
> > But are we ever going to separate these out?  I assume someday
> > controllers will support multiple Root Ports and/or additional devices
> > on the root bus, like RCiEPs, RCECs, etc., and we'll need per-RP phys,
> > max-link-speed, num-lanes, reset-gpios, etc.
> > 
> > Seems like it would be to our benefit to split out the Root Ports when
> > we can, even if the current hardware only supports one, so we can
> > start untangling the code and data structures.
> 
> OK. and we support only 1 lane anyway, so drop it.

Makes sense.  What about phys, resets, etc?  I'm pretty sure a PHY
would be a per-Root Port thing, and some resets and wakeup signals
also.

For new drivers, I think we should start adding Root Port stanzas to
specifically associate those things with the Root Port, e.g.,
something like this?

  pcie@48400000 {
    compatible = "st,stm32mp25-pcie-rc";

    pcie@0,0 {
      reg = <0x0000 0 0 0 0>;
      phys = <&combophy PHY_TYPE_PCIE>;
      phy-names = "pcie-phy";
    };
  };

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml?id=v6.12#n111
is one binding that does this, others include apple,pcie.yaml,
brcm,stb-pcie.yaml, hisilicon,kirin-pcie.yaml.

Bjorn

