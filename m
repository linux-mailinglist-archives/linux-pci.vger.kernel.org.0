Return-Path: <linux-pci+bounces-9426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360B91C8E9
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 00:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF55280AA7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 22:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0279B8E;
	Fri, 28 Jun 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c847feM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93956444;
	Fri, 28 Jun 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612403; cv=none; b=JVf1P2kQFplaCdBV007Qrt48WjFlB+DC2nl1nTUtHY0SHk+pd/d+uAgJyDShF1xpYIKeQ/hnObkU8kBjJPy4aMQYYLlys7/yP0MHfTe3ynUKta7cWovwn8+zNMMHIJ9SPqnglA0zsBIIR8m4y7w5n0vZNrYa5vyEYH2nPZChbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612403; c=relaxed/simple;
	bh=cYBvcV48I6BETzBlpY9cPUOJ81039iBThDExzxsPpn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMGJoexL5uKr5+w8E/UWBl5l3v4b+fWXBpdWaSETddaKz+mJk90/d+yKMJUVP5bqMgqJ4hOZ1e87NvZ8FkvMt6pLnXxUNcFXgU3FuytyaFcTJCZr2bZEPEpIKAUrghGsTfXedMcj647va0YB4CtutrJEzic126izOozUx5rbkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c847feM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D149CC116B1;
	Fri, 28 Jun 2024 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719612403;
	bh=cYBvcV48I6BETzBlpY9cPUOJ81039iBThDExzxsPpn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c847feM2Mx9GgtFvU7cP5XfU3PqAwIBsA/mOstgEmcQqzfdmTJC6FAjcUFppJuzd9
	 ValeWEhWSz02H/bfIARGYIYGtCXyyKb7Cf7JphVJI5HAtF4k901BN0fs7LSwgzMCth
	 GTlGDoVS47cIzHRVxFo7+RbXBYmXVGIL+rEAUYcHOdAxR9lkrjctVgFMj4wXOe9frA
	 e8ByrcdH8fbG0QVJDCgIyMEUcXjUb9xhwfnAgLZnlMe0pRc7TuargZVqruQCfkpcWC
	 NZR9+jQTjAYnM+JAlDmuc5BuYUVUBL78PGoOu7cyGJKsa/oWRspkryNHTBuKKdW4Lm
	 8BCumWg+5BynQ==
Date: Fri, 28 Jun 2024 16:06:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	linux-rpi-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jim Quinlan <jim2101024@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>, kw@linux.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: brcmstb: Update bindings for PCIe
 on bcm2712
Message-ID: <171961239921.291085.4029532973752120923.robh@kernel.org>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104544.14233-3-svarbanov@suse.de>


On Wed, 26 Jun 2024 13:45:39 +0300, Stanimir Varbanov wrote:
> Update brcmstb PCIe controller bindings with bcm2712 compatible
> and add new resets.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


