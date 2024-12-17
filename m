Return-Path: <linux-pci+bounces-18578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CCA9F450F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8280B7A6B1A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D118B46E;
	Tue, 17 Dec 2024 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOBv+Fkp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBE1E529;
	Tue, 17 Dec 2024 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420422; cv=none; b=Pk1ahFpFoj5IFmkAie90yL36ix5Oi4PUbA/F/Yp6E1GTx7ZHu6rLTiJIPYu93yfyU4Lkfxm/HgX4/cG54+Ds1NeTlFfVqalOUfbXldcb/Uu8BUlo6YUrSoZZ/44TTC/po3pCmJKi4sEbXDR/gDxoYcLmfgfu++/U0YFkEVyCXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420422; c=relaxed/simple;
	bh=IMdlZZfrhiRiL0AJADJI5YxB/0B2omath4S2C86sRTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da+crOvDUur+rbuK5s1a0w+xlk1qf33SV3BAaeLKKT6U41IqeplKAZscdQ5sp2sVu9cB9LI1JGoYCGyo2PUwXYcDphuQ9X8lrq60dUMXz8hi25A9HJmuVMOM/4Ehs0PpyxPKHoXPx0wXJgxcAyxOrn3d80cR9mgQQwhUBxxAmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOBv+Fkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA3CC4CED3;
	Tue, 17 Dec 2024 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420421;
	bh=IMdlZZfrhiRiL0AJADJI5YxB/0B2omath4S2C86sRTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOBv+FkpLZvI8reANQuCh4Uqf/ERjSqWcOEey13pBj5YchyfaAfcd9SnR0RhD/jbM
	 pnEjCZEN5GgdQ4buad194GQJPyKCLbcTGzMgqR0gNmk8/lvufaImVfJNu2GsHbCBL3
	 RN/xPyQYO86uvkH+++5wz2aDA0JTVzJdMn7vQUrlAYzaJarDirpB4BkKwMZ7qg4+Zm
	 td3FBoB2/Zzznk5qisZMHSVcFU2gf2Tbf8sj8qA348aRj0fjkjcuOvwnD9SeIt/azz
	 X0wHd2X6+UAL/KnN8fEabVS26tuB6kaVDaJK+Ojh/E+Qpx8i2cRu4sI++Sj8vne5RX
	 nTVm0iyyZ3onA==
Date: Tue, 17 Dec 2024 08:26:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom: Document the IPQ5424 PCIe
 controller
Message-ID: <yorfzhvhciq4xxe2gxmqsudxfw7oehto3pexwit6obuiacl6nw@jmkhxzwb5ika>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-2-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213134950.234946-2-quic_mmanikan@quicinc.com>

On Fri, Dec 13, 2024 at 07:19:47PM +0530, Manikanta Mylavarapu wrote:
> Document the PCIe controller on the IPQ5424 platform using the
> IPQ9574 bindings as a fallback, since the PCIe on the IPQ5424
> is similar to IPQ9574.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


