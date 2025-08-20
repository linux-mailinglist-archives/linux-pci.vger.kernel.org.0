Return-Path: <linux-pci+bounces-34395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25193B2E2CA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03A0188BD87
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CF2EE5FB;
	Wed, 20 Aug 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG5wBt6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B513777E;
	Wed, 20 Aug 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709340; cv=none; b=Z2bFeRqkMzPHhpp7iFjRd4r4ZNuMBZVwGKjaGVaBHHNRLPnmqPfTNwjjuk2gNvY5wkfYid1+QTIBMQe1XNW4RBxf0TQYj8E4y9ctf9KHMDGgMCV1m/z3QXA6V+3Cfr/iWfl72Dicisfj+Y9nTxq8zdotOzkSM2+Rw4ln3/BPBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709340; c=relaxed/simple;
	bh=tNTj9tNEMOWtDcM1RzN6AMMbLh3U5S0eKicHECZ6bHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b2MHN3gX5pVqIfP5Nh1XZVlDpHZW06g6pNOnucKf/mFMD7RagT7Qa/4702Zk+6xqv3NpAw6l/dMM3zDR11lTzQ7G3w2HdlYJBWObDEXjisB7XvsMzccC//+ZaCX+5veUthDJ1uEjpH90vCWMu/PwJtW7UUBsJ8YG706sQlxRSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG5wBt6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784D1C4CEE7;
	Wed, 20 Aug 2025 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709340;
	bh=tNTj9tNEMOWtDcM1RzN6AMMbLh3U5S0eKicHECZ6bHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vG5wBt6EGRHnth+pzXz7cuVql9/xvF5h6qKMLT0c39Yyss10licpn2FXtasr1r55w
	 nv39rhwK3Bg8R4YFYLUN42ZkBup894xfHZDUY0qNRIrlVhBoMkS9aZmRrkc8vjuIbr
	 KPC3jv5wh+WQpJsXLxIRXH67MDcqDX26vbb2bNxEbRyJDPtxHwafTRDpe+bhWvMZt6
	 LrG0xzZz93sFtkMQNzbeC/xWSUGXAWzzoXc+IYS16SCj0YCUP9SPqJNYWPoJEoz+m/
	 KO4tHwqw4eJcW+zuZiXIU8yRuScDw6av5MU4vJwJ/zwItT1lyIMXR1MA/st9nklMiF
	 QzwbMZtg2P+Gg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
 quic_mrana@quicinc.com
In-Reply-To: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/4] arm64: dts: qcom: Add PCIe Support for
 sm8750
Message-Id: <175570933399.66459.8492859060215712340.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 22:32:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 09 Aug 2025 15:29:15 +0530, Krishna Chaitanya Chundru wrote:
> Describe PCIe controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe.
> 
> 

Applied, thanks!

[1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the SM8750 QMP PCIe PHY Gen3 x2
      commit: edafd4f3fd52a614c5cee2684559367eac2286dc
[2/4] phy: qcom-qmp-pcie: add dual lane PHY support for SM8750
      commit: 0f051749c804b5a4f485013c0e3c932e1dd9f70b

Best regards,
-- 
~Vinod



