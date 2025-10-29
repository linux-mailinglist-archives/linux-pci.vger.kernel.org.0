Return-Path: <linux-pci+bounces-39686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F1C1C832
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78463646566
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134D2D063E;
	Wed, 29 Oct 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enQR59jh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC338F80;
	Wed, 29 Oct 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756385; cv=none; b=fGOsIx9Hg0bCOvz3P0HLSdt0SZeOaQrK5eqFuR9TFdmJhM6Y2o0oedED/OB5deP45HamMCOm9TtCksv+l1ZrUrXiDqSCSO7jrpsd8U/iywjtw+J3G7+Js1+2KrcuDw2ySLtgXXzj+aNuo3JjXWVUy4k0aFxP/LZra2O+NlTULrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756385; c=relaxed/simple;
	bh=1wHTyfHcCvA7hCo0cByI9EKq0KDnXxwt2RgKk4naDnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s36+njiYCsM4LLwubDhuwrNIMJl+h75e3M272yFK3z8eFXwAlxpJ3ju/9LMBhOA69IWSudr3Tb/jRFs1Sr4zhskMkK2N4xCtjP+drjgBOE6CH6NKXBJ71cT8jaByhZizBbmMppdWxiDMuwsY3bVXiTg7qlL+Junb29WtB4hxX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enQR59jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7B5C4CEF7;
	Wed, 29 Oct 2025 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756384;
	bh=1wHTyfHcCvA7hCo0cByI9EKq0KDnXxwt2RgKk4naDnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enQR59jhZ3V3HgFXlpnmI5zXIRRYY7VIh/eSvu+R9Lj7qehfm6stRKDnLBb++y4/Z
	 8MkYiFa9w+92dPjE4G0gVdusAmGfYphsi+50fErGmuM4fFcmeOe6lzoOBpib6bPneN
	 NkM/XWDmeba3a3JRtTs3B92onvwt/KzRtdW03WD7etwBSiesJFhDhlznSQtkNlEdAz
	 YmhVshkq58ak7w3N4dguZ9ZFU8X4daT96QPZ4w1gOcsEBFQYbBfFr7Vf/ekUzgDQeY
	 rPoBPX3BLNzSV6/K2u/4/OluQcJ6XMsdi1H4h7hZ8ZaLfEL7LGuUFFaPby+F0uidqx
	 x9A+yA6hXaT/w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE9Je-000000007Po-3IGG;
	Wed, 29 Oct 2025 17:46:31 +0100
Date: Wed, 29 Oct 2025 17:46:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Message-ID: <aQJE5kkOGh76dLvf@hovoldconsulting.com>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>

On Wed, Oct 29, 2025 at 04:40:46PM +0100, Krzysztof Kozlowski wrote:
> Power domains should be required for PCI, so the proper SoC supplies are
> turned on.
> 
> Cc: <stable@vger.kernel.org>

I have a feeling I've pointed this out before, but these kind of binding
patches really does not seem to qualify for stable backporting (e.g.
does not "fix a real bug that bothers people").

> Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
> +required:
> +  - power-domains
> +

Johan

