Return-Path: <linux-pci+bounces-20667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D8A26073
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CDF3A3D61
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5414020B20B;
	Mon,  3 Feb 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEz5s9K+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B4204C31;
	Mon,  3 Feb 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601075; cv=none; b=AsrUFsBJ/GpmMCHyv28e+PnSljY6RQ8w8lS/McY9fdNGJWq7jn8hCqqyoMHHwAC0ZfOcwkQgoT6za03qbEscDoO7MRULi6F3ZjP0DSzqjOyACM6NowRvL3VihbOSz/9BdHM0ZukXwp7hBTfUv1Ko7vKcpNs4yXFn0f4HUp1VCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601075; c=relaxed/simple;
	bh=BcYOm4v3nFF2x/YWxsfMCugongeIvbe3dISHErnwZvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jq9crrLVq1f71t7D2QZpvAxiQc9MKtbS0yCkRAYUcP9zrhnz5T9sxCeE++eXrgZz8i2ucSBGjoxgNJiNRxUyvTUsxfsYrGmCu69jjQZETTehNpfUsT0AjX11hlWT+PlRQci32UBRUTRJHEsIhoXgcxnrdzwdo3s7gBcxcgoXNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEz5s9K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA46C4CED2;
	Mon,  3 Feb 2025 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738601073;
	bh=BcYOm4v3nFF2x/YWxsfMCugongeIvbe3dISHErnwZvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cEz5s9K+Z5g3cCgQvRwYraPOumID4URRXs6EZa7g8GMeOqBTNkEtxCKQ03Sl9BAVV
	 ymqTvgHh+TtzAnIxOGyOhj1jDbjAo3+naOPwJiLmtPKyZJpCCoK7LrqgboScVxeK8B
	 6c2VKOdGqktlyKDOxDiJRrazXVDfbfGA2L/+crWQzudJgxP3YRgSDpSz77/dqonzNc
	 W6jkFEn1Nt9ZqPUIAtHRt1XwZmr1ObxDPbTean0VyQfNTQcAgcW8Wh7B8R0JCGJyR1
	 ul4F9CztfTKmxSKGG0SOjw0PEVF027h27C8y6hN9PuFFMa2cUqF4gquLisoclpQmE7
	 tMRNpK8l9d5hA==
Date: Mon, 3 Feb 2025 10:44:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org,
	quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description
 for ipq9574
Message-ID: <20250203164431.GA788454@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128062708.573662-4-quic_varada@quicinc.com>

On Tue, Jan 28, 2025 at 11:57:04AM +0530, Varadarajan Narayanan wrote:
> All DT entries except "reg" is similar between ipq5332 and
> ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
> additional (i.e. sixth entry). Since this matches with the
> sdx55's "reg" definition which allows for 5 or 6 registers,
> combine ipq9574 with sdx55.
> 
> This change is to prepare ipq9574 to be used as ipq5332's
> fallback compatible.

Nit: since there are apparently other fixes coming for this series,
rewrap all the commit logs to fill 75 columns (so they fit in 80
columns even after "git log" indents them).  No point in artificially
short lines.

