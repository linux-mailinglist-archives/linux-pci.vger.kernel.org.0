Return-Path: <linux-pci+bounces-4863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D987E199
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 02:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B01C20D34
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2017547;
	Mon, 18 Mar 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQozQc8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC3179AE;
	Mon, 18 Mar 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725049; cv=none; b=nVePsXl3wu8lwJlTIk4royGm+CAma/7eha2UL9eqAvHKHTIhwMiaHh9JCSSbk7jUPqEVv628yOzN/LsnxQigIdvmmUcbZj4rflyHAvQBzs1dWDrl5WmCZLzGTGm/rQ0gkRGsSNRCmA7KM8AWDdP16NmC8wS9ygTGxdz+NAtHNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725049; c=relaxed/simple;
	bh=+wfvHnwJWpfZDGn/7Sn97aBeOjz4tC3+nHOqRiSkpxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW8cASwbPvCcWcit1LAXje6u3XfC1+EQapy8cLN6qJGUtVanhEfZZ87YxMmXLrbp10t3LNiQ/cZ9KimJTcK5qv0Br6hTJZlH8vb9AFHi1lzBh+CBUPhRiAIWgeejvjX8gqix5ubb1c8G2ugoN6slbEQmuFTMSE7YG52FNLUbf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQozQc8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D1C433C7;
	Mon, 18 Mar 2024 01:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710725048;
	bh=+wfvHnwJWpfZDGn/7Sn97aBeOjz4tC3+nHOqRiSkpxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQozQc8gbodC6KvNGzCsF9tEaq1ZXPHr/ZCwmtz+4zNnZaaAeaolAH4IiW7BtsiXD
	 A++0Do+rE427NeibdWKRcW2D+CoctBncoYacjXixE7QZ1J5U+LQo2ZJKd7yABOq1Fd
	 KkP1sN39X2oA6G64NSbbWwYQk8Ds8HEbBzsF3CU9ls2nVmMYqWxU9nUINN4as1bE8Z
	 PB/BvjjGbY2tgBT2S1lbaKPpB05s+Bpq/oytolz89AMYApRqnzs/KjaoDKjdR9Uh5B
	 aUecHpRB2dQOOSZ4FYufrOgujp34GQ1c0j83eoX0TSXFKo9ebmyoF7jEespYlPz77G
	 vB1tKj8wH3X5A==
Date: Sun, 17 Mar 2024 20:24:06 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/5] PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p
 and sa8295p
Message-ID: <5o5vbnxfsiokjf2ahrppr26oyuqhwhdos3374r3zpexunhc5j7@yquaupvfywbz>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <20240306095651.4551-4-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306095651.4551-4-johan+linaro@kernel.org>

On Wed, Mar 06, 2024 at 10:56:49AM +0100, Johan Hovold wrote:
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting
> 1.9.0 ops") started enabling ASPM unconditionally when the hardware
> claims to support it. This triggers Correctable Errors for some PCIe
> devices on machines like the Lenovo ThinkPad X13s when L0s is enabled,
> which could indicate an incomplete driver ASPM implementation or that
> the hardware does in fact not support L0s.
> 
> This has now been confirmed by Qualcomm to be the case for sc8280xp and
> its derivate platforms (e.g. sa8540p and sa8295p). Specifically, the PHY
> configuration used on these platforms is not correctly tuned for L0s and
> there is currently no updated configuration available.
> 
> Add a new flag to the driver configuration data and use it to disable
> ASPM L0s on sc8280xp, sa8540p and sa8295p for now.
> 
> Note that only the 1.9.0 ops enable ASPM currently.
> 
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Cc: stable@vger.kernel.org      # 6.7
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

