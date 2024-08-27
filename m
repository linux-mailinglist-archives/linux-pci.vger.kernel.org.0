Return-Path: <linux-pci+bounces-12244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3438960183
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A371B1F21173
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553312E1CD;
	Tue, 27 Aug 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2gL4dQO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6267BA49;
	Tue, 27 Aug 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739874; cv=none; b=mT924ntRswL7YYbKM+hxwfWYFYDiExR/HuZok+y8y/zKsRgTm7VTtS9KktcL5KuctkD+44bsD2ALtaGS9t+35C7GjfZwL94FQxJ3FdKdGEaGf+5bwkQ1Mnl+MXxCTsbXddwExGMjD9IaFtUPYJ/xEIuY/oX9E7DJKo7J6Gui2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739874; c=relaxed/simple;
	bh=eiyBCHlvira5vozuY4SS6oQOMVMr3NqhAQQh4AhxF8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWTMuFa/smDCcaXjm8OhicNXn+SYm+VIj74topn6PhUGEvCPbtNiN/0JoO41W3vVZFGv8jxtZsrErt5eJ18pl+3Cew6A+21cVmmrrNZsDkd7TpIc1SvRZuiko+89P0YzK0jlKmhtY7+Q8X8B3mbJ6PFQ2/qOz/qjLlIk+S3GYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2gL4dQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754B3C4E68E;
	Tue, 27 Aug 2024 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724739874;
	bh=eiyBCHlvira5vozuY4SS6oQOMVMr3NqhAQQh4AhxF8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2gL4dQOC+6Pa8coExiUQ62UkHTnr0v7NVrt4TDtf8rM5IC6FB4HPW39qU5a7R9nB
	 VZUnmGhOvtnZP+4w/XFkIIV1JxfQhAKItyOzIkfK82ftI9zjB991tZjs8dsH5zi8TE
	 GH2jg1OFqHKIDRkAPYbzvK15NX7VxAly1Fu+uRGEtvwDr65bz65i1VdgENRDO9ymQM
	 dDfdGN7UN3izcnzpkfAJuT/zUwbGUEGrOHh7K/qL+eIrgukPZlTLctBvH+8yOPvtB7
	 QYcl2HqVyw02l59nr3XSlf9MY0ZA1jeH7TXFz9rZ9kvzCbtfp8mZa5Rue7Qyf5QVnW
	 mVgygtRnyIyRQ==
Date: Tue, 27 Aug 2024 08:24:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 0/6] Enable IPQ5018 PCI support
Message-ID: <wq5mfkqvvclubmacu5ogptdeaahxr77hk73dpmcvcelno5ylpv@4q4hfuolzky7>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827045757.1101194-1-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:51AM +0530, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> This patch series adds the relevant phy and controller
> DT configurations for enabling PCI gen2 support
> on IPQ5018.
> 
> v2:
>   Fixed all review comments from Krzysztof, Robert Marko,
>   Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.

That's not specific. What exactly did you do? You must list the
changes.

Best regards,
Krzysztof


