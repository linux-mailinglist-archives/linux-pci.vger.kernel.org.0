Return-Path: <linux-pci+bounces-30126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09DADF64A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA001BC1D94
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7C2F4314;
	Wed, 18 Jun 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e14iU62k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB83085C7;
	Wed, 18 Jun 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272764; cv=none; b=qP7N569x8TxGkQeanHTXZLJ7BYsZ0C8oyJ2Jbyasn/mMHYBcB3IzsqWqeG6bK4CeCZn8MAPm1PbV8+DLzqC+L1KODe8P+C9w6EAcO9O/J6qS6+IQlEAeGSKV3zq8Mlu+mAAxZ4ZgA3fdY+k9oxlJOiePAYzkzLl//4iTWlzGvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272764; c=relaxed/simple;
	bh=eT+6E7j8MKpA8+JuN8R6/MizW9cXPn/MID8D+godm0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icAGdCk6IVsNicjVpbu76OefC0SPwOVhpRjaCAGKN3ExZE4xtRzAlzgU0AyfOrP7kqtWEEQP5weIq2A2KyNibYUZ7HxJH1D472wB75vXfLI/q8Mb/haBB1bHNA/0xkfnFmC93kkpV0sjZr/LEm7YlxcTtPHvt6hRU6BB6UKGLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e14iU62k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA7DC4CEE7;
	Wed, 18 Jun 2025 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272763;
	bh=eT+6E7j8MKpA8+JuN8R6/MizW9cXPn/MID8D+godm0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e14iU62kh532Ydae2EKi/eDJxL/gMzuUZYstiZIrzXP54BHZd0y5VwL1wkYK+QDGX
	 F3AFZ9wL4NL1dpyvtxuFRG8tirtdcv315QCN8nNaayXQXDWYUyzqnhQx9w2sPsgYz0
	 +EZHmF0n9J0RrasBf89OH6yxWdjGdhsac+QmfqB4RqEMJsAsfx3SoNIrA4oiCUWhNh
	 lEciGngaQJLAKAyhA+I2rTf6P4Pm9vd46BRUIOhNa5MEXCrLkd2ut4VD/znDZIuRiC
	 2fALmk4jeJCzNOFm680tjXnOsfC6J/rxsQsXwb6KJRFXYPSBYteOVWqNrGQbgDGqWX
	 AE6VYyVduXLwQ==
Date: Wed, 18 Jun 2025 13:52:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 01/27] dt-bindings: interrupt-controller: Add Arm GICv5
Message-ID: <175027275990.2508078.7812820935724706534.robh@kernel.org>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
 <20250618-gicv5-host-v5-1-d9e622ac5539@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-gicv5-host-v5-1-d9e622ac5539@kernel.org>


On Wed, 18 Jun 2025 12:17:16 +0200, Lorenzo Pieralisi wrote:
> The GICv5 interrupt controller architecture is composed of:
> 
> - one or more Interrupt Routing Service (IRS)
> - zero or more Interrupt Translation Service (ITS)
> - zero or more Interrupt Wire Bridge (IWB)
> 
> Describe a GICv5 implementation by specifying a top level node
> corresponding to the GICv5 system component.
> 
> IRS nodes are added as GICv5 system component children.
> 
> An ITS is associated with an IRS so ITS nodes are described
> as IRS children - use the hierarchy explicitly in the device
> tree to define the association.
> 
> IWB nodes are described as a separate schema.
> 
> An IWB is connected to a single ITS, the connection is made explicit
> through the msi-parent property and therefore is not required to be
> explicit through a parent-child relationship in the device tree.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  .../interrupt-controller/arm,gic-v5-iwb.yaml       |  78 ++++++
>  .../bindings/interrupt-controller/arm,gic-v5.yaml  | 267 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  3 files changed, 352 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


