Return-Path: <linux-pci+bounces-8088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD178D50A2
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC18B24666
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934746556;
	Thu, 30 May 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtWM+qef"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A546435;
	Thu, 30 May 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089079; cv=none; b=ppH/iiMhgvzsTHKxcisjGaV+WeNdsGUvGFU3tDKoMQ3gDcV7BnqKyuxfBTzfBOojpyvs/Pm96k5dyTKSiOdzJXkIE6CcvH4EIv/GkukAUG2+2cs1YM1M5/YJGhBXoLuY8s2KhciS4t4b+t5dTTGuAXT9xQprVI60scALRtwSkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089079; c=relaxed/simple;
	bh=iGoKvNnQ+YdL4/1r3sPYk9sQQvMBHfX0Xry1ufnrd68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zb+q0fd0AttJg8sbaY5aw/RGbMTB6Y2FLQ2uZ4VDCZDzd5d3sjXVLhXgwaeBCR3OFx80Uh2jwliCQ680+Erj+5CHeEYmoj598xviE5J6y9RSlnKzotmbyzSbwXp0YFqFhyq0uWP9413rkcN29aGAYECVxzPBjkH+MhluUm7ttPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtWM+qef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FB5C32781;
	Thu, 30 May 2024 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089078;
	bh=iGoKvNnQ+YdL4/1r3sPYk9sQQvMBHfX0Xry1ufnrd68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RtWM+qefsV3TB89kDCxjJfEgUdPE3oWEdnyu7kFtZPHC7wNeHx+A42A1/fEtbIySp
	 dB4khKL+W4SAytw/vjJaTei2kvEn4O9QHLC3jSTH1+lghFWKk55ztrjDslSwsHKs4u
	 jSLKYAcxzXkCEzQDrDA2u2+WczR5SreygM5cftnYkpkx4IM7+XFhXFFtUGZP+ySwYN
	 rdPH0b0trQ6tvEmCWWG2NhWOhz8du3xeL310LjaMBrZZuJJhRdufuAc4pML/gQxSkS
	 80DdAGja0IALTVGznnvulS4+YhCO0msT0xYnjfD+DaBhdHOf8g8csIC0R4fTmn3Kbs
	 NQ8aha0eYHO0Q==
Date: Thu, 30 May 2024 12:11:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: devi priya <quic_devipriy@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
Message-ID: <20240530171116.GA551131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512082858.1806694-7-quic_devipriy@quicinc.com>

On Sun, May 12, 2024 at 01:58:58PM +0530, devi priya wrote:
> The IPQ9574 platform has 4 Gen3 PCIe controllers:
> two single-lane and two dual-lane based on SNPS core 5.70a

s/4/four/ to match "two"

> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'

s/Added/Add/ (use imperative mood:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94)

> which reuses all the members of 'ops_2_9_0' except for the post_init
> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> and 1_27_0.

Add periods at end of sentences.  Rewrap to fill 75 columns.

> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ_1_27_0,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);

Fits on one line.

> +	return qcom_pcie_post_init(pcie);
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);

Fits on one line.

> +	return qcom_pcie_post_init(pcie);
> +}

