Return-Path: <linux-pci+bounces-20271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A6A19F78
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140EA188F86F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE61C5D5F;
	Thu, 23 Jan 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqg1MpIz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A042F2A;
	Thu, 23 Jan 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618919; cv=none; b=ni0wYx+HsRlU5pA5K+rmF5os1OfWCgAXeTkjWCZZwK79oBhf2pDtDzi23uJS00uJZ7xTI1kZU4F4fY02Oaz7vY3zgfnuhxw7Ebxu40FJCEG/Ztt3J4TsA/vglD9L3D7PBG1cVKc0VQFBXYrZ2gklIRSx7PA/UJidRUCoGlIxAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618919; c=relaxed/simple;
	bh=xKMGVhtVXJCt5/79wNfkPhu18XGqd/fBNpa0SKw3Z1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl0SJeCIjvfmSYtau9uvpc7IqhazP5rY7gEKvEh0hqwf61Satiar/dt4ufX44UJQJfBQ9u8Mh0o0wI0IHlS9lMMcnLFmKas3Uxhm++pVJCgJGW3ClmxLRjZ4NUVU2mNyyZrmeGizXQqKC534bD4FqjjmDdTwyOlAxT8MLJFH9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqg1MpIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8DFC4CEE0;
	Thu, 23 Jan 2025 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737618915;
	bh=xKMGVhtVXJCt5/79wNfkPhu18XGqd/fBNpa0SKw3Z1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqg1MpIzA1wVo/F5TLflpCwD2Z/r47gJt64813owDEgHHjeGakI2DAL8QqWNgHN+y
	 PMh4oKo56MOtD1lyVD3FZ7Fqz3BVxELMOsv6GWziMnBZcmJ+ofxT/uWgOpyKQkK6zI
	 q+Jp3XgEtsAAp4ZdbFGKETmLH9SK9CRQdWtZCPRt7vECR3j82YPmUl3KbZmuB2C3W6
	 yo4CeIz/0VS9hFEU5RwjnVq3TdIopbMbhhn6Y5gFA2SyWxHinl9M9wViJlCCFUqFFJ
	 Ih/hz4VQ3ZBQAyzqtgFJvnkD6U5srsYKLIJOi76S9q829JPu8gsEKu8Zkogt1ExNdT
	 DjhPntJGkkwaA==
Date: Thu, 23 Jan 2025 08:55:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description
 for ipq9574
Message-ID: <20250123-talented-inventive-caiman-a2f29f@krzk-bin>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122063411.3503097-4-quic_varada@quicinc.com>

On Wed, Jan 22, 2025 at 12:04:07PM +0530, Varadarajan Narayanan wrote:
> All DT entries except "reg" is similar between ipq5332 and
> ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
> additional (i.e. sixth entry). Since this matches with the
> sdx55's "reg" definition which allows for 5 or 6 registers,
> combine ipq9574 with sdx55.
> 
> This change is to prepare ipq9574 to be used as ipq5332's
> fallback compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


