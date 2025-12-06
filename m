Return-Path: <linux-pci+bounces-42707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1BCA9ACD
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 01:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1659E30DF009
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B0184;
	Sat,  6 Dec 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMarMEwP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659D749C;
	Sat,  6 Dec 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979689; cv=none; b=sEb1k/Pu6q3wQYQlVRUIpNBXcEEEr6r7nIk626K58UcWJYzaJ0M+iiEX4NO0r5hp4ZNoy9pHkZO+ZZUy3rHvpBCUYMyE/IzLBPuYOCvepwsKL/H2GUV6BH9ynm+iMNEhtyoQCTV88aPVnB8T5OVoFJXi3b25k6TSCS0XT8ZEnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979689; c=relaxed/simple;
	bh=R7HsQDGBjcjXJ81DGGnBQnRnfKReTGHiJmsZwWhTh6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqads5tplX8xmEdP0OFF8/3gAUMmXAn2cggn2ZoF5V8NgAezOJWBwH5pSv7R65LuhJsmC+/xI0Nm0l4jIDNq1pgoZK367zlsCjkg510jlz8iR2jI+GWNpIVYxSrUWPWE630vPgGCCX7fm+LlWFrjukhg93Z5+dHwMdntW8WnQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMarMEwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97FAC4CEF1;
	Sat,  6 Dec 2025 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764979688;
	bh=R7HsQDGBjcjXJ81DGGnBQnRnfKReTGHiJmsZwWhTh6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMarMEwPMDpFmOeAE6CeeAxtIrqgmlAO3jdHip31Ld+9XQox+jFZKJmkWBNUFYhOY
	 J7S6GEyYhVsXristA3lxrwkN/2idujDP6kV1nOLtAPb/yVsXB+hI7ec0g2XB08s9HP
	 61xlxNiWckbr4jPP0TM7nN3xlBE0ccvt6NqM548uJdtzfUzxt4sC+lYJzO+Plmk3tr
	 cbS1t+wmnVO6UKA+13SyT//0y2nxOD0zykoPZHAz8bDGvix8dC/AWUMJKbXLkPUMJG
	 qBMq3HaR7ezCM9BRmfIFxBKSnzNziHti3mhlf0Yv2u8M0IRsIym/CMdG+GKtb+9VS8
	 h2IQo5Tgu0UdQ==
Date: Fri, 5 Dec 2025 18:08:06 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Jeffery <andrew@aj.id.au>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] Add ASPEED PCIe Root Complex support
Message-ID: <20251206000806.GA969079-robh@kernel.org>
References: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>
 <20251204195355.GA1975043-robh@kernel.org>
 <SEYPR06MB5134D0D5911E3C86D869151E9DA7A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134D0D5911E3C86D869151E9DA7A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Dec 05, 2025 at 12:12:35AM +0000, Jacky Chou wrote:
> Hi Rob,
> 
> Thanks for your comments.
> 
> > > Changes in v6:
> > > - Refer to pci-cpi-bridge.yaml to update aspeed,ast2600-pcie.yaml and
> > >   the pcie node of aspeed-g6.dtsi.
> > 
> > Where is this? You don't describe the root port and its properties at all now.
> > 
> 
> May I confirm whether the pcie@8,0 in aspeed-g6.dtsi is not considered the 
> root port? From my understanding, that node represents the root port, so I 
> want to make sure I'm aligning with your expectation before updating the binding.

I believe you told me it was the root port.

> Could you help clarify how you would like the root port and its properties to 
> be described in the schema?

properties:
  pcie@8,0:
    $ref: /schemas/pci/pci-pci-bridge.yaml#
    unevaluatedProperties: false

    properties:

And then add all the properties you have which are not defined in 
pci-pci-bridge.yaml (and pci-device.yaml by reference) (i.e. clocks, 
resets, phys, etc.).

Rob

