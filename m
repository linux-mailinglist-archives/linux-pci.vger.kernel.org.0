Return-Path: <linux-pci+bounces-4882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00B87F5A0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34871F22108
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103987D090;
	Tue, 19 Mar 2024 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgfzH/r9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB07D084;
	Tue, 19 Mar 2024 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816539; cv=none; b=grwTB8rxf2c1INeTGVV511bd2GlAQhKqQFlEzGdmp8rAc4ptWq8C15XXW/9n3Ozraf0SXM/UzsSu9Fu5hKfV5GmHr56DlAVRsOOv9ELyPgQi3XK5furOyHOu7gLTVbciQJDwXtm/Ks6FBZS5AN9WqzWn2Z2hwEJO+ZmQ3Ce7HH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816539; c=relaxed/simple;
	bh=XYgXFl74q/2Yhrqf8zZY5j77OL/riLRi+IZAuY5h9yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwZd6i2MJyWPLzpqlZt94uM2OuZO4hCcrwY9AhX9dhmQVFlp/Z8avetFWVjtNg7aI72euvYUOLOHY2mO/WmLbSqk/ZTLyhVIt6Qpc6i6H3okdphw7H8tDs0HfpUXYNT5fIXxS8zGmK4bI2sx/sOiKrJupotkdj2Q/pcdEr0qO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgfzH/r9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB48C41674;
	Tue, 19 Mar 2024 02:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816538;
	bh=XYgXFl74q/2Yhrqf8zZY5j77OL/riLRi+IZAuY5h9yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgfzH/r9kC2uJUxHbn/OBZugdktyFXyN4Jlx465YBYhI0oeajpv+63K0ze/TNA6Dv
	 Y4uFxQzIMFANhRoLB2RJmrEtuQtyLK24W1bOVlHDU1NAH2GJUnIGJjJcbCUm5pnmvT
	 2SuCSuVSc51HQ8k3zR2d6diBHCEFNUZD5Eh/XW5JMbIzHsDCovDFInNespufcmvQol
	 +FpwYXLz33BUK4mzH1/gnbMo5Dl1uVb5SVPKfkWQLqVzFBMwgdCwgNeCBNfGMiJnUe
	 XleNKaOCiY+rkwe53womwGlbRTDfBcLW63qHI2AjOuJnCHGHbQCaja2U75hDImipLX
	 ldD/rnyKGZFXA==
From: Bjorn Andersson <andersson@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Date: Mon, 18 Mar 2024 21:48:30 -0500
Message-ID: <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Applied, thanks!

[4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
      commit: 2b621971554a94094cf489314dc1c2b65401965c
[5/5] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
      commit: 81051f14a66c3913f1d219bd97e47002f1dc91de

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

