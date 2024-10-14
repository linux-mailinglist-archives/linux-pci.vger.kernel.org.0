Return-Path: <linux-pci+bounces-14497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B899D58F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552481F23D00
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648C1BFE10;
	Mon, 14 Oct 2024 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq7hFbLK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF429A0;
	Mon, 14 Oct 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926721; cv=none; b=pRHKeFW7cP5E2XtNQ4NhkillwfeB0MIhKq5hDWEgKFjfKyx0n2RAua8Dnf04aVf5SSbEbOv5b1v8N288Iq6MEDhQayFMIwkIMw6sBRrW089UxT7KjZMsqCLIcpQvt0lPNOam+P9a808+8xqJVwkPX5AHlxkDa6slSU7qmcb4Vyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926721; c=relaxed/simple;
	bh=bKEZkxrV5rlekK0yY/yIrhfg4Y/0zd9c8nRTKHHwPdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dCyPBJi7o0a2OsIdezriTUZjWlqnWUu3HrZNpzbSSo8niguwOm+vXcnbDTjKMtAnfsmEFTNa3vCc5Hv99QyRTHZ3Kdy10srdGIllCrhRAMfh6vLfbMuMTttX9ejjzFQC1ONNsS0f+ncmM7ontLX7HZN7j1Vr9ZmkXQ4ZMaoFTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq7hFbLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EE6C4CEC3;
	Mon, 14 Oct 2024 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926719;
	bh=bKEZkxrV5rlekK0yY/yIrhfg4Y/0zd9c8nRTKHHwPdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Fq7hFbLKhGycRMTSATa7Gg+9Ilpd1/MFR7x0SDp2seTq6T4HBLyjMwwUlKTTXmdx1
	 S2rn4B87pHBXPmNBNzMYZb7vc9vTxnRftgd3kQkM1Rt8cyUIHvPoi0hAhzMD+dCosK
	 2iOH4cDDsU7pSfKOJaJBqYSE/oNVYEpj31NtmppC+X5lW9NOdgGUBLyzICiliRF/Se
	 FPZoHQzQZfpsramf8AqPuWFGakFZIntFiV/6l3uLPtOjM0TvtvvtJxXKPKI2qRe7QL
	 fQ9609kcYe4hBwptdxk2wVUhunm1aGgG74dHXd9sKYDQctOo2R0Q8986lbe+auR1xX
	 Ua8DSX1Kcd6wQ==
Date: Mon, 14 Oct 2024 12:25:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
Message-ID: <20241014172517.GA612835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c2f4ac-896d-4cfc-8068-45bd58aef6dd@broadcom.com>

On Mon, Oct 14, 2024 at 10:10:11AM -0700, Florian Fainelli wrote:
> On 10/14/24 09:57, Bjorn Helgaas wrote:
> > On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
> > > BCM2712 memory map can supports up to 64GB of system
> > > memory, thus expand the inbound size calculation in
> > > helper function up to 64GB.
> > 
> > The fact that the calculation is done in a helper isn't important
> > here.  Can you make the subject line say something about supporting
> > DMA for up to 64GB of system memory?
> > 
> > This is being done specifically for BCM2712, but I assume it's safe
> > for *all* brcmstb devices, right?
> 
> It is safe in the sense that all brcmstb devices with this PCIe controller
> will adopt the same encoding of the size, all of the currently supported
> brcmstb devices have a variety of limitations when it comes to the amount of
> addressable DRAM however. Typically we have a hard limit at 4GB of DRAM per
> memory controller, some devices can do 2GB x3, 4GB x2, or 4GB x1.
> 
> Does that answer your question?

I'd like something in the commit log to the effect that while we're
doing this to support more system memory on BCM2712, this change is
safe for other SoCs that don't support as much system memory.

