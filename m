Return-Path: <linux-pci+bounces-13421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D29840D1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E227287FCF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CA150981;
	Tue, 24 Sep 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocdzidDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7814F123;
	Tue, 24 Sep 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167414; cv=none; b=bet0ZPWLu4X3BKCk1kqBJfxWwGNrMi9X5p2h59EpZMiyHXzUXetWURr1JJPjLczNpA4AhVLefFOkSaq/qXZ7KD19LI4A9vqnzItBniSMmccLHhNfvQGKm9co3+M8AzOVXVCo+JmKQ0K8w5WxiBrA+NcEMkbH4n+Lds+om9Ofy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167414; c=relaxed/simple;
	bh=0GyJC5zgimegff6pjgvV2wTvLGb/Riajc7yJ4PNzrgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZzYywmY2gU0UfLQbRW1Q9LDHxbBmHIrfGuU0tdieYFIr0aRt3Du1X1gxlNDJzmuhpXRcwjVTqEp7FnuzWblNfdTHSUwDOduIBwW5LwCXVEFasEDoafzcyvjEFFDKAhfrqRq2x0lpB84ZCOexhHm2o4L2OefaabYbRjotA0IXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocdzidDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB45C4CEC4;
	Tue, 24 Sep 2024 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727167414;
	bh=0GyJC5zgimegff6pjgvV2wTvLGb/Riajc7yJ4PNzrgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocdzidDWy3R5QEhvUy528E8C+QpTkQ20lSCngxXB57cZ+IcZmY8IACqzrQtkSJiPH
	 L3FrN5jwBS7dMd37KtqzFBqP+iXfcUsu8x+e2mXj8+I3PgEYsZsQaFRDkMJ28RpFNC
	 2mA5ES7+U7U5pJmWqUgwSDy80PTXxw3pVAC8xsk+d4/b67qQ+0a89oHlbj2HQ56/so
	 oeWBbHYCRPkzGUOcT7Kt4apcvD1+pYxhv3eA9j/2GHW0iwmo8n8FP6PWcWDhLORVQf
	 EmC/uFZVfZqB1U1M6CbP0OifrZcnawEzMwqOiw7KFxgUOGOYt0w63pScZUtuLPRjq7
	 dPrnh7hxlqR5w==
Date: Tue, 24 Sep 2024 10:43:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
Message-ID: <znnzcqujrz4cc3uimwymwizf4yvhsos3ky5vwhkxmopootmu2d@3yglev5si6fn>
References: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
 <20240923125713.3411487-2-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923125713.3411487-2-quic_qianyu@quicinc.com>

On Mon, Sep 23, 2024 at 05:57:08AM -0700, Qiang Yu wrote:
> PCIe 3rd instance of X1E80100 supports Gen 4 x8 which needs different
> 8 lane capable QMP PCIe PHY with hardware revision v6.30. Document Gen
> 4 x8 PHY as separate module.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


