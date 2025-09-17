Return-Path: <linux-pci+bounces-36310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FEB7DCF1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719521BC4788
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA199221F12;
	Wed, 17 Sep 2025 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqxxfqUx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE84221D9E;
	Wed, 17 Sep 2025 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069911; cv=none; b=WWT+Phgp5Dkiw3d5/+fWG0CvU48S4ber0RFPm6lgrTCw/U5risNyMvcCBO1xuQQ48b55rK9OseL5rncIUL6JfzXbvEZ4yh3121VQKeqDSbTChq0snOcI0jG5xI1mW01gLeBMAlKWwMRuZinbX2ojcOWea12tgqYXcXcX5jGWIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069911; c=relaxed/simple;
	bh=hM1WsqT6+2Sj1W5hK44iajXZdntKcCchQ0B8FZgONAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVmoUIqNmlAp2ZW+oHI9OL4vITV7+mxIR1rzvqywqtmMYbQzU4iVh3HR+3inrieJ9NF25/PWItHX3594p8lmhxNe0u2z3fS2CcDd4HYOwD0mxn+A8B29sn8gRj1ssT9QXl0bi4SXxQiEcNJgCX8hhxDWozpfat/Wq9S2d8YyOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqxxfqUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC024C4CEEB;
	Wed, 17 Sep 2025 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069911;
	bh=hM1WsqT6+2Sj1W5hK44iajXZdntKcCchQ0B8FZgONAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqxxfqUxYmrCGdbdHUXGz6b01BEvtztSTI6eC4riOXRCFdi2HtHVYwjArb4Th02JV
	 02vuniBHAA21u3KTEAhVFaOyiBJb00RpbX2B8viOpWzcyLuO9Ekz0adZgd9roctyzH
	 b5yqJjBkseb6PXBbG2dHD08WrjAA3DUxh8OipnCpF7D8qoEVgBJj+3W6g33qnNk8Gq
	 +gsYrSEXXMesEndg/hi3gDa9CZ8pemGs66PubwTh7pCwM8UJu9KHdKYUBCRxMlbrsU
	 +JmJPVZ9E9IMRGfJHizpHK3ZroaMu2bErhiKTg9w0W7AP1ZlhYIWAFmjPK59ZWvIK7
	 ZhkmhWS0VSuyw==
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
	quic_vbadigan@quicinc.com
Subject: Re: (subset) [PATCH v6 0/3] Add Equalization Settings for 8.0 GT/s and 32.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Tue, 16 Sep 2025 19:45:05 -0500
Message-ID: <175806990240.4070293.6265162511011715762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
References: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Sep 2025 14:52:22 +0800, Ziyue Zhang wrote:
> This series adds add equalization settings for 8.0 GT/s and 32.0 GT/s,
> and add PCIe lane equalization preset properties for 8.0 GT/s and
> 16.0 GT/s for sa8775p ride platform, which fix AER errors.
> 
> While equalization settings for 16 GT/s have already been set, this
> update adds the required equalization settings for PCIe operating at
> 8.0 GT/s and 32.0 GT/s, including the configuration of shadow registers,
> ensuring optimal performance and stability.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: lemans: Add PCIe lane equalization preset properties
      commit: b4f745f1d8adad62ba8c2065873c8a857ed4c3da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

