Return-Path: <linux-pci+bounces-28053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1CABCD09
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905893A4EE5
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86325B671;
	Tue, 20 May 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsEHxl2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04512571A7;
	Tue, 20 May 2025 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707315; cv=none; b=ZUxRo7Oo0fwX9KOb3qGXCtmBwtdXpXa1IraS3keTIok22uuSK97m6swnnnbfsxBR38Wjzxa5anPuJGAHLpYgSN3zRL6Njm6e73wChvY6AEUGn99QRxb8xohbi/8ObMcCWDk21uXvRZ4iq9Px7oj7v4PPC7JjqlvL/7g9m6RkAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707315; c=relaxed/simple;
	bh=yWYnzyAYf6NVmc74IPU5OBcm8c85o/0n3L4lL5CQnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1ufopazBqZ+SRsevoKl+B6H4pU2pTPrsIiOl+1fgTcUkTqX0Ji59ZLBqF74p9pRhhNfnMdbUJ7vkjbEXkUfM8K+ymWg6pC28rnYmnpHwRt0qXc/ZwpsRH2w1FA6o33N42LJXkrVfm1YfzJwxwrJDAHAjwPkEXqs7szzE8NE4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsEHxl2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4196C4CEE4;
	Tue, 20 May 2025 02:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707314;
	bh=yWYnzyAYf6NVmc74IPU5OBcm8c85o/0n3L4lL5CQnTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsEHxl2Jc6fHeYcNpnVlyobQiN347EYhudDXANuQiI7PS73/3Sj3r0jIQ4ceiSlgj
	 lG7wgs5tOJwCQn28DOXiNe5pTyHMbMiEH4zWvidan6yqVgEHDHaBeNQGkZcZzfd0/W
	 uahNsb58PEPD4ba/B4RQqCJykQsO081GbQvPjEzqxgb1hwlUfOq9phY9UI7ETamL0Z
	 7vkzftb5qpsHO0iSmVTSKWDdS+xyFjIHfKnZfvX7dg4UVw/VIpGHfEG2a8QlbJ1Gi0
	 qTEZA3CoRWwFgY+bDO2GRgxHLIImTxFCI+GmIkdvnQWBvLTzb+gb5B6gjg7fdqR9cT
	 ti1OWPMsMo6FQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v9 0/5] PCI: dwc: Add support for configuring lane equalization presets
Date: Mon, 19 May 2025 21:14:43 -0500
Message-ID: <174770727722.36693.12504895095806597794.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
References: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 15:58:28 +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      commit: 435c3642a6a82c774f2897d72e6ed794a1dbaba1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

