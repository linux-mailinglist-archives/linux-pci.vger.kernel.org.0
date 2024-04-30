Return-Path: <linux-pci+bounces-6907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B98B8182
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F388D1C22D02
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBF199E9B;
	Tue, 30 Apr 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii8bhz4J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE4129E72;
	Tue, 30 Apr 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509340; cv=none; b=S7e0BUYdyOpyd49tZVHoEq3C/vkNX8XTsC7jCb0b6uFeBzgBkBMEr98WpxGIB6txXwA7Pqh65ZQrMcspiSDHkAV/4JAT7c1fteFNmT9OkYUuozZDivhHlK754tEtz027rInQCXBZfPnTCBOGUEWZ6/ufqiDKgmg775xxDIJOcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509340; c=relaxed/simple;
	bh=/jlSsTP3DIEnuvJBHUeTjg2DPnz/xAY7MPH5QodVlyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPwc+WwDNEvPa9dI+WwNhv/KOMJC6ardpOWCKe3Law6AuhGaI2t08zifM3BHYcLfjVBQmwCOYZV9o+OWHTgoonBAR37Y/xldTy2GG1as2wAddD6aG06CtyaxN/gm/7DXPtdUw6+pOCb6K6CB+McomVwu4QMMV/uC6cZYz4V/wWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii8bhz4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C2FC4AF14;
	Tue, 30 Apr 2024 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714509340;
	bh=/jlSsTP3DIEnuvJBHUeTjg2DPnz/xAY7MPH5QodVlyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ii8bhz4JoRQFkqe+hVUEMfv5RH8uk9Fylvj0FEFPy9vHkgPVsHzFv32TBCQpMXbXm
	 fKTZ4yG3IqdxpptM92YIOPJYTBrOb6FNYqUwa4m3VAP05wX/4TrrAkvFzykUOFusvA
	 DvdQpLFglK8txLKK4lW7ZfeXdGR9FQNcReWbLSg/qYGyh8cvxLHWBDRbthLRmnKjY8
	 dMTgR1ySCSN6xNyEEhs1WiS1+jX/ZCcLls2/TwFckQQwDxfnHFNB+5Hh/ndE9MKxor
	 8vZjQn/f4FM4SawSXB5GX02ILn6y1H+WoGoWz48/o+78WTjKmuk4uBHBSfsxDzINnx
	 KaR3b+Iq2Jl+A==
Date: Tue, 30 Apr 2024 15:35:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant
 'oneOf' sub-schema
Message-ID: <171450931454.1152219.5021270598727364030.robh@kernel.org>
References: <20240417200431.3173953-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417200431.3173953-1-robh@kernel.org>


On Wed, 17 Apr 2024 15:04:30 -0500, Rob Herring (Arm) wrote:
> The first entry in the 'oneOf' schema doesn't work because the top
> level schema requires exactly 8 interrupt entries. The 2nd entry is just
> redundant with the top level. Since 1 entry appears to have been a
> mistake, let's just drop the entire 'oneOf' rather than reworking the
> top-level to allow 1 entry.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/qcom,pcie-sm8350.yaml        | 22 -------------------
>  1 file changed, 22 deletions(-)
> 

Applied, thanks!


