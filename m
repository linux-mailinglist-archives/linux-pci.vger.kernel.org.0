Return-Path: <linux-pci+bounces-17664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97EE9E41E7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A9284CBB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A82204A17;
	Wed,  4 Dec 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2xh04T1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2B204A13;
	Wed,  4 Dec 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332297; cv=none; b=j2tNd4BZrMINbRTTM17AM0+j/Ej/5w9mYGa3nOsBVs+7ApikEi1Ls1k90YkkLq9d7yBD7isfNl+P+hO/Pjnyk4Ij5CVx5fYKWvOyMWEQIvHYRgOKGDLqoYXiz0xB/83rN5pAenL3uTsz+bsJBvjve6f0/qEKnjC0IIAoY2Hafj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332297; c=relaxed/simple;
	bh=cjhyV+/fM90COjAxJQgpYB2Tqy1Q8XVFd/TkxArK4KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrgNbz8PWsHEwTwq+1ukbn21LbHm/Yy9dROEIfZiEFi6YsFilFYvQEMc6DYnYZLMaWXXzAGsEz9JV9E6eGtmh0MB1XvwyLSLSbcQ38NcKgbZPI9i3PcHki52efy54F26cusuH2gWSJ8Ff0NX3ufmzg7o0yeryZhHK/h3l1SYsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2xh04T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459ADC4CED6;
	Wed,  4 Dec 2024 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332296;
	bh=cjhyV+/fM90COjAxJQgpYB2Tqy1Q8XVFd/TkxArK4KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2xh04T1l4wo26Qh0nNxqb6YLbuCMm+iZbzJK596jf6Mfz+fk+1lXn7KES1t/PZk0
	 7pH05gx13Z6MvaLtBye0pbeVUpPqSzKeccAnwCm2hZyNEfKt9Fz1OMYh7DBhVgfPJt
	 VDcVQAup3jE4Pgdb+fFxoZk6FUmKFLtGI+VNpXvw2s1o/oc9Dz27YrVlvS/ve7zxIy
	 /8JHFRwSHnEJUti09jdnOBAYGSWIJre6sOlqboduERC+bz5MdliW21SDffKFbghTin
	 5YKrzTTQ8IolqL8UbBl+r34A1eGaML9+GnVWzZDVNwJoR9X1/yRNBxABYvmTVw9osI
	 0LPRJcrN0FRpA==
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
Subject: [PATCH AUTOSEL 6.12 04/15] PCI: qcom: Add support for IPQ9574
Date: Wed,  4 Dec 2024 10:59:52 -0500
Message-ID: <20241204160010.2216008-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index ef44a82be058b..40e0577738650 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1828,6 +1828,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.43.0


