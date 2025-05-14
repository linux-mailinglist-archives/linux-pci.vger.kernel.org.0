Return-Path: <linux-pci+bounces-27682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A21AB637E
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA36D3AE3C8
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09F1F791C;
	Wed, 14 May 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ovNfoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9543169;
	Wed, 14 May 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205511; cv=none; b=f4jqpyzO8mDqkHj9u3X6qv+xxyvzR0ErBvY4QDzMpoedEqv8os+Dcc1JHmiKX6o+yVy9BW+DnWiU8Lb8EpXsWKD42vovOxVPMG9LhgrDz7CX74Tc+5W5brQGMBfA7uFu01KBMcQ6nA8YaGJCH/4uNxr2F+PcPNN1zNuw1K4kWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205511; c=relaxed/simple;
	bh=gxZxLOjfyfNFBmAgKgaPaFgJhZ7shuHTtU/Kpk1Npek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpQuozEi6wtRpKAhz4+UH5ZTgt63LzrivCWgR1g36cQ2Bq50zOiRUnTwP8qwyDRjJNdpRa922SSDdl09BCCdMxWce5Jd3C+WelVyIXxJ6eZblNNcMijhwAc9ml2hBNzPATVfPkiKeciOnhJfAOLbLQiog4RkrxtoV2IOI33aEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+ovNfoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E4C4CEE9;
	Wed, 14 May 2025 06:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747205511;
	bh=gxZxLOjfyfNFBmAgKgaPaFgJhZ7shuHTtU/Kpk1Npek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+ovNfoWN9liprsyztoT/r0/7q1PZdSzMc9DnvlYts7M/wElEPcQ6rt7FErnECMP/
	 3MW577cJkL3B49t+JHnr0aHcd1aPAPtF1Pw4eIZCVy/AJMO25JhsvakTid2L1Sl2GD
	 +hZT4Ek27tP4Q701c0A2twMPijb5GtfigwUjBfGRL3jzhXSd94AOiMGxEwjcoZWDLi
	 eukr4HEGUOsGMhPwuvGlOfYf9fQRtwlJYWhvKb9kjUMhWlFLaCKh63xIxd4CusX50g
	 COVGyjK7XzarylcELOsofgXqS7gmCL9GApTSCfR/Cb/h9TakjhF/N/0YGTBoB942Qr
	 V9UqtwRw9/nsA==
Date: Wed, 14 May 2025 08:51:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <aCQ9ge1eROhh9RVE@ryzen>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
 <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
 <aB8ysBuQysAR-Zcp@ryzen>
 <20250512135909.GA3177343-robh@kernel.org>
 <aCOAmQNWUWU55VKT@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCOAmQNWUWU55VKT@ryzen>

Rob,

On Tue, May 13, 2025 at 07:25:50PM +0200, Niklas Cassel wrote:
> On Mon, May 12, 2025 at 08:59:09AM -0500, Rob Herring wrote:
> 
> I do realize that, for boards supporting more than a single mode (Common
> Clock/SRNS/SRIS), this device tree property is basically a configuration
> option. For boards only supporting a single mode, it is actually describing
> the hardware.
> 
> E.g. Rock 5b can run in both SRNS and SRIS mode (Common Clock is not
> supported), and since this has to be configured before starting the link,
> I cannot think of a better way to control this than a device tree property.

Just to provide some additional context (although it was mentioned in the
commit log), basically what I am trying to accomplish is to replace the
vendor specific properties
"nvidia,enable-ext-refclk" (Common Clock) and "nvidia,enable-srns" (SRNS)
(the tegra SoC does not support SRIS, that is why it doesn't have a
property for that) with a generic property that can be used by all PCIe
endpoint controller drivers.

IMO, there is really no reason to have two properties for this, it is
cleaner to just have a single property which is basically an enum
(as suggested by this patch).

To bring some additional insight of how it will be used, one could grep
for nvidia,enable-ext-refclk and nvidia,enable-srns in the tree.

My plan was to get some feedback on this binding before implementing
support for SRIS in the dw-rockchip driver, but I can also modify the
tegra driver to also support this new property in V2.


Kind regards,
Niklas

