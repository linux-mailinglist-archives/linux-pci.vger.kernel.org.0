Return-Path: <linux-pci+bounces-10189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248DC92F113
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3761F23C50
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC619EED7;
	Thu, 11 Jul 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DREV2l0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A288BFC;
	Thu, 11 Jul 2024 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733101; cv=none; b=MBOxtoR+dPnUrPlChkUAXw4WOorob0DvAHyqPL3K0McpJSynhU2pyG+6tsMovQTxYb8V7Xz+nKjMgOphp1u9qwR3/iilrf/AVjETG23NFsdY9LFmcrX/6bvE1hPJ3pP3lvyulFODREgSqIJUL4eyEeInRnSXnLPv6m88XJ33JtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733101; c=relaxed/simple;
	bh=kq8pr4okGvGrj4gNPhJ+8x7z/fJOCIcvHjdaUUfNYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4x8+56MysQZEFJeTDvbp/40kF6UA7MgKzivl1ncC9Perxi3ZuBpH3s2vjk4eUS2TSnBjW/7Qn+fYWvycNxPA+bMgbkCsKdqOnDquXNKKy34wzpwSwxlKUcXwDxWGvNrJpK2vWd+q7SC1JbKFAWB5QCVyqez5tgQSc0qGmbVZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DREV2l0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4B1C116B1;
	Thu, 11 Jul 2024 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733100;
	bh=kq8pr4okGvGrj4gNPhJ+8x7z/fJOCIcvHjdaUUfNYbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DREV2l0kP9B9m5OSkZlC8KzX1BkGPoFSGHwwoXuCrc3XyZnhOT428S530pb/hDgsm
	 gBZ3LgXKjLMXi5RcleYVNG/eXq5a3BBTKDLffBODuJY2y8Mgn+BH+gLoi+tGE42K7w
	 o52gm0Z3jr92f16aK5s1I2lGwgXAHPZr9Xa1XmTeJSnUq1V0ftj3Z2JzVKg3z/t+rg
	 Es5JagFVM5tFsTI4UbTwy8MRkWwUoUO0NGMTCRrH5kbvsAz2+RgPxTThT+TMmX0R/G
	 B/lqXcY3foaFUQtF5DRTbmATxGw6/0zKi1XmCyTRLuILreSJVP0dKgwMU8/0LkJ2yG
	 hB0WVsHyOIgcA==
Date: Thu, 11 Jul 2024 15:24:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>, jim2101024@gmail.com,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 01/12] dt-bindings: PCI: Change brcmstb YAML maintainer
Message-ID: <172073309845.3035345.4782814760487454161.robh@kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710221630.29561-2-james.quinlan@broadcom.com>


On Wed, 10 Jul 2024 18:16:15 -0400, Jim Quinlan wrote:
> Nicolas has not been active for a while.  It also makes
> sense for a Broadcom employee to be the maintainer as
> many of the details are privy to Broadcom.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


