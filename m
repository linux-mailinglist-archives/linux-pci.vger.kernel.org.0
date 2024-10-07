Return-Path: <linux-pci+bounces-13932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF66F9923CF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 07:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EA11F228B6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ABA136358;
	Mon,  7 Oct 2024 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+iptQHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED542AA4
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277996; cv=none; b=IvcNk9CrzQnOLnt9LrtiMwrR7YGAGOV06DBFpkYp1Vc1T1yHs49LzH2dlui9hOmgULipJ5YbLOM/9umCAXQxx+5garRZMsMLoXuV44wFHDoiEyRgI/F60Y+e3GFtySVw6sMx8lVDCwZjB0sXTvXdHyyH/Dvd7Gk8tS3z/EV6N+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277996; c=relaxed/simple;
	bh=Xl7npExBXXB/m29YQcRR5cFMvxfN8fXQJgX1ModzhYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gr4sIkXWeQlEyaqeOpBJURSpkVRXLkdKcv35l+npAX9+s8GSFvp4oCEErLMGFzoRNYLzOudwaLY22UPtZtT8kqMWn0gvvY8Vp8Zw8/Bvd5YbyNn2W3LMcJGQTzA+51Kh22AwEo5bU8rv9B5XTFrOBA6RbQtUqAVrDU6QikZJBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+iptQHF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b0b5cdb57so36735375ad.1
        for <linux-pci@vger.kernel.org>; Sun, 06 Oct 2024 22:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728277994; x=1728882794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jslguiZl6FGAJBiDxlsSwtiDEosNNmbWrk82rYwT2c=;
        b=H+iptQHFy13tYDdidpEyxRy+Zj+rRTj2uE9xeR9K5tcumR0vMrpmAWqhyxsIYbD4Mc
         PR8xgOPlcr76g6AF98DVR6iHqf6KruG1Hz5WH1KlacIZOwDhdY9F94qXI0UYtwbirOnI
         CfQ4yP6goWa3cC4yX0kj/TtpbbA9O25kEljjBC62WTvzFNZqWrqatpGMtxnE8LmaxK8S
         /qnhhlzyAShMr4MeE1BbsoaNueiiKLpCM6mWkkWityfQmYPFAgvupZ6QcSNF3/S2C79a
         eQ/mHrRYEaBuo1HcxXMqDruOJhZi3x/a+CHm2uHQ2ZU8bpiSL7Wg5/m61UhOt0SMv5Hp
         J54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728277994; x=1728882794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jslguiZl6FGAJBiDxlsSwtiDEosNNmbWrk82rYwT2c=;
        b=IW5x0i8cSWnXmvYqQLmUgOqMeQ02pM9zlNSW2cabg3ce3s+fXPnq1kViUgCe56m3j/
         4X+9nVpNnjbOaF9FP9/qrQm5z7dTtxM5JwAc9C1VbB3WAyNdps7baO+emjX21c7Mj0MU
         DqADkxVxB3wXIaB6BY6Jpu+pI7eLvjoOmy6ywcEGKdJuVxZA8wpZb9gK74PfwFrrAEPs
         jVYMy1H7fT7LM0XUG/ms30EIAk5RyOEmY8Pn+z7qlYlgrhA0lqglGH2CjfCm4HmGgHqd
         AGdmFyAwMc7ZPpfK9zh/2Zv8mVFaoLSTZIi2JRcbP3NEtRj42obhvVL5rdfhzO+IE4EP
         ofzA==
X-Forwarded-Encrypted: i=1; AJvYcCX28feKElmnQBmgcJx63GzsuSu8q3w/krgCJ5rELJm+GZfZsydWP6TT547UGDaPuofiX/V0UyD8FWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7n/nVeZzY2G0K1XZhU95PSaRl8zPuJjeWySzEQnl9N9Df2nx
	d/ILfZTlm30cffGFSSMGSHvUKDMI9r7ohbBm2f2WjWB0ZR006pAZ3TGQi00qDA==
X-Google-Smtp-Source: AGHT+IHAx9gVDA+7k4KjSFKdMpF9NHRdObEoyyAYXc7/CdU+GE9B2kUhrT0lx83zu20SnP8Zs8x+xA==
X-Received: by 2002:a17:902:dad0:b0:207:6d2:1aa5 with SMTP id d9443c01a7336-20bff49bc78mr146295585ad.13.1728277994500;
        Sun, 06 Oct 2024 22:13:14 -0700 (PDT)
Received: from localhost.localdomain ([220.158.156.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139353e8sm32173535ad.164.2024.10.06.22.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:13:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_qianyu@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2] PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported
Date: Mon,  7 Oct 2024 10:42:55 +0530
Message-Id: <20241007051255.4378-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if 'Global IRQ' is supported by the platform, only the Link up
interrupt is enabled in the PARF_INT_ALL_MASK register. This masks MSIs
on some platforms. The MSI bits in PARF_INT_ALL_MASK register are enabled
by default in the hardware, but commit 4581403f6792 ("PCI: qcom: Enumerate
endpoints based on Link up event in 'global_irq' interrupt") disabled them
and enabled only the Link up interrupt. While MSI continued to work on the
SM8450 platform that was used to test the offending commit, on other
platforms like SM8250, X1E80100, MSIs are getting masked. And they require
enabling the MSI interrupt bits in the register to unmask (enable) the
MSIs.

Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
described as 'diagnostic' interrupts in the internal documentation,
disabling them masks MSI on these platforms. Due to this, MSIs were not
reported to be received these platforms while supporting 'Global IRQ'.

So enable the MSI interrupts along with the Link up interrupt in the
PARF_INT_ALL_MASK register if 'Global IRQ' is supported. This ensures that
the MSIs continue to work and also the driver is able to catch the Link
up interrupt for enumerating endpoint devices.

Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SL7
Reviewed-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Reworded the commit message
* Collected tags

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..2b33d03ed054 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -133,6 +133,7 @@
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_UP			BIT(13)
+#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
 
 /* PARF_NO_SNOOP_OVERIDE register fields */
 #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
@@ -1716,7 +1717,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_host_deinit;
 		}
 
-		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
+		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
+			       pcie->parf + PARF_INT_ALL_MASK);
 	}
 
 	qcom_pcie_icc_opp_update(pcie);
-- 
2.25.1


