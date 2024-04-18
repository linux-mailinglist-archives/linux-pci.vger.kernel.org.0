Return-Path: <linux-pci+bounces-6416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F078E8A993C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F531F21B7B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862015FA73;
	Thu, 18 Apr 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaFG+JS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532F15F41B
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441535; cv=none; b=k4qt+nJNyp2LeyIw+cNHQbkFs7BNSiyamyS76s/dw37/nlLX1t3BRodm+ixUuaA0qWhkjdxzLwdUXf23Q0Ih6UGXiU1tE7AJ1A5SBx66ThNCwrUEV7YvoNydB+sakUORkaj+8IoPnMLeYCZBqri6au9GPzxhJPQ8f0hN1oJMtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441535; c=relaxed/simple;
	bh=rwb0ErsAMOJOBGTVMRpx900gyCjG88g972dlNjto2GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGgJpHUp3p+8isg/QqLWGoHI/XmInONH3vV99BhrmxS8spaU4SPEKBVeaq2uZp0p5R7mjLYHn4Bqz3xvzha6uPX2cnXtUFHyxwCsP7p3BjPy9cNo40K1OpkVQWZVpiMZkm0ETkpW8WANpNsv63uW4vTfB+R79HLuElIFzdz5Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaFG+JS+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so818474b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441533; x=1714046333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrN5HMtM25sMebZ7OPzRb4bH/7+xLTv/ToBzj1D+nVM=;
        b=xaFG+JS+KxCBZq+MsH/QYDsGN8I5mzF3n/QK+K9CrM2rVljfapgk6Ml7GewxqSX8Bz
         +vbLdev4Bl0Bn1tLYsjAB20vgTM2wfjyQmqO9n/cz1EvLs9ebtsXaDsMj1p2/pplbbIT
         c/s+vBWNGYROin8M27ufh1dUxhrScYlSusxkpeToJdY007m2LOx3L4/YUEWYy4I/LK27
         dL32ON80BUpYj/eUateeeiXZtSG+jtYO+fBuGUJFy254dr4D0Wbb8YXX68J5qKB0+aMF
         Liiqc7Rk/eFP06Wv8+N0KaXsb/qVWxghZamFUslY14O/yNKohouag3OAaRLqKHNRf2B+
         HaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441533; x=1714046333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrN5HMtM25sMebZ7OPzRb4bH/7+xLTv/ToBzj1D+nVM=;
        b=SHHgtD9kD5d0KQOReANDz4tUwbOaPn7t8UUJz3XQIr9Kyl2D3lgcYuded3KT03kIiM
         yUBqTdyVQFUdxYMT3Q8t4IY64DVWvoQxy2mFiXJjiFjP87O4H3NZAknjpI5BFGJoZSyu
         jiaRu7cHKizYjwdUjKIY7FeN+Ey3xD7vYdRqSh7ARM61CBxtC/F7zp2NxoXlr/S65RmH
         JYVrIqwqQB6MMBYFDDlJETXPZ0oqY5Kp3GMPY20OMfMpVWpy6qT2RNI3IyqfptV4dNND
         IYVySyioIDrNfqPT1RIUAuN/i9aZYiLk160GDzsFcklZzFW+xympG+EOcmoZnJBKVSHN
         f5qA==
X-Gm-Message-State: AOJu0Yxyv4AHPQF5FpKqsDdpLM/iaC+qEqVVZHUjnYdKhf5cjUQPVony
	S+quBANgCrTv1NVVGG01L4FbwcT6hh/kepr6xcT/6Mi4x9PowOKqCxwsCyTT7w==
X-Google-Smtp-Source: AGHT+IG9kXTcBipP2Gwv++j5yx6bfXSo/45ZBOKxw8RMkTQGkrpXHP9dpUWBB5CmHlQYwwIKACpZFA==
X-Received: by 2002:a05:6a00:3a0c:b0:6ed:d164:3433 with SMTP id fj12-20020a056a003a0c00b006edd1643433mr3235807pfb.14.1713441532862;
        Thu, 18 Apr 2024 04:58:52 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:58:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:29 +0530
Subject: [PATCH v3 1/9] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-1-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=rwb0ErsAMOJOBGTVMRpx900gyCjG88g972dlNjto2GQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrywUQZ4EOU/A+AC0lu/3GJstzSzgnsSMRIw
 Cbdqkkl+06JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8gAKCRBVnxHm/pHO
 9R1ZB/wI02PPJ6D+du4yCtEE5xK/RY1PWa2AMXi1v6kvovHwcBAVjhYoA1HNqqGEMdTXRVHZvOj
 3o2Bz3iTvgGW9hdlSIiFgNpqIUYmUSe/Yd66nOZGAR94uY1ryVf/3auhJr7rnq5JdxpTWYqM0qP
 gHmtmy03clIVQUUrYHqFDWKeYzlIILcLJVN0Un5g58JqvTBEWZQmAJv6KBI4kJx1B0fIwBxZ+V0
 +sgykVYYMz4MgwZjEolHARgZC/6j5YEvDBxBhkK7xMnoNszpyEIP8D+Aw9l/2QzEIpKV9cHBZlf
 Ig9p71iFc6buSGb/ijEaNCW94m+ONZJUrxFFYi8gTK4eM6pE
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

All EP specific resources are enabled during PERST# deassert. As a counter
operation, all resources should be disabled during PERST# assert. There is
no point in skipping that if the link was not enabled.

This will also result in enablement of the resources twice if PERST# got
deasserted again. So remove the check from qcom_pcie_perst_assert() and
disable all the resources unconditionally.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..50b1635e3cbb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-
-	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
-		dev_dbg(dev, "Link is already disabled\n");
-		return;
-	}
 
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);

-- 
2.25.1


