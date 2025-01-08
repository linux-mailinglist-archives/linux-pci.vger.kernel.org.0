Return-Path: <linux-pci+bounces-19489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4530A05239
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 05:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787E61889876
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 04:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177F1A23BF;
	Wed,  8 Jan 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvGB47D2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F511A23B8;
	Wed,  8 Jan 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736311433; cv=none; b=NkLjP0dNQl2Qu7JSlKXhzfaBoD9NRLH2AY8Ouxl2udwQPMkZwODeh1nHrtiguAggWK5TupMrPqF8v3zWMoplQMVT86+AOx6A6icqaFDw7aUoAiFNyv3vT3bTYenqENPvbHXbsTU0ynVz23lw2nuScNtO6zvIoplTroov+uIlnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736311433; c=relaxed/simple;
	bh=/KsyKMmsUNCRol6QfIiF+3eCe0c93hEobsQYeWv/DAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsHQRFQWZOEGIITNb87tV1Qj/CgCqEtjXxbUH+igDPxXWhWs5n3uhJ1H8jFdrRtACXxnDtGtFtXLt5FMbtIsSjDR/XWrULCml0OMReQRLFHPgw7Hc37wewMe4wxApDhrjCyhsjw9jvYyrfsiDNhcVPl4qRTMiSKr4SAzGZvIe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvGB47D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125BAC4CED0;
	Wed,  8 Jan 2025 04:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736311433;
	bh=/KsyKMmsUNCRol6QfIiF+3eCe0c93hEobsQYeWv/DAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvGB47D2BpPiRZTbLvi33hzrtP89Cjfe7VjWL9BMgpofRmjhzRgdjrvdGdy5NTA3l
	 JKNEBeKERKUTsE5reAbeqJySSrm4yXfgurgXOSTgYiGHW4n2LC0gJjt1fohzzOav2Z
	 RCBfW5LSXXyQGI3duaRr2ebXag41U1Ijzi0wrp/433zcWji8BcJ6TZv+zo4tnPEh1/
	 9JK9ZWxVaW90HzbezFvfSjtBB102M7dVkwKkm4C2FZwZGGt8p3b647OlaI1h2SaNfe
	 FfI3LRk1cVexUu/DOESnC30U6PGbl9yGovJejrkS8indqF2cKhXu68SJLpXjAZ+mbl
	 rWt7OEUQHvq4A==
From: Bjorn Andersson <andersson@kernel.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] PCI: qcom-ep: BAR fixes
Date: Tue,  7 Jan 2025 22:43:42 -0600
Message-ID: <173631142072.110881.6854526601749603529.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
References: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 31 Dec 2024 18:32:22 +0530, Manivannan Sadhasivam wrote:
> This series has a couple of fixes for Qcom PCIe endpoint controller. The dts
> patch fixes the size of the 'addr_space' regions that allows the endpoint
> drivers to request and map BARs of size >= 1MB. The driver patch marks BAR0/BAR2
> as 64bit BARs.
> 
> Previously, this series was part of the Kselftest series [1]. But submitting
> separately as these are independent fixes anyway.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space' regions
      commit: ec2f548e1a92f49f765e2bce14ceed34698514fc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

