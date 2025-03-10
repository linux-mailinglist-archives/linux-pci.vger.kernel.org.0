Return-Path: <linux-pci+bounces-23288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E57A58E3D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D61188E1F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA3223337;
	Mon, 10 Mar 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwPF2jWA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C12046BF;
	Mon, 10 Mar 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595709; cv=none; b=cdIpQ9l9Q9NVdKmcXKxSyK+DQxAZl0A2mceHvAZM7kThjKtz3vgom/PgL0LppoUcSPK3jtOiJOv0YyAMgy/sq2cdOeCMJIEg3pfSPJ/hpXaY4rwt0jQkGbDA32KW2cHdupoqEX+XxcDrow5dDXd9b3IEJz3U/lGl6fLBGMWafiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595709; c=relaxed/simple;
	bh=FDc8n1PfVplUqR6TlrIzRSO+eMe/vmEGQ617VBj5ULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7jA1yjagv4F0TPcJd1H+HXb06OrdVCKzwXf1mjVpk82/gU25QWyRe+SgR8tKQB3E7ygWyo4Jp6edG3NELOgYcFPbWxABn+R6QzZ78NI5OjJ5ah+9HmbXP8cT801ugsEbK8UKY8SkXRUaetL4P2iBnOg0sjwVWwsqXmc9XxuG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwPF2jWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBBC4CEE5;
	Mon, 10 Mar 2025 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741595708;
	bh=FDc8n1PfVplUqR6TlrIzRSO+eMe/vmEGQ617VBj5ULM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwPF2jWAZQad3jgjs9AggH945mKE24H04MeiEP9rxZ3fttzLqvBqQYIstb7g0EqiE
	 fKZyYRMi+Yga/mq7FcNClkG0RtlYd6z0NzLdpCspseE37UzxsirOVtPcMoYZ+B4SM8
	 rYA89edVwCKeKTLhmeSeavVQFBC4w/6Ft0YhjuG4pjLX2JcAK0AkyL1o16qsCffWJz
	 XhDWDV95MbWRSrc9zfEUJCGDsaY6wqa4PZfPC8dkoL/b/VEPqkrsqrIJGeh7NhBtQE
	 d2wvJ7VNHxHpWkVaON2ugCgIkLZmnAJ9Hub/Si1rB+D4iXOBE4dvSS9ue+3GgHpODZ
	 bQG938Iv2QTgQ==
Date: Mon, 10 Mar 2025 09:35:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org
Cc: quic_qianyu@quicinc.com, quic_krichai@quicinc.com, 
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: qcom: Document the QCS615 PCIe
 Controller
Message-ID: <20250310-bronze-chameleon-of-karma-57cd1b@krzk-bin>
References: <20250310065613.151598-1-quic_ziyuzhan@quicinc.com>
 <20250310065613.151598-2-quic_ziyuzhan@quicinc.com>
 <f679c5a0-5044-4cff-8c3b-5051b1b873f9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f679c5a0-5044-4cff-8c3b-5051b1b873f9@kernel.org>

On Mon, Mar 10, 2025 at 08:18:35AM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2025 07:56, Ziyue Zhang wrote:
> > From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > 
> > Add dedicated schema for the PCIe controllers found on QCS615.
> > Due to qcs615's clock-names do not match any of the existing
> > dt-bindings, a new compatible for qcs615 is needed.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Sigh, this wasn't ever tested.

NAK

Best regards,
Krzysztof


