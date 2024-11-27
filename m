Return-Path: <linux-pci+bounces-17421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF759DAA2F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81509B223C1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20361FCFD5;
	Wed, 27 Nov 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+0diw/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D571DFD1;
	Wed, 27 Nov 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719120; cv=none; b=PPbOonFjOD8RHK0LYm+yFkZGyJJ8XjAPc/CqbnYNmOzTcAXsYr/G9aMqyXTVxXZG2bhTzehtsKPl2ATIp2yaALKZ2wa9TEuHYr1Z6r2C/tUDV2OKNjWRcgCN1CFXGrEndgLHqJiUgAhi74+bGNWMp03mCittgIOt45EuKC+qUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719120; c=relaxed/simple;
	bh=4AGyVOnYw0w4dA8qEhJmW3K+EMnHj8IiVSZHynrM+v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC4nfrznN6xL7opnJqx2c/urwhvmUQGwolemp6bit9NAh56w7oxHWQox/Aj+DQMVgr6cHIQbvaOk03gnFFjBSFdgZcRlCUbafcuqWDdfg5HZ0jD4eO+VvAVa6sv1wmJun9XShH7CcrYm6xi4x0qJagcmMr74zGr0PFfHfkmKFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+0diw/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40AAC4CECC;
	Wed, 27 Nov 2024 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719120;
	bh=4AGyVOnYw0w4dA8qEhJmW3K+EMnHj8IiVSZHynrM+v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+0diw/SG+LpWSeAMVxpAb/FmmbAkmMGG4B7vDhTX4AJVjigqTnN6FJoNLQIeH/Zt
	 JSwce2GHbaJki8uXr4zdsMlGJi7I4ZnMR27D4EGyQJj4kBliw44EyMT2eWb3IhQABx
	 8+7ydZJomGric4n4nS17nh/VHVhZLHhJ4lkRqmtzdoqBZUBDMioIuSueVVFlitriZy
	 faz3ac/nf1mI9mvxZN3k80Owjx218EAyBOr5mhiXennGgJACEavucWOVfkFOuDqtYn
	 0ElH5Ab4Z+VsvYq89DktlYtAlQHccODmNWBWiAUjkcmQc+kgUrxApHJnF0T21tn1Av
	 97VJRqWszflzQ==
Date: Wed, 27 Nov 2024 08:51:58 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: PCI: Add STM32MP25 PCIe endpoint
 bindings
Message-ID: <20241127145158.GA3480289-robh@kernel.org>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-4-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-4-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:17PM +0100, Christian Bruel wrote:
> STM32MP25 PCIe Controller is based on the DesignWare core configured as
> end point mode from the SYSCFG register.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-ep.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> new file mode 100644
> index 000000000000..0da3ee012ba8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP25 PCIe endpoint driver

Bindings are not a driver. Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

