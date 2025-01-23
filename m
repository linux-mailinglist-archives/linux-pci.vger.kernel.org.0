Return-Path: <linux-pci+bounces-20270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E70A19F6F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706E716E0B1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704C20B802;
	Thu, 23 Jan 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Exsl4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCA1FF7B8;
	Thu, 23 Jan 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618881; cv=none; b=s5euWDv28S1I081hCAGXiP+1K3D6kgXzOOTe9dryuEd1WeCkU5ouglxDVsxR5ZhvWFSQ6DPrk6gfwPHzgyn3ISVlYNnkNydZfB0OJawK8HC80r5tx9zYttLh19c2Ze9VoysakKz/9tRAl54xOB8G9FCaBdd+fZFpQDV4y+ilFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618881; c=relaxed/simple;
	bh=OrYcjJ5hzXu+46N9Vw6qrqFKTskY2lWjkvcWkrgGb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebstOsk5gxjY2aeuC/W0VRb0AGpvTsCSLU3GqofxLXzKX/SyZn+mnFqKoT8dp1LVik3ke7MS8EnkA49uDiRb3AakCH/6sUP3krkS+lRgEjqy/xLzOVOu5N0HCXPU646uDdYoqDzQxw9UaLogPvHGwBbulRgZQ+HdX+zWoghG8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Exsl4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB1C4CED3;
	Thu, 23 Jan 2025 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737618879;
	bh=OrYcjJ5hzXu+46N9Vw6qrqFKTskY2lWjkvcWkrgGb0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+Exsl4h6DMWnWCX1BbBSg9OMibYJglDCEoGX8rFhmA1WZtT3jVtpKv5WVPCnSkiU
	 tFsgTfTWoHsKrZf0LrcTf1jGSoXAAtTEd+8zJ5NrXgGYLbeP8EdziU/5DA2XFHuEfr
	 XoUYhOFG3k0E0RRrBRT6zGEXWZGbPdEIGz6GylgKg2x/QW4zlXHAGuTp6DOl4xngxX
	 r9BamiDr88QmR76e0xVQXWvnUljatOeuS5RMbDGE5XHGHXXV6J1ljQV0y0qfNj2OGt
	 xtuHlp1CrTsOFIWFnBrWAmqhHYx4GaoQydiCmqIWrzhho8vg6vJ8CKFZRs0UVxaCA4
	 OakAcC9NnEgtA==
Date: Thu, 23 Jan 2025 08:54:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 1/7] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <20250123-analytic-pragmatic-bonobo-a0f5e1@krzk-bin>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122063411.3503097-2-quic_varada@quicinc.com>

On Wed, Jan 22, 2025 at 12:04:05PM +0530, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v7: * Add data type definition to 'num-lanes'

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


