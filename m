Return-Path: <linux-pci+bounces-12271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8A960911
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E02E1C209B7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7231A08DD;
	Tue, 27 Aug 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb8Uha/3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726E17C69;
	Tue, 27 Aug 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758793; cv=none; b=jToK6m2pBkkr9EchJgrEsAQ3dzmA97nOt0+emYYxYtP019Jht0Ez7VIbbpPApfrXyN2zlxycz+NSLwqKTH90lPvk+ddIlpDTjXLsq6QaSyQjt0GCz3Gr4EpDu5EXma2IExKI68giAvyrXW0GUvdtqEfNUVV6EtQCq3cn8/6sARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758793; c=relaxed/simple;
	bh=4KOpM59ML50YOGsvJ+3FE065aYzzXQptCLzDTnBVYSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JepDiQ7VWv0ODmTjY11Lz0ahKV8j3qlmJvk2qdyx9rLm7Ao2FZIL6sYKIXUMduiyQUF+pvbqN3Z7JRKL/nTq+aFuFbUenjD4+sGQ08gbNAA92l1JOuoBpqf72TH3nLMmgS8f3zINrgQpVF0kCdbTV8KfZbsmGWY1xOCbA+bP8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb8Uha/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5202C515C0;
	Tue, 27 Aug 2024 11:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758792;
	bh=4KOpM59ML50YOGsvJ+3FE065aYzzXQptCLzDTnBVYSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb8Uha/3QANkxXd9ZcRhuXvn2zqZZBvHCLZZxmH7fMhC4OGigRNX0UvwGmbO3aZAO
	 vml+wWHZOQh+c50od7XsNzM+gWkVXcUwEit29nDDsaxanFZWcZKHfGxtKuk/0Qj3Y/
	 OLY7dnoL5c5dHNcUN/Eg5edjDr6/efAZbE6oCQEUwyVruQMQP24F6CKke19Gr1hLxf
	 g+dDoCJuHwVaBahO7qtHr8Qi+9B9FugS7FzfgaYC1Msxj0QfHHylr71KWWaK10dMWY
	 Qja6ugApd2OLReR+H0ifMqWpocrdciHXGzHt88RJPJPtubM6qgIViSdniT00aZP6Ye
	 CNdmKXNN/WzPg==
Date: Tue, 27 Aug 2024 13:39:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/8] arm64: dts: qcom: x1e80100: Add support for PCIe3 on
 x1e80100
Message-ID: <ag3h77zczj5ttuz4bjhtqxpllyt4di77gwaavdcdlhr5anv6yk@ygzb756hcwvm>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-5-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827063631.3932971-5-quic_qianyu@quicinc.com>

On Mon, Aug 26, 2024 at 11:36:27PM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 205 ++++++++++++++++++++++++-

Why DTS is mixed with the drivers? This patchset is organized in
confusing way. Please use standard upstream submission process - DTS is
always the last in the patchset (or separate).


Best regards,
Krzysztof


