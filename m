Return-Path: <linux-pci+bounces-39473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8074C11CB6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6714FBFD9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06633FE10;
	Mon, 27 Oct 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSOPvCUl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AC33F8BF;
	Mon, 27 Oct 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604512; cv=none; b=OxzWINxhhJSsdpP2huORD+C+1ejYaDw0FAXdooa5u24Ve/n7Kg84hAQ0o9hYzYcD4qVUG1mEpN+TQNroFOr9Mem9gPkN9krHxQ6A6eox2+p7wGF4PartWmIWrfikFBgMpbdsO/GK8jQro7qhnz4WbYVflKRw0j/7olG/M41xItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604512; c=relaxed/simple;
	bh=GZ+ClJP4un9jzKP9mztXW62Rt3Pqp7Jft3mYPG/hZok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb01gfM5p2Au19JWZtDaksmhtu4EmB4q5mJCzFbg1RIr0zDTU5Kx0Vjk5H2Pi9eJbja83p1lF79DjvNkGWptHgti8RMidHYCDCrdKoArI3sE3VdBVIkrVi7a+TQ7Q0CIGGf0VzJ9oD/zl1cgn+UNUWzQoai4IvVey4jiQyKN8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSOPvCUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34A5C113D0;
	Mon, 27 Oct 2025 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761604512;
	bh=GZ+ClJP4un9jzKP9mztXW62Rt3Pqp7Jft3mYPG/hZok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSOPvCUl7W0HPFG3BicpvMexcGH0Yy1mVjH6yuElOWAuzsaRMYsk7E9k6dUxYAVoC
	 7Uc3yUrt4KjhWG+KE+tE/851TzoBq22GidrHAtj+BswXVclzTKYfl1jj2Tt2e4CF21
	 tOt3JN1u9JSinvEmn3AcqVk08JPWrYlFLqzt55LZrxQQux2IMSoo7LIZ3IihkQeXng
	 pjVOjCqC7GG4jhaFU8yh5LJ+vu1BS1WguexZJSSH6ahOntiD3lZAE7/vk1jTfq/7ej
	 8gSUSburehlTQJ1K9oq++VcXZGANmcbqTVZt+HHNO/7464CsQzVYpgFjAb3qZrDbyD
	 TVvj8VinoDIjQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/5] OPP: Add support to find OPP for a set of keys
Date: Mon, 27 Oct 2025 17:37:05 -0500
Message-ID: <176160465218.73268.17091212801966002684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Oct 2025 16:23:27 +0530, Krishna Chaitanya Chundru wrote:
> The existing OPP table in the device tree for PCIe is shared across
> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> These configurations often operate at the same frequency, allowing them
> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> different characteristics beyond frequency—such as RPMh votes in QCOM
> case, which cannot be represented accurately when sharing a single OPP.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
      commit: 367c2f473f5f5a84cdf633df96e0f9b4a16e443d
[2/5] arm64: dts: qcom: sm8550: Add opp-level to indicate PCIe data rates
      commit: fc0ed54869be3a40c92879411b6db553d271de4d
[3/5] arm64: dts: qcom: sm8650: Add opp-level to indicate PCIe data rates
      commit: 860d514f09f0ccecd233808b44918ac5b2c10627
[4/5] arm64: dts: qcom: x1e80100: Add opp-level to indicate PCIe data rates
      commit: cfd8f45ddf8944fa95ae3e8cb5159c62fef95e34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

