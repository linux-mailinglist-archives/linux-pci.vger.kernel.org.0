Return-Path: <linux-pci+bounces-20418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F4A1DBB7
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009B318816B1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F73318A6C1;
	Mon, 27 Jan 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL1eRz64"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E217BA1;
	Mon, 27 Jan 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000785; cv=none; b=IeJ1Evns6+nLNDmVSvBKcFwb3jrWc/yULqLi6g1H0+WiV8Hi9WQaYuChsHuNYWSfVNMPeAs76coZixywXfT5wUMD0DuobVmxpMdNA2ZQa0fKO2JJFkbpiIemm4LsrAmYXatbCuvKDTSYBMqKXqh29pKbdTNtuN9ntvRz7WT/QRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000785; c=relaxed/simple;
	bh=c9fNMiYQ6IaAXSHNLRvX7gWgmxv11IcH5CNf8x744j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izg9O7UAX0VURAee/Gj1zoNPwo/AIS++c4Qcn9fFyF9Z9sqXxv5tazxTCv2fhmMGvQf0Il29S399NMETvbdENDkf5g/EDHlw2VBFZ72x7LLA5eUBz0M+nUZnx+ekOQMTkK/wEW6K53AcAdnMzBVVxL+SorFSxR6ybR/LYvg0450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL1eRz64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AEDC4CED2;
	Mon, 27 Jan 2025 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000784;
	bh=c9fNMiYQ6IaAXSHNLRvX7gWgmxv11IcH5CNf8x744j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jL1eRz64jrGD1ExY+hDpmzMxq+qv1SJgTwEyLDz/7hF7LKjWZlcIG7ZTETSArNlbx
	 B3cnxtP2/xdU+vfUZsbuP3NLKIo75Clg4Se1FvvkCPyJ2Fp5ZvHe7DXjxUH4Y2opA9
	 +ApGDsDym8XhAzIwop8RLC7ocLsyeY2FIlf/u8c8+++4wyc9kJtJBh6hmOlDkCcc+W
	 4L4u4/lNmbEY/H28q+y2lQ2ncDVmwo2lJY0Eu1ER1UecvFvUF1hk4rt364eXodXm6w
	 Z8KC7b2lQ29ahPBocJXNjFFj9EeS4ha+tQ2vyEUpfrtjvAKwf+oYDoAEZAU/1W0NPJ
	 XVPbTL4gAd0RA==
Date: Mon, 27 Jan 2025 11:59:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-rpi-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Jonathan Bell <jonathan@raspberrypi.com>, kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Phil Elwell <phil@raspberrypi.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 -next 02/11] dt-bindings: PCI: brcmstb: Update
 bindings for PCIe on bcm2712
Message-ID: <173800078306.536877.920317411552148665.robh@kernel.org>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-3-svarbanov@suse.de>


On Mon, 20 Jan 2025 15:01:10 +0200, Stanimir Varbanov wrote:
> Update brcmstb PCIe controller bindings with bcm2712 compatible.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


