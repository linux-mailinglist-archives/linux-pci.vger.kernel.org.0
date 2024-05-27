Return-Path: <linux-pci+bounces-7832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337178CF7C2
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 05:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652791C20311
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 03:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333E13A895;
	Mon, 27 May 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwwXPPmz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369B13A88A;
	Mon, 27 May 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778870; cv=none; b=c3UHNzsaeo4WKPbLyt8c2pTBzHIWaPvqK5y64wcj3icXr6qHW6V6+YVd5ho4g7qACi9BRuuAXWMCYWXReBaHS943oQQgcDUD+zg0A+b+aXttQsL5SEliMxWcCPFe7lMoJgTsmII+Iae3ChgdTQpBzSPDtoluOUJK0nWUfpjusjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778870; c=relaxed/simple;
	bh=La3vXt+VOZBNivx4l/Ze2+ydsCiv2ENzkQ4QiFfxyz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2GtTUXMxK2zz5LjSAMtIp8QNsYy4vQsPepmfJH29LOVljnv1CypaRasHJuUYfLRTod244Zg9fCQwDHY1oPwMwSDIDlcQMzpumCmxBaisfF8Vjfset2GWlept3xwPQg5A8NdHwaTU5dFmsAo+fr5LztqwyCo0tR8BhHtRCRVFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwwXPPmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4264CC4AF08;
	Mon, 27 May 2024 03:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778869;
	bh=La3vXt+VOZBNivx4l/Ze2+ydsCiv2ENzkQ4QiFfxyz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwwXPPmzE8Q2xnrlfNUuWb05rlZnWcZJV5TDRgfVfwDUj2ddKEJ/n9HBmgrZiWNM+
	 E0BKdDkCywd7/xPPgRroRFO4rV4R8Vomjzn0X1UMoqfIjCVeLvD+gSQa07okvfsEt2
	 2hO6rJKd9yt5JsHBFb6iwlk3GGD9mL7f52WRUYWFpzuoybx+9YjHcbjOBCnC2cjhXR
	 Nkpw1Ac5Hnn+bCSWA94fccjOJZFLbn5Te66v5QNplGzMToucfSkoWvu+wYNQ+NKXLV
	 eAJ6uFsFQf/OEExylJXgW6S6QkxFWm5Ns0Nrs/hE4UC9zaPJFaoHvZD1U+d4vc6ktU
	 SeIdtyOiSRPiQ==
From: Bjorn Andersson <andersson@kernel.org>
To: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v11 0/3] arm64: qcom: sa8775p: add support for EP PCIe
Date: Sun, 26 May 2024 22:00:36 -0500
Message-ID: <171677884211.490947.14350118117730488729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 21:25:36 +0530, Mrinmay Sarkar wrote:
> This series adds the relavent DT bindings, new compatible string,
> and add EP PCIe node in dtsi file for ep pcie0 controller.
> 
> v10 -> v11:
> - Fixed Merged conflict on Patch 3
> - Rebased on top of v6.9-rc6
> - v10 link: https://lore.kernel.org/all/1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com/
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
      commit: 1924f55182243a762c6926962054e338dbbef40d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

