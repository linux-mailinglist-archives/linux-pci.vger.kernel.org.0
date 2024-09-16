Return-Path: <linux-pci+bounces-13236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BE97A51E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1CE284EB1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31C158A09;
	Mon, 16 Sep 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS3B54RZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AEC158535;
	Mon, 16 Sep 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500010; cv=none; b=CbiLcu5ixB7srIE8+1/TFU2/L+I1KorzdqQ36HUmPmT26AAsGV3klJ7ec1MXRwygeyMqE84geH1E5qoqxvHc3ifq3Xhe40UtM98pe1xTeXIfcoaq7cNnlczHlVxRLxvz4AOSpVNT5kGoeyiazuAtwlZI/ntNIzkh7P8nIUyVy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500010; c=relaxed/simple;
	bh=0t2kb4TLGVXAyQQAtnvs4rUiuNe98aV6Ih2GIVaFmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXX5NaiB5tqbPpb3PGGmmsZhFRlTVh4TNLqDiA9C+0zw2UO6A9R9w7P9zhEX3eym6GcGckfDNhWfQnTbjB88oNd1xxFLGX7DUksf4UneQS5QubpXtdpS/yFG0rkdq4Ckgd1W8kmyMr73LsV1gtuuQMFXwlxNBipTZuc7Joy6TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS3B54RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A2AC4CEC4;
	Mon, 16 Sep 2024 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500010;
	bh=0t2kb4TLGVXAyQQAtnvs4rUiuNe98aV6Ih2GIVaFmg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QS3B54RZP3H8Rkbc5Gu6JFcFyWmdibIsQVhd3czujKV8VvKVODvNVjxcDC/50dfdY
	 UNXF2IUwsz1vDscjFcT5cPnbCTEAgQln9iXKTU8H1HkaKJ3Xrfnf20J3mDyqBTME8D
	 SjYoRccRIh6aTAQylTsa7al/vJBLbNy0SJq5FazfnsO9U3mIR/9/c/Dup2H6qe04rZ
	 P+fUIURtOdJm9VkGqADTXDwv9k7GdrkpMSgGCTB2EYoB8PdH66OkBlJL25jXtPC7Rw
	 +T+y7tV6+4VusB70BPO/e/EgQkuKpXmdCiNPYRdLiZ+eS6AV01U6UlvsiryBZfDpMU
	 oex6zJfo5sF6A==
Date: Mon, 16 Sep 2024 17:20:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Message-ID: <hyhcycqedztrstcl2aixs6e2xwiowlrijkj3g6a2kheqap34qq@hhqxp5i3mbyq>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-3-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913083724.1217691-3-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:21AM -0700, Qiang Yu wrote:
> Add OPP table so that PCIe is able to adjust power domain performance
> state and ICC peak bw according to PCIe gen speed and link width.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


