Return-Path: <linux-pci+bounces-31175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EFAEFB23
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD823BF3E2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62028275B09;
	Tue,  1 Jul 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6osAEVz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306611DFD84;
	Tue,  1 Jul 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377740; cv=none; b=aIRc/wgSdLU9dVt/rH7Mf+7csM7D5XYeQe4dvgL1Zr/4VZY9ZzyRH9OvaggZbZt1nqBsPB0EhBC256PGiphT2qutZbWCrxlxhRDv9iLSQbpJR8/1FRjisg255VLJQ+llM8UBW7GeYVo0T4IgAF8KhXMhlsr4z6iryYD/jvM5f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377740; c=relaxed/simple;
	bh=vFTK1oxgqsdO+2h7SzDJQ8yWLt6+O2FcznPSuZUqwgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pHDrBe41sUBTspcPlRlYl159J8oFFjL7044jIhTwyEXWM64Awvjnn9x9VMf3t1SEb8TSvJa5fsI21/PyzeQmWVRMuJksajbMvnR4F0NDwBJpdoyXBsNDDVaO2cn7xaRdVtSrU/oyOHVBNhp2IMkZslhszwxgwQXLBYaJU+BDInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6osAEVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B83C4CEEF;
	Tue,  1 Jul 2025 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751377739;
	bh=vFTK1oxgqsdO+2h7SzDJQ8yWLt6+O2FcznPSuZUqwgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S6osAEVzWABx4z9if+DseWM9EOJS4Pn4c0Lq5ODsWWcCbOOfd6RGKPL6N4FLT8y2H
	 VB1Ld4mmUJoBqp7zDtsYnsCThsXtlusA5nvTOWW7PyOUSt3lbS+ApysjxGGFYnZmau
	 S6jS8yrg3B22HhD0QRLDV3GFYAYbhQJc5Dsx0DVCOZyGtb7aMbdbFZtdQwxvvqWOYZ
	 V86KYy1QA6Wm4PDAgoQ6onPOFsHPwLWWf7kYzaF4/zIG6/3AsaXS8ZhlViBjrwqC6K
	 m+map4A8YGL+N3xPtTYZMzLGNfq6eu+xP/xIBEoVXrsueM+iIrUSt6gTUitp/qd7YX
	 RdTzsmfeC/3EQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, andersson@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com, 
 quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, 
 quic_nitegupt@quicinc.com
In-Reply-To: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
References: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/4] Add Qualcomm SA8255p based firmware managed
 PCIe root complex
Message-Id: <175137773442.25265.15621888836513361848.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 19:18:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 16 Jun 2025 15:42:55 -0700, Mayank Rana wrote:
> Based on received feedback, this patch series adds support with existing
> Linux qcom-pcie.c driver to get PCIe host root complex functionality on
> Qualcomm SA8255P auto platform.
> 
> 1. Interface to allow requesting firmware to manage system resources and
> performing PCIe Link up (devicetree binding in terms of power domain and
> runtime PM APIs is used in driver)
> 
> [...]

Applied, thanks!

[1/4] PCI: dwc: Export dwc MSI controller related APIs
      (no commit info)
[2/4] PCI: host-generic: Rename and export gen_pci_init() to allow ECAM creation
      (no commit info)
[3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root complex
      commit: f1cf5ea8e91b4d66b3f9f89b09edf509cc9da077
[4/4] PCI: qcom: Add support for Qualcomm SA8255p based PCIe root complex
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


