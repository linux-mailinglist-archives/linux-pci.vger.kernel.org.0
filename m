Return-Path: <linux-pci+bounces-33809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC5B21952
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467454627E2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3419284B2E;
	Mon, 11 Aug 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIRicPH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AE284686;
	Mon, 11 Aug 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954855; cv=none; b=to+xyFqk5d/qxZMavIL6WBIgQ71OhHRWMSDfYgJVQuRYiAh9c7X/QslJVzXo7N5PpZCRgB/9F0TkCaaADV0H9iIU1bWKkttmqdO4Vj6bFE9cthuRwTdpNlfxY5OCS+sjlIAeI+KWyeR892CQltcZmlLw0Cmh0P9Zps4dFHnlZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954855; c=relaxed/simple;
	bh=ebiOdG+AaxQ0l6i+TRzVcBvO0u65lAmEEixNAiiAm8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCqyYuqtYwFIDve/MFrOKIh/IEDUPYqz658JsBwWjEFLJNLzDKChORTNSPFj7IQMNvPOps/1IdbiKKrkvk7bJtr99zXpnh07luQXYCBUOd3f5z87FTW/Vp1UH1u2VZONKavqDcfOfOvZbJLZPjYFx9JDB0fKp4VkoNHt6pK+g5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIRicPH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C84C4AF0C;
	Mon, 11 Aug 2025 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954855;
	bh=ebiOdG+AaxQ0l6i+TRzVcBvO0u65lAmEEixNAiiAm8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIRicPH5IC2xu123l78VbKLpGIjxOG5qvhWWXarvFo4pBBhb09Gl0G0nKulLM1CDk
	 DVnpcRG9tQw3ok0XaqvJH6cnYEFqC0WzbvHV0QfTVrZXU11vb2uo+AF0bjxvLGwg5e
	 EMFv0Cd1BeRbLvLHkPH4WF8sb6n1/k57QO+qb2f4dK3kbX+79YgSJiM23oZpOA+kDy
	 y3lz1mM51shhQSS13wSNj09lJSSvJ9Cpiis7bORXZq9LMabHfV5Ar9ZydEsBGhx53m
	 2taX99ez7cQAMI3pyTYxty2Nb8Ia70IzVqrAaPtw2/3QDjffvgh8h2z9xzzD3SgdyT
	 uF36YEeMD1nZA==
From: Bjorn Andersson <andersson@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	sfr@canb.auug.org.au,
	qiang.yu@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: krishna.chundru@oss.qualcomm.com,
	quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com,
	quic_cang@quicinc.com
Subject: Re: (subset) [PATCH v5 0/3] arm64: qcom: x1e80100-qcp: Add power supply and sideband signals for PCIe RC
Date: Mon, 11 Aug 2025 18:27:07 -0500
Message-ID: <175495482431.157244.8781382660149123331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 22 Jul 2025 17:11:48 +0800, Wenbin Yao wrote:
> The first patch enables the PCI Power Control driver to control the power
> state of PCI slots. The second patch adds the bus topology of PCIe domain 3
> on x1e80100 platform. The third patch adds perst, wake and clkreq sideband
> signals, and describe the regulators powering the rails of the PCI slots in
> the devicetree for PCIe3 controller and PHY device.
> 
> The patchset has been modified based on comments and suggestions.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: x1e80100: add bus topology for PCIe domain 3
      commit: 6facfaff0fe3b4d5903bed6164eb5e60ee6cdb8f
[3/3] arm64: dts: qcom: x1e80100-qcp: enable pcie3 x8 slot for X1E80100-QCP
      commit: df758a868dbc90cae98044d52a9d753575f50cfa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

