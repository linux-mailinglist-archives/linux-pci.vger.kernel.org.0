Return-Path: <linux-pci+bounces-17671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40BE9E420D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC8C16842F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321F1F494C;
	Wed,  4 Dec 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpCym4cO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B81F4947;
	Wed,  4 Dec 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332330; cv=none; b=NX4OK0bQRQfObsnoF++ZRz+HruDX4wHvVs4MutDBS44mB4nejG/B4AAAvq+nykS6zgtWoS4C/bmvLCcphRaEa+SX0noT6uXnHh6h1oLRRZkhtLPSpUlgnzbqYONZ4tKsIbPX+PiL0F6XHKXq6T/cPoIPSVWRwRsn3KzZgFfTRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332330; c=relaxed/simple;
	bh=z0BA4xGG5DLCB8Mgq9SQflCwkM33QXWAGI+BP0ooRlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6617SUZLDC9/2llxw3kldixB7qdhqxAycMGnQvlKXO67Gm9+lrfRPVmpGg+teCBCI7268gzEqGnJ1mNaPZ7EVGkWkKTpDYvADkEJUaKohNhcKLv6g1AvE3JMNO1ntGj6ayEjMG53O9Zuoiq2yxtqf2qOyNRjkuKllkMu3bkiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpCym4cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F9FC4CED6;
	Wed,  4 Dec 2024 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332330;
	bh=z0BA4xGG5DLCB8Mgq9SQflCwkM33QXWAGI+BP0ooRlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpCym4cOIt2Oe85oIYCU8RJuaNBjhfLbFEtvHyTJ2AjiYjTq8OahJqHLN2bb3lArN
	 AX3hYjOm29KIvpsLWeLzMjxPwv8EZHwsaSSDilxGIKnN+H+itxank+cys8lsMP8o2c
	 xFVXksUPIsZ9PFfBwFruK4cqjjwOysaPksSmvBKyecmVilu3zJ/Md/OKsIx0khj3Mt
	 8v+JKItUGkEroRLn/dSRMwAEcUper0zihZ0OEFOM/4QYCc1s4njGOzMqPIR+4kQMwH
	 BzL2b0vZQla+KAFrbodMylwcR20E9IDN1D5q2EgU2Qf6PyEaSF48KI0pxYccbQm6ag
	 r2Wk69Xiefdbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: devi priya <quic_devipriy@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/13] PCI: qcom: Add support for IPQ9574
Date: Wed,  4 Dec 2024 11:00:29 -0500
Message-ID: <20241204160044.2216380-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: devi priya <quic_devipriy@quicinc.com>

[ Upstream commit a63b74f2e35be3829f256922037ae5cee6bb844a ]

Add the new IPQ9574 platform which is based on the Qcom IP rev. 1.27.0
and Synopsys IP rev. 5.80a.

The platform itself has four PCIe Gen3 controllers: two single-lane and
two dual-lane, all are based on Synopsys IP rev. 5.70a. As such, reuse
all the members of 'ops_2_9_0'.

Link: https://lore.kernel.org/r/20240801054803.3015572-5-quic_srichara@quicinc.com
Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0b3020c7a50a4..ee8b08f6a641a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1769,6 +1769,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.43.0


