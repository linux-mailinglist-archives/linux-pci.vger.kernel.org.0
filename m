Return-Path: <linux-pci+bounces-17678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B39E4401
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 20:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF963BC2FEC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD7207670;
	Wed,  4 Dec 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0OrDanE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE020765C;
	Wed,  4 Dec 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332361; cv=none; b=GNbdkmtc7GYQOVsG6i8Wzh3+HzAoCoD12g4GHrtgTe70MzJ6wi6MkK6RAAsM40mqZ9Kx6M35gcvTM3IK7qSke/ORCTsWlm93LsSRGZ4yiSJdwHxI4pWOKSv1KnXXWM6RJdKMDvg85bA/MjOcegNKk1yUX9VYhpa4RerZksBmADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332361; c=relaxed/simple;
	bh=G0vd4FDjx3uLl/Z+msCeyMHX4sbiyxk8MJ1jBLPFtkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9KU82zE39Nry4Nub6A/IxVZN/WAkEIlgSoxhrvCP4B+PSuvMNOTgZE2nVjwL7Q5FqeFKHROjEhMHWwjxvwmYtBkP2VE3XZYfneBgin6istnzi4QBJ0Qugsebd1GORZQcL7Edy4KoE9ZgU91xBksbnGyiDOAH4B7NcAnWWpv70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0OrDanE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B9C4CED1;
	Wed,  4 Dec 2024 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332361;
	bh=G0vd4FDjx3uLl/Z+msCeyMHX4sbiyxk8MJ1jBLPFtkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0OrDanEyg0vGqmALVxhicz+GLD2upC7qQcNNqLoto0/FdqUpBOd0XRNUgbsvKSBi
	 MG0zp6sDpxbUeQHuFMeJ1BqHR+XsGYDZQMqmqMBQqNiAcUz2GzdYlRbuy4vdBVIYMb
	 QTF89hY7d6O9+Meb9JWOOSaDqqRMjGdPYtM4gpHit1Jzsl9q9c9NlEd1NdPO1M/+j8
	 InHGVAOSO4Trm3Dpb3Mj2yOC1bWYJ4x/jfHqyNJsYIA9iFwTy/xZYiCeDFfefGt48x
	 cOpZPtanu1LAD+1kPWTRVCBM0HnupGD10ze93ZziraNayXT6AxGJAR+/NzI3tqb+xV
	 8UNQP7u7swoOA==
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
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/12] PCI: qcom: Add support for IPQ9574
Date: Wed,  4 Dec 2024 11:01:01 -0500
Message-ID: <20241204160115.2216718-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index d3ca6d3493130..2427237cbe9c7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1618,6 +1618,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-- 
2.43.0


