Return-Path: <linux-pci+bounces-35171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE861B3C7C8
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 06:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CCC5A15C7
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769772773DC;
	Sat, 30 Aug 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d822i5PQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B298128395;
	Sat, 30 Aug 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527033; cv=none; b=odrubKTgMbtwBhZo7HuTzzGSxvRpjfXUh39/Ns8BxYvw0dFRTjKf8SQWB1AijLhN64hDO4irAguoeYAm7OAbuYl12jiv650xKw8vDuv3SV8YXwxUwuxJUy7emIM4kbo3U0lhhkcJDD8EUN+1S6cs4UJuz6qfMgOQ1/VcPVZx8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527033; c=relaxed/simple;
	bh=+Bg+RVavGYMPykEG5hhqXkc3Av6gb9iZ45IEltTHUHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKkYpJvKMqQ85xzG6noP8bqdi1jG8LR7uqi9ELqldYJfQTSm+u/RwH+HvWYRh8hf65TnuHi9SrR/FU8SuMyd3UOBRqiwpLYrEorXN75W1LX5pM8yJ9H5i2nnbXXcwbJQGajHg6CqthdImJQ6kVOAd3r3apd+zGKb7ljj258boog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d822i5PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF0FC4CEEB;
	Sat, 30 Aug 2025 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756527032;
	bh=+Bg+RVavGYMPykEG5hhqXkc3Av6gb9iZ45IEltTHUHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d822i5PQL/Uvn3lE2lP6EXOe+aAdp86itNdmpV/DjBhUXFigUGStBOlEmkIVXZaiu
	 4jqo7FEpZb4107b55pmYgddnw9xP9EkPeKvFcThgDO+ZS3xK6Oyr+Vr/c4zaXG6HZy
	 fpT9SOIapIKkhqhJ9oKJ/fptZNB2qmSLXRFOjUBfcHy8h0xFQ++D97B3bufKCGXPDi
	 JWEhUdvAY6ADvJ1aTRU1LyBJvRNqBGkY5eHVYcczZ/okP/PqjZ3q6ceafB7ia7fXA0
	 V3WLJKjK7tYfpzBz7h/pL5X2rOYheO6Yp91+Ya7h1ygJ/0jUZAO/LfRI99l9qjImGY
	 DhQRBlJyhQaBg==
Date: Sat, 30 Aug 2025 09:40:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 3/9] PCI: of_property: Restore the arguments of the
 next level parent
Message-ID: <zvyro2dl7hqproym4shawsckorhlcfkyucponfvw2qrbc44zb2@3kg2eaab42rj>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-4-claudiu.beznea.uj@bp.renesas.com>
 <7wmpgldjvznbllotblv6ufybd2qqzb2ole2nhvbx4xiavyqa2b@ezaqwghxmbve>
 <d004d9c4-f71b-49e6-9ced-031761f5e338@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d004d9c4-f71b-49e6-9ced-031761f5e338@tuxon.dev>

On Thu, Aug 21, 2025 at 10:40:40AM GMT, Claudiu Beznea wrote:
> Hi, Manivannan,
> 
> On 20.08.2025 20:47, Manivannan Sadhasivam wrote:
> > On Fri, Jul 04, 2025 at 07:14:03PM GMT, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> of_pci_make_dev_node() creates a device tree node for the PCIe bridge it
> >> detects. The node name follows the format: pci_type@pci_slot,pci_func. If
> >> such a node already exists in the current device tree, a new one is not
> >> created.
> >>
> >> When the node is created, its contents are populated with information from
> >> the parent node. In the case of root complex nodes described in the device
> >> tree, the created node duplicates the interrupt-map property. However, the
> >> duplicated interrupt-map property does not correctly point to the next
> >> interrupt controller.
> >>
> >> For example, in the case of the Renesas RZ/G3S SoC, the resulting device
> >> tree node is as follows (only relevant DT properties are shown):
> >>
> >> pcie@11e40000 {
> >>
> >>     // ...
> >>
> >>     interrupt-map = <0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
> >>                      0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
> >>                      0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
> >>                      0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;
> >>     interrupt-map-mask = <0x00 0x00 0x00 0x07>;
> >>     interrupt-controller;
> >>     #interrupt-cells = <0x01>;
> >>
> >>     #address-cells = <0x03>;
> >>     #size-cells = <0x02>;
> >>
> >>     phandle = <0x1f>;
> >>
> >>     // ...
> >>
> >>     pci@0,0 {
> >>         reg = <0x00 0x00 0x00 0x00 0x00>;
> >>         interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00
> >>                          0x10000 0x00 0x00 0x02 0x1f 0x00 0x11e40000 0x00 0x01
> >>                          0x10000 0x00 0x00 0x03 0x1f 0x00 0x11e40000 0x00 0x02
> >>                          0x10000 0x00 0x00 0x04 0x1f 0x00 0x11e40000 0x00 0x03>;
> >>         interrupt-map-mask = <0xffff00 0x00 0x00 0x07>;
> >>         #interrupt-cells = <0x01>;
> >>
> >>         #address-cells = <0x03>;
> >>         #size-cells = <0x02>;
> >>
> >>         // ...
> >>     };
> >> };
> >>
> >> With this pci@0,0 node, the interrupt-map parsing code behaves as follows:
> >>
> >> When a PCIe endpoint is enumerated and it requests to map a legacy
> >> interrupt, of_irq_parse_raw() is called requesting the interrupt from
> >> pci@0,0. If INTA is requested, of_irq_parse_raw() first matches:
> >>
> >> interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00>
> >>
> >> from the pci@0,0 node. It then follows the phandle 0x1f to the interrupt
> >> parent, looking for a mapping for interrupt ID 0x00
> >> (0x00 0x11e40000 0x00 0x00). However, the root complex node does not
> >> provide this mapping in its interrupt-map property, causing the interrupt
> >> request to fail.
> >>
> > 
> > Are you trying to say that the generated bridge node incorrectly uses Root
> > Complex node as the interrupt parent?
> 
> I'm trying to say that the generated bridge node is wrong because it copies
> the interrupt-map from the root complex mapping int 0x1 to 0x0 in the
> bridge node, while it should have map the int 0x1 to something valid for
> root complex mapping.
> 
> E.g. when some device requests INT with id 0x1 from bridge the bridge
> mapping returns 0x0 then the returned 0x0 is used to find a new mapping on
> the root complex based on what is provided for in with interrupt-map DT
> property.
> 

TBH, I don't know why it generates the 'interrupt-map' property for the bridge
node first place. It just creates two level lookup and in the absence, the IRQ
code will traverse up the node to find the interrupt parent anyway.

Maybe the intention was to avoid doing the traversal.

> 
> > 
> > I'm getting confused since your example above shows '0x1f' as the interrupt
> > parent phandle for both Root Complex and bridge nodes. But I don't know to which
> > node this phandle corresponds to.
> 
> Root complex node from this patch description has:
> 
> phandle = <0x1f>;
> 

Oops. I failed to spot it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

