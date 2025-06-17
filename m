Return-Path: <linux-pci+bounces-29918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEDADC396
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3E3A6380
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2A28D8EF;
	Tue, 17 Jun 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAzayVOL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE922AE45;
	Tue, 17 Jun 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146037; cv=none; b=CGVyQrApDdlqe7AAfjZCgk6JadDx72zojhwuxHvAMb9xxo4Eo69AQDxXKzOhOvMXKVUcwSkx2yfAEz7eAtmkiZHtI2brKScBnXePig9x7I1ZtKu7de1l2ANfn26bjKmlqVcJgmJu2xKtZw+KUOP371s46C+rNm8VOpyPrt5Zp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146037; c=relaxed/simple;
	bh=7ijB6/zreiVtuud8tr/xkH8DzzIWKxXzlILsSoCox2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpj+PQMiB+9fdSUAuZMHdNYGPgBSbs1i5qVY4d27UCtHAqDAl/tk0uDDAZYAWovKwF9cLVysgj7rwWP1iMih03YeWO3IIHj8PzwgTLo36KdhYumbG97CnxCy0w/4virxt2Sn7ArgxsQxeKzlXouAB0Jws9M5dTINp8hWde4YsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAzayVOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A396C4CEED;
	Tue, 17 Jun 2025 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750146037;
	bh=7ijB6/zreiVtuud8tr/xkH8DzzIWKxXzlILsSoCox2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAzayVOL7BCp1NeXspi7GwFtYcb+IjWw+/nM6r27WgBjNKUazmDoxYJd8xMhOGwrD
	 gy0yLyi12ow63Mdeqyms3Kk0f5rVncNj/yxUCp6PH0mKP3q/73MeAG9659gm5EmSbb
	 yUi+V/6/m9JgK7es5C/WAhnpyVOLzq9oDFK2aquKKbV3WqEcSZCZif5HKr4QFKb1TS
	 3qlOyLvjyiusAstbtAh/6HW5kBX16di1Ot54HR6H/t8V9jDsCwwum/UJloxQ6E7nci
	 K2+taRkv/PReXOyr8+KXNrGEfgdidXlrbOWPv92YI/XISxpFff6yDIw1iWDX3WGOWk
	 W/uGmiT/gULTQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRQvq-000000000mw-1WqM;
	Tue, 17 Jun 2025 09:40:34 +0200
Date: Tue, 17 Jun 2025 09:40:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <aFEb8m0snKARK90R@hovoldconsulting.com>
References: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
 <20250617021617.2793902-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617021617.2793902-3-quic_ziyuzhan@quicinc.com>

On Tue, Jun 17, 2025 at 10:16:15AM +0800, Ziyue Zhang wrote:
> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> document it.

Please say something in the commit message about what this reset is used
for as well.

> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index e3fa232da2ca..b7cae2e556e3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -61,11 +61,14 @@ properties:
>        - const: global
>  
>    resets:
> -    maxItems: 1
> +    items:
> +      - description: PCIe controller reset
> +      - description: link_down reset

That's not really a description, you're just repeating the "link_down"
name here. You can probably use the description you add in the comment
below.

>    reset-names:
>      items:
> -      - const: pci
> +      - const: pci # PCIe core reset
> +      - const: link_down # PCIe link down reset

Johan

