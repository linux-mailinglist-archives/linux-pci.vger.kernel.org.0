Return-Path: <linux-pci+bounces-21816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E441DA3C657
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1EE3A82C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784321F941B;
	Wed, 19 Feb 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC1eUyJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6721B415B;
	Wed, 19 Feb 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986756; cv=none; b=Ui4oeySEif6lhqyDsmgdAFHoxSqI+i2Eslr97lVdza3gY3VciH4mf1mHtnISdUTwDVFXRLLWhMsUjppJUQebADOShAOzN2X2wuChBbpmJieUke54kDac3OaXkspQJ0KjgdgfDdXSnTBlr+uTi+dP3z8MSU0akPSu0LB4D5RSA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986756; c=relaxed/simple;
	bh=envBoeOud7Q/RcNE6x7hX9HI5r3dhh7frxZMCujiSME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XrTZ4M66cn8H06shjg9DSYdn40Jx3ryr/cGQpkLregYTrPcTsvXmfr8udgVD9u8m1aU7ZCxwAq+xDy4ZRlWA4bvGennfQUP2DEAWLwVKExxL4/UVWvMWNaaql17RDytnx4s0yQPecPH1Y7eGs46QYXKzVSVXiKCv+D7ukjNGPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC1eUyJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB5C4CED1;
	Wed, 19 Feb 2025 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986754;
	bh=envBoeOud7Q/RcNE6x7hX9HI5r3dhh7frxZMCujiSME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tC1eUyJWR+wzlPDrec1L/z+XhGm3pnnj3ygbLrIUrDmK/LjKH+gMMbRadY1HvZtLb
	 7+h3u/S7JjH4xun86GlfvkW9TmsSbC0rK8txbiCswoaxY9jPLm5zvOsr73zMjNY+Aw
	 u7XOZ5r6OCQ/Z8sCjbtFZePJNA0OfqxX9Zyq6OnbIiUmLgGyq6gYIv+LEmkiXLm2xN
	 sBsSShEY0Si7dqMFlEJPt2x+kJeR866cJOmdMPVLrxYwleyj9Ezkyl2JhxWUYXOqLh
	 lCoxVZh8ZTC2RFl9ukjx4x0MZ/h/y6nQdFX4/wNx1i9lxxizLu2gNEV0FTc2gAQ9px
	 wilA2sN0QymLA==
Date: Wed, 19 Feb 2025 11:39:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250219173912.GA224527@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204073501.278248-6-herve.codina@bootlin.com>

On Tue, Feb 04, 2025 at 08:35:00AM +0100, Herve Codina wrote:
> PCI devices device-tree nodes can be already created. This was
> introduced by commit 407d1a51921e ("PCI: Create device tree node for
> bridge").
> 
> In order to have device-tree nodes related to PCI devices attached on
> their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> root bus device-tree node is needed. This root bus node will be used as
> the parent node of the first level devices scanned on the bus. On
> device-tree based systems, this PCI root bus device tree node is set to
> the node of the related PCI host bridge. The PCI host bridge node is
> available in the device-tree used to describe the hardware passed at
> boot.
> 
> On non device-tree based system (such as ACPI), a device-tree node for
> the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> host bridge is not described in a device-tree used at boot simply
> because no device-tree are passed at boot.
> 
> The device-tree PCI host bridge node creation needs to be done at
> runtime. This is done in the same way as for the creation of the PCI
> device nodes. I.e. node and properties are created based on computed
> information done by the PCI core. Also, as is done on device-tree based
> systems, this PCI host bridge node is used for the PCI root bus.

This is a detailed low-level description of what this patch does.  Can
we include a high level outline of what the benefit is and why we want
this patch?

Based on 185686beb464 ("misc: Add support for LAN966x PCI device"), I
assume the purpose is to deal with some kind of non-standard PCI
topology, e.g., a single B/D/F function contains several different
pieces of functionality to be driven by several different drivers, and
we build a device tree description of those pieces and then bind those
drivers to the functionality using platform_device interfaces?

Bjorn

