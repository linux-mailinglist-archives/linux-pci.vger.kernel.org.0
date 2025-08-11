Return-Path: <linux-pci+bounces-33780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE1B214C2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4363862845E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5852E7F21;
	Mon, 11 Aug 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do8kYorp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAC2E7F19;
	Mon, 11 Aug 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937692; cv=none; b=AATWFjXslCi+xpqXSEiy21KTQ3Jkt0Z1jjT0PicpnmM9Fymod1soiOvJOV/Ltn2Cp4ZPQJ90LqQeDlwaA8osSPpQdCTrF+hiceReJDzkjqkuBNyrl5VArDwsQpUNzfxAmnjgXRs+kxM5TINrtEuydAkYL9LbPQPGj8FkBPxsAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937692; c=relaxed/simple;
	bh=COI84o40coP9gqyrgy3EfpXZhcX5MQJ1jz4hmJxZrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXZJfNSotvKy52BF8kQp6kh6ThmlSlwFPWsot0GYo12HfKp5R3a5b98ujfNHAhIJqU/ikhRMm0ArpVy1RyrYG3G49USUpXOkFOk1ma0CilM5qoRKknK7SAYJD75MSZOU+T+m9xCIqHdCC1C0r0qrVa097CMJjp7Ve1R9HzdXq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do8kYorp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F902C4CEFB;
	Mon, 11 Aug 2025 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937692;
	bh=COI84o40coP9gqyrgy3EfpXZhcX5MQJ1jz4hmJxZrLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do8kYorp+yE9fXkBH0f34e4Fd1D6nMcKXJYLJFKuv86ZgHGExVC4XQBW5zgIVEg+2
	 H+/U2K3zGXKs7ga3Da1teaf6rrQ2kdY5gCRy4A0RhF20EMsXsyDceGvaJ0K6jn78eb
	 9RuuC4sIADlq6psBZHg+Fh4ca89muvxNBUM44huLNa4SfCgRIV2xKW/RCeV5Ybj4Ry
	 94mR9oT/SQjd2YzRhJDrL+xL8O8wIZjlwH4u/xSMzBPteGJZ4zEYuCAsutpiUT30YZ
	 tcrL2HVZcGNh0Tn5SCPL2FUHP8My9jy76MZCGVrWXSpOFN1uwIp0mzDsw6Oo1XaazH
	 L0b5Q6vPN+HAg==
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
Subject: Re: [PATCH v9 0/2] pci: qcom: Add QCS615 PCIe support
Date: Mon, 11 Aug 2025 13:41:10 -0500
Message-ID: <175493766101.138281.16774900398360513894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250725112346.614316-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725112346.614316-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 25 Jul 2025 19:23:44 +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
> 
> This series depend on the dt-bindings change
> https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: qcs615: enable pcie
      commit: 718cc7542a000e2911c8d18878ba2eac5f29e744
[2/2] arm64: dts: qcom: qcs615-ride: Enable PCIe interface
      commit: 414be2b5a79de8694db1e26a3ea63a2aee5957ad

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

