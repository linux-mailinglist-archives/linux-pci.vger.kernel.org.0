Return-Path: <linux-pci+bounces-33812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5DB21B59
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A91A623128
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB82E6102;
	Tue, 12 Aug 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqCTkjqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039642E5B3B;
	Tue, 12 Aug 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967904; cv=none; b=lJvrPV9iGnBvRI1el1EBG59F0qt97R+FTEucsxOC21UbBC/q8Yorb1TYQcbFZBAK3mwRNGm1/hofJeR5jN+51q6MCE/FqHCOHxdUnUdUhRlDKggOsr2AvyWkoM9HMa3rWkSZ9FQqiRIc3Bbu5OTN5gITKRcR7EeXJC3vkbG/AYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967904; c=relaxed/simple;
	bh=+SYEc7mcuPezHlXmlPDvheE/ZJqUSaIeGVyT8sV6eOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2myYNvffcUn7K3WO1UxWofT5m/15ipBOeQzOrzI0RQq3N+01iwze/rPoEszusF1brmClpgQ5ohJg8tEwrNUwpheRsRJI42iqBTUw8nwlXBR9YTwMqd9XXKl7cQ5UFDFa/Y9A4ODGMlYK3biD7TT7aLuXvigRnwmoHXrViGs76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqCTkjqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB6CC4CEF6;
	Tue, 12 Aug 2025 03:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754967903;
	bh=+SYEc7mcuPezHlXmlPDvheE/ZJqUSaIeGVyT8sV6eOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqCTkjqgz/U0F0HowmywnKuw1f3Cx7Bo/4UcfPNM6MwPp24J2KxTZ5TDxETt+OJS/
	 VMZ+dRwfCNtYtAvGHmbpSyPy1B+K9jjDXUbrQoOwvMQALH8f/ZcYxorDOnGuSFD1fW
	 KVPrT5lG5illSdZCAQ3hbV6OLi37fLX0l0hQyD2mwfcntSOZBm9UukXxchsWAZeFdi
	 vRQHrGKGQ9XXXnztCJqMC1xqCEznPG4xr1fDoST8XMBzIKIjG6kyttkK1FFUPwWzTZ
	 p72jj8sV5XmPneO+2SiDNOge1pi4GImMWmmFnFaJZGvOs9WbM/jTY/RiJFa9RFhAmZ
	 ZPEfN1bUW2kFw==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	johan+linaro@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	neil.armstrong@linaro.org,
	abel.vesa@linaro.org,
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: (subset) [PATCH v7 0/3] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Mon, 11 Aug 2025 22:04:52 -0500
Message-ID: <175496788924.165980.4310613357045244026.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 25 Jul 2025 18:22:28 +0800, Ziyue Zhang wrote:
> This series drop gcc_aux_clock in pcie phy, the pcie aux clock should
> be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
> hardware, so add it for both pcie0 and pcie1 to provide a better user
> experience.
> 
> Have follwing changes:
>   - Update pcie phy bindings for sa8775p.
>   - Document link_down reset.
>   - Remove aux clock from pcie phy.
>   - Add link_down reset for pcie.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
      commit: d41fb878adf64ef5dc4b4c25419e875483f62fe2
[3/3] arm64: dts: qcom: sa8775p: add link_down reset for pcie
      commit: f0370265b1d7fc169956927aa62c3abc375743b5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

