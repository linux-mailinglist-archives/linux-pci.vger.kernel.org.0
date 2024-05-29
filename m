Return-Path: <linux-pci+bounces-7951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983568D2A72
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89871C24F46
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 02:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2416130D;
	Wed, 29 May 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyCVRHXo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD715FD1A;
	Wed, 29 May 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948145; cv=none; b=q07Rg/UyJ/yLJEGWnbN2Y+2jLRaifoMxfjcuho0gM9jIr4hHgIosAKbAXS+OU5zPgkBASpYLeQR8WneInUZns4eZCnxZHj1embsodjh4jnRRDg0bLWHxUViqzp18AGJzqLG70ioN3MTswDne7rGj8mmu9gZiTVXLwAup0ChnV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948145; c=relaxed/simple;
	bh=8ZfvQgO3/QzprRBXweHb5KB1W9EIv7sdnc6kqUIcHKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETQ7wOGpKI+PU9TWaHGnwWDKeqkuk6ZXqahOTWN1j6bv/N9OXHP4YMj5W6e9KkQLSsXu6uI+mz4H3mWdo6rCMhcQkY+llTvtv/9k4hpGc0R+0a//Dw6lwumXHKc4RY5A46QbGhUPWzS8HsloNo2Cyiqw3JbFGNtso8f+E9FsV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyCVRHXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428E4C4AF07;
	Wed, 29 May 2024 02:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716948145;
	bh=8ZfvQgO3/QzprRBXweHb5KB1W9EIv7sdnc6kqUIcHKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyCVRHXob0Yzd928wqA+n3n19zyhyTPO8N3wtkoefn9Lebo9rR+UCm55izY+Fn+Hc
	 +qumB4byelFzWsQSsZXSbGlCR+YMqDr7MRZ0o6kAjG5cTFkJheyT1RZ0UezXxJt2cI
	 483ExWXjLNdSowfUFKsR3q7A7D3Ikz9XZGcge9AtecyXjW8HX6wVzML+E4XD/xSpXV
	 gAkbFmuCgYr2ZIIsq8I1XXRqVUD7dJzWUE28xj5aBB7oEC2V61HkifWd3/oucfC/Y5
	 vuIES/tVH09I9uTYA4dY3SBlY/XzN8NZ8hhugEhMqdQZO1jbUShvcKav6OMsEt+KcM
	 6OV4bdeLQsxHg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	johan+linaro@kernel.org,
	bmasney@redhat.com,
	djakov@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	vireshk@kernel.org,
	quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com,
	krzysztof.kozlowski@linaro.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH v13 0/6] PCI: qcom: Add support for OPP
Date: Tue, 28 May 2024 21:01:59 -0500
Message-ID: <171694812089.574781.16754676047820223092.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
References: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 18 May 2024 19:01:41 +0530, Krishna chaitanya chundru wrote:
> This patch adds support for OPP to vote for the performance state of RPMH
> power domain based upon PCIe speed it got enumerated.
> 
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      commit: 42870599f9441fc96f99050637d2dce6f8b52597
[4/6] arm64: dts: qcom: sm8450: Add OPP table support to PCIe
      commit: 628388982c1303283b220a47e69906f0924e4031

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

