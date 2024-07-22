Return-Path: <linux-pci+bounces-10598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C1938FAD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BAB1F21E1B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663916D306;
	Mon, 22 Jul 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVlMUY/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284B16A38B
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653912; cv=none; b=evrxqj5xu6NSuljiFKJHPTindCec6Kv6JeMcTpGNgacYfWOy2WiKG2n4mAxuJdgHwaZ1UtCCtrpqFgPfubEiW+7BivUetSfEuQldEmKAMtzUEOyUj6t5LLBoTsFdOU8bZvNvjVjg33z+mSWiyYJr7I2t+TQYX9BZgMN4fTUBVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653912; c=relaxed/simple;
	bh=Yl54IhhBl5KN5lxPnpBkpytGNX+6KNwM0QpeivEX8uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6sbA0I2eySbw++CQZJTtqWQNuHexEHggWGIvPiVa0OLtfFoI5gLVStf46XgzJbjxnB1tdm0Ee7vI561gAn86a0PLSNJ6ZMxxduQZ9oVMJUY/HE6+0kZlhiOu4mpE3C2aHqMv5syte2MQII/h8LxPtiTEFnFXUaB4ixHS5YL5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVlMUY/i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd69e44596so17771195ad.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721653911; x=1722258711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNLdaVhZLCULcVm0BuO6uOnDm8k9XTjZNc3bP/bzyl0=;
        b=IVlMUY/iSdXQ5RGX+Xj+5FLUNieock8eGfBhmxYKqYcB/ZV0NiNigS5g31bKUGpZn8
         H9D319kSJwFOB4Xc8XlpfVkeUSDhA/3PoogmjRV+tz91hfm0q+NskvDD56PcsHSZw1HS
         0eVghYClsYWFn4CwZVJ3xMKc32Fq8BvO9fhdtPCzGurd7NdUiOozVO36ltqUufgKJx7v
         NQZ7gpvgNmFUWoH+otCKtMdF0ra14s4Jr8pWMId1uedmyNuRjWEUBBhvNtaB5hdhQOwJ
         7+PBVyYj9az/gLxe4nXPBqXTvxNR3zJR5skVhMIPmVuJcFbw85+WsyPAEAlgpGooybcd
         Ja6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721653911; x=1722258711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNLdaVhZLCULcVm0BuO6uOnDm8k9XTjZNc3bP/bzyl0=;
        b=HavNaVq+lh2UxmokCsWszJQ6Z0WYLxE8bAd/IOSaqwNHW8+d6fUU/WlQZU+6m4Fn3d
         R88uZKFOUpNhXVzktW2tQWNsS8Ri1D6UQI4dFxK01kovtPjLYwJFS6wOv7vWtraLTTtM
         lkXGqatTy5pSu56v9nOINyj35k2Lr19Od2mk/hCbNuu4WfMO0cJrNbTdeB9kpfHretIT
         Eq517L7III9Ee8hzPm0R3MoWfP0nSx70nOjMFAcqofHrWq2x3jclhIUBOWSW32/r02hS
         oThqplgrSRre2FSkJXQ9lPlKRCKU3JlOeUqwwS00heLOc+vaIrIi/PjfFO5hIFSdvHxW
         SBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU40OsE8/b1Ht4QCk/Ekgu6Zs9C5Yi+kCZyNM6bBIYwEl3tHJf8zs55O7aUXBb21X1QsJokEmZaw5kcjdGu7xMl/e5okELTZcFF
X-Gm-Message-State: AOJu0YzQK2V12jNo+tZhFCxWL9CcoEUtHo/lHt7YjxfK7UEDPCnNHI70
	c8Cn2cRCV1BNrsb8h4Ba1DTRZLUKGlEYqYfq6k82xfT1b2WiU/CFSFeXTMUDbw==
X-Google-Smtp-Source: AGHT+IGkI1eeF3+ZjtqrWZ8QSMwy1g3He8uLa7RwxeT+z0eXBTnNP30Q7FcMNTGWn5a1pQb16PjBLg==
X-Received: by 2002:a17:902:680a:b0:1fc:4680:820d with SMTP id d9443c01a7336-1fd74d16bfamr100301405ad.9.1721653910688;
        Mon, 22 Jul 2024 06:11:50 -0700 (PDT)
Received: from localhost.localdomain ([120.60.138.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f486a3bsm53945765ad.284.2024.07.22.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 06:11:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom: Use OPP only if the platform supports it
Date: Mon, 22 Jul 2024 18:41:28 +0530
Message-Id: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale
performance"), OPP was used to control the interconnect and power domains
if the platform supported OPP. Also to maintain the backward compatibility
with platforms not supporting OPP but just ICC, the above mentioned commit
assumed that if ICC was not available on the platform, it would resort to
OPP.

Unfortunately, some old platforms don't support either ICC or OPP. So on
those platforms, resorting to OPP in the absence of ICC throws below errors
from OPP core during suspend and resume:

qcom-pcie 1c08000.pcie: dev_pm_opp_set_opp: device opp doesn't exist
qcom-pcie 1c08000.pcie: _find_key: OPP table not found (-19)

Also, it doesn't make sense to invoke the OPP APIs when OPP is not
supported by the platform at all. So let's use a flag to identify whether
OPP is supported by the platform or not and use it to control invoking the
OPP APIs.

Fixes: 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..6f953e32d990 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -261,6 +261,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool use_pm_opp;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1433,7 +1434,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
 				ret);
 		}
-	} else {
+	} else if (pcie->use_pm_opp) {
 		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
 		if (freq_mbps < 0)
 			return;
@@ -1592,6 +1593,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 				      max_freq);
 			goto err_pm_runtime_put;
 		}
+
+		pcie->use_pm_opp = true;
 	} else {
 		/* Skip ICC init if OPP is supported as it is handled by OPP */
 		ret = qcom_pcie_icc_init(pcie);
@@ -1683,7 +1686,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
 
-		if (!pcie->icc_mem)
+		if (pcie->use_pm_opp)
 			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
 	}
 	return ret;
-- 
2.25.1


