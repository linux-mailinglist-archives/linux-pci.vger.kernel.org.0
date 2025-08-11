Return-Path: <linux-pci+bounces-33810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5CB2195F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1F18836A1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D62853EB;
	Mon, 11 Aug 2025 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq15aqHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7E28467D;
	Mon, 11 Aug 2025 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954857; cv=none; b=Xu1M7BkT4zQuUFot9DF1NilB9YxuMoLN4q/r0p4CL+D9++42+q5fnOKBZn7ZwIdLMzMIc7NBl2qftXDwZ/669rcMsVVCggwYZINmSd2S3fyY2z57P2vF0uWdPWyvlt8ofYvfqwCmotODcR4MAd4Hv1MPk/8wfKez9LRyzWSmKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954857; c=relaxed/simple;
	bh=aww67BHxnNdQbNNndw5WrR6+OqPaKbI8LFTYgFplNIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHGwTnHOxa5q7jZLDGSl3gVZFVPswgJZWej3m4/3yyTMEAkWWss5OPy9xGakOOBUdbXfcs2PNm83kxqe2cD6lmkXtIn7R/sKU7r5gBqOBn2rYH1vJJlBAGcdy/XIaW5cHxDHh/MEJO5D9YPkGR6/OZ+eedXY77sg4eYrPc0QqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq15aqHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA06C4CEF7;
	Mon, 11 Aug 2025 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954857;
	bh=aww67BHxnNdQbNNndw5WrR6+OqPaKbI8LFTYgFplNIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nq15aqHZLa13/+Zl7U5iFb3kjfwe8gRadmatAPa5boXFPwIeYedJR2gUen8PWN/QO
	 VXHGC47m7jXL5oBwzNEgZmuNFFQiKnJcXn0XgmXHLIOCthu63tlIadNvqSqYUA29fo
	 1sFhaESlvi7m32tZvPYxbWgEMBE0zTlu8RNL6X/BGcJf8C0SbG2dV/8GO1oX6SYSSL
	 m9GyQeOojnNewvbsm1S1qL4UhiDDAE6qE+rzp6qugCRBRhwZXgwayjpx/JDajElMUI
	 yhxevl053Q6AtlXtEpfciHVU1Wwiv6724T43naPWPSMpV8ZgU1D9ELkYOOVnHxyXf7
	 ffsCkMinDH5YQ==
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
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
	Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: Re: (subset) [PATCH v2 1/1] arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boot hang
Date: Mon, 11 Aug 2025 18:27:08 -0500
Message-ID: <175495482442.157244.678684703517788074.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250717072746.987298-1-quic_ziyuzhan@quicinc.com>
References: <20250717072746.987298-1-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Jul 2025 15:27:46 +0800, Ziyue Zhang wrote:
> On certain platforms (e.g., QCS615), consumers of LDO12A—such as PCIe,
> UFS, and eMMC—may draw more than 10mA of current during boot. This can
> exceed the regulator's limit in Low Power Mode (LPM), triggering current
> limit protection and causing the system to hang.
> 
> To address this, there are two possible approaches:
> a) Set the regulator's initial mode to High Performance Mode (HPM) in
>    the device tree.
> b) Keep the default LPM setting and have each consumer driver explicitly
>    set its current load.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boot hang
      commit: fba47ba8c8a8ffa9d8ad1836396837a998bb5153

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

