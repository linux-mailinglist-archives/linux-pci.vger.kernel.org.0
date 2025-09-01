Return-Path: <linux-pci+bounces-35271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F65B3E5C9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877081896430
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEEC33CE98;
	Mon,  1 Sep 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqchslqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C5335BDB;
	Mon,  1 Sep 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734158; cv=none; b=FfPPixYknNtt8NZgp49Zh8xcVhbYiTrMiFozdEOMbXb+KnYDozGTRyvuOUa01nF57o12Y+GUA7ng5v2TZKFSdGhK/i+8BomVFj5BBdk4nL0O9S4C3kUH8vZV3MQJI/uoRced/iEN+cYovH14A7V7sZdwCR1a4ew7AySgzfc26ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734158; c=relaxed/simple;
	bh=stSa6AbVOyKjdWayNfoBi8bf/zGdedt720iK82+UpbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TYimE423aXg9YznH+c52v48a8E0dlgKmY9IUOqnRmHIkz7Lb/jwuCZKgoKxLRLCB/XEc6Vr9tK92v12rvPBzz55h6JlU8cvn2hzxrzh9vl5W0ZBxsaYHfQgUfCqWK/eM1eDaJtzC8NQ/HtlnJD9iI/amho5yuy/If8g9y4UaNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqchslqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C2C4CEF0;
	Mon,  1 Sep 2025 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734157;
	bh=stSa6AbVOyKjdWayNfoBi8bf/zGdedt720iK82+UpbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bqchslqcFoOMQT0/h8q8vlwjU1ITL62660X9gRcekGYkdnHHOUX7rXHOeBUWREkQP
	 +hsuCjqHVDdf3P0wNbFIYYWUk89cd2OOj3eM9cuZL/Drhor5e/IW+KeZNG/1Lwp+9U
	 WrTVLMJaYOyv7CBKHuG38FkTHAU4yd1PoyD8MdTS12v8hyfov9zLbTSiQNrO3Okio0
	 wWLqiTIo7+MEkhEA+UDM49jqlO5EegjvADcJNc/LUxeq3rL5DidsdDNJlg2iBNZ2T8
	 ovz8GxLGPNAVtE3LKPSJwVpfsK+Ij5Xk/lGB7P1piGMbLKABN3NQQDoITRHkVEl9oY
	 nN2tsEuYn9akg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
 quic_vpernami@quicinc.com, mmareddy@quicinc.com, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU
 configuration
Message-Id: <175673415116.10403.13836370686011733892.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 19:12:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> [...]

Applied, thanks!

[2/5] PCI: dwc: Add support for ELBI resource mapping
      commit: d39e0103e38f9889271a77a837b6179b42d6730d
[3/5] PCI: dwc: qcom: Switch to dwc ELBI resource mapping
      commit: 6955a13b1349376a00ebca80d1a8e2960de3fb0f
[4/5] PCI: dwc: Add ECAM support with iATU configuration
      commit: 0c959f675ce0338f3bee2636437bce4d5713ea03
[5/5] PCI: qcom: Add support for ECAM feature
      commit: 0bba488d552dccda4b803fa4b5d4d5d3029d601d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


