Return-Path: <linux-pci+bounces-18096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B7D9EC652
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D8A282478
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC21D61B9;
	Wed, 11 Dec 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okXBaSB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF11D54E9
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904100; cv=none; b=hBjtDoaLPNUUB4ImS5zErBWLtXlum5S1sP8kNYhCIUA8iz0nVikIzVxr1zJNFjwFpEk8B82PT8tPNJonodEH5j7BRSkCJ4wzHNkznpiWjlwwprc5V2C7lhXXeiVrrh0q2OtadDnPHb8FrVQUsjc/mO5VcNYo0cMtimKCQgm5fyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904100; c=relaxed/simple;
	bh=ipm6qELbYTfXg2hQT0IFc0rvkpX/x/nt8LPfq0mYElQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmFv3I4s/7T0b0nZf9mZ91M+mBa6OrYXHpGpo7L9WhzK70seyrxF8HPpJ3cLC+nz4RJwRQQW83PQyQNzdknPhjsBzVMa1Ak3iG2bjuaVKYjq/UyNgAwI+CTeTD7wS7kKdt8yZsRIvmvUh0bn+dvX4FZqfAyJOF45Cyh4OVckY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okXBaSB5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso3217177a12.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904098; x=1734508898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q76q7eUTECAS81ZcaHstGwKhBK0vE68IjtIJyIAI+k=;
        b=okXBaSB5VRecPpORrr27JIy1sTCPUUNRV0odBObWz3Ht+9bFLY0YnmeDsV714Ckbz7
         MwyIt5DZcD9ddsMexFwlu8czwz9oj/gA/F67OkHkP+5vFtJAJnTCXA2uXqmDcCwKK5f3
         iZPsg6/rhyj36hHZiAzMaVQrup5CS9S5M5T/IzznGbrwDlYzmhyRcnH3a1bGKB5VZKRf
         Y9UvNyynuAbfv9AUWpHI/LgTnIMYWzhB+ttKGHhqX2YEd9HMbA/ZdVQI0wKNmrTHTw+v
         jv5YP/tRNiUJos05+QetafOXatKXGQLH1BCLEtA8wA65h/yxf4BOJeOhVJLObDf3HXek
         xUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904098; x=1734508898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q76q7eUTECAS81ZcaHstGwKhBK0vE68IjtIJyIAI+k=;
        b=izjIW+1ZpY0cUc8xbOWMcdpHyvbIKnLOYDhoE/612y2qf9ViFeX+6EK20mFYnQyvIT
         ndzsU/4KL13EDvWNOeQ17K2Y18o6NzsyVsx3iVGx+NhEJp0MYv2N3ulXEhrGfKgdD+6I
         sRN0P7iKGXsKgHbqdEJVYeVjP5CV1A6hcnjQfPrg20Rnc/ldxVzMqRClztk/tv1WBuS5
         iTegCpM20RCVCKTnw2FfvwgZx697dvZPrKBQSdqXcHW/Me4AAUiZJF1yy27MnUJCQEBw
         zg01PMTxpwQObzNvCgQAXs8b2z6HVzr7p5hRdmymeg90jaK8b1GpfFni8x8553cFEWEY
         QyVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5qBp/3XalB8Ye+X1MSXis0QFxsnAP4kq/dxufj6o6qRHKWfGkyEhMZgwPW8Ca4cJVk1PD3ZdFpQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2elm3t4nf295tfMgRzUhBKXQJbXp4xX2Tisyavo5/3JHzDSl4
	1cbV/fkxgFv8I2TmZdVhqmza7divTgtBjUYf+lA5TCO+nD4HTruhbVaXT1qf7w==
X-Gm-Gg: ASbGncvKUS2p5tmEneQA7p4xp/5GyOXk63WLq0O2a38EHJG46S898oh09zkFvooQrMF
	mrW305u9S+teAGRh/CA7aU2F6n7u8oyeaZC4SfOseGoU60WgeF2k2Qrxq3Ki3hlCCbzZF8s0kmS
	QTQ9UHHCDW3hlvrsdvTaewfStbu5dM1EaWjdatbKDfN0lyFpHtQ5HFIofddzOa2RJnlrDQf2Q/T
	q84ks52Qyhm8AFr/AgkTghUd7x6UMeNX67+e6EWbaIqRJU4glG+q+wSwoPtDy9K7FGqNHrZcdai
	d1qN
X-Google-Smtp-Source: AGHT+IG99qcIr9GvfITm98ryc2AXYkrV8pH6ZRMpAt1heLeVZuLUM1sds1scrjNv6/IS5BWcXLa9WQ==
X-Received: by 2002:a17:90b:224b:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f127f50a32mr3250201a91.6.1733904097941;
        Wed, 11 Dec 2024 00:01:37 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:37 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable+noautosel@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
Date: Wed, 11 Dec 2024 13:31:02 +0530
Message-Id: <20241211080105.11104-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
cannot change the type. So mark the those BARs as 64bit BARs and also mark
the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
use them.

Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e588fcc54589..f925c4ad4294 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .only_64bit = true, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
-- 
2.25.1


