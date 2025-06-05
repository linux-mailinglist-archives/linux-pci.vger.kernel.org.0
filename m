Return-Path: <linux-pci+bounces-29044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190AACF404
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EF2188044E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559E1E5B64;
	Thu,  5 Jun 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8svjUn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE71E9B3D;
	Thu,  5 Jun 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140377; cv=none; b=MgnFv4R8ufLZlCMuKjbjLUE7JZQFN2ZFMZDRvmqvBzgLypKXTDXEh5xnVgJ2R57aLdBsNfbWTzBfDjbbPhrqkkmHiKiecUKMhlUDlXc5r0YPZ071blVcODaZEQHt5k6QwiiB9HOq7H6tY5Do4hjiW86vLjPX31JXQ/3orvYUACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140377; c=relaxed/simple;
	bh=MI0R8HITcFNmNRtLwaJ0PFb0ELfhM/iVB8q75aYrQgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8QGnqwQX5OGVtltOWcBpltUA/76QhPjTj9S+1cgzBEIMNrvzpc0F3vkiLK+yFonxXZ22GGXqGrXWdQ56hSNf6FqO7+K7GUHmfYmSqKbrIbe/V9CRtkmwQ2mjYlChHQLWlZD4Pq4SBIQxSksUH2lyaJPjJHeEqjfnmesYFED+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8svjUn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39781C4CEE7;
	Thu,  5 Jun 2025 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749140376;
	bh=MI0R8HITcFNmNRtLwaJ0PFb0ELfhM/iVB8q75aYrQgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8svjUn+D82cm2fDjyL39hf6xuk8KOEe9fjwlDFtLNpudguls4VUaVNY2N8ifEp3n
	 ciuGTkJBbxbqs9zpPW8EnJ5q+KAh1N9V2xpfi9ikAuAsrJJJt0WI2YUzPZY4Acn5q7
	 6Q70sD9QO8FvJEW9sFoEQR8jng1ZtP+lk4qgN0HSxDNZdbFHk6FlUSf7NRf/GkNmyf
	 mxPg3+eDRX/qpwcvmuJEMZk1GplieqaB6bzDaPuYcFqlXtX/4bD6sLiIUfNkHmRrAk
	 8sGZxGGC1Wt/7mKxwLUMHleHn+znIhtg7lsJhwrIrCTQU+ij0t0BiKj+oTt0F54bd4
	 wcO7QlXQ26IXQ==
Date: Thu, 5 Jun 2025 11:19:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
	kwilczynski@kernel.org, kw@linux.com, vkoul@kernel.org,
	linux-phy@lists.infradead.org, krzk+dt@kernel.org,
	andersson@kernel.org, linux-pci@vger.kernel.org,
	konradybcio@kernel.org, lpieralisi@kernel.org, abel.vesa@linaro.org,
	neil.armstrong@linaro.org, quic_qianyu@quicinc.com,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, quic_krichai@quicinc.com,
	kishon@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: PCI: qcom,pcie-sm8150: document
 qcs615
Message-ID: <174914037222.2791589.7402731623467975644.robh@kernel.org>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <20250527072036.3599076-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527072036.3599076-3-quic_ziyuzhan@quicinc.com>


On Tue, 27 May 2025 15:20:34 +0800, Ziyue Zhang wrote:
> Add compatible for qcs615 platform, with sm8150 as the fallback.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


