Return-Path: <linux-pci+bounces-33811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A479B21963
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25873622042
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5972286898;
	Mon, 11 Aug 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6eUMg2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8A286887;
	Mon, 11 Aug 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954861; cv=none; b=HmYfY6zqhg7h1Pmbm6O5qtFukkVEgF+SUunSnftVQuGBeU89UOkKziF6KdqlB4em2VX/+Jjte5h4+hqh//GvjUO0fh/RI51iegLUmUCh26Hh70awAC33t18g7bGbX3LGRBS4GtD2Hc8I7imC6C6DYQmQKp41T+jAZyB1NFe8EAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954861; c=relaxed/simple;
	bh=mwz/eP00rVG/Y6T80JxDHy1MjyKzEdAzpu/R1JJkgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVa6Zx+80CJdhwwFqLZO367+HHw65O+qD4yu8Hur+PaXd6ZSm7a0b7iyljL/1B3yx5trT2Belk3s6CTkaouLOZwWLSLg3TScgqYF3/9j6mhhz18olfG1F6WQnWjNNRCJreQAE8zpGLOm/oL1GLqt1M4Q4TKYOIMEWIJGJAYEB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6eUMg2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7E9C4CEED;
	Mon, 11 Aug 2025 23:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954861;
	bh=mwz/eP00rVG/Y6T80JxDHy1MjyKzEdAzpu/R1JJkgDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6eUMg2a7Y9Jqpexdl69AD7gsPUWf9vXj9KFy9y7r3utVFdjE/SaoO3RMNBv7tWA8
	 xTE9jAfJqU3pgyzwE6bnl+TB9xWr8NmOIFrQXJC+eURZ5LYPX40L3i0KFYGwhPJ7Y5
	 VBa6VGl0lLlEn8z4MnYdP+VGnrLqXICHDJBLOJZImia77h1yI21JHU1Oclg6p4lRDw
	 W7iaVmArwUHaHFm/AmYqK5vKvNQrvteUdyj3OElW3yF7jyMXQ12g4zmRZXS9puStgq
	 OHazLNtOT6XhIcQkswNWXjgbq1KgI0XxD7+hVacuj3wez6pr00W2purcTqTAkl+jBJ
	 cwgighT5oIX+w==
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
	Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: Re: (subset) [PATCH v1 1/1] arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boot hang
Date: Mon, 11 Aug 2025 18:27:11 -0500
Message-ID: <175495482457.157244.16977167154606922012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716030601.1705364-1-ziyue.zhang@oss.qualcomm.com>
References: <20250716030601.1705364-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Jul 2025 11:06:01 +0800, Ziyue Zhang wrote:
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

