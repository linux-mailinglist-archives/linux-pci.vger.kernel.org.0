Return-Path: <linux-pci+bounces-25064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0717A7798A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCAA3AC8DA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94401F236C;
	Tue,  1 Apr 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOLLDg30"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78651F12FC;
	Tue,  1 Apr 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506937; cv=none; b=cEXybUdEBWPD4OZxRXlOLw9cF7YnYuv++6H2n/MH+9cPPTTUGYPh/SE0zVdVYDC1/JOaqmZplHb807dic/i67DUs1Z94zByj/42M/A4UJtlEpfFnOXM2ZNZq21zKk2sHofrJ8OgSrhZTt037LkFK2an8FufxbcC27O7skh1JpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506937; c=relaxed/simple;
	bh=DaYueR7dUNDwVsECkuaNXT3p5/kpPUyydXjCO2RALyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSF4C7ki+hP2FyOw9gNrxhbU7dexKVWxLJayHpWf5BGSb6NwhwGeojIUiE8COXa3APxcDfl0NxLauYVLQ57399CMM8MnaFklBoZXSWk3nWlYun6ZEZuVLhYLMvbkx5mOyms3dFIurIJ2JDjKke6hxYdY4MrsC8ftlJmQF6l5LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOLLDg30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C312DC4CEE4;
	Tue,  1 Apr 2025 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743506937;
	bh=DaYueR7dUNDwVsECkuaNXT3p5/kpPUyydXjCO2RALyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOLLDg30OXhbK+MphiB+Vy7bXzP49h1ihSXmPB+if7qbiGShHOuINIHjb9tM4eYzU
	 DcyX3Kz63c0TfWGqlLbmunZBbr8cfomlCkx+8wS/HNOrbQmNs5CQcw/43hjjQQA/+n
	 HevMxNXzIU3r1qADvSUNDuc0QHoT2lBql2cK/PH2HG2386R+jQ6kk0SsGKCdD2mJ76
	 sRk8NYdSX3YjtQy1xdyEyUpfT/V/3wYjs1Zz+IaGLtRQauKhHPRqYAvbjZxacMBJXn
	 NtUQlDRjrDhMIfQ8nd3j88d9gp0/ysHZnFVt1bfjSsiCx+/ASu0+QdU8oe2vfKOCFx
	 yRksKLjmWRFaA==
Date: Tue, 1 Apr 2025 13:28:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, vigneshr@ti.com,
	kishon@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, dlemoal@kernel.org
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <Z-vN8_-HJ0K1-1mH@ryzen>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
 <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
 <20250319103217.aaoxpzk2baqna5vc@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319103217.aaoxpzk2baqna5vc@thinkpad>

Hello Mani,

On Wed, Mar 19, 2025 at 04:02:17PM +0530, Manivannan Sadhasivam wrote:
> > 
> > While I don't intend to justify dropping pci_epc_deinit_notify() in the
> > cleanup path, I wanted to check if this should be added to
> > dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
> > is different from cdns_pcie_ep_disable()? Please let me know.
> > 
> 
> Reason why it was not added to dw_pcie_ep_deinit() because, deinit_notify() is
> supposed to be called while performing the resource cleanup with active refclk.
> 
> Some plaforms (Tegra, Qcom) depend on refclk from host. So if deinit_notify() is
> called when there is no refclk, it will crash the endpoint SoC. But since
> cadence endpoint platforms seem to generate their own refclk, you can call
> deinit_notify() during deinit phase.
> 
> That said, I noticed some issues in the DWC cleanup path while checking the code
> now. Will submit fixes for them.

Could you please elaborate quickly what issues you found?


Kind regards,
Niklas

