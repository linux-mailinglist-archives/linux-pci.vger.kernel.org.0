Return-Path: <linux-pci+bounces-31338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCAAAF6CE6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289234A1705
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6158299ABF;
	Thu,  3 Jul 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd4U8ATw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396A2882B2;
	Thu,  3 Jul 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531426; cv=none; b=Y9Rh9UoiPFPIyPT74ZfDA8apuihR5cOxA7cYsSkuX0LLF7oovupG5iwKgpvmiPT6/1G4J0Jgvu8iD5AfKo79pN2StaLshNjwCsXw68H9Oo85QQDQV/kh43gkt262CXVoUsibziNZw9vxqiB5I5QGEJmsTxAwOPFBh7XuVp7lP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531426; c=relaxed/simple;
	bh=Zq7mkNnN+wAqqYQTtHUcR3ndAXwTa8o69LabGKywFfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRuoN58H5Gxp6fLnSp1Y3EnJyUb5zFG2aRA/mCh5FCzogNFxKItD+lvocCnZw74GF32OegauS9FuG75QoNcmYikx595RCSkyZ4J6/LDawPqEkkR6nH0J+yHGEjWoiw2ujLJr304XNJlccddamUlNTGvWTFS0rFjvV2C24Xm6zYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd4U8ATw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB37C4CEE3;
	Thu,  3 Jul 2025 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751531426;
	bh=Zq7mkNnN+wAqqYQTtHUcR3ndAXwTa8o69LabGKywFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bd4U8ATwdGAhoxexB3OVtvV46X7Btx65Bp1AYbLD//mPVJgzfBd2TsAWgJLGkRT6c
	 tJ9qcRcnBke+HzGqyC+m3uEVUivLjmFQwwxisHeT7szrmWrTmrZynLeWtsE2XSTO7R
	 x5AeiEyAdTkd+ijIpt4rFlhlUYIjD6uDdn/J8PbjBEO04lF5Mr0R1WkMs9iiLucBCg
	 yvyX6gaMAUIzmCovm2XyWccRjMmwZ4KoYKWzwMHZQpD0KSXPghTWFZvjzm4GwqnTWl
	 vH+qTPjP3MEhjYeLTFKGNjV7dXxFDoC8BEQEo9N611BLhJcBLnjwYqdTlfTgEDFJ34
	 CTM/GvoA9YwlQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v5 0/2] PCI: qcom: Move PERST# GPIO & phy retrieval from controller to PCIe bridge node
Date: Thu,  3 Jul 2025 14:00:08 +0530
Message-ID: <175153128264.8260.15058435658721595674.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 02 Jul 2025 16:50:40 +0530, Krishna Chaitanya Chundru wrote:
> The main intention of this series is to move wake# to the root port node.
> After this series we will come up with a patch which registers for wake IRQ
> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> the host from D3cold. The driver change for wake IRQ is posted here[1].
> 
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[2] as the
> these properties are root port specific and does not belongs to
> bridge node.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: qcom: Move phy & reset gpio's to root port
      commit: 77df6234668afa9c44490130e62d5c30734d6e2d
[2/2] PCI: qcom: Add support for multi-root port
      commit: 9e09ecef33e6f1019be921732cc2d7bd945202d8

NOTE: I've made changes to the parsing logic. So please test the new version to
make sure I didn't break anything.

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

