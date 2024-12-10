Return-Path: <linux-pci+bounces-18077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896F9EBEA2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C402852CD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70766225A3C;
	Tue, 10 Dec 2024 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6RNkTpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70821126D;
	Tue, 10 Dec 2024 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871243; cv=none; b=ciXq3MyMFwglQ0fD7O37MC8+AVl1kzW+5YodwpK0rmli7J0BQ6IH01JGzqkNVxyNoQScVpdSgRqZ8TX1a1CL6BQj3tPjw55IKkV1tOxCGFxIGwMgxRvT42CDv87uE9X6k1q7F6NNh5QmJ3vjo8CMOhWiRJeVydo+rSQNN4OvY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871243; c=relaxed/simple;
	bh=xHboJ6Nj+jUBjuysVSh5kzHiNcpv6miOBLy03WABifE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWM2aqIKQ6FpCUQZlaKCPrQl8Bhvnxv1DhHsUlGJw6kQCc9tvzDTCcBqdAck6yWoT1CuXnVK+dJLlOwkfjLst4fUILk2zCTlDMwz0IQcZ+SaGiTx1C4GRl10kat7oaw18AWWELaFthvsb5kz/2DKI+b/4oNHSEvYiANPN0Xo+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6RNkTpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD594C4CEDE;
	Tue, 10 Dec 2024 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871243;
	bh=xHboJ6Nj+jUBjuysVSh5kzHiNcpv6miOBLy03WABifE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6RNkTporGLhP919FrAvtVaRdlwD6OHKF9LVyCWvSPhS6/L86mghmTp3sWhxV6wNb
	 QlFBLBsCx5p3BCADTSSJlGiZoVGQUxg0BvJZURibCzW7PEsrxr547c8BfR2mdkLGk9
	 jxaD+B41ZsnY4nGwKXLpOJSOokz1SfQvjul3MYuG+BmUdjAfMYOfMCzqvxr7mfk3gD
	 RfUh0l8GKGMp71ka3TfjDrVw0L/2n83cPMNl5jULVNenO4kzoUP92Oqil4RgXC7Abq
	 10g9W6QDZj1WACB3tkQ++E5BONJ7jF+yNA9r5RaNIdkhA5tl3jpAH7Uvt55OeEaQRl
	 lMW6sHikMq9hg==
Date: Tue, 10 Dec 2024 16:54:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-rpi-kernel@lists.infradead.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Derek Kiernan <derek.kiernan@amd.com>, linux-gpio@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <173387124038.751229.17185539657512592303.robh@kernel.org>
References: <cover.1733136811.git.andrea.porta@suse.com>
 <92fe1c6eb3ae1e7e7c151423568be2d13f19b55a.1733136811.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fe1c6eb3ae1e7e7c151423568be2d13f19b55a.1733136811.git.andrea.porta@suse.com>


On Mon, 02 Dec 2024 12:19:27 +0100, Andrea della Porta wrote:
> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


