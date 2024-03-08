Return-Path: <linux-pci+bounces-4671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6787681A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2542CB20D68
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0025774;
	Fri,  8 Mar 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrmBzkAZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAC366;
	Fri,  8 Mar 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914157; cv=none; b=qIagXEqbN7wFqkoF5S+PewQSE78Vw26p4bT/1Yj8tkM2J0D4fUn/VuJqVhLjB+UbqhXEUG2y0i2aAtr3Vs28Ugo3q+XLVDlwVtjpvBYZTdgDkSvnsCOGoc4F7lpeWvuCNrbxQTf8hkq4nG9Ris6cR+HDNoRBlInkpSqydfCxH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914157; c=relaxed/simple;
	bh=ZSBaVvNvf0DteLyJ6qgFq5sexlcun2hzmzZGkgLZegY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLTUF6bfwGs4e7xHDjUn6QtBgHT6nghmJkA3ESKBxT41L6g4XAIBokvWHjfg5QH0rzPvq8ORCxD95J+BqvvapS8bCBV27eF72wpFX+AVINatPEgHZWi6H/4+xCAA/jvtK4AqVy4hCiExmPP4aDTY+oe/Ov6FqOth5d/x1jmi1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrmBzkAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADCAC433C7;
	Fri,  8 Mar 2024 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914157;
	bh=ZSBaVvNvf0DteLyJ6qgFq5sexlcun2hzmzZGkgLZegY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrmBzkAZsbSCAfnhSR1X0yXEKr23ym6SvHxkA0cbIEwzzp1FC+RDhliEw3qJhhvhi
	 g84El0q676S3dSLbCny5Yh2x19A7YQYblDI9C8jQ/D7wej7qkRvZeXBYY7WJaUtA1p
	 gDsJNgZ++RurRn1si/S/OHh2t3MPOCRqjX7IdOzKG230FZxF9ckSx6QR7/xLesqq3p
	 6DEezmPc1zufyNd77gmPCFymAEYR+vAAIaTGk5AwdVc+A+D4NgBN1eEwyWc55ZTeEK
	 4BFvK2IgA8UfQJ2RoKsdab4jOXpcIr/2eH14Cj+Fdm5GQDqLPq/s3RwTpfyRS74eGc
	 uru1rwmkMF0Mg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3 ITS enable
Date: Fri,  8 Mar 2024 17:09:08 +0100
Message-Id: <170991411487.455768.7609004144728540136.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306095651.4551-1-johan+linaro@kernel.org>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 10:56:46 +0100, Johan Hovold wrote:
> This series addresses a few problems with the sc8280xp PCIe
> implementation.
> 
> The DWC PCIe controller can either use its internal MSI controller or an
> external one such as the GICv3 ITS. Enabling the latter allows for
> assigning affinity to individual interrupts, but results in a large
> amount of Correctable Errors being logged on both the Lenovo ThinkPad
> X13s and the sc8280xp-crd reference design.
> 
> [...]

Applied to controller/qcom, thanks!

[1/5] dt-bindings: PCI: qcom: Allow 'required-opps'
      https://git.kernel.org/pci/pci/c/c8073025c0e4
[2/5] dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
      https://git.kernel.org/pci/pci/c/545e88cb41a6
[3/5] PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p
      https://git.kernel.org/pci/pci/c/d1997c987814

Thanks,
Lorenzo

