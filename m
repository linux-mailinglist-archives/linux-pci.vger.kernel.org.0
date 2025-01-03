Return-Path: <linux-pci+bounces-19207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47ADA0052F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063B3188405C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7A1C3BF8;
	Fri,  3 Jan 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1OLao/u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13401C1F10;
	Fri,  3 Jan 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890141; cv=none; b=U6/WVvBk54LoHwZvX+Z466WHbvFGybhYAIl5wy5mFSG1JCMZIuVnCITwTaXgdcoLQDYHPu9C0CpNOObC7k+nesOuL4E/aP1/hGmnKpBsC5+T+eWkiiOptSwr4BttQQBFdRZAYqfiTzXdGvU9ivKiF/lC3KqCWln+qE1iKX3+1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890141; c=relaxed/simple;
	bh=Zo2LGaP6JfpLkthOZwDrMvwqIAlhxp2dBRQ4A8GvYO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSdCaQynxAj6cakjFSPf0TAUgO8Fh4VlJIQKKgGWUiZZLikHVFlxXlMO6C9tlNVXk4U80WEkT/aB12cFIXzffZ72mcCUtFYeA5AyiGO9weZ+0NR8Zk9KYQcz+mISRgJ7wRaj3lP8vvYdIrFR7QuZQ+XZBLnuczZy2J4mPMkWXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1OLao/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00950C4CECE;
	Fri,  3 Jan 2025 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735890140;
	bh=Zo2LGaP6JfpLkthOZwDrMvwqIAlhxp2dBRQ4A8GvYO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1OLao/ugA7pp5i1/BY+iqZ7FeX6FjrJv5aDpAkZcNwPbnK7AkKanAtZ2aNI05Ha6
	 RFloi/jZrc6n8dugCCP5bgnGK0TElnhYW81DeUU7GAELRD0A9/iYMKpywGZRs7RXN8
	 iiLMmjDupMJtMcxLgQbfV7KB/7otCzSElkkdXDIojDD0WnWSATllJaevF0aIG7JvRU
	 wx5fA58BQvK491fQDhEP6GM9mOslKkIVFYaF7yWOc7pa2O5aI47FL8nppyCRFDoa8P
	 5Uy9bHhKVP/w3B9xtLsrtHHVifSsUzi2EIP14wpraFJQvBdfarWHDPKE6IR9TqHbNP
	 4sdbLT+fAUQng==
Date: Fri, 3 Jan 2025 08:42:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <ihjgmi6hd5dzv4kxskerc7px4u4tynwxa6edwa2mozzczdar3b@xdplqfwme3lm>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102113019.1347068-2-quic_varada@quicinc.com>

On Thu, Jan 02, 2025 at 05:00:15PM +0530, Varadarajan Narayanan wrote:
> +  "#phy-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  num-lanes: true

$ref: /schemas/types.yaml#/definitions/uint32
enum:

or this should be moved to some shared schema.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - "#phy-cells"
> +  - "#clock-cells"

num-lanes should be required. How does it work without it? There is no
default.

Best regards,
Krzysztof


