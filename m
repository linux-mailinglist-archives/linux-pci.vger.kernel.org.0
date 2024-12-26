Return-Path: <linux-pci+bounces-19066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18A9FCD03
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1ED1883D1D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185E1DF745;
	Thu, 26 Dec 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVAbhd86"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449F1DF73C;
	Thu, 26 Dec 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237669; cv=none; b=IaJwQ3JEUkMvJHij9THu0omQpt3bFW3tQbFSoNHqFx/hHzLCG48Jvf+wT45h46ktY84OWJTociWyX+Cck5k4cGQ5fwwIkSLEvKGKrtK/+NbR60/JYY2a+N8rNCcjVuo3i3tmh1/4nxhJUTXrdOsHCLBbktqSvsett/yyHimXdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237669; c=relaxed/simple;
	bh=B+2Of2B5OUwvc314BUcwY6CEwIsr+VXSfnuYiTm6cM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDKIR7J+xaIOEirzvKNF/H08E+jqH8841eG46fomdSDVtLA6TFi9TZ5Xq3+SPpF7SlyNM6rl6kM/wqWf8lUYLazf9yR2+iv/tjAKVnR3vhO9yJsGNutNGlh/fO2WDQgW2ONwvr3IrursJAcVcBbQOLdM7WHdxDqY8vg0YILL+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVAbhd86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A650C4CED6;
	Thu, 26 Dec 2024 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735237669;
	bh=B+2Of2B5OUwvc314BUcwY6CEwIsr+VXSfnuYiTm6cM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XVAbhd86kOmHOv02f/4O/YY+ZedDncAsqeCVTXfmBhldBNGoZKuoWNW9LOuyvSlCM
	 pGnCXBC50tkOa1kLVkPtMoRDFJihP9fsHDOjzMzX7cJpjfhKlaxJ5jUDUQ02Y/XGQ1
	 z+KlQrjCI3FVg5CkdEuNczy3d+6PuliRBHMtWwwPnZ8n0Iyno5LwJk5Zpd4ShdXgzA
	 P/7cDiha6sP6DlP+Nlaln2FhuQFLtYtPjSn5KXRCOmFIOBVFFEML0/pVKLSMcNC7K2
	 0gx6YKdnlzbWYby2X6Lkn+Q450u+tLzkH+w61dwDgjDii0h+K3UMXnwVWZq6vKpTdG
	 SsW9D+KkqCtyQ==
From: Bjorn Andersson <andersson@kernel.org>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sricharan R <quic_srichara@quicinc.com>
Subject: Re: (subset) [PATCH V7 0/4] Add PCIe support for IPQ9574
Date: Thu, 26 Dec 2024 12:27:04 -0600
Message-ID: <173523761381.1412574.6991994387056685375.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20240801054803.3015572-1-quic_srichara@quicinc.com>
References: <20240801054803.3015572-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Aug 2024 11:17:59 +0530, Sricharan R wrote:
> This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
> PCIe2, PCIe3) found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host and PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> [V7]    - Fixed review comments from Konrad, Krysztof, Manivannan and picked up review tags
>           Rebased patch 4 on top of [1] for avoiding DBI/ATU mirroring
>           Both dt_binding_check and dtbs_check passed and tested on ipq9574-rdp433
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
      commit: d80c7fbfa908e3d893a1ea7fe178dfa82ed66bf1
[3/4] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
      commit: 438d05fb9be6bcd565e713c7e8d9ffb97e5f8d1e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

