Return-Path: <linux-pci+bounces-31508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BEAF89CE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA43B2F67
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F9281366;
	Fri,  4 Jul 2025 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JENtlCLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27C1DCB09;
	Fri,  4 Jul 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615060; cv=none; b=L5eaLtEQVNWW2h9bc1ghGVqNES7vso3pi+qmZTD9nB9diPWmb0+oS7xrJBEQeMdoHbA5GBGn5jjpv4lcF6RiPNSqH0ExhtdUESW8Jtm37fJ/V8IteJQMC0tS4Vo533hIlDqgk9/UHjAlQLMP8RuvnOabs13kfCJS0/iQH6Nagyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615060; c=relaxed/simple;
	bh=3py9atRl0Vxy/Um+TpKfDROUTNTZjoIU1e1Qplz+cOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1pRSSBoe0O45fGRnwAvNZoA2B0nXEhUIZ9mVmhu7+WisfTLnjYKpjghTzfkQ5WXY6+R52PteQ5QGcutcbe/pOGusVLE/e2lw1wvDitzxKBRJ3v+O80dF29413LL9uMBHZ6LasoozqnUPUlLNw8ay3cuHgCbSqy3qAHgGlRSJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JENtlCLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CBEC4CEE3;
	Fri,  4 Jul 2025 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751615059;
	bh=3py9atRl0Vxy/Um+TpKfDROUTNTZjoIU1e1Qplz+cOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JENtlCLllPsXY9pgenywFH7k4WZgKcwe0zR9F1smsUoqcuXkcf4zBaXTQePWwev3p
	 d/ORjmX1B41ZyvPm7ibHZ43fGWUBAoT0pJUHOwOe8ZdP2XLtTpMhtyXwP2mE0wBHtK
	 bDWojGIrLQWroWdNHOVbsS6jybVELM+91vl2AE1Y6G5Ttgiki5FueqFNA8/azZMje3
	 PUjowvSHLFfrpC2ae9CItQb0e8yu+Tj9sT2F4qiD3DvgmvS26n+l1oqtmUycIiHneu
	 m2dGWfvqvkMOC7bFsSim/3dd6fPara90LedtTefjSf7udAnZrcmzP44ND3U2rot0oh
	 Uof1KrA/Fe0kg==
Date: Fri, 4 Jul 2025 09:44:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org, 
	abel.vesa@linaro.org, kw@linux.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for QCS615
Message-ID: <20250704-encouraging-pink-firefly-570be6@krzk-bin>
References: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
 <20250703095630.669044-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703095630.669044-2-ziyue.zhang@oss.qualcomm.com>

On Thu, Jul 03, 2025 at 02:56:28AM -0700, Ziyue Zhang wrote:
> QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
> ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
> from 6 clocks' list to 5 clocks' list.
> 
> Fixes: 1e889f2bd837 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS615 QMP PCIe PHY Gen3 x1")

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


