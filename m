Return-Path: <linux-pci+bounces-19573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7CA068D4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E381888A9E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 22:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F30204F93;
	Wed,  8 Jan 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a94Q12m2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029F204F8B;
	Wed,  8 Jan 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376712; cv=none; b=mWrelrzoZJ1r2D7GOHtemayim/H1ae1nbDMnB0hg4stt/VW2yVRhk9OYieoczdhFrmKhHuBwDiorPfkLndiLJm8zYInG9o1IT3t53GzC5kDYbsv54xyMeSniJw0PJz3AwhPJSUhdNANrVZ8y4IW1YFCVwo21AQyq81Nfl3IGqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376712; c=relaxed/simple;
	bh=rhwips9BLdQqNBMe2wi+Q2zGh58uXqCsA6jp/XXmXz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPwSGJpsvqk0iRqxnZ1zbMIAndMNagYVMDfYcBaXaQVa16aN+V/UuZWdMPsIqb2hxpaciOf05lBjEgnuNoONzIpp2UhjJSfIBPjID6zZCWsIudh8KCCsXxlWJW4MToIq5K/kMIOjtdATA26GOfT4nsEL32D28qdRqsFmueXxrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a94Q12m2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD68C4CED3;
	Wed,  8 Jan 2025 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736376712;
	bh=rhwips9BLdQqNBMe2wi+Q2zGh58uXqCsA6jp/XXmXz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a94Q12m2X76lJ/gZED4KOuZt4zLKrNMDDpTEbwhi3Syvjrgu0ysQ4Tsqap+ri1SMX
	 uaR3Iv7nrZRoIsWIbTASt3TM7zQO0ST678kSuiMtuAaBjOeDlS3AWrGy1v0+fCiWD6
	 1jEOt8nujrOlRCxBUE8tSlQ5IPI1qJk61DqEvfrWl7gMhYlw2f0y/SmIEKBA0OVFHu
	 44AgOviOBUzlsnkpa++mGHeo5xfe34djKEd5GrExnDeTQnwGgRSV/dc7ZGVI0ZLPSa
	 8N1ooNruzl8BnpYisyQcMjtpA/BKJQf1DbwiINb53xoPmdkgs1c3BGFzmQn+XWI385
	 o51hAQhlFgHGQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] PCI: qcom-sm8[56]50: document and add 'global' interrupt
Date: Wed,  8 Jan 2025 16:51:44 -0600
Message-ID: <173637670473.158785.9979777577031176622.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Nov 2024 11:22:48 +0100, Neil Armstrong wrote:
> Following [1], document the global irq for the PCIe RC and
> add the interrupt for the SM8550 & SM8650 PCIe RC nodes.
> 
> Tested on SM8550-QRD, SM8650-QRD and SM8650-HDK.
> 
> [1] https://lore.kernel.org/all/20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org/
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to the PCIe RC nodes
      commit: 3e14b14ec8b94c954d8d09230686cdaf5162f3ce
[3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to the PCIe RC nodes
      commit: 9eb81b31ab62cfaa243c6fe948b9f7cfdfdad666

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

