Return-Path: <linux-pci+bounces-28054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E17ABCD1F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA931B67911
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 02:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4B25E828;
	Tue, 20 May 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8XooI2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C1257455;
	Tue, 20 May 2025 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707329; cv=none; b=kt8zlYJlgTAJos852FcLuxy3o95RKrjRHGVdH1wsbobmTTUmeNeJQ5tq6jxeAgW5v+pnudRUeJ2HS+AWFWR4lVNq2ydLBjJO8ANjkrfUx8xYo8P+AdaSrD+J8E5zQVNeeNiOjfZpoldddjXWAo/rQ+Oc/+DbhYR9a8V55znq9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707329; c=relaxed/simple;
	bh=lrhoOxWYvesLQKap0UvoukCJf2mnXwfef9fhv5kh05g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJEFwkuj2fJnkGxm5pXHbrs6hcS6Qo/ywQZSXFZJaGf8RYHv6CsGQVL2PCIYzL1sSsV5SnR2k32M/Qh4uGwM+zxnmNU5RqXaqtEG+7rVhg9ThB0pzmBH5cwRlfwZCV7BpVaTsNz2JrHlzi9hEY2FEBKlJUJNF+mGfrwL8FJNmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8XooI2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26D2C4CEEF;
	Tue, 20 May 2025 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707328;
	bh=lrhoOxWYvesLQKap0UvoukCJf2mnXwfef9fhv5kh05g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I8XooI2/Unx7chKw5GItoSW18dHWeGFlHmxBthKw25ReT8O1kYNeBgwuT0P+wbgoF
	 yig5OSwnKKn08gmjhUZk22DbRTlJjlA9LlWUWApYwx9e6p3fH0Gyha5BgOhLotD7+2
	 QdwLJBhus5VFic4wn4J1zDUQKXuK5/YHpB9yd6YmK7abQEVV+Jh6cu/KLNt8E9TGOW
	 bSVDMMr+fZZVZ39TUe+aG/vWNYYZwv/42SNcQUAAF5FyUZfscDQNQnhftwXwspwvJ4
	 crXzoNI9L3bpxoeArQTOvxlM/yTMhJCQv4mIOrVBwikg7HZcnGQoCDAAvjycd8ZaY9
	 02BTaqI8EJmpg==
From: Bjorn Andersson <andersson@kernel.org>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v14 0/4] Add PCIe support for Qualcomm IPQ5332
Date: Mon, 19 May 2025 21:14:55 -0500
Message-ID: <174770727713.36693.12572385539660853642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317100029.881286-1-quic_varada@quicinc.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Mar 2025 15:30:25 +0530, Varadarajan Narayanan wrote:
> Patch series adds support for enabling the PCIe controller and
> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> PCIe1 is Gen3 X2 are added.
> 
> This series combines [1] and [2]. [1] introduces IPQ5018 PCIe
> support and [2] depends on [1] to introduce IPQ5332 PCIe support.
> Since the community was interested in [2] (please see [3]), tried
> to revive IPQ5332's PCIe support with v2 of this patch series.
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
      commit: c249a0b6a4229141ccc1a3c0e2bf9f3b2750b592
[3/4] arm64: dts: qcom: ipq5332: Add PCIe related nodes
      commit: 9ef45543627021143dc1044a041d4117c882e926
[4/4] arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers
      commit: 1838d9297f9345900f0417ac8a4ea78a51449f19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

